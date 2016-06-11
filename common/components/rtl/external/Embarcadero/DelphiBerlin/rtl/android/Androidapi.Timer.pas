{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.Timer;

interface

type
  TAndroidTimerNotify = procedure(TimerId: Integer) of object;

procedure AndroidTimerSetHandler(OnTimer: TAndroidTimerNotify);
function AndroidTimerCreate: Integer;
procedure AndroidTimerSetInterval(TimerHandle: Integer; Interval: Integer);
procedure AndroidTimerDestroy(TimerHandle: Integer);

implementation

uses
  Posix.Signal, Posix.Time, Posix.SysTypes, System.SysUtils,
  System.Generics.Collections;


var
  TimerNotify: TAndroidTimerNotify;
  TimerHandle: Cardinal;
  HandleToIdMap: TDictionary<Cardinal,timer_t>;

const
  SIGEV_SIGNAL = 0;
  SIGEV_THREAD = 2;

procedure AndroidTimerSetHandler(OnTimer: TAndroidTimerNotify);
begin
  TimerNotify := OnTimer;
end;

procedure OnTimerThread(sv: sigval); cdecl;
begin
  if Assigned(TimerNotify) then
    TimerNotify(sv.sival_int);
end;

function AndroidTimerCreate : Integer;
var
  SigEv: sigevent;
  ThreadDesc: sigev_thread_t;
  TimerId: timer_t;
begin
  Inc(TimerHandle);
  SigEv.sigev_notify := SIGEV_THREAD;
  SigEv.sigev_value.sival_int := TimerHandle;
  ThreadDesc._function := OnTimerThread;
  ThreadDesc._attribute := nil;
  SigEv._sigev_thread := ThreadDesc;

  timer_create(CLOCK_REALTIME, @SigEv, @TimerId);

  HandleToIdMap.AddOrSetValue(TimerHandle, TimerId);

  Result := TimerHandle;
end;


procedure AndroidTimerSetInterval(TimerHandle: Integer; Interval: Integer);
var
  ValueIn: itimerspec;
  TimerId: timer_t;

begin
  ValueIn.it_value.tv_sec := Interval div 1000;
  ValueIn.it_value.tv_nsec := (Interval mod 1000) * 1000000;
  ValueIn.it_interval.tv_sec := Interval div 1000;
  ValueIn.it_interval.tv_nsec :=(Interval mod 1000) * 1000000;
                                                                                                                             
  TimerId := HandleToIdMap[TimerHandle];
  timer_settime(TimerId, 0, ValueIn, nil);
end;

procedure AndroidTimerDestroy(TimerHandle: Integer);
var
  TimerId: timer_t;
begin
  if Assigned(HandleToIdMap) and HandleToIdMap.TryGetValue(TimerHandle, TimerId) then
  begin
    timer_delete(HandleToIdMap[TimerHandle]);
    HandleToIdMap.Remove(TimerHandle);
  end;
end;

initialization
  HandleToIdMap := TDictionary<Cardinal,timer_t>.Create;
  TimerHandle := 0;

finalization
  if Assigned(HandleToIdMap) then
    HandleToIdMap.Free;
  HandleToIdMap := nil;
end.
