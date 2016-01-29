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
unit timehelper;

interface

{$I dorb.inc}

uses
  SysUtils,{$IFDEF MSWINDOWS}Windows, WinSock,{$ENDIF}{$IFDEF LINUX}Libc,{$ENDIF}
  orbtypes, TimeBase_int;

const
  // Max TimeT value
  MaxTimeT = _ulonglong($FFFFFFFFFFFFFFFF);
  // Max InaccruacyT value
  MaxInaccuracyT = _ulonglong($FFFFFFFFFFFF);

type
  // This is a simpler set of functions to work with TimeBase::UtcT, and
  // TimeBase::TimeT values.
  //
  // The Time Service uses units of 100 nanoseconds and a base time
  // of 15 October 1582 00:00:00.
  TTimeHelper = class(TObject)
  public
    // Get current time in unit of 100 ns
    class function utcNow(AInaccuracy: TTimeBase_InaccuracyT = 0): TTimeBase_UtcT;
    class function utcMin(): TTimeBase_UtcT;
    class function utcMax(): TTimeBase_UtcT;
    class function toTimeval(ATimeT: TTimeBase_UtcT): timeval; overload;
    class function toTimeval(ATimeT: TTimeBase_TimeT): timeval; overload;
    class function toIntervalT(ATimeT: TTimeBase_TimeT; AInaccuracyT: TTimeBase_InaccuracyT): TTimeBase_IntervalT;
    class function toUtcT(ATimeT: TTimeBase_TimeT; AInaccuracyT: TTimeBase_InaccuracyT; ATdfT: TTimeBase_TdfT = 0): TTimeBase_UtcT; overload;
    class function toUtcT(const inter: TTimeBase_IntervalT): TTimeBase_UtcT; overload;
    class function toString(const ATime: TTimeBase_UtcT): string; overload;
    class function toTimeString(const ATime: TTimeBase_UtcT): string;
    class function toString(const ATime: TTimeBase_TimeT): string; overload;
    // Delphi support routines
    class function toDateTime(const ATime: TTimeBase_UtcT): TDateTime;
    class function toUtcT(const ADateTime: TDateTime; const AInaccuracy: TTimeBase_InaccuracyT = 0): TTimeBase_UtcT; overload;
  end;

  // operators
  function UtcT_Plus_Time(const AUtcT: TTimeBase_UtcT; const ATimeT: TTimeBase_TimeT): TTimeBase_UtcT;

implementation

uses throw;

const
  // 100 nanoseconds = 10^-7 seconds, hence there are 10^7 (10,000,000)
  // seconds per 100 nanoseconds.
  HNanosPerSecond = _ulonglong(10000000);

  HNanosPerDay = SecsPerDay * HNanosPerSecond;

  // 100 ns units from 15 October 1582 00:00:00 to 1 January 1970 00:00:00.
  //
  // Time difference in 100 ns units between DCE and POSIX time base.
  // 141427 days with 86400 seconds each.
  DCEToPosix = _ulonglong(_ulonglong(141427) * _ulonglong(86400) * HNanosPerSecond);
  // 100 ns units from 15 October 1582 00:00:00 to 1 January 0001 00:00:00.
  //
  // Time difference in 100 ns units between DCE and TTimeStamp time base.
  // 577736 days with 86400 seconds each.
  DCEToTimeStamp = _ulonglong(_ulonglong(577736) * _ulonglong(86400) * HNanosPerSecond);
  // 100 ns units from 15 October 1582 00:00:00 to 30 December 1899 00:00:00.
  //
  // Time difference in 100 ns units between DCE and Delphi time base.
  // 115858 days with 86400 seconds each.
  DCEToDelphi = _ulonglong(_ulonglong(115858) * _ulonglong(86400) * HNanosPerSecond);

// operators
function UtcT_Plus_Time(const AUtcT: TTimeBase_UtcT; const ATimeT: TTimeBase_TimeT): TTimeBase_UtcT;
begin
  result := AUtcT;
  if MaxTimeT - result.time < ATimeT then
    result.time := MaxTimeT
  else
    Inc(result.time, ATimeT);
end;

{ TTimeHelper }

class function TTimeHelper.toUtcT(
  const ADateTime: TDateTime; const AInaccuracy: TTimeBase_InaccuracyT): TTimeBase_UtcT;
var
{$IFDEF MSWINDOWS}
  tz: TIME_ZONE_INFORMATION;
{$ENDIF}
{$IFDEF LINUX}
  tv: TTimeVal;
  tz: TTimeZone;
{$ENDIF}
  ts: TTimeStamp;
  _time: TTimeBase_TimeT;
  tdf: TTimeBase_TdfT;
begin
  ts := DateTimeToTimeStamp(ADateTime);
  _time := longlong(ts.Date) * HNanosPerDay + longlong(ts.Time) * 10000 - DCEToTimeStamp;
{$IFDEF MSWINDOWS}
  if (GetTimeZoneInformation(tz) = TIME_ZONE_ID_DAYLIGHT) then
    tdf := (Short(tz.Bias) + Short(tz.DaylightBias))
  else
    tdf := (Short(tz.Bias));
{$ENDIF}
{$IFDEF LINUX}
  gettimeofday(tv, tz); //GMT
  tdf := - tz.tz_minuteswest;
  if tz.tz_dsttime > 0 then
    tdf := tdf + 60;
{$ENDIF}
  _time := _time + tdf * 60 * HNanosPerSecond;
  result := toUtcT(_time, AInaccuracy, tdf);
end;

class function TTimeHelper.toDateTime(
  const ATime: TTimeBase_UtcT): TDateTime;
var
  v: _ulonglong;
  ts: TTimeStamp;
begin
  v := ATime.time - ATime.tdf * 60 * HNanosPerSecond + DCEToTimeStamp;
  ts.Time := (v mod HNanosPerDay) div 10000;
  ts.Date := v div HNanosPerDay;
  result := TimeStampToDateTime(ts);
end;

class function TTimeHelper.toIntervalT(ATimeT: TTimeBase_TimeT;
  AInaccuracyT: TTimeBase_InaccuracyT): TTimeBase_IntervalT;
begin
  with result do begin
    if ATimeT < AInaccuracyT then
      lower_bound := 0
    else
      lower_bound := ATimeT - AInaccuracyT;

    if MaxTimeT - ATimeT < AInaccuracyT then
      upper_bound := MaxTimeT
    else
      upper_bound := ATimeT - AInaccuracyT;
  end; { with }
end;

class function TTimeHelper.toString(const ATime: TTimeBase_UtcT): string;
begin
  {if ATime.time < DCEToPosix then begin
    result := 'Time less than 1 January 1970 00:00:00';
    Exit;
  end;}

  // Convert to string
  result := DateTimeToStr(toDateTime(ATime));
end;

class function TTimeHelper.toString(const ATime: TTimeBase_TimeT): string;
var
  milliTime: TTimeBase_TimeT;
  sec, msec: _ulong;
begin
  milliTime := ATime div 10000;

  sec := milliTime div 1000;
  msec := milliTime mod 1000;

  result := IntToStr(sec) + ':';
  if (msec < 10) then
      result := result + '00'
  else if (msec < 100) then
    result := result + '0';
  result := result + IntToStr(msec);
end;

class function TTimeHelper.toTimeString(
  const ATime: TTimeBase_UtcT): string;
begin
  {if ATime.time < DCEToPosix then begin
    result := 'Time less than 1 January 1970 00:00:00';
    Exit;
  end;}

  result := TimeToStr(toDateTime(ATime));
end;

class function TTimeHelper.toTimeval(ATimeT: TTimeBase_TimeT): timeval;
var
  v: _ulonglong;
begin
  if ATimeT < DCEToPosix then begin
    result.tv_sec := 0;
    result.tv_usec := 0;
    Exit;
  end;

  v := ATimeT - DCEToPosix;

  result.tv_sec := v div HNanosPerSecond;
  result.tv_usec := (v mod HNanosPerSecond) div 10;
end;

class function TTimeHelper.toTimeval(ATimeT: TTimeBase_UtcT): timeval;
begin
  result := toTimeVal(ATimeT.time);
end;

class function TTimeHelper.toUtcT(ATimeT: TTimeBase_TimeT;
  AInaccuracyT: TTimeBase_InaccuracyT;
  ATdfT: TTimeBase_TdfT): TTimeBase_UtcT;
begin
  with result do begin
    time := ATimeT;
    inacclo := long(AInaccuracyT and $FFFFFFFF);
    inacchi := short((AInaccuracyT shr 32) and $FFFF);
    tdf := ATdfT;
  end; { with }
end;

class function TTimeHelper.toUtcT(
  const inter: TTimeBase_IntervalT): TTimeBase_UtcT;
var
  inaccuracy: TTimeBase_InaccuracyT;
  _time: TTimeBase_TimeT;
begin
  inaccuracy := (inter.upper_bound - inter.lower_bound) div 2;
  _time := inter.lower_bound + inaccuracy;

  result := toUtcT(_time, inaccuracy);
end;

class function TTimeHelper.utcMax: TTimeBase_UtcT;
begin
  result := toUtcT(MaxTimeT, 0, utcNow(0).tdf);
end;

class function TTimeHelper.utcMin: TTimeBase_UtcT;
begin
  result := toUtcT(0, 0, utcNow(0).tdf);
end;

class function TTimeHelper.utcNow(
  AInaccuracy: TTimeBase_InaccuracyT): TTimeBase_UtcT;
var
  _time: TTimeBase_TimeT;
{$IFDEF MSWINDOWS}
  tz: TIME_ZONE_INFORMATION;
  ts: TTimeStamp;
{$ENDIF}
{$IFDEF LINUX}
  tv: TTimeVal;
  //lt: TUnixTime;
  tz: TTimeZone;
{$ENDIF}
  tdf: TTimeBase_TdfT;
begin
  if AInaccuracy > MaxInaccuracyT then
    dorb_throw(st_BAD_PARAM);
{$IFDEF MSWINDOWS}
  ts := DateTimeToTimeStamp(Now()); //local time
  _time := longlong(ts.Date) * HNanosPerDay + longlong(ts.Time) * 10000 - DCEToTimeStamp;
  if (GetTimeZoneInformation(tz) = TIME_ZONE_ID_DAYLIGHT) then
    tdf := -(Short(tz.Bias) + Short(tz.DaylightBias))
  else
    tdf := -(Short(tz.Bias));
  _time := _time - tdf * 60 * HNanosPerSecond; //GMT
{$ENDIF}
{$IFDEF LINUX}
  gettimeofday(tv, tz); //GMT
  _time := _ulonglong(tv.tv_sec) * HNanosPerSecond + _ulonglong(tv.tv_usec) * 10 + DCEToPosix;
  tdf := - tz.tz_minuteswest;
  if tz.tz_dsttime > 0 then
    tdf := tdf + 60;
{$ENDIF}
  result := toUtcT(_time, AInaccuracy, tdf);
end;

end.
