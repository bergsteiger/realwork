{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                   OVCDT.PAS 2.17                      *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


{*************************************************************}
{***                                                       ***}
{*** This unit is provided for backward compatibility only ***}
{***    Applications should use the STDate unit instead    ***}
{***                                                       ***}
{*************************************************************}


unit OvcDT;
  {-General date and time routines}

interface

uses
  OvcData,
  STDate;

function CurrentDate : TOvcDate;
  {-returns today's date as a Julian date}
function CurrentTime : TOvcTime;
  {-return the current time in seconds since midnight}
function DateTimeToOvcDate(DT : TDateTime) : TOvcDate;
  {-Convert a Delphi date/time value into an Orpheus date}
function DateTimeToOvcTime(DT : TDateTime) : TOvcTime;
  {-Convert a Delphi date/time value into an Orpheus time}
procedure DateToDMY(Julian : TOvcDate; var Day, Month, Year : Integer);
  {-convert from a Julian date to day, month, year}
function DayOfWeek(Julian : TOvcDate) : TDayType;
  {-return the day of the week for a Julian date}
function DayOfWeekDMY(Day, Month, Year : Integer) : TDayType;
  {-return the day of the week for the day, month, year}
function DaysInMonth(Month, Year : Integer) : Integer;
  {-return the number of days in the specified month of a given year}
function DecTime(T : TOvcTime; Hours, Minutes, Seconds : Byte) : TOvcTime;
  {-subtract the specified hours, minutes, and seconds from a given time of day}
function DMYToDate(Day, Month, Year : Integer) : TOvcDate;
  {-convert from day, month, year to a Julian date}
function HMSToTime(Hours, Minutes, Seconds : Byte) : TOvcTime;
  {-convert hours, minutes, seconds to a time variable}
function IncDate(Julian : TOvcDate; Days, Months, Years : Integer) : TOvcDate;
  {-add (or subtract) the number of days, months, and years to a date}
function IncDateTrunc(Julian : TOvcDate; Months, Years : Integer) : TOvcDate;
  {-add (or subtract) the specified number of months and years to a date}
function IncTime(T : TOvcTime; Hours, Minutes, Seconds : Byte) : TOvcTime;
  {-add the specified hours, minutes, and seconds to a given time of day}
function IsLeapYear(Year : Integer) : Boolean;
  {-return True if Year is a leap year}
function OvcDateToDateTime(D : TOvcDate) : TDateTime;
  {-Convert an Orpheus date into a Delphi date/time value}
function OvcTimeToDateTime(T : TOvcTime) : TDateTime;
  {-Convert an Orpheus time into a Delphi date/time value}
procedure TimeToHMS(T : TOvcTime; var Hours, Minutes, Seconds : Byte);
  {-convert a time variable to hours, minutes, seconds}
function ValidDate(Day, Month, Year : Integer) : Boolean;
  {-verify that day, month, year is a valid date}
function ValidTime(Hours, Minutes, Seconds : Integer) : Boolean;
  {-return True if Hours:Minutes:Seconds is a valid time}


implementation

{$IFDEF TRIALRUN}
uses OrTrial;
{$I ORTRIALF.INC}
{$ENDIF}

function CurrentDate : TOvcDate;
  {-returns today's date as a julian}
begin
  Result := STDate.CurrentDate;
end;

function CurrentTime : TOvcTime;
  {-returns current time in seconds since midnight}
begin
  Result := STDate.CurrentTime;
end;

function DMYtoDate(Day, Month, Year : Integer) : TOvcDate;
  {-convert from day, month, year to a julian date}
begin
  Result := STDate.DMYToStDate(Day, Month, Year, 1900);
end;

function DateTimeToOvcDate(DT : TDateTime) : TOvcDate;
  {-Convert a Delphi date/time value into an Orpheus date}
begin
  Result := STDate.DateTimeToStDate(DT);
end;

function DateTimeToOvcTime(DT : TDateTime) : TOvcTime;
  {-Convert a Delphi date/time value into an Orpheus time}
begin
  Result := STDate.DateTimeToStTime(DT);
end;

procedure DateToDMY(Julian : TOvcDate; var Day, Month, Year : Integer);
  {-convert from a julian date to month, day, year}
begin
  STDate.StDateToDMY(Julian,Day,Month,Year);
end;

function DayOfWeek(Julian : TOvcDate) : TDayType;
  {-return the day of the week for the date. Returns TDayType(7) if Julian =
    BadDate.}
begin
  Result := STDate.DayOfWeek(Julian);
end;

function DayOfWeekDMY(Day, Month, Year : Integer) : TDayType;
  {-return the day of the week for the day, month, year}
begin
  Result := STDate.DayOfWeek(STDate.DMYtoStDate(Day, Month, Year, 1900));
end;

function DaysInMonth(Month, Year : Integer) : Integer;
  {-return the number of days in the specified month of a given year}
begin
  Result := STDate.DaysInMonth(Month, Year, 1900);
end;

function DecTime(T : TOvcTime; Hours, Minutes, Seconds : Byte) : TOvcTime;
  {-subtract the specified hours,minutes,seconds from T and return the result}
begin
  Result := STDate.DecTime(T,Hours,Minutes,Seconds);
end;

function HMStoTime(Hours, Minutes, Seconds : Byte) : TOvcTime;
  {-convert Hours, Minutes, Seconds to a Time variable}
begin
  Result := STDate.HMSToStTime(Hours,Minutes,Seconds);
end;

function IncDate(Julian : TOvcDate; Days, Months, Years : Integer) : TOvcDate;
  {-add (or subtract) the number of months, days, and years to a date.
    Months and years are added before days. No overflow/underflow
    checks are made}
begin
  Result := STDate.IncDate(Julian,Days,Months,Years);
end;

function IncDateTrunc(Julian : TOvcDate; Months, Years : Integer) : TOvcDate;
  {-add (or subtract) the specified number of months and years to a date}
begin
  Result := STDate.IncDateTrunc(Julian,Months,Years);
end;

function IncTime(T : TOvcTime; Hours, Minutes, Seconds : Byte) : TOvcTime;
  {-add the specified hours,minutes,seconds to T and return the result}
begin
  Result := STDate.IncTime(T,Hours,Minutes,Seconds);
end;

function IsLeapYear(Year : Integer) : Boolean;
  {-return True if Year is a leap year}
begin
  Result := STDate.IsLeapYear(Year);
end;

function OvcDateToDateTime(D : TOvcDate) : TDateTime;
  {-Convert an Orpheus date into a Delphi date/time value}
begin
  Result := STDate.StDateToDateTime(D);
end;

function OvcTimeToDateTime(T : TOvcTime) : TDateTime;
  {-Convert an Orpheus time into a Delphi date/time value}
begin
  Result := STDate.StTimeToDateTime(T);
end;

procedure SetDefaultYearAndMonth;
  {-initialize DefaultYear and DefaultMonth}
begin
  DefaultMonth := STDate.DefaultMonth;
  DefaultYear := STDate.DefaultYear;
end;

procedure TimeToHMS(T : TOvcTime; var Hours, Minutes, Seconds : Byte);
  {-convert a Time variable to Hours, Minutes, Seconds}
begin
  STDate.StTimeToHMS(T,Hours,Minutes,Seconds);
end;

function ValidDate(Day, Month, Year : Integer) : Boolean;
  {-verify that day, month, year is a valid date}
begin
  Result := STDate.ValidDate(Day, Month, Year, 1900);
end;

function ValidTime(Hours, Minutes, Seconds : Integer) : Boolean;
  {-return true if Hours:Minutes:Seconds is a valid time}
begin
  Result := STDate.ValidTime(Hours,Minutes,Seconds);
end;


initialization

  {initialize DefaultYear and DefaultMonth}
  SetDefaultYearAndMonth;
end.