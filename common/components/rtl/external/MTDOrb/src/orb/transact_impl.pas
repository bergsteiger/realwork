// **********************************************************************
//
// Copyright (c) 2001 - 2002 Millennium Group.
//
// Samara, Russia
//
// All Rights Reserved
//
// **********************************************************************
unit transact_impl;

interface

uses SysUtils, orb_int, orb, orbtypes, intercept, intercept_int, code_int, env_int,
  Classes, CosTransactions_int, CosTransactions;

type
  //This is the current interface implementation.
  TCurrentImpl = class(TCurrent)
  private
    FFactory: ITransactionFactory;
    FTimeOut: _ulong;
    function GetPropagationContext: TPropagationContext;
    procedure PushTXContext(const pctx: TPropagationContext);
    procedure PopTXContext;
    function Factory: ITransactionFactory;
  protected
    procedure _begin; override;
    procedure commit(const report_heuristics: boolean); override;
    procedure rollback; override;
    procedure rollback_only; override;
    function get_status: TStatus; override;
    function get_transaction_name: Identifier; override;
    procedure set_timeout(const seconds: _ulong); override;
    function get_control: IControl; override;
    function suspend: IControl; override;
    procedure resume(const which: IControl); override;
  end;

  //The Client side interceptor is used to transfer the propagation context in transaction requests
  TTransactionalClientInterceptor = class(TClientInterceptor)
  protected
    function initialize_request(const req: ILWRequest; const env: IEnvironment): intercept_int.TStatus; override;
  end;

  // The Server side interceptor is used to retrieve the service context for the transaction service
  // The service context is added to the corresponding current object
  TTransactionalServerInterceptor = class(TServerInterceptor)
  protected
    function after_unmarshal(const req: ILWServerRequest; const env: IEnvironment): intercept_int.TStatus; override;
  end;

  (**
   * This object is used to provide a pseudo control object. On the client and server sides, the control object cannot be
   * found ( since its reference is not set in the propagation context ). However, this object only provides two accessors to
   * get the coordinator and the terminator. These objects reference are set in the propagation context, so it is possible
   * to simulate the original control object.
   *)
  TPseudoControl = class(TLocalORBObject, IControl)
  private
    FTerminator: ITerminator;
    FCoord: ICoordinator;
  protected
    function get_terminator: ITerminator;
    function get_coordinator: ICoordinator;
  public
    constructor Create(const coord: ICoordinator; const term: ITerminator);
  end;

  TTransactionServiceInit = class(TInitInterceptor)
  protected
    function initialize(const orb: IORB; const id: ORBId; argv: TStrings): intercept_int.TStatus; override;
  end;

procedure TransactionServiceInit;

implementation

uses throw, any, exceptions, Contnrs, encoder, decoder;

type
  PPropagationContext = ^TPropagationContext;

threadvar
  tran_ctx: IAny;
  pctx_stacks: TStack;

procedure TransactionServiceInit;
var
  tsInit: IInitInterceptor;
begin
  tsInit := TTransactionServiceInit.Create(0);
end;

{ TCurrentImpl }

// A new transaction is created. The transaction context of the client thread is modified so
// that the thread is associated with the new transaction. If the client thread is currently
// associated with a transaction, the new transaction is a subtransaction of that
// transaction. Otherwise, the new transaction is a top-level transaction.
procedure TCurrentImpl._begin;
var
  pctx: TPropagationContext;
  control: IControl;
begin
  try
    pctx := GetPropagationContext;
    // As a previous propagation context has been found, it means that we are
    // going to create a sub transaction. Before, we need to save the current
    // propagation context.
    PushTXContext(pctx);

    // here is the case where we have to create the sub transaction
    control := pctx.current.coord.create_subtransaction();
    pctx := control.get_coordinator().get_txcontext();
    tran_ctx := PropagationContext_to_any(pctx);
  except
    on E: MARSHAL do begin
      // Here is the case where we create a top level transaction
      control := Factory._create(FTimeOut);
      pctx := control.get_coordinator().get_txcontext();
      pctx.current.term := control.get_terminator();
      tran_ctx := PropagationContext_to_any(pctx);
    end;
  end;
end;
(**
 * If there is no transaction associated with the client thread, the NoTransaction exception
 * is raised. If the client thread does not have permission to commit the transaction, the
 * standard exception NO_PERMISSION is raised. (The commit operation may be restricted
 * to the transaction originator in some implementations.)
 *
 * Otherwise, the transaction associated with the client thread is completed. The effect of
 * this request is equivalent to performing the commit operation on the corresponding
 * Terminator object.
 *
 * The client thread transaction context is modified as follows: If the transaction was
 * begun by a thread (invoking begin) in the same execution environment, then the
 * threads transaction context is restored to its state prior to the begin request. Otherwise,
 * the threads transaction context is set to null.
 *)
procedure TCurrentImpl.commit(const report_heuristics: boolean);
var
  pctx: TPropagationContext;
begin
  try
    try
      // Commits the current transaction
      pctx := GetPropagationContext;
      pctx.current.term.commit(report_heuristics);
    except
      on E: MARSHAL do
        raise TNoTransaction.Create
    end; { try/except }
  finally
    // Gets the previous propagation context if the current transaction was
    // a sub transaction
    PopTXContext();
  end; { try/finally }
end;

(**
 * If the client thread is not associated with a transaction, a null object reference is
 * returned. Otherwise, a Control object is returned that represents the transaction context
 * currently associated with the client thread. This object can be given to the resume
 * operation to reestablish this context in the same thread or a different thread. The scope
 * within which this object is valid is implementation dependent; at a minimum, it must
 * be usable by the client thread. This operation is not dependent on the state of the
 * transaction; in particular, it does not raise the TRANSACTION_ROLLEDBACK
 * exception.
 *)
function TCurrentImpl.get_control: IControl;
var
  pctx: TPropagationContext;
begin
  try
    // Commits the current transaction
    pctx := GetPropagationContext;
    result := TPseudoControl.Create(pctx.current.coord, pctx.current.term) as IControl;
  except
    on E: MARSHAL do
      result := nil
  end; { try/except }
end;

// Return the Transaction Factory if already connected or open an connection to it
function TCurrentImpl.Factory: ITransactionFactory;
begin
  if FFactory = nil then
    FFactory := TTransactionFactory._narrow(FORB.resolve_initial_reference('TransactionService'));
  if FFactory = nil then
    dorb_throw(st_INTERNAL);
  result := FFactory;
end;

(**
 * If there is no transaction associated with the client thread, the StatusNoTransaction value
 * is returned. Otherwise, this operation returns the status of the transaction associated
 * with the client thread. The effect of this request is equivalent to performing the
 * get_status operation on the corresponding Coordinator object.
 *)
function TCurrentImpl.get_status: TStatus;
var
  pctx: TPropagationContext;
begin
  try
    // Commits the current transaction
    pctx := GetPropagationContext;
    result := pctx.current.coord.get_status();
  except
    on E: MARSHAL do
      raise TNoTransaction.Create
  end; { try/except }
end;

(**
 * If there is no transaction associated with the client thread, an empty string is returned.
 * Otherwise, this operation returns a printable string describing the transaction. The
 * returned string is intended to support debugging. The effect of this request is
 * equivalent to performing the get_transaction_name operation on the corresponding
 * Coordinator object.
 *)
function TCurrentImpl.get_transaction_name: Identifier;
var
  pctx: TPropagationContext;
begin
  try
    // Commits the current transaction
    pctx := GetPropagationContext;
    result := pctx.current.coord.get_transaction_name();
  except
    on E: MARSHAL do
      result := ''
  end; { try/except }
end;

(**
 * If the parameter is a null object reference, the client thread becomes associated with no
 * transaction. Otherwise, if the parameter is valid in the current execution environment,
 * the client thread becomes associated with that transaction (in place of any previous
 * transaction). Otherwise, the InvalidControl exception is raised.
 *
 * This operation is not dependent on the state of the transaction; in particular,
 * it does not raise the TRANSACTION_ROLLEDBACK exception.
 *)
procedure TCurrentImpl.resume(const which: IControl);
var
  pctx: TPropagationContext;
begin
  if which = nil then begin
    tran_ctx := CreateAny;
  end
  else begin
    pctx := which.get_coordinator().get_txcontext();
    tran_ctx := PropagationContext_to_any(pctx);
  end;
end;

(**
 * If there is no transaction associated with the client thread, the NoTransaction exception
 * is raised. If the client thread does not have permission to rollback the transaction, the
 * standard exception NO_PERMISSION is raised. (The rollback operation may be restricted
 * to the transaction originator in some implementations; however, the rollback_only
 * operation, described below, is available to all transaction participants.)
 *
 * Otherwise, the transaction associated with the client thread is rolled back. The effect of
 * this request is equivalent to performing the rollback operation on the corresponding
 * Terminator object.
 *
 * The client thread transaction context is modified as follows: If the transaction was
 * begun by a thread (invoking begin) in the same execution environment, then the
 * thread?s transaction context is restored to its state prior to the begin request. Otherwise,
 * the thread?s transaction context is set to null.
 *)
procedure TCurrentImpl.rollback;
var
  pctx: TPropagationContext;
begin
  try
    try
      // Commits the current transaction
      pctx := GetPropagationContext;
      pctx.current.term.rollback();
    except
      on E: MARSHAL do
        raise TNoTransaction.Create
    end; { try/except }
  finally
    // Gets the previous propagation context if the current transaction was
    // a sub transaction
    PopTXContext();
  end; { try/finally }
end;

(**
 * If there is no transaction associated with the client thread, the NoTransaction exception
 * is raised. Otherwise, the transaction associated with the client thread is modified so
 * that the only possible outcome is to rollback the transaction. The effect of this request
 * is equivalent to performing the rollback_only operation on the corresponding
 * Coordinator object.
 *)
procedure TCurrentImpl.rollback_only;
var
  pctx: TPropagationContext;
begin
  try
    // Commits the current transaction
    pctx := GetPropagationContext;
    pctx.current.coord.rollback_only();
  except
    on E: MARSHAL do
      raise TNoTransaction.Create;
    on E: TInactive do ;
  end; { try/except }
end;

(**
 * This operation modifies a state variable associated with the target object that affects
 * the time-out period associated with top-level transactions created by subsequent
 * invocations of the begin operation. If the parameter has a nonzero value n, then top-level
 * transactions created by subsequent invocations of begin will be subject to being
 * rolled back if they do not complete before n seconds after their creation. If the
 * parameter is zero, then no application specified time-out is established.
 *)
procedure TCurrentImpl.set_timeout(const seconds: _ulong);
begin
  FTimeOut := seconds;
end;

(**
 * If the client thread is not associated with a transaction, a null object reference is
 * returned. Otherwise, an object is returned that represents the transaction context
 * currently associated with the client thread. This object can be given to the resume
 * operation to reestablish this context in the same thread or a different thread. The scope
 * within which this object is valid is implementation dependent; at a minimum, it must
 * be usable by the client thread. In addition, the client thread becomes associated with no
 * transaction. This operation is not dependent on the state of the transaction; in
 * particular, it does not raise the TRANSACTION_ROLLEDBACK exception.
 *)
function TCurrentImpl.suspend: IControl;
begin
  result := get_control();
  tran_ctx := CreateAny;
end;

function TCurrentImpl.GetPropagationContext: TPropagationContext;
begin
  if (tran_ctx = nil) or not any_to_PropagationContext(tran_ctx, result) then
    dorb_throw(st_MARSHAL);
end;

// This operation is used to push a propagation context in a stack. When a sub transaction
// begins, the parent propagation context must be stored in a stack.
procedure TCurrentImpl.PushTXContext(const pctx: TPropagationContext);
var
  ctx: PPropagationContext;
begin
  if pctx_stacks = nil then
    pctx_stacks := TStack.Create;
  ctx := AllocMem(SizeOf(TPropagationContext));
  ctx^ := pctx;
  pctx_stacks.Push(ctx);
end;

// This operation restores a previously saved propagation context. For example, when a sub transaction
// is completed, the parent propagation context is restored.
procedure TCurrentImpl.PopTXContext;
var
  pctx: TPropagationContext;
  ctx: PPropagationContext;
  stack: TStack;
  clean: Boolean;
begin
  clean := False;
  stack := pctx_stacks;
  if stack = nil then
    clean := True
  else begin
    if stack.Count = 0 then
      clean := True
    else begin
      ctx := PPropagationContext(stack.Pop);
      pctx := ctx^;
      FreeMem(ctx, SizeOf(TPropagationContext));
      tran_ctx := PropagationContext_to_any(pctx);
    end;
  end;
  if clean then
    tran_ctx := CreateAny;
end;

{ TPseudoControl }

constructor TPseudoControl.Create(const coord: ICoordinator;
  const term: ITerminator);
begin
  inherited Create();
  FTerminator := term;
  FCoord := coord;
end;

function TPseudoControl.get_coordinator: ICoordinator;
begin
  result := FCoord;
end;

function TPseudoControl.get_terminator: ITerminator;
begin
  result := FTerminator;
end;

{ TTransactionalClientInterceptor }

// Adds a transaction propagation context to the service context list, to be passed to the server
function TTransactionalClientInterceptor.initialize_request(
  const req: ILWRequest; const env: IEnvironment): intercept_int.TStatus;
var
  a: IAny;
  enc: IEncoder;
  ctx: ContextData;
begin
  result := INVOKE_CONTINUE;
  a := tran_ctx;
  if (a = nil) or (a.__tc.kind = tk_null) or (a.__tc.kind = tk_void) then
    Exit;
  enc := CreateEncoder;
  a.encode(enc);
  SetLength(ctx, enc.buffer.length);
  enc.buffer.get(Pointer(ctx)^, enc.buffer.length);
  req.set_service_context(IOP_TransactionService, 0, ctx);
end;

{ TTransactionalServerInterceptor }

// get the transaction propagation context from the service context list and save
function TTransactionalServerInterceptor.after_unmarshal(
  const req: ILWServerRequest;
  const env: IEnvironment): intercept_int.TStatus;
var
  ctx: ContextData;
  dec: IDecoder;
  a: IAny;
begin
  result := INVOKE_CONTINUE;
  ctx := nil;
  try
    ctx := req.get_service_context(IOP_TransactionService, 0);
  except
    on E: BAD_PARAM do begin
      tran_ctx := nil;
      Exit;
    end;
  end; { try/except }
  // save the propagation context
  dec := CreateDecoder;
  dec._buffer.put(Pointer(ctx)^, Length(ctx));
  a := CreateAny;
  a.decode(dec);
  tran_ctx := a;
end;

{ TTransactionServiceInit }

function TTransactionServiceInit.initialize(const orb: IORB;
  const id: ORBId; argv: TStrings): intercept_int.TStatus;
var
  tClient: IClientInterceptor;
  tServer: IServerInterceptor;
begin
  result := INVOKE_CONTINUE;
  orb.register_initial_reference('TransactionCurrent', TCurrentImpl.Create as IORBObject);
  tClient := TTransactionalClientInterceptor.Create();
  tServer := TTransactionalServerInterceptor.Create();
  tClient.activate(0);
  tServer.activate(0);
end;

end.
