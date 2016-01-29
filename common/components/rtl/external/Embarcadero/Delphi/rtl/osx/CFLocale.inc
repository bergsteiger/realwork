{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFLocale.h                             }
{          Copyright (c) 2002-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IF NOT DEFINED(__COREFOUNDATION_CFLOCALE__)}

{$DEFINE __COREFOUNDATION_CFLOCALE__}

{$I CFBase.inc}
{$I CFArray.inc}
{$I CFDictionary.inc}

type
  PCFLocaleRef = ^CFLocaleRef;
  CFLocaleRef = ^__CFLocale;
  {$EXTERNALSYM CFLocaleRef}
  __CFLocale = record
  end;
  {$EXTERNALSYM __CFLocale}

function CFLocaleGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleGetTypeID';
{$EXTERNALSYM CFLocaleGetTypeID}

function CFLocaleGetSystem: CFLocaleRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleGetSystem';
{$EXTERNALSYM CFLocaleGetSystem}
 // Returns the "root", canonical locale.  Contains fixed "backstop" settings.

function CFLocaleCopyCurrent: CFLocaleRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleCopyCurrent';
{$EXTERNALSYM CFLocaleCopyCurrent}
 // Returns the logical "user" locale for the current user.
 // [This is Copy in the sense that you get a retain you have to release,
 // but we may return the same cached object over and over.]  Settings
 // you get from this locale do not change under you as CFPreferences
 // are changed (for safety and correctness).  Generally you would not
 // grab this and hold onto it forever, but use it to do the operations
 // you need to do at the moment, then throw it away.  (The non-changing
 // ensures that all the results of your operations are consistent.)

function CFLocaleCopyAvailableLocaleIdentifiers: CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleCopyAvailableLocaleIdentifiers';
{$EXTERNALSYM CFLocaleCopyAvailableLocaleIdentifiers}
 // Returns an array of CFStrings that represents all locales for
 // which locale data is available.

function CFLocaleCopyISOLanguageCodes: CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleCopyISOLanguageCodes';
{$EXTERNALSYM CFLocaleCopyISOLanguageCodes}
 // Returns an array of CFStrings that represents all known legal ISO
 // language codes.  Note: many of these will not have any supporting
 // locale data in Mac OS X.

function CFLocaleCopyISOCountryCodes: CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleCopyISOCountryCodes';
{$EXTERNALSYM CFLocaleCopyISOCountryCodes}
 // Returns an array of CFStrings that represents all known legal ISO
 // country codes.  Note: many of these will not have any supporting
 // locale data in Mac OS X.

function CFLocaleCopyISOCurrencyCodes: CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleCopyISOCurrencyCodes';
{$EXTERNALSYM CFLocaleCopyISOCurrencyCodes}
 // Returns an array of CFStrings that represents all known legal ISO
 // currency codes.  Note: some of these currencies may be obsolete, or
 // represent other financial instruments.

function CFLocaleCopyCommonISOCurrencyCodes: CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleCopyCommonISOCurrencyCodes';
{$EXTERNALSYM CFLocaleCopyCommonISOCurrencyCodes}
 // Returns an array of CFStrings that represents ISO currency codes for
 // currencies in common use.

function CFLocaleCopyPreferredLanguages: CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleCopyPreferredLanguages';
{$EXTERNALSYM CFLocaleCopyPreferredLanguages}
 // Returns the array of canonicalized CFString locale IDs that the user prefers.

function CFLocaleCreateCanonicalLanguageIdentifierFromString(
  allocator: CFAllocatorRef; localeIdentifier: CFStringRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleCreateCanonicalLanguageIdentifierFromString';
{$EXTERNALSYM CFLocaleCreateCanonicalLanguageIdentifierFromString}
 // Map an arbitrary language identification string (something close at
 // least) to a canonical language identifier.

function CFLocaleCreateCanonicalLocaleIdentifierFromString(
  allocator: CFAllocatorRef; localeIdentifier: CFStringRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleCreateCanonicalLocaleIdentifierFromString';
{$EXTERNALSYM CFLocaleCreateCanonicalLocaleIdentifierFromString}
 // Map an arbitrary locale identification string (something close at
 // least) to the canonical identifier.

function CFLocaleCreateCanonicalLocaleIdentifierFromScriptManagerCodes(
  allocator: CFAllocatorRef; lcode: LangCode; rcode: RegionCode): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleCreateCanonicalLocaleIdentifierFromScriptManagerCodes';
{$EXTERNALSYM CFLocaleCreateCanonicalLocaleIdentifierFromScriptManagerCodes}
 // Map a Mac OS LangCode and RegionCode to the canonical locale identifier.

function CFLocaleCreateLocaleIdentifierFromWindowsLocaleCode(
  allocator: CFAllocatorRef; lcid: LongWord): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleCreateLocaleIdentifierFromWindowsLocaleCode';
{$EXTERNALSYM CFLocaleCreateLocaleIdentifierFromWindowsLocaleCode}
 // Map a Windows LCID to the canonical locale identifier.

function CFLocaleGetWindowsLocaleCodeFromLocaleIdentifier(
  localeIdentifier: CFStringRef): LongWord; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleGetWindowsLocaleCodeFromLocaleIdentifier';
{$EXTERNALSYM CFLocaleGetWindowsLocaleCodeFromLocaleIdentifier}
 // Map a locale identifier to a Windows LCID.

const
  kCFLocaleLanguageDirectionUnknown     = 0; 
  {$EXTERNALSYM kCFLocaleLanguageDirectionUnknown}
  kCFLocaleLanguageDirectionLeftToRight = 1; 
  {$EXTERNALSYM kCFLocaleLanguageDirectionLeftToRight}
  kCFLocaleLanguageDirectionRightToLeft = 2; 
  {$EXTERNALSYM kCFLocaleLanguageDirectionRightToLeft}
  kCFLocaleLanguageDirectionTopToBottom = 3; 
  {$EXTERNALSYM kCFLocaleLanguageDirectionTopToBottom}
  kCFLocaleLanguageDirectionBottomToTop = 4; 
  {$EXTERNALSYM kCFLocaleLanguageDirectionBottomToTop}
type
  CFLocaleLanguageDirection = CFIndex; 
  {$EXTERNALSYM CFLocaleLanguageDirection}

function CFLocaleGetLanguageCharacterDirection(
  isoLangCode: CFStringRef): CFLocaleLanguageDirection; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleGetLanguageCharacterDirection';
{$EXTERNALSYM CFLocaleGetLanguageCharacterDirection}

function CFLocaleGetLanguageLineDirection(
  isoLangCode: CFStringRef): CFLocaleLanguageDirection; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleGetLanguageLineDirection';
{$EXTERNALSYM CFLocaleGetLanguageLineDirection}

function CFLocaleCreateComponentsFromLocaleIdentifier(allocator: CFAllocatorRef;
  localeID: CFStringRef): CFDictionaryRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleCreateComponentsFromLocaleIdentifier';
{$EXTERNALSYM CFLocaleCreateComponentsFromLocaleIdentifier}
 // Parses a locale ID consisting of language, script, country, variant,
 // and keyword/value pairs into a dictionary. The keys are the constant
 // CFStrings corresponding to the locale ID components, and the values
 // will correspond to constants where available.
 // Example: "en_US@calendar=japanese" yields a dictionary with three
 // entries: kCFLocaleLanguageCode=en, kCFLocaleCountryCode=US, and
 // kCFLocaleCalendarIdentifier=kCFJapaneseCalendar.

function CFLocaleCreateLocaleIdentifierFromComponents(allocator: CFAllocatorRef;
  dictionary: CFDictionaryRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleCreateLocaleIdentifierFromComponents';
{$EXTERNALSYM CFLocaleCreateLocaleIdentifierFromComponents}
 // Reverses the actions of CFLocaleCreateDictionaryFromLocaleIdentifier,
 // creating a single string from the data in the dictionary. The
 // dictionary {kCFLocaleLanguageCode=en, kCFLocaleCountryCode=US,
 // kCFLocaleCalendarIdentifier=kCFJapaneseCalendar} becomes
 // "en_US@calendar=japanese".

function CFLocaleCreate(allocator: CFAllocatorRef;
  localeIdentifier: CFStringRef): CFLocaleRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleCreate';
{$EXTERNALSYM CFLocaleCreate}
  // Returns a CFLocaleRef for the locale named by the "arbitrary" locale identifier.

function CFLocaleCreateCopy(allocator: CFAllocatorRef; locale: CFLocaleRef): CFLocaleRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleCreateCopy';
{$EXTERNALSYM CFLocaleCreateCopy}
 // Having gotten a CFLocale from somebody, code should make a copy
 // if it is going to use it for several operations
 // or hold onto it.  In the future, there may be mutable locales.

function CFLocaleGetIdentifier(locale: CFLocaleRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleGetIdentifier';
{$EXTERNALSYM CFLocaleGetIdentifier}
 // Returns the locale's identifier.  This may not be the same string
 // that the locale was created with (CFLocale may canonicalize it).

function CFLocaleGetValue(locale: CFLocaleRef; key: CFStringRef): CFTypeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleGetValue';
{$EXTERNALSYM CFLocaleGetValue}
 // Returns the value for the given key.  This is how settings and state
 // are accessed via a CFLocale.  Values might be of any CF type.

function CFLocaleCopyDisplayNameForPropertyValue(displayLocale: CFLocaleRef;
  key: CFStringRef; value: CFStringRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleCopyDisplayNameForPropertyValue';
{$EXTERNALSYM CFLocaleCopyDisplayNameForPropertyValue}
 // Returns the display name for the given value.  The key tells what
 // the value is, and is one of the usual locale property keys, though
 // not all locale property keys have values with display name values.


function kCFLocaleCurrentLocaleDidChangeNotification: CFStringRef;
{$EXTERNALSYM kCFLocaleCurrentLocaleDidChangeNotification}


// Locale Keys
function kCFLocaleIdentifier: CFStringRef;
{$EXTERNALSYM kCFLocaleIdentifier}
function kCFLocaleLanguageCode: CFStringRef;
{$EXTERNALSYM kCFLocaleLanguageCode}
function kCFLocaleCountryCode: CFStringRef;
{$EXTERNALSYM kCFLocaleCountryCode}
function kCFLocaleScriptCode: CFStringRef;
{$EXTERNALSYM kCFLocaleScriptCode}
function kCFLocaleVariantCode: CFStringRef;
{$EXTERNALSYM kCFLocaleVariantCode}

function kCFLocaleExemplarCharacterSet: CFStringRef;
{$EXTERNALSYM kCFLocaleExemplarCharacterSet}
function kCFLocaleCalendarIdentifier: CFStringRef;
{$EXTERNALSYM kCFLocaleCalendarIdentifier}
function kCFLocaleCalendar: CFStringRef;
{$EXTERNALSYM kCFLocaleCalendar}
function kCFLocaleCollationIdentifier: CFStringRef;
{$EXTERNALSYM kCFLocaleCollationIdentifier}
function kCFLocaleUsesMetricSystem: CFStringRef;
{$EXTERNALSYM kCFLocaleUsesMetricSystem}
function kCFLocaleMeasurementSystem: CFStringRef; // "Metric" or "U.S."
{$EXTERNALSYM kCFLocaleMeasurementSystem}
function kCFLocaleDecimalSeparator: CFStringRef;
{$EXTERNALSYM kCFLocaleDecimalSeparator}
function kCFLocaleGroupingSeparator: CFStringRef;
{$EXTERNALSYM kCFLocaleGroupingSeparator}
function kCFLocaleCurrencySymbol: CFStringRef;
{$EXTERNALSYM kCFLocaleCurrencySymbol}
function kCFLocaleCurrencyCode: CFStringRef;      // ISO 3-letter currency code
{$EXTERNALSYM kCFLocaleCurrencyCode}
function kCFLocaleCollatorIdentifier: CFStringRef;
{$EXTERNALSYM kCFLocaleCollatorIdentifier}
function kCFLocaleQuotationBeginDelimiterKey: CFStringRef;
{$EXTERNALSYM kCFLocaleQuotationBeginDelimiterKey}
function kCFLocaleQuotationEndDelimiterKey: CFStringRef;
{$EXTERNALSYM kCFLocaleQuotationEndDelimiterKey}
function kCFLocaleAlternateQuotationBeginDelimiterKey: CFStringRef;
{$EXTERNALSYM kCFLocaleAlternateQuotationBeginDelimiterKey}
function kCFLocaleAlternateQuotationEndDelimiterKey: CFStringRef;
{$EXTERNALSYM kCFLocaleAlternateQuotationEndDelimiterKey}

// Values for kCFLocaleCalendarIdentifier
function kCFGregorianCalendar: CFStringRef;
{$EXTERNALSYM kCFGregorianCalendar}
function kCFBuddhistCalendar: CFStringRef;
{$EXTERNALSYM kCFBuddhistCalendar}
function kCFChineseCalendar: CFStringRef;
{$EXTERNALSYM kCFChineseCalendar}
function kCFHebrewCalendar: CFStringRef;
{$EXTERNALSYM kCFHebrewCalendar}
function kCFIslamicCalendar: CFStringRef;
{$EXTERNALSYM kCFIslamicCalendar}
function kCFIslamicCivilCalendar: CFStringRef;
{$EXTERNALSYM kCFIslamicCivilCalendar}
function kCFJapaneseCalendar: CFStringRef;
{$EXTERNALSYM kCFJapaneseCalendar}
function kCFRepublicOfChinaCalendar: CFStringRef;
{$EXTERNALSYM kCFRepublicOfChinaCalendar}
function kCFPersianCalendar: CFStringRef;
{$EXTERNALSYM kCFPersianCalendar}
function kCFIndianCalendar: CFStringRef;
{$EXTERNALSYM kCFIndianCalendar}
function kCFISO8601Calendar: CFStringRef;
{$EXTERNALSYM kCFISO8601Calendar}

{$ENDIF !__COREFOUNDATION_CFLOCALE__}

