{*******************************************************}
{                                                       }
{ Borland Delphi Visual Component Library               }
{                SOAP Support                           }
{                                                       }
{ Copyright (c) 2001 Borland Software Corporation       }
{                                                       }
{*******************************************************}
unit WebBrokerSOAP;

interface

uses Classes, HTTPApp, AutoDisp, Masks, WebNode, SOAPHTTPDisp, SOAPAttachIntf;

type


  { Webbroker component that dispatches soap requests }
  THTTPSoapDispatcher = class(THTTPSoapDispatchNode, IWebDispatch)
  private
    FWebDispatch: TWebDispatch;
    procedure SetWebDispatch(const Value: TWebDispatch);
	protected
    function DispatchEnabled: Boolean;
    function DispatchMask: TMask;
    function DispatchMethodType: TMethodType;
    function DispatchRequest(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property WebDispatch: TWebDispatch read FWebDispatch write SetWebDispatch;
  end;

function GetSOAPWebModule: TWebModule;

{$EXTERNALSYM SOAPWebModule}
threadvar
  SOAPWebModule:  TWebModule;

implementation

uses SysUtils, InvokeRegistry, SOAPConst, SOAPPasInv, OPConvert, SOAPAttach,
     OPToSOAPDomConv, WSDLIntf;

function GetSOAPWebModule: TWebModule;
begin
  Result := SOAPWebModule;
end;

{ THTTPSoapDispatcher }
constructor THTTPSoapDispatcher.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FWebDispatch := TWebDispatch.Create(Self);
  FWebDispatch.PathInfo := 'soap*';     { do not localize }
end;

destructor THTTPSoapDispatcher.Destroy;
begin
  FWebDispatch.Free;
  inherited Destroy;
end;

procedure THTTPSoapDispatcher.SetWebDispatch(const Value: TWebDispatch);
begin
 FWebDispatch.Assign(Value);
end;

function THTTPSoapDispatcher.DispatchEnabled: Boolean;
begin
  { Here we could check whether the 'Dispatcher' is set -
    See 105167 }
  Result := True;
end;

function THTTPSoapDispatcher.DispatchMask: TMask;
begin
  Result := FWebDispatch.Mask;
end;

function THTTPSoapDispatcher.DispatchMethodType: TMethodType;
begin
  Result := FWebDispatch.MethodType;
end;

{ DO NOT LOCALIZE }
const DefException =
    SSoapXMLHeader +
    ' <SOAP-ENV:Envelope' + ' ' +
    'xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >' +
    '<SOAP-ENV:Body> ' +
    '<SOAP-ENV:Fault> ' +
    '<faultcode>SOAP-ENV:Server</faultcode>' +
    '<faultstring>%s</faultstring>' +
    '</SOAP-ENV:Fault>' +
    '</SOAP-ENV:Body>' +
    '</SOAP-ENV:Envelope>';

{ DO NOT LOCALIZE }
const DefExceptionMIME  =
    '--' + SBorlandMimeBoundary       + EOL +
    'Content-Type: text/xml'          + EOL +
    'Content-ID: <'+ SBorlandSoapStart+ '>'     + EOL +
    'Content-Location: ' + SBorlandSoapStart    + EOL +
    'Content-Length: %d'              + EOL + { Here goes the XML Fault packet length }
    ''                                + EOL +
    '%s'                              + EOL + { Here goes the XML fault packet }
    ''                                + EOL +
    '--' + SBorlandMimeBoundary;

function THTTPSoapDispatcher.DispatchRequest(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse): Boolean;
var
  Path, SoapAction: WideString;
  XMLStream, RStream: TMemoryStream;
  AConvert: IAdapterConverter;
  ConvertOptions: TSOAPConvertOptions;
  Converter: TOPToSOAPDomConvert;
  IsMultiPart: Boolean;
  MimeStream: IMimeAttachmentHandler;
  ReqStream: TWebRequestStream;
  BindingTypeIn, BindingTypeOut: TWebServiceBindingType;
  ExceptEnv: string;

  function IsMultiPartForm(ContentType: string): Boolean;
  begin
    Result := AnsiCompareStr(Copy(ContentType, 1, 17),
                                Copy(ContentHeaderMime, 1, 17)) = 0;
  end;

  function BuildMimeResponseStream(RStream: TStream; Attachments: TSoapDataList): TStream;
  begin
    MimeStream.CreateMimeStream(RStream, Attachments);
    try
      if (soUTF8InHeader in ConvertOptions) then
        MimeStream.AddSoapHeader(SContentType + ': ' + ContentTypeUTF8)
      else
        MimeStream.AddSoapHeader(SContentType + ': ' + ContentTypeNoUTF8);
    finally
      MimeStream.FinalizeStream;
    end;
    { NOTE: The stream returned will be owned by TWebResponse that will
            take ownership of the stream - So we release the stream's
            ownership }
    Result := MimeStream.GetMIMEStream(True);
  end;

  procedure SetMIMEResponse(Size: Integer);
  begin
    Response.ContentType := GetBorlandMimeContentType;
    Response.ContentVersion := MimeVersion;
    Response.ContentLength := size;
  end;


begin
  Result := True;
  ConvertOptions := [];
  { We'll assume that we're returning XML data, unless Dispatch returns otherwise }
  BindingTypeOut := btSOAP;
  try
    if Owner is TWebModule then
      SOAPWebModule := TWebModule(Owner);
    try
      try
        { Make sure we have a dispatcher }
        if not Assigned(FSoapDispatcher) and not ((csDesigning in ComponentState) or (csLoading in ComponentState)) then
          raise Exception.Create(SNoDispatcher);
        if Supports(FSoapDispatcher, IAdapterConverter, AConvert) then
        begin
          ConvertOptions := AConvert.GetDomConverter.Options;
          Converter := AConvert.GetDomConverter;
          IsMultiPart := IsMultiPartForm(Request.ContentType);
        end else
        begin
          IsMultiPart := False;
          Converter := Nil;
        end;
        { Get SOAPAction header sent over }
        SoapAction := Request.GetFieldByName(SHTTPSoapAction);
        { CGI/Apache remap headers with 'HTTP_' prefix }
        if SoapAction = '' then
          SoapAction := Request.GetFieldByName('HTTP_' + UpperCase(SHTTPSoapAction)); { do not localize }
        { Get the path to which client posted - SOAPAction may not tell us
          which porttype to dispatch to; we'll then use the path }
        Path := Request.PathInfo;
        XMLStream := TMemoryStream.Create;
        try
          { Wrap request around a stream }
          ReqStream := TWebRequestStream.Create(Request);
          try
            MimeStream := GetMimeAttachmentHandler(Request.ContentType);
            try
              { If packet is multipart, extract SOAP Envelope and cache
                any other MIMEParts to files }
              if IsMultiPart then
              begin
                BindingTypeIn := btMIME;
                MimeStream.ProcessMultiPartForm(ReqStream, XMLStream,
                         Request.ContentType, Nil,
                         Converter.Attachments, Converter.TempDir);
              end else
              begin
                { Load the SOAP Envelope directly into the XMLStream }
                BindingTypeIn := btSOAP;
                XMLStream.CopyFrom(ReqStream, 0);
              end;

              XMLStream.Position := 0;
              RStream := TMemoryStream.Create;
              try
                FSoapDispatcher.DispatchSOAP(Path, SoapAction, XMLStream, RStream, BindingTypeIn);

                { Now that dispatching was successful, we update the outgoing BindingType }
                BindingTypeOut := BindingTypeIn;

                RStream.Position := 0;
                { If the this Service is returning MultiPart data, here we put the SOAP Envelope into
                  a MultiPart message along with any attachments being sent back }
                if BindingTypeOut = btMIME then
                begin
                  try
                    { NOTE: Here Response takes ownership of the MIME Stream and the
                            Stream will be freed after it's sent }
                    Response.ContentStream := BuildMimeResponseStream(RStream, Converter.Attachments);
                  finally
                    Converter.Attachments.Clear;
                  end;
                  SetMIMEResponse(Response.ContentStream.Size);
                end else
                begin
                  if (soUTF8InHeader in ConvertOptions) then
                    Response.ContentType := ContentTypeUTF8
                  else
                    Response.ContentType := ContentTypeNoUTF8;
                  Response.ContentStream := RStream;
                  { NOTE: Here Response take ownership of the XML Stream and the
                          Stream will be freed after it's sent.
                          So we nil the stream }
                  RStream := nil;
                end;

                { Here we send back the response to the client }
                { Response.SendResponse; }
                Result := True;
              finally
                RStream.Free;
              end;
            finally
              MimeStream := nil;
            end;
          finally
            ReqStream.Free;
          end;
        finally
          XMLStream.Free;
        end;
      except
        on E: Exception do
        begin
          { Default to 500, as required by spec. }
          Response.StatusCode := 500;
          { We may, however, return 200 instead }
          if (soReturnSuccessForFault in ConvertOptions) then
            Response.StatusCode := 200;

          { Here we format a SOAP Fault packet }
          if BindingTypeOut = btMIME then
          begin
            ExceptEnv := UTF8Encode(Format(DefException, [E.Message]));
            ExceptEnv := Format(DefExceptionMIME, [Length(ExceptEnv), ExceptEnv]);
            SetMIMEResponse(Length(ExceptEnv));
          end else
          begin
            ExceptEnv := UTF8Encode(Format(DefException, [E.Message]));
            if (soUTF8InHeader in ConvertOptions) then
              Response.ContentType := ContentTypeUTF8
            else
              Response.ContentType := ContentTypeNoUTF8;
          end;
          Response.Content :=  ExceptEnv;
          Result := True;
        end;
      end;
    except
      { Swallow any unexpected exception, it will bring down some web servers }
      Result := False;
    end;
  finally
    { Reset current SOAPWebModule }
    SOAPWebModule := nil;
  end;
end;

end.

