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

unit Posix.SysTime;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses Posix.Base, Posix.SysTypes, Posix.Time;

{$HPPEMIT '#include <sys/time.h>' }

{$IFDEF MACOS}
{$I osx/SysTimeTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/SysTimeTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/SysTimeTypes.inc}
{$ENDIF}

type
  time_t = Posix.SysTypes.time_t;
  {$EXTERNALSYM time_t}
  suseconds_t = Posix.SysTypes.suseconds_t;
  {$EXTERNALSYM suseconds_t}
  cmpTimerType = (cmpGreater, cmpGreaterEqual, cmpEquals, cmpLess, cmpLessEqual);

procedure timerclear(var a: timeval); inline;
{$EXTERNALSYM timerclear}
function timerisset(a: timeval):boolean; inline;
{$EXTERNALSYM timerisset}
function timercmp(a, b: timeval; op: cmpTimerType): boolean; inline;
{$EXTERNALSYM timercmp}
procedure timeradd(a, b: timeval; var res: timeval); inline;
{$EXTERNALSYM timeradd}
procedure timersub(a, b: timeval; var res: timeval); inline;
{$EXTERNALSYM timersub}


{$I SysTimeAPI.inc}

implementation

procedure timerclear(var a: timeval);
begin
  a.tv_sec := 0;
  a.tv_usec := 0;
end;

function timerisset(a: timeval):boolean;
begin
  Result := (a.tv_sec <> 0) or (a.tv_usec <> 0);
end;

function timercmp(a, b: timeval; op: cmpTimerType): boolean;
begin
  Result := False;
  if a.tv_sec = b.tv_sec then
  begin
    case op of
      cmpGreater: result := a.tv_usec > b.tv_usec;
      cmpGreaterEqual: result := a.tv_usec >= b.tv_usec;
      cmpEquals: result := a.tv_usec = b.tv_usec;
      cmpLess: result := a.tv_usec < b.tv_usec;
      cmpLessEqual: result := a.tv_usec <= b.tv_usec;
    end;
  end
  else
  begin
    case op of
      cmpGreater: result := a.tv_sec > b.tv_sec;
      cmpGreaterEqual: result := a.tv_sec >= b.tv_sec;
      cmpEquals: result := a.tv_sec = b.tv_sec;
      cmpLess: result := a.tv_sec < b.tv_sec;
      cmpLessEqual: result := a.tv_sec <= b.tv_sec;
    end;
  end;
end;

procedure timeradd(a, b: timeval; var res: timeval);
begin
  res.tv_sec := a.tv_sec + b.tv_sec;
  res.tv_usec := a.tv_usec + b.tv_usec;
  if res.tv_usec >= 1000000 then
  begin
      res.tv_usec := res.tv_usec - 1000000;
      res.tv_sec := res.tv_sec +1;
  end;
end;

procedure timersub(a, b: timeval; var res: timeval);
begin
  res.tv_sec := a.tv_sec - b.tv_sec;
  res.tv_usec := a.tv_usec - b.tv_usec;
  if res.tv_usec < 0 then
  begin
      res.tv_usec := res.tv_usec + 1000000;
      res.tv_sec := res.tv_sec - 1;
  end;
end;
end.
