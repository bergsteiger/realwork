{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                  SOAP Support                         }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.WebBrokerSOAP;

interface

uses
  System.Classes, System.Masks, Soap.SOAPAttachIntf, Soap.SOAPHTTPDisp,
  Web.AutoDisp, Web.HTTPApp;

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

implementation

uses
  System.Math, System.SysUtils, {$IFNDEF NEXTGEN} System.AnsiStrings, {$ENDIF !NEXTGEN}
  Soap.SOAPAttach, Soap.SOAPConst, Soap.SOAPPasInv,
  Soap.OpConvertOptions, Soap.OPToSOAPDomConv, Soap.WSDLIntf;

threadvar
  SOAPWebModule:  TWebModule;

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

{$IFDEF NEXTGEN}
function StreamAsTBytes(Stream: TStream): TBytes;
begin
  SetLength(Result, Stream.Size);
  Stream.Position := 0;
  Stream.Read(Result, 0, Length(Result));
  Stream.Position := 0;
end;
{$ELSE !NEXTGEN}
function StreamAsString(Stream: TStream): UTF8String;
begin
  SetLength(Result, Stream.Size);
  Stream.Position := 0;
  Stream.Read(Result[1], Length(Result));
  Stream.Position := 0;
end;
{$ENDIF NEXTGEN}

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
{$IFDEF NEXTGEN}
  Path, SoapAction, ContentType: string;
{$ELSE !NEXTGEN}
  Path, SoapAction, ContentType: AnsiString;
{$ENDIF NEXTGEN}
  XMLStream, RStream: TMemoryStream;
  AConvert: IAdapterConverter;
  ConvertOptions: TSOAPConvertOptions;
  Converter: TOPToSOAPDomConvert;
  IsMultiPart: Boolean;
  MimeStream: IMimeAttachmentHandler;
  ReqStream: TWebRequestStream;
  BindingTypeIn, BindingTypeOut: TWebServiceBindingType;
  ExceptEnv: string;

{$IFDEF NEXTGEN}
  function IsMultiPartForm(const ContentType: string): Boolean;
  const
    ContentHeaderMimeANSI: string = ContentHeaderMime;
{$ELSE !NEXTGEN}
  function IsMultiPartForm(const ContentType: AnsiString): Boolean;
  const
    ContentHeaderMimeANSI: AnsiString = ContentHeaderMime;
{$ENDIF NEXTGEN}
    MAX_COMP_LEN = Length(ContentHeaderMime)-2;
  var
    Len : Integer;
  begin
    Len := Min(Length(ContentType), length(ContentHeaderMimeANSI));
    if Len > MAX_COMP_LEN then
      Len := MAX_COMP_LEN;
{$IFDEF NEXTGEN}
    Result := StrLIComp(PChar(ContentType), PChar(ContentHeaderMime), Len) = 0;
{$ELSE !NEXTGEN}
    Result := System.AnsiStrings.AnsiStrLIComp(PAnsiChar(ContentType),
                                               PAnsiChar(ContentHeaderMimeANSI), Len) = 0;
{$ENDIF NEXTGEN}
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
{$IFDEF NEXTGEN}
    Response.ContentType := GetBorlandMimeContentType;
{$ELSE !NEXTGEN}
    Response.ContentType := AnsiString(GetBorlandMimeContentType);
{$ENDIF NEXTGEN}
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

        ContentType := Request.ContentType;
        if Supports(FSoapDispatcher, IAdapterConverter, AConvert) then
        begin
          ConvertOptions := AConvert.GetDomConverter.Options;
          Converter := AConvert.GetDomConverter;
          IsMultiPart := IsMultiPartForm(ContentType);
        end else
        begin
          IsMultiPart := False;
          Converter := nil;
        end;
        { Get SOAPAction header sent over }
        SoapAction := Request.GetFieldByName(SHTTPSoapAction);
        { CGI/Apache remap headers with 'HTTP_' prefix }
        if SoapAction = '' then
{$IFDEF NEXTGEN}
          SoapAction := Request.GetFieldByName('HTTP_SOAPACTION'); { do not localize }
{$ELSE !NEXTGEN}
          SoapAction := Request.GetFieldByName(AnsiString('HTTP_SOAPACTION')); { do not localize }
{$ENDIF NEXTGEN}
        { Get the path to which client posted - SOAPAction may not tell us
          which porttype to dispatch to; we'll then use the path }
        Path := Request.PathInfo;
        XMLStream := TMemoryStream.Create;
        try
          { Wrap request around a stream }
          ReqStream := TWebRequestStream.Create(Request);
          try
            MimeStream := GetMimeAttachmentHandler(ContentType);
            try
              { If packet is multipart, extract SOAP Envelope and cache
                any other MIMEParts to files }
              if IsMultiPart then
              begin
                BindingTypeIn := btMIME;
                MimeStream.ProcessMultiPartForm(ReqStream, XMLStream,
                                                ContentType, nil,
                                                Converter.Attachments,
                                                Converter.TempDir);
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
{$IFNDEF UNICODE}
            ExceptEnv := UTF8Encode(Format(DefException, [E.Message]));
            ExceptEnv := Format(DefExceptionMIME, [Length(ExceptEnv), ExceptEnv]);
            SetMIMEResponse(Length(ExceptEnv));
{$ELSE}
            ExceptEnv := Format(DefException, [E.Message]);
            ExceptEnv := Format(DefExceptionMIME, [Length(ExceptEnv), ExceptEnv]);
            SetMIMEResponse(Length(UTF8Encode(ExceptEnv)));
{$ENDIF}
          end else
          begin
{$IFNDEF UNICODE}
            ExceptEnv := UTF8Encode(Format(DefException, [E.Message]));
{$ELSE}
            ExceptEnv := Format(DefException, [E.Message]);
{$ENDIF}
            if (soUTF8InHeader in ConvertOptions) then
              Response.ContentType := ContentTypeUTF8
            else
              Response.ContentType := ContentTypeNoUTF8;
          end;
{$IFNDEF UNICODE}
          Response.Content :=  ExceptEnv;
{$ELSE}
{$IFDEF NEXTGEN}
          Response.RawContent := TEncoding.UTF8.GetBytes(ExceptEnv);
{$ELSE !NEXTGEN}
          Response.RawContent := UTF8Encode(ExceptEnv);
{$ENDIF NEXTGEN}
{$ENDIF}
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

