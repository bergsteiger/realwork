{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{*******************************************************}
{      Support for high-precision timing utilities      }
{*******************************************************}

unit System.Diagnostics;

interface
{$HPPEMIT LEGACYHPP}

uses System.Classes, System.TimeSpan;

type
  TStopwatch = record
  strict private
    class var FFrequency: Int64;
    class var FIsHighResolution: Boolean;
    class var TickFrequency: Double;
  strict private
    FElapsed: Int64;
    FRunning: Boolean;
    FStartTimeStamp: Int64;
    function GetElapsed: TTimeSpan;
    function GetElapsedDateTimeTicks: Int64;
    function GetElapsedMilliseconds: Int64;
    function GetElapsedTicks: Int64;
    class procedure InitStopwatchType; static;
  public
    class function Create: TStopwatch; static;
    class function GetTimeStamp: Int64; static;
    procedure Reset;
    procedure Start;
    class function StartNew: TStopwatch; static;
    procedure Stop;
    property Elapsed: TTimeSpan read GetElapsed;
    property ElapsedMilliseconds: Int64 read GetElapsedMilliseconds;
    property ElapsedTicks: Int64 read GetElapsedTicks;
    class property Frequency: Int64 read FFrequency;
    class property IsHighResolution: Boolean read FIsHighResolution;
    property IsRunning: Boolean read FRunning;
  end;

implementation

{$IF defined(MSWINDOWS)}
uses Winapi.Windows;
{$ELSEIF defined(MACOS)}
uses Macapi.Mach;
{$ELSEIF defined(POSIX)}
uses Posix.Time;
{$ENDIF}

{ TStopwatch }

class function TStopwatch.Create: TStopwatch;
begin
  InitStopwatchType;
  Result.Reset;
end;

function TStopwatch.GetElapsed: TTimeSpan;
begin
  Result := TTimeSpan.Create(GetElapsedDateTimeTicks);
end;

function TStopwatch.GetElapsedDateTimeTicks: Int64;
begin
  Result := ElapsedTicks;
  if FIsHighResolution then
    Result := Trunc(Result * TickFrequency);
end;

function TStopwatch.GetElapsedMilliseconds: Int64;
begin
  Result := GetElapsedDateTimeTicks div TTimeSpan.TicksPerMillisecond;
end;

function TStopwatch.GetElapsedTicks: Int64;
begin
  Result := FElapsed;
  if FRunning then
    Result := Result + GetTimeStamp - FStartTimeStamp;
end;

class function TStopwatch.GetTimeStamp: Int64;
{$IF defined(POSIX) and not defined(MACOS)}
var
  res: timespec;
{$ENDIF}
begin
{$IF defined(MSWINDOWS)}
  if FIsHighResolution then
    QueryPerformanceCounter(Result)
  else
    Result := GetTickCount * Int64(TTimeSpan.TicksPerMillisecond);
{$ELSEIF defined(MACOS)}
  Result := Int64(AbsoluteToNanoseconds(mach_absolute_time) div 100);
{$ELSEIF defined(POSIX)}
  clock_gettime(CLOCK_MONOTONIC, @res);
  Result := (Int64(1000000000) * res.tv_sec + res.tv_nsec) div 100;
{$ENDIF}
end;

class procedure TStopwatch.InitStopwatchType;
begin
  if FFrequency = 0 then
  begin
{$IF defined(MSWINDOWS)}
    if not QueryPerformanceFrequency(FFrequency) then
    begin
      FIsHighResolution := False;
      FFrequency := TTimeSpan.TicksPerSecond;
      TickFrequency := 1.0;
    end else
    begin
      FIsHighResolution := True;
      TickFrequency := 10000000.0 / FFrequency;
    end;
{$ELSEIF defined(POSIX)}
    FIsHighResolution := True;
    FFrequency := 10000000; // 100 Nanosecond resolution
    TickFrequency := 10000000.0 / FFrequency;
{$ENDIF}
  end;
end;

procedure TStopwatch.Reset;
begin
  FElapsed := 0;
  FRunning := False;
  FStartTimeStamp := 0;
end;

procedure TStopwatch.Start;
begin
  if not FRunning then
  begin
    FStartTimeStamp := GetTimeStamp;
    FRunning := True;
  end;
end;

class function TStopwatch.StartNew: TStopwatch;
begin
  InitStopwatchType;
  Result.Reset;
  Result.Start;
end;

procedure TStopwatch.Stop;
begin
  if FRunning then
  begin
    FElapsed := FElapsed + GetTimeStamp - FStartTimeStamp;
    FRunning := False;
  end;
end;

end.
