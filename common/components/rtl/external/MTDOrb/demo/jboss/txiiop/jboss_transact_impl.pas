unit jboss_transact_impl;

interface

uses SysUtils, orb_int, exceptions, pi, pi_int, pi_impl, code_int, orbtypes,
  CosTransactions_int, CosTransactions, TransactionService_int, TransactionService,
  CosNaming_int;

type
  TTransactionDesc = Torg_jboss_tm_iiop_TransactionDesc;

  TRIORBInitializerImpl = class(TORBInitializer)
  protected
    procedure pre_init(const info: IORBInitInfo); override;
    procedure post_init(const info: IORBInitInfo); override;
  public
    class procedure Init;
  end;

  TTranContextImpl = class(TClientRequestInterceptor)
  private
    class procedure SetOutgoingPropagationContext(const PC: TPropagationContext);
    class procedure UnsetOutgoingPropagationContext();
  protected
    procedure _destroy; override;
    function _get_name: string; override;
    procedure send_request(const ri: IClientRequestInfo); override;
    procedure send_poll(const ri: IClientRequestInfo); override;
    procedure receive_reply(const ri: IClientRequestInfo); override;
    procedure receive_exception(const ri: IClientRequestInfo); override;
    procedure receive_other(const ri: IClientRequestInfo); override;
  public
    constructor Create(const slotId: TSlotId; const Codec: ICodec; const Current: pi_int.ICurrent);
  end;

  TTransactionInfo = record
    Timeout: Integer;
    Control: IControl;
    Coordinator: ICoordinator;
    Terminator: ITerminator;
  end;

  TCurrentImpl = class(TCurrent)
  private
    class function GetThreadLocalControl(): IControl;
    class function GetThreadLocalTimeout(): Integer;
    class function GetThreadLocalCoordinator(): ICoordinator;
    class function GetThreadLocalTerminator(): ITerminator;
    class procedure SetThreadLocalControl(const Control: IControl);
    class procedure SetThreadLocalTimeout(const Timeout: Integer);
    class procedure SetThreadLocalCoordinator(const Coordinator: ICoordinator);
    class procedure SetThreadLocalTerminator(const Terminator: ITerminator);
    class procedure SetCurrentTransaction(const Control: IControl; const PC: TPropagationContext);
    class procedure UnsetCurrentTransaction();
    class procedure Init(const NC: INamingContextExt);
  protected
    procedure _begin; override;
    procedure commit(const report_heuristics: boolean); override;
    procedure rollback; override;
    procedure rollback_only; override;
    function get_status: TStatus; override;
    function get_transaction_name: string; override;
    procedure set_timeout(const seconds: _ulong); override;
    function get_control: IControl; override;
    function suspend: IControl; override;
    procedure resume(const which: IControl); override;
  public
    class function GetInstance(): ICurrent;
  end;

  TTransactionCurrentInitializer = class(TORBInitializer)
  protected
    procedure pre_init(const info: IORBInitInfo); override;
    procedure post_init(const info: IORBInitInfo); override;
  public
    class procedure Init;
  end;

implementation

uses Classes, osthread, CosNaming, orb, any;

var
  FSlot: TSlotId;
  FCodec: ICodec;
  FPICurrent: pi_int.ICurrent;
  TXFactory: Iorg_jboss_tm_iiop_TransactionFactoryExt;
  SuspendedTransactions: IInterfaceList;
  CurrentGuard: TMutex;
  CurrentInstance: ICurrent;

threadvar
  TransactionInfo: TTransactionInfo;

{ TRIORBInitializerImpl }

class procedure TRIORBInitializerImpl.Init;
begin
  TPIManager.RegisterOrbInitializer(TRIORBInitializerImpl.Create());
end;

procedure TRIORBInitializerImpl.post_init(const info: IORBInitInfo);
var
  slotId: TSlotId;
  encoding: TEncoding;
  codec: ICodec;
  obj: IORBObject;
  piCurrent: pi_int.ICurrent;
begin
  try
    encoding.format := ENCODING_CDR_ENCAPS;
    encoding.major_version := 1;
    encoding.minor_version := 0;

    codec := info.codec_factory.create_codec(encoding);

    // Get reference to PICurrent
    obj := info.resolve_initial_references('PICurrent');
    piCurrent := pi.TCurrent._narrow(obj);

    slotId := info.allocate_slot_id();
    info.add_client_request_interceptor(TTranContextImpl.Create(slotId, codec, piCurrent));
  except
    on E: Exception do
      raise INITIALIZE.Create;
  end;
end;

procedure TRIORBInitializerImpl.pre_init(const info: IORBInitInfo);
begin

end;

{ TTranContextImpl }

procedure TTranContextImpl._destroy;
begin

end;

function TTranContextImpl._get_name: string;
begin
  Result := 'TxClientInterceptor';
end;

constructor TTranContextImpl.Create(const slotId: TSlotId; const Codec: ICodec; const Current: pi_int.ICurrent);
begin
  FSlot := slotId;
  FCodec := Codec;
  FPICurrent := Current;
end;

procedure TTranContextImpl.receive_exception(const ri: IClientRequestInfo);
begin

end;

procedure TTranContextImpl.receive_other(const ri: IClientRequestInfo);
begin

end;

procedure TTranContextImpl.receive_reply(const ri: IClientRequestInfo);
begin

end;

procedure TTranContextImpl.send_poll(const ri: IClientRequestInfo);
begin

end;

procedure TTranContextImpl.send_request(const ri: IClientRequestInfo);
var
  a: IAny;
  sc: ServiceContext;
  data: orbtypes.TOctetSeq;
begin
  data := nil;
  try
    a := ri.get_slot(FSlot);

    if (a <> nil) and not (a.tc.kind in [tk_null, tk_void]) then begin
      sc.context_id := IOP_TransactionService;
      data := FCodec.encode_value(a);
      SetLength(sc.context_data, Length(data));
      Move(Pointer(data)^, Pointer(sc.context_data)^, Length(data));

      ri.add_request_service_context(sc, True);
    end;
  except
    on E: Exception do
      raise INTERNAL.Create();
  end;
end;

class procedure TTranContextImpl.SetOutgoingPropagationContext(
  const PC: TPropagationContext);
var
  a: IAny;
begin
  a := PropagationContext_to_any(PC);
  try
    FPICurrent.set_slot(FSlot, a);
  except
    on E: TInvalidSlot do
      raise INTERNAL.Create();
  end;
end;

class procedure TTranContextImpl.UnsetOutgoingPropagationContext;
begin
  try
    FPICurrent.set_slot(FSlot, CreateAny());
  except
    on E: TInvalidSlot do
      raise INTERNAL.Create();
  end;
end;

{ TCurrentImpl }

(**
 * Begins a new transaction, which will become the current transaction
 * associated with the calling thread.
 *)
procedure TCurrentImpl._begin;
var
  td: TTransactionDesc;
begin
  if GetThreadLocalControl() <> nil then
    raise TSubtransactionsUnavailable.Create();
  td := TXFactory.create_transaction(GetThreadLocalTimeout());
  SetCurrentTransaction(td.control, td.propagationContext);
end;

(**
 * Commits the current transaction.
 *)
procedure TCurrentImpl.commit(const report_heuristics: boolean);
begin
  GetThreadLocalTerminator().commit(report_heuristics);
  UnsetCurrentTransaction();
end;

(**
 * Returns the Control associated with the current transaction.
 *)
function TCurrentImpl.get_control: IControl;
begin
  Result := GetThreadLocalControl();
end;

(**
 * Gets the status of current transaction.
 *)
function TCurrentImpl.get_status: TStatus;
var
  coor: ICoordinator;
begin
  coor := GetThreadLocalCoordinator();
  if coor <> nil then
    Result := coor.get_status
  else
    Result := StatusNoTransaction;
end;

(**
 * Returns the name of the current transaction.
 *)
function TCurrentImpl.get_transaction_name: string;
var
  coor: ICoordinator;
begin
  coor := GetThreadLocalCoordinator();
  if coor <> nil then
    Result := coor.get_transaction_name();
end;

(**
 * Resumes the specified transaction.
 *)
procedure TCurrentImpl.resume(const which: IControl);
var
  coor: ICoordinator;
  pc: TPropagationContext;
begin
  try
    if which = nil then
      raise TInvalidControl.Create();
    if SuspendedTransactions.Remove(which) = -1 then
      raise TInvalidControl.Create();
    coor := which.get_coordinator();
    if coor = nil then
      raise TInvalidControl.Create();
    pc := coor.get_txcontext(); // throws Unavailable
    SetCurrentTransaction(which, pc);
  except
    on E: TUnavailable do
      raise TInvalidControl.Create();
  end;
end;

(**
 * Rolls the current transaction back.
 *)
procedure TCurrentImpl.rollback;
begin
  GetThreadLocalTerminator().rollback();
  UnsetCurrentTransaction();
end;

procedure TCurrentImpl.rollback_only;
var
  coor: ICoordinator;
begin
  try
    coor := GetThreadLocalCoordinator();
    if coor = nil then
      raise TNoTransaction.Create();
    coor.rollback_only();
  except
    on E: TInactive do
      raise INTERNAL.Create();
  end;
end;

(**
 * Sets the transaction time out that will be in effect for
 * transactions created after this call.
 *)
procedure TCurrentImpl.set_timeout(const seconds: _ulong);
begin
  SetThreadLocalTimeout(seconds);
end;

function TCurrentImpl.suspend: IControl;
begin
  Result := GetThreadLocalControl();
  if Result <> nil then begin
     UnsetCurrentTransaction();
     SuspendedTransactions.Add(Result);
  end;
end;

class function TCurrentImpl.GetThreadLocalControl: IControl;
begin
  Result := TransactionInfo.Control;
end;

class function TCurrentImpl.GetThreadLocalTimeout: Integer;
begin
  Result := TransactionInfo.Timeout;
end;

class procedure TCurrentImpl.SetThreadLocalTerminator(
  const Terminator: ITerminator);
begin
  TransactionInfo.Terminator := Terminator;
end;

class procedure TCurrentImpl.SetCurrentTransaction(const Control: IControl;
  const PC: TPropagationContext);
begin
  SetThreadLocalControl(Control);
  SetThreadLocalCoordinator(PC.current.coord);
  SetThreadLocalTerminator(PC.current.term);
  TTranContextImpl.SetOutgoingPropagationContext(PC);
end;

class procedure TCurrentImpl.SetThreadLocalControl(
  const Control: IControl);
begin
  TransactionInfo.Control := Control;
end;

class procedure TCurrentImpl.SetThreadLocalCoordinator(
  const Coordinator: ICoordinator);
begin
  TransactionInfo.Coordinator := Coordinator;
end;

class procedure TCurrentImpl.SetThreadLocalTimeout(const Timeout: Integer);
begin
  TransactionInfo.Timeout := Timeout;
end;

class procedure TCurrentImpl.UnsetCurrentTransaction;
begin
  SetThreadLocalControl(nil);
  SetThreadLocalCoordinator(nil);
  SetThreadLocalTerminator(nil);
  TTranContextImpl.UnsetOutgoingPropagationContext();
end;

class function TCurrentImpl.GetThreadLocalCoordinator: ICoordinator;
begin
  Result := TransactionInfo.Coordinator;
end;

class function TCurrentImpl.GetThreadLocalTerminator: ITerminator;
begin
  Result := TransactionInfo.Terminator;
end;

class function TCurrentImpl.GetInstance: ICurrent;
begin
  CurrentGuard.lock;
  try
    if CurrentInstance = nil then
      CurrentInstance := TCurrentImpl.Create();
    Result := CurrentInstance;
  finally
    CurrentGuard.unlock;
  end;
end;

{ TTransactionCurrentInitializer }

class procedure TTransactionCurrentInitializer.Init;
begin
  TPIManager.RegisterOrbInitializer(TTransactionCurrentInitializer.Create());
end;

procedure TTransactionCurrentInitializer.post_init(
  const info: IORBInitInfo);
var
  obj: IORBObject;
  rootContext: INamingContextExt;
begin
  try
    obj := info.resolve_initial_references('NameService');
    rootContext := TNamingContextExt._narrow(obj);
    TCurrentImpl.Init(rootContext);
  except
    on E: Exception do
      raise INITIALIZE.Create;
  end;
end;

procedure TTransactionCurrentInitializer.pre_init(
  const info: IORBInitInfo);
begin
  try
    info.register_initial_reference('TransactionCurrent', TCurrentImpl.GetInstance());
  except
    on E: TInvalidName do
      raise INITIALIZE.Create;
  end;
end;

class procedure TCurrentImpl.Init(const NC: INamingContextExt);
var
  obj: IORBObject;
begin
  try
    obj := NC.resolve_str('TransactionService');
    TXFactory := Torg_jboss_tm_iiop_TransactionFactoryExt._narrow(obj);
  except
    on E: TNamingContext_CannotProceed do
      raise INTERNAL.Create();
    on E: TNamingContext_NotFound do
      raise INTERNAL.Create();
    on E: TNamingContext_InvalidName do
      raise INTERNAL.Create();
  end;
end;

initialization
  SuspendedTransactions := TInterfaceList.Create;
  CurrentGuard := TMutex.Create;
finalization
  SuspendedTransactions := nil;
  CurrentGuard.Free;
end.
