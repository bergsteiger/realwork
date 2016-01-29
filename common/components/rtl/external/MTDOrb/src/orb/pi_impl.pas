// **********************************************************************
//
// Copyright (c) 2001 - 2002 Millennium Group.
//
// Samara, Russia
//
// All Rights Reserved
//
// **********************************************************************
unit pi_impl;

interface

{$I dorb.inc}

uses SysUtils, Classes, orbtypes, pi_int, pi, code_int, orb_int, env_int, iior_int, iiop_int,
  ssl_int, policy_int, except_int, comp_int, mcomp_int, poa_int, map_int;

{$IFNDEF USELIB}
type
  TCodecImpl = class(TCodec)
  private
    FEncoding: TEncoding;
    function FindTypeCode(tc: ITypeCode): boolean;
    function GetEncoder: IEncoder;
    function GetDecoder(buf: IBuffer): IDecoder;
  protected
    function encode(const data: IAny): TOctetSeq; override;
    function decode(const data: TOctetSeq): IAny; override;
    function encode_value(const data: IAny): TOctetSeq; override;
    function decode_value(const data: TOctetSeq; const tc: ITypeCode): IAny; override;
  public
    constructor Create(); overload;
    constructor Create(const enc: TEncoding); overload;
  end;

  TCodecFactoryImpl = class(TCodecFactory)
  protected
    function create_codec(const enc: TEncoding): ICodec; override;
  end;

  IPICurrentImpl = interface(IInterface)
  ['{3AA440B6-2BC3-42DD-B693-BDBC213D377C}']
    procedure Slots(const ASlots: AnySeq); overload;
    function Slots(): AnySeq; overload;
  end;

  TCurrentImpl = class(TCurrent, IPICurrentImpl)
  private
{$IFNDEF HAVE_THREADS}
    FSlots: AnySeq;
{$ENDIF}
  protected
    function get_slot(const id: TSlotId): IAny; override;
    procedure set_slot(const id: TSlotId; const data: IAny); override;
    { IPICurrentImpl }
    procedure Slots(const ASlots: AnySeq); overload;
    function Slots(): AnySeq; overload;
  public
    constructor Create;
  end;

  TPIState = (SEND_REQUEST, SEND_POLL, RECEIVE_REPLY, RECEIVE_EXCEPTION, RECEIVE_OTHER,
    RECEIVE_REQUEST_SERVICE_CONTEXTS, RECEIVE_REQUEST, SEND_REPLY, SEND_EXCEPTION, SEND_OTHER);

  IRequestImpl = interface(IInterface)
  ['{2C97AEE4-A21E-435C-B6CE-CC92E0FFDE11}']
    procedure ReplyStatus(AReplyStatus: TReplyStatus);
    procedure IceptOper(AIceptOper: TPIState);
    procedure RequestId(const AReqId: _ulong);
    procedure SyncScope(ASyncScope: TSyncScope);
    function Arguments(const Arg: INVList; ValidOut: Boolean): Boolean; overload;
    function Arguments(const Arg: IStaticAnyList; ValidOut: Boolean): Boolean; overload;
    procedure ResponseExpected(AResp: Boolean);
    procedure Result(const ARes: IAny);
    procedure OperationContext(const AContext: IContext);
    procedure Exception(const AException: IORBException); overload;
    function Exception: IORBException; overload;
    procedure Contexts(const AContextList: IContextList);
    procedure Slots(const ASlots: AnySeq); overload;
    function Slots(): AnySeq; overload;
  end;

  TRequestInfoImpl = class(TRequestInfo, IRequestImpl)
  private
    //FDummyParamList: TParameterList;
  protected
    FObject: IORBObject;
    FReqId: _ulong;
    FOperName: AnsiString;
    FIcepOper: TPIState;
    FParamList: TParameterList;
    FExceptList: TExceptionList;
    FContextList: TContextList;
    FContextListOrig: IContextList;
    FReqContext: TRequestContext;
    FResponse: Boolean;
    FResult: IAny;
    FSyncScope: TSyncScope;
    FReplyStatus: TReplyStatus;
    FReplySCL: ServiceContextList;
    FReqSCL: PServiceContextList;
    FFwdObject: IORBObject;
    FPolicies: PolicyList;
    FExceptListDefined: Boolean;
    FSlots: AnySeq;
    FException: IORBException;
    function NVListToParameterList(var param_list: TParameterList; const nvlist: INVList; ValidOut: Boolean): Boolean;
    function StaticAnyListToParameterList(var param_list: TParameterList; const salist: IStaticAnyList; ValidOut: Boolean): Boolean;
    procedure CorbaExceptListToDynExceptList(var dyn_except_list: TExceptionList; const except_list: IExceptionList);
    procedure CorbaContextListToDynContextList(var dyn_ctx_list: TContextList; const ctx_list: IContextList);
    procedure CorbaContextToDynContext(var dyn_ctx: TRequestContext; const ctx: IContext; const obj: IORBObject);
    function GetEncoder(var prof: IIORProfile): IEncoder;
    function GetProfile(): IIORProfile;
    function GetComponentsProfile(): IIORProfile;
	  function CompletionStatus(): TCompletionStatus;
    { IRequestInfo }
    function get_slot(const id: TSlotId): IAny; override;
    function get_request_service_context(const id: TServiceId): TServiceContext; override;
    function get_reply_service_context(const id: TServiceId): TServiceContext; override;
    function _get_request_id: _ulong; override;
    function _get_operation: Identifier; override;
    function _get_arguments: TParameterList; override;
    function _get_exceptions: TExceptionList; override;
    function _get_contexts: TContextList; override;
    function _get_operation_context: TRequestContext; override;
    function _get_result: IAny; override;
    function _get_response_expected: boolean; override;
    function _get_sync_scope: TSyncScope; override;
    function _get_reply_status: TReplyStatus; override;
    function _get_forward_reference: IORBObject; override;
    { IRequestImpl }
    procedure ReplyStatus(AReplyStatus: TReplyStatus);
    procedure IceptOper(AIceptOper: TPIState);
    procedure RequestId(const AReqId: _ulong);
    procedure SyncScope(ASyncScope: TSyncScope);
    function Arguments(const Arg: INVList; ValidOut: Boolean): Boolean; overload;
    function Arguments(const Arg: IStaticAnyList; ValidOut: Boolean): Boolean; overload;
    procedure ResponseExpected(AResp: Boolean);
    procedure Result(const ARes: IAny);
    procedure Contexts(const AContextList: IContextList); virtual;
    procedure OperationContext(const AContext: IContext);
    procedure Slots(const ASlots: AnySeq); overload;
    function Slots(): AnySeq; overload;
    procedure Exception(const AException: IORBException); overload;
    function Exception: IORBException; overload;
  end;

  IClientRequestImpl = interface(IRequestImpl)
  ['{6F54EC24-C5B4-4924-BB8A-F3E1B3DBC249}']
    procedure EffectiveTarget(const Obj: IORBObject);
    procedure SetRequestServiceContextList(const AServiceContextList: PServiceContextList);
    procedure OperationContext(const AContext: IContext);
    procedure SetReplyServiceContextList(const AServiceContextList: PServiceContextList);
    procedure SetExceptionsTypeCode(ExTC: array of ITypeCode);
  end;

  TClientRequestInfoImpl = class(TRequestInfoImpl, IClientRequestInfo, IClientRequestImpl)
  private
  protected
    function narrow_helper(const str: RepositoryId): Pointer; override;
    { IClientRequestInfo }
    function get_effective_component(const id: TComponentId): TTaggedComponent;
    function get_effective_components(const id: TComponentId): TTaggedComponentSeq;
    function get_request_policy(const _type: TPolicyType): IPolicy;
    procedure add_request_service_context(const service_context: TServiceContext; const replace: boolean);
    function _get_target: IORBObject;
    function _get_effective_target: IORBObject;
    function _get_effective_profile: TTaggedProfile;
    function _get_received_exception: IAny;
    function _get_received_exception_id: TRepositoryId;
    { IClientRequestImpl }
    procedure EffectiveTarget(const Obj: IORBObject);
    procedure SetRequestServiceContextList(const AServiceContextList: PServiceContextList);
    procedure OperationContext(const AContext: IContext);
    procedure SetReplyServiceContextList(const AServiceContextList: PServiceContextList);
    procedure SetExceptionsTypeCode(ExTC: array of ITypeCode);
  public
    constructor Create(obj: IORBObject; const oper: AnsiString; const res: PNamedValue = nil;
      req_id: _ulong = 0; param_list: INVList = nil; const exc_list: IExceptionList = nil;
      const ctx_list: IContextList = nil; ctx: IContext = nil; resp: Boolean = true);
    class function _narrow(const obj : IORBObject): IClientRequestInfo;
    class function narrow_helper2(const obj: IORBObject): Boolean;
  end;

  IServerRequestImpl = interface(IRequestImpl)
  ['{DE2CC0B8-D9AF-4E1D-B82A-1DCAD7CBB54B}']
    procedure EffectiveTarget(const Obj: IORBObject);
    procedure SetReplyServiceContextList(const AServiceContextList: PServiceContextList);
    procedure SetObjectAdapter(const AObjectAdapter: IObjectAdaptor);
    procedure OwnException(AOwn: Boolean); overload;
    function OwnException: Boolean; overload;
    procedure SetExceptionsTypeCode(ExTC: array of ITypeCode);
  end;

  TServerRequestInfoImpl = class(TRequestInfoImpl, IServerRequestInfo, IServerRequestImpl)
  private
    //FOwnException: Boolean;
    FObjectId: ObjectId;
    FObjectAdapter: IObjectAdaptor;
    FOwnException: Boolean;
  protected
    function narrow_helper(const str: RepositoryId): Pointer; override;
    { IServerRequestInfo }
    function get_server_policy(const _type: TPolicyType): IPolicy;
    procedure set_slot(const id: TSlotId; const data: IAny);
    function target_is_a(const id: TRepositoryId): boolean;
    procedure add_reply_service_context(const service_context: TServiceContext; const replace: boolean);
    function _get_sending_exception: IAny;
    function _get_object_id: TOctetSeq;
    function _get_adapter_id: TOctetSeq;
    function _get_target_most_derived_interface: TRepositoryId;
    { IServerRequestImpl }
    procedure EffectiveTarget(const Obj: IORBObject);
    procedure SetReplyServiceContextList(const AServiceContextList: PServiceContextList);
    procedure SetObjectAdapter(const AObjectAdapter: IObjectAdaptor);
    procedure OwnException(AOwn: Boolean); overload;
    function OwnException: Boolean; overload;
    procedure SetExceptionsTypeCode(ExTC: array of ITypeCode);
    procedure Contexts(const AContextList: IContextList); override;
  public
    constructor Create(obj: IORBObject; const oper: AnsiString; req_id: _ulong; resp: Boolean;
      const scl: PServiceContextList; const res: TNamedValue;
      param_list: INVList = nil; const exc_list: IExceptionList = nil;
      const ctx_list: IContextList = nil; ctx: IContext = nil);
    class function _narrow(const obj : IORBObject): IServerRequestInfo;
    class function narrow_helper2(const obj: IORBObject): Boolean;
  end;

  TIORInfoImpl = class(TIORInfo)
  private
    FPOA: IPOA;
    FIOR: IIOR;
    FCodeSetCoder: ICodeSetCoder;
  protected
    function get_effective_policy(const _type: TPolicyType): IPolicy; override;
    procedure add_ior_component(const comp: TTaggedComponent); override;
    procedure add_ior_component_to_profile(const comp: TTaggedComponent; const profile_id: TProfileId); override;
  public
    constructor Create(poa: IPOA; ior: IIOR);
  end;

  TORBInitInfoImpl = class(TORBInitInfo)
  private
    FORB: IORB;
    FORBId: Identifier;
    FParam: TStringSeq;
  protected
    procedure register_initial_reference(const id: TObjectId; const obj: IORBObject); override;
    function resolve_initial_references(const id: TObjectId): IORBObject; override;
    procedure add_client_request_interceptor(const interceptor: IClientRequestInterceptor); override;
    procedure add_server_request_interceptor(const interceptor: IServerRequestInterceptor); override;
    procedure add_ior_interceptor(const interceptor: IIORInterceptor); override;
    function allocate_slot_id: TSlotId; override;
    procedure register_policy_factory(const _type: TPolicyType; const policy_factory: IPolicyFactory); override;
    function _get_arguments: TStringSeq; override;
    function _get_orb_id: Identifier; override;
    function _get_codec_factory: ICodecFactory; override;
  public
    constructor Create(orb: IORB; const orb_id: RepositoryID; param: TStrings);
  end;

  //TClientMethod = procedure(ri: IClientRequestInfo) of object;
  TClientMethod = (cmSendRequest, cmSendPoll, cmReceiveReply, cmReceiveException, cmReceiveOther);
  //TServerMethod = procedure(ri: IServerRequestInfo) of object;
  TServerMethod = (smReceiveRequestServiceContexts, smReceiveRequest, smSendReply, smSendException, smSendOther);
  TInterceptionPoint = (ipStart, ipIntermediate, ipEnd);

  TPIManager = class(TObject)
  public
    constructor Create;
    destructor Destroy; override;
    class procedure Init;
    class function PIManager: TPIManager;
    class procedure DestroyAllInterceptors;
    class function Initializers: IInterfaceList;
    class procedure RegisterOrbInitializer(const AInit: IORBInitializer);
    function PolicyFactoryMap: ILongInterfaceMap;
    function Slots: AnySeq;
    procedure ExecClient(ri: IClientRequestInfo; method: TClientMethod; ip: TInterceptionPoint);
    procedure ExecServer(ri: IServerRequestInfo; method: TServerMethod; ip: TInterceptionPoint);
    // client interceptor methods
    procedure ExecSendRequest(ri: IClientRequestInfo);
    procedure ExecSendPoll(ri: IClientRequestInfo);
    procedure ExecReceiveReply(ri: IClientRequestInfo);
    procedure ExecReceiveException(ri: IClientRequestInfo);
    procedure ExecReceiveOther(ri: IClientRequestInfo);
    // server interceptor methods
    class function CreateSRI(const obj: IORBObject; const opName: AnsiString; req_id: _ulong; resp: Boolean;
      const scl: PServiceContextList): IServerRequestInfo;
    procedure ExecReceiveRequestServiceContexts(ri: IServerRequestInfo);
    procedure ExecReceiveRequest(ri: IServerRequestInfo);
    procedure ExecSendReply(ri: IServerRequestInfo);
    procedure ExecSendException(ri: IServerRequestInfo);
    procedure ExecSendOther(ri: IServerRequestInfo);
    procedure ReceiveRequestServiceContextsIp(const sri: IServerRequestInfo; const AServiceContextList: PServiceContextList;
      const oa: IObjectAdaptor);
    // IOR Interceptor method
    procedure ExecEstablishComponents(info: IIORInfo);
    // add interceptor methods
    procedure ExecAddClientInterceptor(interceptor: IClientRequestInterceptor);
    procedure ExecAddServerInterceptor(interceptor: IServerRequestInterceptor);
    procedure ExecAddIorInterceptor(interceptor: IIORInterceptor);
  end;

implementation

uses throw, codeset, encoder, decoder, buffer, any, exceptions, policy, map,
  orbcomp, osthread, poa, tcode, Contnrs;

type
  TFlowStack = class(TObject)
  private
    FStartIp,
    FEndIp: IInterfaceStack;
  public
    constructor Create(const AList: IInterfaceList);
    function StartIp: IInterfaceStack;
    function EndIp: IInterfaceStack;
  end;

var
{$IFNDEF HAVE_THREADS}
  PISlots: AnySeq;
{$ENDIF}
  PolicyFactoryMapVar: ILongInterfaceMap;
  ClientPIStack: TStack;
  ServerPIStack: TStack;
  ClientReqInt: IInterfaceList;
  ServerReqInt: IInterfaceList;
  IORInterceptor: IInterfaceList;
  PIInitializers: IInterfaceList;
  ClientPIIndex: Integer = 0;
  ServerPIIndex: Integer = 0;
  ClientPIMutex: TRecursiveMutex;
  ServerPIMutex: TRecursiveMutex;
  PIManagerVar: TPIManager;
  MaxSlotId: Integer = 0;
{$IFDEF HAVE_THREADS}
threadvar
  PISlots: AnySeq;
{$ENDIF}

{ TCodecImpl }

constructor TCodecImpl.Create;
begin
  inherited;
  FEncoding.format := ENCODING_CDR_ENCAPS;
  FEncoding.major_version := 1;
  FEncoding.minor_version := 0;
end;

constructor TCodecImpl.Create(const enc: TEncoding);
begin
  inherited Create();
  FEncoding := enc;
end;

function TCodecImpl.decode(const data: TOctetSeq): IAny;
var
  len, i: Integer;
  buf: IBuffer;
  dec: IDecoder;
  endian: Boolean;
begin
  len := Length(data);
  if (len = 0) then
    dorb_throw(TFormatMismatch.Create());

  buf := TBuffer.Create;
  for i := 0 to len - 1 do
    buf.put(data[i]);

  dec := GetDecoder(buf);
  if dec.get_boolean(endian) then begin
    if endian then
      dec.byteorder(LittleEndian)
    else
      dec.byteorder(BigEndian);
  end
  else
    dorb_throw(TFormatMismatch.Create());
  if not dec.get_any(result) then
    dorb_throw(TFormatMismatch.Create());
end;

function TCodecImpl.decode_value(const data: TOctetSeq;
  const tc: ITypeCode): IAny;
var
  len, i: Integer;
  buf: IBuffer;
  dec: IDecoder;
  endian: Boolean;
begin
  len := Length(data);
  if (len = 0) then
    dorb_throw(TFormatMismatch.Create());

  buf := TBuffer.Create;
  for i := 0 to len - 1 do
    buf.put(data[i]);

  dec := GetDecoder(buf);
  if dec.get_boolean(endian) then begin
    if endian then
      dec.byteorder(LittleEndian)
    else
      dec.byteorder(BigEndian);
  end
  else
    dorb_throw(TFormatMismatch.Create());
  result := TAny.Create();
  if not result.demarshal(tc, dec) then
    dorb_throw(TFormatMismatch.Create());
end;

function TCodecImpl.encode(const data: IAny): TOctetSeq;
var
  tc: ITypeCode;
  enc: IEncoder;
  endian: Boolean;
  buf: IBuffer;
  len: Integer;
begin
  tc := data.get_type();
  if (FEncoding.minor_version < 2) and FindTypeCode(tc) then
    dorb_throw(TInvalidTypeForEncoding.Create());

  enc := GetEncoder();

  endian := enc.byteorder() = LittleEndian;
  enc.put_boolean(endian);

  enc.put_any(data);
  buf := enc.buffer();
  buf.RseekFromBegin(0);
  len := buf.length();

  SetLength(result, len);
  Move(PByteLargeArray(buf._buffer())^, Pointer(result)^, len);
end;

function TCodecImpl.encode_value(const data: IAny): TOctetSeq;
var
  tc: ITypeCode;
  enc: IEncoder;
  endian: Boolean;
  buf: IBuffer;
  len: Integer;
begin
  tc := data.get_type();
  if (FEncoding.minor_version < 2) and FindTypeCode(tc) then
    dorb_throw(TInvalidTypeForEncoding.Create());

  enc := GetEncoder();

  endian := enc.byteorder() = LittleEndian;
  enc.put_boolean(endian);

  data.marshal(enc);

  buf := enc.buffer();
  buf.RseekFromBegin(0);
  len := buf.length();
  SetLength(result, len);
  Move(PByteLargeArray(buf._buffer())^, Pointer(result)^, len);
end;

function TCodecImpl.FindTypeCode(tc: ITypeCode): boolean;
var
  i: Integer;
begin
  result := false;
  case tc.unalias().kind() of
    tk_wstring, tk_wchar: result := true;
    tk_struct, tk_except, tk_union:
      for i := 0 to tc.member_count() - 1 do begin
        result := FindTypeCode(tc.member_type(i));
        if result then
          Break;
      end;
    tk_sequence, tk_array: result := FindTypeCode(tc.content_type());
  end;
end;

function TCodecImpl.GetDecoder(buf: IBuffer): IDecoder;
var
  csid, wcsid: CodesetId;
  conv: ICodeSetCoder;
begin
  csid := TCodeset.special_cs(DefaultCS).id();
  wcsid := TCodeset.special_cs(DefaultWCS).id();

  if (FEncoding.major_version = 0) then
    conv := TGIOP_1_0_CodeSetCoder.Create()
  else if (FEncoding.minor_version = 1) then
    conv := TGIOP_1_1_CodeSetCoder.Create(csid)
  else if (FEncoding.minor_version = 2) then
    conv := TGIOP_1_2_CodeSetCoder.Create(csid, wcsid);

  result := TDecoder.Create(buf);
  result.set_converter(conv);
  //result.byteorder(DefaultEndian);
end;

function TCodecImpl.GetEncoder: IEncoder;
var
  csid, wcsid: CodesetId;
  conv: ICodeSetCoder;
begin
  csid := TCodeset.special_cs(DefaultCS).id();
  wcsid := TCodeset.special_cs(DefaultWCS).id();

  if (FEncoding.major_version = 0) then
    conv := TGIOP_1_0_CodeSetCoder.Create()
  else if (FEncoding.minor_version = 1) then
    conv := TGIOP_1_1_CodeSetCoder.Create(csid)
  else if (FEncoding.minor_version = 2) then
    conv := TGIOP_1_2_CodeSetCoder.Create(csid, wcsid);

  result := TEncoder.Create(TBuffer.Create, conv);
  //result.byteorder(DefaultEndian);
end;

{ TCodecFactoryImpl }

function TCodecFactoryImpl.create_codec(const enc: TEncoding): ICodec;
begin
  if (enc.format <> ENCODING_CDR_ENCAPS) and (enc.major_version <> 1) then
    dorb_throw(TUnknownEncoding.Create);
  if enc.major_version <= 2 then
    result := TCodecImpl.Create(enc)
  else
    dorb_throw(TUnknownEncoding.Create);
end;

{ TCurrentImpl }

constructor TCurrentImpl.Create;
begin
  inherited;
{$IFNDEF HAVE_THREADS}
  FSlots := PISlots;
{$ENDIF}
end;

function TCurrentImpl.get_slot(const id: TSlotId): IAny;
var
  slots: AnySeq;
begin
{$IFNDEF HAVE_THREADS}
  if id >= TSlotId(Length(FSlots)) then
    dorb_throw(TInvalidSlot.Create());
  result := FSlots[id];
{$ELSE}
  slots := Self.Slots();
  if id >= TSlotId(Length(slots)) then
    dorb_throw(TInvalidSlot.Create());
  result := TAny.Create_any(slots[id]);
{$ENDIF}
end;

procedure TCurrentImpl.set_slot(const id: TSlotId; const data: IAny);
var
  slots: AnySeq;
begin
{$IFNDEF HAVE_THREADS}
  if id >= TSlotId(Length(FSlots)) then
    dorb_throw(TInvalidSlot.Create());
  FSlots[id] := data;
{$ELSE}
  slots := Self.Slots();
  if id >= TSlotId(Length(slots)) then
    dorb_throw(TInvalidSlot.Create());
  slots[id] := data;
{$ENDIF}
end;

procedure TCurrentImpl.Slots(const ASlots: AnySeq);
begin
{$IFNDEF HAVE_THREADS}
{$ELSE}
  PISlots := Copy(ASlots);
{$ENDIF}
end;

function TCurrentImpl.Slots: AnySeq;
var
  i: Integer;
begin
{$IFNDEF HAVE_THREADS}
{$ELSE}
  if PISlots = nil then begin
    //lazy init
    SetLength(PISlots, MaxSlotId);
    for i := 0 to MaxSlotId - 1 do
      PISlots[i] := TAny.Create();
  end;
  result := PISlots;
{$ENDIF}
end;

{ TRequestInfoImpl }

function TRequestInfoImpl._get_arguments: TParameterList;
{var
  len, i: Integer;}
begin
  if (FIcepOper = SEND_POLL) or
     (FIcepOper = RECEIVE_EXCEPTION) or
     (FIcepOper = SEND_EXCEPTION) or
     (FIcepOper = RECEIVE_OTHER) or
     (FIcepOper = SEND_OTHER) or
     (FIcepOper = RECEIVE_REQUEST_SERVICE_CONTEXTS) then
    dorb_throw(BAD_INV_ORDER.Create(MinorRequestAlreadySent, CompletionStatus()));
  (*if (FIcepOper = SEND_REQUEST) or (FIcepOper = RECEIVE_REQUEST) then begin
    SetLength(FDummyParamList, 0);
    for i := 0 to Length(FParamList) - 1 do begin
      {if (FParamList[i].mode = PARAM_IN) or (FParamList[i].mode = PARAM_INOUT) then begin
          len := Length(FDummyParamList);
          SetLength(FDummyParamList, len + 1);
          FDummyParamList[len] := FParamList[i]
      end;}
      len := Length(FDummyParamList);
      SetLength(FDummyParamList, len + 1);
      if (FParamList[i].mode = PARAM_IN) or (FParamList[i].mode = PARAM_INOUT) then
        FDummyParamList[len] := FParamList[i]
      else begin
        // The value may only be copied if there is a successful response
        if FIcepOper = SEND_REQUEST then
          FDummyParamList[len] := FParamList[i]
        else begin
          FDummyParamList[len].mode := PARAM_OUT;
          FDummyParamList[len].argument := CreateAny;
        end;
      end;
    end;
    result := FDummyParamList;
  end
  else
    result := FParamList;*)
  result := Copy(FParamList);
end;

function TRequestInfoImpl._get_contexts: TContextList;
begin
  if (FIcepOper = SEND_POLL) or (FIcepOper = RECEIVE_REQUEST_SERVICE_CONTEXTS) then
    dorb_throw(BAD_INV_ORDER.Create(MinorRequestAlreadySent, CompletionStatus()));
  result := Copy(FContextList);
end;

function TRequestInfoImpl._get_exceptions: TExceptionList;
begin
  if (FIcepOper = SEND_POLL) or (FIcepOper = RECEIVE_REQUEST_SERVICE_CONTEXTS) then
    dorb_throw(BAD_INV_ORDER.Create(MinorRequestAlreadySent, CompletionStatus()));
  if FExceptListDefined then
    result := Copy(FExceptList)
  else
    dorb_throw(NO_RESOURCES.Create(MinorInvalidBinding, CompletionStatus()));
end;

function TRequestInfoImpl._get_forward_reference: IORBObject;
begin
    if (FIcepOper <> RECEIVE_OTHER) and (FIcepOper <> SEND_OTHER) then
      dorb_throw(BAD_INV_ORDER.Create(MinorRequestAlreadySent, CompletionStatus()));
    if (FReplyStatus <> LOCATION_FORWARD) and (FReplyStatus <> LOCATION_FORWARD_PERMANENT) then
      dorb_throw(BAD_INV_ORDER.Create(MinorRequestAlreadySent, CompletionStatus()));
    result := FFwdObject;
end;

function TRequestInfoImpl._get_operation: Identifier;
begin
  result := FOperName;
end;

function TRequestInfoImpl._get_operation_context: TRequestContext;
begin
  if (FIcepOper = SEND_POLL) or
     (FIcepOper = RECEIVE_REQUEST_SERVICE_CONTEXTS) or
	   (FIcepOper = SEND_EXCEPTION) or
	   (FIcepOper = SEND_OTHER)
  then
    dorb_throw(BAD_INV_ORDER.Create(MinorRequestAlreadySent, CompletionStatus()));
  result := Copy(FReqContext);
end;

function TRequestInfoImpl._get_reply_status: TReplyStatus;
begin
  if (FIcepOper = SEND_POLL) or
     (FIcepOper = SEND_REQUEST) or
     (FIcepOper = RECEIVE_REQUEST_SERVICE_CONTEXTS) or
     (FIcepOper = RECEIVE_REQUEST) then
    dorb_throw(BAD_INV_ORDER.Create(MinorRequestAlreadySent, CompletionStatus()));
  result := FReplyStatus;
end;

function TRequestInfoImpl._get_request_id: _ulong;
begin
  result := FReqId;
end;

function TRequestInfoImpl._get_response_expected: boolean;
begin
  result := FResponse;
end;

function TRequestInfoImpl._get_result: IAny;
begin
  if (FIcepOper = RECEIVE_REPLY) or (FIcepOper = SEND_REPLY) then begin
    if FResult <> nil then
      result := FResult
    else
      result := CreateAny();
  end
  else
    dorb_throw(BAD_INV_ORDER.Create(MinorRequestAlreadySent, CompletionStatus()));
end;

function TRequestInfoImpl._get_sync_scope: TSyncScope;
begin
  if (FIcepOper = SEND_POLL) then
    dorb_throw(BAD_INV_ORDER.Create(MinorRequestAlreadySent, CompletionStatus()));
  result := FSyncScope;
end;

function TRequestInfoImpl.get_reply_service_context(
  const id: TServiceId): TServiceContext;
var
  i: Integer;
begin
  if (FIcepOper = SEND_POLL) or
     (FIcepOper = SEND_REQUEST) or
     (FIcepOper = RECEIVE_REQUEST_SERVICE_CONTEXTS) or
     (FIcepOper = RECEIVE_REQUEST)  then
    dorb_throw(BAD_INV_ORDER.Create(MinorRequestAlreadySent, CompletionStatus()));
    
  for i := 0 to Length(FReplySCL) - 1 do
    if FReplySCL[i].context_id = id then begin
      result := FReplySCL[i];
      Exit;
    end;

  dorb_throw(BAD_PARAM.Create(MinorInvalidServiceContextId, CompletionStatus()));
end;

function TRequestInfoImpl.get_request_service_context(
  const id: TServiceId): TServiceContext;
var
  i: Integer;
begin
  if (FIcepOper = SEND_POLL) then
    dorb_throw(BAD_INV_ORDER.Create(MinorRequestAlreadySent, CompletionStatus()));

  for i := 0 to Length(FReqSCL^) - 1 do
    if FReqSCL^[i].context_id = id then begin
      result := FReqSCL^[i];
      Exit;
    end;

  dorb_throw(BAD_PARAM.Create(MinorInvalidServiceContextId, CompletionStatus()));
end;

function TRequestInfoImpl.get_slot(const id: TSlotId): IAny;
begin
  if (id >= TSlotId(Length(FSlots))) then
    dorb_throw(TInvalidSlot.Create());
  result := TAny.Create_any(FSlots[id]);
end;

function TRequestInfoImpl.NVListToParameterList(
  var param_list: TParameterList; const nvlist: INVList; ValidOut: Boolean): Boolean;
var
  i: Integer;
begin
  result := false;
  SetLength(param_list, nvlist.count);
  for i := 0 to nvlist.count - 1 do begin
    with nvlist.item(i) do begin
      if not ValidOut and (flags = ARG_OUT) then
  	    // out param in send or receive request interception points
        param_list[i].argument := CreateAny_buff(TTypeCode.Create(tk_null), nil)
      else
  	    // other interception point than send request or receive request
	      // or other param than out
        param_list[i].argument := argument;
      case flags of
        ARG_IN: param_list[i].mode := PARAM_IN;
        ARG_INOUT: param_list[i].mode := PARAM_INOUT;
        ARG_OUT: param_list[i].mode := PARAM_OUT;
      else
        Exit;
      end;
    end; { with }
  end;
  result := true;
end;

procedure TRequestInfoImpl.CorbaExceptListToDynExceptList(
  var dyn_except_list: TExceptionList; const except_list: IExceptionList);
var
  i: Integer;
begin
  SetLength(dyn_except_list, except_list.count);
  for i := 0 to except_list.count - 1 do
    dyn_except_list[i] := except_list.item(i);
end;

procedure TRequestInfoImpl.CorbaContextListToDynContextList(
  var dyn_ctx_list: TContextList; const ctx_list: IContextList);
var
  i: Integer;
begin
  SetLength(dyn_ctx_list, ctx_list.count);
  for i := 0 to ctx_list.count  - 1 do
    dyn_ctx_list[i] := AnsiString(ctx_list.item(i));
end;

procedure TRequestInfoImpl.CorbaContextToDynContext(
  var dyn_ctx: TRequestContext; const ctx: IContext;
  const obj: IORBObject);
var
  values: NVList;
  i, j: Integer;
  str: AnsiString;
begin
  if ctx = nil then
    Exit;
  if FContextListOrig <> nil then
    ctx.get_values('', 0, FContextListOrig, values)
  else
    ctx.get_values('', 0, '*', values);
  SetLength(dyn_ctx, 2 * Length(values));
  j := 0;
  for i := 0 to Length(values) - 1 do begin
    dyn_ctx[j] := values[i].name;
    if values[i].argument.to_string(str) then
      dyn_ctx[j + 1] := str;
    Inc(j, 2);
  end;
end;

function TRequestInfoImpl.GetEncoder(var prof: IIORProfile): IEncoder;
var
  version: _ushort;
  conv: ICodeSetCoder;
  csid, wcsid: CodesetId;
begin
  prof := GetProfile();
  if (prof = nil) then
    Exit;
  version := $0100;
  if (prof.id() = TAG_INTERNET_IOP) then begin
      version := (prof as IIOPProfile).version();
  end;
  csid := TCodeset.special_cs(DefaultCS).id();
  wcsid := TCodeset.special_cs(DefaultWCS).id();

  if (version = $0100) then
      conv := TGIOP_1_0_CodeSetCoder.Create()
  else if (version = $0101) then
      conv := TGIOP_1_1_CodeSetCoder.Create(csid)
  else if (version >= $0102) then
      conv := TGIOP_1_2_CodeSetCoder.Create(csid, wcsid);
  result := TEncoder.Create(TBuffer.Create, conv);
end;

function TRequestInfoImpl.GetProfile: IIORProfile;
var
  //iiopprof: IIOPProfile;
{$IFDEF HAVE_SSL}
  //sslprof: ISSLProfile;
{$ENDIF}
  pol: IPolicy;
  tpp: ITransportPrefPolicy;
  prefs: TProfileTagSeq;
  idx, i: _ulong;
begin
  prefs := nil;
  result := FObject.fwd_ior().active_profile(idx);
  if result <> nil then begin
    if (result.id() = TAG_INTERNET_IOP) then begin
      result := result as IIOPProfile;
      Exit;
    end;
{$IFDEF HAVE_SSL}
    if (result.id() = TAG_SSL_INTERNET_IOP) then begin
      result := result as ISSLProfile;
      Exit;
    end;
{$ENDIF}
  end
  else begin
    pol := FObject.get_policy(TRANSPORTPREF_POLICY_TYPE);
    tpp := TTransportPrefPolicy._narrow(pol);
    if (tpp = nil) then
      Exit;
    prefs := tpp.preferences_nocopy;
    for i := 0 to Length(prefs) - 1 do begin
      result := FObject.fwd_ior().profile((prefs)[i]);
      if (result <> nil) then begin
        if (result.id() = TAG_INTERNET_IOP) then begin
          result := result as IIOPProfile;
          Exit;
        end;
{$IFDEF HAVE_SSL}
        if (result.id() = TAG_SSL_INTERNET_IOP) then begin
          result := result as ISSLProfile;
          Exit;
        end;
{$ENDIF}
      end;
    end
  end;
end;

function TRequestInfoImpl.GetComponentsProfile: IIORProfile;
var
  ix: _ulong;
begin
  ix := 0;
  result := FObject._ior.profile(ix);
  while (result <> nil) do begin
    if (result.id() = TAG_MULTIPLE_COMPONENTS) then
      Exit;
    Inc(ix);
    result := FObject._ior.profile(ix);
  end;
end;

procedure TRequestInfoImpl.ReplyStatus(AReplyStatus: TReplyStatus);
begin
  FReplyStatus := AReplyStatus;
end;

procedure TRequestInfoImpl.IceptOper(AIceptOper: TPIState);
begin
  FIcepOper := AIceptOper;
end;

procedure TRequestInfoImpl.RequestId(const AReqId: _ulong);
begin
  FReqId := AReqId;
end;

procedure TRequestInfoImpl.SyncScope(ASyncScope: TSyncScope);
begin
  FSyncScope := ASyncScope;
end;

function TRequestInfoImpl.Arguments(const Arg: INVList; ValidOut: Boolean): Boolean;
begin
  result := NVListToParameterList(FParamList, Arg, ValidOut);
end;

procedure TRequestInfoImpl.ResponseExpected(AResp: Boolean);
begin
  FResponse := AResp;
end;

procedure TRequestInfoImpl.Result(const ARes: IAny);
begin
  FResult := ARes;
end;

function TRequestInfoImpl.Arguments(const Arg: IStaticAnyList; ValidOut: Boolean): Boolean;
begin
  result := StaticAnyListToParameterList(FParamList, Arg, ValidOut);
end;

function TRequestInfoImpl.StaticAnyListToParameterList(
  var param_list: TParameterList; const salist: IStaticAnyList; ValidOut: Boolean): Boolean;
var
  i, len: Integer;
begin
  len := salist.Count;
  SetLength(param_list, len);
  for i := 0 to len - 1 do begin
    with param_list[i] do begin
      argument := CreateAny();
      if not ValidOut and (salist[i].get_flags = ARG_OUT) then
  	    // out param in send and receive request interception points
        argument := CreateAny_buff(TTypeCode.Create(tk_null), nil)
      else begin
  	    // other interception point than send request and receive request
	      // or other param than out
        argument := CreateAny();
        argument.from_static_any(salist[i]);
      end;
      if salist[i].get_flags = ARG_IN then
        mode := PARAM_IN
      else if salist[i].get_flags = ARG_INOUT then
        mode := PARAM_INOUT
      else if salist[i].get_flags = ARG_OUT then
        mode := PARAM_OUT
      else begin
        result := false;
        Exit;
      end;
    end; { with }
  end;
  result := true;
end;

procedure TRequestInfoImpl.OperationContext(const AContext: IContext);
begin
  //if (FIcepOper = SEND_POLL) or (FIcepOper = RECEIVE_REQUEST_SERVICE_CONTEXTS) then
    //dorb_throw(BAD_INV_ORDER.Create);
  CorbaContextToDynContext(FReqContext, AContext, FObject);
end;

function TRequestInfoImpl.CompletionStatus: TCompletionStatus;
var
  sys: ISystemException;
begin
  result := COMPLETED_NO;
  if (FIcepOper = SEND_REQUEST) or
     (FIcepOper = SEND_POLL) or
     (FIcepOper = SEND_OTHER) or
     (FIcepOper = RECEIVE_REQUEST_SERVICE_CONTEXTS) or
     (FIcepOper = RECEIVE_REQUEST) or
     (FIcepOper = RECEIVE_OTHER)
  then begin
    result := COMPLETED_NO;
    Exit;
  end
  else if (FIcepOper = SEND_REPLY) or
    (FIcepOper = RECEIVE_REPLY)
  then
    result := COMPLETED_YES
  else if (FIcepOper = SEND_EXCEPTION) or
    (FIcepOper = RECEIVE_EXCEPTION)
  then begin
    if (FReplyStatus = USER_EXCEPTION) then
      result := COMPLETED_YES
    else if (FReplyStatus = SYSTEM_EXCEPTION) then begin
      sys := SystemException.EXCEPTION_DOWNCAST(Self.FException);
      Assert(sys <> nil);
      result := sys.completed();
    end;
  end;
end;

procedure TRequestInfoImpl.Contexts(const AContextList: IContextList);
begin
  if AContextList <> nil then begin
    CorbaContextListToDynContextList(FContextList, AContextList);
    FContextListOrig := AContextList;
  end;
end;

procedure TRequestInfoImpl.Slots(const ASlots: AnySeq);
begin
  FSlots := ASlots;
end;

function TRequestInfoImpl.Slots: AnySeq;
begin
  result := Copy(FSlots);
end;

procedure TRequestInfoImpl.Exception(const AException: IORBException);
begin
  FException := AException;
end;

function TRequestInfoImpl.Exception: IORBException;
begin
  result := FException;
end;

{ TClientRequestInfoImpl }

function TClientRequestInfoImpl._get_effective_profile: TTaggedProfile;
var
  prof: IIORProfile;
  enc: IEncoder;
  buf: IBuffer;
begin
  enc := GetEncoder(prof);
  if (prof = nil) then
    Exit;
  prof.encode(enc);
  buf := enc.buffer();
  buf.RseekFromBegin(0);
  SetLength(result.profile_data, buf.length());
  result.tag := prof.id;
  Move(PByteLargeArray(buf._buffer())^, Pointer(result.profile_data)^, buf.length());
end;

function TClientRequestInfoImpl._get_effective_target: IORBObject;
begin
  result := FObject;
end;

function TClientRequestInfoImpl._get_received_exception: IAny;
var
  sysExcept: ISystemException;
  uuExcept: IUnknownUserException;
  repoid: RepositoryId;
  tc: ITypeCode;
  i: Integer;
begin
  if (FIcepOper <> RECEIVE_EXCEPTION) then
	  dorb_throw(BAD_INV_ORDER.Create(MinorRequestAlreadySent, CompletionStatus()));
  if (FException = nil) then
    Exit;
  sysExcept := SystemException.EXCEPTION_DOWNCAST(FException);
  if (sysExcept <> nil) then begin
    result := CreateAny();
    sysExcept.encode_any(result);
    Exit;
  end;

  if (Length(FExceptList) > 0) then begin
    uuExcept := UnknownUserException.EXCEPTION_DOWNCAST(FException);
    if (uuExcept <> nil) then begin
      repoid := uuExcept.except_repoid();
      for i := 0 to Length(FExceptList) - 1 do begin
        tc := FExceptList[i];
        if repoid = tc.id() then begin
          result := uuExcept.exception(tc);
          Exit;
        end;
      end;
    end;
  end;
  result := CreateAny();
  sysExcept := UNKNOWN.Create(0, CompletionStatus());
  sysExcept.encode_any(result);
end;

function TClientRequestInfoImpl._get_received_exception_id: TRepositoryId;
var
  uuExcept: IUnknownUserException;
begin
  if (FIcepOper <> RECEIVE_EXCEPTION) then
	  dorb_throw(BAD_INV_ORDER.Create(MinorRequestAlreadySent, CompletionStatus()));
  uuExcept := UnknownUserException.EXCEPTION_DOWNCAST(FException);
  if (uuExcept <> nil) then
    result :=  uuExcept.except_repoid()
  else
    result := FException.repoid();
end;

function TClientRequestInfoImpl._get_target: IORBObject;
begin
  result := FObject;
end;

class function TClientRequestInfoImpl._narrow(
  const obj: IORBObject): IClientRequestInfo;
var
  p: Pointer;
begin
  result := nil;
  if obj = nil then exit;
  p := obj.narrow_helper('IDL:omg.org/PortableInterceptor/ClientRequestInfo:1.0');
  if p <> nil then
    result := IClientRequestInfo(p)
end;

function TClientRequestInfoImpl.get_effective_component(
  const id: TComponentId): TTaggedComponent;
var
  prof: IIORProfile;
  enc: IEncoder;
  buf: IBuffer;
  ct: IORBComponent;
  comps: IMultiComponent;
begin
  if (FIcepOper = SEND_POLL) then
	  dorb_throw(BAD_INV_ORDER.Create(MinorRequestAlreadySent, CompletionStatus()));

  enc := GetEncoder(prof);
  if (prof = nil) then
    Exit;

  comps := prof.get_components() as IMultiComponent;
  ct := comps.get_component(id);
  if (ct = nil) then begin
    // there isn't such component in active profile
    // => we'll try to find multicomponent
    // profile
    (*if (MICO::Logger::IsLogged(MICO::Logger::PI))
        MICO::Logger::Stream(MICO::Logger::PI)
            << "component(id:" << __id << ") is not in active profile."
            << endl;*)
    prof := GetComponentsProfile();
    if (prof = nil) then
      dorb_throw(BAD_PARAM.Create(MinorInvalidComponentId, CompletionStatus()));
    (*if (MICO::Logger::IsLogged(MICO::Logger::PI))
        MICO::Logger::Stream(MICO::Logger::PI)
            << "Found MultiComponents profile" << endl;*)
    comps := prof.get_components() as IMultiComponent;
    ct := comps.get_component(id);
    if (ct = nil) then
      dorb_throw(BAD_PARAM.Create(MinorInvalidComponentId, CompletionStatus()));
    (*if (MICO::Logger::IsLogged(MICO::Logger::PI))
        MICO::Logger::Stream(MICO::Logger::PI)
            << "Found component(id:" << __id << ") in MC profile" << endl;*)
  end
  else begin
    (*if (MICO::Logger::IsLogged(MICO::Logger::PI))
        MICO::Logger::Stream(MICO::Logger::PI)
            << "Found component(id:" << __id << ") in active profile"
            << endl;*)
  end;
  ct.encode(enc);
  buf := enc.buffer();
  buf.RseekFromBegin(0);
  SetLength(result.component_data, buf.length());
  result.tag := ct._id;
  Move(PByteLargeArray(buf._buffer())^, Pointer(result.component_data)^, buf.length());
end;

function TClientRequestInfoImpl.get_effective_components(
  const id: TComponentId): TTaggedComponentSeq;
var
  prof: IIORProfile;
  enc: IEncoder;
  buf: IBuffer;
  ct: IORBComponent;
  comps: IMultiComponent;
  i, len: Integer;
begin
  if (FIcepOper = SEND_POLL) then
	  dorb_throw(BAD_INV_ORDER.Create(MinorRequestAlreadySent, CompletionStatus()));

  enc := GetEncoder(prof);
  if (prof = nil) then
    Exit;

  comps := prof.get_components() as IMultiComponent;
  len := 0;
  for i := 0 to comps.size - 1 do begin
    if (comps.get_component(i)._id() = id) then begin
        enc.buffer().WseekFromBegin(0);
        enc.buffer().RseekFromBegin(0);
        ct := comps.get_component(i);
        ct.encode(enc);
        SetLength(result, len + 1);
        result[len].tag := ct._id();
        buf := enc.buffer();
        SetLength(result[len].component_data, buf.length());
        Move(PByteLargeArray(buf._buffer())^, Pointer(result[len].component_data)^, buf.length());
        Inc(len);
    end;
  end;
  if Length(result) = 0 then
    dorb_throw(BAD_PARAM.Create(MinorInvalidComponentId, CompletionStatus()));
end;

function TClientRequestInfoImpl.get_request_policy(
  const _type: TPolicyType): IPolicy;
begin
  if (FIcepOper = SEND_POLL) then
	  dorb_throw(BAD_INV_ORDER.Create(MinorRequestAlreadySent, CompletionStatus()));
  try
    result := FObject.get_policy(_type);
  except
    dorb_throw(INV_POLICY.Create(MinorInvalidPolicyType, CompletionStatus()));
  end; { try/except }
end;

function TClientRequestInfoImpl.narrow_helper(const str: RepositoryId): Pointer;
begin
  if str = 'IDL:omg.org/PortableInterceptor/ClientRequestInfo:1.0' then
    begin
      result := Pointer(self as IClientRequestInfo);
      exit;
    end;
  result := inherited narrow_helper(str);
end;

class function TClientRequestInfoImpl.narrow_helper2(
  const obj: IORBObject): Boolean;
begin
  result := obj._repoid = 'IDL:omg.org/PortableInterceptor/ClientRequestInfo:1.0'
end;

procedure TClientRequestInfoImpl.add_request_service_context(
  const service_context: TServiceContext; const replace: boolean);
var
  len, i: Integer;
begin
  if (FIcepOper <> SEND_REQUEST) then
	  dorb_throw(BAD_INV_ORDER.Create(MinorInvalidPICall, CompletionStatus()));
  len := Length(FReqSCL^);
  {if len = 0 then
    dorb_throw(BAD_INV_ORDER.Create());}

  for i := 0 to len -1 do
    if (FReqSCL^[i].context_id = service_context.context_id) then begin
      if replace then
        FReqSCL^[i] := service_context
      else
        dorb_throw(BAD_INV_ORDER.Create(MinorServiceContextExists, CompletionStatus()));
      Exit;
    end;

  SetLength(FReqSCL^, len + 1);
  FReqSCL^[len] := service_context;
end;

constructor TClientRequestInfoImpl.Create(obj: IORBObject;
  const oper: AnsiString; const res: PNamedValue; req_id: _ulong;
  param_list: INVList; const exc_list: IExceptionList;
  const ctx_list: IContextList; ctx: IContext; resp: Boolean);
begin
  inherited Create();
  FObject := obj;
  FOperName := oper;
  if param_list <> nil then
    NVListToParameterList(FParamList, param_list, false);
  FExceptListDefined := exc_list <> nil;
  if FExceptListDefined then
    CorbaExceptListToDynExceptList(FExceptList, exc_list);
  FContextListOrig := ctx_list;
  if ctx_list <> nil then
    CorbaContextListToDynContextList(FContextList, ctx_list);
  CorbaContextToDynContext(FReqContext, ctx, obj);
  if res <> nil then
    FResult := res.argument;
  FResponse := resp;
end;

procedure TClientRequestInfoImpl.EffectiveTarget(const Obj: IORBObject);
begin
  FObject := Obj;
  FFwdObject := Obj;
end;

procedure TClientRequestInfoImpl.SetRequestServiceContextList(
  const AServiceContextList: PServiceContextList);
begin
  FReqSCL := AServiceContextList;
end;

procedure TClientRequestInfoImpl.OperationContext(
  const AContext: IContext);
begin
  CorbaContextToDynContext(FReqContext, AContext, FObject);
end;

procedure TClientRequestInfoImpl.SetReplyServiceContextList(
  const AServiceContextList: PServiceContextList);
begin
  FReplySCL := Copy(AServiceContextList^);
end;

procedure TClientRequestInfoImpl.SetExceptionsTypeCode(
  ExTC: array of ITypeCode);
var
  i, len: Integer;
begin
  len := Length(ExTC);
  SetLength(FExceptList, len);
  for i := 0 to len - 1 do
    FExceptList[i] := ExTc[i];
end;

{ TServerRequestInfoImpl }

function TServerRequestInfoImpl._get_adapter_id: TOctetSeq;
var
  id: ObjectId;
  len: Integer;
begin
  if (FIcepOper = RECEIVE_REQUEST_SERVICE_CONTEXTS) then
    dorb_throw(BAD_INV_ORDER.Create(MinorInvalidPICall, CompletionStatus()));
  if ((FIcepOper = SEND_EXCEPTION) or
     (FIcepOper = SEND_OTHER)) and
     ((FReplyStatus = LOCATION_FORWARD) or
     (FReplyStatus = LOCATION_FORWARD_PERMANENT)) then
    dorb_throw(NO_RESOURCES.Create());
  if (FObjectAdapter = nil) then
    Exit;
  id := FObjectAdapter.get_oaid();
  len := Length(id);
  if (len <> 0) then begin
    SetLength(result, len);
    Move(Pointer(id)^, Pointer(result)^, len);
  end;
end;

function TServerRequestInfoImpl._get_object_id: TOctetSeq;
begin
  if (FIcepOper = RECEIVE_REQUEST_SERVICE_CONTEXTS) then
    dorb_throw(BAD_INV_ORDER.Create(MinorInvalidPICall, CompletionStatus()));
  if ((FIcepOper = SEND_EXCEPTION) or
     (FIcepOper = SEND_OTHER)) and
     ((FReplyStatus = LOCATION_FORWARD) or
     (FReplyStatus = LOCATION_FORWARD_PERMANENT)) then
    dorb_throw(NO_RESOURCES.Create(MinorInvalidBinding, CompletionStatus()));
  SetLength(result, Length(FObjectId));
  Move(Pointer(FObjectId)^, Pointer(result)^, Length(FObjectId));
end;

function TServerRequestInfoImpl._get_sending_exception: IAny;
var
  sysExcept: ISystemException;
  uuExcept: IUnknownUserException;
  repoid: RepositoryId;
  tc: ITypeCode;
  i: Integer;
begin
  if (FIcepOper <> SEND_EXCEPTION) then
    dorb_throw(BAD_INV_ORDER.Create(MinorInvalidPICall, CompletionStatus()));
  if (FException = nil) then
    Exit;
  sysExcept := SystemException.EXCEPTION_DOWNCAST(FException);
  if (sysExcept <> nil) then begin
    result := CreateAny();
    sysExcept.encode_any(result);
    Exit;
  end;
  if (Length(FExceptList) > 0) then begin
    uuExcept := UnknownUserException.EXCEPTION_DOWNCAST(FException);
    if (uuExcept <> nil) then begin
      repoid := uuExcept.repoid();
      for i := 0 to Length(FExceptList) - 1 do begin
        tc := FExceptList[i];
        if repoid = tc.id() then begin
          result := uuExcept.exception(tc);
          Exit;
        end;
      end;
    end;
  end;
  result := CreateAny();
  FException.encode_any(result);
  //sysExcept := UNKNOWN.Create();
  //sysExcept.encode_any(result);
end;

function TServerRequestInfoImpl._get_target_most_derived_interface: TRepositoryId;
var
  oaid, oid: ObjectId;
  poa: IPOA;
  serv: IServant;
  //sc: Boolean;
begin
  if (FIcepOper = RECEIVE_REQUEST_SERVICE_CONTEXTS) or
     (FIcepOper = SEND_REPLY) then
    dorb_throw(BAD_INV_ORDER.Create(MinorInvalidPICall, CompletionStatus()));
  if ((FIcepOper = SEND_EXCEPTION) or
     (FIcepOper = SEND_OTHER)) and
     ((FReplyStatus = LOCATION_FORWARD) or
     (FReplyStatus = LOCATION_FORWARD_PERMANENT)) then
    dorb_throw(NO_RESOURCES.Create());
  if (FObjectAdapter = nil) then
    Exit;
  oaid := FObjectAdapter.get_oaid();
  if (oaid = '') then
    Exit;
  poa := FObjectAdapter as IPOA;
  oid := poa.reference_to_id(FObject);
  (*sc := true;
  try
    oid := poa.reference_to_id(FObject);
    serv := poa.id_to_servant(oid);
  except
    try
      serv := poa.get_servant();
    except
      sc := false;
    end; { try/except }
  end; { try/except }
  if not sc then
    // do something else
    dorb_throw(BAD_INV_ORDER.Create());*)
  try
    serv := POACurrent.get_serv;
  except
    dorb_throw(BAD_INV_ORDER.Create());
  end; { try/except }
  result := serv._primary_interface(oid, poa);
end;

class function TServerRequestInfoImpl._narrow(
  const obj: IORBObject): IServerRequestInfo;
var
  p: Pointer;
begin
  result := nil;
  if obj = nil then exit;
  p := obj.narrow_helper('IDL:omg.org/PortableInterceptor/ServerRequestInfo:1.0');
  if p <> nil then
    result := IServerRequestInfo(p)
end;

procedure TServerRequestInfoImpl.add_reply_service_context(
  const service_context: TServiceContext; const replace: boolean);
var
  len, i: Integer;
begin
  len := Length(FReplySCL);
  if len = 0 then
    dorb_throw(BAD_INV_ORDER.Create());
  for i := 0 to len - 1 do
    if FReplySCL[i].context_id = service_context.context_id then begin
      if replace then
        FReplySCL[i].context_data := service_context.context_data
      else
        dorb_throw(BAD_INV_ORDER.Create(MinorServiceContextExists, CompletionStatus()));
      Exit;
    end;
  SetLength(FReplySCL, len + 1);
  FReplySCL[len] := service_context;
end;

constructor TServerRequestInfoImpl.Create(obj: IORBObject; const oper: AnsiString; req_id: _ulong; resp: Boolean;
  const scl: PServiceContextList; const res: TNamedValue; param_list: INVList;
  const exc_list: IExceptionList; const ctx_list: IContextList; ctx: IContext);
begin
  inherited Create();
  FReqId := req_id;                
  FObject := obj;
  FOperName := oper;
  if param_list <> nil then
    NVListToParameterList(FParamList, param_list, false);
  FExceptListDefined := exc_list <> nil;
  if FExceptListDefined then
    CorbaExceptListToDynExceptList(FExceptList, exc_list);
  if ctx_list <> nil then
    CorbaContextListToDynContextList(FContextList, ctx_list);
  CorbaContextToDynContext(FReqContext, ctx, obj);
  FResult := res.argument;
  FResponse := resp;
  FSyncScope := SYNC_NONE;
  FReqSCL := scl;
end;

function TServerRequestInfoImpl.get_server_policy(
  const _type: TPolicyType): IPolicy;
begin
  if (PolicyFactoryMapVar.Item[_type] = nil) then
    dorb_throw(INV_POLICY.Create(MinorInvalidPolicyType, CompletionStatus()));
  if (FObjectAdapter = nil) then
    Exit;
  result := (FObjectAdapter as IPOA).get_policy(_type)
end;

function TServerRequestInfoImpl.narrow_helper(const str: RepositoryId): Pointer;
begin
  if str = 'IDL:omg.org/PortableInterceptor/ServerRequestInfo:1.0' then
    begin
      result := Pointer(self as IServerRequestInfo);
      exit;
    end;
  result := inherited narrow_helper(str);
end;

class function TServerRequestInfoImpl.narrow_helper2(
  const obj: IORBObject): Boolean;
begin
  result := obj._repoid = 'IDL:omg.org/PortableInterceptor/ServerRequestInfo:1.0'
end;

procedure TServerRequestInfoImpl.set_slot(const id: TSlotId;
  const data: IAny);
begin
  if (id >= TSlotId(Length(FSlots))) then
    dorb_throw(TInvalidSlot.Create());
  FSlots[id] := data;
end;

function TServerRequestInfoImpl.target_is_a(
  const id: TRepositoryId): boolean;
begin
  if (FIcepOper = RECEIVE_REQUEST_SERVICE_CONTEXTS) then
    dorb_throw(BAD_INV_ORDER.Create(MinorInvalidPICall, CompletionStatus()));
  if ((FIcepOper = SEND_EXCEPTION) or
     (FIcepOper = SEND_OTHER)) and
     ((FReplyStatus = LOCATION_FORWARD) or
     (FReplyStatus = LOCATION_FORWARD_PERMANENT)) then
    dorb_throw(NO_RESOURCES.Create());
  if (FObject = nil) then
    result := false
  else
    result := FObject._is_a(id);
end;

procedure TServerRequestInfoImpl.EffectiveTarget(const Obj: IORBObject);
begin
  FObject := Obj;
  FFwdObject := Obj;
end;

procedure TServerRequestInfoImpl.SetReplyServiceContextList(
  const AServiceContextList: PServiceContextList);
begin
  FReplySCL := Copy(AServiceContextList^);
end;

procedure TServerRequestInfoImpl.SetObjectAdapter(
  const AObjectAdapter: IObjectAdaptor);
begin
  FObjectAdapter := AObjectAdapter;
end;

procedure TServerRequestInfoImpl.OwnException(AOwn: Boolean);
begin
  FOwnException := AOwn;
end;

function TServerRequestInfoImpl.OwnException: Boolean;
begin
  result := FOwnException;
end;

procedure TServerRequestInfoImpl.SetExceptionsTypeCode(
  ExTC: array of ITypeCode);
var
  i, len: Integer;
begin
  len := Length(ExTC);
  SetLength(FExceptList, len);
  for i := 0 to len - 1 do
    FExceptList[i] := ExTc[i];
end;

procedure TServerRequestInfoImpl.Contexts(
  const AContextList: IContextList);
begin
  dorb_throw(NO_RESOURCES.Create(MinorInvalidBinding, CompletionStatus()));
end;

{ TIORInfoImpl }

procedure TIORInfoImpl.add_ior_component(const comp: TTaggedComponent);
var
  i: Integer;
begin
  i := 0;
  while (FIOR.profile(i) <> nil) do begin
    try
      add_ior_component_to_profile(comp, FIOR.profile(i).id);
    except

    end; { try/except }
    Inc(i);
  end; { while }
end;

procedure TIORInfoImpl.add_ior_component_to_profile(
  const comp: TTaggedComponent; const profile_id: TProfileId);
var
  prof: IIORProfile;
  mc: IMultiComponent;
  len, i: Integer;
  buf: IBuffer;
  dec: IDecoder;
  cmp: IORBComponent;
begin
  prof := FIOR.get_profile(profile_id, true);
  if (prof = nil) then
    dorb_throw(BAD_PARAM.Create());

  mc := prof.get_components() as IMultiComponent;
  if (mc = nil) then
    dorb_throw(BAD_PARAM.Create());

  len := Length(comp.component_data);
  buf := TBuffer.Create();
  for i := 0 to len - 1 do
    buf.put(comp.component_data[i]);

  Assert(FCodeSetCoder <> nil);
  dec := TDecoder.Create(buf, FCodeSetCoder);
  cmp := TORBComponent.decode_body(dec, comp.tag, len);
  (*if (MICO::Logger::IsLogged(MICO::Logger::PI)) {
      MICO::Logger::Stream(MICO::Logger::PI)
          << "added component into profile(" << __profile_id << "):" << endl;
      __cmp->print(MICO::Logger::Stream(MICO::Logger::PI));
  }*)
  if (cmp = nil) then
    dorb_throw(BAD_PARAM.Create());
  mc.add_component(cmp);
end;

constructor TIORInfoImpl.Create(poa: IPOA; ior: IIOR);
var
  version: _ushort;
  csid, wcsid: CodesetId;
  prof: IIORProfile;
begin
  inherited Create;
  FPOA := poa;
  FIOR := ior;
  version := $0100;
  if (FIOR <> nil) then begin
    prof := FIOR.get_profile(TAG_INTERNET_IOP);
    if prof <> nil then
      version := (prof as IIOPProfile).version;
  end;

  csid := TCodeset.special_cs(DefaultCS).id();
  wcsid := TCodeset.special_cs(DefaultWCS).id();

  if (version = $0100) then
      FCodeSetCoder := TGIOP_1_0_CodeSetCoder.Create()
  else if (version = $0101) then
      FCodeSetCoder := TGIOP_1_1_CodeSetCoder.Create(csid)
  else if (version >= $0102) then
      FCodeSetCoder := TGIOP_1_2_CodeSetCoder.Create(csid, wcsid);
end;

function TIORInfoImpl.get_effective_policy(
  const _type: TPolicyType): IPolicy;
begin
  try
    result := FPOA.get_policy(_type);
  except
    dorb_throw(INV_POLICY.Create());
  end; { try/except }
end;

{ TORBInitInfoImpl }

function TORBInitInfoImpl._get_arguments: TStringSeq;
begin
  result := FParam;
end;

function TORBInitInfoImpl._get_codec_factory: ICodecFactory;
begin
  result := TCodecFactoryImpl.Create();
end;

function TORBInitInfoImpl._get_orb_id: Identifier;
begin
  result := FORBId;
end;

procedure TORBInitInfoImpl.add_client_request_interceptor(
  const interceptor: IClientRequestInterceptor);
begin
  TPIManager.PIManager.ExecAddClientInterceptor(interceptor);
end;

procedure TORBInitInfoImpl.add_ior_interceptor(
  const interceptor: IIORInterceptor);
begin
  TPIManager.PIManager.ExecAddIorInterceptor(interceptor);
end;

procedure TORBInitInfoImpl.add_server_request_interceptor(
  const interceptor: IServerRequestInterceptor);
begin
  TPIManager.PIManager.ExecAddServerInterceptor(interceptor);
end;

function TORBInitInfoImpl.allocate_slot_id: TSlotId;
begin
  Result := MaxSlotId;
  Inc(MaxSlotId);
end;

procedure TORBInitInfoImpl.register_initial_reference(const id: TObjectId;
  const obj: IORBObject);
begin
  FORB.register_initial_reference(id, obj);
end;

procedure TORBInitInfoImpl.register_policy_factory(
  const _type: TPolicyType; const policy_factory: IPolicyFactory);
begin
  if PolicyFactoryMapVar.Item[_type] <> nil then
    dorb_throw(BAD_INV_ORDER.Create());
  PolicyFactoryMapVar.Item[_type] := policy_factory;
end;

function TORBInitInfoImpl.resolve_initial_references(
  const id: TObjectId): IORBObject;
begin
  if FORB <> nil then
    result := FORB.resolve_initial_reference(id)
  else
    dorb_throw(TInvalidName.Create());
end;

// ORB Init Info
// During initialization ORB_init goes through the list of ORBInitializers created
// by application, instantiates ORBInitInfo and calls pre_init() and
// post_init() methods of every ORBInitializer.
constructor TORBInitInfoImpl.Create(orb: IORB; const orb_id: RepositoryID; param: TStrings);
var
  i: Integer;
begin
  inherited Create();
  FORB := orb;
  FORBId := orb_id;
  if param <> nil then begin
    SetLength(FParam, param.Count);
    for i := 0 to param.Count - 1 do
      FParam[i] := AnsiString(param[i]);
  end;
end;

{ TPIManager }

constructor TPIManager.Create;
begin
  ClientPIStack := TStack.Create;
  ServerPIStack := TStack.Create;
  ClientReqInt := TInterfaceList.Create;
  ServerReqInt := TInterfaceList.Create;
  IORInterceptor := TInterfaceList.Create;
end;

class function TPIManager.CreateSRI(const obj: IORBObject;
  const opName: AnsiString; req_id: _ulong; resp: Boolean;
  const scl: PServiceContextList): IServerRequestInfo;
var
  res: TNamedValue;
begin
  Result := TServerRequestInfoImpl.Create(obj, opName, req_id, resp, scl, res);
end;

destructor TPIManager.Destroy;
begin
  FreeAndNil(ClientPIStack);
  FreeAndNil(ServerPIStack);
  ClientReqInt := nil;
  ClientReqInt := nil;
  IORInterceptor := nil;
  inherited;
end;

class procedure TPIManager.DestroyAllInterceptors;
begin
  IORInterceptor := nil;

  PolicyFactoryMapVar := nil;
  PIInitializers.Clear;
  FreeAndNil(PIManagerVar);
  FreeAndNil(ClientPIMutex);
  FreeAndNil(ServerPIMutex);
end;

procedure TPIManager.ExecAddClientInterceptor(interceptor: IClientRequestInterceptor);
var
  name: AnsiString;
  i: Integer;
begin
  name := interceptor.name;
  if name <> '' then begin
    // it's non-anonymous interceptor
    // so we have to check if it has unique name
    // as CORBA 2.6 (21.7.2.1) says
    for i := 0 to ClientReqInt.Count - 1 do begin
      if IClientRequestInterceptor(ClientReqInt[i]).name = name then
        dorb_throw(TDuplicateName.Create());
    end;
  end;
  ClientReqInt.Add(interceptor);
end;

procedure TPIManager.ExecAddIorInterceptor(interceptor: IIORInterceptor);
var
  name: AnsiString;
  i: Integer;
begin
  name := interceptor.name;
  if name <> '' then begin
    for i := 0 to IORInterceptor.Count - 1 do
      if IIORInterceptor(IORInterceptor[i]).name = name then
        dorb_throw(TDuplicateName.Create());
  end;
  IORInterceptor.Add(interceptor);
end;

procedure TPIManager.ExecAddServerInterceptor(interceptor: IServerRequestInterceptor);
var
  name: AnsiString;
  i: Integer;
begin
  name := interceptor.name;
  if name <> '' then begin
    // it's non-anonymous interceptor
    // so we have to check if it has unique name
    // as CORBA 2.6 (21.7.2.1) says
    for i := 0 to ServerReqInt.Count - 1 do begin
      if IServerRequestInterceptor(ServerReqInt[i]).name = name then
        dorb_throw(TDuplicateName.Create());
    end;
  end;
  ServerReqInt.Add(interceptor);
end;

procedure TPIManager.ExecClient(ri: IClientRequestInfo; method: TClientMethod;
  ip: TInterceptionPoint);
var
  sync: ISynchronized;
  cri: IClientRequestInterceptor;
  fl: TFlowStack;

  procedure ExecMethod(m: TClientMethod);
  begin
    case m of
      cmSendRequest: cri.send_request(ri);
      cmSendPoll: cri.send_poll(ri);
      cmReceiveReply: cri.receive_reply(ri);
      cmReceiveException: cri.receive_exception(ri);
      cmReceiveOther: cri.receive_other(ri);
    end;
  end;

begin
  sync := TSynchronized.Create(ClientPIMutex);

  case ip of
    ipStart: begin
      fl := TFlowStack.Create(ClientReqInt);
      ClientPIStack.Push(fl);
      while fl.StartIp.Count <> 0 do begin
        cri := IClientRequestInterceptor(fl.StartIp.Pop);
        ExecMethod(method);
        fl.EndIp.Push(cri);
      end;
    end;
    ipIntermediate: Assert(False); // incorect value for client side for CORBA 2.6.1 spec.
    ipEnd: begin
      fl := ClientPIStack.Peek;
      while fl.EndIp.Count <> 0 do begin
        cri := IClientRequestInterceptor(fl.EndIp.Pop);
        ExecMethod(method);
      end;
      ClientPIStack.Pop;
      fl.Free;
    end;
  end;
end;

procedure TPIManager.ExecEstablishComponents(info: IIORInfo);
var
  i: Integer;
begin
  for i := 0 to IORInterceptor.Count - 1 do
    try
      IIORInterceptor(IORInterceptor[i]).establish_components(info);
    except
      //consume
    end; { try/except }
end;

procedure TPIManager.ExecReceiveException(ri: IClientRequestInfo);
var
  riImpl: IClientRequestImpl;
  ex: ISystemException;
begin
  try
    ExecClient(ri, cmReceiveException, ipEnd);
  except
    on E: SystemException do begin
      riImpl := ri as IClientRequestImpl;
      riImpl.Exception(SystemException.Create(E));
      riImpl.ReplyStatus(SYSTEM_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecReceiveException(ri);
      raise;
    end;
    on E: TForwardRequest do begin
      riImpl := ri as IClientRequestImpl;
      riImpl.Exception(TForwardRequest.Create(E));
      riImpl.EffectiveTarget(E.forward());
      riImpl.ReplyStatus(LOCATION_FORWARD);
      riImpl.IceptOper(RECEIVE_OTHER);
      ExecReceiveOther(ri);
      raise;
    end;
    on E: UserException do begin
      riImpl := ri as IClientRequestImpl;
      riImpl.Exception(UserException.copy(E));
      riImpl.ReplyStatus(USER_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecReceiveException(ri);
      raise;
    end;
    else begin
      riImpl := ri as IClientRequestImpl;
      ex := UNKNOWN.Create(0, COMPLETED_NO);
      riImpl.Exception(ex);
      riImpl.ReplyStatus(SYSTEM_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecReceiveException(ri);
      dorb_throw(ex);
    end;
  end; { try/except }
end;

procedure TPIManager.ExecReceiveOther(ri: IClientRequestInfo);
var
  riImpl: IClientRequestImpl;
  ex: ISystemException;
begin
  try
    ExecClient(ri, cmReceiveOther, ipEnd);
  except
    on E: SystemException do begin
      riImpl := ri as IClientRequestImpl;
      riImpl.Exception(SystemException.Create(E));
      riImpl.ReplyStatus(SYSTEM_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecReceiveException(ri);
      raise;
    end;
    on E: TForwardRequest do begin
      riImpl := ri as IClientRequestImpl;
      riImpl.Exception(TForwardRequest.Create(E));
      riImpl.EffectiveTarget(E.forward());
      riImpl.ReplyStatus(LOCATION_FORWARD);
      riImpl.IceptOper(RECEIVE_OTHER);
      ExecReceiveOther(ri);
      raise;
    end;
    on E: UserException do begin
      riImpl := ri as IClientRequestImpl;
      riImpl.Exception(UserException.copy(E));
      riImpl.ReplyStatus(USER_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecReceiveException(ri);
      raise;
    end;
    else begin
      riImpl := ri as IClientRequestImpl;
      ex := UNKNOWN.Create(0, COMPLETED_NO);
      riImpl.Exception(ex);
      riImpl.ReplyStatus(SYSTEM_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecReceiveException(ri);
      dorb_throw(ex);
    end;
  end; { try/except }
end;

procedure TPIManager.ExecReceiveReply(ri: IClientRequestInfo);
var
  riImpl: IClientRequestImpl;
  ex: ISystemException;
begin
  try
    ExecClient(ri, cmReceiveReply, ipEnd);
  except
    on E: SystemException do begin
      riImpl := ri as IClientRequestImpl;
      riImpl.Exception(SystemException.Create(E));
      riImpl.ReplyStatus(SYSTEM_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecReceiveException(ri);
      raise;
    end;
    on E: UserException do begin
      riImpl := ri as IClientRequestImpl;
      riImpl.Exception(UserException.copy(E));
      riImpl.ReplyStatus(USER_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecReceiveException(ri);
      raise;
    end;
    else begin
      riImpl := ri as IClientRequestImpl;
      ex := UNKNOWN.Create(0, COMPLETED_NO);
      riImpl.Exception(ex);
      riImpl.ReplyStatus(SYSTEM_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecReceiveException(ri);
      dorb_throw(ex);
    end;
  end;
end;

procedure TPIManager.ExecReceiveRequest(ri: IServerRequestInfo);
var
  riImpl: IServerRequestImpl;
  ex: ISystemException;
begin
  try
    ExecServer(ri, smReceiveRequest, ipIntermediate);
  except
    on E: SystemException do begin
      riImpl := ri as IServerRequestImpl;
      riImpl.Exception(SystemException.Create(E));
      riImpl.ReplyStatus(SYSTEM_EXCEPTION);
      riImpl.IceptOper(SEND_EXCEPTION);
      ExecSendException(ri);
      raise;
    end;
    on E: TForwardRequest do begin
      riImpl := ri as IServerRequestImpl;
      riImpl.Exception(TForwardRequest.Create(E));
      riImpl.EffectiveTarget(E.forward());
      riImpl.ReplyStatus(LOCATION_FORWARD);
      riImpl.IceptOper(SEND_OTHER);
      ExecSendOther(ri);
      raise;
    end;
    on E: UserException do begin
      riImpl := ri as IServerRequestImpl;
      riImpl.Exception(UserException.copy(E));
      riImpl.ReplyStatus(USER_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecSendException(ri);
      raise;
    end;
    else begin
      riImpl := ri as IServerRequestImpl;
      ex := UNKNOWN.Create(0, COMPLETED_NO);
      riImpl.Exception(ex);
      riImpl.ReplyStatus(SYSTEM_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecSendException(ri);
      dorb_throw(ex);
    end;
  end; { try/except }
end;

procedure TPIManager.ExecReceiveRequestServiceContexts(ri: IServerRequestInfo);
var
  riImpl: IServerRequestImpl;
  ex: ISystemException;
begin
  try
    ExecServer(ri, smReceiveRequestServiceContexts, ipStart);
  except
    on E: SystemException do begin
      riImpl := ri as IServerRequestImpl;
      riImpl.Exception(SystemException.Create(E));
      riImpl.ReplyStatus(SYSTEM_EXCEPTION);
      riImpl.IceptOper(SEND_EXCEPTION);
      ExecSendException(ri);
      raise;
    end;
    on E: TForwardRequest do begin
      riImpl := ri as IServerRequestImpl;
      riImpl.Exception(TForwardRequest.Create(E));
      riImpl.EffectiveTarget(E.forward());
      riImpl.ReplyStatus(LOCATION_FORWARD);
      riImpl.IceptOper(SEND_OTHER);
      ExecSendOther(ri);
      raise;
    end;
    on E: UserException do begin
      riImpl := ri as IServerRequestImpl;
      riImpl.Exception(UserException.copy(E));
      riImpl.ReplyStatus(USER_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecSendException(ri);
      raise;
    end;
    else begin
      riImpl := ri as IServerRequestImpl;
      ex := UNKNOWN.Create(0, COMPLETED_NO);
      riImpl.Exception(ex);
      riImpl.ReplyStatus(SYSTEM_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecSendException(ri);
      dorb_throw(ex);
    end;
  end; { try/except }
end;

procedure TPIManager.ExecSendException(ri: IServerRequestInfo);
var
  riImpl: IServerRequestImpl;
  ex: ISystemException;
begin
  try
    ExecServer(ri, smSendException, ipEnd);
  except
    on E: SystemException do begin
      riImpl := ri as IServerRequestImpl;
      riImpl.Exception(SystemException.Create(E));
      riImpl.ReplyStatus(SYSTEM_EXCEPTION);
      riImpl.IceptOper(SEND_EXCEPTION);
      ExecSendException(ri);
      raise;
    end;
    on E: TForwardRequest do begin
      riImpl := ri as IServerRequestImpl;
      riImpl.Exception(TForwardRequest.Create(E));
      riImpl.EffectiveTarget(E.forward());
      riImpl.ReplyStatus(LOCATION_FORWARD);
      riImpl.IceptOper(SEND_OTHER);
      ExecSendOther(ri);
      raise;
    end;
    on E: UserException do begin
      riImpl := ri as IServerRequestImpl;
      riImpl.Exception(UserException.copy(E));
      riImpl.ReplyStatus(USER_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecSendException(ri);
      raise;
    end;
    else begin
      riImpl := ri as IServerRequestImpl;
      ex := UNKNOWN.Create(0, COMPLETED_NO);
      riImpl.Exception(ex);
      riImpl.ReplyStatus(SYSTEM_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecSendException(ri);
      dorb_throw(ex);
    end;
  end; { try/except }
end;

procedure TPIManager.ExecSendOther(ri: IServerRequestInfo);
var
  riImpl: IServerRequestImpl;
  ex: ISystemException;
begin
  try
    ExecServer(ri, smSendOther, ipEnd);
  except
    on E: SystemException do begin
      riImpl := ri as IServerRequestImpl;
      riImpl.Exception(SystemException.Create(E));
      riImpl.ReplyStatus(SYSTEM_EXCEPTION);
      riImpl.IceptOper(SEND_EXCEPTION);
      ExecSendException(ri);
      raise;
    end;
    on E: TForwardRequest do begin
      riImpl := ri as IServerRequestImpl;
      riImpl.Exception(TForwardRequest.Create(E));
      riImpl.EffectiveTarget(E.forward());
      riImpl.ReplyStatus(LOCATION_FORWARD);
      riImpl.IceptOper(SEND_OTHER);
      ExecSendOther(ri);
      raise;
    end;
    on E: UserException do begin
      riImpl := ri as IServerRequestImpl;
      riImpl.Exception(UserException.copy(E));
      riImpl.ReplyStatus(USER_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecSendException(ri);
      raise;
    end;
    else begin
      riImpl := ri as IServerRequestImpl;
      ex := UNKNOWN.Create(0, COMPLETED_NO);
      riImpl.Exception(ex);
      riImpl.ReplyStatus(SYSTEM_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecSendException(ri);
      dorb_throw(ex);
    end;
  end; { try/except }
end;

procedure TPIManager.ExecSendPoll(ri: IClientRequestInfo);
var
  riImpl: IClientRequestImpl;
  ex: ISystemException;
begin
  try
    ExecClient(ri, cmSendPoll, ipStart);
  except
    on E: SystemException do begin
      riImpl := ri as IClientRequestImpl;
      riImpl.Exception(SystemException.Create(E));
      riImpl.ReplyStatus(SYSTEM_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecReceiveException(ri);
      raise;
    end;
    on E: UserException do begin
      riImpl := ri as IClientRequestImpl;
      riImpl.Exception(UserException.copy(E));
      riImpl.ReplyStatus(USER_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecReceiveException(ri);
      raise;
    end;
    else begin
      riImpl := ri as IClientRequestImpl;
      ex := UNKNOWN.Create(0, COMPLETED_NO);
      riImpl.Exception(ex);
      riImpl.ReplyStatus(SYSTEM_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecReceiveException(ri);
      dorb_throw(ex);
    end;
  end;
end;

procedure TPIManager.ExecSendReply(ri: IServerRequestInfo);
var
  riImpl: IServerRequestImpl;
  ex: ISystemException;
begin
  try
    ExecServer(ri, smSendReply, ipEnd);
  except
    on E: SystemException do begin
      riImpl := ri as IServerRequestImpl;
      riImpl.Exception(SystemException.Create(E));
      riImpl.ReplyStatus(SYSTEM_EXCEPTION);
      riImpl.IceptOper(SEND_EXCEPTION);
      ExecSendException(ri);
      raise;
    end;
    on E: UserException do begin
      riImpl := ri as IServerRequestImpl;
      riImpl.Exception(UserException.copy(E));
      riImpl.ReplyStatus(USER_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecSendException(ri);
      raise;
    end;
    else begin
      riImpl := ri as IServerRequestImpl;
      ex := UNKNOWN.Create(0, COMPLETED_NO);
      riImpl.Exception(ex);
      riImpl.ReplyStatus(SYSTEM_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecSendException(ri);
      dorb_throw(ex);
    end;
  end;
end;

procedure TPIManager.ExecSendRequest(ri: IClientRequestInfo);
var
  riImpl: IClientRequestImpl;
  ex: ISystemException;
begin
  try
    ExecClient(ri, cmSendRequest, ipStart);
  except
    on E: SystemException do begin
      riImpl := ri as IClientRequestImpl;
      riImpl.Exception(SystemException.Create(E));
      riImpl.ReplyStatus(SYSTEM_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecReceiveException(ri);
      raise;
    end;
    on E: TForwardRequest do begin
      riImpl := ri as IClientRequestImpl;
      riImpl.Exception(TForwardRequest.Create(E));
      riImpl.EffectiveTarget(E.forward());
      riImpl.ReplyStatus(LOCATION_FORWARD);
      riImpl.IceptOper(RECEIVE_OTHER);
      ExecReceiveOther(ri);
      raise;
    end;
    on E: UserException do begin
      riImpl := ri as IClientRequestImpl;
      riImpl.Exception(UserException.copy(E));
      riImpl.ReplyStatus(USER_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecReceiveException(ri);
      raise;
    end;
    else begin
      riImpl := ri as IClientRequestImpl;
      ex := UNKNOWN.Create(0, COMPLETED_NO);
      riImpl.Exception(ex);
      riImpl.ReplyStatus(SYSTEM_EXCEPTION);
      riImpl.IceptOper(RECEIVE_EXCEPTION);
      ExecReceiveException(ri);
      dorb_throw(ex);
    end;
  end; { try/except }
end;

procedure TPIManager.ExecServer(ri: IServerRequestInfo; method: TServerMethod;
  ip: TInterceptionPoint);
var
  sync: ISynchronized;
  sri: IServerRequestInterceptor;
  fl: TFlowStack;
  i: Integer;

  procedure ExecMethod(m: TServerMethod);
  begin
    case m of
      smReceiveRequestServiceContexts: sri.receive_request_service_contexts(ri);
      smReceiveRequest: sri.receive_request(ri);
      smSendReply: sri.send_reply(ri);
      smSendException: sri.send_exception(ri);
      smSendOther: sri.send_other(ri);
    end;
  end;

begin
  sync := TSynchronized.Create(ServerPIMutex);

  case ip of
    ipStart: begin
      fl := TFlowStack.Create(ServerReqInt);
      ServerPIStack.Push(fl);
      while fl.StartIp.Count <> 0 do begin
        sri := IServerRequestInterceptor(fl.StartIp.Pop);
        ExecMethod(method);
        fl.EndIp.Push(sri);
      end;
    end;
    ipIntermediate: begin
      for i := 0 to ServerReqInt.Count - 1 do begin
        sri := IServerRequestInterceptor(ServerReqInt[i]);
        ExecMethod(method);
      end;
    end;
    ipEnd: begin
      fl := ServerPIStack.Peek;
      while fl.EndIp.Count <> 0 do begin
        sri := IServerRequestInterceptor(fl.EndIp.Pop);
        ExecMethod(method);
      end;
      ServerPIStack.Pop;
      fl.Free;
    end;
  end;
end;

class procedure TPIManager.Init;
begin
  PolicyFactoryMapVar := long_interface_map;
  ClientPIMutex := TRecursiveMutex.Create;
  ServerPIMutex := TRecursiveMutex.Create;
  PIManagerVar := TPIManager.Create;
  IORInterceptor := TInterfaceList.Create;
end;

class function TPIManager.Initializers: IInterfaceList;
begin
  result := PIInitializers;
end;

class function TPIManager.PIManager: TPIManager;
begin
  result := PIManagerVar;
end;

function TPIManager.PolicyFactoryMap: ILongInterfaceMap;
begin
  Result := PolicyFactoryMapVar;
end;

procedure TPIManager.ReceiveRequestServiceContextsIp(const sri: IServerRequestInfo;
  const AServiceContextList: PServiceContextList; const oa: IObjectAdaptor);
var
  srImpl: IServerRequestImpl;
  slots: AnySeq;
begin
  if sri <> nil then begin
    srImpl := sri as IServerRequestImpl;
    srImpl.SetReplyServiceContextList(AServiceContextList);
    srImpl.IceptOper(RECEIVE_REQUEST_SERVICE_CONTEXTS);
    srImpl.SetObjectAdapter(oa);
    SetLength(slots, MaxSlotId);
    srImpl.Slots(slots);
    ExecReceiveRequestServiceContexts(sri);
  end;
end;

class procedure TPIManager.RegisterOrbInitializer(
  const AInit: IORBInitializer);
begin
  PIInitializers.Add(AInit);
end;

function TPIManager.Slots: AnySeq;
begin

end;

{ TFlowStack }

constructor TFlowStack.Create(const AList: IInterfaceList);
var
  i: Integer;
begin
  FStartIp := interface_stack();
  FEndIp := interface_stack();
  for i := 0 to AList.Count - 1 do
    FStartIp.Push(AList[i]);
end;

function TFlowStack.EndIp: IInterfaceStack;
begin
  result := FEndIp;
end;

function TFlowStack.StartIp: IInterfaceStack;
begin
  result := FStartIp;
end;

initialization
  PIInitializers := TInterfaceList.Create;
finalization
  PIInitializers := nil;
{$ELSE}
implementation
{$ENDIF}
end.
