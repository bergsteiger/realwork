{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.Pthread;

{$WEAKPACKAGEUNIT}

interface

uses
{$IFDEF MACOS}
  Macapi.Mach,
{$ENDIF MACOS}
  Posix.Base, Posix.SysTypes, Posix.Time, Posix.Sched;

{$IFDEF MACOS}
{$I osx/PthreadTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/PthreadTypes.inc}
{$ENDIF LINUX}

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
initialization
finalization
  if HPThread <> 0 then
    dlclose(HPThread);
end.
