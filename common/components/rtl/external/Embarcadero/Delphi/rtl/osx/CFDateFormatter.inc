{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFDateFormatter.h                      }
{          Copyright (c) 2003-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IF NOT DEFINED(__COREFOUNDATION_CFDATEFORMATTER__)}

{$DEFINE __COREFOUNDATION_CFDATEFORMATTER__}

{$I CFBase.inc}
{$I CFDate.inc}
{$I CFLocale.inc}

type
  PCFDateFormatterRef = ^CFDateFormatterRef;
  CFDateFormatterRef = ^__CFDateFormatter;
  {$EXTERNALSYM CFDateFormatterRef}
  __CFDateFormatter = record
  end;
  {$EXTERNALSYM __CFDateFormatter}

// CFDateFormatters are not thread-safe.  Do not use one from multiple threads!

function CFDateFormatterCreateDateFormatFromTemplate(allocator: CFAllocatorRef;
  tmplate: CFStringRef; options: CFOptionFlags; locale: CFLocaleRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFDateFormatterCreateDateFormatFromTemplate'
{$EXTERNALSYM CFDateFormatterCreateDateFormatFromTemplate}
 // no options defined, pass 0 for now

function CFDateFormatterGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFDateFormatterGetTypeID';
{$EXTERNALSYM CFDateFormatterGetTypeID}

const
  kCFDateFormatterNoStyle     = 0;
  {$EXTERNALSYM kCFDateFormatterNoStyle}
  kCFDateFormatterShortStyle  = 1;
  {$EXTERNALSYM kCFDateFormatterShortStyle}
  kCFDateFormatterMediumStyle = 2;
  {$EXTERNALSYM kCFDateFormatterMediumStyle}
  kCFDateFormatterLongStyle   = 3;
  {$EXTERNALSYM kCFDateFormatterLongStyle}
  kCFDateFormatterFullStyle   = 4;
  {$EXTERNALSYM kCFDateFormatterFullStyle}
type
  CFDateFormatterStyle = CFIndex; 
  {$EXTERNALSYM CFDateFormatterStyle}

// The exact formatted result for these date and time styles depends on the
// locale, but generally:
//     Short is completely numeric, such as "12/13/52" or "3:30pm"
//     Medium is longer, such as "Jan 12, 1952"
//     Long is longer, such as "January 12, 1952" or "3:30:32pm"
//     Full is pretty complete; e.g. "Tuesday, April 12, 1952 AD" or "3:30:42pm PST"
// The specifications though are left fuzzy, in part simply because a user's
// preference choices may affect the output, and also the results may change
// from one OS release to another.  To produce an exactly formatted date you
// should not rely on styles and localization, but set the format string and
// use nothing but numbers.

function CFDateFormatterCreate(allocator: CFAllocatorRef; locale: CFLocaleRef;
  dateStyle: CFDateFormatterStyle; timeStyle: CFDateFormatterStyle): CFDateFormatterRef; cdecl;
  external CoreFoundationLib name _PU + 'CFDateFormatterCreate';
{$EXTERNALSYM CFDateFormatterCreate}
 // Returns a CFDateFormatter, localized to the given locale, which
 // will format dates to the given date and time styles.

function CFDateFormatterGetLocale(formatter: CFDateFormatterRef): CFLocaleRef; cdecl;
  external CoreFoundationLib name _PU + 'CFDateFormatterGetLocale';
{$EXTERNALSYM CFDateFormatterGetLocale}

function CFDateFormatterGetDateStyle(formatter: CFDateFormatterRef): CFDateFormatterStyle; cdecl;
  external CoreFoundationLib name _PU + 'CFDateFormatterGetDateStyle';
{$EXTERNALSYM CFDateFormatterGetDateStyle}

function CFDateFormatterGetTimeStyle(formatter: CFDateFormatterRef): CFDateFormatterStyle; cdecl;
  external CoreFoundationLib name _PU + 'CFDateFormatterGetTimeStyle';
{$EXTERNALSYM CFDateFormatterGetTimeStyle}
 // Get the properties with which the date formatter was created.

function CFDateFormatterGetFormat(formatter: CFDateFormatterRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFDateFormatterGetFormat';
{$EXTERNALSYM CFDateFormatterGetFormat}

procedure CFDateFormatterSetFormat(formatter: CFDateFormatterRef;
  formatString: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFDateFormatterSetFormat';
{$EXTERNALSYM CFDateFormatterSetFormat}
 // Set the format description string of the date formatter.  This
 // overrides the style settings.  The format of the format string
 // is as defined by the ICU library.  The date formatter starts with a
 // default format string defined by the style arguments with
 // which it was created.


function CFDateFormatterCreateStringWithDate(allocator: CFAllocatorRef;
  formatter: CFDateFormatterRef; date: CFDateRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFDateFormatterCreateStringWithDate';
{$EXTERNALSYM CFDateFormatterCreateStringWithDate}

function CFDateFormatterCreateStringWithAbsoluteTime(allocator: CFAllocatorRef;
  formatter: CFDateFormatterRef; at: CFAbsoluteTime): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFDateFormatterCreateStringWithAbsoluteTime';
{$EXTERNALSYM CFDateFormatterCreateStringWithAbsoluteTime}
 // Create a string representation of the given date or CFAbsoluteTime
 // using the current state of the date formatter.


function CFDateFormatterCreateDateFromString(allocator: CFAllocatorRef;
  formatter: CFDateFormatterRef; &string: CFStringRef; rangep: PCFRange): CFDateRef; cdecl;
  external CoreFoundationLib name _PU + 'CFDateFormatterCreateDateFromString';
{$EXTERNALSYM CFDateFormatterCreateDateFromString}

function CFDateFormatterGetAbsoluteTimeFromString(formatter: CFDateFormatterRef;
  &string: CFStringRef; rangep: PCFRange; atp: PCFAbsoluteTime): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFDateFormatterGetAbsoluteTimeFromString';
{$EXTERNALSYM CFDateFormatterGetAbsoluteTimeFromString}
 // Parse a string representation of a date using the current state
 // of the date formatter.  The range parameter specifies the range
 // of the string in which the parsing should occur in input, and on
 // output indicates the extent that was used; this parameter can
 // be NULL, in which case the whole string may be used.  The
 // return value indicates whether some date was computed and
 // (if atp is not NULL) stored at the location specified by atp.


procedure CFDateFormatterSetProperty(formatter: CFDateFormatterRef;
  key: CFStringRef; value: CFTypeRef); cdecl;
  external CoreFoundationLib name _PU + 'CFDateFormatterSetProperty';
{$EXTERNALSYM CFDateFormatterSetProperty}

function CFDateFormatterCopyProperty(formatter: CFDateFormatterRef;
  key: CFStringRef): CFTypeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFDateFormatterCopyProperty';
{$EXTERNALSYM CFDateFormatterCopyProperty}
 // Set and get various properties of the date formatter, the set of
 // which may be expanded in the future.

function kCFDateFormatterIsLenient: CFStringRef;	                       // CFBoolean
{$EXTERNALSYM kCFDateFormatterIsLenient}
function kCFDateFormatterTimeZone: CFStringRef;		                       // CFTimeZone
{$EXTERNALSYM kCFDateFormatterTimeZone}
function kCFDateFormatterCalendarName: CFStringRef;	                     // CFString
{$EXTERNALSYM kCFDateFormatterCalendarName}
function kCFDateFormatterDefaultFormat: CFStringRef;	                   // CFString
{$EXTERNALSYM kCFDateFormatterDefaultFormat}
function kCFDateFormatterTwoDigitStartDate: CFStringRef;                 // CFDate
{$EXTERNALSYM kCFDateFormatterTwoDigitStartDate}
function kCFDateFormatterDefaultDate: CFStringRef;	                     // CFDate
{$EXTERNALSYM kCFDateFormatterDefaultDate}
function kCFDateFormatterCalendar: CFStringRef;		                       // CFCalendar
{$EXTERNALSYM kCFDateFormatterCalendar}
function kCFDateFormatterEraSymbols: CFStringRef;	                       // CFArray of CFString
{$EXTERNALSYM kCFDateFormatterEraSymbols}
function kCFDateFormatterMonthSymbols: CFStringRef;	                     // CFArray of CFString
{$EXTERNALSYM kCFDateFormatterMonthSymbols}
function kCFDateFormatterShortMonthSymbols: CFStringRef;                 // CFArray of CFString
{$EXTERNALSYM kCFDateFormatterShortMonthSymbols}
function kCFDateFormatterWeekdaySymbols: CFStringRef;	                   // CFArray of CFString
{$EXTERNALSYM kCFDateFormatterWeekdaySymbols}
function kCFDateFormatterShortWeekdaySymbols: CFStringRef;               // CFArray of CFString
{$EXTERNALSYM kCFDateFormatterShortWeekdaySymbols}
function kCFDateFormatterAMSymbol: CFStringRef;		                       // CFString
{$EXTERNALSYM kCFDateFormatterAMSymbol}
function kCFDateFormatterPMSymbol: CFStringRef;		                       // CFString
{$EXTERNALSYM kCFDateFormatterPMSymbol}
function kCFDateFormatterLongEraSymbols: CFStringRef;                    // CFArray of CFString
{$EXTERNALSYM kCFDateFormatterLongEraSymbols}
function kCFDateFormatterVeryShortMonthSymbols: CFStringRef;             // CFArray of CFString
{$EXTERNALSYM kCFDateFormatterVeryShortMonthSymbols}
function kCFDateFormatterStandaloneMonthSymbols: CFStringRef;            // CFArray of CFString
{$EXTERNALSYM kCFDateFormatterStandaloneMonthSymbols}
function kCFDateFormatterShortStandaloneMonthSymbols: CFStringRef;       // CFArray of CFString
{$EXTERNALSYM kCFDateFormatterShortStandaloneMonthSymbols}
function kCFDateFormatterVeryShortStandaloneMonthSymbols: CFStringRef;   // CFArray of CFString
{$EXTERNALSYM kCFDateFormatterVeryShortStandaloneMonthSymbols}
function kCFDateFormatterVeryShortWeekdaySymbols: CFStringRef;           // CFArray of CFString
{$EXTERNALSYM kCFDateFormatterVeryShortWeekdaySymbols}
function kCFDateFormatterStandaloneWeekdaySymbols: CFStringRef;          // CFArray of CFString
{$EXTERNALSYM kCFDateFormatterStandaloneWeekdaySymbols}
function kCFDateFormatterShortStandaloneWeekdaySymbols: CFStringRef;     // CFArray of CFString
{$EXTERNALSYM kCFDateFormatterShortStandaloneWeekdaySymbols}
function kCFDateFormatterVeryShortStandaloneWeekdaySymbols: CFStringRef; // CFArray of CFString
{$EXTERNALSYM kCFDateFormatterVeryShortStandaloneWeekdaySymbols}
function kCFDateFormatterQuarterSymbols: CFStringRef; 	                 // CFArray of CFString
{$EXTERNALSYM kCFDateFormatterQuarterSymbols}
function kCFDateFormatterShortQuarterSymbols: CFStringRef;               // CFArray of CFString
{$EXTERNALSYM kCFDateFormatterShortQuarterSymbols}
function kCFDateFormatterStandaloneQuarterSymbols: CFStringRef;          // CFArray of CFString
{$EXTERNALSYM kCFDateFormatterStandaloneQuarterSymbols}
function kCFDateFormatterShortStandaloneQuarterSymbols: CFStringRef;     // CFArray of CFString
{$EXTERNALSYM kCFDateFormatterShortStandaloneQuarterSymbols}
function kCFDateFormatterGregorianStartDate: CFStringRef;                // CFDate
{$EXTERNALSYM kCFDateFormatterGregorianStartDate}
function kCFDateFormatterDoesRelativeDateFormattingKey: CFStringRef;     // CFBoolean - AVAILABLE_MAC_OS_X_VERSION_10_6_AND_LATER
{$EXTERNALSYM kCFDateFormatterDoesRelativeDateFormattingKey}

// See CFLocale.h for these calendar constants:
// 	const CFStringRef kCFGregorianCalendar;
// 	const CFStringRef kCFBuddhistCalendar;
// 	const CFStringRef kCFJapaneseCalendar;
// 	const CFStringRef kCFIslamicCalendar;
// 	const CFStringRef kCFIslamicCivilCalendar;
// 	const CFStringRef kCFHebrewCalendar;
// 	const CFStringRef kCFChineseCalendar;
// 	const CFStringRef kCFRepublicOfChinaCalendar;
// 	const CFStringRef kCFPersianCalendar;
// 	const CFStringRef kCFIndianCalendar;
// 	const CFStringRef kCFISO8601Calendar;   not yet implemented

{$ENDIF !__COREFOUNDATION_CFDATEFORMATTER__}

