{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{ Return a string of the form "Day Mon dd hh:mm:ss yyyy\n"
   that is the representation of TP in this format.  }
function asctime(const [Ref] UnixTime: tm): MarshaledAString; cdecl;
  external libc name _PU + 'asctime';
{$EXTERNALSYM asctime}

{ Return in BUF a string of the form "Day Mon dd hh:mm:ss yyyy\n"
   that is the representation of TP in this format.  }
function asctime_r(const [Ref] UnixTime: tm; Buf: MarshaledAString): MarshaledAString; cdecl;
  external libc name _PU + 'asctime_r';
{$EXTERNALSYM asctime_r}

{ The amount of processor time used since the invocation of the calling process,
   measured in CLOCKS_PER_SECs of a second }
function clock: clock_t; cdecl;
  external libc name _PU + 'clock';
{$EXTERNALSYM clock}

{$IFNDEF MACOS}
function clock_getres(Clk: Integer; Res: Ptimespec): Integer; cdecl;
  external libc name _PU + 'clock_getres';
{$EXTERNALSYM clock_getres}

function clock_gettime(Clk: Integer; Tp: Ptimespec): Integer; cdecl;
  external libc name _PU + 'clock_gettime';
{$EXTERNALSYM clock_gettime}
{$ENDIF !MACOS}

{ Equivalent to `asctime (localtime (timer))'.  }
function ctime(var Timer: time_t): MarshaledAString; cdecl;
  external libc name _PU + 'ctime';
{$EXTERNALSYM ctime}

{ Equivalent to `asctime_r (localtime_r (timer, *TMP*), buf)'.  }
function ctime_r(var Timer: time_t; Buf: MarshaledAString): MarshaledAString; cdecl;
  external libc name _PU + 'ctime_r';
{$EXTERNALSYM ctime_r}

{ Return the difference between TIME1 and TIME0.  }
function difftime(time1, time0: time_t): Double; cdecl;
  external libc name _PU + 'difftime';
{$EXTERNALSYM difftime}

{$IFNDEF ANDROID}
{ Converts a user-definable date and/or time specifications pointed to by
   DateStr to a tm structure}
function getdate(const DateStr: MarshaledAString): Ptm; cdecl;
  external libc name _PU + 'getdate';
{$EXTERNALSYM getdate}
{$ENDIF !ANDROID}

{ Return the `struct tm' representation of *TIMER
   in Universal Coordinated Time (aka Greenwich Mean Time).  }
function gmtime(var Timer: time_t): Ptm; cdecl;
  external libc name _PU + 'gmtime';
{$EXTERNALSYM gmtime}

{ Return the `struct tm' representation of *TIMER in UTC,
   using *TP to store the result.  }
function gmtime_r(var Timer: time_t; var UnixTime: tm): Ptm; cdecl;
  external libc name _PU + 'gmtime_r';
{$EXTERNALSYM gmtime_r}

{ Return the `struct tm' representation
   of *TIMER in the local timezone.  }
function localtime(var Timer: time_t): Ptm; cdecl;
  external libc name _PU + 'localtime';
{$EXTERNALSYM localtime}

{ Return the `struct tm' representation of *TIMER in local time,
   using *TP to store the result.  }
function localtime_r(var Timer: time_t; var UnixTime: tm): Ptm; cdecl; overload;
  external libc name _PU + 'localtime_r';
{$EXTERNALSYM localtime_r}

{ Return the `time_t' representation of TP and normalize TP.  }
function mktime(var UnixTime: tm): time_t; cdecl;
  external libc name _PU + 'mktime';
{$EXTERNALSYM mktime}

{ Pause execution for a number of nanoseconds.  }
function nanosleep(const [Ref] RequestedTime: timespec; Remaining: Ptimespec): Integer; cdecl;
  external libc name _PU + 'nanosleep';
{$EXTERNALSYM nanosleep}

{ Format TP into S according to FORMAT.
   Write no more than MAXSIZE characters and return the number
   of characters written, or 0 if it would exceed MAXSIZE.  }
function strftime(S: MarshaledAString; MaxSize: LongWord; Format: MarshaledAString;
  const [Ref] UnixTime: tm): LongWord; cdecl;
  external libc name _PU + 'strftime';
{$EXTERNALSYM strftime}

{ Parse S according to FORMAT and store binary time information in TP.
   The return value is a pointer to the first unparsed character in S.  }
function strptime(S: MarshaledAString; Format: MarshaledAString; var UnixTime: tm): MarshaledAString; cdecl;
  external libc name _PU + 'strptime';
{$EXTERNALSYM strptime}

{ Return the current time and put it in *TIMER if TIMER is not NULL.  }
// HTI - Renamed from "time" to "__time"
function __time(var TimeNow: time_t): time_t; cdecl;
  external libc name _PU + 'time';
{$EXTERNALSYM __time}

{ Return the current time and put it in *TIMER if TIMER is not NULL.  }
function time(TimeNow: Ptime_t): time_t; cdecl;
  external libc name _PU + 'time';
{$EXTERNALSYM time}

{$IFNDEF ANDROID}
{ timegm is not a POSIX function, but it is present on both OS X and linux. }
function timegm(var UnixTime: tm): time_t; platform; cdecl;
  external libc name _PU + 'timegm';
{$EXTERNALSYM timegm}
{$ENDIF !ANDROID}

{
 POSIX defines timer_crete, timer_delete, timer_getoverrun, timer_gettime,
 timer_settime.  However, OS X doesn't provide these currently.
}

{$IFNDEF MACOS}
function timer_create(ClockId: Integer; SignalEvent: Psigevent; TimerId: Ptimer_t): Integer; cdecl;
  external libc name _PU + 'timer_create';
{$EXTERNALSYM timer_create}

function timer_delete(TimerId: timer_t): Integer; cdecl;
  external libc name _PU + 'timer_delete';
{$EXTERNALSYM timer_delete}

function timer_settime(TimerId: timer_t; Flags: Integer; const [Ref] ValueIn: itimerspec; PValueOut: Pitimerspec): Integer; cdecl;
  external libc name _PU + 'timer_settime';
{$EXTERNALSYM timer_settime}

function timer_gettime(TimerId: timer_t; Flags: Integer; PValueOut: Pitimerspec): Integer; cdecl;
  external libc name _PU + 'timer_gettime';
{$EXTERNALSYM timer_gettime}

function timer_getoverrun(TimerId: timer_t): Integer; cdecl;
  external libc name _PU + 'timer_getoverrun';
{$EXTERNALSYM timer_getoverrun}
{$ENDIF !MACOS}

{ Initializes time conversion information used by localtime based on TZ environment
   variable. }
procedure tzset; cdecl;
  external libc name _PU + 'tzset';
{$EXTERNALSYM tzset}
