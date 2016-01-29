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
unit osthread;

interface


{$IFDEF WIN32}
  {$DEFINE MSWINDOWS}
{$ENDIF}

uses
  {$IFDEF WIN32}windows{$ENDIF}{$IFDEF LINUX}Libc,unixtype{$ENDIF}, SysUtils, Classes, orbtypes;

type
  TThreadHandle = {$IFDEF WIN32}THandle{$ENDIF}{$IFDEF LINUX}TThreadID{$ENDIF};
  TMutexAttribute = (maNormal, maRecursive);
  TMutexLockResult = (NoError, InvalidPriority, MutexAlreadyLocked);

  // This class can be used to establish a critical section. Call the
  // lock method to lock the mutex, and the unlock Method to unlock the
  // mutex. If the mutex is currently locked the thread will be
  // suspended until the mutex becomes unlocked
  TMutex = class
  private
    FCrit: TRTLCriticalSection;
  public
    constructor Create(ALocked: boolean = false);
    destructor Destroy; override;
    function trylock(): TMutexLockResult;
    procedure lock();
    procedure unlock();
  end;

  // Unlike the TMutex class this mutex can be locked recursively.
  // That is it can be locked by a thread that already has the mutex
  // locked.
  TRecursiveMutex = class
  private
    FCount: integer;
    FOwner: TThreadHandle;
    FInternal: TMutex;
    FLock: TRTLCriticalSection;
    procedure lock(count: integer); overload;
    function reset_for_condvar(): integer;
    function InternalLock(Count: integer): boolean;
    function InternalUnlock(): boolean;
  public
    constructor Create();
    destructor Destroy; override;
    // Lock the mutex. True is returned if the mutex is was locked for
    // the first time, false otherwise.
    function lock(): boolean; overload;
    // Unlock the mutex. True is returned if the mutex is available
    // for locking by some other thread. False otherwise.
    function unlock(): boolean;
  end;

{$IFDEF MSWINDOWS}
  TSemaphore = class;

  // The condition variable implementation for WIN32. The WIN32
  // implementation of broadcast wakes one waiting thread. Each woken
  // thread then signals the next waiting thread to wake. This approach
  // hopefully should cause the least number of context switches
  // assuming a short wait(), command, wait() cycle.
  TCondImpl = class(TObject)
  private
    // Binary semaphore which protects the blocked count. This
    // semaphore also protects wait() from being re-entered when a
    // broadcast is pending. This must be a sempahore and not a mutex
    // since the lock() and unlock() threads may not be the same.
    FGate: TSemaphore;
    // Semaphore upon which waiting threads are queued
    FQueue: TSemaphore;
    // Internal mutex
    FInternal: TMutex;
    // The number of blocked waiters.
    FBlocked: integer;
    // The number of waiters that have been unblocked.
    FUnblocked: integer;
    // The number of waiters to be unblocked.
    FToUnblock: integer;
    procedure PostWait(ATimeout: boolean);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Signal(ABroadcast: boolean);
    procedure PreWait();
    function Wait(ATimeout: integer): boolean;
  end;
{$ENDIF}

  // This class acts like a pthreads condition variable. The difference
  // is that this implementation works with the recursive mutex
  // implementation in this library.
  TCondVar = class
  private
{$IFDEF WIN32}
    FImpl: TCondImpl;
{$ENDIF}
{$IFDEF LINUX}
    FCond: unixtype.pthread_cond_t;
    FAttr: unixtype.pthread_condattr_t;// Ppthread_condattr_t;
    function CalcTimeout(ATimeout: integer): TTimeSpec;
{$ENDIF}
    // Actual implementation of wait for a recursive mutex.
    function InternalWait(AMutex: TRecursiveMutex; ATimeout: Longint): boolean; overload;
    // Actual implementation of wait for a non-recursive mutex.
    function InternalWait(AMutex: TMutex; ATimeout: Longint): boolean; overload;
  public
    constructor Create();
    destructor  Destroy; override;
    // Wait for the condition variable to be signaled for timeout
    // msec. Returns false if wait() terminated due to a timeout.
    function wait(AMutex: TRecursiveMutex; ATimeout: Longint): boolean; overload;
    // Wait for the condition variable to be signaled for timeout
    // msec. Returns false if wait() terminated due to a timeout.
    function wait(AMutex: TMutex; ATimeout: Longint): boolean; overload;
    // Wait for the condition variable to be signaled.
    procedure wait(AMutex: TRecursiveMutex); overload;
    // Wait for the condition variable to be signaled.
    procedure wait(AMutex: TMutex); overload;
    // Signal all waiting threads.
    procedure broadcast();
    // Signal one waiting thread.
    procedure signal();
  end;

  TSemaphore = class
  private
{$IFDEF WIN32}
    FSema: THandle; // Handle to WIN32 sempahore object.
{$ENDIF}
{$IFDEF LINUX}
    //FSema: sem_t;
    FMutex: TRecursiveMutex;
    FCond: TCondVar;
    FValue: integer;
{$ENDIF}
  public
    constructor Create(val: integer = 0);
    destructor  Destroy; override;
    function wait(timeout: integer = -1): boolean;
    procedure post(count: integer = 1);
  end;

{$DEFINE _THR_CREATE_AND_BLOCK}
  TDetachFlag = (dfDetached, dfNotDetached);
  TThreadErrorType = (teNoError, teInvalidPriority, teMutexAlreadyLocked, teNotStarted, teUnknownError);

  TThreadKey = {$IFDEF WIN32}DWORD{$ENDIF}{$IFDEF LINUX}TPThreadKey{$ENDIF};

  IORBThread = interface
  ['{7BF4A2F2-E458-4A6A-8217-888EA40B33C9}']
    procedure Run();
    function _Arg: Pointer;
    function ReturnValue: integer;
    procedure Finish;
    procedure Wait;
    function Start(Arg: pointer = nil): TThreadErrorType;
    procedure Entrance();
    procedure ExitHook();
    function GetNo: integer;
    procedure SetNo(value: integer);
{$IFDEF WIN32}
    function GetThreadId: THandle;
{$ENDIF}
{$IFDEF LINUX}
    function GetThreadId: Cardinal;
{$ENDIF}
  end;

  TThreadSpecificCleanup = procedure(css: Pointer);

  PTKeyCleanup = ^TKeyCleanup;
  TKeyCleanup = record
    key: TThreadKey;
    release: TThreadSpecificCleanup;
    next: PTKeyCleanup;
  end;

  TThreadSpecificManager = class
  private
    FList: TThreadList;
    FMutex: TMutex;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Allocate(key: TThreadKey; clean_func: TThreadSpecificCleanup);
    procedure Release(key: TThreadKey);
    procedure Cleanup;
    class function Instance: TThreadSpecificManager;
  end;

  // This class encapsulates the functionality of a thread.
  TORBThread = class(TInterfacedObject, IORBThread)
  private
{$IFDEF WIN32}
    FThreadHandle: TThreadHandle;
    FID: THandle;
{$ENDIF}
{$IFDEF LINUX}
    FID: LongWord;
{$ENDIF}
    FDetached: TDetachFlag;
    FReturnValue: integer;
    FNo: integer;
{$IFDEF _THR_CREATE_AND_BLOCK}
    FReady: TMutex;
{$ENDIF _THR_CREATE_AND_BLOCK}
  protected
    FArg: pointer;
    FFinished: boolean;
    function GetNo: integer;
    procedure SetNo(value: integer);
    { IORBThread }
    // Override this method to provide functionality to your thread.
    procedure Run(); virtual; abstract;
    function _Arg: Pointer;
    function ReturnValue: integer;
    procedure Finish;
{$IFDEF WIN32}
    function GetThreadId: THandle;
{$ENDIF}
{$IFDEF LINUX}
    function GetThreadId: Cardinal;
{$ENDIF}
  public
    constructor Create(detached: TDetachFlag = dfNotDetached);
    destructor Destroy; override;
    procedure Entrance();
    procedure ExitHook(); virtual;
    function Start(arg: pointer = nil): TThreadErrorType;
    procedure CreateThread();
    procedure Yield();
    procedure Terminate(exitval: pointer);
    procedure Priority(new_priority: integer);
    procedure Wait();
    // key handling
    class procedure CreateKey(var key: TThreadKey; clean_func: TThreadSpecificCleanup = nil);
    class procedure DeleteKey(key: TThreadKey);
    class function GetSpecific(key: TThreadKey): Pointer;
    class procedure SetSpecific(key: TThreadKey; value: Pointer);
    //
    class function CurrentThread(): TThreadHandle;
    //
    property ID: {$IFDEF WIN32}THandle{$ENDIF}{$IFDEF LINUX}Cardinal{$ENDIF} read GetThreadId;
  end;

  // A monitor is used to ensure that only one thread can have access to
  // the internals of an object at one time. Use the class
  // TSynchronized to automatically lock and unlock a monitor.
  //
  // The TThreadMonitor class also provides an efficient way of notification
  // and suspension of threads. The wait method waits for a notification
  // by another thread. A thread may notify a waiting object with the
  // notify call. A thread may notify all waiting objects with the
  // notifyAll call.
  TThreadMonitor = class
  private
    FMutex: TRecursiveMutex;
    FCondVar: TCondVar; // Monitors condition variable.
    FNNotify: integer; // Number of pending notifications (-1 broadcast).
    procedure lock();
    procedure unlock();
    procedure InternalNotify(NNotify: integer);
  public
    constructor Create;
    destructor Destroy; override;
    // Wait to be signalled for timeout milliseconds.
    procedure wait(timeout: long); overload;
    // Wait for the monitor to be signalled.
    procedure wait(); overload;
    // Wake one waiting object.
    procedure notify();
    // Wake all waiting objects.
    procedure notifyAll();
  end;

  TExecState = (esInit, esActive, esInitShutdown, esShutdown, esTerminated);

  TStateRefCount = class
  private
    FExecState: TExecState;
    FActiveRefs: _ulong;
    FMutex: TRecursiveMutex;
    FCondVar: TCondVar;
  public
    constructor Create;
    destructor Destroy; override;
    function activeRef(): boolean;
    procedure activeDeref();
    function StateChange(es: TExecState): boolean;
    function State(): TExecState;
    function InitShutdown(): boolean;
  end;

  TRWLock = class
  private
    FCount: integer;
    FWaitingWriters: integer;
    FMutex: TMutex;
    FOkToRead: TCondVar;
    FOkToWrite: TCondVar;
    procedure InternalReadLock();
    procedure InternalWriteLock();
    procedure InternalUnlock();
  public
    constructor Create;
    destructor Destroy; override;
    procedure rdlock();
    procedure wrlock();
    procedure rdunlock();
    procedure wrunlock();
    procedure unlock();
  end;

  ISynchronized = interface
  ['{D7BAAEFB-9F2E-4EDF-996C-43184F696CF3}']
  end;

  TLockType = (ltMonitor, ltMutex, ltRecursiveMutex, ltRWLock);

  TSynchronized = class(TInterfacedObject, ISynchronized)
  private
    FMonitor: TThreadMonitor;
    FMutex: TMutex;
    FRecursiveMutex: TRecursiveMutex;
    FRWLock: TRWLock;
    FLockType: TLockType;
  public
    constructor Create(AMonitor: TThreadMonitor); overload;
    constructor Create(AMutex: TMutex); overload;
    constructor Create(AMutex: TRecursiveMutex); overload;
    constructor Create(ARWLock: TRWLock; AReadLock: boolean = true); overload;
    destructor Destroy; override;
  end;

function ThreadSpecificManager_Instance: TThreadSpecificManager;

implementation

uses internalexceptions, mtdebug;

{$IFDEF MSWINDOWS}
const
  TryEnterCriticalSection: function(var lpCriticalSection: TRTLCriticalSection): BOOL; stdcall = nil;
var
  Kernel32Handle: HMODULE;
{$ENDIF}

var
  threadSpecificManager: TThreadSpecificManager;
  threadSpecificManagerCreateMutex: TMutex;
//threadvar
  //threadSpecific: pointer;

{$IFNDEF USELIB}
function ThreadSpecificManager_Instance: TThreadSpecificManager;
begin
  result := TThreadSpecificManager.Instance;
end;
{$ELSE}
function ThreadSpecificManager_Instance: TThreadSpecificManager; external MTDORB_Library_Name;
{$ENDIF}


{ TMutex }

constructor TMutex.Create(ALocked: boolean);
{$IFDEF LINUX}
var
  attr: Libc.TMutexAttribute;
{$ENDIF}
begin
{$IFDEF WIN32}
  InitializeCriticalSection(FCrit);
{$ENDIF}
{$IFDEF LINUX}
  pthread_mutexattr_settype(attr, PTHREAD_MUTEX_NORMAL);
  pthread_mutex_init(FCrit, attr); // not recursive
{$ENDIF}
  if ALocked then lock;
end;

destructor TMutex.Destroy;
begin
  DeleteCriticalSection(FCrit);
  inherited;
end;

// Lock the mutex.
procedure TMutex.lock;
begin
  EnterCriticalSection(FCrit);
end;

// Try lock the mutex.
function TMutex.trylock: TMutexLockResult;
begin
{$IFDEF MSWINDOWS}
  if Assigned(TryEnterCriticalSection) then begin
{$ENDIF}
    if TryEnterCriticalSection(FCrit) then
      result := NoError
    else
      result := MutexAlreadyLocked;
{$IFDEF MSWINDOWS}
  end
  else
    result := NoError;
{$ENDIF}
end;

// Unlock the mutex.
procedure TMutex.unlock;
begin
  LeaveCriticalSection(FCrit);
end;

{ TCondVar }

//
// Wake all waiting threads.
//
procedure TCondVar.broadcast;
begin
{$IFDEF WIN32}
  FImpl.Signal(true);
{$ENDIF}
{$IFDEF LINUX}
  pthread_cond_broadcast(@FCond);
{$ENDIF}
end;

{$IFDEF LINUX}
function TCondVar.CalcTimeout(ATimeout: integer): TTimeSpec;
const
  oneBillion = 1000000000;
var
  tv: Libc.TTimeVal;
  tz: ^TTimezone;
begin
  Assert(ATimeout >= 0);
  tz := nil;
  gettimeofday(tv, tz^);
  result.tv_sec := tv.tv_sec + (ATimeout div 1000);
  result.tv_nsec := (tv.tv_usec * 1000) + ((ATimeout mod 1000) * 1000000);
  if result.tv_nsec > oneBillion then begin
    Inc(result.tv_sec);
    result.tv_nsec := result.tv_nsec - oneBillion;
  end;
end;
{$ENDIF}

constructor TCondVar.Create();
begin
{$IFDEF WIN32}
  FImpl := TCondImpl.Create;
{$ENDIF}
{$IFDEF LINUX}
  pthread_condattr_init(@FAttr);
  pthread_cond_init(@FCond, @FAttr);
{$ENDIF}
end;

destructor TCondVar.Destroy;
begin
{$IFDEF WIN32}
  FreeAndNil(FImpl);
{$ENDIF}
{$IFDEF LINUX}
  pthread_cond_destroy(@FCond);
  pthread_condattr_destroy(@FAttr);
{$ENDIF}
  inherited;
end;

{$IFDEF LINUX}
type
  TCondHelper = class
  private
    FMutex: TRecursiveMutex;
    FCount: integer;
  public
    constructor Create(AMutex: TRecursiveMutex; ACount: integer);
    destructor Destroy; override;
  end;

{ TCondHelper }

constructor TCondHelper.Create(AMutex: TRecursiveMutex; ACount: integer);
begin
  FMutex := AMutex;
  FCount := ACount;
end;

destructor TCondHelper.Destroy;
begin
  // We need to acquire the mutex rationally... We unlock the
  // mutexes critical section, and lock the mutex.  Restore
  // saved information. NOTE: It's not correct to set the count
  // and the owner of the mutex, the lock API method MUST be
  // called.
  pthread_mutex_unlock(FMutex.FLock);
  FMutex.lock(FCount);
  inherited;
end;
{$ENDIF}

// Wait for the condition variable to be signaled. A timeout value
// of -1 means wait forever. Otherwise, only wait for timeout
// milliseconds.
function TCondVar.InternalWait(AMutex: TRecursiveMutex; ATimeout: Longint): boolean;
var
  count: integer;
{$IFDEF LINUX}
  abstime: TTimeSpec;
  unlock: TCondHelper;
  sysError: integer;
{$ENDIF}
begin
{$IFDEF LINUX}
  result := true;
  try
  
    count := AMutex.reset_for_condvar();
    //unlock.Create(AMutex, count);
    try
      if (ATimeout < 0) then begin
        sysError := pthread_cond_wait(@FCond, @AMutex.FLock);
        if sysError <> 0 then
          raise ESystemCallException.Create('pthread_cond_wait', sysError);
      end
      else begin
        // Calculate the timeout period.
        abstime := CalcTimeout(ATimeout);
        sysError := pthread_cond_timedwait(@FCond, @AMutex.FLock, @abstime);
        if sysError <> 0 then
          raise ESystemCallException.Create('pthread_cond_timedwait', sysError);
      end;
    finally
      //unlock.Free;
      pthread_mutex_unlock(AMutex.FLock);
      AMutex.lock(count);
    end;
  except
    on E: ESystemCallException do begin
      // EINTR is translated to InterruptedException.
      if (E.GetError() = EINTR) then
        raise EInterruptedException.Create()
      // EAGAIN means that the wait time has passed.
      else if (E.GetError() = EAGAIN) or ((E.GetError() = ETIMEDOUT) and (ATimeout >= 0)) then
        result := false
      else
        // Rethrow caught exception.
        raise;
    end;
  end;
{$ENDIF}
{$IFDEF WIN32}
  FImpl.PreWait();

  count := AMutex.reset_for_condvar();
  try
    result := FImpl.Wait(ATimeout);
  finally
    AMutex.lock(count);
  end; { try/finally }
{$ENDIF}
end;

// Wait for the condition variable to be signaled. A timeout value
// of -1 means wait forever. Otherwise, only wait for timeout
// milliseconds.
function TCondVar.InternalWait(AMutex: TMutex; ATimeout: Integer): boolean;
{$IFDEF LINUX}
var
  sysError: integer;
  abstime: TTimeSpec;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  FImpl.PreWait();

  AMutex.unlock();
  try
    result := FImpl.Wait(ATimeout);
  finally
    AMutex.lock();
  end; { try/finally }
{$ENDIF}
{$IFDEF LINUX}
  result := true;
  try
    if (ATimeout < 0) then begin
      sysError := pthread_cond_wait(@FCond, @AMutex.FCrit);
      if sysError <> 0 then
        raise ESystemCallException.Create('pthread_cond_wait', sysError);
    end
    else begin
      // Calculate the timeout period.
      abstime := CalcTimeout(ATimeout);
      sysError := pthread_cond_timedwait(@FCond, @AMutex.FCrit, @abstime);
      if sysError <> 0 then
        raise ESystemCallException.Create('pthread_cond_timedwait', sysError);
    end;
  except
    on E: ESystemCallException do begin
      // EINTR is translated to InterruptedException.
      if (E.GetError() = EINTR) then
        raise EInterruptedException.Create()
      // EAGAIN means that the wait time has passed.
      else if (E.GetError() = EAGAIN) or ((E.GetError() = ETIMEDOUT) and (ATimeout >= 0)) then
        result := false
      else
        // Rethrow caught exception.
        raise;
    end;
  end;
{$ENDIF}
end;

procedure TCondVar.signal;
begin
{$IFDEF WIN32}
  FImpl.Signal(false);
{$ENDIF}
{$IFDEF LINUX}
  pthread_cond_signal(@FCond);
{$ENDIF}
end;

function TCondVar.wait(AMutex: TMutex; ATimeout: Longint): boolean;
begin
  if ATimeout < 0 then
    raise EIllegalArgumentException.Create('timeout value is negative');
  result := InternalWait(AMutex, ATimeout);
end;

function TCondVar.wait(AMutex: TRecursiveMutex; ATimeout: Longint): boolean;
begin
  if ATimeout < 0 then
    raise EIllegalArgumentException.Create('timeout value is negative');
  result := InternalWait(AMutex, ATimeout);
end;

procedure TCondVar.wait(AMutex: TRecursiveMutex);
begin
  InternalWait(AMutex, -1);
end;

procedure TCondVar.wait(AMutex: TMutex);
begin
  InternalWait(AMutex, -1);
end;

{ TSemaphore }

constructor TSemaphore.Create(val: integer);
begin
{$IFDEF WIN32}
  FSema := CreateSemaphore(nil, val, $7fffffff, nil);
  if FSema = INVALID_HANDLE_VALUE then
    raise ESystemCallException.Create('CreateSemaphore', GetLastError());
{$ENDIF}
{$IFDEF LINUX}
  //sem_init(FSema, false, val);
  FMutex := TRecursiveMutex.Create();
  FCond := TCondVar.Create();
  FValue := val;
{$ENDIF}
end;

destructor TSemaphore.Destroy;
begin
{$IFDEF WIN32}
  CloseHandle(FSema);
  //FSema := INVALID_HANDLE_VALUE;
{$ENDIF}
{$IFDEF LINUX}
  //sem_destroy(FSema);
  FreeAndNil(FMutex);
  FreeAndNil(FCond);
{$ENDIF}
  inherited;
end;

procedure TSemaphore.post(count: integer);
begin
{$IFDEF WIN32}
    if not ReleaseSemaphore(FSema, count, nil) then
      raise ESystemCallException.Create('ReleaseSemaphore', GetLastError());
{$ENDIF}
{$IFDEF LINUX}
  //sem_post(FSema);
  FMutex.lock;
  try
    Inc(FValue);
  finally
    FMutex.unlock;
  end;
  FCond.signal;
{$ENDIF}
end;

function TSemaphore.wait(timeout: integer): boolean;
{$IFDEF LINUX}
const
  oneBillion = 1000000000;
{$ENDIF}
var
{$IFDEF WIN32}
  tm: LongWord;
  res: DWORD;
{$ENDIF}
{$IFDEF LINUX}
  sync: ISynchronized;
{$ENDIF}
begin
{$IFDEF WIN32}
  if timeout = -1 then
    tm := INFINITE
  else
    tm := timeout;
  res := WaitForSingleObject(FSema, tm);
  if res = WAIT_ABANDONED then
    raise ESystemCallException.Create('WaitForSingleObject', GetLastError());
  result := res <> WAIT_TIMEOUT;
{$ENDIF}
{$IFDEF LINUX}
  {if timeout = -1 then begin
    result := EINTR;
    while result = EINTR do
      result := sem_wait(FSema);
  end
  else begin
    gettimeofday(tv, nil);
    abstime.tv_sec := tv.tv_sec + (timeout div 1000);
    abstime.tv_nsec := (tv.tv_usec * 1000) + ((timeout mod 1000) * 1000000);
    if abstime.tv_nsec > oneBillion then begin
      Inc(abstime.tv_sec);
      abstime.tv_nsec := abstime.tv_nsec - oneBillion;
    end;
    result := sem_timedwait(FSema, abstime);
  end;}
  result := true;
  sync := TSynchronized.Create(FMutex);
  while (FValue = 0) and result do
    if (timeout = -1) then
      FCond.wait(FMutex)
    else
      result := FCond.wait(FMutex, timeout);
  if result then
    Dec(FValue);
{$ENDIF}
end;

{ TORBThread }

{$IFDEF WIN32}
const
  levelMap: array [0..2] of integer = (
    THREAD_PRIORITY_LOWEST,
    THREAD_PRIORITY_NORMAL,
    THREAD_PRIORITY_HIGHEST
  );
{$ENDIF}

// Start the thread.  
procedure TORBThread.Entrance();
begin
{$IFDEF _THR_CREATE_AND_BLOCK}
  FReady.lock();
{$ENDIF _THR_CREATE_AND_BLOCK}
  Run();
end;

constructor TORBThread.Create(detached: TDetachFlag);
begin
  FDetached := detached;
{$IFDEF _THR_CREATE_AND_BLOCK}
  FReady := TMutex.Create;
  CreateThread();
{$ENDIF _THR_CREATE_AND_BLOCK}
end;

function ThreadFunc({AThread: IORBThread}p : Pointer): integer;
var
  manager: TThreadSpecificManager;
begin
  try
    try
      IORBThread(p).Entrance();
    except
      //consume
      on E: Exception do
        MTDORBLogger.Error(AnsiString(Format('UncaughtException: %s.%s %s', [E.Message, sLineBreak, CallStackTextualRepresentation()])));
      else
        MTDORBLogger.Error(AnsiString(Format('UncaughtException: %s%s', [sLineBreak, CallStackTextualRepresentation()])));
    end; { try/except }
    try
      IORBThread(p).ExitHook();
    except
      MTDORBLogger.Error(AnsiString(Format('UncaughtException: %s%s', [sLineBreak, CallStackTextualRepresentation()])));
      //consume
    end; { try/except }
  finally
    result := IORBThread(p).ReturnValue;
    IORBThread(p).Finish; 
    manager := TThreadSpecificManager.Instance;
    if manager <> nil then
      manager.Cleanup();
    IORBThread(p) := nil;
    EndThread(Result);
  end; { try/finally }
end;

procedure TORBThread.CreateThread;
{$IFDEF LINUX}
var
  sysError: Integer;
{$ENDIF}
begin
{$IFDEF _THR_CREATE_AND_BLOCK}
  FReady.lock();
{$ENDIF}
{$IFDEF WIN32}
  try
    FThreadHandle := BeginThread(nil, 0, @ThreadFunc, Pointer(Self as IORBThread), 0, FID);
    if FThreadHandle = 0 then
      raise ESystemCallException.Create('BeginThread', GetLastError());
  except
    on E: ESystemCallException do
      if (E.GetError = ERROR_NOT_ENOUGH_MEMORY) or (E.GetError = ERROR_OUTOFMEMORY) then
        OutOfMemoryError
      else
        raise;
  end; { try/except }
{$ENDIF}
{$IFDEF LINUX}
  try
//    sysError := 0;
//    sysError := BeginThread(nil, @ThreadFunc, Pointer(Self as IORBThread), FID);
//    WriteLn('Begin thread...');
    sysError := BeginThread(@ThreadFunc, Pointer(Self as IORBThread), FID);
    //if sysError <> 0 then
    //begin
    //  WriteLn('Exception!');
    //  raise ESystemCallException.Create('BeginThread', sysError);
    //end;
    if FDetached = dfDetached then
      pthread_detach(FID);
  except
    on E: ESystemCallException do
      if (E.GetError = EAGAIN) or (E.GetError = ENOMEM) then
        OutOfMemoryError
      else
        raise;
  end; { try/except }
{$ENDIF}
end;

destructor TORBThread.Destroy;
begin
  if not FFinished then
    wait();
{$IFDEF _THR_CREATE_AND_BLOCK}
  if Assigned(FReady) then
  begin
    FReady.unlock();
    try
      FreeAndNil(FReady);
    except
      on ex : Exception do
        MTDORBLogger.Error('Error in TORBThread.Destroy: ' + AnsiString(ex.Message));
    end;
  end;
{$ENDIF _THR_CREATE_AND_BLOCK}
{$IFDEF MSWINDOWS}
  if FThreadHandle <> 0 then
  begin
    CloseHandle(FThreadHandle);
    FThreadHandle := 0;
  end;
{$ENDIF}
{$IFDEF LINUX}
  // This final check is to ensure that even if the thread was never waited on
  // its resources will be freed.
  if FID <> 0 then
    pthread_detach(FID);
{$ENDIF}
  inherited;
end;

// Set the priority of this thread.
procedure TORBThread.Priority(new_priority: integer);
begin
{$IFDEF WIN32}
  SetThreadPriority(FThreadHandle, levelMap[new_priority]);
{$ENDIF}
end;

// Start the thread ala JAVA:
function TORBThread.Start(Arg: pointer): TThreadErrorType;
begin
  FArg := Arg;
{$IFDEF _THR_CREATE_AND_BLOCK}
  FReady.unlock();
  result := teNoError;
{$ELSE}
  result := CreateThread();
{$ENDIF _THR_CREATE_AND_BLOCK}
end;

// Tell this thread to die.
procedure TORBThread.Terminate(exitval: pointer);
begin
{$IFDEF WIN32}
  TerminateThread(FThreadHandle, PInteger(exitval)^);
{$ENDIF}
{$IFDEF LINUX}
  pthread_cancel(FID);
{$ENDIF}
end;

// Wait for this thread to finish.
procedure TORBThread.Wait;
{$IFDEF LINUX}
var
   status:Pointer;
{$ENDIF}
begin
{$IFDEF WIN32}
  WaitForSingleObject(FThreadHandle, INFINITE);
{$ENDIF}
{$IFDEF LINUX}
  status := nil;
  pthread_join(FID, status);
{$ENDIF}
end;

// Yield the current threads timeslice.
procedure TORBThread.Yield;
begin
{$IFDEF WIN32}
  //yield(); //win16
  Sleep(0);
{$ENDIF}
{$IFDEF LINUX}
  sched_yield();
{$ENDIF}
end;

{$IFDEF WIN32}
function TORBThread.GetThreadId: THandle;
{$ENDIF}
{$IFDEF LINUX}
function TORBThread.GetThreadId: Cardinal;
{$ENDIF}
begin
  result := FID;
end;

function TORBThread.GetNo: integer;
begin
  result := FNo;
end;

procedure TORBThread.SetNo(value: integer);
begin
  FNo := value;
end;

class procedure TORBThread.CreateKey(var key: TThreadKey; clean_func: TThreadSpecificCleanup);
begin
{$IFDEF WIN32}
  key := TlsAlloc();
{$ENDIF}
{$IFDEF LINUX}
  pthread_key_create(key, nil);
{$ENDIF}
  TThreadSpecificManager.Instance.Allocate(key, clean_func);
end;

class procedure TORBThread.DeleteKey(key: TThreadKey);
var
  manager: TThreadSpecificManager;
begin
  // It's possible that release is called after the Thread Specific Manager
  // has already been destroyed -- although this is technically
  // an error, just ignore it.
  manager := TThreadSpecificManager.Instance;
  if manager <> nil then
    manager.Release(key);
{$IFDEF WIN32}
  TlsFree(key);
{$ENDIF}
{$IFDEF LINUX}
  pthread_key_delete(key);
{$ENDIF}
end;

class function TORBThread.GetSpecific(key: TThreadKey): Pointer;
begin
{$IFDEF WIN32}
  result := TlsGetValue(key);
{$ENDIF}
{$IFDEF LINUX}
  result := pthread_getspecific(key);
{$ENDIF}
end;

class procedure TORBThread.SetSpecific(key: TThreadKey; value: Pointer);
begin
{$IFDEF WIN32}
  TlsSetValue(key, value);
{$ENDIF}
{$IFDEF LINUX}
  pthread_setspecific(key, value);
{$ENDIF}
end;

function TORBThread._Arg: Pointer;
begin
  result := FArg;
end;

function TORBThread.ReturnValue: integer;
begin
  result := FReturnValue;
end;

procedure TORBThread.Finish;
begin
  FFinished := true;
end;

procedure TORBThread.ExitHook();
begin
end;

class function TORBThread.CurrentThread: TThreadHandle;
begin
  result := GetCurrentThreadID();
end;

{ TRWLock }

constructor TRWLock.Create;
begin
  FMutex := TMutex.Create();
  FOkToRead := TCondVar.Create();
  FOkToWrite := TCondVar.Create();
end;

destructor TRWLock.Destroy;
begin
  FreeAndNil(FMutex);
  FreeAndNil(FOkToRead);
  FreeAndNil(FOkToWrite);
  inherited;
end;

procedure TRWLock.InternalReadLock;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMutex);

  // Wait while a writer holds the lock or while writers are waiting
  // to get the lock.
  while (FCount < 0) or (FWaitingWriters <> 0) do
      FOkToRead.wait(FMutex);
  FCount := Succ(FCount);
end;

procedure TRWLock.InternalUnlock;
var
  ww: boolean;
  wr: boolean;
begin
  FMutex.lock;
  try
    Assert(FCount <> 0);

    // If FCount < 0, the calling thread is a writer that holds the
    // lock, so release the lock.  Otherwise, FCount is guaranteed to
    // be > 0, so the calling thread is a reader releasing the lock.
    //
    if (FCount < 0) then
      // Writer called unlock
      FCount := 0
    else
      // Reader called unlock
      FCount := Pred(FCount);

    // Writers are waiting (ww) if FWaitingWriters > 0.  In that
    // case, it's OK to let another writer into the region once there
    // are no more readers (m_count == 0).  Otherwise, no writers are
    // waiting but readers may be waiting (wr).
    ww := (FWaitingWriters <> 0) and (FCount = 0);
    wr := (FWaitingWriters = 0);
  finally
    FMutex.unlock;
  end; { try/finally }

  // Wake up a waiting writer if there is one. If not, wake up all
  // readers (just in case -- there may be none).
  if ww then
    // Wake writer
    FOkToWrite.signal()
  else if wr then
    // Wake readers
    FOkToRead.broadcast();
end;

procedure TRWLock.InternalWriteLock;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMutex);

  // Wait for the lock to become available and increment the number
  // of waiting writers.
  while (FCount <> 0) do begin
    FWaitingWriters := Succ(FWaitingWriters);
    try
      //TODO: Exception
      FOkToWrite.wait(FMutex);
    finally
      FWaitingWriters := Pred(FWaitingWriters);
    end; { try/finally }
  end;

  // Got the lock, indicate it's held by a writer.
  FCount := -1;
end;

procedure TRWLock.rdlock;
begin
  InternalReadLock;
end;

procedure TRWLock.rdunlock;
begin
  InternalUnlock;
end;

procedure TRWLock.unlock;
begin
  InternalUnlock();
end;

procedure TRWLock.wrlock;
begin
  InternalWriteLock;
end;

procedure TRWLock.wrunlock;
begin
  InternalUnlock;
end;

{ TStateRefCount }

procedure TStateRefCount.activeDeref;
begin
  FMutex.lock();
  try
    if (FActiveRefs > 0) then
      FActiveRefs := Pred(FActiveRefs);
    if (FActiveRefs = 0) and (FExecState <> esActive) then
      FCondVar.signal();
  finally
    FMutex.unlock();
  end; { try/finally }
end;

function TStateRefCount.activeRef: boolean;
begin
  FMutex.lock();
  try
    result := FExecState = esActive;
    if result then FActiveRefs := Succ(FActiveRefs);
  finally
    FMutex.unlock();
  end; { try/finally }
end;

constructor TStateRefCount.Create;
begin
  FMutex := TRecursiveMutex.Create;
  FCondVar := TCondVar.Create();
  FExecState := esInit;
  FActiveRefs := 0;
end;

destructor TStateRefCount.Destroy;
begin
  FreeAndNil(FCondVar);
  FreeAndNil(FMutex);
  inherited;
end;

function TStateRefCount.InitShutdown: boolean;
begin
  FMutex.lock();
  try
    result := FExecState = esActive;
    if result then FExecState := esInitShutdown;
  finally
    FMutex.unlock();
  end; { try/finally }
end;

function TStateRefCount.State: TExecState;
begin
  result := FExecState;
end;

function TStateRefCount.StateChange(es: TExecState): boolean;
begin
  FMutex.lock();
  try
    result := es > FExecState;
    if result then begin
      FExecState := es;
      // wait until the state change has become effective
      while FActiveRefs <> 0 do
        FCondVar.wait(FMutex);
    end;
  finally
    FMutex.unlock();
  end; { try/finally }
end;

{ TThreadSpecificManager }

procedure TThreadSpecificManager.Allocate(key: TThreadKey;
  clean_func: TThreadSpecificCleanup);
var
  node: PTKeyCleanup;
  list: TList;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMutex);
  list := FList.LockList;
  try
    node := AllocMem(SizeOf(TKeyCleanup));
    node^.key := key;
    node^.release := clean_func;
    list.Add(node);
  finally
    FList.UnlockList;
  end; { try/finally }
  {node := AllocMem(SizeOf(TKeyCleanup));
  node^.key := key;
  node^.release := clean_func;
  node^.next := FHead;
  FHead := node;}
end;

procedure TThreadSpecificManager.Cleanup;
var
  list: TList;
  i: integer;
  data: Pointer;
  node: PTKeyCleanup;
  cleanfunc: TThreadSpecificCleanup;
begin
  list := FList.LockList;
  try
    i := list.Count - 1;
    while i >= 0 do begin
      node := PTKeyCleanup(list.Items[i]);
      data := TORBThread.getSpecific(node^.key);
      cleanfunc := node^.release;
      cleanfunc(data);
      TORBThread.setSpecific(node^.key, nil);
      i := Pred(i);
    end; { while }
  finally
    FList.UnlockList;
  end; { try/finally }
end;

constructor TThreadSpecificManager.Create;
begin
  FMutex := TMutex.Create;
  FList := TThreadList.Create;
end;

destructor TThreadSpecificManager.Destroy;
begin
  FreeAndNil(FMutex);
  FreeAndNil(FList);
  inherited;
end;

class function TThreadSpecificManager.Instance: TThreadSpecificManager;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(threadSpecificManagerCreateMutex);
  if threadSpecificManager = nil then
    threadSpecificManager := TThreadSpecificManager.Create;
  result := threadSpecificManager;
end;

procedure TThreadSpecificManager.Release(key: TThreadKey);
var
  list: TList;
  i: integer;
begin
  list := FList.LockList;
  try
    i := list.Count - 1;
    while i >= 0 do begin
      if PTKeyCleanup(list.Items[i])^.key = key then
        Break;
      i := Pred(i);
    end; { while }
    if i >= 0 then begin
      FreeMem(list.Items[i], SizeOf(TKeyCleanup));
      list.Delete(i);
    end;
  finally
    FList.UnlockList;
  end; { try/finally }
end;

{ TThreadMonitor }

constructor TThreadMonitor.Create;
begin
  FMutex := TRecursiveMutex.Create();
  FCondVar := TCondVar.Create();
end;

destructor TThreadMonitor.Destroy;
begin
  FreeAndNil(FMutex);
  FreeAndNil(FCondVar);
  inherited;
end;

// Perform any pending notifications.
procedure TThreadMonitor.InternalNotify(NNotify: integer);
begin
  // Zero indicates no notifies.
  if (NNotify <> 0) then begin
    // -1 means notifyAll.
    if (NNotify = -1) then begin
      FCondVar.broadcast();
      Exit;
    end
    else begin
      // Otherwise notify n times.
      while (NNotify > 0) do begin
        FCondVar.signal();
        NNotify := Pred(NNotify);
      end;
    end;
  end;
end;

// Lock the monitors mutex.
procedure TThreadMonitor.lock;
begin
  // On the first mutex acquisition set the number of notifies
  // to 0.
  if FMutex.lock() then
    FNNotify := 0;
end;

// Wake one waiting thread.
procedure TThreadMonitor.notify;
begin
  // Increment the m_nnotify flag, unless a broadcast has already
  // been requested.
  if (FNNotify <> -1) then
    FNNotify := Succ(FNNotify);
end;

// Wake all waiting threads.
procedure TThreadMonitor.notifyAll;
begin
  // Set the m_nnotify flag to -1 (indicates broadcast)
  FNNotify := -1;
end;

// Unlock the monitors mutex.
procedure TThreadMonitor.unlock;
var
  nnotify: integer;
begin
  nnotify := FNNotify;
  // Perform any pending notifies
  if FMutex.unlock() then
    InternalNotify(nnotify);
end;

procedure TThreadMonitor.wait(timeout: long);
begin
  // Perform any pending notifies.
  InternalNotify(FNNotify);

  // Wait for a notification.
  try
    FCondVar.wait(FMutex, timeout);
  finally
    // Reset the nnotify count once wait() returns.
    FNNotify := 0;
  end; { try/finally }
end;

procedure TThreadMonitor.wait;
begin
  // Perform any pending notifies.
  InternalNotify(FNNotify);

  // Wait for a notification.
  try
    FCondVar.wait(FMutex);
  finally
    // Reset the nnotify count once wait() returns.
    FNNotify := 0;
  end; { try/finally }
end;

{ TSynchronized }

constructor TSynchronized.Create(AMonitor: TThreadMonitor);
begin
  FLockType := ltMonitor;
  FMonitor := AMonitor;
  FMonitor.lock();
end;

constructor TSynchronized.Create(AMutex: TMutex);
begin
  FLockType := ltMutex;
  FMutex := AMutex;
  FMutex.lock();
end;

constructor TSynchronized.Create(AMutex: TRecursiveMutex);
begin
  FLockType := ltRecursiveMutex;
  FRecursiveMutex := AMutex;
  FRecursiveMutex.lock();
end;

constructor TSynchronized.Create(ARWLock: TRWLock; AReadLock: boolean);
begin
  FLockType := ltRWLock;
  FRWLock := ARWLock;
  if AReadLock then
    FRWLock.rdlock()
  else
    FRWLock.wrlock();
end;

destructor TSynchronized.Destroy;
begin
  case FLockType of
    ltMonitor: FMonitor.unlock();
    ltMutex: FMutex.unlock();
    ltRecursiveMutex: FRecursiveMutex.unlock();
    ltRWLock: FRWLock.unlock();
  end;
  inherited;
end;

{ TRecursiveMutex }

constructor TRecursiveMutex.Create;
{$IFDEF LINUX}
var
  attr: Libc.TMutexAttribute;
{$ENDIF}
begin
  FInternal := TMutex.Create;
{$IFDEF WIN32}
  InitializeCriticalSection(FLock);
{$ENDIF}
{$IFDEF LINUX}
  pthread_mutexattr_settype(attr, PTHREAD_MUTEX_NORMAL);
  pthread_mutex_init(FLock, attr); // not recursive
{$ENDIF}
end;

destructor TRecursiveMutex.Destroy;
begin
  DeleteCriticalSection(FLock);
  FreeAndNil(FInternal);
  inherited;
end;

function TRecursiveMutex.InternalLock(Count: integer): boolean;
var
  obtained: boolean;
begin
  result := false;

  // This flag is set to true once the mutex has been obtained.
  obtained := false;
  while not obtained do begin
    // Lock the internal mutex.
    FInternal.lock();

    // FCount represents the number of times the mutex has been
    // aquired.  If FCount is zero then the mutex is not yet
    // aquired.  Note that two mutexes cannot be in here at once,
    // since this CS is protected by the mutex m_internal.
    //
    if (FCount = 0) then begin
      // We're attempting to aquire the mutex count more times.
      FCount := Count;
      FOwner := TORBThread.CurrentThread();
      obtained := true;
      result := true;

      // Acquire the mutexes critical section.
      try
        EnterCriticalSection(FLock);
      except
        try
          FInternal.unlock();
        except
        end;
        raise;
      end
    end
    //
    // Otherwise m_count is non-zero.  This means that the mutex is
    // currently aquired.  There are two cases here:
    //
    // - The mutex is owned by the caller. Simply increment the
    //   count in this case.
    //
    // - The mutex is owned by a thread other than the caller. In
    //   this case we attempt to aquire the mutexes critical
    //   section. This CS is unlocked once mutex is released m_count
    //   times.
    //
    else if (FOwner = TORBThread.CurrentThread()) then begin
      FCount := Succ(Count);
      obtained := true;
    end;
    FInternal.unlock();

    // If we haven't yet obtained the mutex lock the critical
    // section mutex.  Immediately unlock the CS, then attempt to
    // re-obtain.
    if not obtained then begin
      EnterCriticalSection(FLock);
      LeaveCriticalSection(FLock);
    end;
  end;
end;

function TRecursiveMutex.InternalUnlock: boolean;
begin
  // Aquire the internal mutex.
  FInternal.lock();
  // If FCount decrements to zero then unlock the mutexes CS. The
  // mutex is no longer owned by a thread.
  FCount := Pred(FCount);
  if FCount = 0 then begin
    FOwner := TORBThread.CurrentThread();
    LeaveCriticalSection(FLock);
    result := true;
  end
  else
    result := false;
  FInternal.unlock();
end;

function TRecursiveMutex.lock(): boolean;
begin
  // Work around lack of mutable.
  result := Self.InternalLock(1);
end;

procedure TRecursiveMutex.lock(count: integer);
begin
  // Work around lack of mutable.
  Self.InternalLock(count);
end;

function TRecursiveMutex.reset_for_condvar: integer;
begin
  FInternal.lock();

  result := FCount;
  FCount := 0;
  FOwner := TORBThread.CurrentThread();

  FInternal.unlock();

{$IFDEF MSWINDOWS}
  // Under NT the actual mutex has to be unlocked. For pthreads the
  // condvar implementation takes care of this.
  LeaveCriticalSection(FLock);
{$ENDIF}
end;

function TRecursiveMutex.unlock(): boolean;
begin
  // Work around lack of mutable.
  result := Self.InternalUnlock();
end;

{$IFDEF MSWINDOWS}

{ TCondImpl }

constructor TCondImpl.Create;
begin
  FGate := TSemaphore.Create(1);
  FQueue := TSemaphore.Create;
  FInternal := TMutex.Create;
end;

destructor TCondImpl.Destroy;
begin
  FreeAndNil(FGate);
  FreeAndNil(FQueue);
  FreeAndNil(FInternal);
  inherited;
end;

procedure TCondImpl.PostWait(ATimeout: boolean);
var
  last: boolean;
begin
  // Acquire the internal mutex, there is one more unblocked
  // thread.
  FInternal.lock();
  FUnblocked := Succ(FUnblocked);

  // Determine the action, release the internal mutex. If there
  // are no threads to unblock wait() on the queue returned as a
  // result of a timeout.
  if (FToUnblock <> 0) then begin
    FToUnblock := Pred(FToUnblock);
    last := FToUnblock = 0;
    FInternal.unlock();

    // If the wait() terminated as a consequence of a timeout
    // then consume one of the wakeups.
    if ATimeout then
      FQueue.wait();

    // Otherwise, if there are more threads to unblock then
    // signal the queue, otherwise signal the gate.
    if last then
      FGate.post()
    else
      FQueue.post();
  end
  else
    FInternal.unlock();
end;

procedure TCondImpl.PreWait;
begin
  // Called prior to wait(). Acquire the gate semaphore,
  // increment the number of blocked threads and release the
  // gate.
  FGate.wait();
  FBlocked := Succ(FBlocked);
  FGate.post();
end;

procedure TCondImpl.Signal(ABroadcast: boolean);
begin
  // Acquire the gate semaphore and the internal mutex. Once
  // these have been acquired no further threads can enter
  // signal() or wait().
  FGate.wait();
  FInternal.lock();

  // Adjust the number of blocked waiters. There must be a
  // separation of unblocked vs. blocked otherwise signal()
  // cannot determine if there are pending signals which have
  // not yet been processed.
  if (FUnblocked <> 0) then begin
    FBlocked := FBlocked - FUnblocked;
    FUnblocked := 0;
  end;

  // If there are blocked waiters then calculate the number to
  // unblock, unlock the internal mutex and wake the first
  // blocked thread.
  if (FBlocked > 0) then begin
    if ABroadcast then
      FToUnblock := FBlocked
    else
      FToUnblock := 1;
    FInternal.unlock();
    FQueue.post();
  end
  // Otherwise no blocked waiters so release the gate and the
  // internal mutex.
  else begin
    FGate.post();
    FInternal.unlock();
  end;
end;

function TCondImpl.Wait(ATimeout: integer): boolean;
begin
  // Wait for the queue semaphore to be signaled.
  try
    result := FQueue.wait(ATimeout);
    PostWait(not result);
  except
    PostWait(false);
    raise;
  end;
end;
{$ENDIF}

{$IFDEF LIBRARY}
exports
  ThreadSpecificManager_Instance;
{$ENDIF}
initialization
  threadSpecificManagerCreateMutex := TMutex.Create;
{$IFDEF MSWINDOWS}
  Kernel32Handle := GetModuleHandle(kernel32);
  @TryEnterCriticalSection := GetProcAddress(Kernel32Handle, 'TryEnterCriticalSection');
{$ENDIF}
finalization
  FreeAndNil(threadSpecificManager);
  FreeAndNil(threadSpecificManagerCreateMutex);
end.

