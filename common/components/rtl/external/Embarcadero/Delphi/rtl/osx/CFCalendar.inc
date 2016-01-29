{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFCalendar.h                           }
{          Copyright (c) 2004-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IFNDEF __COREFOUNDATION_CFCALENDAR__}

{$DEFINE __COREFOUNDATION_CFCALENDAR__}

{$I CFBase.inc}
{$I CFDate.inc}
{$I CFLocale.inc}
{$I CFTimeZone.inc}

type
  PCFCalendarRef = ^CFCalendarRef;
  CFCalendarRef = ^__CCalendar;
  {$EXTERNALSYM CFCalendarRef}
  __CCalendar = record
  end;
  {$EXTERNALSYM __CCalendar}

function CFCalendarGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFCalendarGetTypeID';
{$EXTERNALSYM CFCalendarGetTypeID}

function CFCalendarCopyCurrent: CFCalendarRef; cdecl;
  external CoreFoundationLib name _PU + 'CFCalendarCopyCurrent';
{$EXTERNALSYM CFCalendarCopyCurrent}

function CFCalendarCreateWithIdentifier(allocator: CFAllocatorRef;
  identifier: CFStringRef): CFCalendarRef; cdecl;
  external CoreFoundationLib name _PU + 'CFCalendarCreateWithIdentifier';
{$EXTERNALSYM CFCalendarCreateWithIdentifier}
 // Create a calendar.  The identifiers are the kCF*Calendar
 // constants in CFLocale.h.

function CFCalendarGetIdentifier(calendar: CFCalendarRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFCalendarGetIdentifier';
{$EXTERNALSYM CFCalendarGetIdentifier}
 // Returns the calendar's identifier.

function CFCalendarCopyLocale(calendar: CFCalendarRef): CFLocaleRef; cdecl;
  external CoreFoundationLib name _PU + 'CFCalendarCopyLocale';
{$EXTERNALSYM CFCalendarCopyLocale}

procedure CFCalendarSetLocale(calendar: CFCalendarRef;
  locale: CFLocaleRef); cdecl;
  external CoreFoundationLib name _PU + 'CFCalendarSetLocale';
{$EXTERNALSYM CFCalendarSetLocale}

function CFCalendarCopyTimeZone(calendar: CFCalendarRef): CFTimeZoneRef; cdecl;
  external CoreFoundationLib name _PU + 'CFCalendarCopyTimeZone';
{$EXTERNALSYM CFCalendarCopyTimeZone}

procedure CFCalendarSetTimeZone(calendar: CFCalendarRef;
  tz: CFTimeZoneRef); cdecl;
  external CoreFoundationLib name _PU + 'CFCalendarSetTimeZone';
{$EXTERNALSYM CFCalendarSetTimeZone}

function CFCalendarGetFirstWeekday(calendar: CFCalendarRef): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFCalendarGetFirstWeekday';
{$EXTERNALSYM CFCalendarGetFirstWeekday}

procedure CFCalendarSetFirstWeekday(calendar: CFCalendarRef;
  wkdy: CFIndex); cdecl;
  external CoreFoundationLib name _PU + 'CFCalendarSetFirstWeekday';
{$EXTERNALSYM CFCalendarSetFirstWeekday}

function CFCalendarGetMinimumDaysInFirstWeek(
  calendar: CFCalendarRef): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFCalendarGetMinimumDaysInFirstWeek';
{$EXTERNALSYM CFCalendarGetMinimumDaysInFirstWeek}

procedure CFCalendarSetMinimumDaysInFirstWeek(calendar: CFCalendarRef;
  mwd: CFIndex); cdecl;
  external CoreFoundationLib name _PU + 'CFCalendarSetMinimumDaysInFirstWeek';
{$EXTERNALSYM CFCalendarSetMinimumDaysInFirstWeek}


const
  kCFCalendarUnitEra            = 1 shl 1;
  {$EXTERNALSYM kCFCalendarUnitEra}
  kCFCalendarUnitYear           = 1 shl 2;
  {$EXTERNALSYM kCFCalendarUnitYear}
  kCFCalendarUnitMonth          = 1 shl 3;
  {$EXTERNALSYM kCFCalendarUnitMonth}
  kCFCalendarUnitDay            = 1 shl 4;
  {$EXTERNALSYM kCFCalendarUnitDay}
  kCFCalendarUnitHour           = 1 shl 5;
  {$EXTERNALSYM kCFCalendarUnitHour}
  kCFCalendarUnitMinute         = 1 shl 6;
  {$EXTERNALSYM kCFCalendarUnitMinute}
  kCFCalendarUnitSecond         = 1 shl 7;
  {$EXTERNALSYM kCFCalendarUnitSecond}
  kCFCalendarUnitWeek           = 1 shl 8;
  {$EXTERNALSYM kCFCalendarUnitWeek}
  kCFCalendarUnitWeekday        = 1 shl 9;
  {$EXTERNALSYM kCFCalendarUnitWeekday}
  kCFCalendarUnitWeekdayOrdinal = 1 shl 10;
  {$EXTERNALSYM kCFCalendarUnitWeekdayOrdinal}
  kCFCalendarUnitQuarter        = 1 shl 11;
  {$EXTERNALSYM kCFCalendarUnitQuarter}
type
  CFCalendarUnit = CFOptionFlags;
  {$EXTERNALSYM CFCalendarUnit}

function CFCalendarGetMinimumRangeOfUnit(calendar: CFCalendarRef;
  &unit: CFCalendarUnit): CFRange; cdecl;
  external CoreFoundationLib name _PU + 'CFCalendarGetMinimumRangeOfUnit';
{$EXTERNALSYM CFCalendarGetMinimumRangeOfUnit}

function CFCalendarGetMaximumRangeOfUnit(calendar: CFCalendarRef;
  &unit: CFCalendarUnit): CFRange; cdecl;
  external CoreFoundationLib name _PU + 'CFCalendarGetMaximumRangeOfUnit';
{$EXTERNALSYM CFCalendarGetMaximumRangeOfUnit}

function CFCalendarGetRangeOfUnit(calendar: CFCalendarRef;
  smallerUnit: CFCalendarUnit; biggerUnit: CFCalendarUnit;
  at: CFAbsoluteTime): CFRange; cdecl;
  external CoreFoundationLib name _PU + 'CFCalendarGetRangeOfUnit';
{$EXTERNALSYM CFCalendarGetRangeOfUnit}

function CFCalendarGetOrdinalityOfUnit(calendar: CFCalendarRef;
  smallerUnit: CFCalendarUnit; biggerUnit: CFCalendarUnit;
  at: CFAbsoluteTime): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFCalendarGetOrdinalityOfUnit';
{$EXTERNALSYM CFCalendarGetOrdinalityOfUnit}

function CFCalendarGetTimeRangeOfUnit(calendar: CFCalendarRef;
  &unit: CFCalendarUnit; at: CFAbsoluteTime; startp: PCFAbsoluteTime;
  tip: PCFTimeInterval): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFCalendarGetTimeRangeOfUnit';
{$EXTERNALSYM CFCalendarGetTimeRangeOfUnit}

function CFCalendarComposeAbsoluteTime(calendar: CFCalendarRef;
  at: PCFAbsoluteTime; componentDesc: MarshaledAString): Boolean; cdecl; varargs;
  external CoreFoundationLib name _PU + 'CFCalendarComposeAbsoluteTime';
{$EXTERNALSYM CFCalendarComposeAbsoluteTime}

function CFCalendarDecomposeAbsoluteTime(calendar: CFCalendarRef;
  at: CFAbsoluteTime; componentDesc: MarshaledAString): Boolean; cdecl; varargs;
  external CoreFoundationLib name _PU + 'CFCalendarDecomposeAbsoluteTime';
{$EXTERNALSYM CFCalendarDecomposeAbsoluteTime}


const
  kCFCalendarComponentsWrap = 1 shl 0;      // option for adding
  {$EXTERNALSYM kCFCalendarComponentsWrap}

function CFCalendarAddComponents(calendar: CFCalendarRef; at: PCFAbsoluteTime;
  options: CFOptionFlags; componentDesc: MarshaledAString): Boolean; cdecl; varargs;
  external CoreFoundationLib name _PU + 'CFCalendarAddComponents';
{$EXTERNALSYM CFCalendarAddComponents}

function CFCalendarGetComponentDifference(calendar: CFCalendarRef;
  startingAT: CFAbsoluteTime; resultAT: CFAbsoluteTime; options: CFOptionFlags;
  componentDesc: MarshaledAString): Boolean; cdecl; varargs;
  external CoreFoundationLib name _PU + 'CFCalendarGetComponentDifference';
{$EXTERNALSYM CFCalendarGetComponentDifference}


{$ENDIF !__COREFOUNDATION_CFCALENDAR__}


