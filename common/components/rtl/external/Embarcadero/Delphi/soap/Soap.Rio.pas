{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{              Interface Invoker Support                }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.Rio;

{ RIO is currently implemented with WININET on WIN32 }
{$IFDEF WIN32}
 (*$HPPEMIT '#pragma link "wininet.lib"' *)
{$ENDIF}

{$DEFINE ATTACHMENT_SUPPORT}

interface

uses
  System.Classes, System.Rtti, Soap.IntfInfo, Soap.OPConvert,
  Soap.InvokeRegistry, Soap.WebNode, Soap.SOAPAttachIntf, Soap.WSDLIntf;

type
  TRIO = class;

  { This interface provides access back to the RIO
    from an interface that the RIO implements
    NOTE: It is *NOT* implemented at  the RIO level;
          therefore it cannot control the lifetime
          of the RIO;
          therefore you should not hang on to this interface
          as its underlying RIO could go away!
          Use the interface for quick RIO configuration
          when you still have the interface implemented
          by the RIO; then quickly "Let It Go!" }
  IRIOAccess = interface
  ['{FEF7C9CC-A477-40B7-ACBE-487EDA3E5DFE}']
    function GetRIO: TRIO;
    property RIO: TRIO read GetRIO;
  end;

  TBeforeExecuteEvent = procedure(const MethodName: string; SOAPRequest: TStream) of object;
  TAfterExecuteEvent  = procedure(const MethodName: string; SOAPResponse: TStream) of object;

  TRIO = class(TComponent, IInterface, IRIOAccess)
  private type
    TRioVirtualInterface = class(TVirtualInterface)
    private
      FRio: TRio;
    protected
//{$IFNDEF AUTOREFCOUNT}
      function _AddRef: Integer; override; stdcall;
      function _Release: Integer; override; stdcall;
//{$ENDIF !AUTOREFCOUNT}
    public
      constructor Create(ARio: TRio; AInterface: Pointer);
//{$IFNDEF AUTOREFCOUNT}
      function QueryInterface(const IID: TGUID; out Obj): HRESULT; override; stdcall;
//{$ENDIF !AUTOREFCOUNT}
    end;
  private
    FInterface: IInterface;

{$IFNDEF AUTOREFCOUNT}
    FRefCount: Integer;
{$ENDIF !AUTOREFCOUNT}

    { Headers }
    FSOAPHeaders: TSOAPHeaders;
    FHeadersOutBound: THeaderList;
    FHeadersInbound: THeaderList;

    FOnAfterExecute: TAfterExecuteEvent;
    FOnBeforeExecute: TBeforeExecuteEvent;
    FOnSendAttachment: TOnSendAttachmentEvent;
    FOnGetAttachment: TOnGetAttachmentEvent;

    procedure Generic(Method: TRttiMethod;
      const Args: TArray<TValue>; out Result: TValue);

{$IFNDEF AUTOREFCOUNT}
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
{$ENDIF !AUTOREFCOUNT}

    { IRIOAccess }
    function GetRIO: TRIO;

  protected
    FIID: TGUID;
    IntfMD: TIntfMetaData;
    FConverter: IOPConvert;
    FWebNode: IWebNode;

    procedure DoDispatch(const Context: TInvContext; MethNum: Integer; const MethMD: TIntfMethEntry);
    function InternalQI(const IID: TGUID; out Obj): HResult; stdcall;

    { Routines that derived RIOs may override }
    procedure DoAfterExecute(const MethodName: string; Response: TStream); virtual;
    procedure DoBeforeExecute(const MethodName: string; Request: TStream); virtual;
    function  GetResponseStream(BindingType: TWebServiceBindingType): TStream; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function QueryInterface(const IID: TGUID; out Obj): HResult; override; stdcall;
    { Behave like a TInterfacedObject, (only when Owner = nil) }
{$IFNDEF AUTOREFCOUNT}
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function NewInstance: TObject; override;

    property RefCount: Integer read FRefCount;
{$ENDIF !AUTOREFCOUNT}
    property Converter: IOPConvert read FConverter write FConverter;
    property WebNode: IWebNode read FWebNode write FWebNode;
    property SOAPHeaders: TSOAPHeaders read FSOAPHeaders;
  published
    property OnAfterExecute: TAfterExecuteEvent read FOnAfterExecute write FOnAfterExecute;
    property OnBeforeExecute: TBeforeExecuteEvent read FOnBeforeExecute write FOnBeforeExecute;
    property OnSendAttachment: TOnSendAttachmentEvent read FOnSendAttachment write FOnSendAttachment;
    property OnGetAttachment: TOnGetAttachmentEvent read FOnGetAttachment write FOnGetAttachment;
  end;

implementation

uses
  {$IFDEF MSWINDOWS}Winapi.Windows,{$ENDIF}
  {$IFDEF POSIX}Posix.Unistd,{$ENDIF}
  System.SysUtils, {$IFNDEF NEXTGEN} System.SyncObjs, {$ENDIF !NEXTGEN}
  Soap.OpConvertOptions, Soap.SOAPAttach, Soap.SOAPConst, Soap.WebServExp;

type
  TTempFileStream = class(THandleStream)
  private
    FTempFile: string;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

{ TTempFileStream }
constructor TTempFileStream.Create;
begin
  FTempFile := GetTempDir + 'EmbarcaderoSoapMimeCache';
  inherited Create(GetTempHandle(FTempFile));
end;

destructor TTempFileStream.Destroy;
var
  Handle: Integer;
begin
  Handle := Self.Handle;
  inherited;
  FileClose(Handle);
  if FileExists(FTempFile) then
    DeleteFile(FTempFile);
end;

{ TRIO }

constructor TRIO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  { Headers }
  FSOAPHeaders := TSOAPHeaders.Create(Self);
  FHeadersInbound := THeaderList.Create;
  FHeadersOutBound:= THeaderList.Create;
  { We don't own sent objects - just like we don't own
    TRemotable parameters sent to a Service -
    We will take ownership of headers received (returned by
    Service) unless Client removes them }
  FHeadersOutbound.OwnsObjects := False;
  (FSOAPHeaders as IHeadersSetter).SetHeadersInOut(FHeadersInbound, FHeadersOutBound);
end;

destructor TRIO.Destroy;
begin
  TRIOVirtualInterface(Pointer(FInterface)).Free;
  Pointer(FInterface) := nil;
  FSOAPHeaders.Free;
  FHeadersInbound.Free;
  FHeadersOutBound.Free;
  inherited;
end;

{$IFNDEF AUTOREFCOUNT}
procedure TRIO.AfterConstruction;
begin
  TInterlocked.Decrement(FRefCount); // Release the constructor's implicit refcount
end;

procedure TRIO.BeforeDestruction;
begin
  inherited;
  if FRefCount <> 0 then
    raise Exception.Create(SInvalidPointer);
end;

class function TRIO.NewInstance: TObject;
begin
  // Set an implicit refcount so that refcounting
  // during construction won't destroy the object.
  Result := inherited NewInstance;
  TRIO(Result).FRefCount := 1;
end;
{$ENDIF !AUTOREFCOUNT}

function TRIO.GetRIO: TRIO;
begin
  Result := Self;
end;

function TRIO.GetResponseStream(BindingType: TWebServiceBindingType): TStream;
begin
  if (BindingType in [btMime, btDime]) and
     (soCacheMimeResponse in FConverter.Options) then
    Result := TTempFileStream.Create
  else
    Result := TMemoryStream.Create;
end;

procedure TRIO.DoBeforeExecute(const MethodName: string; Request: TStream);
begin
  if Assigned(FOnBeforeExecute) then
  begin
    FOnBeforeExecute(MethodName, Request);
    Request.Position := 0;
  end;
end;

procedure TRIO.DoAfterExecute(const MethodName: string; Response: TStream);
begin
  if Assigned(FOnAfterExecute) then
  begin
    FOnAfterExecute(MethodName, Response);
    Response.Position := 0;
  end;
end;

procedure TRio.DoDispatch(const Context: TInvContext; MethNum: Integer;
  const MethMD: TIntfMethEntry);
var
  Req, Resp, RespXML: TStream;
  XMLStream: TMemoryStream;
  AttachHandler: IMimeAttachmentHandler;
  BindingType, RespBindingType: TWebServiceBindingType;
  AttachHeader: String;
begin
  { Convert parameter to XML packet }
  Req := FConverter.InvContextToMsg(IntfMD, MethNum, Context, FHeadersOutBound);
  try
{$IFDEF ATTACHMENT_SUPPORT}
    { Get the Binding Type
      NOTE: We're interested in the input/call }
    BindingType := GetBindingType(MethMD, True);

    { NOTE: Creation of AttachHandler could be delayed - doesn't
            seem to matter much though }
    AttachHandler := GetMimeAttachmentHandler(BindingType);
    AttachHandler.OnGetAttachment := OnGetAttachment;
    AttachHandler.OnSendAttachment := OnSendAttachment;
{$ELSE}
    BindingType := btSOAP;
{$ENDIF}
    try
{$IFDEF ATTACHMENT_SUPPORT}
      { Create MIME stream if we're MIME bound }
      if (BindingType = btMIME) then
      begin
        { Create a MIME stream from the request and attachments }
        AttachHandler.CreateMimeStream(Req, FConverter.Attachments);

        { Set the MIME Boundary
          Investigate: Since one of the weaknesses of MIME is the boundary,
          it seems that we should be going the other way.
          IOW, since the programmer can configure IWebNode's MIMEBoundary,
          we should be using that to initialize the AttachHandler's MIME Boundary.
          IOW, allow the programmer to customize the boundary... instead of
          ignoring whatever value the programmer may have put there at design time
          and hardcoding the MIMEBoundary.

          Or maybe that property should not be exposed at the Designer Level  ????  }
        FWebNode.MimeBoundary := AttachHandler.MIMEBoundary;

        { Allow for transport-specific initialization that needs to take
          place prior to execution - NOTE: It's important to call this
          routine before calling FinalizeStream - this allows the attachment's
          stream to be modified/configured }
        { NOTE: Skip 3 for AddRef,Release & QI }
        { NOTE: Hardcoding '3' makes an assumption: that the interface derived
                directly from IInvokable (i.e. IUnknown). Under that condition
                3 represent the three standard methods of IUknown. However,
                someone could ask the RIO for an interface that derives from
                something else that derives from IUnknown. In that case, the
                '3' here would be wrong. The importer always generates interfaces
                derived from IInvokable - so we're *relatively* safe. }
        FWebNode.BeforeExecute(IntfMD, MethMD, MethNum-3, AttachHandler);

        { This is a hack - but for now, LinkedRIO requires that FinalizeStream
          be called from here - doing so, breaks HTTPRIO - so we resort to a
          hack. Ideally, I'm thinking of exposing a thin AttachHeader interface
          that the transport can use to set SOAP headers - allowing each transport
          to perform any packet customization }
        if AttachHeader <> '' then
          AttachHandler.AddSoapHeader(AttachHeader);
        AttachHandler.FinalizeStream;
      end else
{$ENDIF}
        { NOTE: Skip 3 for AddRef,Release & QI - See comment above about '3' }
        FWebNode.BeforeExecute(IntfMD, MethMD, MethNum-3, nil);

      { Allow event to see packet we're sending }
      { This allows the handler to see the whole packet - i.e. attachments too }
{$IFDEF ATTACHMENT_SUPPORT}
      if BindingType = btMIME then
        DoBeforeExecute(MethMD.Name, AttachHandler.GetMIMEStream)
      else
{$ENDIF}
        DoBeforeExecute(MethMD.Name, Req);

{$IFDEF ATTACHMENT_SUPPORT}
      RespBindingType := GetBindingType(MethMD, False);
{$ELSE}
      RespBindingType := btSOAP;
{$ENDIF}
      Resp := GetResponseStream(RespBindingType);
      try
{$IFDEF ATTACHMENT_SUPPORT}
        if (BindingType = btMIME) then
        begin
          try
            FWebNode.Execute(AttachHandler.GetMIMEStream, Resp);
          finally
            FConverter.Attachments.Clear;
            FHeadersOutBound.Clear;
          end;
        end
        else
{$ENDIF}
        try
          FWebNode.Execute(Req, Resp);
        finally
          { Clear Outbound headers }
          FHeadersOutBound.Clear;
        end;

        { Assume the response is the SOAP Envelope in XML format. NOTE: In case
          of attachments, this could actually be a Multipart/Related response }
        RespXML := Resp;

        XMLStream := TMemoryStream.Create;
        try
          { This allows the handler to see the whole packet - i.e. attachments too }
          DoAfterExecute(MethMD.Name, Resp);
{$IFDEF ATTACHMENT_SUPPORT}
          { If we're expecting MIME parts, process 'em }
          if FWebNode.MimeBoundary <> '' then
          begin
            AttachHandler.ProcessMultiPartForm(Resp, XMLStream,
              FWebNode.MimeBoundary,
              nil,
              FConverter.Attachments,
              FConverter.TempDir);
             { Now point RespXML to Envelope }
            RespXML := XMLStream;
          end;
{$ENDIF}
          FConverter.ProcessResponse(RespXML, IntfMD, MethMD,
            Context, FHeadersInbound);
        finally
          XMLStream.Free;
        end;
      finally
        Resp.Free;
      end;
    finally
      FConverter.Attachments.Clear;
    end;
  finally
    Req.Free;
  end;
end;

{$IFNDEF AUTOREFCOUNT}
function TRIO._AddRef: Integer;
begin
  Result := TInterlocked.Increment(FRefCount);
end;

function TRIO._Release: Integer;
begin
  Result := TInterlocked.Decrement(FRefCount);
  if (Result = 0) and not (Owner is TComponent) then
    Destroy;
end;
{$ENDIF !AUTOREFCOUNT}

function TRIO.InternalQI(const IID: TGUID; out Obj): HResult;
begin
  Result := E_NOINTERFACE;
  { ISoap Headers }
  if IID = ISoapHeaders then
    if FSOAPHeaders.GetInterface(IID, Obj) then Result := 0;

  { IInterface, IRIOAccess }
  if (IID = IInterface) or (IID = IRIOAccess) then
    if GetInterface(IID, Obj) then Result := 0;

  { NOTE: Are there other interfaces that we would want to QI the
          RIOVirtualInterface for? }
  if (Result <> 0) and (FInterface <> nil) and (IID = FIID) then
    Result := TRIOVirtualInterface(Pointer(FInterface)).QueryInterface(IID, Obj);
end;

function TRIO.QueryInterface(const IID: TGUID; out Obj): HResult;
var
  InvokeOptions: TIntfInvokeOptions;
  PInfo: Pointer;
begin
  if FInterface = nil then
  begin
    PInfo := InvRegistry.GetInterfaceTypeInfo(IID);
    if PInfo <> nil then
    try
      Pointer(FInterface) := TRioVirtualInterface.Create(Self, PInfo);
      TRIOVirtualInterface(Pointer(FInterface)).OnInvoke := Generic;
      GetIntfMetaData(PInfo, IntfMD, True);
      FIID := IID;
    except
      TRIOVirtualInterface(Pointer(FInterface)).Free;
      Pointer(FInterface) := nil;
    end;
  end;

  Result := InternalQI(IID, Obj);

  { Here we override the Converter Options based on Invoke Options registered
    for this particular interface }
  if (Result = 0) and (FConverter <> nil) then
  begin
    InvokeOptions := InvRegistry.GetIntfInvokeOptions(IID);
    { Encode or passing document-style? }
    if ioDocument in InvokeOptions then
      FConverter.Options := FConverter.Options + [soDocument]
    else
      FConverter.Options := FConverter.Options - [soDocument];

    { And did we unwind or do we have literal parameters? }
    if ioLiteral in InvokeOptions then
      FConverter.Options := FConverter.Options + [soLiteralParams]
    else
      FConverter.Options := FConverter.Options - [soLiteralParams];

    { Are we to use v1.2 of SOAP }
    if ioSOAP12 in InvokeOptions then
    begin
      FConverter.Options := FConverter.Options + [soSOAP12];
      FWebNode.Options := FWebNode.Options + [wnoSOAP12];
    end
    else
    begin
      FConverter.Options := FConverter.Options - [soSOAP12];
      FWebNode.Options := FWebNode.Options - [wnoSOAP12];
    end;
  end;
end;

{ TRIO.TRioVirtualInterface }
constructor TRIO.TRioVirtualInterface.Create(ARio: TRio; AInterface: Pointer);
begin
  FRio := ARio;
  inherited Create(AInterface);
end;

function TRIO.TRioVirtualInterface.QueryInterface(const IID: TGUID;
  out Obj): HRESULT;
begin
  Result := inherited;
  if Result <> 0 then
    Result := FRio.InternalQI(IID, Obj);
end;

function TRIO.TRioVirtualInterface._AddRef: Integer;
begin
  Result := FRio._AddRef;
end;

function TRIO.TRioVirtualInterface._Release: Integer;
begin
  Result := FRio._Release;
end;

procedure TRio.Generic(Method: TRttiMethod;
  const Args: TArray<TValue>; out Result: TValue);
var
  MethMD: TIntfMethEntry;
  I: Integer;
  MethNum: Integer;
  Context: TInvContext;
begin
  if not Assigned(FConverter) then
    raise Exception.Create(SNoMessageConverter);
  if not Assigned(FWebNode) then
    raise Exception.Create(SNoMsgProcessingNode);
  Context :=  TInvContext.Create;
  try
    MethNum := 0;
    for I := 0 to Length(Intfmd.MDA) do
      if intfMD.MDA[I].Pos = method.VirtualIndex then
      begin
        MethNum := I;
        MethMD := IntfMD.MDA[I];
        Context.SetMethodInfo(MethMD);
        break;
      end;
    for I := 1 to methmd.ParamCount do
      Context.SetParamPointer(I-1, Args[I].GetReferenceToRawData);

    if Assigned(MethMd.ResultInfo) then
    begin
      TValue.Make(nil, MethMD.ResultInfo, Result);
      Context.SetResultPointer(Result.GetReferenceToRawData);
    end
    else
      Context.SetResultPointer(nil);
    DoDispatch(Context, MethNum, MethMD);
  finally
    Context.Free;
  end;
end;

end.
