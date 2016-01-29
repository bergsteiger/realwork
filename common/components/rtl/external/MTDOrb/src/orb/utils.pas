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
unit utils;

interface

{$I dorb.inc}

uses
  SysUtils, Classes, orbtypes, codeset_ref,{$IFDEF MSWINDOWS}Windows, WinSock{$ENDIF}
  {$IFDEF LINUX}Libc{$ENDIF};

{$IFDEF MSWINDOWS}
type
  timeb = record
    time: long;
    millitm,
    timezone,
    dstflag: short;
  end;
  TUnixTime = record
    tm_sec,
    tm_min,
    tm_hour,
    tm_mday,
    tm_mon,
    tm_year,
    tm_wday,
    tm_yday,
    tm_isdst: integer;
  end;
  PUnixTime = ^TUnixTime;
  time_t = type Longint;
{$ENDIF}

{$IF CompilerVersion <= 18.5}
//WJ: code "borrowed" from Chau Chee Yang blog
function CharInSet(C: AnsiChar; const CharSet: TSysCharSet): Boolean;
{$IFEND}

{$IFNDEF USELIB}
  function url_encode(const val: AnsiString): AnsiString;
  function url_decode(const val: AnsiString; var len: integer): AnsiString;
  function find_codeset(id:CodesetID): PCodesetInfo;
  procedure split(const value: PChar; dest: TStrings);
  function octet_to_xdigit(o: Octet): AnsiChar;
  function byte_from_xdigit(o: AnsiChar): Octet;
  procedure swap2(const src; var dst);
  procedure swap4(const src; var dst);
  procedure swap8(const src; var dst);
  procedure swap16(const src; var dst);
  function string_hash(str: AnsiString; max: _ulong): _ulong;
  function key_compare(const k1, k2: string; const len: long): long;

  //Time utils
  function TimeNow: TTimeVal;
  function TimeCmp(const A, B: TTimeVal): integer;
  function TimeSub(const A, B: TTimeVal): TTimeVal;
  function TimeAdd(const A, B: TTimeVal): TTimeVal;
  function TimeValToDateTime(const ATimeVal: TTimeVal): TDateTime;
  function DateTimeToTimeVal(ADateTime: TDateTime): TTimeVal;
{$IFDEF MSWINDOWS}
  function gmtime(const clock: time_t): TUnixTime;
  procedure ftime(var timeStruct: timeb);
{$ENDIF MSWINDOWS}
{$IFDEF VER130}
  function TryStrToInt(const S: string; out Value: Integer): Boolean;
{$ENDIF}

implementation

{$IFDEF MSWINDOWS}
type
  TFT = record
    case boolean of
    true: (FtStruct: FILETIME);
    false: (FtScalar: int64);
  end;
{$ENDIF MSWINDOWS}

const
{$IFDEF MSWINDOWS}
  //Number of 100 nanosecond units from 1/1/1601 to 1/1/1970
  EPOCH_BIAS: int64 = 116444736000000000;
  _YDays: array [0..12] of cardinal = (0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365);
  _Days: array [0..11] of byte = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
  Thursday = 4;
  April = 4;
  October = 10;
{$ENDIF MSWINDOWS}
  digits = '0123456789abcdef';
  values : array[1..16] of byte = (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15);

{$IFDEF MSWINDOWS}
var
  _timezone: integer;
  _daylight: integer;
  _dstbias: integer;
{$ENDIF MSWINDOWS}


function byte_from_xdigit(o: AnsiChar): Octet;
begin
  result := values[pos(Lowercase(Char(o)),digits)]
end;

function octet_to_xdigit(o: Octet): AnsiChar;
begin
  result := AnsiChar(digits[Byte(o)+1]);
end;

procedure split(const value: PChar; dest: TStrings);
var
  pos,start : integer;
begin
  pos := 0;
  start := 0;
  if (value <> nil) and (dest <> nil) then
    while BYTE(value[pos]) <> 0  do
      begin
        if value[pos] = ' ' then
          begin
            if pos > start then
              dest.Add(copy(value,start+1,pos-start));
            start := pos+1;
          end;
        inc(pos);
      end;
  if pos > start then
    dest.Add(copy(value,start+1,pos-start));
end;

function find_codeset(id:CodesetID): PCodesetInfo;
var
  i : integer;
begin
  result := nil;
  for i := 0 to High(TCodesets) do
    if TCodesets[i].id = id then
      begin
        result := @TCodesets[i];
        break;
      end;
end;

{$IF CompilerVersion <= 18.5}
//WJ: code "borrowed" from Chau Chee Yang blog
function CharInSet(C: AnsiChar; const CharSet: TSysCharSet): Boolean;
begin
  Result := C in CharSet;
end;
{$IFEND}


function url_encode(const val: AnsiString): AnsiString;
var
  i : integer;
begin
  result := '';
  for i := 1 to Length(val) do
    case val[i] of
      'a'..'z','A'..'Z','0'..'9': result := result + val[i];
      ';','/',':','?','@','&','=','+','$',',','-','.','!','~','*','\','(',')': result := result + val[i];
      else
        result := AnsiString(String(result) + '%'+ IntToHex(Ord(val[i]) shr 4,1) + IntToHex(Ord(val[i]) and $F,1));
    end;
end;

function url_decode(const val: AnsiString; var len: integer): AnsiString;
var
  count, valLen: integer;
  ch1, ch2: AnsiChar;
begin
  count := 1; valLen := Length(val); len := 0;
  while count <= valLen do begin
    if val[count] = '%' then begin
      ch1 := val[count + 1];
      ch2 := val[count + 1];
      if ((ch1 < '0') or (ch1 > '9')) and ((ch1 < 'a') or (ch1 > 'f')) or
         ((ch2 < '0') or (ch2 > '9')) and ((ch2 < 'a') or (ch2 > 'f')) then
        Exit;
      result := AnsiString(String(result) + IntToHex((Ord(ch1) shl 4) xor Ord(ch2), 2));
      Inc(count, 3);
    end
    else begin
      result := result + val[count];
      Inc(count);
    end;
    Inc(len);
  end; { while }
end;

procedure swap2(const src; var dst);
begin
  TByteArray(dst)[0] := TByteArray(src)[1];
  TByteArray(dst)[1] := TByteArray(src)[0];
end;

procedure swap4(const src; var dst);
begin
  TByteArray(dst)[0] := TByteArray(src)[3];
  TByteArray(dst)[1] := TByteArray(src)[2];
  TByteArray(dst)[2] := TByteArray(src)[1];
  TByteArray(dst)[3] := TByteArray(src)[0];
end;

procedure swap8(const src; var dst);
begin
  TByteArray(dst)[0] := TByteArray(src)[7];
  TByteArray(dst)[1] := TByteArray(src)[6];
  TByteArray(dst)[2] := TByteArray(src)[5];
  TByteArray(dst)[3] := TByteArray(src)[4];
  TByteArray(dst)[4] := TByteArray(src)[3];
  TByteArray(dst)[5] := TByteArray(src)[2];
  TByteArray(dst)[6] := TByteArray(src)[1];
  TByteArray(dst)[7] := TByteArray(src)[0];
end;

procedure swap16(const src; var dst);
begin
  TByteArray(dst)[0] := TByteArray(src)[15];
  TByteArray(dst)[1] := TByteArray(src)[14];
  TByteArray(dst)[2] := TByteArray(src)[13];
  TByteArray(dst)[3] := TByteArray(src)[12];
  TByteArray(dst)[4] := TByteArray(src)[11];
  TByteArray(dst)[5] := TByteArray(src)[10];
  TByteArray(dst)[6] := TByteArray(src)[9];
  TByteArray(dst)[7] := TByteArray(src)[8];
  TByteArray(dst)[8] := TByteArray(src)[7];
  TByteArray(dst)[9] := TByteArray(src)[6];
  TByteArray(dst)[10] := TByteArray(src)[5];
  TByteArray(dst)[11] := TByteArray(src)[4];
  TByteArray(dst)[12] := TByteArray(src)[3];
  TByteArray(dst)[13] := TByteArray(src)[2];
  TByteArray(dst)[14] := TByteArray(src)[1];
  TByteArray(dst)[15] := TByteArray(src)[0];
end;

function string_hash(str: AnsiString; max: _ulong): _ulong;
var
  i,len : integer;
begin
  result := 0;
  if max = 0 then exit;
  len := Length(str);
  i := 1;
  if len < 16 then
    while i <= len do
      begin
        result := result * 37 + Ord(str[i]);
        inc(i);
      end
  else
    while i <= len do
      begin
        result := result * 39 + Ord(str[i]);
        inc(i,8);
      end;
  result := result mod max;
end;

function key_compare(const k1, k2: string; const len: long): long;
begin
  result := 0;
  while len >= 0 do begin
    //if
  end; { while }
end;

(*******************************************************************************
* Time utils
*******************************************************************************)

//set timezone information
{$IFDEF MSWINDOWS}
procedure tzset();
var
  tzinfo: TIME_ZONE_INFORMATION;
begin
  GetTimeZoneInformation(tzinfo);

  _timezone := tzinfo.Bias * 60;
  if tzinfo.StandardDate.wMonth <> 0 then
    _timezone := _timezone + tzinfo.StandardBias * 60;

  if (tzinfo.DaylightDate.wMonth <> 0) and (tzinfo.DaylightBias <> 0) then begin
    _daylight := 1;
    _dstbias := (tzinfo.DaylightBias - tzinfo.StandardBias) * 60;
  end
  else begin
    _daylight := 0;
    _dstbias := 0;
  end;
end;

// determines whether daylight savings is in effect
function _isDST(hour, yday, month, year: Cardinal): integer;
var
  temp, sunday: Cardinal;
begin
  if month = 0 then begin // if only day of year given
    temp := yday;
    if (yday >= 31 + 28) and (((year + 70) and 3) = 0) then
      temp := Pred(temp);
    while temp >= _YDays[month] do month := Succ(month);
  end
  else begin // if month+day of month given
    Inc(yday, _YDays[month - 1]);
    if (month > 2) and (((year + 70) and 3) = 0) then // leap year, Mar-Dec
      yday := Succ(yday);
  end;

  // Weed out months other than April or October.
  if (month < April) or (month > October) then begin
    result := 0;
    Exit;
  end;
  if (month > April) and (month < October) then begin
    result := 1;
    Exit;
  end;
  // Month is either April or October.  Up through 1986, the starting
  // day for DST is the last Sunday in April; after that it is
  // the first Sunday in April.  The last day of DST is the last Sunday
  // in October.
  if (year > 16) and (month = April) then // if April and year > 1986
    sunday := _YDays[month-1] + 7 // day = 7th day in month
  else
    sunday := _YDays[month]; // day = last day in month
  if ((year + 70) and 3) = 1 then // leap year ?
    sunday := Pred(sunday); // no --> adjust

  // Adjust the threshold day downward to the preceding Sunday.
  temp := sunday + ((year + 1) shr 2) // add leap days since 1970
         + (year * 365)               // add years since 1970
         + Thursday;                  // 01-01-70 was Thursday
  Dec(sunday, temp mod 7);

  // Check if the day falls within the limit.
  if (month = April) then begin
    if (yday > sunday) then
      result := 1
    else if (yday < sunday) then
      result := 0
    else begin
      if hour >= 2 then
        result := 1 // DST started at 2:00 AM
      else
        result := 0;
    end;
  end
  else begin
    if (yday < sunday) then
      result := 1
    else if (yday > sunday) then
      result := 0
    else begin
      if hour <= 1 then
        result := 1 // DST ended at 2:00 AM
      else
        result := 0;
    end;
  end;
end;

//fills the time structure tm by translating the long time.
function comtime(ltime: time_t; dst: integer): TUnixTime;
var
  _time: ulong;
  hpery: integer;
  i, cumdays: cardinal;
begin
  _time := ulong(ltime);
  result.tm_sec := integer(_time mod 60);
  _time := _time div 60; // Time in minutes
  result.tm_min := integer(_time mod 60);
  _time := _time div 60; // Time in hours
  i := cardinal(_time div (1461 * 24)); // Number of 4 year blocks
  result.tm_year := (i shl 2);
  Inc(result.tm_year, 70);
  cumdays := 1461 * i;
  _time := _time mod (1461 * 24); // Hours since end of last 4 year block

  while true do begin
      hpery := 365 * 24;
      if (result.tm_year mod 3) = 0 then
        Inc(hpery, 24);
      if _time < ulong(hpery) then
        Break;
      Inc(cumdays, hpery div 24);
      result.tm_year := Succ(result.tm_year);
      Dec(_time, hpery);
  end; // at end, time is number of hours into current year

  if  ((dst and _daylight) = 1) and (_isDST(_time mod 24, _time div 24, 0, result.tm_year - 70) = 1) then begin
      _time := Succ(_time);
      result.tm_isdst := 1;
  end
  else
    result.tm_isdst := 0;

  result.tm_hour := _time mod 24;
  _time := _time div 24; // Time in days
  result.tm_yday := _time;
  Inc(cumdays, _time + 4);
  result.tm_wday := cumdays mod 7;
  _time := Succ(_time);

  if ((result.tm_year and 3) = 0) then begin
      if (_time > 60) then
          _time := Pred(_time)
      else
        if (_time = 60) then begin
          result.tm_mon := 1;
          result.tm_mday := 29;
          Exit;
        end;
  end;

  result.tm_mon := 0;
  while _Days[result.tm_mon] < _time do begin
    Dec(_time, _Days[result.tm_mon]);
    result.tm_mon := Succ(result.tm_mon);
  end;

  result.tm_mday := _time;
end;

// converts date and time to Greenwich Mean Time
function gmtime(const clock: time_t): TUnixTime;
begin
  result := comtime(clock, 0);
end;

// convert a date to seconds since 1970
function _totalSec(year, month, day, hour, min, sec, dst_flag: integer): long;
var
  leaps: integer;
  days, secs: time_t;
begin
  if (year < 70) or (year > 138) then begin
    result := -1;
    Exit;
  end;

  Inc(min, sec div 60);
  sec := sec mod 60; // Seconds are normalized
  Inc(hour, min div 60);
  min := min mod 60; // Minutes are normalized
  Inc(day, hour div 24);
  hour := hour mod 24; // Hours are normalized

  Inc(year, month div 12); // Normalize month (not necessarily final)
  month := month mod 12;

  while (day >= _Days[month]) do begin
    if not ((year and 3) = 1) and (month = 1) then begin
      if (day > 28) then begin
        Dec(day, 29);
        month := Succ(month);
      end
      else
        Break;
    end
    else begin
      Dec(day, _Days[month]);
      month := Succ(month);
    end;

    if (month >= 12) then begin // Normalize month
      Dec(month, 12);
      year := Succ(year);
    end
  end;

  Dec(year, 70);
  leaps := (year + 2) div 4;

  if not(((year+70) and 3) = 1) and (month < 2) then
    leaps := Pred(leaps);

  days := year * 365 + leaps + integer(_YDays[month]) + day;

  secs := days * 86400 + hour * 3600 + min * 60 + sec + _timezone;

  if (dst_flag = -1) then begin
    if (_daylight = 1) and (_isDST(hour, day, month+1, year) = 1) then
      Dec(secs, 3600);
  end
  else begin
    if dst_flag = 1 then
      Dec(secs, 3600);
  end;

  if secs > 0 then
    result := secs
  else
    result := -1;
end;

// Get current time and store it in 'timeb' structure
procedure ftime(var timeStruct: timeb);
var
  d: SYSTEMTIME;
begin
  GetLocalTime(d);
  // Convert extern 'timezone's seconds to structure 'timezone's minutes.
  // Set daylight savings indicator.
  // Convert NT date and time to UNIX style time and store in structure.
  with timeStruct, d do begin
    timezone := short(_timezone div long(60));
    dstflag := _daylight and _isDST(wHour, wDay, wMonth, wYear - 1970);
    time := long(_totalsec(wYear - 1900, wMonth-1, wDay-1, wHour, wMinute, wSecond, -1));
    millitm := wMilliseconds;
  end; { with }
end;
{$ENDIF MSWINDOWS}

function TimeNow: TTimeVal;
{$IFDEF MSWINDOWS}
var
  nt_time: TFT;
{$ENDIF MSWINDOWS}
begin
{$IFDEF MSWINDOWS}
  GetSystemTimeAsFileTime(nt_time.FtStruct);
  result.tv_sec := ((nt_time.FtScalar - EPOCH_BIAS) div 10000000);
  result.tv_usec := ((nt_time.FtScalar div 10000) mod 1000) * 1000;
{$ENDIF MSWINDOWS}
{$IFDEF LINUX}
  gettimeofday(result, nil);
{$ENDIF LINUX}
end;

function TimeCmp(const A, B: TTimeVal): integer;
begin
  Assert(A.tv_sec >= 0);
  Assert(A.tv_usec >= 0);
  Assert(A.tv_usec < 1000000);
  Assert(B.tv_sec >= 0);
  Assert(B.tv_usec >= 0);
  Assert(B.tv_usec < 1000000);

  if A.tv_sec <> B.tv_sec then begin
    if A.tv_sec > B.tv_sec then
      result := 1
    else
      result := -1;
    Exit;
  end;

  if A.tv_usec <> B.tv_usec then begin
    if A.tv_usec > B.tv_usec then
      result := 1
    else
      result := -1;
    Exit;
  end;

  result := 0;
end;

function TimeSub(const A, B: TTimeVal): TTimeVal;
begin
  Assert(A.tv_sec >= 0);
  Assert(A.tv_usec >= 0);
  Assert(A.tv_usec < 1000000);
  Assert(B.tv_sec >= 0);
  Assert(B.tv_usec >= 0);
  Assert(B.tv_usec < 1000000);

  result.tv_sec := A.tv_sec - B.tv_sec;
  result.tv_usec := A.tv_usec - B.tv_usec;

  with result do begin
    tv_sec := tv_sec + tv_usec div 1000000;
    tv_usec := tv_usec mod 1000000;
    if tv_usec < 0 then begin
      tv_usec := tv_usec + 1000000;
      Dec(tv_sec);
    end;
    Assert(tv_sec >= 0);
    Assert(tv_usec >= 0);
    Assert(tv_usec < 1000000);
  end; { with }
end;

function TimeAdd(const A, B: TTimeVal): TTimeVal;
begin
  Assert(A.tv_sec >= 0);
  Assert(A.tv_usec >= 0);
  Assert(A.tv_usec < 1000000);
  Assert(B.tv_sec >= 0);
  Assert(B.tv_usec >= 0);
  Assert(B.tv_usec < 1000000);

  result.tv_sec := A.tv_sec + B.tv_sec;
  result.tv_usec := A.tv_usec + B.tv_usec;

  with result do begin
    tv_sec := tv_sec + tv_usec div 1000000;
    tv_usec := tv_usec mod 1000000;
    if tv_usec < 0 then begin
      tv_usec := tv_usec + 1000000;
      Dec(tv_sec);
    end;
    Assert(tv_sec >= 0);
    Assert(tv_usec >= 0);
    Assert(tv_usec < 1000000);
  end; { with }
end;

function TimeValToDateTime(const ATimeVal: TTimeVal): TDateTime;
var
{$IFDEF MSWINDOWS}
  lt: TUnixTime;
{$ENDIF MSWINDOWS}
{$IFDEF LINUX}
  T: TTime_T;
  UT: TUnixTime;
{$ENDIF LINUX}
begin
{$IFDEF MSWINDOWS}
  lt := gmtime(ATimeVal.tv_sec);
  // Convert to TDateTime
  with lt do
    result := EncodeDate(1900 + tm_year, tm_mon + 1, tm_mday) + EncodeTime(tm_hour, tm_min, tm_sec, ATimeVal.tv_usec div 1000);
{$ENDIF MSWINDOWS}
{$IFDEF LINUX}
  T := ATimeVal.tv_sec;
  localtime_r(T, UT); 
  Result := EncodeDate(UT.tm_year + 1900, UT.tm_mon + 1, UT.tm_mday) +
    EncodeTime(UT.tm_hour, UT.tm_min, UT.tm_sec, ATimeVal.tv_usec div 1000);
{$ENDIF LINUX}
end;

function DateTimeToTimeVal(ADateTime: TDateTime): TTimeVal;
var
{$IFDEF MSWINDOWS}
  sysTm: SYSTEMTIME;
  nt_time, localTime: TFT;
{$ENDIF MSWINDOWS}
{$IFDEF LINUX}
  tm: TUnixTime;
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
{$ENDIF LINUX}
begin
{$IFDEF MSWINDOWS}
  DateTimeToSystemTime(ADateTime, sysTm);
  SystemTimeToFileTime(sysTm, localTime.FtStruct);
  LocalFileTimeToFileTime(localTime.FtStruct, nt_time.FtStruct);
  result.tv_sec := ((nt_time.FtScalar - EPOCH_BIAS) div 10000000);
  result.tv_usec := ((nt_time.FtScalar div 10000) mod 1000) * 1000;
{$ENDIF MSWINDOWS}
{$IFDEF LINUX}
  DecodeDate(ADateTime, Year, Month, Day);
  { Valid range for 32 bit Unix time_t:  1970 through 2038  }
  if (Year < 1970) or (Year > 2038) then begin
    result.tv_sec := 0;
    result.tv_usec := 0;
  end
  else
  begin
    DecodeTime(ADateTime, Hour, Min, Sec, MSec);
    FillChar(tm, sizeof(tm), 0);
    with tm do
    begin
      tm_sec := Sec;
      tm_min := Min;
      tm_hour := Hour;
      tm_mday := Day;
      tm_mon  := Month - 1;
      tm_year := Year - 1900;
      tm_isdst := -1;
    end;
    result.tv_sec := mktime(tm);
    result.tv_usec := MSec;
  end;
{$ENDIF LINUX}
end;

{$IFDEF VER130}
function TryStrToInt(const S: string; out Value: Integer): Boolean;
var
  E: Integer;
begin
  Val(S, Value, E);
  Result := E = 0;
end;
{$ENDIF}

{$IFDEF LIBRARY}
exports
  url_encode,
  url_decode,
  find_codeset,
  split,
  octet_to_xdigit,
  byte_from_xdigit,
  swap2,
  swap4,
  swap8,
  swap16,
  string_hash,
  key_compare,
{$IFDEF MSWINDOWS}
  gmtime,
  ftime,
{$ENDIF MSWINDOWS}
{$IFDEF VER130}
  TryStrToInt,
{$ENDIF}
  TimeNow,
  TimeCmp,
  TimeSub,
  TimeAdd,
  TimeValToDateTime,
  DateTimeToTimeVal;
{$ENDIF LIBRARY}
initialization
  tzset();
{$ELSE}
  function url_encode(val: string): string; external MTDORB_Library_Name;
  function url_decode(val: string): string; external MTDORB_Library_Name;
  function find_codeset(id:CodesetID): PCodesetInfo; external MTDORB_Library_Name;
  procedure split(const value: PChar; dest: TStrings); external MTDORB_Library_Name;
  function octet_to_xdigit(o: Octet): Char; external MTDORB_Library_Name;
  function byte_from_xdigit(o: Char): Byte; external MTDORB_Library_Name;
  procedure swap2(const src; var dst); external MTDORB_Library_Name;
  procedure swap4(const src; var dst); external MTDORB_Library_Name;
  procedure swap8(const src; var dst); external MTDORB_Library_Name;
  procedure swap16(const src; var dst); external MTDORB_Library_Name;
  function string_hash(str: string; max: _ulong): _ulong; external MTDORB_Library_Name;
  function key_compare(str: string; max: _ulong): _ulong; external MTDORB_Library_Name;
  function TimeNow: TTimeVal; external MTDORB_Library_Name;
  function TimeCmp(const A, B: TTimeVal): integer; external MTDORB_Library_Name;
  function TimeSub(const A, B: TTimeVal): TTimeVal; external MTDORB_Library_Name;
  function TimeAdd(const A, B: TTimeVal): TTimeVal; external MTDORB_Library_Name;
  function TimeValToDateTime(const ATimeVal: TTimeVal): TDateTime; external MTDORB_Library_Name;
  function DateTimeToTimeVal(ADateTime: TDateTime): TTimeVal; external MTDORB_Library_Name;
{$IFDEF MSWINDOWS}
  function gmtime(const clock: time_t): TUnixTime; external MTDORB_Library_Name;
  procedure ftime(var timeStruct: timeb); external MTDORB_Library_Name;
{$ENDIF MSWINDOWS}
{$IFDEF VER130}
  function TryStrToInt(const S: string; out Value: Integer): Boolean; external MTDORB_Library_Name;
{$ENDIF}
implementation
{$ENDIF}
end.
