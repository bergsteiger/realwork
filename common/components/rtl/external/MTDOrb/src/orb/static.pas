// **********************************************************************
//
// Copyright (c) 2001 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
{**
        Implementation of StaticRequest, StaticAny and StaticServerRequest.
 }
unit static;

interface

uses
  orb,orb_int,exceptions,orbtypes,code_int,Classes,SysUtils,req_int,
  req,env_int,except_int,pi_int;

{$IFNDEF USELIB}

type

  TStaticRequest = class(TORBRequest,IStaticRequest,IORBRequest)
  private
    //FORBMessageID : ORBMessageID;
    FObject : IORBObject;
    FResult : IStaticAny;
    FIsExcept: Boolean;
    FArguments : IStaticAnyList;
    FContext : IContext;
    FContextList: IContextList;
    FEnvironment: IEnvironment;
    //FContextList : IInterfaceList;
    FIceptReq: IORBObject;
    FPIClientReqInfo: IClientRequestInfo;
  protected
    procedure Invoke();
    procedure add_in_arg(const any: IStaticAny);
    procedure add_inout_arg(const any: IStaticAny);
    procedure add_out_arg(const any: IStaticAny);
    function req_type(): AnsiString;
    procedure set_result(const any: IStaticAny);
    function get_in_args(const enc: IEncoder): Boolean; overload;
    function get_in_args(const list : INVList; out ctx: IContext): Boolean; overload; virtual;
    function get_in_args(const list : IStaticAnyList; out ctx: IContext): Boolean; overload; virtual;
    function get_out_args(const enc: IEncoder;out is_except: Boolean): Boolean; overload;
    function get_out_args(const res: IStaticAny; const list: IStaticAnyList; out ex: IORBException): Boolean; overload;
    function get_out_args(const res: IAny; const list: INVList; out ex: IORBException): Boolean; overload;
    function set_out_args(const dec: IDecoder; const exception : Boolean): Boolean; overload;
    function set_out_args(const res: IStaticAny; const list: IStaticAnyList): Boolean; overload;
    function set_out_args(const res: IAny; const list: INVList): Boolean; overload;
    function set_out_args(const ex: IORBException): Boolean; overload;
    function copy_out_args(const req: IORBRequest): Boolean;
    function get_exception(): IORBException;
    procedure set_exception(const ex: IORBException);
    procedure set_exceptions_tc(exTC: array of ITypeCode);
    function get_environment(): IEnvironment;
    function copy(dest,src: IInterfaceList; flags: _ulong): Boolean;
    procedure oneway();
  public
    constructor Create(const obj: IORBObject; op : AnsiString);
    destructor Destroy(); override;
  end;

  TStaticTypeInfo = class
    class function demarshal(dec: IDecoder;var val : IORBObject): Boolean;
  end;

  TStaticAny = class(TORBObject,IStaticAny)
  private
   FInfo : IStaticTypeInfo;
   FVal,FDummy : Pointer;
   FFlags : _ulong;
   FDoFree: Boolean;
  protected
    function demarshal(dec: IDecoder): Boolean;
    function marshal(enc: IEncoder): Boolean;
    procedure set_flags(val: _ulong);
    function get_flags(): _ulong;
    function value(): Pointer; overload;
    procedure value(const info: IStaticTypeInfo;const addr : Pointer = nil; free : Boolean = false); overload;
    function _type(): IStaticTypeInfo;
    procedure _assign(const val: IStaticAny);
  public
    constructor Create(info : IStaticTypeInfo;const addr : Pointer = nil);
    constructor Create_static(const s: IStaticAny);
    destructor Destroy(); override;
  end;

  TStaticServerRequest = class(TInterfacedObject,IStaticServerRequest,IServerRequestBase)
  private
    FArgs: IStaticAnyList;
    FReq: IORBRequest;
    FObject: IORBObject;
    FORBid: ORBMessageID;
    FAdaptor: IObjectAdaptor;
    FResult : IStaticAny;
    FContext: IContext;
    FEnvironment: IEnvironment;
    FIceptReq: IORBObject;
    FAborted: boolean;
  protected
    procedure add_in_arg(const any: IStaticAny);
    procedure add_out_arg(const any: IStaticAny);
    procedure add_inout_arg(const any: IStaticAny);
    function read_args(): Boolean;
    function op_name: AnsiString;
    procedure write_results();
    procedure set_result(const any: IStaticAny);
    procedure set_exception(const ex: IORBException);
    function environment: IEnvironment;
    procedure set_exceptions_tc(exTC: array of ITypeCode);
  public
    constructor Create(const req: IORBRequest; const obj: IORBObject; id: ORBMessageID;
      const oa: IObjectAdaptor; pr: IPrincipal);
    destructor Destroy(); override;
  end;

   function StaticRequest(const obj: IORBObject; op : AnsiString): IStaticRequest;
   function StaticAny(info : IStaticTypeInfo;const addr : Pointer = nil): IStaticAny;
   function StaticAny_static(const s: IStaticAny): IStaticAny;
   function StaticServerRequest(const req: IORBRequest; const obj: IORBObject; id: ORBMessageID;
      const oa: IObjectAdaptor; pr: IPrincipal): IStaticServerRequest;  

implementation

uses
  ior,iior_int,env,poa,poa_int,any,intercept,intercept_int,throw,pi_impl,mtdebug,
  pi;

//*********************************************************************
// TStaticRequest
//*********************************************************************
constructor TStaticRequest.Create(const obj: IORBObject; op : AnsiString);
begin
  if obj._IOR = nil then
    dorb_throw(st_NO_IMPLEMENT);
  FObject := obj;
  FOperation := op;
  FArguments := TStaticAnyList.Create;
  //ClientInterceptor
  FIceptReq := TClientInterceptor._create_request(FObject, op, context(), nil);
  //PI ClientInterceptor
  FPIClientReqInfo := TClientRequestInfoImpl.Create(FObject, FOperation);
end;

destructor TStaticRequest.Destroy;
begin
  FArguments := nil;
end;

function TStaticRequest.set_out_args(const ex: IORBException): Boolean;
begin
  result := true;
  set_exception(ex.clone);
end;

function TStaticRequest.get_out_args(const res: IStaticAny; const list: IStaticAnyList; out ex: IORBException): Boolean;
var
  e: IORBException;
begin
  result := false;
  ex := get_exception();
  if ex <> nil then
    begin
      ex := e.clone;
      result := true;
      exit;
    end;
  if list.Count <> FArguments.Count then
    exit;
  if (FResult <> nil) and (res <> nil) then
    res._assign(FResult);
end;

function TStaticRequest.set_out_args(const res: IAny;
  const list: INVList): Boolean;
var
 val: TNamedValue;
 i : integer;
begin
  result := false;
  if FArguments.Count <> list.count then exit;
  if assigned(res) and assigned(FResult) then
    begin
      if not res.to_static_any(FResult) then exit;
    end;
  for i := 0 to pred(list.count) do
    begin
      val := list.item(i);
      if val.flags <> FArguments.Items[i].get_flags then exit;
      if FArguments.Items[i].get_flags in [ARG_OUT,ARG_INOUT] then
        begin
          if not val.argument.to_static_any(FArguments.Items[i]) then exit;
        end;
    end;
  result := true;
end;

function TStaticRequest.get_out_args(const res: IAny; const list: INVList; out ex: IORBException): Boolean;
var
  e: IORBException;
begin
  result := false;
  ex := get_exception();
  if ex <> nil then
    begin
      ex := e.clone;
      result := true;
      exit;
    end;
  if list.Count <> FArguments.Count then
    exit;
  if (FResult <> nil) and (res <> nil) then
    res.from_static_any(FResult);
end;


function TStaticRequest.copy(dest,src: IInterfaceList; flags: _ulong): Boolean;
var
  dst_count,src_count,d,s,n,m: integer;
  dst_any,src_any: IStaticAny;
begin
  result := false;
  dst_count := dest.Count;
  src_count := src.count;
  d := 0;
  s := 0;
  while true do
    begin
      dst_any := nil;
      n := d;
      while n < dst_count do
        begin
          dst_any := IStaticAny(dest[n]);
          if (dst_any.get_flags() and flags) <> 0 then
            break;
          inc(n);
        end;
      src_any := nil;
      m := s;
      while m < src_count do
        begin
          src_any := IStaticAny(src[m]);
          if (src_any.get_flags() and flags) <> 0 then
            break;
          inc(m);  
        end;
      if (m >= src_count) or (n>= dst_count) then
        begin
          if not ((m >= src_count) and (n>= dst_count)) then
            exit;
          break;
        end;
      d:= n+1;
      s:= m+1;
      if not (src_any.get_flags and flags = dst_any.get_flags and flags) then
        exit;
      dst_any._assign(src_any);
    end;
  result := true;
end;

function TStaticRequest.get_environment(): IEnvironment;
begin
  if FEnvironment = nil then
    FEnvironment := TEnvironment.Create;
  result := FEnvironment;
end;

function TStaticRequest.get_exception(): IORBException;
begin
  result := nil;
  if FEnvironment <> nil then
    result := FEnvironment.get_exception;
end;

procedure TStaticRequest.set_exception(const ex: IORBException);
begin
  if FEnvironment = nil then
    FEnvironment := TEnvironment.Create;
  FEnvironment.set_exception(ex);
end;

procedure TStaticRequest.set_exceptions_tc(exTC: array of ITypeCode);
var
  cri: IClientRequestImpl;
  len: Integer;
begin
  len := Length(exTc);
  if len <> 0 then begin
    cri := FPIClientReqInfo as IClientRequestImpl;
    cri.SetExceptionsTypeCode(exTC);
  end;
end;

function TStaticRequest.req_type(): AnsiString;
begin
  result := 'static';
end;

procedure TStaticRequest.add_in_arg(const any: IStaticAny);
begin
  FArguments.Add(any);
  any.set_flags(ARG_IN);
end;

procedure TStaticRequest.add_inout_arg(const any: IStaticAny);
begin
  FArguments.Add(any);
  any.set_flags(ARG_INOUT);
end;

procedure TStaticRequest.add_out_arg(const any: IStaticAny);
begin
  FArguments.Add(any);
  any.set_flags(ARG_OUT);
end;

function TStaticRequest.copy_out_args(const req: IORBRequest): Boolean;
var
  ex: IORBException;
begin
  result := true;
  if req = IORBRequest(self) then
    Exit
  else begin
    // copy service context list
    copy_servcntx(req);
    if not req.get_out_args(FResult,FArguments,ex) then begin
      result := false;
      Exit;
    end;
    if ex <> nil then
      set_exception(ex);
  end;
end;

procedure TStaticRequest.oneway();
var
  orb : IORB;
  cri: IClientRequestImpl;
  id: ORBMessageID;
  msgid: MessageID;
  piCur: IInterface;
begin
  orb := FObject._ORB;
  //ClientInterceptor
  if (FIceptReq <> nil) and not TClientInterceptor._exec_initialize_request(FIceptReq as ILWRequest, get_environment()) then begin
    Exit;
  end;

  msgid := orb.new_MessageID();
  id := orb.new_orbid(msgid);

  cri := FPIClientReqInfo as IClientRequestImpl;
  piCur := FObject._orb.resolve_initial_reference('PICurrent');
  cri.ResponseExpected(false);
  cri.IceptOper(SEND_REQUEST);
  cri.SyncScope(SYNC_WITH_TRANSPORT);
  cri.Arguments(FArguments, false);
  cri.RequestId(msgid);
  cri.Contexts(FContextList);
  cri.OperationContext(FContext);
  cri.SetRequestServiceContextList(context());
  cri.Slots((piCur as IPICurrentImpl).Slots());
  TPIManager.PIManager.ExecSendRequest(FPIClientReqInfo); // start point

  id := FObject._orb.invoke_async(FObject,self,nil,false,nil,id);

  if (id <> nil) and id.responce() then begin
    MTDORBLogger.Error('static.pas hack pi....');
    cri.Exception(OBJECT_NOT_EXIST.Create());
    cri.IceptOper(RECEIVE_EXCEPTION);
    cri.ReplyStatus(SYSTEM_EXCEPTION);
    TPIManager.PIManager.ExecReceiveException(FPIClientReqInfo); // end point
  end
  else begin
    cri.IceptOper(RECEIVE_OTHER);
    TPIManager.PIManager.ExecReceiveOther(FPIClientReqInfo); // end point
  end;

  //ClientInterceptor
  if (FIceptReq <> nil) then
    TClientInterceptor._exec_after_marshal(FIceptReq as ILWRequest, FEnvironment);
end;

procedure TStaticRequest.Invoke();
var
  orb : IORB;
  done: Boolean;
  ist : TInvokeStatus;
  req: IORBRequest;
  obj : IORBObject;
  sysex : ISystemException;
  FORBMessageID : ORBMessageID;
  ad: AddressingDisposition;
  cri: IClientRequestImpl;
  tc: ITypeCode;
  res: IAny;
  piCur: IInterface;
begin
  orb := FObject._ORB;
  done := false;

  FORBMessageID := orb.new_orbid();
  // here the point for PI "send_request()"
  // set request_id = _msgid, arguments = _args, response_expected = TRUE,
  // sync_scope = SYNC_NONE, etc.

  cri := FPIClientReqInfo as IClientRequestImpl;
  piCur := FObject._orb.resolve_initial_reference('PICurrent');
  cri.RequestId(orb.get_msgid(FORBMessageID));
  // we need to set contexts before seting operation_context!
  // because right value of operation_context is computed with help
  // of contexts!
  cri.IceptOper(SEND_REQUEST);
  cri.SyncScope(SYNC_NONE);
  cri.Arguments(FArguments, false);
  cri.Contexts(FContextList);
  cri.OperationContext(FContext);
  cri.SetRequestServiceContextList(context());
  cri.Slots((piCur as IPICurrentImpl).Slots());
  TPIManager.PIManager.ExecSendRequest(FPIClientReqInfo); // start point

  //ClientInterceptor
  if (FIceptReq <> nil) and not TClientInterceptor._exec_initialize_request(FIceptReq as ILWRequest, get_environment()) then begin
    Exit;
  end;

  FORBMessageID := orb.invoke_async(FObject, Self, get_environment().principal, true, nil, FORBMessageID);

  //ClientInterceptor
  if (FIceptReq <> nil) and not TClientInterceptor._exec_after_marshal(FIceptReq as ILWRequest, FEnvironment) then begin
    orb.cancel(FORBMessageID);
    Exit;
  end;

  while (not done) do begin
    if not orb.wait(FORBMessageID,-1(* $FFFF*)) then
      Break;
    {if orb.wait(FORBMessageID,-1(* $FFFF*)) then begin
      set_out_args(NO_RESPONSE.Create());
      orb.answer_invoke(FORBMessageID, InvokeSysEx, nil, req, ad);
    end;}
    // XXX called multiple times in case of Forward
    //ClientInterceptor
    if (FIceptReq <> nil) and not TClientInterceptor._exec_before_unmarshal(FIceptReq as ILWRequest, FEnvironment) then begin
      orb.cancel(FORBMessageID);
      Exit;
    end;
    ist := orb.get_invoke_reply(FORBMessageID, obj, req, ad);
    case ist of
      InvokeOk: begin
        // receive reply
        cri.ReplyStatus(SUCCESSFUL);
        cri.SetReplyServiceContextList(req.context());
        if FResult <> nil then begin
          tc := FResult._type().typecode();
          if (tc <> nil) and (tc.kind <> tk_void) and (tc.kind <> tk_null) then begin
            res := CreateAny();
            res.from_static_any(FResult);
            cri.Result(res);
          end;
        end;
        cri.Arguments(FArguments, true);
        cri.IceptOper(RECEIVE_REPLY);
        TPIManager.PIManager.ExecReceiveReply(FPIClientReqInfo); // end point
        done := true;
      end;
      InvokeUserEx: begin
        // receive_exception (user exception)
        cri.Exception(get_exception());
        cri.ReplyStatus(USER_EXCEPTION);
        cri.IceptOper(RECEIVE_EXCEPTION);
        cri.SetReplyServiceContextList(req.context());
        TPIManager.PIManager.ExecReceiveException(FPIClientReqInfo); // end point
        done := true;
      end;
      InvokeForward: begin
        // receive other
        cri.ReplyStatus(LOCATION_FORWARD);
        cri.IceptOper(RECEIVE_OTHER);
        cri.SetReplyServiceContextList(req.context());
        FObject._forward(obj);
        cri.EffectiveTarget(FObject);
        TPIManager.PIManager.ExecReceiveOther(FPIClientReqInfo); // end point
        FORBMessageID := orb.new_orbid();
        FPIClientReqInfo := TClientRequestInfoImpl.Create(FObject, FOperation, nil, orb.get_msgid(FORBMessageID));
        cri := FPIClientReqInfo as IClientRequestImpl;
        cri.IceptOper(SEND_REQUEST);
        cri.SyncScope(SYNC_NONE);
        cri.Arguments(FArguments, false);
        cri.Contexts(FContextList);
        cri.OperationContext(FContext);
        cri.SetRequestServiceContextList(context());
        cri.Slots((piCur as IPICurrentImpl).Slots());
        TPIManager.PIManager.ExecSendRequest(FPIClientReqInfo); // another start point
        FORBMessageID := orb.invoke_async(FObject, self, FEnvironment.principal, true, nil, FORBMessageID);
      end;
      InvokeAddrDisp: begin
        // receive other
        FObject.fwd_ior.addressing_disposition(ad);
        cri.ReplyStatus(TRANSPORT_RETRY);
        cri.IceptOper(RECEIVE_OTHER);
        cri.SetReplyServiceContextList(req.context());
        TPIManager.PIManager.ExecReceiveOther(FPIClientReqInfo); // end point
        FORBMessageID := orb.new_orbid();
        FPIClientReqInfo := TClientRequestInfoImpl.Create(FObject, FOperation, nil, orb.get_msgid(FORBMessageID));
        cri := FPIClientReqInfo as IClientRequestImpl;
        cri.IceptOper(SEND_REQUEST);
        cri.SyncScope(SYNC_NONE);
        cri.Arguments(FArguments, false);
        cri.Contexts(FContextList);
        cri.OperationContext(FContext);
        cri.SetRequestServiceContextList(context());
        cri.Slots((piCur as IPICurrentImpl).Slots());
        TPIManager.PIManager.ExecSendRequest(FPIClientReqInfo); // another start point
        FORBMessageID := orb.invoke_async(FObject, self, FEnvironment.principal, true, nil, FORBMessageID);
      end;
      InvokeSysEx: begin
        // receive_exception (system exception)
        cri.Exception(get_exception());
        cri.ReplyStatus(SYSTEM_EXCEPTION);
        cri.IceptOper(RECEIVE_EXCEPTION);
        cri.SetReplyServiceContextList(req.context());
        TPIManager.PIManager.ExecReceiveException(FPIClientReqInfo); // end point
        if FObject.is_forwarded then begin
          sysex := SystemException.EXCEPTION_DOWNCAST(get_exception);
          assert(sysex<>nil);
          if (sysex.completed = COMPLETED_NO) and
            (sysex.extype in [st_COMM_FAILURE,st_TRANSIENT,st_OBJECT_NOT_EXIST]) then
          begin
            FObject._unforward;
            FEnvironment.clear;
            FORBMessageID := orb.new_orbid();
            FPIClientReqInfo := TClientRequestInfoImpl.Create(FObject, FOperation, nil, orb.get_msgid(FORBMessageID));
            cri := FPIClientReqInfo as IClientRequestImpl;
            cri.IceptOper(SEND_REQUEST);
            cri.SyncScope(SYNC_NONE);
            cri.Arguments(FArguments, false);
            cri.Contexts(FContextList);
            cri.OperationContext(FContext);
            cri.SetRequestServiceContextList(context());
            cri.Slots((piCur as IPICurrentImpl).Slots());
            TPIManager.PIManager.ExecSendRequest(FPIClientReqInfo); // another start point
            FORBMessageID := orb.invoke_async(FObject,self,FEnvironment.principal,true,nil,FORBMessageID);
            Continue;
          end;
        end;
        done := true;
      end;
      else
        done := true;
    end;
  end;
  //ClientInterceptor
  if (FIceptReq <> nil) then
    TClientInterceptor._exec_finish_request(FIceptReq as ILWRequest, FEnvironment);
  FORBMessageID := nil;
end;

procedure TStaticRequest.set_result(const any: IStaticAny);
begin
  FResult := any;
end;

function TStaticRequest.get_in_args(const enc: IEncoder): Boolean;
var
  i : integer;
begin
  if FArguments.Count = 0 then
    begin
      result := true;
      exit;
    end;
  for i := 0 to pred(FArguments.Count) do
    with IStaticAny(FArguments[i]) do
      if (get_flags() in [ARG_IN,ARG_INOUT]) and not marshal(enc) then
        begin
          result := false;
          { TODO -oOVS : Release INOUT params }
          exit;
        end;
  result := true;
end;

function TStaticRequest.set_out_args(const res: IStaticAny; const list: IStaticAnyList): Boolean;
begin
  if (FResult <> nil) and (res <> nil) then
    FResult._assign(res);
  result := copy(FArguments,list,ARG_OUT or ARG_INOUT);
end;

function TStaticRequest.get_in_args(const list : INVList; out ctx: IContext): Boolean;
var
  val: TNamedValue;
  i : integer;
begin
  result := false;
  if FArguments.Count <> list.Count then
    exit;
  for i := 0 to Pred(FArguments.Count) do
    begin
      val:= list.item(i);
      if val.flags <> FArguments[i].get_flags then
        exit;
      if (FArguments[i].get_flags and (ARG_IN or ARG_INOUT)) <> 0 then
        val.argument.from_static_any(FArguments[i]);
    end;
  ctx := FContext;
  result := true;
end;

function TStaticRequest.get_in_args(const list : IStaticAnyList; out ctx: IContext): Boolean;
begin
  result := false;
  if not copy(list,FArguments,ARG_IN or ARG_INOUT) then exit;
  FContext := ctx;
  result := true;
end;

function TStaticRequest.get_out_args(const enc: IEncoder; out is_except: Boolean): Boolean;
var
  ex: IORBException;
  i : integer;
begin
  result := false;
  FIsExcept := False;
  ex := get_exception();
  if (ex = nil) and (FResult = nil) and (FArguments.Count = 0) then
    begin
      result := true;
      exit;
    end;
  if ex <> nil then
    begin
      FIsExcept := true;
      ex.encode(enc);
      result := true;
      exit;
    end;
  if (FResult <> nil) and not FResult.marshal(enc) then
    exit;
  for i := 0 to Pred(FArguments.Count) do
    with IStaticAny(FArguments[i]) do
      if (get_flags() in [ARG_OUT,ARG_INOUT]) and not marshal(enc) then
          exit;
  result := true;
end;

function TStaticRequest.set_out_args(const dec: IDecoder; const exception : Boolean): Boolean;
var
  ex: IORBException;
  i : integer;
  se: ISystemException;
begin
  result := false;
  if exception then
    begin
      ex := ORBException.decode(dec);
      set_exception(ex);
      //set remote flag
      se := SystemException.EXCEPTION_DOWNCAST(ex);
      if se <> nil then
        se.set_remote(true);
    end
  else
    begin
      if FResult <> nil then
         begin
           result := FResult.demarshal(dec);
           if not result then exit;
         end;
      for i := 0 to Pred(FArguments.Count) do
        with IStaticAny(FArguments[i]) do
          if (get_flags() in [ARG_OUT,ARG_INOUT]) and not demarshal(dec) then
            exit;
    end;
  result := true;
end;

//******************************************************
//  TStaticAny
//******************************************************
constructor TStaticAny.Create(info : IStaticTypeInfo; const addr : Pointer);
begin
  FDummy := nil;
  FInfo := info;
  if addr = nil then
    FVal := @FDummy
  else
    FVal := addr;
  FFlags := 0;
  FDoFree := false;
end;

constructor TStaticAny.Create_static(const s: IStaticAny);
begin
  FInfo := s._type;
  FVal := s._type.copy(s.value);
end;

destructor TStaticAny.Destroy;
begin
  if FDoFree and (FVal <> nil) then
    FInfo._free(FVal);
end;

procedure TStaticAny._assign(const val: IStaticAny);
var
  p : Pointer;
begin
  if FVal = @FDummy then
    begin
      FInfo._create(FVal);
      FDoFree := True;
    end;
  if val.value<>nil then
    FInfo._assign(FVal,val.value)
  else
    begin
      FInfo._create(p);
      FInfo._assign(FVal,p);
      FInfo._free(p);
    end;
end;

function TStaticAny.marshal(enc: IEncoder): Boolean;
begin
  if FVal = @FDummy then
    begin
      FInfo._create(FVal);
      FDoFree := True;
    end;
  FInfo.marshal(enc,Fval);
  result := true;
end;

function TStaticAny._type(): IStaticTypeInfo;
begin
  result := FInfo;
end;

function TStaticAny.demarshal(dec: IDecoder): Boolean;
begin
  if FVal = @FDummy then
    begin
      FInfo._create(FVal);
      FDoFree := True;
    end;
  result := FInfo.demarshal(dec,Fval);
end;

procedure TStaticAny.set_flags(val: _ulong);
begin
  FFlags := val;
end;

function TStaticAny.get_flags(): _ulong;
begin
  result := FFlags;
end;

function TStaticAny.value(): Pointer;
begin
  result := FVal;
  //FVal := nil;
end;

procedure TStaticAny.value(const info: IStaticTypeInfo;
  const addr: Pointer; free: Boolean);
begin
  if FDoFree and (FVal <> nil) then
    FInfo._free(FVal);
  FInfo := info;
  if addr = nil then
    FVal := @FDummy
  else
    FVal := addr;
  //FFlags := 0;
  FDoFree := free;
end;

//****************************************************************************
//  TStaticTypeInfo
//*****************************************************************************
class function TStaticTypeInfo.demarshal(dec: IDecoder;var val : IORBObject): Boolean;
var
  ior : IIOR;
begin
  result := false;
  ior := TIOR.Create;
  if not ior.decode(dec) then exit;
  val := orb.ORB_Instance.ior_to_object(ior);
  result := true;
end;

//****************************************************************************
//  TStaticServerRequest
//*****************************************************************************
constructor TStaticServerRequest.Create(const req: IORBRequest; const obj: IORBObject; id: ORBMessageID;
      const oa: IObjectAdaptor; pr: IPrincipal);
begin
  inherited Create;
  FArgs := TStaticAnyList.Create;
  FReq:= req;
  FEnvironment := TEnvironment.Create(pr);
  FObject:= obj;
  FORBid:= id;
  FAdaptor:= oa;
  FResult := nil;
  FAborted := false;
  //ServerIntercept
  FIceptReq := TServerInterceptor._create_request(FObject, req.op_name(), req.context(), nil);
end;

destructor TStaticServerRequest.Destroy;
var
  stat : TInvokeStatus;
  sri: IServerRequestImpl;
begin
  stat := InvokeOK;
  if FEnvironment.get_exception <> nil then
    begin
      if SystemException.EXCEPTION_DOWNCAST(FEnvironment.get_exception) <> nil then
        stat := InvokeSysEx
      else
        stat := InvokeUserEx;
    end;
  if (FORBid <> nil) then begin
    sri := FORBid.request_info as IServerRequestImpl;
    sri.Exception(FEnvironment.get_exception());
  end;
  FAdaptor.answer_invoke(FORBid,FObject,FReq,stat);
  //ServerIntercept
  if (FIceptReq <> nil) and not FAborted and not (TServerInterceptor._exec_finish_request(FIceptReq as ILWServerRequest, FEnvironment)) then begin
    // XXX how to abort request here ??
  end;
  FEnvironment := nil;
  FIceptReq := nil;
  FArgs := nil;
  inherited Destroy();
end;

procedure TStaticServerRequest.set_exception(const ex: IORBException);
begin
  if FEnvironment = nil then
    FEnvironment := TEnvironment.Create;
  FEnvironment.set_exception(ex);
end;

procedure TStaticServerRequest.add_in_arg(const any: IStaticAny);
begin
  any.set_flags(orbtypes.ARG_IN);
  FArgs.Add(any);
end;

procedure TStaticServerRequest.set_result(const any: IStaticAny);
begin
  FResult := any;
end;

procedure TStaticServerRequest.write_results();
var
  sri: IServerRequestImpl;
  tc: ITypeCode;
  res: IAny;
begin
  // clear service context list
  SetLength(FReq.context^, 0);
  //ServerIntercept
  if (FIceptReq <> nil) and not (FAborted) and not (TServerInterceptor._exec_before_marshal(FIceptReq as ILWServerRequest, FEnvironment)) then begin
    FAborted := true;
  end;
  if FEnvironment = nil then
    FEnvironment := TEnvironment.Create;
  if FEnvironment.get_exception <> nil then
    FReq.set_out_args(FEnvironment.get_exception)
  else begin
    if (FORBid <> nil) then
      sri := FORBid.request_info as IServerRequestImpl;
    if (FResult <> nil) then begin
      tc := FResult._type().typecode();
      if (tc <> nil) and (tc.kind <> tk_void) and (tc.kind <> tk_null) then begin
        res := CreateAny();
        res.from_static_any(FResult);
        sri.Result(res);
      end;
    end;
    sri.Arguments(FArgs, true);
    if not FReq.set_out_args(FResult, FArgs) then begin
      MTDORBLogger.Error('Error: cannot set out args in StaticServerRequest');
      FReq.set_out_args(MARSHAL.Create(0, COMPLETED_YES))
    end;
  end;
end;

procedure TStaticServerRequest.add_inout_arg(const any: IStaticAny);
begin
  any.set_flags(orbtypes.ARG_INOUT);
  FArgs.Add(any);
end;

procedure TStaticServerRequest.add_out_arg(const any: IStaticAny);
begin
  any.set_flags(orbtypes.ARG_OUT);
  FArgs.Add(any);
end;

function TStaticServerRequest.read_args: Boolean;
var
  sri: IServerRequestImpl;
  orb: IORB;
  piCur: IInterface;
begin
  //ServerIntercept
  if (FIceptReq <> nil) and not (TServerInterceptor._exec_initialize_request(FIceptReq as ILWServerRequest, FEnvironment)) then begin
    FAborted := true;
    result := false;
    write_results();
    Exit;
  end;
  result := FReq.get_in_args(FArgs,FContext);
  if not result then begin
    FAborted := true;
    set_exception(MARSHAL.Create(0, COMPLETED_NO));
    write_results ();
    Exit;
  end;
  //ServerIntercept
  if (FIceptReq <> nil) and not (TServerInterceptor._exec_after_unmarshal(FIceptReq as ILWServerRequest, FEnvironment)) then begin
    FAborted := true;
    result := false;
    write_results();
  end;
  if FORBid = nil then
    Exit;
  orb := FObject._orb;
  sri := FORBid.request_info as IServerRequestImpl;
  piCur := FObject._orb.resolve_initial_reference('PICurrent');
  sri.Arguments(FArgs, false);
  sri.IceptOper(RECEIVE_REQUEST);
  sri.OperationContext(FContext);
  sri.SetObjectAdapter(FAdaptor);
  sri.EffectiveTarget(FObject);
  (piCur as IPICurrentImpl).Slots(sri.Slots());
  // point of receive_request call
  try
    TPIManager.PIManager.ExecReceiveRequest(sri as IServerRequestInfo);
  except
    on E: SystemException do begin
      set_exception(SystemException.Create(E));
      FAborted := true;
      write_results();
      result := false;
    end;
    on E: TForwardRequest do begin
      FObject := E.forward();
      orb.answer_invoke(FORBid, InvokeForward, FObject, FReq, 0);
    end;
    on E: UserException do begin
      set_exception(UserException.copy(E));
      FAborted := true;
      write_results();
      result := false;
    end;
    else begin
      set_exception(UNKNOWN.Create(0, COMPLETED_NO));
      FAborted := true;
      write_results();
      result := false;
    end;
  end; { try/except }
end;

function TStaticServerRequest.op_name: AnsiString;
begin
  result := FReq.op_name;
end;

function TStaticServerRequest.environment: IEnvironment;
begin
  Result := FEnvironment
end;

procedure TStaticServerRequest.set_exceptions_tc(exTC: array of ITypeCode);
var
  sri: IServerRequestImpl;
begin
  if (FORBid <> nil) then begin
    sri := FORBid.request_info as IServerRequestImpl;
    sri.SetExceptionsTypeCode(exTC);
  end;
end;

//*********************************************************************
function StaticRequest(const obj: IORBObject; op : AnsiString): IStaticRequest;
begin
  result := TStaticRequest.Create(obj,op)
end;

function StaticAny(info : IStaticTypeInfo;const addr : Pointer = nil): IStaticAny;
begin
  result := TStaticAny.Create(info,addr)
end;

function StaticAny_static(const s: IStaticAny): IStaticAny;
begin
  result := TStaticAny.Create_static(s)
end;

function StaticServerRequest(const req: IORBRequest; const obj: IORBObject; id: ORBMessageID;
      const oa: IObjectAdaptor; pr: IPrincipal): IStaticServerRequest;
begin
  result := TStaticServerRequest.Create(req,obj,id,oa,pr)
end;

{$IFDEF LIBRARY}
exports
  StaticRequest,
  StaticAny,
  StaticAny_static,
  StaticServerRequest;
{$ENDIF}
{$ELSE}
   function StaticRequest(const obj: IORBObject; op : string): IStaticRequest; external MTDORB_Library_Name;
   function StaticAny(info : IStaticTypeInfo;const addr : Pointer = nil): IStaticAny; external MTDORB_Library_Name;
   function StaticAny_static(const s: IStaticAny): IStaticAny; external MTDORB_Library_Name;
   function StaticServerRequest(const req: IORBRequest; const obj: IORBObject; id: ORBMessageID;
     const oa: IObjectAdaptor; pr: IPrincipal): IStaticServerRequest; external MTDORB_Library_Name;
implementation
{$ENDIF}
end.
