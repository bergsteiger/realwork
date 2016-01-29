{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFDate.h                               }
{          Copyright (c) 1998-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IF NOT DEFINED(__COREFOUNDATION_CFDATE__)}

{$DEFINE __COREFOUNDATION_CFDATE__}

{$I CFBase.inc}

type
  PCFTimeInterval = ^CFTimeInterval;
  CFTimeInterval = Double;
  {$EXTERNALSYM CFTimeInterval}
  PCFAbsoluteTime = ^CFAbsoluteTime;
  CFAbsoluteTime = CFTimeInterval;
  {$EXTERNALSYM CFAbsoluteTime}
{ absolute time is the time interval since the reference date }
{ the reference date (epoch) is 00:00:00 1 January 2001. }

function CFAbsoluteTimeGetCurrent: CFAbsoluteTime; cdecl;
  external CoreFoundationLib name _PU + 'CFAbsoluteTimeGetCurrent';
{$EXTERNALSYM CFAbsoluteTimeGetCurrent}

function kCFAbsoluteTimeIntervalSince1970: CFTimeInterval;
{$EXTERNALSYM kCFAbsoluteTimeIntervalSince1970}
function kCFAbsoluteTimeIntervalSince1904: CFTimeInterval;
{$EXTERNALSYM kCFAbsoluteTimeIntervalSince1904}

type
  PCFDateRef = ^CFDateRef;
  CFDateRef = ^__CFDate;
  {$EXTERNALSYM CFDateRef}
  __CFDate = record
  end;
{$EXTERNALSYM __CFDate}

function CFDateGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFDateGetTypeID';
{$EXTERNALSYM CFDateGetTypeID}

function CFDateCreate(allocator: CFAllocatorRef;
  at: CFAbsoluteTime): CFDateRef; cdecl;
  external CoreFoundationLib name _PU + 'CFDateCreate';
{$EXTERNALSYM CFDateCreate}

function CFDateGetAbsoluteTime(theDate: CFDateRef): CFAbsoluteTime; cdecl;
  external CoreFoundationLib name _PU + 'CFDateGetAbsoluteTime';
{$EXTERNALSYM CFDateGetAbsoluteTime}

function CFDateGetTimeIntervalSinceDate(theDate: CFDateRef;
  otherDate: CFDateRef): CFTimeInterval; cdecl;
  external CoreFoundationLib name _PU + 'CFDateGetTimeIntervalSinceDate';
{$EXTERNALSYM CFDateGetTimeIntervalSinceDate}

function CFDateCompare(theDate: CFDateRef; otherDate: CFDateRef;
  context: Pointer): CFComparisonResult; cdecl;
  external CoreFoundationLib name _PU + 'CFDateCompare';
{$EXTERNALSYM CFDateCompare}

type
  PCFTimeZoneRef = ^CFTimeZoneRef;
  CFTimeZoneRef = ^__CFTimeZone;
  {$EXTERNALSYM CFTimeZoneRef}
  __CFTimeZone = record
  end;
  {$EXTERNALSYM __CFTimeZone}

  PCFGregorianDate = ^CFGregorianDate;
  CFGregorianDate = record
    year: SInt32;
    month: SInt8;
    day: SInt8;
    hour: SInt8;
    minute: SInt8;
    second: Double;
  end;
  {$EXTERNALSYM CFGregorianDate}

  PCFGregorianUnits = ^CFGregorianUnits;
  CFGregorianUnits = record
    years: SInt32;
    months: SInt32;
    days: SInt32;
    hours: SInt32;
    minutes: SInt32;
    seconds: Double;
  end;
  {$EXTERNALSYM CFGregorianUnits}

const
  kCFGregorianUnitsYears   = 1 shl 0;
  {$EXTERNALSYM kCFGregorianUnitsYears}
  kCFGregorianUnitsMonths   = 1 shl 1;
  {$EXTERNALSYM kCFGregorianUnitsMonths}
  kCFGregorianUnitsDays   = 1 shl 2;
  {$EXTERNALSYM kCFGregorianUnitsDays}
  kCFGregorianUnitsHours   = 1 shl 3;
  {$EXTERNALSYM kCFGregorianUnitsHours}
  kCFGregorianUnitsMinutes = 1 shl 4;
  {$EXTERNALSYM kCFGregorianUnitsMinutes}
  kCFGregorianUnitsSeconds = 1 shl 5;
  {$EXTERNALSYM kCFGregorianUnitsSeconds}
  kCFGregorianAllUnits = $00FFFFFF;
  {$EXTERNALSYM kCFGregorianAllUnits}
type
  CFGregorianUnitFlags = CFOptionFlags;
  {$EXTERNALSYM CFGregorianUnitFlags}

function CFGregorianDateIsValid(gdate: CFGregorianDate;
  unitFlags: CFOptionFlags): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFGregorianDateIsValid';
{$EXTERNALSYM CFGregorianDateIsValid}

function CFGregorianDateGetAbsoluteTime(gdate: CFGregorianDate;
  tz: CFTimeZoneRef): CFAbsoluteTime; cdecl;
  external CoreFoundationLib name _PU + 'CFGregorianDateGetAbsoluteTime';
{$EXTERNALSYM CFGregorianDateGetAbsoluteTime}

function CFAbsoluteTimeGetGregorianDate(at: CFAbsoluteTime;
  tz: CFTimeZoneRef): CFGregorianDate; cdecl;
  external CoreFoundationLib name _PU + 'CFAbsoluteTimeGetGregorianDate';
{$EXTERNALSYM CFAbsoluteTimeGetGregorianDate}

function CFAbsoluteTimeAddGregorianUnits(at: CFAbsoluteTime; tz: CFTimeZoneRef;
  units: CFGregorianUnits): CFAbsoluteTime; cdecl;
  external CoreFoundationLib name _PU + 'CFAbsoluteTimeAddGregorianUnits';
{$EXTERNALSYM CFAbsoluteTimeAddGregorianUnits}

function CFAbsoluteTimeGetDifferenceAsGregorianUnits(at1: CFAbsoluteTime;
  at2: CFAbsoluteTime; tz: CFTimeZoneRef; unitFlags: CFOptionFlags): CFGregorianUnits; cdecl;
  external CoreFoundationLib name _PU + 'CFAbsoluteTimeGetDifferenceAsGregorianUnits';
{$EXTERNALSYM CFAbsoluteTimeGetDifferenceAsGregorianUnits}

function CFAbsoluteTimeGetDayOfWeek(at: CFAbsoluteTime; tz: CFTimeZoneRef): SInt32; cdecl;
  external CoreFoundationLib name _PU + 'CFAbsoluteTimeGetDayOfWeek';
{$EXTERNALSYM CFAbsoluteTimeGetDayOfWeek}

function CFAbsoluteTimeGetDayOfYear(at: CFAbsoluteTime; tz: CFTimeZoneRef): SInt32; cdecl;
  external CoreFoundationLib name _PU + 'CFAbsoluteTimeGetDayOfYear';
{$EXTERNALSYM CFAbsoluteTimeGetDayOfYear}

function CFAbsoluteTimeGetWeekOfYear(at: CFAbsoluteTime; tz: CFTimeZoneRef): SInt32; cdecl;
  external CoreFoundationLib name _PU + 'CFAbsoluteTimeGetWeekOfYear';
{$EXTERNALSYM CFAbsoluteTimeGetWeekOfYear}

{$ENDIF !__COREFOUNDATION_CFDATE__}

