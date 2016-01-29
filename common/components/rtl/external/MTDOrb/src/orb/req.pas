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
unit req;

interface

uses
  orb_int,orbtypes,req_int,code_int,Classes,except_int,env_int,pi_int;

{$IFNDEF USELIB}

type

  {** Implements org.omg.CORBA.Request }
  TRequest = class(TInterfacedObject,IRequest,IORBCallback)
  private
    FOperation : AnsiString;
    FObject : IORBObject;
    FMID: ORBMessageID;
    FContext : IContext;
    FContextList: IContextList;
    FResult : TNamedValue;
    FEnvironment : IEnvironment;
    FArguments : INVList;
    FCallback : IRequestCallback;
    FRequest: IORBRequest;
    FIceptReq: IORBObject;
    // PI client interceptor request info
    FPIClientReqInfo: IClientRequestInfo;
    FFlags : _ulong;
    FInvokePending: Boolean;
    FInvokeFlag: Boolean;
    FEList: IExceptionList;
  protected
    function waitfor(const orb: IORB; id: ORBMessageID; event: TORBCallbackEvent; tmout: Longint = -1): boolean;
    procedure notify(const orb: IORB; id: ORBMessageID; event: TORBCallbackEvent);
    //procedure callback(const orb: IORB; mid: MessageID; event: TORBCallbackEvent);
    function add_in_arg(const name: AnsiString): IAny;
    function add_inout_arg(const name: AnsiString): IAny;
    function add_out_arg(const name: AnsiString): IAny;
    function get_arguments(): INVList;
    function get_environment(): IEnvironment;
    function get_exceptions(): IInterfaceList;
    function get_context(): IContext;
    function get_contexts(): IContextList;
    procedure invoke();
    function operation(): AnsiString;
    function return_value: IAny;
    procedure set_context(const ctx: IContext);
    procedure set_result(const any: IStaticAny);
    procedure set_return_type(const tc: ITypeCode);
    function get_result(): TNamedValue;
    function get_target(): IORBObject;
    procedure decode_user_exception();

    procedure get_response(block: Boolean = true);
    function poll_response(): Boolean;
    procedure send_oneway();
    procedure send_deferred(const cb: IRequestCallBack = nil);
  public
    constructor Create(const obj : IORBObject; const c : IContext; op: AnsiString;
      arguments: INVList; res: TNamedValue; flags: _ulong); overload;
    constructor Create(const obj : IORBObject; op: AnsiString); overload;
  end;

  TORBRequest = class(TInterfacedObject)
  protected
    FOperation : AnsiString;
    FServCnts: ServiceContextList;
  protected
    function context(): PServiceContextList;
    procedure set_context(const ctx: PServiceContextList);
    function op_name(): AnsiString; virtual;
    procedure set_out_args_ex(const ex: IORBException); virtual;
    procedure copy_servcntx(r: IORBRequest);
  end;

  TLocalRequest = class(TORBRequest,IORBRequest)
  private
    FResult : TNamedValue;
    FRequest: IRequest;
    FHaveResult: Boolean;
    FHaveException : Boolean;
  protected
    procedure add_in_arg(const any: IStaticAny);
    procedure add_inout_arg(const any: IStaticAny);
    procedure add_out_arg(const any: IStaticAny);
    function copy_out_args(const req: IORBRequest): Boolean;
    function get_in_args(const enc: IEncoder): Boolean; overload;
    function get_in_args(const list : INVList; out ctx: IContext): Boolean; overload;
    function get_in_args(const list : IStaticAnyList; out ctx: IContext): Boolean; overload;
    function get_out_args(const enc: IEncoder; out is_except: Boolean): Boolean; overload;
    function get_out_args(const res: IAny; const list: INVList; out ex: IORBException): Boolean; overload;
    function get_out_args(const res: IStaticAny; const list: IStaticAnyList; out ex: IORBException): Boolean; overload;
    procedure invoke();
    function op_name(): AnsiString; override;
    function req_type(): AnsiString;
    procedure set_result(const any: IStaticAny);
    function set_out_args(const dec: IDecoder; const exception : Boolean): Boolean; overload;
    function set_out_args(const res: IStaticAny; const list: IStaticAnyList): Boolean;  overload;
    function set_out_args(const ex: IORBException): Boolean; overload;
    function set_out_args(const res: IAny; const list: INVList): Boolean; overload;
  public
    constructor Create_req(const req: IRequest);
  end;

  TServerRequest = class(TInterfacedObject,IServerRequestBase,IServerRequest)
  private
    FArguments: INVList;
    FReq: IORBRequest;
    FObject: IORBObject;
    FMid: ORBMessageID;
    FAdaptor: IObjectAdaptor;
    FResult : IAny;
    FEnvironment : IEnvironment;
    FContext: IContext;
    FAborted : Boolean;
    FIceptReq: IORBObject;
    FCanceled : Boolean;
    function environment: IEnvironment;
  protected
    procedure set_exception(const exc: IORBException);
    function operation: AnsiString;
    function arguments(const lst: INVList): Boolean;
    procedure set_result(const any: IAny);
    function ctx: IContext;
    procedure set_out_args();
  public
    constructor Create(const req: IORBRequest; const obj: IORBObject; mid: ORBMessageID;
      const oa: IObjectAdaptor; pr: IPrincipal);
    destructor Destroy(); override;
  end;

  function CreateRequest(const obj : IORBObject; op: AnsiString): IRequest;
  function CreateRequest_arg(const obj : IORBObject; const c : IContext; op: AnsiString;
    arguments: INVList; res: TNamedValue; flags: _ulong): IRequest;
  function ServerRequest(const req: IORBRequest; const obj: IORBObject; mid: ORBMessageID;
    const oa: IObjectAdaptor; pr: IPrincipal): IServerRequest;

implementation

uses
  env,exceptions,intercept_int,intercept,throw,pi_impl,pi;

//**************************************************************
// TRequest
//**************************************************************
constructor TRequest.Create(const obj : IORBObject; op: AnsiString);
var
  orb: IORB;
begin
  if (obj = nil) or (op = '') then
    dorb_throw(BAD_PARAM.Create() as IORBException);
  if obj._ior = nil then
    dorb_throw(NO_IMPLEMENT.Create() as IORBException);
  FObject := obj;
  FOperation := op;
  FContext := nil;
  orb := FObject._orb;
  FResult := orb.create_named_value;
  orb.create_list(0,FArguments);
  FEnvironment := orb.create_environment;
  FRequest := TLocalRequest.Create_req(self);
  //WJ: Workaround - we have no access to FRequest from outside, so RefCount is always >0
  //and Request will never be released
  Self._Release;
  //ClientInterceptor
  FIceptReq := TClientInterceptor._create_request(FObject, FRequest.op_name(), FRequest.context(), Self);
  //PI ClientInterceptor
  FPIClientReqInfo := TClientRequestInfoImpl.Create(FObject, FOperation, @FResult, 0, FArguments, FEList, FContextList, FContext, true);
  FCallback := nil;
  FFlags := 0;
end;

constructor TRequest.Create(const obj : IORBObject; const c : IContext; op: AnsiString;
      arguments: INVList; res: TNamedValue; flags: _ulong);
var
  orb: IORB;
begin
  if (obj = nil) or (op = '') then
    dorb_throw(BAD_PARAM.Create() as IORBException);
  if obj._ior = nil then
    dorb_throw(NO_IMPLEMENT.Create() as IORBException);
  FObject := obj;
  FContext := c;
  FArguments := arguments;
  FResult := res;
  FFlags := flags;
  FOperation := op;
  orb := obj._orb;
  if FArguments = nil then
    orb.create_list(0,FArguments);
  if FResult.argument = nil then
    FResult := orb.create_named_value;
  FEnvironment := orb.create_environment;
  FRequest := TLocalRequest.Create_req(self);
  //WJ: Workaround - we have no access to FRequest from outside, so RefCount is always >0
  //and Request will never be released
  Self._Release;
  //ClientInterceptor
  FIceptReq := TClientInterceptor._create_request(FObject, FRequest.op_name(), FRequest.context(), Self);
  //PI ClientInterceptor
  FPIClientReqInfo := TClientRequestInfoImpl.Create(FObject, FOperation, @FResult, 0, FArguments, FEList, FContextList, FContext, true);
  FCallback := nil;
end;

function TRequest.get_environment(): IEnvironment;
begin
  result := FEnvironment;
end;

procedure TRequest.notify(const orb: IORB; id: ORBMessageID;
  event: TORBCallbackEvent);
begin
  assert(event = _Invoke);
  if FCallback <> nil then
    begin
      FCallback.callback(self);
      FCallback := nil;
    end;
end;

function TRequest.operation: AnsiString;
begin
  result := FOperation
end;

procedure TRequest.decode_user_exception();
var
  ex: IORBException;
  knownException: Boolean;
  uuex: IUnknownUserException;
  repoid: RepositoryId;
  tc: ITypeCode;
  i: Integer;
begin
  knownException := false;
  ex := FEnvironment.get_exception;
  { TODO -oOVS -cException list : Remove next lines after implement exception list in ORB }
  if ex = nil then
    Exit;
  Assert(FEList <> nil);
  if (ex <> nil) and (FEList.count > 0) then begin
    uuex := UnknownUserException.EXCEPTION_DOWNCAST(ex);
    if (uuex <> nil) then begin
      // decode UnknownUserException using ExceptionList ...
      repoid := uuex.except_repoid();
      for i := 0 to FEList.count - 1 do begin
        tc := FEList.item(i);
        if (repoid = tc.id()) then begin
          uuex.exception(tc);
          knownException := true;
          Break;
        end;
      end;
    end;
  end;

  if (ex <> nil) and not knownException then begin
    // oops, unknown exception
    ex := SystemException.Create_type(st_UNKNOWN, MinorUnknownUserException, COMPLETED_MAYBE);
    FEnvironment.set_exception(ex);
  end;
end;

function TRequest.get_arguments(): INVList;
begin
  result := FArguments;
end;

function TRequest.add_in_arg(const name: AnsiString): IAny;
begin
  result := FArguments.add_item(name,ARG_IN).argument
end;

function TRequest.add_inout_arg(const name: AnsiString): IAny;
begin
  result := FArguments.add_item(name,ARG_INOUT).argument
end;

function TRequest.add_out_arg(const name: AnsiString): IAny;
begin
  result := FArguments.add_item(name,ARG_OUT).argument
end;

function TRequest.get_context: IContext;
begin
  result := FContext
end;

function TRequest.get_contexts: IContextList;
begin
  assert(false,'not implemented');
end;

function TRequest.get_exceptions: IInterfaceList;
begin
  assert(false,'not implemented');
end;

function TRequest.get_result: TNamedValue;
begin
  result := FResult;
end;

function TRequest.get_target: IORBObject;
begin
  result := FObject
end;

procedure TRequest.invoke;
begin
  FInvokeFlag := true;
  try
    send_deferred;
    get_response;
  finally
    FInvokeFlag := false;
  end; { try/finally }
end;

function TRequest.return_value: IAny;
begin
  Result := FResult.argument
end;

procedure TRequest.set_context(const ctx: IContext);
begin
  FContext := ctx
end;

procedure TRequest.set_result(const any: IStaticAny);
begin
  assert(false,'not implemented');
end;

procedure TRequest.set_return_type(const tc: ITypeCode);
begin
  FResult.argument.set_type(tc)
end;

procedure TRequest.get_response(block: Boolean);
var
  orb : IORB;
  rs: TInvokeStatus;
  obj : IORBObject;
  req: IORBRequest;
  s : ISystemException;
  ad: AddressingDisposition;
  cri: IClientRequestImpl;
  piCur: IInterface;
begin
  if not FInvokePending then exit;
  orb := FObject._orb;
  rs := InvokeOK;
  while FInvokePending do begin
    if block then
      orb.wait(FMid)
    else if not orb.wait(FMid,0) then
      exit;
    if not TClientInterceptor._exec_before_unmarshal(FIceptReq as ILWRequest,FEnvironment) then begin
      orb.cancel(Fmid);
      FInvokePending := false;
      if FCallback <> nil then FCallback.callback(self);
      FCallback := nil;
      exit;
    end;

    rs := orb.get_invoke_reply(FMid, obj, req, ad);

    piCur := FObject._orb.resolve_initial_reference('PICurrent');
    cri := FPIClientReqInfo as IClientRequestImpl;

    case rs of
      InvokeOK: begin
        cri.ReplyStatus(SUCCESSFUL);
        cri.SetReplyServiceContextList(req.context());
        cri.Result(FResult.argument);
        cri.Arguments(FArguments, true);
        cri.IceptOper(RECEIVE_REPLY);
        TPIManager.PIManager.ExecReceiveReply(FPIClientReqInfo);
        FInvokePending := false;
        //break;
      end;
      InvokeForward: begin
        cri.ReplyStatus(LOCATION_FORWARD);
        cri.IceptOper(RECEIVE_OTHER);
        cri.SetReplyServiceContextList(req.context());
        FObject._forward(obj);
        cri.EffectiveTarget(FObject);
        cri.Slots((piCur as IPICurrentImpl).Slots());
        TPIManager.PIManager.ExecReceiveOther(FPIClientReqInfo); // end point

        FMid := orb.new_orbid();
        FPIClientReqInfo := TClientRequestInfoImpl.Create(FObject, FOperation, @FResult, orb.get_msgid(FMid), FArguments, FEList, FContextList, FContext, true);
        cri := FPIClientReqInfo as IClientRequestImpl;
        cri.IceptOper(SEND_REQUEST);
        cri.SyncScope(SYNC_NONE);
        cri.SetRequestServiceContextList(FRequest.context());
        TPIManager.PIManager.ExecSendRequest(FPIClientReqInfo); // another start point

        FMid := orb.invoke_async(FObject,FRequest,nil,true);
        //break;
      end;
      InvokeSysEx: begin
        cri.Exception(FEnvironment.get_exception().clone());
        cri.ReplyStatus(SYSTEM_EXCEPTION);
        cri.IceptOper(RECEIVE_EXCEPTION);
        cri.SetReplyServiceContextList(req.context());
        TPIManager.PIManager.ExecReceiveException(FPIClientReqInfo); // end point
        if FObject.is_forwarded then begin
          s := SystemException.EXCEPTION_DOWNCAST(FEnvironment.get_exception);
          if (s.completed = COMPLETED_NO)
            and (s.extype in [st_COMM_FAILURE,st_TRANSIENT,st_OBJECT_NOT_EXIST])
            //Closes error 800832
            and not (s.minor = MinorConnectFailed) then begin
            FObject._unforward;
            FEnvironment.clear;
            FMid := orb.new_orbid();
            FPIClientReqInfo := TClientRequestInfoImpl.Create(FObject, FOperation, @FResult, orb.get_msgid(FMid), FArguments, FEList, FContextList, FContext, true);
            cri := FPIClientReqInfo as IClientRequestImpl;
            cri.IceptOper(SEND_REQUEST);
            cri.SyncScope(SYNC_NONE);
            cri.SetRequestServiceContextList(FRequest.context());
            cri.Slots((piCur as IPICurrentImpl).Slots());
            // another start point
            TPIManager.PIManager.ExecSendRequest(FPIClientReqInfo);
            FMid := orb.invoke_async(FObject,FRequest,nil,true);
            Continue;
            //break;
          end
        end;
        FInvokePending := false;
        //break;
      end;
      InvokeUserEx: begin
        decode_user_exception();
        cri.Exception(FEnvironment.get_exception().clone());
        cri.ReplyStatus(USER_EXCEPTION);
        cri.IceptOper(RECEIVE_EXCEPTION);
        cri.SetReplyServiceContextList(req.context());
        TPIManager.PIManager.ExecReceiveException(FPIClientReqInfo); // end point
        FInvokePending := false;
        //break;
      end;
      InvokeAddrDisp: begin
        FObject.fwd_ior().addressing_disposition(ad);
        cri.ReplyStatus(TRANSPORT_RETRY);
        cri.IceptOper(RECEIVE_OTHER);
        cri.SetReplyServiceContextList(req.context());
        TPIManager.PIManager.ExecReceiveOther(FPIClientReqInfo); // end point
        FMid := orb.new_orbid();
        FPIClientReqInfo := TClientRequestInfoImpl.Create(FObject, FOperation, @FResult, orb.get_msgid(FMid), FArguments, FEList, FContextList, FContext, true);
        cri := FPIClientReqInfo as IClientRequestImpl;
        cri.IceptOper(SEND_REQUEST);
        cri.SyncScope(SYNC_NONE);
        cri.SetRequestServiceContextList(FRequest.context());
        cri.Slots((piCur as IPICurrentImpl).Slots());
        TPIManager.PIManager.ExecSendRequest(FPIClientReqInfo); // another start point
        FMid := orb.invoke_async(FObject, FRequest, nil, true, nil, FMid);
        //break;
      end;
    end;
  end;
  if not TClientInterceptor._exec_finish_request(FIceptReq as ILWRequest,FEnvironment) then begin
    FCallback := nil;
    exit;
  end;
  FCallback := nil;
  if not FInvokePending and (rs = InvokeSysEx) then
    FEnvironment.get_exception.throw;
end;

function TRequest.poll_response: Boolean;
var
  cri: IClientRequestImpl;
  piCur: IInterface;
begin
  piCur := FObject._orb.resolve_initial_reference('PICurrent');
  cri := FPIClientReqInfo as IClientRequestImpl;
  cri.RequestId(FObject._orb.get_msgid(FMid));
  cri.IceptOper(SEND_POLL);
  cri.SyncScope(SYNC_NONE);
  cri.Slots((piCur as IPICurrentImpl).Slots());
  TPIManager.PIManager.ExecSendPoll(FPIClientReqInfo); // start point
  get_response(false);
  result := not FInvokePending;
end;

procedure TRequest.send_deferred(const cb: IRequestCallBack);
var
  orb: IORB;
  cri: IClientRequestImpl;
  piCur: IInterface;
begin
  FCallback := cb;
  if not TClientInterceptor._exec_initialize_request(FIceptReq as ILWRequest,FEnvironment) then
    begin
      if FCallback <> nil then
        FCallback.callback(self);
      FCallback := nil;
      exit;
    end;
  FInvokePending := true;
  orb := FObject._orb;
  FMid := orb.new_orbid;

  piCur := orb.resolve_initial_reference('PICurrent');
  cri := FPIClientReqInfo as IClientRequestImpl;
  cri.RequestId(orb.get_msgid(Fmid));
  cri.IceptOper(SEND_REQUEST);
  cri.SyncScope(SYNC_NONE);
  cri.Arguments(FArguments, false);
  cri.Contexts(FContextList);
  cri.SetRequestServiceContextList(FRequest.context());
  cri.OperationContext(FContext);
  cri.Slots((piCur as IPICurrentImpl).Slots());
  TPIManager.PIManager.ExecSendRequest(FPIClientReqInfo); // start point

  if assigned(FCallback) then
    orb.invoke_async(FObject,FRequest,nil,true,self,Fmid)
  else
    orb.invoke_async(FObject,FRequest,nil,true,nil,Fmid);
  if not FInvokeFlag then begin // send_deferred from client, not from invoke()
    cri.IceptOper(RECEIVE_OTHER);
    TPIManager.PIManager.ExecReceiveOther(FPIClientReqInfo);
  end;

  if FInvokePending and not TClientInterceptor._exec_after_marshal(FIceptReq as ILWRequest,FEnvironment) then
    begin
      orb.cancel(Fmid);
      FInvokePending := false;
      if FCallback <> nil then
        FCallback.callback(self);
      FCallback := nil;
    end;
end;

procedure TRequest.send_oneway;
var
  cri: IClientRequestImpl;
  msgId: ORBMessageID;
  piCur: IInterface;
begin
  if not TClientInterceptor._exec_initialize_request(FIceptReq as ILWRequest,FEnvironment) then
      exit;

  piCur := FObject._orb.resolve_initial_reference('PICurrent');
  cri := FPIClientReqInfo as IClientRequestImpl;
  cri.ResponseExpected(false);
  cri.IceptOper(SEND_REQUEST);
  cri.SyncScope(SYNC_WITH_TRANSPORT);
  cri.Arguments(FArguments, false);
  cri.Contexts(FContextList);
  cri.SetRequestServiceContextList(FRequest.context());
  cri.OperationContext(FContext);
  cri.Slots((piCur as IPICurrentImpl).Slots());
  TPIManager.PIManager.ExecSendRequest(FPIClientReqInfo); // start point

  msgId := FObject._orb.invoke_async(FObject,FRequest,nil,false);

  if msgId <> nil then begin
    cri.Exception(OBJECT_NOT_EXIST.Create());
    cri.IceptOper(RECEIVE_EXCEPTION);
    cri.ReplyStatus(SYSTEM_EXCEPTION);
    TPIManager.PIManager.ExecReceiveException(FPIClientReqInfo); // end point
  end
  else begin
    cri.IceptOper(RECEIVE_OTHER);
    TPIManager.PIManager.ExecReceiveOther(FPIClientReqInfo); // end point
  end;

  TClientInterceptor._exec_after_marshal(FIceptReq as ILWRequest,FEnvironment)
end;

//********************************************************************
// TORBRequest
//********************************************************************
function TORBRequest.context: PServiceContextList;
begin
  result := @FServCnts;
end;

procedure TORBRequest.copy_servcntx(r: IORBRequest);
begin
  FServCnts := r.context()^;
end;

function TORBRequest.op_name(): AnsiString;
begin
  result := FOperation;
end;

procedure TORBRequest.set_context(const ctx: PServiceContextList);
begin
  FServCnts := ctx^;
end;

procedure TORBRequest.set_out_args_ex(const ex: IORBException);
begin
  assert(false,'not implemented');
end;

//********************************************************************
// TLocalRequest
//********************************************************************
procedure TLocalRequest.add_in_arg(const any: IStaticAny);
begin
  assert(false,'not imlplemented');
end;

procedure TLocalRequest.add_out_arg(const any: IStaticAny);
begin
  assert(false,'not imlplemented');
end;

procedure TLocalRequest.add_inout_arg(const any: IStaticAny);
begin
  assert(false,'not imlplemented');
end;

function TLocalRequest.copy_out_args(const req: IORBRequest): Boolean;
var
  ex : IORBException;
begin
  result := false;
  if req = IORBRequest(Self) then
    begin
      result := true;
      exit;
    end;
  copy_servcntx(req);
  if not req.get_out_args(FRequest.get_result.argument,FRequest.get_arguments,ex) then exit;
  if assigned(ex) then
    begin
      FHaveResult := false;
      FHaveException := true;
      FRequest.get_environment.set_exception(ex);
    end
  else
    begin
      FHaveResult := true;
      FHaveException := false;
    end;
  result := true;
end;

constructor TLocalRequest.Create_req(const req: IRequest);
begin
  FRequest := req;
end;

function TLocalRequest.get_in_args(const enc: IEncoder): Boolean;
var
  args : INVList;
  i : integer;
begin
  result := false;
  args := FRequest.get_arguments;
  for i := 0 to Pred(args.count) do
    if (args.item(i).flags in [ARG_IN,ARG_INOUT]) and
      not args.item(i).argument.marshal(enc) then
        exit;
  if FRequest.get_context <> nil then
    FRequest.get_context.encode(enc,FRequest.get_contexts);
  result := true;
end;

function TLocalRequest.get_in_args(const list: INVList;
  out ctx: IContext): Boolean;
begin
  result := false;
  if not list.copy(FRequest.get_arguments,ARG_IN) then exit;
  ctx := FRequest.get_context;
  result := true;
end;

function TLocalRequest.get_in_args(const list: IStaticAnyList;
  out ctx: IContext): Boolean;
var
  args: INVList;
  nv : TNamedValue;
  i : integer;
begin
  result := false;
  args := FRequest.get_arguments;
  if list.Count <> args.count then exit;
  for i := 0 to Pred(list.count) do
    begin
      nv := args.item(i);
      if list[i].get_flags <> nv.flags then exit;
      if (list[i].get_flags in [ARG_IN,ARG_INOUT]) and
        not nv.argument.to_static_any(list[i]) then exit;
    end;
  ctx := FRequest.get_context;
  result := true;
end;


function TLocalRequest.get_out_args(const res: IStaticAny; const list: IStaticAnyList; out ex: IORBException): Boolean;
var
  e : IORBException;
  nvlist: INVList;
begin
  result := false;
  if FHaveException then
    begin
      e := FRequest.get_environment().get_exception;
      assert(e<>nil);
      ex := e.clone;
      result := true;
      exit;
    end;
  nvlist := FRequest.get_arguments;
  if (list.Count <> nvlist.Count) then
    exit;
  if FHaveResult and (res <> nil) then
    FRequest.get_result.argument.to_static_any(res);

end;

function TLocalRequest.get_out_args(const res: IAny; const list: INVList; out ex: IORBException): Boolean;
var
  e : IORBException;
  lst: INVList;
begin
  result := false;
  if FHaveException then
    begin
      e := FRequest.get_environment.get_exception();
      assert(e<>nil);
      ex := e.clone;
      result := true;
      exit;
    end;
  ex := nil;
  lst := FRequest.get_arguments;
  if lst.Count <> list.Count then
    exit;
  if FHaveResult then
    FResult := FRequest.get_result;

  result := true;
end;

function TLocalRequest.get_out_args(const enc: IEncoder; out is_except: Boolean): Boolean;
var
  args : INVList;
  i : integer;
begin
  result := false;
  if FHaveException then
    begin
      is_except := true;
      FRequest.get_environment.get_exception.encode(enc);
    end
  else
    begin
      is_except := false;
      if FHaveResult and not FRequest.get_result.argument.marshal(enc) then exit;
      args := FRequest.get_arguments;
      for i := 0 to Pred(args.count) do
        if (args.item(i).flags in [ARG_OUT,ARG_INOUT]) and
          not args.item(i).argument.marshal(enc) then
            exit;
    end;
  result := true;
end;

procedure TLocalRequest.invoke;
begin
  assert(false,'not imlplemented');
end;

function TLocalRequest.op_name: AnsiString;
begin
  result := FRequest.operation;
end;

function TLocalRequest.req_type: AnsiString;
begin
  result := 'local';
end;

function TLocalRequest.set_out_args(const ex: IORBException): Boolean;
begin
  result := true;
  FHaveResult := false;
  FHaveException := True;
  FRequest.get_environment.set_exception(ex.clone);
end;

function TLocalRequest.set_out_args(const dec: IDecoder;
  const exception: Boolean): Boolean;
var
  e : IORBException;
  tc: ITypeCode;
  args : INVList;
  i : integer;
begin
  result := false;
  if exception then
    begin
      FHaveResult := false;
      FHaveException := true;
      e := ORBException.decode(dec);
      FRequest.get_environment.set_exception(e);
    end
  else
    begin
      FHaveResult := true;
      FHaveException := false;
      tc := FRequest.get_result.argument.__tc;
      if not FRequest.get_result.argument.demarshal(tc,dec) then exit;
      args := FRequest.get_arguments;
      for i := 0 to Pred(args.count) do
        if args.item(i).flags in [ARG_OUT,ARG_INOUT] then
          begin
            tc := args.item(i).argument.__tc;
            if not args.item(i).argument.demarshal(tc,dec) then exit;
          end;
    end;
  result := true;
end;

function TLocalRequest.set_out_args(const res: IAny;
  const list: INVList): Boolean;
begin
  FHaveException := false;
  if res <> nil then
    begin
      FHaveResult :=  true;
      FRequest.get_result.argument.copy(res);
    end;
  result := FRequest.get_arguments.copy(list,ARG_OUT or ARG_INOUT);
end;

function TLocalRequest.set_out_args(const res: IStaticAny;
  const list: IStaticAnyList): Boolean;
var
  args: INVList;
  nv: TNamedValue;
  i : integer;
begin
  result := false;
  args := FRequest.get_arguments;
  if args.count <> list.count then exit;
  if assigned(res) then
    FRequest.get_result.argument.from_static_any(res);
  for i := 0 to Pred(args.count) do
    begin
      nv := args.item(i);
      if nv.flags <> list[i].get_flags then exit;
      if (nv.flags in [ARG_OUT,ARG_INOUT] ) and
        not nv.argument.from_static_any(list[i]) then exit;
    end;
  result := true;
end;

procedure TLocalRequest.set_result(const any: IStaticAny);
begin
  assert(false,'not imlplemented');
end;

//*********************************************************************
//  TServerRequest
//*********************************************************************
constructor TServerRequest.Create(const req: IORBRequest;
  const obj: IORBObject; mid: ORBMessageID; const oa: IObjectAdaptor; pr: IPrincipal);
begin
  FEnvironment := TEnvironment.Create(pr);
  FReq := req;
  FObject := obj;
  FAborted := False;
  FMid := mid;
  FAdaptor := oa;
  FArguments := nil;
  FCanceled := false;
  //ServerIntercept
  FIceptReq := TServerInterceptor._create_request(FObject, req.op_name(), req.context(), {Self}nil);
end;

destructor TServerRequest.Destroy();
var
  stat : TInvokeStatus;
  sri: IServerRequestImpl;
begin
  if not FCanceled then
    begin
      // clear service context list
      SetLength(FReq.context^, 0);
      //ServerIntercept
      if (FIceptReq <> nil) and not FAborted and not (TServerInterceptor._exec_before_marshal(FIceptReq as ILWServerRequest, FEnvironment)) then begin
        FAborted := true;
      end;
      // copy back out args and result into ORBRequest
      set_out_args();
      // tell OA we are done
      stat := InvokeOK;
      if FEnvironment.get_exception <> nil then begin
        if SystemException.EXCEPTION_DOWNCAST(FEnvironment.get_exception) <> nil then
          stat := InvokeSysEx
        else
          stat := InvokeUserEx;
      end;
      if FMid <> nil then begin
        sri := FMid.request_info() as IServerRequestImpl;
        sri.Exception(FEnvironment.get_exception);
      end;
      FAdaptor.answer_invoke(FMid,FObject,FReq,stat);
      //ServerIntercept
      if (FIceptReq <> nil) and not FAborted and not (TServerInterceptor._exec_finish_request(FIceptReq as ILWServerRequest, FEnvironment)) then begin
        // XXX how to abort request here ??
      end;
    end;
  inherited;
end;

procedure TServerRequest.set_out_args();
var
  sri: IServerRequestImpl;
begin
  if FEnvironment.get_exception <> nil then
    FReq.set_out_args(FEnvironment.get_exception)
  else if FArguments <> nil then begin
    if FMid <> nil then begin
      sri := FMid.request_info() as IServerRequestImpl;
      if sri <> nil then begin
        if (FResult <> nil) and (FResult.__tc <> nil) and
          (FResult.__tc.kind <> tk_void) and (FResult.__tc.kind <> tk_null) then
          sri.Result(FResult);
        sri.Arguments(FArguments, true);
      end;
    end;

    if not FReq.set_out_args(FResult, FArguments) then
      FReq.set_out_args(MARSHAL.Create(0, COMPLETED_NO) as IORBException);
  end
end;

function TServerRequest.environment: IEnvironment;
begin
  result := FEnvironment;
end;

procedure TServerRequest.set_exception(const exc: IORBException);
begin
  FEnvironment.set_exception(exc);
  FResult := nil;
  //doesn't call destructor, if the interceptor have reference to server request
  FIceptReq := nil;
end;

function TServerRequest.operation: AnsiString;
begin
  result := freq.op_name;
end;

procedure TServerRequest.set_result(const any: IAny);
begin
  //FEnvironment.clear;
  FResult := any;
end;

function TServerRequest.arguments(const lst: INVList): Boolean;
var
  orb: IORB;
  sri: IServerRequestImpl;
  piCur: IInterface;
begin
  result := false;
  assert(FArguments = nil);
  FArguments := lst;
  if not TServerInterceptor._exec_initialize_request(FIceptReq as ILWServerRequest, FEnvironment) then begin
    FAborted := true;
    exit;
  end;
  if not FReq.get_in_args(FArguments,FContext) then begin
    set_exception(MARSHAL.Create(0, COMPLETED_NO) as IORBException);
    FAborted := true;
    exit;
  end;
  if not TServerInterceptor._exec_after_unmarshal(FIceptReq as ILWServerRequest, FEnvironment) then begin
    FAborted := true;
    exit;
  end;

  orb := FObject._orb();
  if FMid = nil then begin
    result := true;
    Exit;
  end;
  piCur := FObject._orb.resolve_initial_reference('PICurrent');
  sri := FMid.request_info() as IServerRequestImpl;
  if sri = nil then begin
    result := true;
    Exit;
  end;
  sri.Arguments(FArguments, false);
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
      Exit;
    end;
    on E: TForwardRequest do begin
      FObject := e.forward();
      orb.answer_invoke(FMid, InvokeForward, FObject, FReq, 0);
    end;
    on E: UserException do begin
      set_exception(UserException.copy(E));
      FAborted := true;
      Exit;
    end
    else begin
      set_exception(UNKNOWN.Create(0, COMPLETED_NO));
      FAborted := true;
      Exit;
    end;
  end; { try/except }
  result := true;
end;

function TServerRequest.ctx: IContext;
begin
  result := FContext;
end;

function TRequest.waitfor(const orb: IORB; id: ORBMessageID;
  event: TORBCallbackEvent; tmout: Integer): boolean;
begin
  assert(false,'not imlplemented');
  result := false;
end;

//*********************************************************************
function CreateRequest(const obj : IORBObject; op: AnsiString): IRequest;
begin
  result := TRequest.Create(obj,op)
end;

function CreateRequest_arg(const obj : IORBObject; const c : IContext; op: AnsiString;
      arguments: INVList; res: TNamedValue; flags: _ulong): IRequest;
begin
  result := TRequest.Create(obj,c,op,arguments,res,flags);
end;

function ServerRequest(const req: IORBRequest; const obj: IORBObject; mid: ORBMessageID;
  const oa: IObjectAdaptor; pr: IPrincipal): IServerRequest;
begin
  result := TServerRequest.Create(req, obj, mid, oa, pr);
end;

{$IFDEF LIBRARY}
exports
  CreateRequest,
  CreateRequest_arg,
  ServerRequest;
{$ENDIF}
{$ELSE}
  function CreateRequest(const obj : IORBObject; op: string): IRequest; external MTDORB_Library_Name;
  function CreateRequest_arg(const obj : IORBObject; const c : IContext; op: string;
      arguments: INVList; res: TNamedValue; flags: _ulong): IRequest; external MTDORB_Library_Name;
  function ServerRequest(const req: IORBRequest; const obj: IORBObject; mid: ORBMessageID;
    const oa: IObjectAdaptor; pr: IPrincipal): IServerRequest; external MTDORB_Library_Name;
implementation
{$ENDIF}
end.
