{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFNumberFormatter.h                    }
{          Copyright (c) 2003-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IF NOT DEFINED(__COREFOUNDATION_CFNUMBERFORMATTER__)}

{$DEFINE __COREFOUNDATION_CFNUMBERFORMATTER__}

{$I CFBase.inc}

type
  PCFNumberFormatterRef = ^CFNumberFormatterRef;
  CFNumberFormatterRef = ^__CFNumberFormatter;
  {$EXTERNALSYM CFNumberFormatterRef}
  __CFNumberFormatter = record
  end;
  {$EXTERNALSYM __CFNumberFormatter}

// CFNumberFormatters are not thread-safe.  Do not use one from multiple threads!

function CFNumberFormatterGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFNumberFormatterGetTypeID';
{$EXTERNALSYM CFNumberFormatterGetTypeID}

const
  kCFNumberFormatterNoStyle         = 0;
  {$EXTERNALSYM kCFNumberFormatterNoStyle}
  kCFNumberFormatterDecimalStyle    = 1;
  {$EXTERNALSYM kCFNumberFormatterDecimalStyle}
  kCFNumberFormatterCurrencyStyle   = 2;
  {$EXTERNALSYM kCFNumberFormatterCurrencyStyle}
  kCFNumberFormatterPercentStyle    = 3;
  {$EXTERNALSYM kCFNumberFormatterPercentStyle}
  kCFNumberFormatterScientificStyle = 4;
  {$EXTERNALSYM kCFNumberFormatterScientificStyle}
  kCFNumberFormatterSpellOutStyle   = 5;
  {$EXTERNALSYM kCFNumberFormatterSpellOutStyle}
type
  CFNumberFormatterStyle = CFIndex;
  {$EXTERNALSYM CFNumberFormatterStyle}


function CFNumberFormatterCreate(allocator: CFAllocatorRef; locale: CFLocaleRef;
  style: CFNumberFormatterStyle): CFNumberFormatterRef; cdecl;
  external CoreFoundationLib name _PU + 'CFNumberFormatterCreate';
{$EXTERNALSYM CFNumberFormatterCreate}
 // Returns a CFNumberFormatter, localized to the given locale, which
 // will format numbers to the given style.

function CFNumberFormatterGetLocale(formatter: CFNumberFormatterRef): CFLocaleRef; cdecl;
  external CoreFoundationLib name _PU + 'CFNumberFormatterGetLocale';
{$EXTERNALSYM CFNumberFormatterGetLocale}

function CFNumberFormatterGetStyle(formatter: CFNumberFormatterRef): CFNumberFormatterStyle; cdecl;
  external CoreFoundationLib name _PU + 'CFNumberFormatterGetStyle';
{$EXTERNALSYM CFNumberFormatterGetStyle}
 // Get the properties with which the number formatter was created.

function CFNumberFormatterGetFormat(formatter: CFNumberFormatterRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFNumberFormatterGetFormat';
{$EXTERNALSYM CFNumberFormatterGetFormat}

procedure CFNumberFormatterSetFormat(formatter: CFNumberFormatterRef;
  formatString: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFNumberFormatterSetFormat';
{$EXTERNALSYM CFNumberFormatterSetFormat}
 // Set the format description string of the number formatter.  This
 // overrides the style settings.  The format of the format string
 // is as defined by the ICU library, and is similar to that found
 // in Microsoft Excel and NSNumberFormatter (and Java I believe).
 // The number formatter starts with a default format string defined
 // by the style argument with which it was created.


function CFNumberFormatterCreateStringWithNumber(allocator: CFAllocatorRef;
  formatter: CFNumberFormatterRef; number: CFNumberRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFNumberFormatterCreateStringWithNumber';
{$EXTERNALSYM CFNumberFormatterCreateStringWithNumber}

function CFNumberFormatterCreateStringWithValue(allocator: CFAllocatorRef;
  formatter: CFNumberFormatterRef; numberType: CFNumberType;
  valuePtr: Pointer): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFNumberFormatterCreateStringWithValue';
{$EXTERNALSYM CFNumberFormatterCreateStringWithValue}
 // Create a string representation of the given number or value
 // using the current state of the number formatter.


const
  kCFNumberFormatterParseIntegersOnly = 1;  { only parse integers }
  {$EXTERNALSYM kCFNumberFormatterParseIntegersOnly}
type
  CFNumberFormatterOptionFlags = CFOptionFlags;
  {$EXTERNALSYM CFNumberFormatterOptionFlags}

function CFNumberFormatterCreateNumberFromString(allocator: CFAllocatorRef;
  formatter: CFNumberFormatterRef; &string: CFStringRef; rangep: PCFRange;
  options: CFOptionFlags): CFNumberRef; cdecl;
  external CoreFoundationLib name _PU + 'CFNumberFormatterCreateNumberFromString';
{$EXTERNALSYM CFNumberFormatterCreateNumberFromString}

function CFNumberFormatterGetValueFromString(formatter: CFNumberFormatterRef;
  &string: CFStringRef; rangep: PCFRange; numberType: CFNumberType;
  valuePtr: Pointer): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFNumberFormatterGetValueFromString';
{$EXTERNALSYM CFNumberFormatterGetValueFromString}
 // Parse a string representation of a number using the current state
 // of the number formatter.  The range parameter specifies the range
 // of the string in which the parsing should occur in input, and on
 // output indicates the extent that was used; this parameter can
 // be NULL, in which case the whole string may be used.  The
 // return value indicates whether some number was computed and
 // (if valuePtr is not NULL) stored at the location specified by
 // valuePtr.  The numberType indicates the type of value pointed
 // to by valuePtr.


procedure CFNumberFormatterSetProperty(formatter: CFNumberFormatterRef;
  key: CFStringRef; value: CFTypeRef); cdecl;
  external CoreFoundationLib name _PU + 'CFNumberFormatterSetProperty';
{$EXTERNALSYM CFNumberFormatterSetProperty}

function CFNumberFormatterCopyProperty(formatter: CFNumberFormatterRef;
  key: CFStringRef): CFTypeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFNumberFormatterCopyProperty';
{$EXTERNALSYM CFNumberFormatterCopyProperty}
 // Set and get various properties of the number formatter, the set of
 // which may be expanded in the future.

function kCFNumberFormatterCurrencyCode: CFStringRef; // CFString
{$EXTERNALSYM kCFNumberFormatterCurrencyCode}
function kCFNumberFormatterDecimalSeparator: CFStringRef; // CFString
{$EXTERNALSYM kCFNumberFormatterDecimalSeparator}
function kCFNumberFormatterCurrencyDecimalSeparator: CFStringRef; // CFString
{$EXTERNALSYM kCFNumberFormatterCurrencyDecimalSeparator}
function kCFNumberFormatterAlwaysShowDecimalSeparator: CFStringRef; // CFBoolean
{$EXTERNALSYM kCFNumberFormatterAlwaysShowDecimalSeparator}
function kCFNumberFormatterGroupingSeparator: CFStringRef; // CFString
{$EXTERNALSYM kCFNumberFormatterGroupingSeparator}
function kCFNumberFormatterUseGroupingSeparator: CFStringRef; // CFBoolean
{$EXTERNALSYM kCFNumberFormatterUseGroupingSeparator}
function kCFNumberFormatterPercentSymbol: CFStringRef; // CFString
{$EXTERNALSYM kCFNumberFormatterPercentSymbol}
function kCFNumberFormatterZeroSymbol: CFStringRef; // CFString
{$EXTERNALSYM kCFNumberFormatterZeroSymbol}
function kCFNumberFormatterNaNSymbol: CFStringRef; // CFString
{$EXTERNALSYM kCFNumberFormatterNaNSymbol}
function kCFNumberFormatterInfinitySymbol: CFStringRef; // CFString
{$EXTERNALSYM kCFNumberFormatterInfinitySymbol}
function kCFNumberFormatterMinusSign: CFStringRef; // CFString
{$EXTERNALSYM kCFNumberFormatterMinusSign}
function kCFNumberFormatterPlusSign: CFStringRef; // CFString
{$EXTERNALSYM kCFNumberFormatterPlusSign}
function kCFNumberFormatterCurrencySymbol: CFStringRef; // CFString
{$EXTERNALSYM kCFNumberFormatterCurrencySymbol}
function kCFNumberFormatterExponentSymbol: CFStringRef; // CFString
{$EXTERNALSYM kCFNumberFormatterExponentSymbol}
function kCFNumberFormatterMinIntegerDigits: CFStringRef; // CFNumber
{$EXTERNALSYM kCFNumberFormatterMinIntegerDigits}
function kCFNumberFormatterMaxIntegerDigits: CFStringRef; // CFNumber
{$EXTERNALSYM kCFNumberFormatterMaxIntegerDigits}
function kCFNumberFormatterMinFractionDigits: CFStringRef; // CFNumber
{$EXTERNALSYM kCFNumberFormatterMinFractionDigits}
function kCFNumberFormatterMaxFractionDigits: CFStringRef; // CFNumber
{$EXTERNALSYM kCFNumberFormatterMaxFractionDigits}
function kCFNumberFormatterGroupingSize: CFStringRef; // CFNumber
{$EXTERNALSYM kCFNumberFormatterGroupingSize}
function kCFNumberFormatterSecondaryGroupingSize: CFStringRef; // CFNumber
{$EXTERNALSYM kCFNumberFormatterSecondaryGroupingSize}
function kCFNumberFormatterRoundingMode: CFStringRef; // CFNumber
{$EXTERNALSYM kCFNumberFormatterRoundingMode}
function kCFNumberFormatterRoundingIncrement: CFStringRef; // CFNumber
{$EXTERNALSYM kCFNumberFormatterRoundingIncrement}
function kCFNumberFormatterFormatWidth: CFStringRef; // CFNumber
{$EXTERNALSYM kCFNumberFormatterFormatWidth}
function kCFNumberFormatterPaddingPosition: CFStringRef; // CFNumber
{$EXTERNALSYM kCFNumberFormatterPaddingPosition}
function kCFNumberFormatterPaddingCharacter: CFStringRef; // CFString
{$EXTERNALSYM kCFNumberFormatterPaddingCharacter}
function kCFNumberFormatterDefaultFormat: CFStringRef; // CFString
{$EXTERNALSYM kCFNumberFormatterDefaultFormat}
function kCFNumberFormatterMultiplier: CFStringRef; // CFNumber
{$EXTERNALSYM kCFNumberFormatterMultiplier}
function kCFNumberFormatterPositivePrefix: CFStringRef; // CFString
{$EXTERNALSYM kCFNumberFormatterPositivePrefix}
function kCFNumberFormatterPositiveSuffix: CFStringRef; // CFString
{$EXTERNALSYM kCFNumberFormatterPositiveSuffix}
function kCFNumberFormatterNegativePrefix: CFStringRef; // CFString
{$EXTERNALSYM kCFNumberFormatterNegativePrefix}
function kCFNumberFormatterNegativeSuffix: CFStringRef; // CFString
{$EXTERNALSYM kCFNumberFormatterNegativeSuffix}
function kCFNumberFormatterPerMillSymbol: CFStringRef; // CFString
{$EXTERNALSYM kCFNumberFormatterPerMillSymbol}
function kCFNumberFormatterInternationalCurrencySymbol: CFStringRef; // CFString
{$EXTERNALSYM kCFNumberFormatterInternationalCurrencySymbol}
function kCFNumberFormatterCurrencyGroupingSeparator: CFStringRef; // CFString
{$EXTERNALSYM kCFNumberFormatterCurrencyGroupingSeparator}
function kCFNumberFormatterIsLenient: CFStringRef; // CFBoolean
{$EXTERNALSYM kCFNumberFormatterIsLenient}
function kCFNumberFormatterUseSignificantDigits: CFStringRef; // CFBoolean
{$EXTERNALSYM kCFNumberFormatterUseSignificantDigits}
function kCFNumberFormatterMinSignificantDigits: CFStringRef; // CFNumber
{$EXTERNALSYM kCFNumberFormatterMinSignificantDigits}
function kCFNumberFormatterMaxSignificantDigits: CFStringRef; // CFNumber
{$EXTERNALSYM kCFNumberFormatterMaxSignificantDigits}

const
  kCFNumberFormatterRoundCeiling  = 0;
  {$EXTERNALSYM kCFNumberFormatterRoundCeiling}
  kCFNumberFormatterRoundFloor    = 1;
  {$EXTERNALSYM kCFNumberFormatterRoundFloor}
  kCFNumberFormatterRoundDown     = 2;
  {$EXTERNALSYM kCFNumberFormatterRoundDown}
  kCFNumberFormatterRoundUp       = 3;
  {$EXTERNALSYM kCFNumberFormatterRoundUp}
  kCFNumberFormatterRoundHalfEven = 4;
  {$EXTERNALSYM kCFNumberFormatterRoundHalfEven}
  kCFNumberFormatterRoundHalfDown = 5;
  {$EXTERNALSYM kCFNumberFormatterRoundHalfDown}
  kCFNumberFormatterRoundHalfUp   = 6;
  {$EXTERNALSYM kCFNumberFormatterRoundHalfUp}
type
  CFNumberFormatterRoundingMode = CFIndex;
  {$EXTERNALSYM CFNumberFormatterRoundingMode}

const
  kCFNumberFormatterPadBeforePrefix = 0;
  {$EXTERNALSYM kCFNumberFormatterPadBeforePrefix}
  kCFNumberFormatterPadAfterPrefix  = 1;
  {$EXTERNALSYM kCFNumberFormatterPadAfterPrefix}
  kCFNumberFormatterPadBeforeSuffix = 2;
  {$EXTERNALSYM kCFNumberFormatterPadBeforeSuffix}
  kCFNumberFormatterPadAfterSuffix  = 3;
  {$EXTERNALSYM kCFNumberFormatterPadAfterSuffix}
type
  CFNumberFormatterPadPosition = CFIndex;
  {$EXTERNALSYM CFNumberFormatterPadPosition}


function CFNumberFormatterGetDecimalInfoForCurrencyCode(
  currencyCode: CFStringRef; defaultFractionDigits: PInteger;
  roundingIncrement: PDouble): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFNumberFormatterGetDecimalInfoForCurrencyCode';
{$EXTERNALSYM CFNumberFormatterGetDecimalInfoForCurrencyCode}
 // Returns the number of fraction digits that should be displayed, and
 // the rounding increment (or 0.0 if no rounding is done by the currency)
 // for the given currency.  Returns false if the currency code is unknown
 // or the information is not available.
 // Not localized because these are properties of the currency.

{$ENDIF !__COREFOUNDATION_CFNUMBERFORMATTER__}

