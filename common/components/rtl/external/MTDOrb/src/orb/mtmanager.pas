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
unit mtmanager;

interface

{$I dorb.inc}

uses
  {$IFDEF MSWINDOWS}Windows,{$ENDIF}{$IFDEF LINUX}Libc,{$ENDIF}SysUtils, Classes,
  Contnrs, mtmanager_int, osthread, orbtypes;

{$IFNDEF USELIB}

type
  TMsgChannelTypes = (mcActive, mcPassive, mcDirect);

  // Forward declarations
  TThreadPool = class;
  TThreadPoolManager = class;
  TWorkerThread = class;

  TMsgType = class(TInterfacedObject, IMsgType)
  protected
    FType: TMTMesType;
    FPtr: pointer;
    FValue: integer;
    function get_type: TMTMesType;
    procedure set_type(msgType: TMTMesType);
    function data: pointer;
  public
    constructor Create(ptr: pointer; AType: TMTMesType = mtProcess);
    destructor Destroy; override;
    property Value: integer read FValue write FValue;
  end;

  TMsgChannel = class(TInterfacedObject, IMsgChannel)
  protected
    FThreadPool: IThreadPool;
    procedure set_thread_pool(AThreadPool: IThreadPool);
    function get_thread_pool: IThreadPool; overload;
    function check_msg(var kt: IWorkerThread): boolean; virtual;
    function get_msg(idType: TOperationKind): IMsgType; virtual;
    procedure put_msg(nextOpId: TOperationKind; msg: IMsgType); virtual; abstract;
  public
  end;

  TActiveMsgQueue = class(TMsgChannel, IMsgChannel)
  private
    FQueue: TQueue;
    FAccess: TMutex;
  protected
    function check_msg(var kt: IWorkerThread): boolean; override;
    procedure put_msg(nextOpId: TOperationKind; msg: IMsgType); override;
  public
    constructor Create();
    destructor Destroy; override;
  end;

  TPassiveMsgQueue = class(TMsgChannel, IPassiveMsgQueue)
  private
    Fkt: IWorkerThread;
    FQueue: TQueue;
    FAccess: TMutex;
    FMsgCnt: TSemaphore;
  protected
    procedure set_worker_thread(kt: IWorkerThread);
    function get_msg(idType: TOperationKind): IMsgType; override;
    procedure put_msg(idType: TOperationKind; msgType: IMsgType); override;
  public
    constructor Create();
    destructor Destroy; override;
  end;

  TDirectMsgConnector = class(TMsgChannel, IDirectMsgConnector)
  private
    FOp: IOperation;
  protected
    procedure set_operation(op: IOperation);
    procedure put_msg(idType: TOperationKind; msgType: IMsgType); override;
  public
  end;

  TOperation = class(TMsgChannel, IOperation)
  private
  protected
    FInfo: IOperationInfoNode;
    FWThread: IWorkerThread;
    function get_info(): IOperationInfoNode;
    procedure set_info(value: IOperationInfoNode);
    function get_thread(): IWorkerThread;
    procedure set_thread(value: IWorkerThread);
    procedure start();
    procedure init_shutdown(); virtual;
    procedure finalize_shutdown(); virtual;
    procedure send_msg(nextOpId: TOperationKind; msg: IMsgType);
    procedure process(msg: IMsgType); virtual;
    procedure run(); virtual; abstract;
    function copy(): IOperation; virtual; abstract;
    procedure put_msg(nextOpId: TOperationKind; msg: IMsgType); override;
  public
    constructor Create(); overload;
    constructor Create(AThreadPool: IThreadPool); overload;
    constructor Create(op: IOperation); overload;
    destructor Destroy; override;
  end;

  TOperationInfoNode = class(TInterfacedObject, IOperationInfoNode)
  private
    FNextOP: IMsgChannel;
    FTp: IThreadPool;
    FOpID: TOperationKind;
  protected
    function get_thread_pool(): IThreadPool;
    procedure set_thread_pool(tp: IThreadPool);
    function get_OP_id(): TOperationKind;
    procedure set_OP_id(id: TOperationKind);
    function get_nextOP(): IMsgChannel;
    procedure set_nextOP(nextOP: IMsgChannel);
  end;

  TActiveOperation = class(TOperation, IActiveOperation)
  private
  protected
    FInputMC: IPassiveMsgQueue;
    procedure register_input_mc(mc: IPassiveMsgQueue);
    function get_input_mc(): IPassiveMsgQueue;
    procedure init_shutdown(); override;
    procedure run(); override;
  public
    constructor Create(AThreadPool: IThreadPool); overload;
    constructor Create(op: IActiveOperation); overload;
  end;

  TPassiveOperation = class(TOperation, IPassiveOperation)
  private
    FMsgType: IMsgType;
  protected
    procedure put_msg(idType: TOperationKind; msgType: IMsgType); override;
    procedure run(); override;
  end;

  TWorkerThread = class(TORBThread, IWorkerThread)
  private
    FTP: IThreadPool;
    FOp: IOperation;
    FState: TWorkerThreadState;
    FOpCritical: TRecursiveMutex;
    FStateSem: TSemaphore;
    procedure wait_for_state_change();
    function get_state: TWorkerThreadState;
    procedure set_state(const Value: TWorkerThreadState);
  protected
    procedure set_thread_pool(AThreadPool: IThreadPool);
    function get_thread_pool: IThreadPool;
    procedure register_operation(op: IOperation);
    procedure deregister_operation(op: IOperation);
    procedure post_state_change();
    procedure put_msg(msgType: IMsgType);
    procedure mark_idle();
    procedure mark_busy();
    function get_operation(): IOperation;
    procedure Run(); override;
  public
    constructor Create(); overload;
    constructor Create(AThreadPool: IThreadPool); overload;
    destructor Destroy; override;
    procedure ExitHook(); override;
  end;

  TWorkerThreadList = class(TList);

  TThreadPool = class(TMsgChannel, IThreadPool)
  private
    FOpType: integer;
    //FTPLock: TMutex;
    FTpm: IThreadPoolManager;
    //FBusyThreads,
    FIdleThreads: IInterfaceList;
    FOp: IOperation;
    FInputMC: IMsgChannel;
    FMax,
    FMaxIdle,
    FMinIdle,
    FCountAll: cardinal;
    FMonitor: TThreadMonitor;
    function new_idle_thread(): IWorkerThread;
  protected
    function get_idle_thread(): IWorkerThread;
    procedure mark_busy(wt: IWorkerThread);
    procedure mark_idle(wt: IWorkerThread);
    function remove_thread(kt: IWorkerThread): boolean;
    function get_operation(): IOperation;
    procedure set_operation(op: IOperation);
    procedure set_thread_pool_manager(tpm: IThreadPoolManager);
    function get_thread_pool_manager(): IThreadPoolManager;
    function optype: integer;
    procedure clear();
    // fire up all threads
    procedure start_threads(arg: pointer = nil); virtual;
    procedure registerInputMC(mc: TMsgChannel);
    function getInputMC(): IMsgChannel;
    procedure put_msg(nextOpId: TOperationKind; msgType: IMsgType); override;
  public
    constructor Create(AMax, AMaxIdle, AMinIdle: cardinal);
    destructor Destroy; override;
  end;

  TThreadPoolManager = class(TMsgChannel, IThreadPoolManager)
  private
    FTp: array [TOperationKind] of IThreadPool;
    FUserCnt: _ulong;
    procedure register_tp(const opId: TOperationKind; tp: IThreadPool);
  protected
    function register_new_tp(tp: IThreadPool): _ulong;
    procedure put_msg(nextOpId: TOperationKind; msgType: IMsgType); override;
    { IThreadPoolManager }
    function get_operation(opId: TOperationKind): IOperation;
    function get_thread_pool(const opId: TOperationKind): IThreadPool; overload;
    function get_idle_thread(const opId: TOperationKind): IWorkerThread;
    procedure shutdown();
  public
    constructor Create();
    destructor Destroy; override;
  end;

  TMTDispatcher = class(TPassiveOperation, IPassiveOperation)
  protected
    procedure process(msg: IMsgType); override;
    function copy(): IOperation; override;
  public
    constructor Create(); overload;
    constructor Create(op: IOperation); overload;
  end;

  TMTManager = class(TObject)
  public
    class procedure ConcurrencyModel(AModel: TConcurrencyModel); overload;
    class function ConcurrencyModel: TConcurrencyModel; overload;
    class function ThreadPool: boolean;
    class function ThreadPerConnection: boolean;
    class function ThreadPerRequest: boolean;
    class procedure ThreadSetup(ConnLimit, RequestLimit: integer);
    class procedure ThreadShutdown();
    class function ThreadPoolManager: IThreadPoolManager;
  end;

implementation

uses
  iop,giop_int,orb,mtdebug,internalexceptions,utils;

type
  TTm_Init_T = record
    opKind: TOperationKind;
    max: cardinal;
    max_idle: cardinal;
    min_idle: cardinal;
    mct: TMsgChannelTypes;
    mc_size: cardinal;
    op: IOperation;
    start: boolean;
  end;

const
  tmInitSize = 5;
  
var
  tmInit: array [0..tmInitSize-1] of TTm_Init_T =
   ((opKind: odAccept; max: 200; max_idle: 0; min_idle: 0; mct: mcPassive; mc_size: 0; op: nil; start: FALSE),
    (opKind: odWriter; max: 200; max_idle: 0; min_idle: 0; mct: mcPassive; mc_size: 0; op: nil; start: FALSE),
    (opKind: odReader; max: 200; max_idle: 0; min_idle: 0; mct: mcPassive; mc_size: 0; op: nil; start: FALSE),
    (opKind: odDeCode; max: 200; max_idle: 0; min_idle: 0; mct: mcActive;  mc_size: 1; op: nil; start: TRUE),
    (opKind: odORB;    max: 100; max_idle: 0; min_idle: 0; mct: mcActive;  mc_size: 1; op: nil; start: TRUE));

var
  tpmVar: IThreadPoolManager;
  ConcurrencyModelVar: TConcurrencyModel;
  
{ TOperationInfoNode }

function TOperationInfoNode.get_nextOP: IMsgChannel;
begin
  result := FNextOP;
end;

function TOperationInfoNode.get_OP_id: TOperationKind;
begin
  result := FOpID;
end;

function TOperationInfoNode.get_thread_pool: IThreadPool;
begin
  result := FTp;
end;

procedure TOperationInfoNode.set_nextOP(nextOP: IMsgChannel);
begin
  FNextOP := nextOP;
end;

procedure TOperationInfoNode.set_OP_id(id: TOperationKind);
begin
  FOpID := id;
end;

procedure TOperationInfoNode.set_thread_pool(tp: IThreadPool);
begin
  FTp := tp;
end;

{ TMsgChannel }

function TMsgChannel.check_msg(var kt: IWorkerThread): boolean;
begin
  result := false;
end;

function TMsgChannel.get_msg(idType: TOperationKind): IMsgType;
begin
  Assert(false, 'Not implemented');
  result := nil;
end;

function TMsgChannel.get_thread_pool: IThreadPool;
begin
  result := FThreadPool;
end;

procedure TMsgChannel.set_thread_pool(AThreadPool: IThreadPool);
begin
  FThreadPool := AThreadPool;
end;

{ TOperation }

constructor TOperation.Create(AThreadPool: IThreadPool);
begin
  FInfo := TOperationInfoNode.Create();
  FInfo.set_thread_pool(AThreadPool);
end;

constructor TOperation.Create;
begin
  FInfo := TOperationInfoNode.Create();
end;

constructor TOperation.Create(op: IOperation);
begin
  FInfo := op.get_info();
end;

destructor TOperation.Destroy;
begin
  FInfo := nil;
  inherited;
end;

procedure TOperation.finalize_shutdown;
begin
  // make sure the thread has left the context of
  // this OP, deregisterOP will take care of that !
  if FWThread <> nil then FWThread.deregister_operation(Self as IOperation);
end;

function TOperation.get_info: IOperationInfoNode;
begin
  result := FInfo;
end;

function TOperation.get_thread: IWorkerThread;
begin
  result := FWThread;
end;

procedure TOperation.init_shutdown;
begin

end;

// the assert's below mark methods that have to be overloaded
// in derived Classes
// the derived Classes have to overload only one of those !!!
procedure TOperation.process(msg: IMsgType);
begin
  Assert(false, 'Implementation error - this should never happen');
end;

procedure TOperation.put_msg(nextOpId: TOperationKind; msg: IMsgType);
begin
  Assert(false, 'not implemented');
end;

procedure TOperation.send_msg(nextOpId: TOperationKind; msg: IMsgType);
begin
  FInfo.get_nextOP().put_msg(nextOpId, msg);
end;

procedure TOperation.set_info(value: IOperationInfoNode);
begin
  FInfo := value;
end;

procedure TOperation.set_thread(value: IWorkerThread);
begin
  FWThread := value;
end;

procedure TOperation.start;
begin
  FWThread.post_state_change();
end;

{ TActiveOperation }

procedure TActiveOperation.run;
var
  msg: IMsgType;
begin
  while true do begin
    msg := get_input_mc().get_msg(FInfo.get_OP_id());
    // We are guaranteed that msg is not NULL because get_msg() asserts
    // this, so don't bother checking it again after the call to get_msg()
    // above!!!
    if msg.get_type() = mtTerminate then begin
      msg := nil;
      Break;
    end;
    process(msg);
  end; { while }
end;

constructor TActiveOperation.Create(AThreadPool: IThreadPool);
begin
  inherited Create(AThreadPool);
end;

constructor TActiveOperation.Create(op: IActiveOperation);
begin
  inherited Create(op);
  FInputMC := op.get_input_mc();
end;

function TActiveOperation.get_input_mc: IPassiveMsgQueue;
begin
  result := FInputMC;
end;

procedure TActiveOperation.init_shutdown;
var
  msg: IMsgType;
begin
  if get_input_mc() <> nil then begin
    msg := TMsgType.Create(nil, mtTerminate);
    get_input_mc().put_msg(FInfo.get_OP_id(), msg)
  end;
end;

procedure TActiveOperation.register_input_mc(mc: IPassiveMsgQueue);
begin
  FInputMC := mc;
  //FInputMC.set_worker_thread(FWThread);
end;

  { TPassiveOperation }

procedure TPassiveOperation.run;
begin
  // make sure the message exists
  if (FMsgType = nil) then
    Exit;

  if (FMsgType.get_type() <> mtTerminate) then
    process(FMsgType);
  FMsgType := nil;
end;

procedure TPassiveOperation.put_msg(idType: TOperationKind;
  msgType: IMsgType);
begin
  Assert(Finfo.get_OP_id = idType);
  FMsgType := msgType;
end;

  { TMsgType }

constructor TMsgType.Create(ptr: pointer; AType: TMTMesType);
begin
  FPtr := ptr;
  FType := AType;
end;

function TMsgType.data: pointer;
begin
  result := FPtr;
end;

destructor TMsgType.Destroy;
begin
  inherited;
end;

function TMsgType.get_type: TMTMesType;
begin
  result := FType;
end;

procedure TMsgType.set_type(msgType: TMTMesType);
begin
  FType := msgType;
end;

{ TActiveMsgQueue }

function TActiveMsgQueue.check_msg(var kt: IWorkerThread): boolean;
var
  msg: IMsgType;
begin
  FAccess.lock();
  try
    result := FQueue.Count <> 0;
    if result then begin
      if kt = nil then begin
        try
          kt := FThreadPool.get_idle_thread();
        except
          //consume or maybe raise fatal exception???
        end; { try/except }
        if kt = nil then begin
          result := false;
          Exit;
        end;
      end;
      msg := IMsgType(FQueue.Peek);
      Assert(msg <> nil);
      FQueue.Pop;
      msg._Release;
      kt.put_msg(msg);
      kt.mark_busy();
      result := true;
      //kt.post_state_change();
    end;
  finally
    FAccess.unlock();
  end; { try/finally }
end;

constructor TActiveMsgQueue.Create;
begin
  FQueue := TQueue.Create;
  FAccess := TMutex.Create;
end;

destructor TActiveMsgQueue.Destroy;
begin
  FreeAndNil(FAccess);
  FreeAndNil(FQueue);
  inherited;
end;

procedure TActiveMsgQueue.put_msg(nextOpId: TOperationKind; msg: IMsgType);
var
  kt: IWorkerThread;
begin
  Assert(msg <> nil);
  FAccess.lock();
  try
    try
      kt := FThreadPool.get_idle_thread();
    except
      //consume or maybe raise fatal exception???
    end; { try/except }
    if kt <> nil then begin
      kt.put_msg(msg);
      kt.mark_busy;
      kt.post_state_change;
    end
    else begin
        msg._AddRef;
        FQueue.Push(Pointer(msg));
    end;
  finally
    FAccess.unlock();
  end; { try/finally }
end;

  { TPassiveMsgQueue }

constructor TPassiveMsgQueue.Create;
begin
  FQueue := TQueue.Create;
  FAccess := TMutex.Create;
  FMsgCnt := TSemaphore.Create;
end;

destructor TPassiveMsgQueue.Destroy;
begin
  FreeAndNil(FMsgCnt);
  FreeAndNil(FAccess);
  FreeAndNil(FQueue);
  inherited;
end;

function TPassiveMsgQueue.get_msg(idType: TOperationKind): IMsgType;
begin
  FMsgCnt.wait(); // wait for a message (block)
  FAccess.lock();
  try
    result := IMsgType(FQueue.Peek);
    Assert(result <> nil);
    result._Release;
    FQueue.Pop;
  finally
    FAccess.unlock();
  end; { try/finally }
end;

procedure TPassiveMsgQueue.put_msg(idType: TOperationKind; msgType: IMsgType);
begin
  Assert(msgType <> nil);
  FAccess.lock();
  try
    msgType._AddRef;
    FQueue.Push(Pointer(msgType));
  finally
    FAccess.unlock();
  end; { try/finally }
  FMsgCnt.post();
end;

procedure TPassiveMsgQueue.set_worker_thread(kt: IWorkerThread);
begin
  FKt := kt;
end;

{ TDirectMsgConnector }

procedure TDirectMsgConnector.put_msg(idType: TOperationKind;
  msgType: IMsgType);
var
  oper: IOperation;
begin
  Assert(msgType <> nil);
  oper := FOp.copy();
  oper.put_msg(idType, msgType);
  oper.run();
  oper := nil;
end;

procedure TDirectMsgConnector.set_operation(op: IOperation);
begin
  FOp := op;
end;

{ TWorkerThread }

procedure TWorkerThread.Run();
var
  op: IOperation;
begin
  repeat
    try
        wait_for_state_change();
        if FState = wtsBusy then begin
          FOpCritical.lock();
          try
            op := get_operation();
            if op <> nil then op.run();
            op := nil;
          finally
            FOpCritical.unlock();
          end; { try/finally }
          mark_idle();
          post_state_change();
        end;
    except on e: Exception do
    begin
      MTDORBLogger.Warning('Error in thread: ' + AnsiString(e.Message));
//      mark_idle();
      FState := wtsStop;
      post_state_change();
      //exit;
    end;
    end;
  until FState = wtsStop;
end;

{procedure TWorkerThread._run_multi_queue_input;
begin

end;

procedure TWorkerThread._run_process;
begin

end;

procedure TWorkerThread._run_single_queue_input;
begin

end;}

constructor TWorkerThread.Create;
begin
  //create mutex and semaphore before inherited Create!!!
  FOpCritical := TRecursiveMutex.Create();
  FStateSem := TSemaphore.Create();
  inherited Create();
end;

constructor TWorkerThread.Create(AThreadPool: IThreadPool);
begin
  Create();
  FTP := AThreadPool;
end;

procedure TWorkerThread.deregister_operation(op: IOperation);
begin
  FOpCritical.lock();
  try
    if op = FOp then begin
      FOp.set_info(nil);
      FOp := nil;
    end;
  finally
    FOpCritical.unlock();
  end; { try/finally }
end;

destructor TWorkerThread.Destroy;
begin
  {WJ: Refcount should be higher than 1!! Otherwise destructor will be called
  again after removing thread from threadpool}
  if not FFinished then
    wait();
  FRefCount := 1;
  if FTP <> nil then
    FTP.remove_thread(Self);
  FreeAndNil(FOpCritical);
  FreeAndNil(FStateSem);
  FRefCount := 0;
  inherited;
end;

function TWorkerThread.get_operation: IOperation;
begin
  FOpCritical.lock();
  result := FOp;
  FOpCritical.unlock();
end;

function TWorkerThread.get_state: TWorkerThreadState;
begin
  FOpCritical.lock();
  result := FState;
  FOpCritical.unlock();
end;

function TWorkerThread.get_thread_pool: IThreadPool;
begin
  result := FTP;
end;

procedure TWorkerThread.mark_busy;
begin
  FOpCritical.lock();
  if get_thread_pool() <> nil then get_thread_pool().mark_busy(Self);
  FOpCritical.unlock();
end;

procedure TWorkerThread.mark_idle;
begin
  FOpCritical.lock;
  if get_thread_pool() <> nil then get_thread_pool().mark_idle(Self);
  FOpCritical.unlock;
end;

procedure TWorkerThread.post_state_change;
begin
  if Assigned(FStateSem) then
    FStateSem.post()
//  else
//     FStateSem := nil;
  //FStateMon.notify();
end;

procedure TWorkerThread.put_msg(msgType: IMsgType);
begin
  FOp.put_msg(FOp.get_info().get_OP_id(), msgType)
end;

procedure TWorkerThread.register_operation(op: IOperation);
begin
  FOpCritical.lock();
  try
    //WJ: if exists FOp we need to tell it has no thread
    if FOp <> nil then
    begin
      FOp.set_thread(nil);
      FOp := nil;
    end;
    if op <> nil then begin
      FOp := op;
      FOp.set_thread(Self);
    end;
  finally
    FOpCritical.unlock();
  end; { try/finally }
end;

procedure TWorkerThread.set_state(const Value: TWorkerThreadState);
begin
  FOpCritical.lock();
  FState := Value;
  FOpCritical.unlock();
end;

procedure TWorkerThread.set_thread_pool(AThreadPool: IThreadPool);
begin
  FOpCritical.lock;
  FTP := AThreadPool;
  FOpCritical.unlock;
end;

procedure TWorkerThread.wait_for_state_change;
var
  value: string;
  waitRes: boolean;
  valueInt: Integer;
begin
  // maybe after ORB shutdown
  if ORB_Instance <> nil then
    value := ORB_Instance.get_properties().get_Property('mtdorb.orb.thread_pool_timeout');
  try
    if (FState = wtsIdle) and TryStrToInt(value, valueInt) then
      waitRes := FStateSem.wait(valueInt * 1000)
    else
      waitRes := FStateSem.wait();
  except
    on E: EInterruptedException do
      waitRes := false;
  end; { try/except }
  if not waitRes and (value <> '') and FTP.remove_thread(Self) then begin
    FState := wtsStop;
    register_operation(nil);
  end;
end;

procedure TWorkerThread.ExitHook;
begin
  FTP.remove_thread(Self);
  inherited;
end;

{ TThreadPool }

constructor TThreadPool.Create(AMax, AMaxIdle, AMinIdle: cardinal);
begin
  //FTPLock := TMutex.Create;
  //FBusyThreads := TInterfaceList.Create;//TList.Create;
  FIdleThreads := TInterfaceList.Create;//TList.Create;
  FMonitor := TThreadMonitor.Create;
  FMax := AMax;
  FMaxIdle := AMaxIdle;
  FMinIdle := AMinIdle;
end;

destructor TThreadPool.Destroy;
var
  i: integer;
begin
  Assert(long(FCountAll) = FIdleThreads.Count);
  //terminate all threads
  for i := 0 to FIdleThreads.Count - 1 do
    IWorkerThread(FIdleThreads.Items[i]).Terminate(nil);
  //for i := 0 to FBusyThreads.Count - 1 do
    //IWorkerThread(FBusyThreads.Items[i]).Terminate(nil);

  //FIdleThreads.Free;
  //FBusyThreads.Free;
  //FTPLock.Free;
  FreeAndNil(FMonitor);
  inherited;
end;

// returns - a idle thread or creates a new thread if needed
// - or NIL if limits are exhausted
// removes threads from the idle list
function TThreadPool.get_idle_thread: IWorkerThread;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMonitor);
  // no idle threads
  if FIdleThreads.Count = 0 then begin
    // limit exhausted
    if FCountAll >= FMax then Exit;
    result := TWorkerThread.Create(Self);
    if FOp <> nil then
      result.register_operation(FOp.copy());
    FCountAll := Succ(FCountAll);
    result.Start();
  end
  else begin
    result := IWorkerThread(FIdleThreads.First);
    FIdleThreads.Remove(result);
  end;
  result.set_state(wtsTransition);
end;

function TThreadPool.getInputMC: IMsgChannel;
begin
  result := FInputMC;
end;

function TThreadPool.get_operation: IOperation;
begin
  result := FOp;
end;

function TThreadPool.get_thread_pool_manager: IThreadPoolManager;
begin
  result := FTpm;
end;

function TThreadPool.new_idle_thread: IWorkerThread;
var
  sync: ISynchronized;
begin
  result := TWorkerThread.Create(Self);
  sync := TSynchronized.Create(FMonitor);
  result.SetNo(FIdleThreads.Add(result));
  result.set_state(wtsIdle);
  FCountAll := Succ(FCountAll);
  result.start();
end;

procedure TThreadPool.put_msg(nextOpId: TOperationKind; msgType: IMsgType);
begin
  //FOp.put_msg(nextOpId, msgType);
  if FInputMC <> nil then
    FInputMC.put_msg(nextOpId, msgType);
end;

procedure TThreadPool.registerInputMC(mc: TMsgChannel);
begin
  FInputMC := mc;
  FInputMC.set_thread_pool(Self);
end;

function TThreadPool.remove_thread(kt: IWorkerThread): boolean;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMonitor);
  result := kt.get_state() <> wtsTransition;
  //comment by OVS, 15.07.2002, always remove from list, remove_thread perform
  //after change state from Idle to Stop
  //if kt.get_state = wtsIdle then
    FIdleThreads.Remove(kt);
  if FCountAll > 0 then
    FCountAll := Pred(FCountAll);
end;

procedure TThreadPool.set_operation(op: IOperation);
begin
  FOp := op;
end;

procedure TThreadPool.set_thread_pool_manager(tpm: IThreadPoolManager);
begin
  FTpm := tpm;
end;

// fire up all threads
procedure TThreadPool.start_threads(arg: pointer);
var
  kt: IWorkerThread;
  i: integer;
begin
  for i := 1 to FMinIdle do begin
    kt := new_idle_thread();
    if get_operation() <> nil then kt.register_operation(get_operation().copy());
  end;
end;

procedure TThreadPool.mark_busy(wt: IWorkerThread);
begin
  Assert(wt.get_state() <> wtsIdle);
  wt.set_state(wtsBusy);
end;

procedure TThreadPool.mark_idle(wt: IWorkerThread);
var
  wt_dummy: IWorkerThread;
  sync: ISynchronized;
begin
  if (FInputMC <> nil) and FInputMC.check_msg(wt) then
    Exit;
  if wt.get_state() <> wtsIdle then begin
    sync := TSynchronized.Create(FMonitor);
    wt.SetNo(FIdleThreads.Add(wt));
    wt.set_state(wtsIdle);
    if FCountAll > 0 then
      FMonitor.notifyAll();
    sync := nil;
  end;
  if FInputMC <> nil then
    FInputMC.check_msg(wt_dummy);
end;

function TThreadPool.optype: integer;
begin
  result := FOpType;
end;

procedure TThreadPool.clear;
var
  wt: IWorkerThread;
  list: IInterfaceList;
  idx: integer;
  sync: ISynchronized;
begin
  list := TInterfaceList.Create;
  sync := TSynchronized.Create(FMonitor);
  FOp := nil;
  while long(FCountAll) > FIdleThreads.Count do
    FMonitor.wait();

  idx := 0;
  while idx < FIdleThreads.Count do begin
    list.Add(FIdleThreads.Items[idx]);
    Inc(idx);
  end;
  FInputMC := nil;
  sync := nil;

  while list.Count > 0 do begin
    wt := IWorkerThread(list.Last);
    wt.register_operation(nil);
    wt.set_state(wtsStop);
    //try
      wt.post_state_change();
    //except
      //on ex : Exception do
        //MTDORBLogger.Warning('Error clearing thread: ' + ex.Message);
    //end;
    wt.Wait();
    list.Remove(wt);
    //wt := nil;
  end; { while }
  list := nil;
end;

{ TThreadPoolManager }

constructor TThreadPoolManager.Create();
begin
  FUserCnt := 64;
end;

destructor TThreadPoolManager.Destroy;
var
  i: TOperationKind;
begin
  for i := Low(FTp) to High(FTp) do begin
    FTp[i] := nil;
  end;
  inherited;
end;

function TThreadPoolManager.get_idle_thread(
  const opId: TOperationKind): IWorkerThread;
begin
  result := get_thread_pool(opId).get_idle_thread();
end;

function TThreadPoolManager.get_operation(opId: TOperationKind): IOperation;
begin
  result := get_thread_pool(opId).get_operation();
end;

function TThreadPoolManager.get_thread_pool(
  const opId: TOperationKind): IThreadPool;
begin
  result := FTp[opId];
end;

procedure TThreadPoolManager.put_msg(nextOpId: TOperationKind;
  msgType: IMsgType);
begin
  get_thread_pool(nextOpId).put_msg(nextOpId, msgType);
end;

function TThreadPoolManager.register_new_tp(tp: IThreadPool): _ulong;
begin
  {tp._AddRef;
  FTp.AddObject(IntToStr(FUserCnt), Pointer(tp));
  tp.set_thread_pool_manager(Self as IThreadPoolManager);
  FUserCnt := Succ(FUserCnt);}
  result := FUserCnt;
end;

procedure TThreadPoolManager.register_tp(const opId: TOperationKind;
  tp: IThreadPool);
begin
  FTp[opId] := tp;
end;

procedure TThreadPoolManager.shutdown;
var
  i: TOperationKind;
begin
  for i := Low(FTp) to High(FTp) do begin
  try
    FTp[i].clear();
  except
    on ex: Exception do
      MTDORBLogger.Error('Error in threadpoolmanager shutdown: ' + AnsiString(ex.Message));
  end;
    FTp[i] := nil;
  end;
end;

{ TMTDispatcher }

function TMTDispatcher.copy: IOperation;
begin
  result := TMTDispatcher.Create(Self);
end;

constructor TMTDispatcher.Create;
begin
  inherited;
  FInfo.set_OP_id(odORB);
end;

constructor TMTDispatcher.Create(op: IOperation);
begin
  inherited;
  FInfo.set_OP_id(odORB);
end;

procedure TMTDispatcher.process(msg: IMsgType);
var
  msgRec: IOrbMsg;
begin
  msgRec := IOrbMsg(msg.Data());
  case msgRec.orbEvent() of
    omeKillConn:
      begin
        Assert(msgRec.connection().state = esTerminated);
      end;
    omeCloseConn: begin
      msgRec.callback().giop_callback(msgRec.connection(), Closed);
    end;
  end;
  msgRec._Release();
end;

{ TMTManager }

class procedure TMTManager.ConcurrencyModel(AModel: TConcurrencyModel);
begin
  ConcurrencyModelVar := AModel;
end;

class function TMTManager.ConcurrencyModel: TConcurrencyModel;
begin
  result := ConcurrencyModelVar;
end;

class function TMTManager.ThreadPerConnection: boolean;
begin
  result := ConcurrencyModelVar = cmThreadPerConnection;
end;

class function TMTManager.ThreadPerRequest: boolean;
begin
  result := ConcurrencyModelVar = cmThreadPerRequest;
end;

class function TMTManager.ThreadPool: boolean;
begin
  result := ConcurrencyModelVar = cmThreadPool;
end;

class function TMTManager.ThreadPoolManager: IThreadPoolManager;
begin
  result := tpmVar;
end;

class procedure TMTManager.ThreadSetup(ConnLimit, RequestLimit: integer);
var
  i: integer;
  tpmObj: TThreadPoolManager;
  tpObj: TThreadPool;
  tp: IThreadPool;
  mq: TDirectMsgConnector;
begin
  if not TMTManager.ThreadPool then begin
    // thread-per-connection and thread-per-request concurrency models
    if ConnLimit = 0 then
      Halt(1);
    tmInit[1].max := ConnLimit;
    tmInit[2].max := ConnLimit;
  end
  else begin
    // thread-pool concurrency model
    if ConnLimit > 0 then begin
      tmInit[1].max := ConnLimit;
      tmInit[2].max := ConnLimit;
    end
    else
      // connection checking disabled by -ORBConnLimit 0
      // but we have to set max limit on reader thread pool
      // because this thread-pool is used by client side
      tmInit[2].max := 10;
  end;
  if RequestLimit = 0 then
    Halt(1);
  tmInit[3].max := RequestLimit;

  tpmObj := TThreadPoolManager.Create;
  for i := 0 to tmInitSize-1 do begin
    tpObj := TThreadPool.Create(tmInit[i].max, tmInit[i].max_idle, tmInit[i].min_idle);
    tp := tpObj;
    tpObj.FOpType := ord(tmInit[i].opKind);
    tpmObj.register_tp(tmInit[i].opKind, tp);
    case tmInit[i].opKind of
      odDeCode: tpObj.set_operation(TInputHandler.Create() as IPassiveOperation);
      odORB: tpObj.set_operation(TMTDispatcher.Create() as IPassiveOperation);
    end;
    case tmInit[i].mct of
      mcActive:
        if tmInit[i].mc_size <> 0 then tpObj.registerInputMC(TActiveMsgQueue.Create());
      mcDirect:
        begin
          mq := TDirectMsgConnector.Create;
          mq.set_operation(tpObj.get_operation());
          tpObj.registerInputMC(mq);
        end;
    end;
    if tmInit[i].start then tpObj.start_threads();
  end;
  tpmVar := tpmObj;
end;

class procedure TMTManager.ThreadShutdown;
begin
  tpmVar.shutdown();
end;

initialization
finalization
  tpmVar := nil;
{$ELSE}
implementation
{$ENDIF}
end.
