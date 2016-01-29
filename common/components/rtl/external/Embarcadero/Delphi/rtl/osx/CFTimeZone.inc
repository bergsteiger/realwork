{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFTimeZone.h                           }
{          Copyright (c) 1998-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IF NOT DEFINED(__COREFOUNDATION_CFTIMEZONE__)}

{$DEFINE __COREFOUNDATION_CFTIMEZONE__}

{$I CFBase.inc}
{$I CFArray.inc}
{$I CFData.inc}
{$I CFDate.inc}
{$I CFDictionary.inc}
{$I CFString.inc}

function CFTimeZoneGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFTimeZoneGetTypeID';
{$EXTERNALSYM CFTimeZoneGetTypeID}

function CFTimeZoneCopySystem: CFTimeZoneRef; cdecl;
  external CoreFoundationLib name _PU + 'CFTimeZoneCopySystem';
{$EXTERNALSYM CFTimeZoneCopySystem}

procedure CFTimeZoneResetSystem; cdecl;
  external CoreFoundationLib name _PU + 'CFTimeZoneResetSystem';
{$EXTERNALSYM CFTimeZoneResetSystem}

function CFTimeZoneCopyDefault: CFTimeZoneRef; cdecl;
  external CoreFoundationLib name _PU + 'CFTimeZoneCopyDefault';
{$EXTERNALSYM CFTimeZoneCopyDefault}

procedure CFTimeZoneSetDefault(tz: CFTimeZoneRef); cdecl;
  external CoreFoundationLib name _PU + 'CFTimeZoneSetDefault';
{$EXTERNALSYM CFTimeZoneSetDefault}

function CFTimeZoneCopyKnownNames: CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFTimeZoneCopyKnownNames';
{$EXTERNALSYM CFTimeZoneCopyKnownNames}

function CFTimeZoneCopyAbbreviationDictionary: CFDictionaryRef; cdecl;
  external CoreFoundationLib name _PU + 'CFTimeZoneCopyAbbreviationDictionary';
{$EXTERNALSYM CFTimeZoneCopyAbbreviationDictionary}

procedure CFTimeZoneSetAbbreviationDictionary(dict: CFDictionaryRef); cdecl;
  external CoreFoundationLib name _PU + 'CFTimeZoneSetAbbreviationDictionary';
{$EXTERNALSYM CFTimeZoneSetAbbreviationDictionary}

function CFTimeZoneCreate(allocator: CFAllocatorRef; name: CFStringRef;
  data: CFDataRef): CFTimeZoneRef; cdecl;
  external CoreFoundationLib name _PU + 'CFTimeZoneCreate';
{$EXTERNALSYM CFTimeZoneCreate}

function CFTimeZoneCreateWithTimeIntervalFromGMT(allocator: CFAllocatorRef;
  ti: CFTimeInterval): CFTimeZoneRef; cdecl;
  external CoreFoundationLib name _PU + 'CFTimeZoneCreateWithTimeIntervalFromGMT';
{$EXTERNALSYM CFTimeZoneCreateWithTimeIntervalFromGMT}

function CFTimeZoneCreateWithName(allocator: CFAllocatorRef; name: CFStringRef;
  tryAbbrev: Boolean): CFTimeZoneRef; cdecl;
  external CoreFoundationLib name _PU + 'CFTimeZoneCreateWithName';
{$EXTERNALSYM CFTimeZoneCreateWithName}

function CFTimeZoneGetName(tz: CFTimeZoneRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFTimeZoneGetName';
{$EXTERNALSYM CFTimeZoneGetName}

function CFTimeZoneGetData(tz: CFTimeZoneRef): CFDataRef; cdecl;
  external CoreFoundationLib name _PU + 'CFTimeZoneGetData';
{$EXTERNALSYM CFTimeZoneGetData}

function CFTimeZoneGetSecondsFromGMT(tz: CFTimeZoneRef;
  at: CFAbsoluteTime): CFTimeInterval; cdecl;
  external CoreFoundationLib name _PU + 'CFTimeZoneGetSecondsFromGMT';
{$EXTERNALSYM CFTimeZoneGetSecondsFromGMT}

function CFTimeZoneCopyAbbreviation(tz: CFTimeZoneRef;
  at: CFAbsoluteTime): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFTimeZoneCopyAbbreviation';
{$EXTERNALSYM CFTimeZoneCopyAbbreviation}

function CFTimeZoneIsDaylightSavingTime(tz: CFTimeZoneRef;
  at: CFAbsoluteTime): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFTimeZoneIsDaylightSavingTime';
{$EXTERNALSYM CFTimeZoneIsDaylightSavingTime}

function CFTimeZoneGetDaylightSavingTimeOffset(tz: CFTimeZoneRef;
  at: CFAbsoluteTime): CFTimeInterval; cdecl;
  external CoreFoundationLib name _PU + 'CFTimeZoneGetDaylightSavingTimeOffset';
{$EXTERNALSYM CFTimeZoneGetDaylightSavingTimeOffset}

function CFTimeZoneGetNextDaylightSavingTimeTransition(tz: CFTimeZoneRef;
  at: CFAbsoluteTime): CFAbsoluteTime; cdecl;
  external CoreFoundationLib name _PU + 'CFTimeZoneGetNextDaylightSavingTimeTransition';
{$EXTERNALSYM CFTimeZoneGetNextDaylightSavingTimeTransition}

const
  kCFTimeZoneNameStyleStandard            = 0;
  {$EXTERNALSYM kCFTimeZoneNameStyleStandard}
  kCFTimeZoneNameStyleShortStandard       = 1;
  {$EXTERNALSYM kCFTimeZoneNameStyleShortStandard}
  kCFTimeZoneNameStyleDaylightSaving      = 2;
  {$EXTERNALSYM kCFTimeZoneNameStyleDaylightSaving}
  kCFTimeZoneNameStyleShortDaylightSaving = 3;
  {$EXTERNALSYM kCFTimeZoneNameStyleShortDaylightSaving}
  kCFTimeZoneNameStyleGeneric             = 4;
  {$EXTERNALSYM kCFTimeZoneNameStyleGeneric}
  kCFTimeZoneNameStyleShortGeneric        = 5;
  {$EXTERNALSYM kCFTimeZoneNameStyleShortGeneric}
type
  CFTimeZoneNameStyle = CFIndex;
  {$EXTERNALSYM CFTimeZoneNameStyle}

function CFTimeZoneCopyLocalizedName(tz: CFTimeZoneRef;
  style: CFTimeZoneNameStyle; locale: CFLocaleRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFTimeZoneCopyLocalizedName';
{$EXTERNALSYM CFTimeZoneCopyLocalizedName}

function kCFTimeZoneSystemTimeZoneDidChangeNotification: CFStringRef;
{$EXTERNALSYM kCFTimeZoneSystemTimeZoneDidChangeNotification}

{$ENDIF !__COREFOUNDATION_CFTIMEZONE__}

