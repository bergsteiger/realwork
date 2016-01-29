{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                  SOAP Support                         }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.SOAPPasInv;

interface

uses
  System.Classes, System.TypInfo, Soap.InvokeRegistry, Soap.OPConvert,
  Soap.OPToSOAPDomConv, Soap.SOAPAttachIntf, Soap.WSDLIntf;

type

  { forward declarations }
  TSoapPascalInvoker = class;

  { Handlers to peek at data in/out of WebService }
  TBeforeDispatchEvent = procedure(const MethodName: string; const Request: TStream) of object;
  TBeforeDispatchEvent2= procedure(const MethodName: string; const Request: TStream;
                                   Response: TStream; var BindingType: TWebServiceBindingType;
                                   var Handled: Boolean) of object;
  TAfterDispatchEvent  = procedure(const MethodName: string; SOAPResponse: TStream) of object;
  TOnExceptionEvent    = procedure(const MethodName: string; const Request: TStream; const Response: TStream) of object;

  { Allows access to DomConverter }
  IAdapterConverter = interface
  ['{82165DF4-B1B9-D511-9561-00C04FA06B45}']
    function GetDomConverter: TOPToSoapDomConvert;
  end;

  { Allows access to DomConverter }
  IInvokerConverter = interface
  ['{367A2E38-0539-D611-97F2-00C04FA06B45}']
    function GetInvoker: TSoapPascalInvoker;
  end;

  TSoapPascalInvoker = class(TComponent, IAdapterConverter, IInvokerConverter)
  private
    FBeforeDispatchEvent: TBeforeDispatchEvent;
    FBeforeDispatchEvent2: TBeforeDispatchEvent2;
    FAfterDispatchEvent: TAfterDispatchEvent;
    FOnSendAttachment: TOnSendAttachmentEvent;
    FOnGetAttachment: TOnGetAttachmentEvent;
    FOnExceptionEvent: TOnExceptionEvent;
    procedure  SetDomConverter(Value: TOPToSoapDomConvert);
  protected
    FHeadersIn: THeaderList;
    FHeadersOut: THeaderList;
    FConverter: IOPConvert;
    FSOAPHeaders: TSOAPHeaders;
    { Hard-coded to DOM converter, for now }
    FDomConverter:  TOPToSoapDomConvert;
    function GetDomConverter: TOPToSoapDomConvert;
    function GetInvoker: TSoapPascalInvoker;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Invoke(AClass: TClass; IntfInfo: PTypeInfo; MethName: string;
                     const Request: TStream; Response: TStream; var BindingType: TWebServiceBindingType); virtual;
  published
    { Events }
    property BeforeDispatchEvent: TBeforeDispatchEvent read FBeforeDispatchEvent write FBeforeDispatchEvent;
    property AfterDispatchEvent: TAfterDispatchEvent read FAfterDispatchEvent write FAfterDispatchEvent;
    property OnSendAttachment: TOnSendAttachmentEvent read FOnSendAttachment write FOnSendAttachment;
    property OnGetAttachment: TOnGetAttachmentEvent read FOnGetAttachment write FOnGetAttachment;
    property OnExceptionEvent: TOnExceptionEvent read FOnExceptionEvent write FOnExceptionEvent;
    property BeforeDispatchEvent2: TBeforeDispatchEvent2 read FBeforeDispatchEvent2 write FBeforeDispatchEvent2;

    property Converter: TOPToSoapDomConvert read GetDomConverter write SetDomConverter;
  end;

function GetSOAPHeaders: ISOAPHeaders;

implementation

uses
  System.SysUtils, {$IFDEF MSWINDOWS}Winapi.ActiveX,{$ENDIF}
  Soap.IntfInfo, Soap.Invoker, Soap.OpConvertOptions, Soap.SOAPConst, Soap.WebServExp;

threadvar
  SOAPServerHeaders:  ISOAPHeaders;

function GetSOAPHeaders: ISOAPHeaders;
begin
  Result := SOAPServerHeaders;
end;

constructor TSoapPascalInvoker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  { Converter }
  FDomConverter := TOPToSoapDomConvert.Create(Self);
  FDomConverter.Name := 'Converter1'; { do not localize }
  FDomConverter.SetSubComponent(True);
  FDomConverter.Options := FDomConverter.Options + [soSendMultiRefObj, soTryAllSchema];

  { Headers }
  FSOAPHeaders := TSOAPHeaders.Create(Self);
  FHeadersIn := THeaderList.Create;
  FHeadersOut:= THeaderList.Create;
  { On Server-side make sure HeaderList does not own objects;
    all TSOAPHeader types inherit server-side lifetime management
    from TRemotable }
  FHeadersIn.OwnsObjects := False;
  FHeadersOut.OwnsObjects := False;
{$IFDEF POSIX}
  FDomConverter.Options := FDomConverter.Options + [soReturnSuccessForFault];
{$ENDIF}
  FConverter := FDomConverter as IOPConvert;
end;

destructor TSoapPascalInvoker.Destroy;
begin
  if Assigned(FConverter) then
    FConverter := nil;
  if Assigned(FDomConverter) and (FDomConverter.Owner = Self) then
    FDomConverter.Free;
  FSOAPHeaders.Free;
  FHeadersIn.Destroy;
  FHeadersOut.Destroy;
  inherited;
end;

procedure TSoapPascalInvoker.Invoke(AClass: TClass; IntfInfo: PTypeInfo; MethName: string; const Request: TStream;
                                    Response: TStream; var BindingType: TWebServiceBindingType);
var
  Inv: TInterfaceInvoker;
  Obj: TObject;
  InvContext: TInvContext;
  IntfMD: TIntfMetaData;
  MethNum: Integer;
  SOAPHeaders: ISOAPHeaders;
  Handled: Boolean;
begin
  try
{$IFDEF MSWINDOWS}
    { Assumes we are using COM dependent stuff (like the MSXML DOM) }
    CoInitialize(nil);
{$ENDIF}
    try
      MethNum := -1;
      GetIntfMetaData(IntfInfo, IntfMD, True);
      InvContext := TInvContext.Create;
      SetRemotableDataContext(InvContext);

      { Is this interface registered for document style? }
      if ioDocument in InvRegistry.GetIntfInvokeOptions(IntfInfo) then
        FConverter.Options := FConverter.Options + [soDocument]
      else
        FConverter.Options := FConverter.Options - [soDocument];

      try
        { Retrieve index from method name, if it's known! }
        { NOTE: This code often is often not taken because
                the MethName is not known yet - sometimes
                it comes with the SOAPAction... but there's
                a move away from SOAPAction currently }
        if MethName <> '' then
          MethNum := GetMethNum(IntfMD, MethName);

        { Request peeker }
        if Assigned(FBeforeDispatchEvent) then
        begin
          FBeforeDispatchEvent(MethName, Request);
          Request.Position := 0;
        end;

        { Request peeker2 }
        Handled := False;
        if Assigned(FBeforeDispatchEvent2) then
        begin
          FBeforeDispatchEvent2(MethName, Request, Response, BindingType, Handled);
          Request.Position := 0;
        end;

        if not Handled then
        begin
          { Convert XML to Invoke Context }
          FConverter.MsgToInvContext(Request, IntfMD, MethNum, InvContext, FHeadersIn);

          { Now, MethNum is filled!!
            NOTE: Here we could validate whether the BindingType upon input
                  was appropriate. However, since the XML packet has already
                  been cracked, there's a high probability that we won't get
                  that far... For example, if we were expecting plain XML
                  and the client sent MultiPart data, the loading of the
                  data into a DOM would have fail. However, the most common
                  scenario probably will be that the client is expecting
                  multipart and a client sends plain XML. This scenario
                  can be handled here provided that TSOAPAttachment
                  deserialization is not unhappy with the XML node }
          try
            Obj := InvRegistry.GetInvokableObjectFromClass(AClass);
            if Obj = nil then
              raise Exception.CreateFmt(SNoClassRegistered, [IntfMD.Name]);

            { Does class supports SOAP Headers? }
            if Supports(Obj, ISOAPHeaders, SOAPHeaders) then
              (SOAPHeaders as IHeadersSetter).SetHeadersInOut(FHeadersIn, FHeadersOut);
            { Also provide access to headers through a Threadvar - mainly for cases where
              Server does not derive from TInvokableClass }
            if Supports(FSOAPHeaders, ISOAPHeaders, SOAPHeaders) then
              (SOAPHeaders as IHeadersSetter).SetHeadersInOut(FHeadersIn, FHeadersOut);
            SOAPServerHeaders := SOAPHeaders;
            try
              { Dispatch }
              Inv := TInterfaceInvoker.Create;
              try
                { here we try to determine what type of data is being returned:
                  This will help the code that returns that data to the Client
                  determine whether is needs to make a multipart packet before
                  sending out the SOAP Envelope }
                BindingType := GetBindingType(IntfMD.MDA[MethNum], False);
                Inv.Invoke(Obj, IntfMD, MethNum, InvContext);
              finally
                Inv.Free;
                FConverter.Attachments.Clear;
                FHeadersIn.Clear;
              end;
            finally
              { clear out thread var access to headers }
              SOAPServerHeaders := nil;
            end;
            try
              FConverter.MakeResponse(IntfMD, MethNum, InvContext, Response, FHeadersOut);
            finally
              { Clear out headers that are being sent }
              FHeadersOut.Clear;
            end;
            { See if someone wants to monitor the response }
            if Assigned(FAfterDispatchEvent) then
            begin
              FAfterDispatchEvent(MethName, Response);
              Response.Position := 0;
            end;
          except
            on E: Exception do
            begin
              FConverter.MakeFault(E, Response);
              { Exception peek }
              if Assigned(FOnExceptionEvent) then
                FOnExceptionEvent(MethName, Request, Response);
            end;
          end;
        end;
      finally
        InvContext.Free;
        SetRemotableDataContext(nil);
      end;
    except
      on E: Exception do
      begin
        FConverter := TOPToSoapDomConvert.Create(nil) as IOPConvert;
        FConverter.MakeFault(E, Response);
      end;
    end;
  finally
{$IFDEF MSWINDOWS}
    CoUnInitialize;
{$ENDIF}
  end;
end;

procedure TSoapPascalInvoker.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FDomConverter) then
  begin
    FConverter := nil;
    FDomConverter := nil;
  end;
end;

function TSoapPascalInvoker.GetDomConverter: TOPToSoapDomConvert;
begin
  Result := FDomConverter;
end;

function TSoapPascalInvoker.GetInvoker: TSoapPascalInvoker;
begin
  Result := Self;
end;

procedure TSoapPascalInvoker.SetDomConverter(Value: TOPToSoapDomConvert);
begin
  if Assigned(FDOMConverter) and (FDomConverter.Owner = Self) then
  begin
    FConverter := nil;
    FDomConverter.Free;
  end;
  FDomConverter := Value;
  if Value <> nil then
  begin
    FConverter := Value as IOPConvert;
    Value.FreeNotification(Self);
  end;
end;

end.


