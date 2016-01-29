unit CounterImpl;

interface

uses orb_int, orbtypes, CosTransactions, CosTransactions_int, Counter, Counter_int,
  osthread, poa_int;

type
  TCounterImpl = class;

  // The counter resource implementation. Note that this resource does
  // not implement the semantics of a recoverable resource. Most
  // notably:
  //
  // - The resource is not a persistent object-reference.
  //
  // - The resource does not log the prepare VoteCommit decision to
  // stable store.
  //
  // - The resource does not implement recovery.
  TCounterResourceImpl = class(TResource_serv, ICounter)
  private
    // The associated counter implementation
    FCounter: TCounterImpl;
    // The original count
    FOrigCount: Integer;
    // The transactional count
    FCount: Integer;
  protected
    function prepare: TVote; override;
    procedure rollback; override;
    procedure commit; override;
    procedure commit_one_phase; override;
    procedure forget; override;
    { ICounter }
    procedure increment;
    procedure decrement;
    procedure shutdown;
    function _get_count: long;
  public
    constructor Create(ACounter: TCounterImpl; ACount: Integer);
  end;

  TCounterImpl = class(TCounter_serv)
  private
    FCurrent: ICurrent;
    FCoordinator: ICoordinator;
    FResource: IResource;
    FCount: Integer;
    FMonitor: TThreadMonitor;
    procedure Join;
    procedure EndTransaction;
    procedure Commit(count: Integer);
  protected
    procedure increment; override;
    procedure decrement; override;
    procedure shutdown; override;
    function _get_count: long; override;
  public
    constructor Create(const ACurrent: ICurrent);
    destructor Destroy; override;
  end;

implementation

uses orb, throw, exceptions, internalexceptions;

{ TCounterResourceImpl }

procedure TCounterResourceImpl.commit;
begin
  FCounter.Commit(FCount);
end;

procedure TCounterResourceImpl.commit_one_phase;
begin
  FCounter.Commit(FCount);
end;

procedure TCounterResourceImpl.decrement;
begin
  Dec(FCount);
end;

procedure TCounterResourceImpl.forget;
begin
  FCounter.EndTransaction;
end;

procedure TCounterResourceImpl.increment;
begin
  Inc(FCount);
end;

function TCounterResourceImpl.prepare: TVote;
begin
  if FCount = FOrigCount then begin
    FCounter.EndTransaction;
    result := VoteReadOnly
  end
  else
    result := VoteCommit;
end;

procedure TCounterResourceImpl.rollback;
begin
  FCounter.EndTransaction;
end;

function TCounterResourceImpl._get_count: long;
begin
  result := FCount;
end;

procedure TCounterResourceImpl.shutdown;
begin

end;

constructor TCounterResourceImpl.Create(ACounter: TCounterImpl;
  ACount: Integer);
begin
  inherited Create;
  FCounter := ACounter;
  FOrigCount := ACount;
  FCount := ACount;
end;

{ TCounterImpl }

function TCounterImpl._get_count: long;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMonitor);
  Join;
  result := (FResource as ICounter).count;
end;

procedure TCounterImpl.decrement;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMonitor);
  Join;
  (FResource as ICounter).decrement;
end;

procedure TCounterImpl.increment;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMonitor);
  Join;
  (FResource as ICounter).increment;
end;

procedure TCounterImpl.shutdown;
begin
  ORB_Instance.shutdown(false);
end;

procedure TCounterImpl.Join;
var
  control: IControl;
  coordinator: ICoordinator;
  res: TCounterResourceImpl;
begin
  try
    control := FCurrent.get_control();

    if control = nil then
      dorb_throw(st_TRANSACTION_REQUIRED);

    try
      coordinator := control.get_coordinator();
    except
      on E: SystemException do
        if E.extype = st_OBJECT_NOT_EXIST then
          dorb_throw(st_TRANSACTION_REQUIRED)
        else
          raise;
    end;

    try
      // Is this resource is already part of a transaction?
      while FCoordinator <> nil do begin
        // If the transaction isn't the same as the transaction
        // that the resource is already involved with then wait
        // for that transaction to terminate.
        if(coordinator.is_same_transaction(FCoordinator)) then
          Break;

        try
          FMonitor.wait();
        except
          on E: EInterruptedException do ;
        end;
      end;
    except
      // If the coordinator goes away then the transaction aborted.
      on E: SystemException do
        if E.extype = st_OBJECT_NOT_EXIST then
          EndTransaction()
        else
          raise;
    end;

    // Is this resource joining the transaction for the first time?
    if FCoordinator = nil then begin
      FCoordinator := coordinator;

      // Allocate a new resource
      res := TCounterResourceImpl.Create(Self, FCount);
      FResource := res;

      FCoordinator.register_resource(res._this);
    end;
  except
    on E: TInactive do
      // The transaction is not active, marked for rollback,
      // already preparing.
      dorb_throw(st_INVALID_TRANSACTION);
  end;
end;

procedure TCounterImpl.EndTransaction;
var
  sync: ISynchronized;
  oid: ObjectId;
begin
  sync := TSynchronized.Create(FMonitor);
  // Destroy the resource
  oid := FPOA.servant_to_id(FResource as IServant);
  FPOA.deactivate_object(oid);
  FResource := nil;

  // Reset the coordinator to allow the Counter to join a new
  // transaction
  FCoordinator := nil;
  FMonitor.notify();
end;

procedure TCounterImpl.Commit(count: Integer);
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMonitor);
  FCount := count;
  EndTransaction;
end;

constructor TCounterImpl.Create(const ACurrent: ICurrent);
begin
  inherited Create;
  FCurrent := ACurrent;
  FMonitor := TThreadMonitor.Create;
end;

destructor TCounterImpl.Destroy;
begin
  FMonitor.Free;
  inherited;
end;

end.
