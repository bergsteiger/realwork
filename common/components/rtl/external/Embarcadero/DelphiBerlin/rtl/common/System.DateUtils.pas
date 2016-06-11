{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{*******************************************************}
{       Date/time Utilities Unit                        }
{*******************************************************}

{ The following unit is ISO 8601 compliant.  What that means is this unit
  considers Monday the first day of the week (5.2.3).  Additionally ISO 8601
  dictates the following "the first calendar week of the year is the one
  that includes the first Thursday of that year" (3.17).  In other words the
  first week of the year is the first one that has four or more days.  For
  more information about ISO 8601 see: http://www.iso.ch/markete/8601.pdf

  The functions most impacted by ISO 8601 are marked as such in the interface
  section.

  The functions marked with "ISO 8601x" are not directly covered by ISO 8601
  but their functionality is a logical extension to the standard.

  Some of the functions, concepts or constants in this unit were provided by
  Jeroen W. Pluimers (http://www.all-im.com), Glenn Crouch, Rune Moberg and
  Ray Lischner (http://www.tempest-sw.com).

  The Julian Date and Modified Julian Date functions are based on code
  from NASA's SOHO site (http://sohowww.nascom.nasa.gov/solarsoft/gen/idl/time)
  in which they credit the underlying algorithms as by Fliegel and Van
  Flandern (1968) which was reprinted in the Explanatory Supplement to the
  Astronomical Almanac, 1992.

  Julian Date and Modified Julian Date is discussed in some detail on the
  US Naval Observatory Time Service site (http://tycho.usno.navy.mil/mjd.html).
  Additional information can be found at (http://www.treasure-troves.com/astro).

  Note that the Delphi RTL Date/Time system uses the "Proleptic Gregorian Calendar".
  That is, the Delphi RTL assumes the Gregorian calendar is in effect all the way
  back to 1/1/0001 (i.e., January 1, Year 1).   A definition of this calendaring
  system can be found at:

  http://en.wikipedia.org/wiki/Proleptic_Gregorian_calendar

  Therefore,  the RTL does not account for lost days that resulted from the transition
  from the Julian calendar to the Gregorian Calendar that the world underwent at
  various times during the 16th, 17th, and 18th centuries, or even later.  (For
  example, Russia did not adopt the Gregorian calendar until 1918)

  More about that transition, and the missing dates that resulted, can be found on
  Wikipedia:

  http://en.wikipedia.org/wiki/Gregorian_calendar

  It should also be noted that there is no connection between a "Julian Date" and
  the "Julian Calendar".

}

unit System.DateUtils;

interface
{$HPPEMIT LEGACYHPP}

uses
  System.SysUtils, System.Types, System.TimeSpan;

{ Simple trimming functions }

function DateOf(const AValue: TDateTime): TDateTime; inline;
function TimeOf(const AValue: TDateTime): TDateTime; inline;

{ Misc functions }

function IsInLeapYear(const AValue: TDateTime): Boolean;
function IsPM(const AValue: TDateTime): Boolean; inline;
function IsAM(const AValue: TDateTime): Boolean;
function IsValidDate(const AYear, AMonth, ADay: Word): Boolean;
function IsValidTime(const AHour, AMinute, ASecond, AMilliSecond: Word): Boolean;
function IsValidDateTime(const AYear, AMonth, ADay, AHour, AMinute, ASecond,
  AMilliSecond: Word): Boolean; inline;
function IsValidDateDay(const AYear, ADayOfYear: Word): Boolean;
function IsValidDateWeek(const AYear, AWeekOfYear,                    {ISO 8601}
  ADayOfWeek: Word): Boolean;
function IsValidDateMonthWeek(const AYear, AMonth, AWeekOfMonth,     {ISO 8601x}
  ADayOfWeek: Word): Boolean;
function WeeksInYear(const AValue: TDateTime): Word; inline;          {ISO 8601}
function WeeksInAYear(const AYear: Word): Word;                       {ISO 8601}
function DaysInYear(const AValue: TDateTime): Word; inline;
function DaysInAYear(const AYear: Word): Word; inline;
function DaysInMonth(const AValue: TDateTime): Word;
function DaysInAMonth(const AYear, AMonth: Word): Word;
function Today: TDateTime;
function Yesterday: TDateTime;
function Tomorrow: TDateTime;
function IsToday(const AValue: TDateTime): Boolean;
function IsSameDay(const AValue, ABasis: TDateTime): Boolean;

{ Pick-a-field functions }

function YearOf(const AValue: TDateTime): Word;
function MonthOf(const AValue: TDateTime): Word;
function WeekOf(const AValue: TDateTime): Word;                       {ISO 8601}
function DayOf(const AValue: TDateTime): Word;
function HourOf(const AValue: TDateTime): Word;
function MinuteOf(const AValue: TDateTime): Word;
function SecondOf(const AValue: TDateTime): Word;
function MilliSecondOf(const AValue: TDateTime): Word;

{ Start/End functions }

function StartOfTheYear(const AValue: TDateTime): TDateTime;
function EndOfTheYear(const AValue: TDateTime): TDateTime;
function StartOfAYear(const AYear: Word): TDateTime;
function EndOfAYear(const AYear: Word): TDateTime;

function StartOfTheMonth(const AValue: TDateTime): TDateTime;
function EndOfTheMonth(const AValue: TDateTime): TDateTime;
function StartOfAMonth(const AYear, AMonth: Word): TDateTime;
function EndOfAMonth(const AYear, AMonth: Word): TDateTime;

function StartOfTheWeek(const AValue: TDateTime): TDateTime;          {ISO 8601}
function EndOfTheWeek(const AValue: TDateTime): TDateTime;            {ISO 8601}
function StartOfAWeek(const AYear, AWeekOfYear: Word;                 {ISO 8601}
  const ADayOfWeek: Word = 1): TDateTime;
function EndOfAWeek(const AYear, AWeekOfYear: Word;                   {ISO 8601}
  const ADayOfWeek: Word = 7): TDateTime;

function StartOfTheDay(const AValue: TDateTime): TDateTime; inline;
function EndOfTheDay(const AValue: TDateTime): TDateTime;
function StartOfADay(const AYear, AMonth, ADay: Word): TDateTime; overload;
function EndOfADay(const AYear, AMonth, ADay: Word): TDateTime; overload;
function StartOfADay(const AYear, ADayOfYear: Word): TDateTime; overload;
function EndOfADay(const AYear, ADayOfYear: Word): TDateTime; overload;

{ This of that functions }

function MonthOfTheYear(const AValue: TDateTime): Word; inline;
function WeekOfTheYear(const AValue: TDateTime): Word; overload;      {ISO 8601}
function WeekOfTheYear(const AValue: TDateTime;                       {ISO 8601}
  var AYear: Word): Word; overload;
function DayOfTheYear(const AValue: TDateTime): Word;
function HourOfTheYear(const AValue: TDateTime): Word;
function MinuteOfTheYear(const AValue: TDateTime): LongWord;
function SecondOfTheYear(const AValue: TDateTime): LongWord;
function MilliSecondOfTheYear(const AValue: TDateTime): Int64;

function WeekOfTheMonth(const AValue: TDateTime): Word; overload;    {ISO 8601x}
function WeekOfTheMonth(const AValue: TDateTime; var AYear,          {ISO 8601x}
  AMonth: Word): Word; overload;
function DayOfTheMonth(const AValue: TDateTime): Word; inline;
function HourOfTheMonth(const AValue: TDateTime): Word;
function MinuteOfTheMonth(const AValue: TDateTime): Word;
function SecondOfTheMonth(const AValue: TDateTime): LongWord;
function MilliSecondOfTheMonth(const AValue: TDateTime): LongWord;

function DayOfTheWeek(const AValue: TDateTime): Word;                 {ISO 8601}
function HourOfTheWeek(const AValue: TDateTime): Word;                {ISO 8601}
function MinuteOfTheWeek(const AValue: TDateTime): Word;              {ISO 8601}
function SecondOfTheWeek(const AValue: TDateTime): LongWord;          {ISO 8601}
function MilliSecondOfTheWeek(const AValue: TDateTime): LongWord;     {ISO 8601}

function HourOfTheDay(const AValue: TDateTime): Word; inline;
function MinuteOfTheDay(const AValue: TDateTime): Word;
function SecondOfTheDay(const AValue: TDateTime): LongWord;
function MilliSecondOfTheDay(const AValue: TDateTime): LongWord;

function MinuteOfTheHour(const AValue: TDateTime): Word; inline;
function SecondOfTheHour(const AValue: TDateTime): Word;
function MilliSecondOfTheHour(const AValue: TDateTime): LongWord;

function SecondOfTheMinute(const AValue: TDateTime): Word; inline;
function MilliSecondOfTheMinute(const AValue: TDateTime): LongWord;

function MilliSecondOfTheSecond(const AValue: TDateTime): Word; inline;

{ Range checking functions }

function WithinPastYears(const ANow, AThen: TDateTime;
  const AYears: Integer): Boolean; inline;
function WithinPastMonths(const ANow, AThen: TDateTime;
  const AMonths: Integer): Boolean; inline;
function WithinPastWeeks(const ANow, AThen: TDateTime;
  const AWeeks: Integer): Boolean; inline;
function WithinPastDays(const ANow, AThen: TDateTime;
  const ADays: Integer): Boolean; inline;
function WithinPastHours(const ANow, AThen: TDateTime;
  const AHours: Int64): Boolean; inline;
function WithinPastMinutes(const ANow, AThen: TDateTime;
  const AMinutes: Int64): Boolean; inline;
function WithinPastSeconds(const ANow, AThen: TDateTime;
  const ASeconds: Int64): Boolean; inline;
function WithinPastMilliSeconds(const ANow, AThen: TDateTime;
  const AMilliSeconds: Int64): Boolean; inline;

{ Range query functions }

function YearsBetween(const ANow, AThen: TDateTime): Integer;
function MonthsBetween(const ANow, AThen: TDateTime): Integer;
function WeeksBetween(const ANow, AThen: TDateTime): Integer;
function DaysBetween(const ANow, AThen: TDateTime): Integer;
function HoursBetween(const ANow, AThen: TDateTime): Int64;
function MinutesBetween(const ANow, AThen: TDateTime): Int64;
function SecondsBetween(const ANow, AThen: TDateTime): Int64;
function MilliSecondsBetween(const ANow, AThen: TDateTime): Int64;

{ InRange functions }

function DateTimeInRange(ADateTime: TDateTime; AStartDateTime, AEndDateTime: TDateTime; aInclusive: Boolean = True): Boolean;
function DateInRange(ADate: TDate; AStartDate, AEndDate: TDate; AInclusive: Boolean = True): Boolean;
function TimeInRange(ATime: TTime; AStartTime, AEndTime: TTime; AInclusive: Boolean = True): Boolean;


{ Range spanning functions }
{ YearSpan and MonthSpan are approximates, not exact but pretty darn close }
function YearSpan(const ANow, AThen: TDateTime): Double;
function MonthSpan(const ANow, AThen: TDateTime): Double;
function WeekSpan(const ANow, AThen: TDateTime): Double;
function DaySpan(const ANow, AThen: TDateTime): Double;
function HourSpan(const ANow, AThen: TDateTime): Double;
function MinuteSpan(const ANow, AThen: TDateTime): Double;
function SecondSpan(const ANow, AThen: TDateTime): Double;
function MilliSecondSpan(const ANow, AThen: TDateTime): Double;

{ Increment/decrement datetime fields }

function IncYear(const AValue: TDateTime;
  const ANumberOfYears: Integer = 1): TDateTime; inline;
// function IncMonth is in SysUtils
function IncWeek(const AValue: TDateTime;
  const ANumberOfWeeks: Integer = 1): TDateTime; inline;
function IncDay(const AValue: TDateTime;
  const ANumberOfDays: Integer = 1): TDateTime; inline;
function IncHour(const AValue: TDateTime;
  const ANumberOfHours: Int64 = 1): TDateTime; inline;
function IncMinute(const AValue: TDateTime;
  const ANumberOfMinutes: Int64 = 1): TDateTime; inline;
function IncSecond(const AValue: TDateTime;
  const ANumberOfSeconds: Int64 = 1): TDateTime; inline;
function IncMilliSecond(const AValue: TDateTime;
  const ANumberOfMilliSeconds: Int64 = 1): TDateTime;

{ Unified encode/decode functions that deal with all datetime fields at once }

function EncodeDateTime(const AYear, AMonth, ADay, AHour, AMinute, ASecond,
  AMilliSecond: Word): TDateTime;
procedure DecodeDateTime(const AValue: TDateTime; out AYear, AMonth, ADay,
  AHour, AMinute, ASecond, AMilliSecond: Word);

{ Encode/decode functions that work with week of year and day of week }

function EncodeDateWeek(const AYear, AWeekOfYear: Word;               {ISO 8601}
  const ADayOfWeek: Word = 1): TDateTime;
procedure DecodeDateWeek(const AValue: TDateTime; out AYear,          {ISO 8601}
  AWeekOfYear, ADayOfWeek: Word);

{ Encode/decode functions that work with day of year }

function EncodeDateDay(const AYear, ADayOfYear: Word): TDateTime;
procedure DecodeDateDay(const AValue: TDateTime; out AYear, ADayOfYear: Word);

{ Encode/decode functions that work with week of month }

function EncodeDateMonthWeek(const AYear, AMonth, AWeekOfMonth,      {ISO 8601x}
  ADayOfWeek: Word): TDateTime;
procedure DecodeDateMonthWeek(const AValue: TDateTime;               {ISO 8601x}
  out AYear, AMonth, AWeekOfMonth, ADayOfWeek: Word);

{ The following functions are similar to the above ones except these don't
  generated exceptions on failure, they return false instead }

function TryEncodeDateTime(const AYear, AMonth, ADay, AHour, AMinute, ASecond,
  AMilliSecond: Word; out AValue: TDateTime): Boolean;
function TryEncodeDateWeek(const AYear, AWeekOfYear: Word;            {ISO 8601}
  out AValue: TDateTime; const ADayOfWeek: Word = 1): Boolean;
function TryEncodeDateDay(const AYear, ADayOfYear: Word;
  out AValue: TDateTime): Boolean;
function TryEncodeDateMonthWeek(const AYear, AMonth, AWeekOfMonth,   {ISO 8601x}
  ADayOfWeek: Word; var AValue: TDateTime): Boolean;

{ Recode functions for datetime fields }

function RecodeYear(const AValue: TDateTime; const AYear: Word): TDateTime;
function RecodeMonth(const AValue: TDateTime; const AMonth: Word): TDateTime;
function RecodeDay(const AValue: TDateTime; const ADay: Word): TDateTime;
function RecodeHour(const AValue: TDateTime; const AHour: Word): TDateTime;
function RecodeMinute(const AValue: TDateTime; const AMinute: Word): TDateTime;
function RecodeSecond(const AValue: TDateTime; const ASecond: Word): TDateTime;
function RecodeMilliSecond(const AValue: TDateTime;
  const AMilliSecond: Word): TDateTime;

function RecodeDate(const AValue: TDateTime; const AYear, AMonth,
  ADay: Word): TDateTime;
function RecodeTime(const AValue: TDateTime; const AHour, AMinute, ASecond,
  AMilliSecond: Word): TDateTime;
function RecodeDateTime(const AValue: TDateTime; const AYear, AMonth, ADay,
  AHour, AMinute, ASecond, AMilliSecond: Word): TDateTime;

{ The following function is similar to the above one except it doesn't
  generated an exception on failure, it return false instead }

function TryRecodeDateTime(const AValue: TDateTime; const AYear, AMonth, ADay,
  AHour, AMinute, ASecond, AMilliSecond: Word; out AResult: TDateTime): Boolean;

{ Fuzzy comparison }

function CompareDateTime(const A, B: TDateTime): TValueRelationship;
function SameDateTime(const A, B: TDateTime): Boolean;
function CompareDate(const A, B: TDateTime): TValueRelationship;
function SameDate(const A, B: TDateTime): Boolean;
function CompareTime(const A, B: TDateTime): TValueRelationship;
function SameTime(const A, B: TDateTime): Boolean;

{ For a given date these functions tell you the which day of the week of the
  month (or year).  If its a Thursday, they will tell you if its the first,
  second, etc Thursday of the month (or year).  Remember, even though its
  the first Thursday of the year it doesn't mean its the first week of the
  year.  See ISO 8601 above for more information. }

function NthDayOfWeek(const AValue: TDateTime): Word;

procedure DecodeDayOfWeekInMonth(const AValue: TDateTime; out AYear, AMonth,
  ANthDayOfWeek, ADayOfWeek: Word);

function EncodeDayOfWeekInMonth(const AYear, AMonth, ANthDayOfWeek,
  ADayOfWeek: Word): TDateTime;
function TryEncodeDayOfWeekInMonth(const AYear, AMonth, ANthDayOfWeek,
  ADayOfWeek: Word; out AValue: TDateTime): Boolean;

{ Error reporting }

procedure InvalidDateTimeError(const AYear, AMonth, ADay, AHour, AMinute,
  ASecond, AMilliSecond: Word; const ABaseDate: TDateTime = 0);
procedure InvalidDateWeekError(const AYear, AWeekOfYear, ADayOfWeek: Word);
procedure InvalidDateDayError(const AYear, ADayOfYear: Word);
procedure InvalidDateMonthWeekError(const AYear, AMonth, AWeekOfMonth,
  ADayOfWeek: Word);
procedure InvalidDayOfWeekInMonthError(const AYear, AMonth, ANthDayOfWeek,
  ADayOfWeek: Word);

{ Julian and Modified Julian Date conversion support }
{ Be aware that not all Julian Dates (or MJD) are encodable as a TDateTime }

function DateTimeToJulianDate(const AValue: TDateTime): Double;
function JulianDateToDateTime(const AValue: Double): TDateTime;
function TryJulianDateToDateTime(const AValue: Double;
  out ADateTime: TDateTime): Boolean;

function DateTimeToModifiedJulianDate(const AValue: TDateTime): Double;
function ModifiedJulianDateToDateTime(const AValue: Double): TDateTime;
function TryModifiedJulianDateToDateTime(const AValue: Double;
  out ADateTime: TDateTime): Boolean;

{ Unix date conversion support }

function DateTimeToUnix(const AValue: TDateTime; AInputIsUTC: Boolean = True): Int64;
function UnixToDateTime(const AValue: Int64; AReturnUTC: Boolean = True): TDateTime;

{ Constants used in this unit }

const
  DaysPerWeek = 7;
  WeeksPerFortnight = 2;
  MonthsPerYear = 12;
  YearsPerDecade = 10;
  YearsPerCentury = 100;
  YearsPerMillennium = 1000;

  DayMonday = 1;
  DayTuesday = 2;
  DayWednesday = 3;
  DayThursday = 4;
  DayFriday = 5;
  DaySaturday = 6;
  DaySunday = 7;

  MonthJanuary = 1;
  MonthFebruary = 2;
  MonthMarch = 3;
  MonthApril = 4;
  MonthMay = 5;
  MonthJune = 6;
  MonthJuly = 7;
  MonthAugust = 8;
  MonthSeptember = 9;
  MonthOctober = 10;
  MonthNovember = 11;
  MonthDecember = 12;

  
  OneHour = 1 / HoursPerDay;
  {$HPPEMIT OPENNAMESPACE}
  {$EXTERNALSYM OneHour}
  {$HPPEMIT 'extern const System::Extended OneHour /*= 4.166667E-02*/;'}
  OneMinute = 1 / MinsPerDay;
  {$EXTERNALSYM OneMinute}
  {$HPPEMIT 'extern const System::Extended OneMinute /*= 6.944444E-04*/;'}
  OneSecond = 1 / SecsPerDay;
  {$EXTERNALSYM OneSecond}
  {$HPPEMIT 'extern const System::Extended OneSecond /*= 1.157407E-05*/;'}
  OneMillisecond = 1 / MSecsPerDay;
  {$EXTERNALSYM OneMillisecond}
  {$HPPEMIT 'extern const System::Extended OneMillisecond /*= 1.157407E-08*/;'}

  EpochAsJulianDate = 2415018.5;
  {$EXTERNALSYM EpochAsJulianDate}
  {$HPPEMIT 'extern const System::Extended EpochAsJulianDate /*= 2.415018E+06*/;'}
  {$HPPEMIT CLOSENAMESPACE}
  EpochAsUnixDate   = -2209161600;

  { This is actual days per year but you need to know if it's a leap year}
  DaysPerYear: array [Boolean] of Word = (365, 366);

  { Used in RecodeDate, RecodeTime and RecodeDateTime for those datetime }
  {  fields you want to leave alone }
  RecodeLeaveFieldAsIs = High(Word);

{ Global variable used in this unit }

var
  { average over a 4 year span }
  ApproxDaysPerMonth: Double = 30.4375;
  ApproxDaysPerYear: Double  = 365.25;

  { The above are the average days per month/year over a normal 4 year period. }
  { We use these approximations because they are more accurate for the next }
  {  century or so.  After that you may want to switch over to these 400 year }
  {  approximations... }
  {    ApproxDaysPerMonth = 30.436875 }
  {    ApproxDaysPerYear  = 365.2425 }

type
  { Exception type used in this unit to signal that a given local time is situated in the
    invalid period (usually the missing hour during the DST time-shift). }
  ELocalTimeInvalid = class(Exception);
  EDateTimeException = class(Exception);

  { Specifies the type of a date/time value }
  TLocalTimeType = (
    { Identifies a date/time value when DST rules are not in effect }
    lttStandard,
    { Identifies a date/time value when DST rules are in effect }
    lttDaylight,
    { Identifies a date/time value situated in the ambiguous interval (ex. in the repeating hour) }
    lttAmbiguous,
    { Identifies a date/time value situated in the invalid interval (in the missing hour) }
    lttInvalid
  );

  { Use TTimeZone to gain access to a set of methods that can be used to convert between
    local time (as seen by the current user of the time zone) and universal time. }
  TTimeZone = class abstract
  private
    { Contains the "local" time zone. Instantiated at unit initialization }
    class var FLocal: TTimeZone;

    { Called during initialization. Initializes the cache (empty) and the local time zone }
    class constructor Create;

    { Called during finalization. Destroys the internal cache and contained time zones (inclusing the local one) }
    class destructor Destroy;

    { Returns the time zone’s current abbreviated name }
    function GetAbbreviationForNow: string; inline;

    { Returns the time zone’s current display name }
    function GetDisplayNameForNow: string; inline;

    { Calculates the UTC offset for the given local time. The UTC offset represents the amount of time that
      should be subtracted from the given local time to obtain universal time. }
    function GetUtcOffsetInSeconds(const ADateTime: TDateTime; const ForceDaylight: Boolean): Int64;

    { Returns the current time zone's UTC offset }
    function GetCurrentUtcOffset: TTimeSpan; inline;
  protected
    { Override in derived classes to supply offset information about a local time. }
    procedure DoGetOffsetsAndType(
      const ADateTime: TDateTime; out AOffset, ADstSave: Int64; out AType: TLocalTimeType); virtual; abstract;

    { Override in derived classes to supply a TZ name for a given local time. }
    function DoGetDisplayName(const ADateTime: TDateTime; const ForceDaylight: Boolean): string; virtual; abstract;

    { Override to return the time zone ID. }
    function DoGetID: string; virtual; abstract;
  public
    { Calculates the UTC offset for the given local time. The UTC offset represents the amount of time that should
      be subtracted from the given local time to obtain universal time. ForceDaylight specifies how
      ambiguous time is treated. }
    function GetUtcOffset(const ADateTime: TDateTime; const ForceDaylight: Boolean = False): TTimeSpan; inline;

    { Converts a given local time to universal time. ForceDaylight specifies how
      ambiguous time is treated. }
    function ToUniversalTime(const ADateTime: TDateTime; const ForceDaylight: Boolean = False): TDateTime; inline;

    { Converts a given universal time to local time. }
    function ToLocalTime(const ADateTime: TDateTime): TDateTime;

    { Returns the full name (localized if possible) for the time zone based on the given date/time. }
    function GetDisplayName(const ADateTime: TDateTime; const ForceDaylight: Boolean = False): string;

    { Returns an abbreviated name that can be used to position the local time in relation to UTC.
      Non-localized, always specified, and has the form: GMT[+|-HH[:MM]]. }
    function GetAbbreviation(const ADateTime: TDateTime; const ForceDaylight: Boolean = False): string;

    { Returns the type of a given date/time in this time zone. }
    function GetLocalTimeType(const ADateTime: TDateTime): TLocalTimeType; inline;

    { Checks whether the given local date/time is situated outside the DST period. ForceDaylight
      specifies how ambiguous time is treated. }
    function IsStandardTime(const ADateTime: TDateTime; const ForceDaylight: Boolean = False): Boolean;

    { Checks whether the given local date/time is invalid (situated within the limbo hour(s)) }
    function IsInvalidTime(const ADateTime: TDateTime): Boolean; inline;

    { Checks whether the given local date/time is ambiguous (situated within the repeating hour(s)) }
    function IsAmbiguousTime(const ADateTime: TDateTime): Boolean; inline;

    { Checks whether the given local date/time is situated in the DST period. ForceDaylight
      specifies how ambiguous time is treated. }
    function IsDaylightTime(const ADateTime: TDateTime; const ForceDaylight: Boolean = False): Boolean;

    { Returns the time zone identification string. }
    property ID: string read DoGetID;

    { Specifies the display name (localized if possible) of this time zone. }
    property DisplayName: string read GetDisplayNameForNow;

    { Current time zone's abbreviation. Non-localized, always specified, and has the form: GMT[+|-HH[:MM]]. }
    property Abbreviation: string read GetAbbreviationForNow;

    { Specifies the time zone's current UTC offset. }
    property UtcOffset: TTimeSpan read GetCurrentUtcOffset;

    { Specifies the local time zone. Use this property to obtain a TTimeZone instance that identifies
      current user's time zone. }
    class property Local: TTimeZone read FLocal;
  end;

/// <summary>
/// Converts an ISO8601 encoded date/time string to TDateTime. The result is in local time, if AReturnUTC is false.
/// </summary>
/// <example>
/// <para> "2013-10-18T20:36:22.966Z"  </para>
/// <para> This is 20:36 UTC time (Zulu). If the local timezone is MEST (UTC+2), then resulting time will be 22:36. </para>
/// </example>
function ISO8601ToDate(const AISODate: string; AReturnUTC: Boolean = True): TDateTime;

/// <summary> Tries to Convert an ISO8601 encoded date/time string to a TDateTime. </summary>
/// <param name ="AISODate"> an ISO8601 string e.g. "2013-10-18T20:36:22.966Z" </param>
/// <param name ="Value">  Out param of TDateTime value </param>
/// <param name = "AReturnUTC">  UTC time (Zulu) </param>
/// <returns> Boolean indicating success </returns>
function TryISO8601ToDate(const AISODate: string; out Value: TDateTime; AReturnUTC: Boolean = True): Boolean;

/// <summary> Converts a TDateTime value to ISO8601 format. </summary>
/// <param name="ADate"> A TDateTime value </param>
/// <param name="AInputIsUTC">
/// If AInputIsUTC is true, then the resulting ISO8601 string will show the exact same time as ADate has. </param>
/// <returns> ISO8601 representation of ADate. The resulting ISO string will be in UTC, i.e. will have a Z (Zulu) post
/// fix. If AInputIsUTC = true, then the time portion of ADate will not be modified. </returns>
function DateToISO8601(const ADate: TDateTime; AInputIsUTC: Boolean = True): string;


implementation

uses
  {$IFDEF MSWINDOWS}Winapi.Windows,{$ENDIF}
  {$IFDEF POSIX}Posix.Time, Posix.Unistd, Posix.SysTypes,{$ENDIF}
  {$IFDEF MACOS}Macapi.CoreFoundation, System.Mac.CFUtils,{$ENDIF}
  System.Character,
  System.RTLConsts,
  System.SysConst,
  System.Generics.Collections,
  System.Generics.Defaults;

function DateOf(const AValue: TDateTime): TDateTime;
begin
  Result := Trunc(AValue);
end;

function TimeOf(const AValue: TDateTime): TDateTime;
begin
  Result := Frac(AValue);
end;


function IsInLeapYear(const AValue: TDateTime): Boolean;
begin
  Result := IsLeapYear(YearOf(AValue));
end;

function IsPM(const AValue: TDateTime): Boolean;
begin
  Result := HourOf(AValue) >= 12;
end;

function IsAM(const AValue: TDateTime): Boolean;
begin
  Result := not IsPM(AValue);
end;

function IsValidDate(const AYear, AMonth, ADay: Word): Boolean;
begin
  Result := (AYear >= 1) and (AYear <= 9999) and
            (AMonth >= 1) and (AMonth <= 12) and
            (ADay >= 1) and (ADay <= DaysInAMonth(AYear, AMonth));
end;

function IsValidTime(const AHour, AMinute, ASecond, AMilliSecond: Word): Boolean;
begin
  Result := ((AHour < HoursPerDay) and (AMinute < MinsPerHour) and
             (ASecond < SecsPerMin) and (AMilliSecond < MSecsPerSec)) or
            ((AHour = 24) and (AMinute = 0) and // midnight early next day
             (ASecond = 0) and (AMilliSecond = 0));
end;

function IsValidDateTime(const AYear, AMonth, ADay, AHour, AMinute, ASecond,
  AMilliSecond: Word): Boolean;
begin
  Result := IsValidDate(AYear, AMonth, ADay) and
            IsValidTime(AHour, AMinute, ASecond, AMilliSecond);
end;

function IsValidDateMonthWeek(const AYear, AMonth, AWeekOfMonth,
  ADayOfWeek: Word): Boolean;
begin
  Result := (AYear >= 1) and (AYear <= 9999) and
            (AMonth >= 1) and (AMonth <= 12) and
            (AWeekOfMonth >= 1) and (AWeekOfMonth <= 5) and
            (ADayOfWeek >= DayMonday) and (ADayOfWeek <= DaySunday);
end;

function IsValidDateDay(const AYear, ADayOfYear: Word): Boolean;
begin
  Result := (AYear >= 1) and (AYear <= 9999) and
            (ADayOfYear >= 1) and (ADayOfYear <= DaysInAYear(AYear));
end;

function IsValidDateWeek(const AYear, AWeekOfYear, ADayOfWeek: Word): Boolean;
begin
  Result := (AYear >= 1) and (AYear <= 9999) and
            (AWeekOfYear >= 1) and (AWeekOfYear <= WeeksInAYear(AYear)) and
            (ADayOfWeek >= DayMonday) and (ADayOfWeek <= DaySunday);
end;

function DaysInYear(const AValue: TDateTime): Word;
begin
  Result := DaysInAYear(YearOf(AValue));
end;

function DaysInAYear(const AYear: Word): Word;
begin
  Result := DaysPerYear[IsLeapYear(AYear)];
end;

function DaysInMonth(const AValue: TDateTime): Word;
var
  LYear, LMonth, LDay: Word;
begin
  DecodeDate(AValue, LYear, LMonth, LDay);
  Result := DaysInAMonth(LYear, LMonth);
end;

function DaysInAMonth(const AYear, AMonth: Word): Word;
begin
  Result := MonthDays[(AMonth = 2) and IsLeapYear(AYear), AMonth];
end;

function WeeksInYear(const AValue: TDateTime): Word;
begin
  Result := WeeksInAYear(YearOf(AValue));
end;

function WeeksInAYear(const AYear: Word): Word;
var
  LDayOfWeek: Word;
begin
  Result := 52;
  LDayOfWeek := DayOfTheWeek(EncodeDate(AYear, 1, 1));
  if (LDayOfWeek = DayThursday) or
     ((LDayOfWeek = DayWednesday) and IsLeapYear(AYear)) then
    Inc(Result);
end;

function Today: TDateTime;
begin
  Result := Date;
end;

function Yesterday: TDateTime;
begin
  Result := Date - 1;
end;

function Tomorrow: TDateTime;
begin
  Result := Date + 1;
end;

function IsToday(const AValue: TDateTime): Boolean;
begin
  Result := IsSameDay(AValue, Date);
end;

function IsSameDay(const AValue, ABasis: TDateTime): Boolean;
begin
  Result := (AValue >= Trunc(ABasis)) and
            (AValue < Trunc(ABasis) + 1);
end;

function YearOf(const AValue: TDateTime): Word;
var
  LMonth, LDay: Word;
begin
  DecodeDate(AValue, Result, LMonth, LDay);
end;

function MonthOf(const AValue: TDateTime): Word;
var
  LYear, LDay: Word;
begin
  DecodeDate(AValue, LYear, Result, LDay);
end;

function WeekOf(const AValue: TDateTime): Word;
begin
  Result := WeekOfTheYear(AValue);
end;

function DayOf(const AValue: TDateTime): Word;
var
  LYear, LMonth: Word;
begin
  DecodeDate(AValue, LYear, LMonth, Result);
end;

function HourOf(const AValue: TDateTime): Word;
var
  LMinute, LSecond, LMilliSecond: Word;
begin
  DecodeTime(AValue, Result, LMinute, LSecond, LMilliSecond);
end;

function MinuteOf(const AValue: TDateTime): Word;
var
  LHour, LSecond, LMilliSecond: Word;
begin
  DecodeTime(AValue, LHour, Result, LSecond, LMilliSecond);
end;

function SecondOf(const AValue: TDateTime): Word;
var
  LHour, LMinute, LMilliSecond: Word;
begin
  DecodeTime(AValue, LHour, LMinute, Result, LMilliSecond);
end;

function MilliSecondOf(const AValue: TDateTime): Word;
var
  LHour, LMinute, LSecond: Word;
begin
  DecodeTime(AValue, LHour, LMinute, LSecond, Result);
end;

function StartOfTheYear(const AValue: TDateTime): TDateTime;
begin
  Result := EncodeDate(YearOf(AValue), 1, 1);
end;

function EndOfTheYear(const AValue: TDateTime): TDateTime;
begin
  Result := EndOfTheDay(EncodeDate(YearOf(AValue), 12, 31));
end;

function StartOfTheMonth(const AValue: TDateTime): TDateTime;
var
  LYear, LMonth, LDay: Word;
begin
  DecodeDate(AValue, LYear, LMonth, LDay);
  Result := EncodeDate(LYear, LMonth, 1);
end;

function EndOfTheMonth(const AValue: TDateTime): TDateTime;
var
  LYear, LMonth, LDay: Word;
begin
  DecodeDate(AValue, LYear, LMonth, LDay);
  Result := EndOfTheDay(EncodeDate(LYear, LMonth, DaysInAMonth(LYear, LMonth)));
end;

function StartOfTheWeek(const AValue: TDateTime): TDateTime;
begin
  Result := Trunc(AValue) - (DayOfTheWeek(AValue) - 1);
end;

function EndOfTheWeek(const AValue: TDateTime): TDateTime;
begin
  Result := EndOfTheDay(StartOfTheWeek(AValue) + 6);
end;

function StartOfTheDay(const AValue: TDateTime): TDateTime;
begin
  Result := Trunc(AValue);
end;

function EndOfTheDay(const AValue: TDateTime): TDateTime;
begin
  Result := RecodeTime(AValue, 23, 59, 59, 999);
end;

function StartOfAYear(const AYear: Word): TDateTime;
begin
  Result := EncodeDate(AYear, 1, 1);
end;

function EndOfAYear(const AYear: Word): TDateTime;
begin
  Result := EndOfTheDay(EncodeDate(AYear, 12, 31));
end;

function StartOfAMonth(const AYear, AMonth: Word): TDateTime;
begin
  Result := EncodeDate(AYear, AMonth, 1);
end;

function EndOfAMonth(const AYear, AMonth: Word): TDateTime;
begin
  Result := EndOfTheDay(EncodeDate(AYear, AMonth, DaysInAMonth(AYear, AMonth)));
end;

function StartOfAWeek(const AYear, AWeekOfYear, ADayOfWeek: Word): TDateTime;
begin
  Result := EncodeDateWeek(AYear, AWeekOfYear, ADayOfWeek);
end;

function EndOfAWeek(const AYear, AWeekOfYear, ADayOfWeek: Word): TDateTime;
begin
  Result := EndOfTheDay(EncodeDateWeek(AYear, AWeekOfYear, ADayOfWeek));
end;

function StartOfADay(const AYear, ADayOfYear: Word): TDateTime;
begin
  Result := EncodeDateDay(AYear, ADayOfYear);
end;

function EndOfADay(const AYear, ADayOfYear: Word): TDateTime;
begin
  Result := EndOfTheDay(EncodeDateDay(AYear, ADayOfYear));
end;

function StartOfADay(const AYear, AMonth, ADay: Word): TDateTime;
begin
  Result := StartOfAMonth(AYear, AMonth) + ADay - 1;
end;

function EndOfADay(const AYear, AMonth, ADay: Word): TDateTime;
begin
  Result := EndOfTheDay(EncodeDate(AYear, AMonth, ADay));
end;


function MonthOfTheYear(const AValue: TDateTime): Word;
begin
  Result := MonthOf(AValue);
end;

function WeekOfTheYear(const AValue: TDateTime): Word;
var
  LYear, LDOW: Word;
begin
  DecodeDateWeek(AValue, LYear, Result, LDOW);
end;

function WeekOfTheYear(const AValue: TDateTime; var AYear: Word): Word;
var
  LDOW: Word;
begin
  DecodeDateWeek(AValue, AYear, Result, LDOW);
end;

function DayOfTheYear(const AValue: TDateTime): Word;
begin
  Result := Trunc(AValue) - Trunc(StartOfTheYear(AValue)) + 1;
end;

function HourOfTheYear(const AValue: TDateTime): Word;
begin
  Result := HourOf(AValue) + (DayOfTheYear(AValue) - 1) * HoursPerDay;
end;

function MinuteOfTheYear(const AValue: TDateTime): LongWord;
begin
  Result := MinuteOf(AValue) + HourOfTheYear(AValue) * MinsPerHour;
end;

function SecondOfTheYear(const AValue: TDateTime): LongWord;
begin
  Result := SecondOf(AValue) + MinuteOfTheYear(AValue) * SecsPerMin;
end;

function MilliSecondOfTheYear(const AValue: TDateTime): Int64;
begin
  Result := MilliSecondOf(AValue) + Int64(SecondOfTheYear(AValue)) * MSecsPerSec;
end;


function WeekOfTheMonth(const AValue: TDateTime): Word;
var
  LYear, LMonth, LDayOfWeek: Word;
begin
  DecodeDateMonthWeek(AValue, LYear, LMonth, Result, LDayOfWeek);
end;

function WeekOfTheMonth(const AValue: TDateTime; var AYear, AMonth: Word): Word;
var
  LDayOfWeek: Word;
begin
  DecodeDateMonthWeek(AValue, AYear, AMonth, Result, LDayOfWeek);
end;

function DayOfTheMonth(const AValue: TDateTime): Word;
begin
  Result := DayOf(AValue);
end;

function HourOfTheMonth(const AValue: TDateTime): Word;
begin
  Result := HourOf(AValue) + (DayOfTheMonth(AValue) - 1) * HoursPerDay;
end;

function MinuteOfTheMonth(const AValue: TDateTime): Word;
begin
  Result := MinuteOf(AValue) + HourOfTheMonth(AValue) * MinsPerHour;
end;

function SecondOfTheMonth(const AValue: TDateTime): LongWord;
begin
  Result := SecondOf(AValue) + MinuteOfTheMonth(AValue) * SecsPerMin;
end;

function MilliSecondOfTheMonth(const AValue: TDateTime): LongWord;
begin
  Result := MilliSecondOf(AValue) + SecondOfTheMonth(AValue) * MSecsPerSec;
end;


function DayOfTheWeek(const AValue: TDateTime): Word;
begin
  Result := (DateTimeToTimeStamp(AValue).Date - 1) mod 7 + 1;
end;

function HourOfTheWeek(const AValue: TDateTime): Word;
begin
  Result := HourOf(AValue) + (DayOfTheWeek(AValue) - 1) * HoursPerDay;
end;

function MinuteOfTheWeek(const AValue: TDateTime): Word;
begin
  Result := MinuteOf(AValue) + HourOfTheWeek(AValue) * MinsPerHour;
end;

function SecondOfTheWeek(const AValue: TDateTime): LongWord;
begin
  Result := SecondOf(AValue) + MinuteOfTheWeek(AValue) * SecsPerMin;
end;

function MilliSecondOfTheWeek(const AValue: TDateTime): LongWord;
begin
  Result := MilliSecondOf(AValue) + SecondOfTheWeek(AValue) * MSecsPerSec;
end;


function HourOfTheDay(const AValue: TDateTime): Word;
begin
  Result := HourOf(AValue);
end;

function MinuteOfTheDay(const AValue: TDateTime): Word;
var
  LHours, LMinutes, LSeconds, LMilliSeconds: Word;
begin
  DecodeTime(AValue, LHours, LMinutes, LSeconds, LMilliSeconds);
  Result := LMinutes + LHours * MinsPerHour;
end;

function SecondOfTheDay(const AValue: TDateTime): LongWord;
var
  LHours, LMinutes, LSeconds, LMilliSeconds: Word;
begin
  DecodeTime(AValue, LHours, LMinutes, LSeconds, LMilliSeconds);
  Result := LSeconds + (LMinutes + LHours * MinsPerHour) * SecsPerMin;
end;

function MilliSecondOfTheDay(const AValue: TDateTime): LongWord;
var
  LHours, LMinutes, LSeconds, LMilliSeconds: Word;
begin
  DecodeTime(AValue, LHours, LMinutes, LSeconds, LMilliSeconds);
  Result := LMilliSeconds + (LSeconds + (LMinutes + LHours * MinsPerHour) * SecsPerMin) * MSecsPerSec;
end;


function MinuteOfTheHour(const AValue: TDateTime): Word;
begin
  Result := MinuteOf(AValue);
end;

function SecondOfTheHour(const AValue: TDateTime): Word;
var
  LHours, LMinutes, LSeconds, LMilliSeconds: Word;
begin
  DecodeTime(AValue, LHours, LMinutes, LSeconds, LMilliSeconds);
  Result := LSeconds + (LMinutes * SecsPerMin);
end;

function MilliSecondOfTheHour(const AValue: TDateTime): LongWord;
var
  LHours, LMinutes, LSeconds, LMilliSeconds: Word;
begin
  DecodeTime(AValue, LHours, LMinutes, LSeconds, LMilliSeconds);
  Result := LMilliSeconds + (LSeconds + LMinutes * SecsPerMin) * MSecsPerSec;
end;


function SecondOfTheMinute(const AValue: TDateTime): Word;
begin
  Result := SecondOf(AValue);
end;

function MilliSecondOfTheMinute(const AValue: TDateTime): LongWord;
var
  LHours, LMinutes, LSeconds, LMilliSeconds: Word;
begin
  DecodeTime(AValue, LHours, LMinutes, LSeconds, LMilliSeconds);
  Result := LMilliSeconds + LSeconds * MSecsPerSec;
end;


function MilliSecondOfTheSecond(const AValue: TDateTime): Word;
begin
  Result := MilliSecondOf(AValue);
end;


function WithinPastYears(const ANow, AThen: TDateTime;
  const AYears: Integer): Boolean;
begin
  Result := YearsBetween(ANow, AThen) <= AYears;
end;

function WithinPastMonths(const ANow, AThen: TDateTime;
  const AMonths: Integer): Boolean;
begin
  Result := MonthsBetween(ANow, AThen) <= AMonths;
end;

function WithinPastWeeks(const ANow, AThen: TDateTime;
  const AWeeks: Integer): Boolean;
begin
  Result := WeeksBetween(ANow, AThen) <= AWeeks;
end;

function WithinPastDays(const ANow, AThen: TDateTime;
  const ADays: Integer): Boolean;
begin
  Result := DaysBetween(ANow, AThen) <= ADays;
end;

function WithinPastHours(const ANow, AThen: TDateTime;
  const AHours: Int64): Boolean;
begin
  Result := HoursBetween(ANow, AThen) <= AHours;
end;

function WithinPastMinutes(const ANow, AThen: TDateTime;
  const AMinutes: Int64): Boolean;
begin
  Result := MinutesBetween(ANow, AThen) <= AMinutes;
end;

function WithinPastSeconds(const ANow, AThen: TDateTime;
  const ASeconds: Int64): Boolean;
begin
  Result := SecondsBetween(ANow, AThen) <= ASeconds;
end;

function WithinPastMilliSeconds(const ANow, AThen: TDateTime;
  const AMilliSeconds: Int64): Boolean;
begin
  Result := MilliSecondsBetween(ANow, AThen) <= AMilliSeconds;
end;

const
  CMillisPerDay = Int64(MSecsPerSec * SecsPerMin * MinsPerHour * HoursPerDay);

{ Internal, converts a date-time to milliseconds }
function DateTimeToMilliseconds(const ADateTime: TDateTime): Int64;
var
  LTimeStamp: TTimeStamp;
begin
  LTimeStamp := DateTimeToTimeStamp(ADateTime);
  Result := LTimeStamp.Date;
  Result := (Result * MSecsPerDay) + LTimeStamp.Time;
end;

function YearsBetween(const ANow, AThen: TDateTime): Integer;
begin
  Result := Abs(DateTimeToMilliseconds(ANow) - DateTimeToMilliseconds(AThen))
     div Round(CMillisPerDay * ApproxDaysPerYear);
end;

function MonthsBetween(const ANow, AThen: TDateTime): Integer;
begin
  Result := Abs(DateTimeToMilliseconds(ANow) - DateTimeToMilliseconds(AThen))
    div Round(CMillisPerDay * ApproxDaysPerMonth);
end;

function WeeksBetween(const ANow, AThen: TDateTime): Integer;
begin
  Result := Abs(DateTimeToMilliseconds(ANow) - DateTimeToMilliseconds(AThen))
    div (CMillisPerDay * DaysPerWeek);
end;

function DaysBetween(const ANow, AThen: TDateTime): Integer;
begin
  Result := Abs(DateTimeToMilliseconds(ANow) - DateTimeToMilliseconds(AThen))
    div CMillisPerDay;
end;

function HoursBetween(const ANow, AThen: TDateTime): Int64;
begin
  Result := Abs(DateTimeToMilliseconds(ANow) - DateTimeToMilliseconds(AThen))
    div (MSecsPerSec * SecsPerMin * MinsPerHour);
end;

function MinutesBetween(const ANow, AThen: TDateTime): Int64;
begin
  Result := Abs(DateTimeToMilliseconds(ANow) - DateTimeToMilliseconds(AThen))
    div (MSecsPerSec * SecsPerMin);
end;

function SecondsBetween(const ANow, AThen: TDateTime): Int64;
begin
  Result := Abs(DateTimeToMilliseconds(ANow) - DateTimeToMilliseconds(AThen))
    div (MSecsPerSec);
end;

function MilliSecondsBetween(const ANow, AThen: TDateTime): Int64;
begin
  Result := Abs(DateTimeToMilliseconds(ANow) - DateTimeToMilliseconds(AThen));
end;

function DateTimeInRange(ADateTime: TDateTime; AStartDateTime, AEndDateTime: TDateTime; aInclusive: Boolean = True): Boolean;
begin
  if aInclusive then
    Result := (AStartDateTime <= ADateTime) and (ADateTime <= AEndDateTime)
  else
    Result := (AStartDateTime < ADateTime) and (ADateTime < AEndDateTime);
end;

function TimeInRange(ATime: TTime; AStartTime, AEndTime: TTime; AInclusive: Boolean = True): Boolean;
var
  LTime, LStartTime, LEndTime: TTime;
begin
  LTime := TimeOf(ATime);
  LStartTime := TimeOf(AStartTime);
  LEndTime := TimeOF(AEndTime);

  if LEndTime < LStartTime then
    if AInclusive then
      Result := (LStartTime <= LTime) or (LTime <= LEndTime)
    else
      Result := (LStartTime < LTime) or (LTime < LEndTime)
  else
    if AInclusive then
      Result := (LStartTime <= LTime) and (LTime <= LEndTime)
    else
      Result := (LStartTime < LTime) and (LTime < LEndTime);
end;

function DateInRange(ADate: TDate; AStartDate, AEndDate: TDate; AInclusive: Boolean = True): Boolean;
begin
  if AInclusive then
    Result := (DateOf(AStartDate) <= DateOf(ADate)) and (DateOf(ADate) <= DateOf(AEndDate))
 else
    Result := (DateOf(AStartDate) < DateOf(ADate)) and (DateOf(ADate) < DateOf(AEndDate));
end;

function SpanOfNowAndThen(const ANow, AThen: TDateTime): TDateTime;
begin
  if ANow < AThen then
    Result := AThen - ANow
  else
    Result := ANow - AThen;
end;

function YearSpan(const ANow, AThen: TDateTime): Double;
begin
  Result := DaySpan(ANow, AThen) / ApproxDaysPerYear;
end;

function MonthSpan(const ANow, AThen: TDateTime): Double;
begin
  Result := DaySpan(ANow, AThen) / ApproxDaysPerMonth;
end;

function WeekSpan(const ANow, AThen: TDateTime): Double;
begin
  Result := DaySpan(ANow, AThen) / DaysPerWeek;
end;

function DaySpan(const ANow, AThen: TDateTime): Double;
begin
  Result := SpanOfNowAndThen(ANow, AThen);
end;

function HourSpan(const ANow, AThen: TDateTime): Double;
begin
  Result := HoursPerDay * SpanOfNowAndThen(ANow, AThen);
end;

function MinuteSpan(const ANow, AThen: TDateTime): Double;
begin
  Result := MinsPerDay * SpanOfNowAndThen(ANow, AThen);
end;

function SecondSpan(const ANow, AThen: TDateTime): Double;
begin
  Result := SecsPerDay * SpanOfNowAndThen(ANow, AThen);
end;

function MilliSecondSpan(const ANow, AThen: TDateTime): Double;
begin
  Result := MSecsPerDay * SpanOfNowAndThen(ANow, AThen);
end;

function IncYear(const AValue: TDateTime;
  const ANumberOfYears: Integer): TDateTime;
begin
  Result := IncMonth(AValue, ANumberOfYears * MonthsPerYear);
end;

function IncWeek(const AValue: TDateTime;
  const ANumberOfWeeks: Integer): TDateTime;
begin
  Result := IncDay(AValue, ANumberOfWeeks * DaysPerWeek);
end;

function IncDay(const AValue: TDateTime;
  const ANumberOfDays: Integer = 1): TDateTime;
begin
  Result := IncHour(AValue, ANumberOfDays * HoursPerDay);
end;

function IncHour(const AValue: TDateTime; const ANumberOfHours: Int64 = 1): TDateTime;
begin
  Result := IncMinute(AValue, ANumberOfHours * MinsPerHour);
end;

function IncMinute(const AValue: TDateTime;
  const ANumberOfMinutes: Int64 = 1): TDateTime;
begin
  Result := IncSecond(AValue, ANumberOfMinutes * SecsPerMin);
end;

function IncSecond(const AValue: TDateTime;
  const ANumberOfSeconds: Int64 = 1): TDateTime;
begin
  Result := IncMilliSecond(Avalue, ANumberOfSeconds * MSecsPerSec);
end;

function IncMilliSecond(const AValue: TDateTime;
  const ANumberOfMilliSeconds: Int64 = 1): TDateTime;
var
  TS: TTimeStamp;
  TempTime: Comp;
begin
  TS := DateTimeToTimeStamp(AValue);
  TempTime := TimeStampToMSecs(TS);
  TempTime := TempTime + ANumberOfMilliSeconds;
  TS := MSecsToTimeStamp(TempTime);
  Result := TimeStampToDateTime(TS);
end;

function EncodeDateTime(const AYear, AMonth, ADay, AHour, AMinute, ASecond,
  AMilliSecond: Word): TDateTime;
begin
  if not TryEncodeDateTime(AYear, AMonth, ADay,
                           AHour, AMinute, ASecond, AMilliSecond, Result) then
    InvalidDateTimeError(AYear, AMonth, ADay,
                         AHour, AMinute, ASecond, AMilliSecond);
end;

procedure DecodeDateTime(const AValue: TDateTime; out AYear, AMonth, ADay,
  AHour, AMinute, ASecond, AMilliSecond: Word);
begin
  DecodeDate(AValue, AYear, AMonth, ADay);
  DecodeTime(AValue, AHour, AMinute, ASecond, AMilliSecond);
end;

function EncodeDateWeek(const AYear, AWeekOfYear, ADayOfWeek: Word): TDateTime;
begin
  if not TryEncodeDateWeek(AYear, AWeekOfYear, Result, ADayOfWeek) then
    InvalidDateWeekError(AYear, AWeekOfYear, ADayOfWeek);
end;

const
  CDayMap: array [1..7] of Word = (7, 1, 2, 3, 4, 5, 6);

procedure DecodeDateWeek(const AValue: TDateTime; out AYear, AWeekOfYear,
  ADayOfWeek: Word);
var
  LDayOfYear: Integer;
  LMonth, LDay: Word;
  LStart: TDateTime;
  LStartDayOfWeek, LEndDayOfWeek: Word;
  LLeap: Boolean;
begin
  LLeap := DecodeDateFully(AValue, AYear, LMonth, LDay, ADayOfWeek);
  ADayOfWeek := CDayMap[ADayOfWeek];
  LStart := EncodeDate(AYear, 1, 1);
  LDayOfYear := Trunc(AValue - LStart + 1);
  LStartDayOfWeek := DayOfTheWeek(LStart);
  if LStartDayOfWeek in [DayFriday, DaySaturday, DaySunday] then
    Dec(LDayOfYear, 8 - LStartDayOfWeek)
  else
    Inc(LDayOfYear, LStartDayOfWeek - 1);
  if LDayOfYear <= 0 then
    DecodeDateWeek(LStart - 1, AYear, AWeekOfYear, LDay)
  else
  begin
    AWeekOfYear := LDayOfYear div 7;
    if LDayOfYear mod 7 <> 0 then
      Inc(AWeekOfYear);
    if AWeekOfYear > 52 then
    begin
      LEndDayOfWeek := LStartDayOfWeek;
      if LLeap then
      begin
        if LEndDayOfWeek = DaySunday then
          LEndDayOfWeek := DayMonday
        else
          Inc(LEndDayOfWeek);
      end;
      if LEndDayOfWeek in [DayMonday, DayTuesday, DayWednesday] then
      begin
        Inc(AYear);
        AWeekOfYear := 1;
      end;
    end;
  end;
end;

function EncodeDateDay(const AYear, ADayOfYear: Word): TDateTime;
begin
  if not TryEncodeDateDay(AYear, ADayOfYear, Result) then
    InvalidDateDayError(AYear, ADayOfYear);
end;

procedure DecodeDateDay(const AValue: TDateTime; out AYear, ADayOfYear: Word);
begin
  AYear := YearOf(AValue);
  ADayOfYear := DayOfTheYear(AValue);
end;

function EncodeDateMonthWeek(const AYear, AMonth, AWeekOfMonth,
  ADayOfWeek: Word): TDateTime;
begin
  if not TryEncodeDateMonthWeek(AYear, AMonth, AWeekOfMonth, ADayOfWeek,
                                Result) then
    InvalidDateMonthWeekError(AYear, AMonth, AWeekOfMonth, ADayOfWeek);
end;

procedure DecodeDateMonthWeek(const AValue: TDateTime;
  out AYear, AMonth, AWeekOfMonth, ADayOfWeek: Word);
var
  LDay, LDaysInMonth: Word;
  LDayOfMonth: Integer;
  LStart: TDateTime;
  LStartDayOfWeek, LEndOfMonthDayOfWeek: Word;
begin
  DecodeDateFully(AValue, AYear, AMonth, LDay, ADayOfWeek);
  ADayOfWeek := CDayMap[ADayOfWeek];
  LStart := EncodeDate(AYear, AMonth, 1);
  LStartDayOfWeek := DayOfTheWeek(LStart);
  LDayOfMonth := LDay;
  if LStartDayOfWeek in [DayFriday, DaySaturday, DaySunday] then
    Dec(LDayOfMonth, 8 - LStartDayOfWeek)
  else
    Inc(LDayOfMonth, LStartDayOfWeek - 1);
  if LDayOfMonth <= 0 then
    DecodeDateMonthWeek(LStart - 1, AYear, AMonth, AWeekOfMonth, LDay)
  else
  begin
    AWeekOfMonth := LDayOfMonth div 7;
    if LDayOfMonth mod 7 <> 0 then
      Inc(AWeekOfMonth);
    LDaysInMonth := DaysInAMonth(AYear, AMonth);
    LEndOfMonthDayOfWeek := DayOfTheWeek(EncodeDate(AYear, AMonth, LDaysInMonth));
    if (LEndOfMonthDayOfWeek in [DayMonday, DayTuesday, DayWednesday]) and
       (LDaysInMonth - LDay < LEndOfMonthDayOfWeek) then
    begin
      Inc(AMonth);
      if AMonth = 13 then
      begin
        AMonth := 1;
        Inc(AYear);
      end;
      AWeekOfMonth := 1;
    end;
  end;
end;


function TryEncodeDateTime(const AYear, AMonth, ADay, AHour, AMinute, ASecond,
  AMilliSecond: Word; out AValue: TDateTime): Boolean;
var
  LTime: TDateTime;
begin
  Result := TryEncodeDate(AYear, AMonth, ADay, AValue);
  if Result then
  begin
    Result := TryEncodeTime(AHour, AMinute, ASecond, AMilliSecond, LTime);
    if Result then
      if AValue >= 0 then
        AValue := AValue + LTime
      else
        AValue := AValue - LTime
  end;
end;

function TryEncodeDateWeek(const AYear, AWeekOfYear: Word;
  out AValue: TDateTime; const ADayOfWeek: Word): Boolean;
var
  LDayOfYear: Integer;
  LStartDayOfWeek: Word;
begin
  Result := IsValidDateWeek(AYear, AWeekOfYear, ADayOfWeek);
  if Result then
  begin
    AValue := EncodeDate(AYear, 1, 1);
    LStartDayOfWeek := DayOfTheWeek(AValue);
    LDayOfYear := (AWeekOfYear - 1) * 7 + ADayOfWeek - 1;
    if LStartDayOfWeek in [DayFriday, DaySaturday, DaySunday] then
      Inc(LDayOfYear, 8 - LStartDayOfWeek)
    else
      Dec(LDayOfYear, LStartDayOfWeek - 1);
    AValue := AValue + LDayOfYear;
  end;
end;

function TryEncodeDateDay(const AYear, ADayOfYear: Word;
  out AValue: TDateTime): Boolean;
begin
  Result := IsValidDateDay(AYear, ADayOfYear);
  if Result then
    AValue := StartOfAYear(AYear) + ADayOfYear - 1;
end;

function TryEncodeDateMonthWeek(const AYear, AMonth, AWeekOfMonth,
  ADayOfWeek: Word; var AValue: TDateTime): Boolean;
var
  LStartDayOfWeek: Word;
  LDayOfMonth: Integer;
begin
  Result := IsValidDateMonthWeek(AYear, AMonth, AWeekOfMonth, ADayOfWeek);
  if Result then
  begin
    AValue := EncodeDate(AYear, AMonth, 1);
    LStartDayOfWeek := DayOfTheWeek(AValue);
    LDayOfMonth := (AWeekOfMonth - 1) * 7 + ADayOfWeek - 1;
    if LStartDayOfWeek in [DayFriday, DaySaturday, DaySunday] then
      Inc(LDayOfMonth, 8 - LStartDayOfWeek)
    else
      Dec(LDayOfMonth, LStartDayOfWeek - 1);
    AValue := AValue + LDayOfMonth;
  end;
end;


function RecodeYear(const AValue: TDateTime; const AYear: Word): TDateTime;
begin
  Result := RecodeDateTime(AValue, AYear, RecodeLeaveFieldAsIs,
    RecodeLeaveFieldAsIs, RecodeLeaveFieldAsIs, RecodeLeaveFieldAsIs,
    RecodeLeaveFieldAsIs, RecodeLeaveFieldAsIs);
end;

function RecodeMonth(const AValue: TDateTime; const AMonth: Word): TDateTime;
begin
  Result := RecodeDateTime(AValue, RecodeLeaveFieldAsIs, AMonth,
    RecodeLeaveFieldAsIs, RecodeLeaveFieldAsIs, RecodeLeaveFieldAsIs,
    RecodeLeaveFieldAsIs, RecodeLeaveFieldAsIs);
end;

function RecodeDay(const AValue: TDateTime; const ADay: Word): TDateTime;
begin
  Result := RecodeDateTime(AValue, RecodeLeaveFieldAsIs, RecodeLeaveFieldAsIs,
    ADay, RecodeLeaveFieldAsIs, RecodeLeaveFieldAsIs, RecodeLeaveFieldAsIs,
    RecodeLeaveFieldAsIs);
end;

function RecodeHour(const AValue: TDateTime; const AHour: Word): TDateTime;
begin
  Result := RecodeDateTime(AValue, RecodeLeaveFieldAsIs, RecodeLeaveFieldAsIs,
    RecodeLeaveFieldAsIs, AHour, RecodeLeaveFieldAsIs, RecodeLeaveFieldAsIs,
    RecodeLeaveFieldAsIs);
end;

function RecodeMinute(const AValue: TDateTime; const AMinute: Word): TDateTime;
begin
  Result := RecodeDateTime(AValue, RecodeLeaveFieldAsIs, RecodeLeaveFieldAsIs,
    RecodeLeaveFieldAsIs, RecodeLeaveFieldAsIs, AMinute, RecodeLeaveFieldAsIs,
    RecodeLeaveFieldAsIs);
end;

function RecodeSecond(const AValue: TDateTime; const ASecond: Word): TDateTime;
begin
  Result := RecodeDateTime(AValue, RecodeLeaveFieldAsIs, RecodeLeaveFieldAsIs,
    RecodeLeaveFieldAsIs, RecodeLeaveFieldAsIs, RecodeLeaveFieldAsIs, ASecond,
    RecodeLeaveFieldAsIs);
end;

function RecodeMilliSecond(const AValue: TDateTime;
  const AMilliSecond: Word): TDateTime;
begin
  Result := RecodeDateTime(AValue, RecodeLeaveFieldAsIs, RecodeLeaveFieldAsIs,
    RecodeLeaveFieldAsIs, RecodeLeaveFieldAsIs, RecodeLeaveFieldAsIs,
    RecodeLeaveFieldAsIs, AMilliSecond);
end;

function RecodeDate(const AValue: TDateTime; const AYear, AMonth,
  ADay: Word): TDateTime;
begin
  Result := RecodeDateTime(AValue, AYear, AMonth, ADay, RecodeLeaveFieldAsIs,
    RecodeLeaveFieldAsIs, RecodeLeaveFieldAsIs, RecodeLeaveFieldAsIs);
end;

function RecodeTime(const AValue: TDateTime; const AHour, AMinute, ASecond,
  AMilliSecond: Word): TDateTime;
begin
  Result := RecodeDateTime(AValue, RecodeLeaveFieldAsIs, RecodeLeaveFieldAsIs,
    RecodeLeaveFieldAsIs, AHour, AMinute, ASecond, AMilliSecond);
end;

function RecodeDateTime(const AValue: TDateTime; const AYear, AMonth, ADay,
  AHour, AMinute, ASecond, AMilliSecond: Word): TDateTime;
begin
  if not TryRecodeDateTime(AValue, AYear, AMonth, ADay,
                           AHour, AMinute, ASecond, AMilliSecond, Result) then
    InvalidDateTimeError(AYear, AMonth, ADay,
                         AHour, AMinute, ASecond, AMilliSecond,
                         AValue);
end;

function TryRecodeDateTime(const AValue: TDateTime; const AYear, AMonth, ADay,
  AHour, AMinute, ASecond, AMilliSecond: Word; out AResult: TDateTime): Boolean;
var
  LYear, LMonth, LDay, LHour, LMinute, LSecond, LMilliSecond: Word;
begin
  DecodeDateTime(AValue, LYear, LMonth, LDay,
                         LHour, LMinute, LSecond, LMilliSecond);
  if AYear <> RecodeLeaveFieldAsIs then LYear := AYear;
  if AMonth <> RecodeLeaveFieldAsIs then LMonth := AMonth;
  if ADay <> RecodeLeaveFieldAsIs then LDay := ADay;
  if AHour <> RecodeLeaveFieldAsIs then LHour := AHour;
  if AMinute <> RecodeLeaveFieldAsIs then LMinute := AMinute;
  if ASecond <> RecodeLeaveFieldAsIs then LSecond := ASecond;
  if AMilliSecond <> RecodeLeaveFieldAsIs then LMilliSecond := AMilliSecond;
  Result := TryEncodeDateTime(LYear, LMonth, LDay,
                              LHour, LMinute, LSecond, LMilliSecond, AResult);
end;

{ Fuzzy comparison }

function CompareDateTime(const A, B: TDateTime): TValueRelationship;
begin
  // If the dates are the same, then only compare the time
  // This returns the correct result for values below the epoch
  if SameDate(A, B) then
  begin
    Result := CompareTime(A, B);
  end else
  begin
    if SameDateTime(A, B) then
      Result := EqualsValue
    else if A < B then
      Result := LessThanValue
    else
      Result := GreaterThanValue;
  end;
end;

function SameDateTime(const A, B: TDateTime): Boolean;
var
  TSA, TSB: TTimeStamp;
begin
  TSA := DateTimeToTimeStamp(A);
  TSB := DateTimeToTimeStamp(B);
  Result := (TSA.Date = TSB.Date) and (TSA.Time = TSB.Time);
end;

function CompareDate(const A, B: TDateTime): TValueRelationship;
begin
  if Trunc(A) = Trunc(B) then
    Result := EqualsValue
  else if A < B then
    Result := LessThanValue
  else
    Result := GreaterThanValue;
end;

function SameDate(const A, B: TDateTime): Boolean;
begin
  Result := Trunc(A) = Trunc(B);
end;

function CompareTime(const A, B: TDateTime): TValueRelationship;
begin
  if SameTime(A, B) then
    Result := EqualsValue
  else if Abs(Frac(A)) < Abs(Frac(B)) then
    Result := LessThanValue
  else
    Result := GreaterThanValue;
end;

function SameTime(const A, B: TDateTime): Boolean;
begin
  Result := (DateTimeToTimeStamp(A).Time = DateTimeToTimeStamp(B).Time);
end;


{ NthDayOfWeek conversion }

function NthDayOfWeek(const AValue: TDateTime): Word;
begin
  Result := (DayOfTheMonth(AValue) - 1) div 7 + 1;
end;

procedure DecodeDayOfWeekInMonth(const AValue: TDateTime; out AYear, AMonth,
  ANthDayOfWeek, ADayOfWeek: Word);
var
  ADay: Word;
begin
  DecodeDate(AValue, AYear, AMonth, ADay);
  ANthDayOfWeek := (ADay - 1) div 7 + 1;
  ADayOfWeek := DayOfTheWeek(AValue);
end;

function EncodeDayOfWeekInMonth(const AYear, AMonth, ANthDayOfWeek,
  ADayOfWeek: Word): TDateTime;
begin
  if not TryEncodeDayOfWeekInMonth(AYear, AMonth, ANthDayOfWeek, ADayOfWeek, Result) then
    InvalidDayOfWeekInMonthError(AYear, AMonth, ANthDayOfWeek, ADayOfWeek);
end;

function TryEncodeDayOfWeekInMonth(const AYear, AMonth,
  ANthDayOfWeek, ADayOfWeek: Word; out AValue: TDateTime): Boolean;
var
  LStartOfMonth, LDay: Word;
begin
  LStartOfMonth := DayOfTheWeek(StartOfAMonth(AYear, AMonth));
  if LStartOfMonth <= ADayOfWeek then
    LDay := (ADayOfWeek - LStartOfMonth + 1) + 7 * (ANthDayOfWeek - 1)
  else
    LDay := (7 - LStartOfMonth + 1) + ADayOfWeek + 7 * (ANthDayOfWeek - 1);
  Result := TryEncodeDate(AYear, AMonth, LDay, AValue);
end;


{ Julian and Modified Julian Date conversion support }

function DateTimeToJulianDate(const AValue: TDateTime): Double;
var
  LYear, LMonth, LDay: Word;
begin
  DecodeDate(AValue, LYear, LMonth, LDay);
  Result := (1461 * (LYear + 4800 + (LMonth - 14) div 12)) div 4 +
            (367 * (LMonth - 2 - 12 * ((LMonth - 14) div 12))) div 12 -
            (3 * ((LYear + 4900 + (LMonth - 14) div 12) div 100)) div 4 +
            LDay - 32075.5 + Abs(Frac(AValue));
end;

function JulianDateToDateTime(const AValue: Double): TDateTime;
begin
  if not TryJulianDateToDateTime(AValue, Result) then
    raise EConvertError.CreateFmt(SInvalidJulianDate, [AValue]);
end;

function TryJulianDateToDateTime(const AValue: Double;
  out ADateTime: TDateTime): Boolean;
var
  L, N, LYear, LMonth, LDay: Integer;
  ExtraMilliseconds: Integer;
begin
  L := Trunc(AValue) + 68570;
  N := 4 * L div 146097;
  L := L - (146097 * N + 3) div 4;
  LYear := 4000 * (L + 1) div 1461001;
  L := L - 1461 * LYear div 4 + 31;
  LMonth := 80 * L div 2447;
  LDay := L - 2447 * LMonth div 80;
  L := LMonth div 11;
  LMonth := LMonth + 2 - 12 * L;
  LYear := 100 * (N - 49) + LYear + L;
  Result := TryEncodeDate(Word(LYear), Word(LMonth), Word(LDay), ADateTime);
  if Result then
  begin
    ExtraMilliseconds := MilliSecondOfTheDay(Abs(Frac(aValue)));
    ADateTime := IncHour(ADateTime, -12); // Julian days start at noon
    ADateTime := IncMilliSecond(ADateTime, ExtraMilliseconds);
  end;
end;

const
  CJDToMJDOffset: TDateTime = 2400000.5;

function DateTimeToModifiedJulianDate(const AValue: TDateTime): Double;
begin
  Result := DateTimeToJulianDate(AValue) - CJDToMJDOffset;
end;

function ModifiedJulianDateToDateTime(const AValue: Double): TDateTime;
begin
  Result := JulianDateToDateTime(AValue + CJDToMJDOffset);
end;

function TryModifiedJulianDateToDateTime(const AValue: Double;
  out ADateTime: TDateTime): Boolean;
begin
  Result := TryJulianDateToDateTime(AValue + CJDToMJDOffset, ADateTime);
end;


{ Unix date conversion support }

function DateTimeToUnix(const AValue: TDateTime; AInputIsUTC: Boolean): Int64;
var
  LDate: TDateTime;
 begin
  if AInputIsUTC then
    LDate := AValue
  else
    LDate := TTimeZone.Local.ToUniversalTime(AValue);
  Result := SecondsBetween(UnixDateDelta, LDate);
  if LDate < UnixDateDelta then
     Result := -Result;
 end;

function UnixToDateTime(const AValue: Int64; AReturnUTC: Boolean): TDateTime;
begin
  if AReturnUTC then
    Result := IncSecond(UnixDateDelta, AValue)
  else
    Result := TTimeZone.Local.ToLocalTime(IncSecond(UnixDateDelta, AValue));
end;

{ Error reporting }

procedure InvalidDateTimeError(const AYear, AMonth, ADay, AHour, AMinute,
  ASecond, AMilliSecond: Word; const ABaseDate: TDateTime);
  function Translate(AOrig, AValue: Word): string;
  begin
    if AValue = RecodeLeaveFieldAsIs then
      if ABaseDate = 0 then
        Result := SMissingDateTimeField
      else
        Result := IntToStr(AOrig)
    else
      Result := IntToStr(AValue);
  end;
var
  LYear, LMonth, LDay, LHour, LMinute, LSecond, LMilliSecond: Word;
begin
  DecodeDate(ABaseDate, LYear, LMonth, LDay);
  DecodeTime(ABaseDate, LHour, LMinute, LSecond, LMilliSecond);
  raise EConvertError.CreateFmt(SInvalidDateTime,
                                [Translate(LYear, AYear) + FormatSettings.DateSeparator +
                                 Translate(LMonth, AMonth) + FormatSettings.DateSeparator +
                                 Translate(LDay, ADay) + ' ' +
                                 Translate(LHour, AHour) + FormatSettings.TimeSeparator +
                                 Translate(LMinute, AMinute) + FormatSettings.TimeSeparator +
                                 Translate(LSecond, ASecond) + FormatSettings.DecimalSeparator +
                                 Translate(LMilliSecond, AMilliSecond)]);
end;

procedure InvalidDateWeekError(const AYear, AWeekOfYear, ADayOfWeek: Word);
begin
  raise EConvertError.CreateFmt(SInvalidDateWeek, [AYear, AWeekOfYear, ADayOfWeek]);
end;

procedure InvalidDateDayError(const AYear, ADayOfYear: Word);
begin
  raise EConvertError.CreateFmt(SInvalidDateDay, [AYear, ADayOfYear]);
end;

procedure InvalidDateMonthWeekError(const AYear, AMonth, AWeekOfMonth,
  ADayOfWeek: Word);
begin
  raise EConvertError.CreateFmt(SInvalidDateMonthWeek, [AYear, AMonth,
    AWeekOfMonth, ADayOfWeek]);
end;

procedure InvalidDayOfWeekInMonthError(const AYear, AMonth, ANthDayOfWeek,
  ADayOfWeek: Word);
begin
  raise EConvertError.CreateFmt(SInvalidDayOfWeekInMonth, [AYear, AMonth,
    ANthDayOfWeek, ADayOfWeek]);
end;

type
  { Represents an OS local timezone }
  TLocalTimeZone = class(TTimeZone)
  private type
    { Per-year time data }
    TYearlyChanges = class
    private
      FStartOfDST, FEndOfDST: TDateTime;
      FBias, FBiasWithDST: Int64;
      FName, FDSTName: string;
    end;

  private
    FFastYearlyArray: array[1950 .. 2050] of TYearlyChanges;
    FYearlyCache: TObjectDictionary<Word, TYearlyChanges>;


{$IF Defined(MSWINDOWS)}
    FTZ: TIME_ZONE_INFORMATION;
{$ELSEIF Defined(MACOS)}
    FTZ: CFTimeZoneRef;
{$ELSEIF Defined(POSIX)}
    FTime: time_t;
    FOff: Integer;
    FAbb: MarshaledAString;
{$ENDIF POSIX}
    function TimeZoneChanged: Boolean;

    { Platform specific! }
    function GetChangesForYear(const AYear: Word): TYearlyChanges;

    { Helpers }
    function GetCachedChangesForYear(const AYear: Word): TYearlyChanges;
    function GetType(const ADateTime: TDateTime; const AChanges: TYearlyChanges): TLocalTimeType;

    { Clear the cache! }
    procedure ClearCache;
  protected
    { Override in derived classes to supply offset information about a local time. }
    procedure DoGetOffsetsAndType(
      const ADateTime: TDateTime; out AOffset, ADstSave: Int64; out AType: TLocalTimeType); override;

    { Override in derived classes to supply a TZ name for a given local time. }
    function DoGetDisplayName(const ADateTime: TDateTime; const ForceDaylight: Boolean): string; override;

    { Override in derived classes to supply an Id of the Time Zone }
    function DoGetID(): string; override;
  public
    { Internals }
    constructor Create();
    destructor Destroy; override;
  end;

{ TLocalTimeZone }

constructor TLocalTimeZone.Create;
{$IF Defined(POSIX) and not Defined(MACOS)}
var
  Ltm: tm;
{$ENDIF}
begin
  inherited;

  { Create and initilizite proper structures used for caching }
  FYearlyCache := TObjectDictionary<Word, TYearlyChanges>.Create([doOwnsValues]);
  FillChar(FFastYearlyArray, SizeOf(FFastYearlyArray), 0);

  // Cache TZ information for later checks
{$IF Defined(MSWINDOWS)}
  GetTimeZoneInformation(FTZ);
{$ELSEIF Defined(MACOS)}
  FTZ := CFTimeZoneCopyDefault();
{$ELSEIF Defined(POSIX)}
  FTime := time(nil);
  localtime_r(FTime, Ltm);
  FOff := Ltm.tm_gmtoff;
  FAbb := Ltm.tm_zone;
{$ENDIF POSIX}
end;

function TLocalTimeZone.TimeZoneChanged: Boolean;
{$IF Defined(MSWINDOWS)}
var
  LTZ: TIME_ZONE_INFORMATION;
begin
  { Get the TZ info and compare with what we had }
  GetTimeZoneInformation(LTZ);
  Result := not CompareMem(@FTZ, @LTZ, SizeOf(TIME_ZONE_INFORMATION));

  { Change the new data }
  if Result then
    FTZ := LTZ;
end;
{$ELSEIF Defined(MACOS)}
var
  LTZ: CFTimeZoneRef;
begin
  LTZ := CFTimeZoneCopyDefault();
  Result := not CFEqual(LTZ, FTZ);

  { Change the new data }
  if Result then
  begin
    CFRelease(FTZ);
    FTZ := LTZ;
  end;
end;
{$ELSEIF Defined(POSIX)}
var
  Ltm: tm;
begin
  localtime_r(FTime, Ltm);
  Result := (Ltm.tm_gmtoff <> FOff) or (Ltm.tm_zone <> FAbb);

  if Result then
  begin
    FOff := Ltm.tm_gmtoff;
    FAbb := Ltm.tm_zone;
  end;
end;
{$ENDIF POSIX}

procedure TLocalTimeZone.ClearCache;
var
  I: Integer;
begin
  { Free the fast lookup array }
  for I := Low(FFastYearlyArray) to High(FFastYearlyArray) do
    FreeAndNil(FFastYearlyArray[I]);

  { Free the dictionary afterward }
  FYearlyCache.Clear;
end;

destructor TLocalTimeZone.Destroy;
begin
  { Clear the cache, then free the dictionary }
  ClearCache();
  FYearlyCache.Free;

{$IFDEF MACOS}
  CFRelease(FTZ);
{$ENDIF}

  inherited;
end;

function TLocalTimeZone.DoGetID(): string;
{$IF Defined(MSWINDOWS)}
begin
  Result := FTZ.StandardName;
end;
{$ELSEIF Defined(MACOS)}
begin
  Result := '';

  if FTZ <> nil then
    Result := TCFString(CFTimeZoneGetName(FTZ));
end;
{$ELSEIF Defined(POSIX)}
begin
  Result := GetCachedChangesForYear(YearOf(Now)).FName;
end;
{$ENDIF POSIX}

function TLocalTimeZone.DoGetDisplayName(const ADateTime: TDateTime; const ForceDaylight: Boolean): string;
var
  LChanges: TYearlyChanges;
  LType: TLocalTimeType;
begin
  { Obtain the block for the required year }
  LChanges := GetCachedChangesForYear(YearOf(ADateTime));

  { Obtain the type of the date/time }
  LType := GetType(ADateTime, LChanges);

  { Select the proper name. }
  if (LType = lttDaylight) or ((LType = lttAmbiguous) and ForceDaylight) then
    Result := LChanges.FDSTName
  else
    Result := LChanges.FName;
end;

procedure TLocalTimeZone.DoGetOffsetsAndType(const ADateTime: TDateTime;
  out AOffset, ADstSave: Int64; out AType: TLocalTimeType);
var
  LChanges: TYearlyChanges;
begin
  { Obtain the block for the required year }
  LChanges := GetCachedChangesForYear(YearOf(ADateTime));

  { Fill in Biases }
  ADstSave := (LChanges.FBiasWithDST - LChanges.FBias);
  AOffset := LChanges.FBias;

  AType := GetType(ADateTime, LChanges);
end;

function TLocalTimeZone.GetCachedChangesForYear(const AYear: Word): TYearlyChanges;
begin
  MonitorEnter(FYearlyCache); // Acquire the lock

  { Check for timezone change, and clear the cache in that case }
  if TimeZoneChanged then
    ClearCache();

  try
    { Check for a fast lookup value }
    if (AYear >= Low(FFastYearlyArray)) and (AYear <= High(FFastYearlyArray)) then
    begin
      if FFastYearlyArray[AYear] = nil then
        FFastYearlyArray[AYear] := GetChangesForYear(AYear);

      Result := FFastYearlyArray[AYear];
    end else
    if not FYearlyCache.TryGetValue(AYear, Result) then
    begin
      { Check for a cached value }
      Result := GetChangesForYear(AYear);
      FYearlyCache.Add(AYear, Result);
    end;
  finally
    MonitorExit(FYearlyCache); // Release the lock
  end;
end;

function TLocalTimeZone.GetChangesForYear(const AYear: Word): TYearlyChanges;
{$IF defined(MSWINDOWS)}
  function GetAbsoluteDateFromRule(const AYear, AMonth, ADoW, ADoWIndex: Word; AToD: TTime): TDateTime;
  const
    CReDoW: array [0 .. 6] of Integer = (7, 1, 2, 3, 4, 5, 6);

  var
    LExpDayOfWeek, LActualDayOfWeek: Word;

  begin
    { No actual rule }
    if (AMonth = 0) and (ADoW = 0) and (ADoWIndex = 0) then
      Exit(0);

    { Transform into ISO 8601 day of week }
    LExpDayOfWeek := CReDoW[ADoW];

    { Generate a date in the form of: Year/Month/1st of month }
    Result := EncodeDate(AYear, AMonth, 1);

    { Get the day of week for this newly crafted date }
    LActualDayOfWeek := DayOfTheWeek(Result);

    { We're too far off now, let's decrease the number of days till we get to the desired one }
    if LActualDayOfWeek > LExpDayOfWeek then
      Result := IncDay(Result, DaysPerWeek - LActualDayOfWeek + LExpDayOfWeek)
    else if (LActualDayOfWeek < LExpDayOfWeek) Then
      Result := IncDay(Result, LExpDayOfWeek - LActualDayOfWeek);

    { Skip the required number of weeks }
    Result := IncDay(Result, DaysPerWeek * (ADoWIndex - 1));

    { If we've skipped the day in this moth, go back a few weeks until we get it right again }
    while (MonthOf(Result) > AMonth) do
      Result := IncDay(Result, -DaysPerWeek);

    { Add the time part }
    Result := Result + AToD;
  end;

var
  LTZ: TIME_ZONE_INFORMATION;
  LResult: Cardinal;

begin
  Result := TYearlyChanges.Create;
  FillChar(LTZ, SizeOf(LTZ), 0);

  { Win32 can't handle dates outside this range }
  if (AYear <= 1601) or (AYear > 30827) then
    exit;

  { Use either Vista of lower APIs. If Vista one fails, also use the lower API. }
  if TOSVersion.Check(6, 1, 1) and GetTimeZoneInformationForYear(AYear, nil, LTZ) then
    LResult := TIME_ZONE_ID_STANDARD
  else
    LResult := GetTimeZoneInformation(LTZ); { Try with the old API }

  { Exit on error }
  if LResult = TIME_ZONE_ID_INVALID then
    exit;

  { Try to obtain the daylight adjustment for the specified year }
  if LResult <> TIME_ZONE_ID_UNKNOWN then
  begin
    with LTZ.StandardDate do
      Result.FEndOfDST := GetAbsoluteDateFromRule(AYear, wMonth, wDayOfWeek,
        wDay, EncodeTime(wHour, wMinute, wSecond, 0));

    with LTZ.DaylightDate do
      Result.FStartOfDST := GetAbsoluteDateFromRule(AYear, wMonth, wDayOfWeek,
        wDay, EncodeTime(wHour, wMinute, wSecond, 0));
  end;

  Result.FBias := -SecsPerMin * (LTZ.StandardBias + LTZ.Bias);
  Result.FBiasWithDST := -SecsPerMin * (LTZ.DaylightBias + LTZ.Bias);
  Result.FName := LTZ.StandardName;
  Result.FDSTName := LTZ.DaylightName;
end;
{$ELSEIF defined(MACOS)}
function MacToDateTime(const AbsTime: CFAbsoluteTime; const ATZ: CFTimeZoneRef): TDateTime;
var
  LDate: CFGregorianDate;
begin
  { Decompose the object }
  LDate := CFAbsoluteTimeGetGregorianDate(AbsTime, ATZ);

  { Generate a TDateTime now }
  with LDate do
    Result := EncodeDateTime(year, month, day, hour, minute, Round(second), 0);
end;

procedure CopyInfo(const ATZ: CFTimeZoneRef; const AStartBT: CFAbsoluteTime; out LPt1DT, LPt2DT: TDateTime;
  out LPt1Off, LPt2Off: Int64);
var
  L1stTrans, L2ndTrans: CFAbsoluteTime;
begin
  { Calculate the first and the last transition times }
  L1stTrans := CFTimeZoneGetNextDaylightSavingTimeTransition(ATZ, AStartBT);
  L2ndTrans := CFTimeZoneGetNextDaylightSavingTimeTransition(ATZ, L1stTrans);

  { Obtain the GMT offset before first transition }
  LPt1Off := Round(CFTimeZoneGetSecondsFromGMT(ATZ, AStartBT));

  if (L1stTrans <> 0) or (L2ndTrans > L1stTrans) then
  begin
    { Convert the first transition to TDateTime }
    LPt1DT := MacToDateTime(L1stTrans, ATZ);

    { Convert the second transition to TDateTime }
    LPt2DT := MacToDateTime(L2ndTrans, ATZ);

    { Obtain the GMT offset before second transition }
    LPt2Off := Round(CFTimeZoneGetSecondsFromGMT(ATZ, L1stTrans));
  end else
  begin
    { There were no transitions. Use the base data }
    LPt2Off := LPt1Off;
    LPt1DT := MacToDateTime(AStartBT, ATZ);
    LPt2DT := LPt1DT;
  end;
end;

var
  LLocaleRef: CFLocaleRef;
  L1stJan: CFAbsoluteTime;
  LDate: CFGregorianDate;

  { What we expect }
  LStart, LEnd: TDateTime;
begin
  { Create the changes block. Keep it clean so far. }
  Result := TYearlyChanges.Create;

  if FTZ <> nil then
  begin
    { Encode 1st Jan of the given year into Absolute time }
    with LDate do
    begin
      year := AYear;
      month := MonthJanuary;
      day := 1;
      hour := 0;
      minute := 0;
      second := 0;
    end;

    { Generate an absolute time (1st Jan Year) }
    L1stJan := CFGregorianDateGetAbsoluteTime(LDate, FTZ);

    { Use CopyInfo but reverse the variables depending on the Northern/Southern hemispheres }
    if not CFTimeZoneIsDaylightSavingTime(FTZ, L1stJan) then
      CopyInfo(FTZ, L1stJan, LStart, LEnd, Result.FBias, Result.FBiasWithDST)
    else
      CopyInfo(FTZ, L1stJan, LEnd, LStart, Result.FBiasWithDST, Result.FBias);

    { Fill the remaining parts of the structure }
    LLocaleRef := CFLocaleCopyCurrent();

    if LLocaleRef <> nil then
    begin
      { Obtain localized names of the locale (normal and DST) }
      try
        Result.FName := TCFString(CFTimeZoneCopyLocalizedName(FTZ,
          kCFTimeZoneNameStyleStandard, LLocaleRef)).AsString(True);

        Result.FDSTName := TCFString(CFTimeZoneCopyLocalizedName(FTZ,
          kCFTimeZoneNameStyleDaylightSaving, LLocaleRef)).AsString(True);
      finally
        CFRelease(LLocaleRef);
      end;
    end else
    begin
      { Fall back to std info }
      Result.FName := TCFString(CFTimeZoneGetName(FTZ));
      Result.FDSTName := Result.FName;
    end;

    Result.FStartOfDST := IncSecond(LStart, Result.FBias - Result.FBiasWithDST); // Remove the save time from result
    Result.FEndOfDST := IncSecond(LEnd, Result.FBiasWithDST - Result.FBias);     // Add the save time to result
  end;
end;
{$ELSEIF defined(POSIX)}
var
  LComp: tm;
  LTime: time_t;
  LLastOffset, LDay: Integer;
  LIsSecondCycle, LIsStandard: Boolean;
  LChars: TBytes;
begin
  SetLength(LChars, 256);
  { Create the changes block. Keep it clean so far. }
  Result := TYearlyChanges.Create;

  if (SizeOf(LongInt) = 4) and ((AYear < 1970) or (AYear > 2037)) then
    Exit; // Not supported

  { Generate a value that starts with 1st of the current year }
  FillChar(LComp, SizeOf(LComp), 0);
  LComp.tm_mday := 1;
  LComp.tm_year := AYear - 1900;
  LTime := mktime(LComp);

  if LTime = -1 then
    Exit; // Some error occured!

  { Unknown DST information. Quit. }
  if LComp.tm_isdst < -1 then
    Exit;

  { Check if the DST or STD time was in effect at 1st Jan }
  LIsStandard := LComp.tm_isdst = 0;

  { Prepare to iterate over the year }
  LLastOffset := LComp.tm_gmtoff;
  LIsSecondCycle := false;

  { Initialize info, in some locales like Russia the clock is not changed for daylight saving }
  Result.FStartOfDST := IncSecond(FileDateToDateTime(LTime), LLastOffset - LComp.tm_gmtoff);
  Result.FEndOfDST := Result.FStartOfDST;
  Result.FBias := LLastOffset;
  Result.FDSTName := '';
  Result.FBiasWithDST := LLastOffset;
  Result.FName := '';

  for LDay := 0 to DaysInAYear(AYear) - 1 do
  begin
    { Skip to next day }
    Inc(LTime, SecsPerDay);

    { Decompose the time }
    if localtime_r(LTime, LComp) <> @LComp then
      Exit;

    if LComp.tm_gmtoff <> LLastOffset then
    begin
      { We found the day when the time change occured. Serach the hour now. }

      repeat
        Dec(LTime, SecsPerHour);

        { Decompose the time }
        if localtime_r(LTime, LComp) <> @LComp then
          Exit;
      until LComp.tm_gmtoff = LLastOffset;

      { Search for the minute }
      repeat
        Inc(LTime, SecsPerMin);

        { Decompose the time }
        if localtime_r(LTime, LComp) <> @LComp then
          Exit;
      until LComp.tm_gmtoff <> LLastOffset;

      { Generate the time zone abbreviation }
      strftime(MarshaledAString(LChars), Length(LChars), '%Z', LComp);  // DO NOT LOCALIZE
      if LIsStandard then
      begin
        { We were in the standard period }
        Result.FStartOfDST := IncSecond(FileDateToDateTime(LTime), LLastOffset - LComp.tm_gmtoff);
        Result.FBias := LLastOffset;
        Result.FDSTName := Utf8ToString(LChars);
      end else
      begin
        { We were in the DST period }
        Result.FEndOfDST := IncSecond(FileDateToDateTime(LTime), LLastOffset - LComp.tm_gmtoff);
        Result.FBiasWithDST := LLastOffset;
        Result.FName := Utf8ToString(LChars);
      end;

      { Set the last offset }
      LLastOffset := LComp.tm_gmtoff;
      LIsStandard := not LIsStandard;

      { Die if this is the second cycle }
      if LIsSecondCycle then
        Exit
      else
        LIsSecondCycle := true;
    end;
  end;
end;
{$ENDIF}

function TLocalTimeZone.GetType(const ADateTime: TDateTime; const AChanges: TYearlyChanges): TLocalTimeType;

 function After(const Point: TDateTime): Boolean;
 begin
   Result := CompareDateTime(ADateTime, Point) >= 0;
 end;

 function AfterSum(const Point: TDateTime; const Sum: Int64): Boolean;
 begin
   Result := CompareDateTime(ADateTime, IncSecond(Point, Sum)) >= 0;
 end;

 function Before(const Point: TDateTime): Boolean;
 begin
   Result := CompareDateTime(ADateTime, Point) < 0;
 end;

 function BeforeSum(const Point: TDateTime; const Sum: Int64): Boolean;
 begin
   Result := CompareDateTime(ADateTime, IncSecond(Point, Sum)) < 0;
 end;

var
  LDstSave: Int64;
begin
  { Default to normal }
  Result := lttStandard;

  { Calculate the save }
  LDstSave := (AChanges.FBiasWithDST - AChanges.FBias);

  { Check only if we have a DST bias ... }
  if LDstSave <> 0 then
  begin
    { NOTE: Apparently there are Countries that use inverse DST rules. This means that instead
      of adjusting their clocks +xxx time in the summer/winter, they adjust by -xxxx at the opposite
      season. In this particular case, LDstSave would be a negative number and thus the invalid/ambiguous
      rules change from start -> end to end -> start.
    }
    if LDstSave > 0 then
    begin
      { Invalid time between transitions (Normal Daylight) }
      if After(AChanges.FStartOfDST) and BeforeSum(AChanges.FStartOfDST, LDstSave) then
        Exit(lttInvalid);

      { Ambiguous time between transitions (Normal Daylight) }
      if Before(AChanges.FEndOfDST) and AfterSum(AChanges.FEndOfDST, -LDstSave) then
        Exit(lttAmbiguous);
    end else
    begin
      { Invalid time between transitions (Inverse Daylight) }
      if Before(AChanges.FStartOfDST) and AfterSum(AChanges.FStartOfDST, LDstSave) then
        Exit(lttInvalid);

      { Ambiguous time between transitions (Inverse Daylight) }
      if After(AChanges.FEndOfDST) and BeforeSum(AChanges.FEndOfDST, -LDstSave) then
        Exit(lttAmbiguous);
    end;

    { Northern Hemisphere OR "Winter Daylight" }
    if (CompareDateTime(AChanges.FStartOfDST, AChanges.FEndOfDST) < 0) and
       (After(AChanges.FStartOfDST) and Before(AChanges.FEndOfDST)) then
      Exit(lttDaylight);

    { Southern Hemisphere OR "Summer Daylight" }
    if (CompareDateTime(AChanges.FStartOfDST, AChanges.FEndOfDST) > 0) and
       (After(AChanges.FStartOfDST) or Before(AChanges.FEndOfDST)) then
      Exit(lttDaylight);
  end;
end;

{ TTimeZone }

function TTimeZone.ToLocalTime(const ADateTime: TDateTime): TDateTime;
var
  LOffset, LDSTSave: Int64;
  LType: TLocalTimeType;
begin
  { Adjust to local time (no DST yet). Note, ADateTime is "Universal" }
  DoGetOffsetsAndType(ADateTime, LOffset, LDSTSave, LType);
  Result := IncSecond(ADateTime, LOffset);

  { Obtain the same data again (but for the adjusted time) }
  DoGetOffsetsAndType(Result, LOffset, LDSTSave, LType);

  if LType in [lttInvalid, lttDaylight] then
    Result := IncSecond(Result, LDSTSave);

  { -- NOTE --
    Consider this DST rule: 31 october at 3 AM local time the clock shifts back one hour.
    We have two times in the same day that interval [2:00 .. 3:00) repeats.

    Normally, UTC time corresponding to 2:00 (in our imaginary TZ) is 00:00.

    If Type of Result = ttDaylight, we shift the clock +1 hour,
    if Type of Result = ttAmbiguous, we do nothing, thus the hour will
    repeat 2 time if we call ToLocalTime(00:00) and ToLocalTime(01:00).

    This is normal behaviour and you should be aware of that. }
end;

function TTimeZone.ToUniversalTime(const ADateTime: TDateTime; const ForceDaylight: Boolean): TDateTime;
var
  LOffset: Int64;
begin
  { Get the UCS offset in seconds }
  LOffset := GetUtcOffsetInSeconds(ADateTime, ForceDaylight);

  { Call the internal function }
  Result := IncSecond(ADateTime, -LOffset);
end;

class constructor TTimeZone.Create;
begin
  { Create the local time-zone too }
  FLocal := TLocalTimeZone.Create;
end;

class destructor TTimeZone.Destroy;
begin
  { Free the cache and local TZ }
  FLocal.Free;
end;

function TTimeZone.GetAbbreviationForNow: string;
begin
  { Call the actual method }
  Result := GetAbbreviation(Now);
end;

function TTimeZone.GetLocalTimeType(const ADateTime: TDateTime): TLocalTimeType;
var
  LOffset, LDSTSave: Int64;  // Dummy
begin
  { Obtain the offsets and type }
  DoGetOffsetsAndType(ADateTime, LOffset, LDSTSave, Result);
end;

function TTimeZone.GetDisplayNameForNow: string;
begin
  { Call the actual method }
  Result := GetDisplayName(Now);
end;

function TTimeZone.GetDisplayName(const ADateTime: TDateTime; const ForceDaylight: Boolean): string;
begin
  { Fail on invalid local time }
  if GetLocalTimeType(ADateTime) = lttInvalid then
    raise ELocalTimeInvalid.CreateResFmt(@SLocalTimeInvalid, [DateTimeToStr(ADateTime)]);

  { Get the right stuff out }
  Result := DoGetDisplayName(ADateTime, ForceDaylight);
end;

function TTimeZone.GetAbbreviation(const ADateTime: TDateTime; const ForceDaylight: Boolean): string;
const
  CGMT = 'GMT';  // DO NOT LOCALIZE
  CPlus = '+';   // DO NOT LOCALIZE
  CMinus = '-';  // DO NOT LOCALIZE
  CAbbreviationFormat_Hours = '%s%s%.2d';         // DO NOT LOCALIZE
  CAbbreviationFormat_Minutes = '%s%s%.2d:%.2d';  // DO NOT LOCALIZE

var
  LAbsOffset, LOffset: Int64;
  LSignChar: Char;
  LHours, LMinutes: Integer;
begin
  { Obtain the UTC offset }
  LOffset := GetUtcOffsetInSeconds(ADateTime, ForceDaylight);

  { For zero offset return "GMT" }
  if LOffset = 0 then
    Result := CGMT
  else begin
    { Extract the number of distinct hours and minutes }
    LAbsOffset := Abs(LOffset);

    LHours := LAbsOffset div SecsPerHour;
    LMinutes := (LAbsOffset mod SecsPerHour) div SecsPerMin;

    { Select the proper character }
    if LOffset < 0 then
      LSignChar := CMinus
    else
      LSignChar := CPlus;

    { Use the short or the long version of the format string }
    if LMinutes > 0 then
      Result := Format(CAbbreviationFormat_Minutes, [CGMT, LSignChar, LHours, LMinutes])
    else
      Result := Format(CAbbreviationFormat_Hours, [CGMT, LSignChar, LHours]);
  end;
end;

function TTimeZone.GetUtcOffset(const ADateTime: TDateTime; const ForceDaylight: Boolean): TTimeSpan;
begin
  { Call the internal function }
  Result := TTimeSpan.FromSeconds(GetUtcOffsetInSeconds(ADateTime, ForceDaylight));
end;

function TTimeZone.GetUtcOffsetInSeconds(const ADateTime: TDateTime; const ForceDaylight: Boolean): Int64;
var
  LOffset, LDSTSave: Int64;
  LType: TLocalTimeType;
begin
  { Obtain the information we require }
  DoGetOffsetsAndType(ADateTime, LOffset, LDSTSave, LType);

  { Select the proper offset }
  if (LType = lttInvalid) then
    raise ELocalTimeInvalid.CreateResFmt(@SLocalTimeInvalid, [DateTimeToStr(ADateTime)])
  else if (LType = lttDaylight) or ((LType = lttAmbiguous) and ForceDaylight) then
    Result := LOffset + LDSTSave
  else
    Result := LOffset;
end;

function TTimeZone.IsAmbiguousTime(const ADateTime: TDateTime): Boolean;
begin
  { Forward the call }
  Result := GetLocalTimeType(ADateTime) = lttAmbiguous;
end;

function TTimeZone.IsDaylightTime(const ADateTime: TDateTime; const ForceDaylight: Boolean): Boolean;
begin
  { Treat each case separately }
  case GetLocalTimeType(ADateTime) of
    lttDaylight:
      Result := true; { Is daylight time }

    lttAmbiguous:
      Result := ForceDaylight; { Is daylight time if we're treating ambiguous as such }

    else
      Result := false; { Not daylight }
  end;
end;

function TTimeZone.IsInvalidTime(const ADateTime: TDateTime): Boolean;
begin
  { Forward the call }
  Result := GetLocalTimeType(ADateTime) = lttInvalid;
end;

function TTimeZone.IsStandardTime(const ADateTime: TDateTime; const ForceDaylight: Boolean): Boolean;
begin
  { Treat each case separately }
  case GetLocalTimeType(ADateTime) of
    lttStandard:
      Result := true; { Is standard time }

    lttAmbiguous:
      Result := not ForceDaylight; { Is standard time if we're treating ambiguous as such }

    else
      Result := false; { Not standard }
  end;
end;

function TTimeZone.GetCurrentUtcOffset: TTimeSpan;
begin
  { Get the offset of now }
  Result := GetUtcOffset(Now);
end;

type
  DTErrorCode = (InvDate, InvTime, InvOffset);

procedure DTFmtError(AErrorCode: DTErrorCode; const AValue: string);
const
  Errors: array[DTErrorCode] of string = (SInvalidDateString, SInvalidTimeString, SInvalidOffsetString);
begin
  raise EDateTimeException.CreateFmt(Errors[AErrorCode], [AValue]);
end;

function GetNextDTComp(var P: PChar; const PEnd: PChar;  ErrorCode: DTErrorCode;
  const AValue: string; NumDigits: Integer): string; overload;
var
  LDigits: Integer;
begin
  LDigits := 0;
  Result := '';
  while ((P <= PEnd) and P^.IsDigit and (LDigits < NumDigits)) do
  begin
    Result := Result + P^;
    Inc(P);
    Inc(LDigits);
  end;
  if Result = '' then
    DTFmtError(ErrorCode, AValue);
end;

function GetNextDTComp(var P: PChar; const PEnd: PChar; const DefValue: string; Prefix: Char;
  IsOptional: Boolean; IsDate: Boolean; ErrorCode: DTErrorCode; const AValue: string; NumDigits: Integer): string; overload;
const
  SEmptySeparator: Char = ' ';
var
  LDigits: Integer;
begin
  if (P >= PEnd) then
  begin
    Result := DefValue;
    Exit;
  end;

  Result := '';

  if (Prefix <> SEmptySeparator) and (IsDate or not (Byte(P^) in [Ord('+'), Ord('-')])) then
  begin
    if P^ <> Prefix then
      DTFmtError(ErrorCode, AValue);
    Inc(P);
  end;

  LDigits := 0;
  while ((P <= PEnd) and P^.IsDigit and (LDigits < NumDigits)) do
  begin
    Result := Result + P^;
    Inc(P);
    Inc(LDigits);
  end;

  if Result = '' then
  begin
    if IsOptional then
      Result := DefValue
    else
      DTFmtError(ErrorCode, AValue);
  end;
end;


function DateToISO8601(const ADate: TDateTime; AInputIsUTC: Boolean = true): string;
const
  SDateFormat: string = 'yyyy''-''mm''-''dd''T''hh'':''nn'':''ss''.''zzz''Z'''; { Do not localize }
  SOffsetFormat: string = '%s%s%.02d:%.02d'; { Do not localize }
  Neg: array[Boolean] of string = ('+', '-'); { Do not localize }
var
  Bias: Integer;
  TimeZone: TTimeZone;
begin
  Result := FormatDateTime(SDateFormat, ADate);
  if not AInputIsUTC then
  begin
    TimeZone := TTimeZone.Local;
    Bias := Trunc(TimeZone.GetUTCOffset(ADate).Negate.TotalMinutes);
    if Bias <> 0 then
    begin
      // Remove the Z, in order to add the UTC_Offset to the string.
      SetLength(Result, Result.Length - 1);
      Result := Format(SOffsetFormat, [Result, Neg[Bias > 0], Abs(Bias) div MinsPerHour,
        Abs(Bias) mod MinsPerHour]);
    end
  end;
end;

procedure DecodeISO8601Date(const DateString: string; var AYear, AMonth, ADay: Word);

  procedure ConvertDate(const AValue: string);
  const
    SDateSeparator: Char = '-';
    SEmptySeparator: Char = ' ';
  var
    P, PE: PChar;
  begin
    P := PChar(AValue);
    PE := P + (AValue.Length - 1);
    if AValue.IndexOf(SDateSeparator) < 0 then
    begin
      AYear := StrToInt(GetNextDTComp(P, PE, InvDate, AValue, 4));
      AMonth := StrToInt(GetNextDTComp(P, PE, '00', SEmptySeparator, True, True, InvDate, AValue, 2));
      ADay := StrToInt(GetNextDTComp(P, PE, '00', SEmptySeparator, True, True, InvDate, AValue, 2));
    end
    else
    begin
      AYear := StrToInt(GetNextDTComp(P, PE, InvDate, AValue, 4));
      AMonth := StrToInt(GetNextDTComp(P, PE, '00', SDateSeparator, True, True, InvDate, AValue, 2));
      ADay := StrToInt(GetNextDTComp(P, PE, '00', SDateSeparator, True, True, InvDate, AValue, 2));
    end;
  end;

var
  TempValue: string;
  LNegativeDate: Boolean;
begin
  AYear := 0;
  AMonth := 0;
  ADay := 1;

  LNegativeDate := (DateString[Low(string)] = '-');
  if LNegativeDate then
    TempValue := DateString.Substring(1)
  else
    TempValue := DateString;
  if Length(TempValue) < 4 then
    raise EDateTimeException.CreateFmt(SInvalidDateString, [TempValue]);
  ConvertDate(TempValue);
end;

procedure DecodeISO8601Time(const TimeString: string; var AHour, AMinute, ASecond, AMillisecond: Word;
  var AHourOffset, AMinuteOffset: Integer);
const
  SEmptySeparator: Char = ' ';
  STimeSeparator: Char = ':';
  SMilSecSeparator: Char = '.';
var
  LFractionalSecondString: string;
  P, PE: PChar;
  LOffsetSign: Char;
  LFraction: Double;
begin
  AHour := 0;
  AMinute := 0;
  ASecond := 0;
  AMillisecond := 0;
  AHourOffset := 0;
  AMinuteOffset := 0;
  if TimeString <> '' then
  begin
    P := PChar(TimeString);
    PE := P + (TimeString.Length - 1);
    if TimeString.IndexOf(STimeSeparator) < 0 then
    begin
      AHour := StrToInt(GetNextDTComp(P, PE, InvTime, TimeString, 2));
      AMinute := StrToInt(GetNextDTComp(P, PE, '00', SEmptySeparator, False, False, InvTime, TimeString, 2));
      ASecond := StrToInt(GetNextDTComp(P, PE, '00', SEmptySeparator, True, False, InvTime, TimeString, 2));
      LFractionalSecondString := GetNextDTComp(P, PE, '0', SMilSecSeparator, True, False, InvTime, TimeString, 18);
      if LFractionalSecondString <> '0' then
      begin
        LFractionalSecondString := FormatSettings.DecimalSeparator + LFractionalSecondString;
        LFraction := LFractionalSecondString.ToDouble;
        AMillisecond := Round(1000 * LFraction);
      end;
    end
    else
    begin
      AHour := StrToInt(GetNextDTComp(P, PE, InvTime, TimeString, 2));
      AMinute := StrToInt(GetNextDTComp(P, PE, '00', STimeSeparator, False, False, InvTime, TimeString, 2));
      ASecond := StrToInt(GetNextDTComp(P, PE, '00', STimeSeparator, True, False, InvTime, TimeString, 2));
      LFractionalSecondString := GetNextDTComp(P, PE, '0', SMilSecSeparator, True, False, InvTime, TimeString, 18);
      if LFractionalSecondString <> '0' then
      begin
        LFractionalSecondString := FormatSettings.DecimalSeparator + LFractionalSecondString;
        LFraction := LFractionalSecondString.ToDouble;
        AMillisecond := Round(1000 * LFraction);
      end;
    end;

    if P^.IsInArray(['-', '+']) then
    begin
      LOffsetSign := P^;
      Inc(P);
      if not P^.IsDigit then
        DTFmtError(InvTime, TimeString);
      AHourOffset  := StrToInt(LOffsetSign + GetNextDTComp(P, PE, InvOffset, TimeString, 2));
      AMinuteOffset:= StrToInt(LOffsetSign + GetNextDTComp(P, PE, '00', STimeSeparator, True, True, InvOffset, TimeString, 2));
    end;
  end;
end;

function AdjustDateTime(const ADate: TDateTime; AHourOffset, AMinuteOffset:Integer; IsUTC: Boolean = True): TDateTime;
var
  AdjustDT: TDateTime;
  BiasLocal: Int64;
  BiasTime: Integer;
  BiasHour: Integer;
  BiasMins: Integer;
  BiasDT: TDateTime;
  TZ: TTimeZone;
begin
  Result := ADate;
  if IsUTC then
  begin
    { If we have an offset, adjust time to go back to UTC }
    if (AHourOffset <> 0) or (AMinuteOffset <> 0) then
    begin
      AdjustDT := EncodeTime(Abs(AHourOffset), Abs(AMinuteOffset), 0, 0);
      if ((AHourOffset * MinsPerHour) + AMinuteOffset) > 0 then
        Result := Result - AdjustDT
      else
        Result := Result + AdjustDT;
    end;
  end
  else
  begin
    { Now adjust TDateTime based on any offsets we have and the local bias }
    { There are two possibilities:
        a. The time we have has the same offset as the local bias - nothing to do!!
        b. The time we have and the local bias are different - requiring adjustments }
    TZ := TTimeZone.Local;
    BiasLocal := Trunc(TZ.GetUTCOffset(Result).Negate.TotalMinutes);
    BiasTime  := (AHourOffset * MinsPerHour) + AMinuteOffset;
    if (BiasLocal + BiasTime) = 0 then
      Exit;

    { Here we adjust the Local Bias to make it relative to the Time's own offset
      instead of being relative to GMT }
    BiasLocal := BiasLocal + BiasTime;
    BiasHour := Abs(BiasLocal) div MinsPerHour;
    BiasMins := Abs(BiasLocal) mod MinsPerHour;
    BiasDT := EncodeTime(BiasHour, BiasMins, 0, 0);
    if (BiasLocal > 0) then
      Result := Result - BiasDT
    else
      Result := Result + BiasDT;
  end;
end;

function ISO8601ToDate(const AISODate: string; AReturnUTC: Boolean = True): TDateTime;
const
  STimePrefix: Char = 'T';
var
  TimeString, DateString: string;
  TimePosition: Integer;
  Year, Month, Day, Hour, Minute, Second, Millisecond: Word;
  HourOffset, MinuteOffset: Integer;
  AddDay, AddMinute: Boolean;
begin
  HourOffset := 0;
  MinuteOffset := 0;
  TimePosition := AISODate.IndexOf(STimePrefix);
  if TimePosition >= 0 then
  begin
    DateString := AISODate.Substring(0, TimePosition);
    TimeString := AISODate.Substring(TimePosition + 1);
  end
  else
  begin
    Hour := 0;
    Minute := 0;
    Second := 0;
    Millisecond := 0;
    HourOffset := 0;
    MinuteOffset := 0;
    DateString := AISODate;
    TimeString := '';
  end;
  DecodeISO8601Date(DateString, Year, Month, Day);
  DecodeISO8601Time(TimeString, Hour, Minute, Second, Millisecond, HourOffset, MinuteOffset);

  AddDay := Hour = 24;
  if AddDay then
    Hour := 0;

  AddMinute := Second = 60;
  if AddMinute then
    Second := 0;

  Result := EncodeDateTime(Year, Month, Day, Hour, Minute, Second, Millisecond);

  if AddDay then
    Result := IncDay(Result);
  if AddMinute then
    Result := IncMinute(Result);

  Result := AdjustDateTime(Result, HourOffset, MinuteOffset, AReturnUTC);
end;

function TryISO8601ToDate(const AISODate: string; out Value: TDateTime; AReturnUTC: Boolean = True): Boolean;
begin
  Result := False;
  try
    Value := ISO8601ToDate(AISODate, AReturnUTC);
    Result := True
  except

  end;
end;

end.
