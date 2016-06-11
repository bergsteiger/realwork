{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.SyncObjs;

{$H+,X+}
{$IF Defined(CPUX86) and Defined(ASSEMBLER) and not Defined(PUREPASCAL)}
  {$DEFINE X86ASM}
{$ELSE}
  {$IF Defined(CPUX64) and Defined(ASSEMBLER) and not Defined(PUREPASCAL)}
    {$DEFINE X64ASM}
  {$ENDIF}
  {$DEFINE PUREPASCAL}
{$ENDIF}

interface
{$HPPEMIT LEGACYHPP}

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
  Winapi.Messages,
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  Posix.SysTypes,
  Posix.SysTime,
  Posix.Time,
  Posix.Semaphore,
  Posix.Pthread,
  Posix.Errno,
{$ENDIF POSIX}
{$IFDEF MACOS}
  Macapi.CoreServices,
  Macapi.Mach,
{$ENDIF MACOS}
  System.Types,
  System.RTLConsts,
  System.TimeSpan,
  System.SysUtils;

type
  ESyncObjectException = class(Exception);
{$IFNDEF MSWINDOWS}
  PSecurityAttributes = Pointer;
{$ENDIF MSWINDOWS}

{$IFDEF MSWINDOWS}
  TCriticalSectionHelper = record helper for TRTLCriticalSection
    procedure Initialize; inline;
    procedure Destroy; inline;
    procedure Free; inline;
    procedure Enter; inline;
    procedure Leave; inline;
    function TryEnter: Boolean; inline;
  end;

  TConditionVariableHelper = record helper for TRTLConditionVariable
  public
    class function Create: TRTLConditionVariable; static;
    procedure Free; inline;
    function SleepCS(var CriticalSection: TRTLCriticalSection; dwMilliseconds: DWORD): Boolean;
    procedure Wake;
    procedure WakeAll;
  end;
{$ENDIF MSWINDOWS}

  TWaitResult = System.Types.TWaitResult;

  TSynchroObject = class(TObject)
{$IFDEF MACOS}
  private
    class var CalendarClock: clock_serv_t;
{$ENDIF MACOS}
{$IFDEF POSIX}
  protected
    procedure GetPosixEndTime(var EndTime: timespec; TimeOut: LongWord); inline;
    procedure CheckNamed(const Name: string); inline;
{$ENDIF POSIX}
  public
{$IFDEF MACOS}
    class constructor Create;
    class destructor Destroy;
{$ENDIF MACOS}
    procedure Acquire; virtual;
    procedure Release; virtual;
    function WaitFor(Timeout: LongWord = INFINITE): TWaitResult; overload; virtual;
    function WaitFor(const Timeout: TTimeSpan): TWaitResult; overload;
  end;

  THandleObject = class;
  THandleObjectArray = array of THandleObject;

  THandleObject = class(TSynchroObject)
{$IFDEF MSWINDOWS}
  protected
    FHandle: THandle;
    FLastError: Integer;
    FUseCOMWait: Boolean;
  public
    { Specify UseCOMWait to ensure that when blocked waiting for the object
      any STA COM calls back into this thread can be made. }
    constructor Create(UseCOMWait: Boolean = False);
    destructor Destroy; override;
{$ENDIF MSWINDOWS}
  public
{$IFDEF MSWINDOWS}
    function WaitFor(Timeout: LongWord): TWaitResult; overload; override;
    class function WaitForMultiple(const HandleObjs: THandleObjectArray;
      Timeout: LongWord; AAll: Boolean; out SignaledObj: THandleObject;
      UseCOMWait: Boolean = False; Len: Integer = 0): TWaitResult;
    property LastError: Integer read FLastError;
    property Handle: THandle read FHandle;
{$ENDIF MSWINDOWS}
  end;

  TEvent = class(THandleObject)
{$IFDEF POSIX}
  private
    FManualReset: Boolean;
{$IF Defined(LINUX) or Defined(ANDROID)}
    FEvent: sem_t;
{$ENDIF LINUX or ANDROID}
{$IFDEF MACOS}
    FEvent: dispatch_semaphore_t;
    function WaitNoReset(Timeout: LongWord): TWaitResult;
{$ENDIF MACOS}
{$ENDIF POSIX}
  public
    constructor Create(EventAttributes: PSecurityAttributes; ManualReset,
      InitialState: Boolean; const Name: string; UseCOMWait: Boolean = False); overload;
    constructor Create(UseCOMWait: Boolean = False); overload;
{$IFDEF POSIX}
    destructor Destroy; override;
    function WaitFor(Timeout: LongWord): TWaitResult; override;
{$ENDIF POSIX}
    procedure SetEvent;
    procedure ResetEvent;
  end;

  TSimpleEvent = class(TEvent);

  TMutex = class(THandleObject)
{$IFDEF POSIX}
  private
    FMutex: pthread_mutex_t;
{$ENDIF POSIX}
  public
    constructor Create(UseCOMWait: Boolean = False); overload;
    constructor Create(MutexAttributes: PSecurityAttributes; InitialOwner: Boolean; const Name: string; UseCOMWait: Boolean = False); overload;
    constructor Create(DesiredAccess: LongWord; InheritHandle: Boolean; const Name: string; UseCOMWait: Boolean = False); overload;
{$IFDEF POSIX}
    destructor Destroy; override;
    function WaitFor(Timeout: LongWord): TWaitResult; override;
{$ENDIF POSIX}
    procedure Acquire; override;
    procedure Release; override;
  end;

  TSemaphore = class(THandleObject)
{$IF Defined(LINUX) or Defined(ANDROID)}
  private
    FSem: sem_t;
{$ENDIF LINUX or ANDROID}
{$IFDEF MACOS}
  private
    FSem: dispatch_semaphore_t;
{$ENDIF MACOS}
  public
    constructor Create(UseCOMWait: Boolean = False); overload;
    constructor Create(SemaphoreAttributes: PSecurityAttributes; AInitialCount, AMaximumCount: Integer; const Name: string; UseCOMWait: Boolean = False); overload;
    constructor Create(DesiredAccess: LongWord; InheritHandle: Boolean; const Name: string; UseCOMWait: Boolean = False); overload;
{$IFDEF POSIX}
    destructor Destroy; override;
    function WaitFor(Timeout: LongWord = INFINITE): TWaitResult; override;
{$ENDIF POSIX}
    procedure Acquire; override;
    procedure Release; overload; override;
    function Release(AReleaseCount: Integer): Integer; reintroduce; overload;
  end;

  TCriticalSection = class(TSynchroObject)
{$IFDEF POSIX}
  private type
    TCritSec = record
      FSync: TObject;
      procedure Initialize; inline;
      procedure Free; inline;
      procedure Enter; inline;
      procedure Leave; inline;
      function TryEnter: Boolean; inline;
    end;
{$ENDIF POSIX}
  protected
{$IFDEF MSWINDOWS}
    FSection: TRTLCriticalSection;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
    FSection: TCritSec;
{$ENDIF POSIX}
  public
    constructor Create;
    destructor Destroy; override;
    procedure Acquire; override;
    procedure Release; override;
    function TryEnter: Boolean;
    procedure Enter; inline;
    procedure Leave; inline;
  end;

  TConditionVariableMutex = class(TSynchroObject)
  private
{$IFDEF POSIX}
    FCondVar: pthread_cond_t;
{$ENDIF POSIX}
{$IFDEF MSWINDOWS}
    FWaiterCount: Integer;
    FCountLock: TCriticalSection;
    FWaitSemaphore: TSemaphore;
    FWaitersDoneEvent: TEvent;
    FBroadcasting: Boolean;
{$ENDIF MSWINDOWS}
  public
    constructor Create;
    destructor Destroy; override;
    procedure Acquire; override;
    procedure Release; override;
    procedure ReleaseAll;
    function WaitFor(AExternalMutex: TMutex; TimeOut: LongWord = INFINITE): TWaitResult;
  end;

  TConditionVariableCS = class(TSynchroObject)
  protected
{$IFDEF MSWINDOWS}
    FConditionVariable: TRTLConditionVariable;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
    FCondVar: TObject;
{$ENDIF POSIX}
  public
{$IFDEF POSIX}
    constructor Create;
    destructor Destroy; override;
{$ENDIF POSIX}
    procedure Acquire; override;
    procedure Release; override;
    procedure ReleaseAll;
    function WaitFor(CriticalSection: TCriticalSection; TimeOut: LongWord = INFINITE): TWaitResult; overload;
{$IFDEF MSWINDOWS}
    function WaitFor(var CriticalSection: TRTLCriticalSection; TimeOut: LongWord = INFINITE): TWaitResult; overload;
{$ENDIF MSWINDOWS}
  end;

  { TSpinWait implements an exponential backoff algorithm for spin or busy waiting (http://en.wikipedia.org/wiki/Busy_waiting).
    The algorithm is as follows: If the CPUCount > 1, then the first 10 (YieldThreshold) spin cycles
    (calls to SpinCycle) will use a base 2 exponentially increasing spin count starting at 4. After 10 cycles,
    then the behavior reverts to the same behavior as when CPUCount = 1.
    If the CPUCount = 1, then it will sleep (TThread.Sleep) 1ms every modulus 20 cycles and sleep 0ms every modulus
    5 cycles. All other cycles simply yield (TThread.Yield).

    This type is modeled after a similar type available in .NET 4.0 as System.Threading.SpinWait.
  }

  TSpinWait = record
  private const
    YieldThreshold = 10;
    Sleep1Threshold = 20;
    Sleep0Threshold = 5;
  private
    FCount: Integer;
    function GetNextSpinCycleWillYield: Boolean;
  public
    procedure Reset;
    procedure SpinCycle;

    class procedure SpinUntil(const ACondition: TFunc<Boolean>); overload; static;
    class function SpinUntil(const ACondition: TFunc<Boolean>; Timeout: LongWord): Boolean; overload; static;
    class function SpinUntil(const ACondition: TFunc<Boolean>; const Timeout: TTimeSpan): Boolean; overload; static;

    property Count: Integer read FCount;
    property NextSpinCycleWillYield: Boolean read GetNextSpinCycleWillYield;
  end;

  { TSpinLock implements a very simple non-reentrant spin lock. This lock does not block the calling thread using a
    synchronization object. Instead it opts to burn a few extra CPU cycles using a technique similar to the above
    TSpinWait type. This is typically faster than fully blocking if the length of time the lock is held is
    relatively few cycles. In these cases the thread switching overhead will usually far outpace the few cycles
    burned by simply spin waiting. This is typically only true for multicore or SMP situations. However, that case
    is taken into account and the CPU is yielded instead of actually busy-waiting during the current thread's
    quantum.

    Since this lock is non-reentrant, attempts to call Enter a second time from the same thread will cause either
    an exception to be raised if threadID tracking is enabled, otherwise it will deadlock.

    The PublishNow parameter on Exit indicated whether or not a full memory fence should be used to ensure that all
    other threads see the exit immediately. In this case the fairness of the lock is better at the expense of a little
    performance.

    This type is modeled after a similar type available in .NET 4.0 as System.Threading.SpinLock.
  }

  ELockRecursionException = class(ESyncObjectException);
  ELockException = class(ESyncObjectException);

  TSpinLock = record
  private const
    ThreadTrackingDisabled = $80000000;
    MaxWaitingThreads = $7FFFFFFE;
    WaitingThreadMask = $7FFFFFFE;
    AnonymouslyOwned = 1;
    LockAvailable = 0;
  private
    FLock: Integer;
    function InternalTryEnter(Timeout: LongWord): Boolean;
    function GetIsLocked: Boolean;
    function GetIsLockedByCurrentThread: Boolean;
    function GetIsThreadTrackingEnabled: Boolean;
    procedure RemoveWaiter;
  public
    constructor Create(EnableThreadTracking: Boolean);
    procedure Enter; inline;
    procedure Exit(PublishNow: Boolean = True);
    function TryEnter: Boolean; overload; inline;
    function TryEnter(Timeout: LongWord): Boolean; overload;
    function TryEnter(const Timeout: TTimeSpan): Boolean; overload;

    property IsLocked: Boolean read GetIsLocked;
    property IsLockedByCurrentThread: Boolean read GetIsLockedByCurrentThread;
    property IsThreadTrackingEnabled: Boolean read GetIsThreadTrackingEnabled;
  end;

  { TLightweightEvent implements a manual reset event using only atomic operations from the TInterlocked class and the
    built-in TMonitor. Similar to TSpinLock above, TLightweightEvent.WaitFor prefers to try and burn a few CPU cycles
    in a spin-loop before fully blocking the calling thread. This class should really be used in scenarios where the
    signaled-to-blocked ratio is relatively small. In other words, the time that a thread would expect to spend in
    TLightweightEvent.WaitFor is relatively short (in terms of CPU cycles, not absolute time). If used in scenarios
    where the the internal spin count is routinely exhausted and it does finally block, the performance may be slightly
    below that of a regular TSimpleEvent.

    This type is modeled after a similar type available in .NET 4.0 as System.Threading.ManualResetEventSlim.
  }

  TLightweightEvent = class(TSynchroObject)
  strict private const
    DefaultSpinMulticore = 10;
    DefaultSpinSinglecore = 1;
    SpinMask = $FFF;
    MaxSpin = $FFF;
    EventSignaled = Integer($80000000);
    EventUnsignaled = 0;
    SignalMask = Integer($80000000);
  strict private
    FLock: TObject;
    FStateAndSpin: Integer;
    FWaiters: Integer;
    FBlockedCount: Integer;
    function GetIsSet: Boolean;
    function GetSpinCount: Integer;
    procedure SetNewStateAtomically(NewValue, Mask: Integer);
  public
    constructor Create; overload;
    constructor Create(InitialState: Boolean); overload;
    constructor Create(InitialState: Boolean; SpinCount: Integer); overload;
    destructor Destroy; override;
    procedure ResetEvent;
    procedure SetEvent;
    function WaitFor(Timeout: LongWord = INFINITE): TWaitResult; overload; override;
    property BlockedCount: Integer read FBlockedCount;
    property IsSet: Boolean read GetIsSet;
    property SpinCount: Integer read GetSpinCount;
  end;

  { TLightweightSemaphore implements a classic "semaphore" synchronization primitive using only the atomic operations
    from the TInterlocked class and the built-in TMonitor. Similar to TSpinLock and TLightweightEvent above,
    TLightweightSemaphore.WaitFor will prefer to burn a few CPU cycles in a spin-loop before performing a fully
    blocking operation. Again, like the above TLightweightEvent, TLightweightSemaphore should be used in scenarios where
    the semaphore count regularly stays > 0. This will ensure that calls to WaitFor will rarely block. When compared to
    the TSemaphore class in scenarios where the semaphore count is regularly 0, the performance of this class may be
    slightly below that of the TSemaphore class above.

    This type is modeled after a similar type available in .NET 4.0 as System.Threading.SemaphoreSlim.
  }

  TLightweightSemaphore = class(TSynchroObject)
  strict private
    FCountLock: TObject;
    FCurrentCount: Integer;
    FInitialCount: Integer;
    FMaxCount: Integer;
    FWaitCount: Integer;
    FBlockedCount: Integer;
  public
    constructor Create(AInitialCount: Integer; AMaxCount: Integer = MaxInt);
    destructor Destroy; override;
    function Release(AReleaseCount: Integer = 1): Integer; reintroduce;
    function WaitFor(Timeout: LongWord = INFINITE): TWaitResult; overload; override;
    property BlockedCount: Integer read FBlockedCount;
    property CurrentCount: Integer read FCurrentCount;
  end;

  { TCountdownEvent is a synchronization object that behaves similar to a "manual reset semaphore" only it is signaled
    when the count is zero (0) instead of non-zero. Once the count reaches zero, the only way to "unsignal" the event
    is to call one of the Reset methods. AddCount can only be called if the current count is > 0. TryAddCount will
    return true if the count was > 0 and the count was added, otherwise it will return false if the count is already
    zero.

    This type is modeled after a similar type available in .NET 4.0 as System.Threading.CountdownEvent.
  }

  TCountdownEvent = class(TSynchroObject)
  strict private
    FEvent: TLightweightEvent;
    FInitialCount, FCurrentCount: Integer;
    function GetIsSet: Boolean;
  public
    constructor Create; overload;
    constructor Create(Count: Integer); overload;
    constructor Create(Count: Integer; SpinCount: Integer); overload;
    destructor Destroy; override;
    function Signal(Count: Integer = 1): Boolean;
    procedure AddCount(Count: Integer = 1);
    procedure Reset; overload;
    procedure Reset(Count: Integer); overload;
    function TryAddCount(Count: Integer = 1): Boolean;
    function WaitFor(Timeout: LongWord = INFINITE): TWaitResult; overload; override;

    property CurrentCount: Integer read FCurrentCount;
    property InitialCount: Integer read FInitialCount;
    property IsSet: Boolean read GetIsSet;
  end;

  { TInterlocked implements various common atomic opererations for the purpose of ensuring "thread" or "multi-core"
    safety when modifying variables that could be accessed from multiple threads simultaneously. The TInterlocked class
    is not intended to be instantiated nor derived from. All the methods are "class static" and are merely defined in
    a class as a way to group their like-functionality.
  }

  TBitOffset = 0..31;
  TInterlocked = class sealed
  public
    class function Increment(var Target: Integer): Integer; overload; static; inline;
    class function Increment(var Target: Int64): Int64; overload; static; inline;
    class function Decrement(var Target: Integer): Integer; overload; static; inline;
    class function Decrement(var Target: Int64): Int64; overload; static; inline;
    class function Add(var Target: Integer; Increment: Integer): Integer; overload; static; inline;
    class function Add(var Target: Int64; Increment: Int64): Int64; overload; static; inline;
    class function BitTestAndSet(var Target: Integer; BitOffset: TBitOffset): Boolean; static; {$IF not Defined(X86ASM) and not Defined(X64ASM)} inline; {$ENDIF}
    class function BitTestAndClear(var Target: Integer; BitOffset: TBitOffset): Boolean; static;  {$IF not Defined(X86ASM) and not Defined(X64ASM)} inline; {$ENDIF}
    class function Exchange(var Target: Pointer; Value: Pointer): Pointer; overload; static; inline;
    class function Exchange(var Target: Integer; Value: Integer): Integer; overload; static; inline;
    class function Exchange(var Target: Int64; Value: Int64): Int64; overload; static; inline;
    class function Exchange(var Target: TObject; Value: TObject): TObject; overload; static; inline;
    class function Exchange(var Target: Double; Value: Double): Double; overload; static; inline;
    class function Exchange(var Target: Single; Value: Single): Single; overload; static; inline;
    class function Exchange<T: class>(var Target: T; Value: T): T; overload; static; inline;
    class function CompareExchange(var Target: Pointer; Value: Pointer; Comparand: Pointer): Pointer; overload; static; inline;
    class function CompareExchange(var Target: Integer; Value: Integer; Comparand: Integer): Integer; overload; static; inline;
    class function CompareExchange(var Target: Integer; Value: Integer; Comparand: Integer; out Succeeded: Boolean): Integer; overload; static;
    class function CompareExchange(var Target: Int64; Value: Int64; Comparand: Int64): Int64; overload; static; inline;
    class function CompareExchange(var Target: TObject; Value: TObject; Comparand: TObject): TObject; overload; static; inline;
    class function CompareExchange(var Target: Double; Value: Double; Comparand: Double): Double; overload; static; inline;
    class function CompareExchange(var Target: Single; Value: Single; Comparand: Single): Single; overload; static; inline;
    class function CompareExchange<T: class>(var Target: T; Value: T; Comparand: T): T; overload; static; inline;
    class function Read(var Target: Int64): Int64; static; inline;
  end;

const
  wrSignaled = System.Types.TWaitResult.wrSignaled;
  (*$HPPEMIT END OPENNAMESPACE *)
  (*$HPPEMIT END '#if defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) || defined(NO_USING_NAMESPACE_SYSTEM_SYNCOBJS)'*)
  (*$NODEFINE wrSignaled *)
  (*$HPPEMIT END 'static const System::Types::TWaitResult wrSignaled = System::Types::TWaitResult::wrSignaled;' *)
  wrTimeout = System.Types.TWaitResult.wrTimeout;
  (*$NODEFINE wrTimeout *)
  (*$HPPEMIT END 'static const System::Types::TWaitResult wrTimeout = System::Types::TWaitResult::wrTimeout;' *)
  wrAbandoned = System.Types.TWaitResult.wrAbandoned;
  (*$NODEFINE wrAbandoned *)
  (*$HPPEMIT END 'static const System::Types::TWaitResult wrAbandoned = System::Types::TWaitResult::wrAbandoned;' *)
  wrError = System.Types.TWaitResult.wrError;
  (*$NODEFINE wrError *)
  (*$HPPEMIT END 'static const System::Types::TWaitResult wrError = System::Types::TWaitResult::wrError;' *)
  wrIOCompletion = System.Types.TWaitResult.wrIOCompletion;
  (*$NODEFINE wrIOCompletion *)
  (*$HPPEMIT 'static const System::Types::TWaitResult wrIOCompletion = System::Types::TWaitResult::wrIOCompletion;' *)
  (*$HPPEMIT END '#endif'*)
  (*$HPPEMIT END CLOSENAMESPACE *)

implementation

uses 
  System.Diagnostics,
  System.Math,
  System.Classes;

{$IFDEF MSWINDOWS}
type
  PInternalConditionVariable = ^TInternalConditionVariable;
  TInternalConditionVariable = record
  strict private
    type
      PWaitingThread = ^TWaitingThread;
      TWaitingThread = record
        Next: PWaitingThread;
        Thread: Cardinal;
        WaitEvent: THandle;
      end;
    var
      FWaitQueue: PWaitingThread;
    function LockQueue: PWaitingThread;
    procedure UnlockQueue(WaitQueue: PWaitingThread);
    procedure QueueWaiter(var WaitingThread: TWaitingThread);
    function DequeueWaiterNoLock(var WaitQueue: PWaitingThread): PWaitingThread;
    function DequeueWaiter: PWaitingThread;
    procedure RemoveWaiter(var WaitingThread: TWaitingThread);
  public
    class function Create: TInternalConditionVariable; static;
    function SleepCriticalSection(var CriticalSection: TRTLCriticalSection; Timeout: DWORD): Boolean;
    procedure Wake;
    procedure WakeAll;
  end;

  TCoWaitForMultipleHandlesProc = function (dwFlags: DWORD; dwTimeOut: DWORD;
    cHandles: LongWord; var Handles; var lpdwIndex: DWORD): HRESULT; stdcall;
  TInitializeConditionVariableProc = procedure (out ConditionVariable: TRTLConditionVariable); stdcall;
  TSleepConditionVariableCSProc = function (var ConditionVariable: TRTLConditionVariable; var CriticalSection: TRTLCriticalSection; dwMilliseconds: DWORD): BOOL; stdcall;
  TWakeConditionVariableProc = procedure (var ConditionVariable: TRTLConditionVariable); stdcall;
  TWakeAllConditionVariableProc = procedure (var ConditionVariable: TRTLConditionVariable); stdcall;

var
  CoWaitForMultipleHandlesProc: TCoWaitFormultipleHandlesProc;
  InitializeConditionVariableProc: TInitializeConditionVariableProc;
  SleepConditionVariableCSProc: TSleepConditionVariableCSProc;
  WakeConditionVariableProc: TWakeConditionVariableProc;
  WakeAllConditionVariableProc: TWakeAllConditionVariableProc;

threadvar
  OleThreadWnd: HWND;

const
  OleThreadWndClassName = 'OleMainThreadWndClass'; //do not localize
  COWAIT_WAITALL = $00000001;
  COWAIT_ALERTABLE = $00000002;

function GetOleThreadWindow: HWND;
var
  ChildWnd: HWND;
  ParentWnd: HWND;
begin
  if (OleThreadWnd = 0) or not IsWindow(OleThreadWnd) then
  begin
    if (Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion >= 5) then
      ParentWnd := HWND_MESSAGE
    else
      ParentWnd := 0;
    ChildWnd := 0;
    repeat
      OleThreadWnd := FindWindowEx(ParentWnd, ChildWnd, OleThreadWndClassName, nil);
      ChildWnd := OleThreadWnd;
    until (OleThreadWnd = 0) or (GetWindowThreadProcessId(OleThreadWnd, nil) = GetCurrentThreadId);
  end;
  Result := OleThreadWnd;
end;

function InternalCoWaitForMultipleHandles(dwFlags: DWORD; dwTimeOut: DWORD;
  cHandles: LongWord; var Handles; var lpdwIndex: DWORD): HRESULT; stdcall;
var
  WaitResult: DWORD;
  OleThreadWnd: HWnd;
  Msg: TMsg;
begin
  {$IFDEF CPUX86}
  WaitResult := 0; // supress warning
  {$ENDIF CPUX86}
  OleThreadWnd := GetOleThreadWindow;
  if OleThreadWnd <> 0 then
    while True do
    begin
      WaitResult := MsgWaitForMultipleObjectsEx(cHandles, Handles, dwTimeOut, QS_ALLEVENTS, dwFlags);
      if WaitResult = WAIT_OBJECT_0 + cHandles then
      begin
        if PeekMessage(Msg, OleThreadWnd, 0, 0, PM_REMOVE) then
        begin
          TranslateMessage(Msg);
          DispatchMessage(Msg);
        end;
      end else
        Break;
    end
  else
    WaitResult := WaitForMultipleObjectsEx(cHandles, @Handles,
      dwFlags and COWAIT_WAITALL <> 0, dwTimeOut, dwFlags and COWAIT_ALERTABLE <> 0);
  if WaitResult = WAIT_TIMEOUT then
    Result := RPC_E_TIMEOUT
  else if WaitResult = WAIT_IO_COMPLETION then
    Result := RPC_S_CALLPENDING
  else
  begin
    Result := S_OK;
    if (WaitResult >= WAIT_ABANDONED_0) and (WaitResult < WAIT_ABANDONED_0 + cHandles) then
      lpdwIndex := WaitResult - WAIT_ABANDONED_0
    else
      lpdwIndex := WaitResult - WAIT_OBJECT_0;
  end;
end;

function CoWaitForMultipleHandles(dwFlags: DWORD; dwTimeOut: DWORD;
  cHandles: LongWord; var Handles; var lpdwIndex: DWORD): HRESULT;

  procedure LookupProc;
  var
    Ole32Handle: HMODULE;
  begin
    Ole32Handle := GetModuleHandle('ole32.dll'); //do not localize
    if Ole32Handle <> 0 then
      CoWaitForMultipleHandlesProc := GetProcAddress(Ole32Handle, 'CoWaitForMultipleHandles'); //do not localize
    if not Assigned(CoWaitForMultipleHandlesProc) then
      CoWaitForMultipleHandlesProc := InternalCoWaitForMultipleHandles;
  end;

begin
  if not Assigned(CoWaitForMultipleHandlesProc) then
    LookupProc;
  Result := CoWaitForMultipleHandlesProc(dwFlags, dwTimeOut, cHandles, Handles, lpdwIndex)
end;
{$ENDIF MSWINDOWS}

{ TSynchroObject }

procedure TSynchroObject.Acquire;
begin
  WaitFor(INFINITE);
end;

{$IFDEF POSIX}
procedure TSynchroObject.GetPosixEndTime(var EndTime: timespec; TimeOut: LongWord);
{$IFDEF MACOS}
var
  Now: mach_timespec_t;
  NanoSecTimeout: Int64;
begin
  clock_get_time(CalendarClock, Now);
{$ELSE}
var
  Now: timespec;
  NanoSecTimeout: Int64;
begin
  CheckOSError(clock_gettime(CLOCK_REALTIME, @Now));
{$ENDIF MACOS}
  NanoSecTimeout := Now.tv_nsec + (Int64(Timeout) * 1000000);
  EndTime.tv_sec := Int32(Now.tv_sec) + Int32(NanoSecTimeout div 1000000000);
  EndTime.tv_nsec := Int32(NanoSecTimeout mod 1000000000);
end;

procedure TSynchroObject.CheckNamed(const Name: string);
begin
  if Name <> '' then
    raise ESyncObjectException.CreateRes(@sNamedSyncObjectsNotSupported);
end;
{$ENDIF POSIX}

{$IFDEF MACOS}
class constructor TSynchroObject.Create;
begin
  host_get_clock_service(mach_host_self, CALENDAR_CLOCK, CalendarClock);
end;

class destructor TSynchroObject.Destroy;
begin
  mach_port_deallocate(mach_task_self, CalendarClock);
end;
{$ENDIF MACOS}

procedure TSynchroObject.Release;
begin
end;

function TSynchroObject.WaitFor(Timeout: LongWord): TWaitResult;
begin
  Result := wrError;
end;

function TSynchroObject.WaitFor(const Timeout: TTimeSpan): TWaitResult;
var
  Total: Int64;
begin
  Total := Trunc(Timeout.TotalMilliseconds);
  if (Total < 0) or (Total > $7FFFFFFF) then
    raise EArgumentOutOfRangeException.CreateResFmt(@sInvalidTimeoutValue, [string(Timeout)]);
  Result := WaitFor(Integer(Total));
end;

{$IFDEF MSWINDOWS}

{ THandleObject }

constructor THandleObject.Create(UseComWait: Boolean);
begin
  inherited Create;
  FUseCOMWait := UseCOMWait;
end;

destructor THandleObject.Destroy;
begin
  CloseHandle(FHandle);
  inherited Destroy;
end;

function THandleObject.WaitFor(Timeout: LongWord): TWaitResult;
var
  Index: DWORD;
begin
  if FUseCOMWait then
  begin
    case CoWaitForMultipleHandles(0, TimeOut, 1, FHandle, Index) of
      S_OK: Result := wrSignaled;
      RPC_S_CALLPENDING: Result := wrIOCompletion;
      RPC_E_TIMEOUT: Result := wrTimeout;
    else
      Result := wrError;
      FLastError := Integer(GetLastError);
    end;
  end else
  begin
    case WaitForMultipleObjectsEx(1, @FHandle, True, Timeout, False) of
      WAIT_ABANDONED: Result := wrAbandoned;
      WAIT_OBJECT_0: Result := wrSignaled;
      WAIT_TIMEOUT: Result := wrTimeout;
      WAIT_FAILED:
        begin
          Result := wrError;
          FLastError := Integer(GetLastError);
        end;
    else
      Result := wrError;
    end;
  end;
end;

class function THandleObject.WaitForMultiple(
  const HandleObjs: THandleObjectArray; Timeout: LongWord; AAll: Boolean;
  out SignaledObj: THandleObject; UseCOMWait: Boolean; Len: Integer): TWaitResult;
var
  I: Integer;
  Index: DWORD;
  Handles: array of THandle;
  CoWaitFlags: Integer;
  WaitResult: DWORD;
begin
  if Len > 0 then
    Len := Min(Len, Length(HandleObjs))
  else
    Len := Length(HandleObjs);
  SetLength(Handles, Len);
  for I := Low(Handles) to High(Handles) do
    Handles[I] := HandleObjs[I].Handle;
  if UseCOMWait then
  begin
    if AAll then
      CoWaitFlags := COWAIT_WAITALL
    else
      CoWaitFlags := 0;
    case CoWaitForMultipleHandles(CoWaitFlags, Timeout, Length(Handles), Handles[0], Index) of
      S_OK: Result := wrSignaled;
      RPC_S_CALLPENDING: Result := wrIOCompletion;
      RPC_E_TIMEOUT: Result := wrTimeout;
    else
      Result := wrError;
    end;
    if not AAll and (Result = wrSignaled) then
      SignaledObj := HandleObjs[Index]
    else
      SignaledObj := nil;
  end else
  begin
    WaitResult := WaitForMultipleObjectsEx(Length(Handles), @Handles[0], AAll, Timeout, False);
    case WaitResult of
      WAIT_ABANDONED_0..WAIT_ABANDONED_0 + MAXIMUM_WAIT_OBJECTS - 1:
        begin
          Result := wrAbandoned;
          SignaledObj := HandleObjs[WaitResult - WAIT_ABANDONED_0];
        end;
      WAIT_TIMEOUT: Result := wrTimeout;
      WAIT_FAILED: Result := wrError;
      WAIT_IO_COMPLETION: Result := wrIOCompletion;
      WAIT_OBJECT_0..WAIT_OBJECT_0 + MAXIMUM_WAIT_OBJECTS - 1:
        begin
          Result := wrSignaled;
          SignaledObj := HandleObjs[WaitResult - WAIT_OBJECT_0];
        end;
      else
        Result := wrError;  
    end;
  end;
end;
{$ENDIF MSWINDOWS}

{ TEvent }

constructor TEvent.Create(EventAttributes: PSecurityAttributes; ManualReset,
  InitialState: Boolean; const Name: string; UseCOMWait: Boolean);
{$IFDEF MSWINDOWS}
var
  LName: PChar;
begin
  inherited Create(UseCOMWait);
  if Name = '' then
    LName := nil
  else
    LName := PChar(Name);
  FHandle := CreateEvent(EventAttributes, ManualReset, InitialState, LName);
end;
{$ENDIF MSWINDOWS}
{$IFDEF MACOS}
var
  Value: Integer;
begin
  inherited Create;
  CheckNamed(Name);
  if InitialState then
    Value := 1
  else
    Value := 0;

  FManualReset := ManualReset;
  FEvent := dispatch_semaphore_create(Value);
  if FEvent = nil then
    raise ESyncObjectException.CreateRes(@sErrorCreatingEvent);
end;
{$ENDIF MACOS}
{$IF Defined(LINUX) or Defined(ANDROID)}
var
   Value: Integer;
begin
  inherited Create;
  CheckNamed(Name);
  if InitialState then
    Value := 1
  else
    Value := 0;

  FManualReset := ManualReset;

  sem_init(FEvent, 0, Value);
end;
{$ENDIF LINUX or ANDROID}


constructor TEvent.Create(UseCOMWait: Boolean);
begin
  Create(nil, True, False, '', UseCOMWait);
end;

{$IFDEF POSIX}
destructor TEvent.Destroy;
begin
{$IF Defined(LINUX) or Defined(ANDROID)}
  sem_destroy(FEvent);
{$ENDIF LINUX or ANDROID}
{$IFDEF MACOS}
  dispatch_release(FEvent);
{$ENDIF MACOS}
  inherited Destroy;
end;
{$ENDIF POSIX}

{$IFDEF MACOS}
function TEvent.WaitNoReset(Timeout: LongWord): TWaitResult;
begin
  if dispatch_semaphore_wait(FEvent, dispatch_time(UInt64(Ord(Timeout = INFINITE)) * DISPATCH_TIME_FOREVER, NSEC_PER_MSEC * Timeout)) = 0 then
    Result := wrSignaled
  else
    Result := wrTimeout;
end;
{$ENDIF MACOS}

{$IFDEF POSIX}
function TEvent.WaitFor(Timeout: LongWord): TWaitResult;
{$IF Defined(LINUX) or Defined(ANDROID)}
var
  Err: Integer;
  EndTime: timespec;
begin
  if (Timeout > 0) and (Timeout < INFINITE) then
  begin
    GetPosixEndTime(EndTime, Timeout);
    if sem_timedwait(FEvent, EndTime) <> 0 then
    begin
      Err := GetLastError;
      if Err = ETIMEDOUT then
        Result := wrTimeout
      else
        Result := wrError;
    end else
      Result := wrSignaled;
  end else if Timeout = INFINITE then
  begin
    if sem_wait(FEvent) = 0 then
      Result := wrSignaled
    else
      Result := wrError;
  end else
  begin
    if sem_trywait(FEvent) <> 0 then
    begin
      Err := GetLastError;
      if Err = EAGAIN then
        Result := wrTimeout
      else
        Result := wrError;
    end else
      Result := wrSignaled;
  end;
  if (Result = wrSignaled) and FManualReset then
    sem_post(FEvent);
end;
{$ENDIF LINUX or ANDROID}
{$IFDEF MACOS}
begin
  Result := WaitNoReset(Timeout);
  if (Result = wrSignaled) and FManualReset then
    dispatch_semaphore_signal(FEvent);
end;
{$ENDIF MACOS}
{$ENDIF POSIX}

procedure TEvent.SetEvent;
{$IFDEF MSWINDOWS}
begin
  Winapi.Windows.SetEvent(Handle);
end;
{$ENDIF MSWINDOWS}
{$IF Defined(LINUX) or Defined(ANDROID)}
var
  I: Integer;
begin
  sem_getvalue(FEvent, I);
  if I = 0 then
    sem_post(FEvent);
end;
{$ENDIF LINUX or ANDROID}
{$IFDEF MACOS}
begin
  dispatch_semaphore_signal(FEvent);
end;
{$ENDIF MACOS}

procedure TEvent.ResetEvent;
begin
{$IFDEF MSWINDOWS}
  Winapi.Windows.ResetEvent(Handle);
{$ENDIF MSWINDOWS}
{$IF Defined(LINUX) or Defined(ANDROID)}
  while sem_trywait(FEvent) = 0 do { nothing };
{$ENDIF LINUX or ANDROID}
{$IFDEF MACOS}
  WaitNoReset(0);
{$ENDIF MACOS}
end;

{ TCriticalSectionHelper }

{$IFDEF MSWINDOWS}
procedure TCriticalSectionHelper.Initialize;
begin
  InitializeCriticalSection(Self);
end;

procedure TCriticalSectionHelper.Destroy;
begin
  DeleteCriticalSection(Self);
end;

procedure TCriticalSectionHelper.Enter;
begin
  EnterCriticalSection(Self);
end;

procedure TCriticalSectionHelper.Free;
begin
  Destroy;
end;

procedure TCriticalSectionHelper.Leave;
begin
  LeaveCriticalSection(Self);
end;

function TCriticalSectionHelper.TryEnter: Boolean;
begin
  Result := TryEnterCriticalSection(Self);
end;
{$ENDIF MSWINDOWS}

{$IFDEF POSIX}

{ TCriticalSection.TCritSec }

procedure TCriticalSection.TCritSec.Initialize;
begin
  FSync := TObject.Create;
end;

procedure TCriticalSection.TCritSec.Free;
begin
  FSync.Free;
end;

procedure TCriticalSection.TCritSec.Enter;
begin
  TMonitor.Enter(FSync);
end;

procedure TCriticalSection.TCritSec.Leave;
begin
  TMonitor.Exit(FSync);
end;

function TCriticalSection.TCritSec.TryEnter: Boolean;
begin
  Result := TMonitor.TryEnter(FSync);
end;
{$ENDIF POSIX}

{ TCriticalSection }

constructor TCriticalSection.Create;
begin
  inherited Create;
  FSection.Initialize;
end;

destructor TCriticalSection.Destroy;
begin
  FSection.Free;
  inherited Destroy;
end;

procedure TCriticalSection.Acquire;
begin
  FSection.Enter;
end;

procedure TCriticalSection.Release;
begin
  FSection.Leave;
end;

function TCriticalSection.TryEnter: Boolean;
begin
  Result := FSection.TryEnter;
end;

procedure TCriticalSection.Enter;
begin
  Acquire;
end;

procedure TCriticalSection.Leave;
begin
  Release;
end;

{ TMutex }

constructor TMutex.Create(UseCOMWait: Boolean);
begin
  Create(nil, False, '', UseCOMWait);
end;

constructor TMutex.Create(MutexAttributes: PSecurityAttributes;
  InitialOwner: Boolean; const Name: string; UseCOMWait: Boolean);
{$IFDEF MSWINDOWS}
var
  lpName: PChar;
begin
  inherited Create(UseCOMWait);
  if Name <> '' then
    lpName := PChar(Name)
  else
    lpName := nil;
  FHandle := CreateMutex(MutexAttributes, InitialOwner, lpName);
  if FHandle = 0 then
    RaiseLastOSError;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  Attr: pthread_mutexattr_t;
begin
  inherited Create;
  CheckNamed(Name);
  CheckOSError(pthread_mutexattr_init(Attr));
  CheckOSError(pthread_mutexattr_settype(Attr, PTHREAD_MUTEX_RECURSIVE));
  CheckOSError(pthread_mutex_init(FMutex, Attr));
  if InitialOwner then
    Acquire;
end;
{$ENDIF POSIX}

constructor TMutex.Create(DesiredAccess: LongWord; InheritHandle: Boolean;
  const Name: string; UseCOMWait: Boolean);
{$IFDEF MSWINDOWS}
var
  lpName: PChar;
begin
  inherited Create(UseCOMWait);
  if Name <> '' then
    lpName := PChar(Name)
  else
    lpName := nil;
  FHandle := OpenMutex(DesiredAccess, InheritHandle, lpName);
  if FHandle = 0 then
    RaiseLastOSError;
end;
{$ELSE !MSWINDOWS}
begin
  Create(nil, False, Name, UseCOMWait);
end;
{$ENDIF !MSWINDOWS}

{$IFDEF POSIX}
destructor TMutex.Destroy;
begin
  pthread_mutex_destroy(FMutex); // do not call CheckOSError since the mutex could be invalid if object was partially
                                 // constructed due to an exception.
  inherited Destroy;
end;

function TMutex.WaitFor(Timeout: LongWord): TWaitResult;
var
  Err: Integer;
  EndTime: timespec;
begin
  if (Timeout > 0) and (Timeout < INFINITE) then
  begin
    GetPosixEndTime(EndTime, Timeout);
    Err := pthread_mutex_timedlock(FMutex, EndTime);
    if Err = ETIMEDOUT then
      Result := wrTimeout
    else if Err = 0 then
      Result := wrSignaled
    else
      Result := wrError;
  end else if Timeout = INFINITE then
  begin
    if pthread_mutex_lock(FMutex) = 0 then
      Result := wrSignaled
    else
      Result := wrError;
  end else
  begin
    Err := pthread_mutex_trylock(FMutex);
    if Err = 0 then
      Result := wrSignaled
    else if Err = EBUSY then
      Result := wrTimeout
    else
      Result := wrError;
  end;
end;
{$ENDIF POSIX}

procedure TMutex.Acquire;
begin
  if WaitFor(INFINITE) = wrError then
    RaiseLastOSError;
end;

procedure TMutex.Release;
{$IFDEF MSWINDOWS}
begin
  if not ReleaseMutex(FHandle) then
    RaiseLastOSError;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
begin
  CheckOSError(pthread_mutex_unlock(FMutex));
end;
{$ENDIF POSIX}

{ TSemaphore }

procedure TSemaphore.Acquire;
begin
  if WaitFor(INFINITE) = wrError then
    RaiseLastOSError;
end;

constructor TSemaphore.Create(UseCOMWait: Boolean);
begin
  Create(nil, 1, 1, '', UseCOMWait);
end;

constructor TSemaphore.Create(DesiredAccess: LongWord; InheritHandle: Boolean;
  const Name: string; UseCOMWait: Boolean);
{$IFDEF MSWINDOWS}
var
  lpName: PChar;
begin
  inherited Create(UseCOMWait);
  if Name <> '' then
    lpName := PChar(Name)
  else
    lpName := nil;
  FHandle := OpenSemaphore(DesiredAccess, InheritHandle, lpName);
  if FHandle = 0 then
    RaiseLastOSError;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
begin
  Create(nil, 1, 1, Name, UseCOMWait);
end;
{$ENDIF POSIX}

constructor TSemaphore.Create(SemaphoreAttributes: PSecurityAttributes;
  AInitialCount, AMaximumCount: Integer; const Name: string; UseCOMWait: Boolean);
{$IFDEF MSWINDOWS}
var
  lpName: PChar;
begin
  inherited Create(UseCOMWait);
  if Name <> '' then
    lpName := PChar(Name)
  else
    lpName := nil;
  FHandle := CreateSemaphore(SemaphoreAttributes, AInitialCount, AMaximumCount, lpName);
  if FHandle = 0 then
    RaiseLastOSError;
end;
{$ENDIF MSWINDOWS}
{$IF Defined(LINUX) or Defined(ANDROID)}
begin
  inherited Create;
  CheckNamed(Name);
  if sem_init(FSem, 0, AInitialCount) <> 0 then
    RaiseLastOSError;
end;
{$ENDIF LINUX or ANDROID}
{$IFDEF MACOS}
begin
  inherited Create;
  CheckNamed(Name);
  FSem := dispatch_semaphore_create(AInitialCount);
  if FSem = nil then
    raise ESyncObjectException.CreateRes(@sErrorCreatingSemaphore);
end;
{$ENDIF MACOS}


{$IFDEF POSIX}
destructor TSemaphore.Destroy;
begin
{$IF Defined(LINUX) or Defined(ANDROID)}
  sem_destroy(FSem);
{$ENDIF LINUX or ANDROID}
{$IFDEF MACOS}
  dispatch_release(FSem);
{$ENDIF MACOS}
  inherited Destroy;
end;
{$ENDIF POSIX}

function TSemaphore.Release(AReleaseCount: Integer): Integer;
{$IFDEF MSWINDOWS}
begin
  if not ReleaseSemaphore(FHandle, AReleaseCount, @Result) then
    RaiseLastOSError;
end;
{$ENDIF MSWINDOWS}
{$IF Defined(LINUX) or Defined(ANDROID)}
begin
  Result := 0;
  if AReleaseCount < 1 then
    raise ESyncObjectException.CreateResFmt(@SInvalidSemaphoreReleaseCount, [AReleaseCount]);
  repeat
    if sem_post(FSem) <> 0 then
      RaiseLastOSError;
    Dec(AReleaseCount);
    Inc(Result);
  until AReleaseCount = 0;
end;
{$ENDIF LINUX or ANDROID}
{$IFDEF MACOS}
begin
  Result := 0;
  if AReleaseCount < 1 then
    raise ESyncObjectException.CreateResFmt(@SInvalidSemaphoreReleaseCount, [AReleaseCount]);
  repeat
    dispatch_semaphore_signal(FSem);
    Dec(AReleaseCount);
    Inc(Result);
  until AReleaseCount = 0;
end;
{$ENDIF MACOS}


procedure TSemaphore.Release;
begin
  Release(1);
end;

{$IFDEF POSIX}
function TSemaphore.WaitFor(Timeout: LongWord): TWaitResult;
{$IF Defined(LINUX) or Defined(ANDROID)}
var
  EndTime: timespec;
begin
  if (Timeout > 0) and (Timeout < INFINITE) then
  begin
    GetPosixEndTime(EndTime, Timeout);
    if sem_timedwait(FSem, EndTime) <> 0 then
    begin
      if GetLastError = ETIMEDOUT then
        Result := wrTimeout
      else
        Result := wrError;
    end else
      Result := wrSignaled;
  end else if Timeout = INFINITE then
  begin
    if sem_wait(FSem) = 0 then
      Result := wrSignaled
    else
      Result := wrError;
  end else
  begin
    if sem_trywait(FSem) = 0 then
      Exit(wrSignaled);
    if GetLastError = EAGAIN then
      Result := wrTimeout
    else
      Result := wrError;
  end;
end;
{$ENDIF LINUX or ANDROID}
{$IFDEF MACOS}
begin
  if dispatch_semaphore_wait(FSem, dispatch_time(UInt64(Ord(Timeout = INFINITE)) * DISPATCH_TIME_FOREVER, NSEC_PER_MSEC * Timeout)) = 0 then
    Result := wrSignaled
  else
    Result := wrTimeout;
end;
{$ENDIF MACOS}
{$ENDIF POSIX}

{ TConditionVariableMutex }

procedure TConditionVariableMutex.Acquire;
begin
  raise ESyncObjectException.Create(sCannotCallAcquireOnConditionVar);
end;

constructor TConditionVariableMutex.Create;
begin
  inherited Create;
{$IFDEF MSWINDOWS}
  FCountLock := TCriticalSection.Create;
  FWaitSemaphore := TSemaphore.Create(nil, 0, MaxInt, '');
  FWaitersDoneEvent := TEvent.Create(nil, False, False, '');
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  CheckOSError(pthread_cond_init(FCondVar, nil));
{$ENDIF POSIX}
end;

destructor TConditionVariableMutex.Destroy;
begin
{$IFDEF MSWINDOWS}
  FWaitersDoneEvent.Free;
  FWaitSemaphore.Free;
  FCountLock.Free;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  CheckOSError(pthread_cond_destroy(FCondVar));
{$ENDIF POSIX}
  inherited;
end;

procedure TConditionVariableMutex.Release;
{$IFDEF MSWINDOWS}
var
  AnyWaiters: Boolean;
begin
  FCountLock.Enter;
  try
    AnyWaiters := FWaiterCount > 0;
  finally
    FCountLock.Leave;
  end;
  if AnyWaiters then
    FWaitSemaphore.Release;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
begin
  CheckOSError(pthread_cond_signal(FCondVar));
end;
{$ENDIF POSIX}

procedure TConditionVariableMutex.ReleaseAll;
{$IFDEF MSWINDOWS}
var
  AnyWaiters: Boolean;
begin
  AnyWaiters := False;
  FCountLock.Enter;
  try
    if FWaiterCount > 0 then
    begin
      FBroadcasting := True;
      FWaitSemaphore.Release(FWaiterCount);
      AnyWaiters := True;
      FCountLock.Leave;
      FWaitersDoneEvent.WaitFor(INFINITE);
      FBroadcasting := False;
    end;
  finally
    if not AnyWaiters then
      FCountLock.Leave;
  end;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
begin
  CheckOSError(pthread_cond_broadcast(FCondVar));
end;
{$ENDIF POSIX}

function TConditionVariableMutex.WaitFor(AExternalMutex: TMutex; TimeOut: LongWord): TWaitResult;
{$IFDEF MSWINDOWS}
var
  LastWaiter: Boolean;
begin
  if AExternalMutex = nil then
    raise EArgumentNilException.CreateRes(@SArgumentNil);
  FCountLock.Enter;
  try
    Inc(FWaiterCount);
  finally
    FCountLock.Leave;
  end;
  case SignalObjectAndWait(AExternalMutex.Handle, FWaitSemaphore.Handle, TimeOut, False) of
    WAIT_FAILED, WAIT_IO_COMPLETION: Result := wrError;
    WAIT_ABANDONED: Result := wrAbandoned;
    WAIT_TIMEOUT: Result := wrTimeout;
  else
    Result := wrSignaled;
  end;
  FCountLock.Enter;
  try
    Dec(FWaiterCount);
    LastWaiter := FBroadcasting and (FWaiterCount = 0);
  finally
    FCountLock.Leave;
  end;
  if Result <> wrSignaled then
  begin
    if Result = wrTimeout then
      AExternalMutex.WaitFor(INFINITE);
    Exit;
  end;
  if LastWaiter then
    case SignalObjectAndWait(FWaitersDoneEvent.Handle, AExternalMutex.Handle, INFINITE, False) of
      WAIT_FAILED, WAIT_IO_COMPLETION: Result := wrError;
      WAIT_ABANDONED: Result := wrAbandoned;
      WAIT_TIMEOUT: Result := wrTimeout;
    else
      Result := wrSignaled;
    end
  else
    Result := AExternalMutex.WaitFor(INFINITE);
end;
{$ENDIF MSINDOWS}
{$IFDEF POSIX}
var
  Err: Integer;
  EndTime: timespec;
begin
  if AExternalMutex = nil then
    raise EArgumentNilException.CreateRes(@SArgumentNil);
  if (TimeOut > 0) and (Timeout < INFINITE) then
  begin
    GetPosixEndTime(EndTime, Timeout);
    if pthread_cond_timedwait(FCondVar, AExternalMutex.FMutex, EndTime) = 0 then
      Exit(wrSignaled);
    Err := GetLastError;
    if Err = ETIMEDOUT then
      Result := wrTimeout
    else
      Result := wrError;
  end else if Timeout = INFINITE then
  begin
    if pthread_cond_wait(FCondVar, AExternalMutex.FMutex) = 0 then
      Result := wrSignaled
    else
      Result := wrError;
  end else
    Result := wrTimeout;
end;
{$ENDIF POSIX}

{$IFDEF MSWINDOWS}

{ TConditionVariableHelper }

class function TConditionVariableHelper.Create: TRTLConditionVariable;
begin
  InitializeConditionVariableProc(Result);
end;

procedure TConditionVariableHelper.Free;
begin
  // do nothing here;
end;

function TConditionVariableHelper.SleepCS(var CriticalSection: TRTLCriticalSection; dwMilliseconds: DWORD): Boolean;
begin
  Result := SleepConditionVariableCSProc(Self, CriticalSection, dwMilliseconds);
end;

procedure TConditionVariableHelper.Wake;
begin
  WakeConditionVariableProc(Self);
end;

procedure TConditionVariableHelper.WakeAll;
begin
  WakeAllConditionVariableProc(Self);
end;

procedure InternalInitConditionVariable(out ConditionVariable: TRTLConditionVariable); stdcall;
begin
  ConditionVariable.Ptr := nil;
end;

procedure InternalWakeConditionVariable(var ConditionVariable: TRTLConditionVariable); stdcall;
begin
  PInternalConditionVariable(@ConditionVariable).Wake;
end;

procedure InternalWakeAllConditionVariable(var ConditionVariable: TRTLConditionVariable); stdcall;
begin
  PInternalConditionVariable(@ConditionVariable).WakeAll;
end;

function InternalSleepConditionVariableCS(var ConditionVariable: TRTLConditionVariable; var CriticalSection: TRTLCriticalSection; dwMilliseconds: DWORD): BOOL; stdcall;
begin
  Result := PInternalConditionVariable(@ConditionVariable).SleepCriticalSection(CriticalSection, dwMilliseconds);
end;

{$ENDIF MSWINDOWS}

{ TConditionVariableCS }

{$IFDEF POSIX}
constructor TConditionVariableCS.Create;
begin
  inherited Create;
  FCondVar := TObject.Create;
end;

destructor TConditionVariableCS.Destroy;
begin
  FCondVar.Free;
  inherited Destroy;
end;
{$ENDIF POSIX}

procedure TConditionVariableCS.Acquire;
begin
  raise ESyncObjectException.CreateRes(@sCannotCallAcquireOnConditionVar);
end;

procedure TConditionVariableCS.Release;
{$IFDEF MSWINDOWS}
begin
  WakeConditionVariableProc(FConditionVariable);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
begin
  TMonitor.Pulse(FCondVar);
end;
{$ENDIF POSIX}

procedure TConditionVariableCS.ReleaseAll;
{$IFDEF MSWINDOWS}
begin
  WakeAllConditionVariableProc(FConditionVariable);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
begin
  TMonitor.PulseAll(FCondVar);
end;
{$ENDIF POSIX}

{$IFDEF MSWINDOWS}
function TConditionVariableCS.WaitFor(var CriticalSection: TRTLCriticalSection;
  TimeOut: LongWord): TWaitResult;
begin
  if SleepConditionVariableCSProc(FConditionVariable, CriticalSection, Timeout) then
    Result := wrSignaled
  else
    case GetLastError of
      ERROR_TIMEOUT: Result := wrTimeout;
      WAIT_ABANDONED: Result := wrAbandoned;
    else
      Result := wrError;
    end;
end;
{$ENDIF MSWINDOWS}

function TConditionVariableCS.WaitFor(CriticalSection: TCriticalSection;
  TimeOut: LongWord): TWaitResult;
begin
  if CriticalSection = nil then
    raise EArgumentNilException.CreateRes(@SArgumentNil);
{$IFDEF MSWINDOWS}
  Result := WaitFor(CriticalSection.FSection, TimeOut);
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  if TMonitor.Wait(FCondVar, CriticalSection.FSection.FSync, Integer(TimeOut)) then
    Result := wrSignaled
  else
    Result := wrTimeout;
{$ENDIF POSIX}
end;

{$IFDEF MSWINDOWS}
{ TInternalConditionVariable }

class function TInternalConditionVariable.Create: TInternalConditionVariable;
begin
  Result.FWaitQueue := nil;
end;

function TInternalConditionVariable.DequeueWaiter: PWaitingThread;
var
  WaitQueue: PWaitingThread;
begin
  WaitQueue := LockQueue;
  try
    Result := DequeueWaiterNoLock(WaitQueue);
  finally
    UnlockQueue(WaitQueue);
  end;
end;

function TInternalConditionVariable.DequeueWaiterNoLock(var WaitQueue: PWaitingThread): PWaitingThread;
begin
  Result := WaitQueue;
  if (Result = nil) or (Result.Next = Result) then
  begin
    WaitQueue := nil;
    System.Exit;
  end else
  begin
    Result := WaitQueue.Next;
    WaitQueue.Next := WaitQueue.Next.Next;
  end;
end;

function TInternalConditionVariable.LockQueue: PWaitingThread;
var
  SpinLock: Boolean;
  SpinCount: Integer;
begin
  SpinLock := CPUCount > 1;
  if SpinLock then
    SpinCount := 4000
  else
    SpinCount := -1;
  repeat
    Result := PWaitingThread(IntPtr(FWaitQueue) and not 1);
    if PWaitingThread(AtomicCmpExchange(Pointer(FWaitQueue), Pointer(IntPtr(Result) or 1), Pointer(Result))) = Result then
      Break;
    if SpinCount < 0 then
    begin
      SwitchToThread;
      if SpinLock then
        SpinCount := 4000
      else
        SpinCount := 0;
    end else
{$IFNDEF X86ASM}
      YieldProcessor;
{$ELSE X86ASM}
                                                           
    asm
      PAUSE
    end;
{$ENDIF X86ASM}
    Dec(SpinCount);
  until False;
end;

procedure TInternalConditionVariable.QueueWaiter(var WaitingThread: TWaitingThread);
var
  WaitQueue: PWaitingThread;
begin
  // Lock the list
  Assert(Integer(@WaitingThread) and 1 = 0);
  WaitQueue := LockQueue;
  try
    if WaitQueue = nil then
    begin
      WaitQueue := @WaitingThread;
      WaitingThread.Next := @WaitingThread
    end else
    begin
      WaitingThread.Next := WaitQueue.Next;
      WaitQueue.Next := @WaitingThread;
      WaitQueue := @WaitingThread;
    end;
  finally
    UnlockQueue(WaitQueue);
  end;
end;

procedure TInternalConditionVariable.RemoveWaiter(var WaitingThread: TWaitingThread);
var
  WaitQueue, Last, Walker: PWaitingThread;
begin
  if Pointer(IntPtr(FWaitQueue) and not 1) <> nil then
  begin
    WaitQueue := LockQueue;
    try
      Last := WaitQueue;
      Walker := Last.Next;
      while Walker <> WaitQueue do
      begin
        if Walker = @WaitingThread then
        begin
          Last.Next := Walker.Next;
          Break;
        end;
        Last := Walker;
        Walker := Walker.Next;
      end;
      if (Walker = WaitQueue) and (Walker = @WaitingThread) then
        if Walker.Next = Walker then
          WaitQueue := nil
        else
        begin
          WaitQueue := Walker.Next;
          Last.Next := WaitQueue;
        end;
    finally
      UnlockQueue(WaitQueue);
    end;
  end;
end;

function TInternalConditionVariable.SleepCriticalSection(
  var CriticalSection: TRTLCriticalSection; Timeout: DWORD): Boolean;
var
  WaitingThread: TWaitingThread;
  RecursionCount: Integer;
begin
  if CriticalSection.OwningThread = GetCurrentThreadId then
  begin
    WaitingThread.Next := nil;
    WaitingThread.Thread := CriticalSection.OwningThread;
    WaitingThread.WaitEvent := CreateEvent(nil, False, False, nil);
    try
      // Save the current recursion count
      RecursionCount := CriticalSection.RecursionCount;
      // Add the current thread to the waiting queue
      QueueWaiter(WaitingThread);
      // Set it back to almost released
      CriticalSection.RecursionCount := 1;
      //InterlockedExchangeAdd(CriticalSection.LockCount, -(RecursionCount - 1));
      AtomicIncrement(CriticalSection.LockCount, -(RecursionCount - 1));
      // Release and get in line for someone to do a Pulse or PulseAll
      CriticalSection.Leave;
      // This is, admitedly, a potential race condition
      case WaitForSingleObject(WaitingThread.WaitEvent, Timeout) of
        WAIT_TIMEOUT:
          begin
            Result := False;
            SetLastError(ERROR_TIMEOUT);
          end;
        WAIT_OBJECT_0: Result := True;
      else
        Result := False;
        SetLastError(ERROR);
      end;
      // Got to get the lock back and block waiting for it.
      CriticalSection.Enter;
      // Remove any dangling waiters from the list
      RemoveWaiter(WaitingThread);
      // Lets restore all the recursion and lock counts
      //InterlockedExchangeAdd(Integer(CriticalSection.LockCount), RecursionCount - 1);
      AtomicIncrement(Integer(CriticalSection.LockCount), RecursionCount - 1);
      CriticalSection.RecursionCount := RecursionCount;
    finally
      CloseHandle(WaitingThread.WaitEvent);
    end;
  end else
    Result := False;
end;

procedure TInternalConditionVariable.UnlockQueue(WaitQueue: PWaitingThread);
begin
  FWaitQueue := PWaitingThread(IntPtr(WaitQueue) and not 1);
end;

procedure TInternalConditionVariable.Wake;
var
  WaitingThread: PWaitingThread;
begin
  WaitingThread := DequeueWaiter;
  if WaitingThread <> nil then
    SetEvent(WaitingThread.WaitEvent);
end;

procedure TInternalConditionVariable.WakeAll;
var
  WaitQueue, WaitingThread: PWaitingThread;
begin
  WaitQueue := LockQueue;
  try
    WaitingThread := DequeueWaiterNoLock(WaitQueue);
    while WaitingThread <> nil do
    begin
      SetEvent(WaitingThread.WaitEvent);
      WaitingThread := DequeueWaiterNoLock(WaitQueue);
    end;
  finally
    UnlockQueue(WaitQueue);
  end;
end;
{$ENDIF MSWINDOWS}

{ TInterlocked }

class function TInterlocked.Add(var Target: Integer; Increment: Integer): Integer;
begin
  Result := AtomicIncrement(Target, Increment);
end;

class function TInterlocked.Add(var Target: Int64; Increment: Int64): Int64;
begin
  Result := AtomicIncrement(Target, Increment);
end;

class function TInterlocked.BitTestAndSet(var Target: Integer; BitOffset: TBitOffset): Boolean;
{$IF Defined(X64ASM)}
asm
  .NOFRAME
  AND   EDX,31
  LOCK BTS   [RCX].Integer,EDX
  SETNC  AL
end;
{$ELSEIF Defined(X86ASM)}
asm
  AND   EDX,31
  LOCK BTS   [EAX],EDX
  SETNC  AL
end;
{$ELSE}
var
  OldValue: Integer;
begin
  OldValue := Target and not (1 shl (BitOffset and 31));
  AtomicCmpExchange(Target, OldValue or (1 shl (BitOffset and 31)), OldValue, Result);
end;
{$ENDIF}

class function TInterlocked.BitTestAndClear(var Target: Integer; BitOffset: TBitOffset): Boolean;
{$IF Defined(X64ASM)}
asm
  .NOFRAME
  AND   EDX,31
  LOCK BTR   [RCX].Integer,EDX
  SETC  AL
end;
{$ELSEIF Defined(X86ASM)}
asm
  AND   EDX,31
  LOCK BTR   [EAX],EDX
  SETC  AL
end;
{$ELSE}
var
  OldValue: Integer;
begin
  OldValue := Target or (1 shl (BitOffset and 31));
  AtomicCmpExchange(Target, OldValue and not (1 shl (BitOffset and 31)), OldValue, Result);
end;
{$ENDIF}

class function TInterlocked.CompareExchange(var Target: Pointer; Value: Pointer; Comparand: Pointer): Pointer;
begin
  Result := AtomicCmpExchange(Target, Value, Comparand);
end;

class function TInterlocked.CompareExchange(var Target: TObject; Value, Comparand: TObject): TObject;
begin
  Result := TObject(CompareExchange(Pointer(Target), Pointer(Value), Pointer(Comparand)));
{$IFDEF AUTOREFCOUNT}
  if Pointer(Result) = Pointer(Comparand) then
  begin
    if Value <> nil then
      Value.__ObjAddRef;
    if Result <> nil then
      Result.__ObjRelease;
  end;
{$ENDIF AUTOREFCOUNT}
end;

class function TInterlocked.CompareExchange(var Target: Int64; Value, Comparand: Int64): Int64;
begin
  Result := AtomicCmpExchange(Target, Value, Comparand);
end;

class function TInterlocked.CompareExchange(var Target: Integer; Value, Comparand: Integer): Integer;
begin
  Result := AtomicCmpExchange(Target, Value, Comparand);
end;

class function TInterlocked.CompareExchange(var Target: Integer; Value: Integer; Comparand: Integer; out Succeeded: Boolean): Integer;
begin
  Result := AtomicCmpExchange(Target, Value, Comparand, Succeeded);
end;

class function TInterlocked.CompareExchange(var Target: Double; Value, Comparand: Double): Double;
begin
  Int64((@Result)^) := AtomicCmpExchange(Int64((@Target)^), Int64((@Value)^), Int64((@Comparand)^));
end;

class function TInterlocked.CompareExchange(var Target: Single; Value, Comparand: Single): Single;
begin
  Integer((@Result)^) := AtomicCmpExchange(Integer((@Target)^), Integer((@Value)^), Integer((@Comparand)^));
end;

class function TInterlocked.CompareExchange<T>(var Target: T; Value, Comparand: T): T;
begin
  TObject((@Result)^) := CompareExchange(TObject((@Target)^), TObject((@Value)^), TObject((@Comparand)^));
end;

class function TInterlocked.Decrement(var Target: Int64): Int64;
begin
  Result := Add(Target, -1);
end;

class function TInterlocked.Decrement(var Target: Integer): Integer;
begin
  Result := Add(Target, -1);
end;

class function TInterlocked.Exchange(var Target: Int64; Value: Int64): Int64;
begin
  Result := AtomicExchange(Target, Value);
end;

class function TInterlocked.Exchange(var Target: Integer; Value: Integer): Integer;
begin
  Result := AtomicExchange(Target, Value);
end;

class function TInterlocked.Exchange(var Target: TObject; Value: TObject): TObject;
begin
  Result := TObject(Exchange(Pointer(Target), Pointer(Value)));
{$IFDEF AUTOREFCOUNT}
  if Value <> nil then
    Value.__ObjAddRef;
  if Result <> nil then
    Result.__ObjRelease;
{$ENDIF AUTOREFCOUNT}
end;

class function TInterlocked.Exchange(var Target: Pointer; Value: Pointer): Pointer;
begin
  Result := AtomicExchange(Target, Value);
end;

class function TInterlocked.Exchange(var Target: Single; Value: Single): Single;
begin
  Integer((@Result)^) := AtomicExchange(Integer((@Target)^), Integer((@Value)^));
end;

class function TInterlocked.Exchange(var Target: Double; Value: Double): Double;
begin
  Int64((@Result)^) := AtomicExchange(Int64((@Target)^), Int64((@Value)^));
end;

class function TInterlocked.Exchange<T>(var Target: T; Value: T): T;
begin
  TObject((@Result)^) := Exchange(TObject((@Target)^), TObject((@Value)^));
end;

class function TInterlocked.Increment(var Target: Integer): Integer;
begin
  Result := Add(Target, 1);
end;

class function TInterlocked.Read(var Target: Int64): Int64;
begin
  Result := CompareExchange(Target, 0, 0);
end;

class function TInterlocked.Increment(var Target: Int64): Int64;
begin
  Result := Add(Target, 1);
end;

{ TSpinWait }

function TSpinWait.GetNextSpinCycleWillYield: Boolean;
begin
  Result := (FCount > YieldThreshold) or (CPUCount = 1);
end;

procedure TSpinWait.Reset;
begin
  FCount := 0;
end;

procedure TSpinWait.SpinCycle;
var
  SpinCount: Integer;
begin
  if NextSpinCycleWillYield then
  begin
    if FCount >= YieldThreshold then
      SpinCount := FCount - YieldThreshold
    else
      SpinCount := FCount;
    if SpinCount mod Sleep1Threshold = Sleep1Threshold - 1 then
      TThread.Sleep(1)
    else if SpinCount mod Sleep0Threshold = Sleep0Threshold - 1 then
      TThread.Sleep(0)
    else
      TThread.Yield;
  end else
    TThread.SpinWait(4 shl FCount);
  Inc(FCount);
  if FCount < 0 then
    FCount := YieldThreshold + 1;
end;

class procedure TSpinWait.SpinUntil(const ACondition: TFunc<Boolean>);
begin
  SpinUntil(ACondition, INFINITE);
end;

class function TSpinWait.SpinUntil(const ACondition: TFunc<Boolean>; Timeout: LongWord): Boolean;
var
  Timer: TStopwatch;
  Wait: TSpinWait;
begin
  if @ACondition = nil then
    raise EArgumentNilException.CreateRes(@SArgumentNil);
  Timer := TStopwatch.StartNew;
  Wait.Reset;
  while not ACondition() do
  begin
    if Timeout = 0 then
      Exit(False);
    Wait.SpinCycle;
    if (Timeout <> INFINITE) and Wait.NextSpinCycleWillYield and (Timeout <= Timer.ElapsedMilliseconds) then
      Exit(False);
  end;
  Result := True;
end;

class function TSpinWait.SpinUntil(const ACondition: TFunc<Boolean>; const Timeout: TTimeSpan): Boolean;
var
  Total: Int64;
begin
  Total := Trunc(Timeout.TotalMilliseconds);
  if (Total < 0) or (Total > $7FFFFFFF) then
    raise EArgumentOutOfRangeException.CreateResFmt(@sInvalidTimeoutValue, [string(Timeout)]);
  Result := SpinUntil(ACondition, LongWord(Total));
end;

{ TSpinLock }

constructor TSpinLock.Create(EnableThreadTracking: Boolean);
begin
  if EnableThreadTracking then
    FLock := LockAvailable
  else
    FLock := Integer(ThreadTrackingDisabled);
end;

procedure TSpinLock.Enter;
begin
  TryEnter(INFINITE);
end;

procedure TSpinLock.Exit(PublishNow: Boolean);
begin
  if IsThreadTrackingEnabled and not IsLockedByCurrentThread then
    raise ELockException.CreateRes(@SSpinLockNotOwned);
  if PublishNow then
  begin
    if IsThreadTrackingEnabled then
      TInterlocked.Exchange(FLock, LockAvailable)
    else
      TInterlocked.Decrement(FLock)
  end else if IsThreadTrackingEnabled then
    FLock := LockAvailable
  else
    Dec(FLock);
end;

function TSpinLock.GetIsLocked: Boolean;
begin
  if IsThreadTrackingEnabled then
    Result := FLock <> LockAvailable
  else
    Result := FLock and AnonymouslyOwned = AnonymouslyOwned;
end;

function TSpinLock.GetIsLockedByCurrentThread: Boolean;
begin
  if not IsThreadTrackingEnabled then
    raise EInvalidOpException.CreateRes(@SSpinLockInvalidOperation);
  Result := Cardinal(FLock and $7FFFFFFF) = TThread.CurrentThread.ThreadID;
end;

function TSpinLock.GetIsThreadTrackingEnabled: Boolean;
begin
  Result := FLock and ThreadTrackingDisabled = 0;
end;

function TSpinLock.InternalTryEnter(Timeout: LongWord): Boolean;
var
  CurLock: Integer;
  NewLock: Integer;
  Timer: TStopwatch;
  Wait: TSpinWait;
  SpinLock: ^TSpinLock;
begin
  SpinLock := @Self;
  if IsThreadTrackingEnabled then
  begin
    NewLock := TThread.CurrentThread.ThreadID;
    if FLock = NewLock then
      raise ELockRecursionException.CreateRes(@SSpinLockReEntered);
    Result := TSpinWait.SpinUntil(
      function: Boolean
      begin
        Result := (SpinLock.FLock = LockAvailable) and (TInterlocked.CompareExchange(SpinLock.FLock, NewLock, LockAvailable) = LockAvailable);
      end, Timeout);
  end else
  begin
    Timer := TStopwatch.StartNew;
    Wait.Reset;
    while True do
    begin
      CurLock := FLock;
      if CurLock and AnonymouslyOwned = LockAvailable then
      begin
        if TInterlocked.CompareExchange(FLock, CurLock or AnonymouslyOwned, CurLock) = CurLock then
          System.Exit(True);
      end else if (CurLock and WaitingThreadMask = MaxWaitingThreads) or (TInterlocked.CompareExchange(FLock, CurLock + 2, CurLock) = CurLock) then
         Break;
      Wait.SpinCycle;
    end;
    if (Timeout = 0) or ((Timeout <> INFINITE) and (Timeout <= Timer.ElapsedMilliseconds)) then
    begin
      RemoveWaiter;
      System.Exit(False);
    end;
    // Adjust the timeout for any time already spent
    Timeout := Timeout - Timer.ElapsedMilliseconds;
    Result := TSpinWait.SpinUntil(
      function: Boolean
      begin
        CurLock := SpinLock.FLock;
        if CurLock and AnonymouslyOwned = LockAvailable then
        begin
          if CurLock and WaitingThreadMask = LockAvailable then
            NewLock := CurLock or AnonymouslyOwned
          else
            NewLock := (CurLock - 2) or AnonymouslyOwned;
          Result := TInterlocked.CompareExchange(SpinLock.FLock, NewLock, CurLock) = CurLock;
        end else
          Result := False;
      end, Timeout);
    if not Result then
      RemoveWaiter;
  end;
end;

procedure TSpinLock.RemoveWaiter;
var
  CurLock: Integer;
  Wait: TSpinWait;
begin
  Wait.Reset;
  while True do
  begin
    CurLock := FLock;
    if (CurLock and WaitingThreadMask = 0) or (TInterlocked.CompareExchange(FLock, CurLock - 2, CurLock) = CurLock) then
      System.Exit;
    Wait.SpinCycle;
  end;
end;

function TSpinLock.TryEnter: Boolean;
begin
  Result := TryEnter(0);
end;

function TSpinLock.TryEnter(const Timeout: TTimeSpan): Boolean;
var
  Total: Int64;
begin
  Total := Trunc(Timeout.TotalMilliseconds);
  if (Total < 0) or (Total > $7FFFFFFF) then
    raise EArgumentOutOfRangeException.CreateResFmt(@sInvalidTimeoutValue, [string(Timeout)]);
  Result := TryEnter(LongWord(Total));
end;

function TSpinLock.TryEnter(Timeout: LongWord): Boolean;
var
  CurLock: Integer;
  NewLock: Cardinal;
begin
  CurLock := FLock;
  NewLock := 0;
  if IsThreadTrackingEnabled then
  begin
    if CurLock = LockAvailable then
      NewLock := TThread.CurrentThread.ThreadID;
  end else if CurLock and AnonymouslyOwned = LockAvailable then
    NewLock := Cardinal(CurLock or AnonymouslyOwned);
  if NewLock <> 0 then
    if TInterlocked.CompareExchange(FLock, Integer(NewLock), CurLock) = CurLock then
      System.Exit(True);
  Result := InternalTryEnter(Timeout);
end;

{ TLightweightEvent }

constructor TLightweightEvent.Create;
begin
  Create(False, DefaultSpinMulticore);
end;

constructor TLightweightEvent.Create(InitialState: Boolean);
begin
  Create(InitialState, DefaultSpinMulticore);
end;

constructor TLightweightEvent.Create(InitialState: Boolean; SpinCount: Integer);
begin
  inherited Create;
  FLock := TObject.Create;
  TMonitor.SetSpinCount(FLock, 10);
  if InitialState then
    FStateAndSpin := EventSignaled;
  if (SpinCount < 0) or (SpinCount > MaxSpin) then
    raise EArgumentOutOfRangeException.CreateResFmt(@sSpinCountOutOfRange, [MaxSpin]);
  if (CPUCount = 1) and (SpinCount > 0) then
    FStateAndSpin := FStateAndSpin or DefaultSpinSinglecore
  else
    FStateAndSpin := FStateAndSpin or SpinCount;
end;

destructor TLightweightEvent.Destroy;
begin
  FLock.Free;
  inherited;
end;

function TLightweightEvent.GetIsSet: Boolean;
begin
  Result := (FStateAndSpin and SignalMask) = EventSignaled;
end;

function TLightweightEvent.GetSpinCount: Integer;
begin
  Result := FStateAndSpin and SpinMask;
end;

procedure TLightweightEvent.ResetEvent;
begin
  SetNewStateAtomically(EventUnsignaled, SignalMask);
end;

procedure TLightweightEvent.SetEvent;
begin
  SetNewStateAtomically(EventSignaled, SignalMask);
  if FWaiters > 0 then
  begin
    TMonitor.Enter(FLock);
    try
      TMonitor.PulseAll(FLock);
    finally
      TMonitor.Exit(FLock);
    end;
  end;
end;

procedure TLightweightEvent.SetNewStateAtomically(NewValue, Mask: Integer);
var
  Spin: TSpinWait;
  CurrentState, NewState: Integer;
begin
  Spin.Reset;
  while True do
  begin
    CurrentState := FStateAndSpin;
    NewState := (CurrentState and not Mask) or NewValue;
    if TInterlocked.CompareExchange(FStateAndSpin, NewState, CurrentState) = CurrentState then
      Exit;
    Spin.SpinCycle;
  end;
end;

function TLightweightEvent.WaitFor(Timeout: LongWord): TWaitResult;
var
  I: Integer;
  Timer: TStopwatch;
  SpinWait: TSpinWait;
  Elapsed: Int64;
begin
  if not IsSet then
  begin
    if Timeout = 0 then
      Exit(wrTimeout);
    SpinWait.Reset;
    if SpinCount > 0 then
    begin
      if Timeout < INFINITE then
        Timer := TStopwatch.StartNew;
      for I := 0 to SpinCount - 1 do
      begin
        SpinWait.SpinCycle;
        if IsSet then
          Exit(wrSignaled);
      end;
    end;
    if Timeout < INFINITE then
    begin
      Elapsed := Timer.ElapsedMilliseconds;
      if (Elapsed > $7FFFFFFF) or (Elapsed >= Timeout) then
        Exit(wrTimeout);
      Timeout := Timeout - Elapsed;
    end;
    TMonitor.Enter(FLock);
    try
      TInterlocked.Increment(FWaiters); // Use a full fence here
      if IsSet then
      begin
        TInterlocked.Decrement(FWaiters);
        Exit(wrSignaled);
      end;
      try
        TInterlocked.Increment(FBlockedCount);
        if TMonitor.Wait(FLock, Timeout) then
          Result := wrSignaled
        else
          Result := wrTimeout;
      finally
        TInterlocked.Decrement(FWaiters);
      end;
    finally
      TMonitor.Exit(FLock);
    end;
  end else
    Result := wrSignaled;
end;

{ TLightweightSemaphore }

constructor TLightweightSemaphore.Create(AInitialCount, AMaxCount: Integer);
begin
  inherited Create;
  if (AInitialCount < 0) or (AInitialCount > AMaxCount) then
    raise EArgumentOutOfRangeException.CreateResFmt(@sInvalidInitialSemaphoreCount, [AInitialCount]);
  if AMaxCount <= 0 then
    raise EArgumentOutOfRangeException.CreateResFmt(@sInvalidMaxSemaphoreCount, [AMaxCount]);
  FInitialCount := AInitialCount;
  FMaxCount := AMaxCount;
  FCountLock := TObject.Create;
  TMonitor.SetSpinCount(FCountLock, 10);
  FCurrentCount := AInitialCount;
end;

destructor TLightweightSemaphore.Destroy;
begin
  FCountLock.Free;
  inherited;
end;

function TLightweightSemaphore.Release(AReleaseCount: Integer): Integer;
begin
  Result := 0;
  if AReleaseCount < 0 then
    raise EArgumentOutOfRangeException.CreateResFmt(@sInvalidSemaphoreReleaseCount, [AReleaseCount]);
  TMonitor.Enter(FCountLock);
  try
    if FMaxCount - FCurrentCount < AReleaseCount then
      raise ESyncObjectException.CreateRes(@sSemaphoreReachedMaxCount);
    Inc(FCurrentCount, AReleaseCount);
    if (FCurrentCount = 1) or (FWaitCount = 1) then
      TMonitor.Pulse(FCountLock)
    else if FWaitCount > 1 then
      TMonitor.PulseAll(FCountLock);
    Result := FCurrentCount - AReleaseCount;
  finally
    TMonitor.Exit(FCountLock);
  end;
end;

function TLightweightSemaphore.WaitFor(Timeout: LongWord): TWaitResult;
var
  Timer: TStopwatch;
  Spinner: TSpinWait;
  CountDown: Integer;

  function UpdateTimeout(const Timer: TStopwatch; OriginalWaitTime: Integer): Integer;
  var
    Elapsed: Int64;
  begin
    Elapsed := Timer.ElapsedMilliseconds;
    if Elapsed > $7FFFFFFF then
      Result := 0
    else
      Result := OriginalWaitTime - Integer(Elapsed);
    if Result < 0 then
      Result := 0;
  end;

begin
  Timer := TStopWatch.Create;
  Spinner.Reset;
  CountDown := Integer(Timeout);
  if Timeout < INFINITE then
    Timer.Start;
  while True do
  begin
    if FCurrentCount > 0 then
    begin
      if TMonitor.TryEnter(FCountLock) then
        Break;
    end;
    if Spinner.NextSpinCycleWillYield then
    begin
      if Timeout = 0 then
        Exit(wrTimeout);
      if Timeout < INFINITE then
      begin
        CountDown := UpdateTimeout(Timer, Timeout);
        if CountDown <= 0 then
          Exit(wrTimeout);
      end;
      if not TMonitor.Enter(FCountLock, Cardinal(CountDown)) then
        Exit(wrTimeout);
      Break;
    end;
    Spinner.SpinCycle;
  end;
  Inc(FWaitCount);
  try
    while FCurrentCount = 0 do
    begin
      if Timeout < INFINITE then
      begin
        Countdown := UpdateTimeout(Timer, Timeout);
        if CountDown <= 0 then
          Exit(wrTimeout);
      end;
      TInterlocked.Increment(FBlockedCount);
      if not TMonitor.Wait(FCountLock, Cardinal(Countdown)) then
        Exit(wrTimeout);
    end;
    Dec(FCurrentCount);
  finally
    Dec(FWaitCount);
    TMonitor.Exit(FCountLock);
  end;
  Result := wrSignaled;
end;

{ TCountdownEvent }

constructor TCountdownEvent.Create;
begin
  Create(1, -1);
end;

constructor TCountdownEvent.Create(Count: Integer);
begin
  Create(Count, -1);
end;

constructor TCountdownEvent.Create(Count, SpinCount: Integer);
begin
  inherited Create;
  if Count < 0 then
    raise EArgumentOutOfRangeException.CreateResFmt(@sInvalidInitialCount, [Count]);
  FInitialCount := Count;
  FCurrentCount := Count;
  if SpinCount < 0 then
    FEvent := TLightweightEvent.Create
  else
    FEvent := TLightweightEvent.Create(False, SpinCount);
  if Count = 0 then
    FEvent.SetEvent;
end;

destructor TCountdownEvent.Destroy;
begin
  FEvent.Free;
  inherited;
end;

function TCountdownEvent.Signal(Count: Integer): Boolean;
var
  CurCount: Integer;
  SpinWait: TSpinWait;
begin
  if Count <= 0 then
    raise EArgumentOutOfRangeException.CreateResFmt(@sInvalidDecrementCount, [Count]);
  Result := False;
  SpinWait.Reset;
  while True do
  begin
    CurCount := FCurrentCount;
    if CurCount < Count then
      raise EInvalidOperation.CreateResFmt(@sInvalidDecrementOperation, [Count, CurCount]);
    if TInterlocked.CompareExchange(FCurrentCount, CurCount - Count, CurCount) <> CurCount then
    begin
      SpinWait.SpinCycle;
      Continue;
    end;
    if CurCount = Count then
    begin
      FEvent.SetEvent;
      Result := True;
    end;
    Break;
  end;
end;

function TCountdownEvent.GetIsSet: Boolean;
begin
  Result := FCurrentCount = 0;
end;

procedure TCountdownEvent.AddCount(Count: Integer);
begin
  if not TryAddCount(Count) then
    raise EInvalidOperation.CreateRes(@sCountdownAlreadyZero);
end;

procedure TCountdownEvent.Reset(Count: Integer);
begin
  if Count < 0 then
    raise EArgumentOutOfRangeException.CreateResFmt(@sInvalidResetCount, [Count]);
  FCurrentCount := Count;
  FInitialCount := Count;
  if Count = 0 then
    FEvent.SetEvent
  else
    FEvent.ResetEvent;
end;

procedure TCountdownEvent.Reset;
begin
  Reset(FInitialCount);
end;

function TCountdownEvent.TryAddCount(Count: Integer): Boolean;
var
  CurCount: Integer;
  SpinWait: TSpinWait;
begin
  if Count <= 0 then
    raise EArgumentOutOfRangeException.CreateResFmt(@sInvalidIncrementCount, [Count]);
  SpinWait.Reset;
  while True do
  begin
    CurCount := FCurrentCount;
    if CurCount = 0 then
      Exit(False);
    if CurCount > ($7FFFFFFF - Count) then
      raise EInvalidOperation.CreateResFmt(@sInvalidIncrementOperation, [Count, CurCount]);
    if TInterlocked.CompareExchange(FCurrentCount, CurCount + Count, CurCount) <> CurCount then
    begin
      SpinWait.SpinCycle;
      Continue;
    end;
    Break;
  end;
  Result := True;
end;

function TCountdownEvent.WaitFor(Timeout: LongWord): TWaitResult;
begin
  if not IsSet then
    Result := FEvent.WaitFor(Timeout)
  else
    Result := wrSignaled;
end;

type
  TMultiWaitEventImpl = class(TMultiWaitEvent)
  private
    FEvent: TLightweightEvent;
    FWaiters: TArray<TMultiWaitEvent.TWaitInfo>;
  protected type
    TWaitInfo = TMultiWaitEvent.TWaitInfo;
    PWaitInfo = TMultiWaitEvent.PWaitInfo;
  protected
    class function CreateInstance: TMultiWaitEvent; override;
    class procedure ArgumentException; override;
    class function GetTickCount: Cardinal; override;
    procedure Lock; override;
    procedure Unlock; override;
    procedure AtomicSetEventState(State: Boolean); override;
    procedure NotifyWaiters; override;
    procedure ClearWaiters; override;
    procedure PushWaiter(const Waiter: TMultiWaitEvent.TWaitInfo); override;
    procedure RemoveWaiter(Index: Integer); override;
    function GetWaiterCount: Integer; override;
    function GetWaiter(Index: Integer): TMultiWaitEvent.PWaitInfo; override;
  public
    constructor Create; // inject a Create method into this class to keep from overflowing the stack

    function WaitFor(Timeout: Cardinal = INFINITE): TWaitResult; override;
  end;

{ TMultiWaitEventImpl }

class procedure TMultiWaitEventImpl.ArgumentException;
begin
  raise EArgumentOutOfRangeException.CreateRes(@sMustWaitOnOneEvent);
end;

procedure TMultiWaitEventImpl.AtomicSetEventState(State: Boolean);
begin
  if not State then
    FEvent.ResetEvent;
end;

procedure TMultiWaitEventImpl.ClearWaiters;
begin
  FWaiters := nil;
end;

constructor TMultiWaitEventImpl.Create;
begin
  FEvent := TLightweightEvent.Create;
end;

class function TMultiWaitEventImpl.CreateInstance: TMultiWaitEvent;
begin
  Result := TMultiWaitEventImpl.Create;
end;

class function TMultiWaitEventImpl.GetTickCount: Cardinal;
begin
  Result := TThread.GetTickCount;
end;

function TMultiWaitEventImpl.GetWaiter(Index: Integer): PWaitInfo;
begin
  Result := @FWaiters[Index];
end;

function TMultiWaitEventImpl.GetWaiterCount: Integer;
begin
  Result := Length(FWaiters);
end;

procedure TMultiWaitEventImpl.Lock;
begin
end;

procedure TMultiWaitEventImpl.NotifyWaiters;
begin
  FEvent.SetEvent;
end;

procedure TMultiWaitEventImpl.Unlock;
begin
end;

procedure TMultiWaitEventImpl.PushWaiter(const Waiter: TWaitInfo);
begin
  FWaiters := FWaiters + [Waiter];
end;

procedure TMultiWaitEventImpl.RemoveWaiter(Index: Integer);
begin
  Delete(FWaiters, Index, 1);
end;

function TMultiWaitEventImpl.WaitFor(Timeout: Cardinal): TWaitResult;
begin
  Result := FEvent.WaitFor(Timeout);
end;

{$IFDEF MSWINDOWS}
procedure InitConditionVariableProcs;
var
  Module: HMODULE;
begin
  Module := GetModuleHandle('kernel32.dll'); // do not localize
  InitializeConditionVariableProc := GetProcAddress(Module, 'InitializeConditionVariable'); // do not localize
  if @InitializeConditionVariableProc = nil then
  begin
    InitializeConditionVariableProc := InternalInitConditionVariable;
    WakeConditionVariableProc := InternalWakeConditionVariable;
    WakeAllConditionVariableProc := InternalWakeAllConditionVariable;
    SleepConditionVariableCSProc := InternalSleepConditionVariableCS;
  end else
  begin
    WakeConditionVariableProc := GetProcAddress(Module, 'WakeConditionVariable'); // do not localize
    WakeAllConditionVariableProc := GetProcAddress(Module, 'WakeAllConditionVariable'); // do not localize
    SleepConditionVariableCSProc := GetProcAddress(Module, 'SleepConditionVariableCS'); // do not localize
  end;
end;
{$ENDIF}

initialization
{$IFDEF MSWINDOWS}
  InitConditionVariableProcs;
{$ENDIF}
  // if this unit is used, use a little more efficient TLightweightEvent instead of the implementation from System.Classes
  TMultiWaitEventImpl.FMultiEventType := TMultiWaitEventImpl;

end.
