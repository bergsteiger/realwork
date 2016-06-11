{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.Pthread;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses
{$IFDEF MACOS}
  Macapi.Mach,
{$ENDIF MACOS}
  Posix.Base, Posix.SysTypes, Posix.Time, Posix.Sched;

{$IFDEF MACOS}
{$I osx/PthreadTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/PthreadTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/PthreadTypes.inc}
{$ENDIF}

{$I PthreadAPI.inc}

function pthread_getname_np(Thread: pthread_t; Name: MarshaledAString;
  len: size_t): Integer;
{$EXTERNALSYM pthread_getname_np}

function pthread_setname_np(Name: MarshaledAString): Integer;
{$EXTERNALSYM pthread_setname_np}

{$IFDEF MACOS}
function pthread_mach_thread_np(Thread: pthread_t): mach_port_t; cdecl;
  external libpthread name _PU + 'pthread_mach_thread_np';
{$EXTERNALSYM pthread_setname_np}
{$ENDIF MACOS}

{ Declare an alias of pthread_self for portability - not present in header file. }
function GetCurrentThreadID: TThreadID; cdecl;
  external libpthread name _PU + 'pthread_self';

{$IF defined(MACOS) or defined(ANDROID)}
function pthread_mutex_timedlock(var Mutex: pthread_mutex_t; const AbsTime: timespec): Integer;
{$ENDIF MACOS or ANDROID}

implementation

uses
  Posix.Dlfcn,
  Posix.Errno;

var
  HPThread : THandle = 0;

function GetPThreadLib: THandle;
begin
  if HPThread = 0 then
  begin
    Result := dlopen(libpthread, RTLD_LAZY);
    if AtomicCmpExchange(HPThread, Result, 0) <> 0 then
      dlclose(Result);
  end;
  Result := HPThread;
end;

type
  Tpthread_getname_np = function(Thread: pthread_t; Name: MarshaledAString;
    len: size_t): Integer; cdecl;
var
  _pthread_getname_np: Tpthread_getname_np;
  pthread_getname_npTested: Boolean;

function pthread_getname_np(Thread: pthread_t; Name: MarshaledAString;
  len: size_t): Integer;
begin
  Result := EINVAL; // Default:  thread doesn't exist
  if not pthread_getname_npTested then
  begin
    @_pthread_getname_np := dlsym(GetPThreadLib, 'pthread_getname_np'); // do not localize
    pthread_getname_npTested := True;
  end;
  if Assigned(_pthread_getname_np) then
    Result := _pthread_getname_np(Thread, Name, len);
end;

type
  Tpthread_setname_np = function(Name: MarshaledAString): Integer; cdecl;
var
  _pthread_setname_np: Tpthread_setname_np;
  pthread_setname_npTested: Boolean;

function pthread_setname_np(Name: MarshaledAString): Integer;
begin
  Result := EINVAL; // Default: thread doesn't exist
  if not pthread_setname_npTested then
  begin
    @_pthread_setname_np := dlsym(GetPThreadLib, 'pthread_setname_np'); // do not localize
    pthread_setname_npTested := True;
  end;
  if Assigned(_pthread_setname_np) then
    Result := _pthread_setname_np(Name);
end;

{$IF defined(MACOS) or defined(ANDROID)}
function pthread_mutex_timedlock(var Mutex: pthread_mutex_t; const AbsTime: timespec): Integer;
var
{$IFDEF MACOS}
  TimeNow: mach_timespec_t;
  CalendarClock: clock_serv_t;
{$ELSE}
  TimeNow: timespec;
{$ENDIF MACOS}
  SleepyTime: timespec;
begin
// This is just to avoid a completely busy wait
  SleepyTime.tv_sec := 0;
  SleepyTime.tv_nsec := 50;
  Result := pthread_mutex_trylock(Mutex);
  {$IFDEF MACOS}
  if Result = EBUSY then
    host_get_clock_service(mach_host_self, CALENDAR_CLOCK, CalendarClock);
  {$ENDIF MACOS}
  while Result = EBUSY do
  begin
  {$IFDEF MACOS}
    clock_get_time(CalendarClock, TimeNow);
  {$ELSE}
    clock_gettime(CLOCK_REALTIME, @TimeNow);
  {$ENDIF MACOS}
    if Int32(TimeNow.tv_sec) > Int32(AbsTime.tv_sec) then
    begin
    {$IFDEF MACOS}
      mach_port_deallocate(mach_task_self, CalendarClock);
    {$ENDIF MACOS}
      Exit(ETIMEDOUT);
    end;
    if Int32(TimeNow.tv_sec) = Int32(AbsTime.tv_sec) then
    begin
      if Int32(TimeNow.tv_nsec) > Int32(AbsTime.tv_nsec) then
      begin
      {$IFDEF MACOS}
        mach_port_deallocate(mach_task_self, CalendarClock);
      {$ENDIF MACOS}
        Exit(ETIMEDOUT);
      end;
      sched_yield;
    end
    else
      nanosleep(SleepyTime, nil);
    Result := pthread_mutex_trylock(Mutex);
  end;
  {$IFDEF MACOS}
  if Result = EBUSY then
    mach_port_deallocate(mach_task_self, CalendarClock);
  {$ENDIF MACOS}
end;
{$ENDIF MACOS or ANDROID}

initialization
finalization
  if HPThread <> 0 then
    dlclose(HPThread);
end.
