{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Character;

interface

{$HPPEMIT LEGACYHPP}
{$IFDEF ANDROID}
  {$DEFINE USE_LIBICU}
{$ENDIF}
                                                                                  
{$IFDEF LINUX64}
//  {$DEFINE USE_LIBICU}
{$ENDIF LINUX64}

{$SCOPEDENUMS ON}

uses
  System.SysUtils;

type
  TUnicodeCategory = (
    ucControl,
    ucFormat,
    ucUnassigned,
    ucPrivateUse,
    ucSurrogate,
    ucLowercaseLetter,
    ucModifierLetter,
    ucOtherLetter,
    ucTitlecaseLetter,
    ucUppercaseLetter,
    ucCombiningMark,
    ucEnclosingMark,
    ucNonSpacingMark,
    ucDecimalNumber,
    ucLetterNumber,
    ucOtherNumber,
    ucConnectPunctuation,
    ucDashPunctuation,
    ucClosePunctuation,
    ucFinalPunctuation,
    ucInitialPunctuation,
    ucOtherPunctuation,
    ucOpenPunctuation,
    ucCurrencySymbol,
    ucModifierSymbol,
    ucMathSymbol,
    ucOtherSymbol,
    ucLineSeparator,
    ucParagraphSeparator,
    ucSpaceSeparator
  );

  TUnicodeBreak = (
    ubMandatory,
    ubCarriageReturn,
    ubLineFeed,
    ubCombiningMark,
    ubSurrogate,
    ubZeroWidthSpace,
    ubInseparable,
    ubNonBreakingGlue,
    ubContingent,
    ubSpace,
    ubAfter,
    ubBefore,
    ubBeforeAndAfter,
    ubHyphen,
    ubNonStarter,
    ubOpenPunctuation,
    ubClosePunctuation,
    ubQuotation,
    ubExclamation,
    ubIdeographic,
    ubNumeric,
    ubInfixSeparator,
    ubSymbol,
    ubAlphabetic,
    ubPrefix,
    ubPostfix,
    ubComplexContext,
    ubAmbiguous,
    ubUnknown,
    ubNextLine,
    ubWordJoiner,
    ubHangulLJamo,
    ubHangulVJamo,
    ubHangulTJamo,
    ubHangulLvSyllable,
    ubHangulLvtSyllable
  );

type
  TCharacter = record
  public
    const
      MaxHighSurrogate       = #$DBFF;
      MaxLowSurrogate        = #$DFFF;
      MaxSurrogate           = #$DFFF;
      MinHighSurrogate       = #$D800;
      MinLowSurrogate        = #$DC00;
      MinSurrogate           = #$D800;

    class function MaxCodePoint: Integer; static;
    class function UnicodeDataVersion: string; static;
    class function ConvertFromUtf32(C: UCS4Char): string; static;
    class function ConvertToUtf32(const S: string; Index: Integer): UCS4Char; overload; inline; static;
    class function ConvertToUtf32(const S: string; Index: Integer; out CharLength: Integer): UCS4Char; overload; inline; static;
    class function ConvertToUtf32(const HighSurrogate, LowSurrogate: Char): UCS4Char; overload; inline; static;
    class function GetNumericValue(C: Char): Double; overload; inline; static;
    class function GetNumericValue(C: UCS4Char): Double; overload; inline; static;
    class function GetNumericValue(const S: string; Index: Integer): Double; overload; inline; static;
    class function GetUnicodeCategory(C: Char): TUnicodeCategory; overload; inline; static;
    class function GetUnicodeCategory(C: UCS4Char): TUnicodeCategory; overload; inline; static;
    class function GetUnicodeCategory(const S: string; Index: Integer): TUnicodeCategory; overload; inline; static;
    class function IsControl(C: Char): Boolean; overload; inline; static;
    class function IsControl(C: UCS4Char): Boolean; overload; inline; static;
    class function IsControl(const S: string; Index: Integer): Boolean; overload; inline; static;
    /// <summary>Determines if a character is defined in Unicode.</summary>
    class function IsDefined(C: Char): Boolean; overload; inline; static;
    class function IsDefined(C: UCS4Char): Boolean; overload; inline; static;
    class function IsDefined(const S: string; Index: Integer): Boolean; overload; inline; static;
    class function IsDigit(C: Char): Boolean; overload; inline; static;
    class function IsDigit(C: UCS4Char): Boolean; overload; inline; static;
    class function IsDigit(const S: string; Index: Integer): Boolean; overload; inline; static;
    class function IsHighSurrogate(C: Char): Boolean; overload; inline; static;
    class function IsHighSurrogate(C: UCS4Char): Boolean; overload; inline; static;
    class function IsHighSurrogate(const S: string; Index: Integer): Boolean; overload; inline; static;
    class function IsLetter(C: Char): Boolean; overload; inline; static;
    class function IsLetter(C: UCS4Char): Boolean; overload; inline; static;
    class function IsLetter(const S: string; Index: Integer): Boolean; overload; inline; static;
    class function IsLetterOrDigit(C: Char): Boolean; overload; inline; static;
    class function IsLetterOrDigit(C: UCS4Char): Boolean; overload; inline; static;
    class function IsLetterOrDigit(const S: string; Index: Integer): Boolean; overload; inline; static;
    class function IsLower(C: Char): Boolean; overload; inline; static;
    class function IsLower(C: UCS4Char): Boolean; overload; inline; static;
    class function IsLower(const S: string; Index: Integer): Boolean; overload; inline; static;
    class function IsLowSurrogate(C: Char): Boolean; overload; inline; static;
    class function IsLowSurrogate(C: UCS4Char): Boolean; overload; inline; static;
    class function IsLowSurrogate(const S: string; Index: Integer): Boolean; overload; inline; static;
    class function IsNumber(C: Char): Boolean; overload; inline; static;
    class function IsNumber(C: UCS4Char): Boolean; overload; inline; static;
    class function IsNumber(const S: string; Index: Integer): Boolean; overload; inline; static;
    class function IsPunctuation(C: Char): Boolean; overload; inline; static;
    class function IsPunctuation(C: UCS4Char): Boolean; overload; inline; static;
    class function IsPunctuation(const S: string; Index: Integer): Boolean; overload; inline; static;
    class function IsSeparator(C: Char): Boolean; overload; inline; static;
    class function IsSeparator(C: UCS4Char): Boolean; overload; inline; static;
    class function IsSeparator(const S: string; Index: Integer): Boolean; overload; inline; static;
    class function IsSurrogate(Surrogate: Char): Boolean; overload; inline; static;
    class function IsSurrogate(Surrogate: UCS4Char): Boolean; overload; inline; static;
    class function IsSurrogate(const S: string; Index: Integer): Boolean; overload; inline; static;
    class function IsSurrogatePair(const HighSurrogate, LowSurrogate: Char): Boolean; overload; inline; static;
    class function IsSurrogatePair(const S: string; Index: Integer): Boolean; overload; inline; static;
    class function IsSymbol(C: Char): Boolean; overload; inline; static;
    class function IsSymbol(C: UCS4Char): Boolean; overload; inline; static;
    class function IsSymbol(const S: string; Index: Integer): Boolean; overload; inline; static;
    class function IsUpper(C: Char): Boolean; overload; inline; static;
    class function IsUpper(C: UCS4Char): Boolean; overload; inline; static;
    class function IsUpper(const S: string; Index: Integer): Boolean; overload; inline; static;
    class function IsWhiteSpace(C: Char): Boolean; overload; inline; static;
    class function IsWhiteSpace(C: UCS4Char): Boolean; overload; inline; static;
    class function IsWhiteSpace(const S: string; Index: Integer): Boolean; overload; inline; static;
    class function ToLower(C: Char): Char; overload; inline; static;
    class function ToLower(C: UCS4Char): UCS4Char; overload; inline; static;
    class function ToLower(const S: string): string; overload; inline; static;
    class function ToUpper(C: Char): Char; overload; inline; static;
    class function ToUpper(C: UCS4Char): UCS4Char; overload; inline; static;
    class function ToUpper(const S: string): string; overload; inline; static;
  end deprecated 'Use TCharHelper';

function ConvertFromUtf32(C: UCS4Char): string; inline; deprecated 'Use TCharHelper';
function ConvertToUtf32(const S: string; Index: Integer): UCS4Char; overload; inline; deprecated 'Use TCharHelper';
function ConvertToUtf32(const S: string; Index: Integer; out CharLength: Integer): UCS4Char; overload; inline; deprecated 'Use TCharHelper';
function ConvertToUtf32(const HighSurrogate, LowSurrogate: Char): UCS4Char; overload; inline; deprecated 'Use TCharHelper';
function GetNumericValue(C: Char): Double; overload; inline; deprecated 'Use TCharHelper';
function GetNumericValue(C: UCS4Char): Double; overload; inline; deprecated 'Use TCharHelper';
function GetNumericValue(const S: string; Index: Integer): Double; overload; inline; deprecated 'Use TCharHelper';
function GetUnicodeCategory(C: Char): TUnicodeCategory; overload; inline; deprecated 'Use TCharHelper';
function GetUnicodeCategory(C: UCS4Char): TUnicodeCategory; overload; inline; deprecated 'Use TCharHelper';
function GetUnicodeCategory(const S: string; Index: Integer): TUnicodeCategory; overload; inline; deprecated 'Use TCharHelper';
function IsControl(C: Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsControl(C: UCS4Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsControl(const S: string; Index: Integer): Boolean; overload; inline; deprecated 'Use TCharHelper';
/// <summary>Determines if a character is defined in Unicode.</summary>
function IsDefined(C: Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsDefined(C: UCS4Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsDefined(const S: string; Index: Integer): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsDigit(C: Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsDigit(C: UCS4Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsDigit(const S: string; Index: Integer): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsHighSurrogate(C: Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsHighSurrogate(C: UCS4Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsHighSurrogate(const S: string; Index: Integer): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsLetter(C: Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsLetter(C: UCS4Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsLetter(const S: string; Index: Integer): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsLetterOrDigit(C: Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsLetterOrDigit(C: UCS4Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsLetterOrDigit(const S: string; Index: Integer): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsLower(C: Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsLower(C: UCS4Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsLower(const S: string; Index: Integer): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsLowSurrogate(C: Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsLowSurrogate(C: UCS4Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsLowSurrogate(const S: string; Index: Integer): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsNumber(C: Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsNumber(C: UCS4Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsNumber(const S: string; Index: Integer): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsPunctuation(C: Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsPunctuation(C: UCS4Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsPunctuation(const S: string; Index: Integer): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsSeparator(C: Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsSeparator(C: UCS4Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsSeparator(const S: string; Index: Integer): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsSurrogate(Surrogate: Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsSurrogate(Surrogate: UCS4Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsSurrogate(const S: string; Index: Integer): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsSurrogatePair(const HighSurrogate, LowSurrogate: Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsSurrogatePair(const S: string; Index: Integer): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsSymbol(C: Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsSymbol(C: UCS4Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsSymbol(const S: string; Index: Integer): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsUpper(C: Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsUpper(C: UCS4Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsUpper(const S: string; Index: Integer): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsWhiteSpace(C: Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsWhiteSpace(C: UCS4Char): Boolean; overload; inline; deprecated 'Use TCharHelper';
function IsWhiteSpace(const S: string; Index: Integer): Boolean; overload; inline; deprecated 'Use TCharHelper';
function ToLower(C: Char): Char; overload; inline; deprecated 'Use TCharHelper';
function ToLower(C: UCS4Char): UCS4Char; overload; inline; deprecated 'Use TCharHelper';
function ToLower(const S: string): string; overload; inline; deprecated 'Use TCharHelper';
function ToUpper(C: Char): Char; overload; inline; deprecated 'Use TCharHelper';
function ToUpper(C: UCS4Char): UCS4Char; overload; inline; deprecated 'Use TCharHelper';
function ToUpper(const S: string): string; overload; inline; deprecated 'Use TCharHelper';

// -------------------------------------------------------------------------- //
// -------------------------------------------------------------------------- //
// -------------------------------------------------------------------------- //
type
  TCharHelper = record helper for Char
  private
    class procedure RaiseCheckStringRangeException(Index, LowIndex, MaxIndex: Integer); static;
  public
    const
      MaxHighSurrogate       = #$DBFF;
      MaxLowSurrogate        = #$DFFF;
      MaxSurrogate           = #$DFFF;
      MinHighSurrogate       = #$D800;
      MinLowSurrogate        = #$DC00;
      MinSurrogate           = #$D800;
    class function MaxCodePoint: Integer; static;
    class function UnicodeDataVersion: string; static;

    class function ConvertFromUtf32(C: UCS4Char): string; static;
    class function ConvertToUtf32(const S: string; Index: Integer): UCS4Char; overload; inline; static;
    class function ConvertToUtf32(const S: string; Index: Integer; out CharLength: Integer): UCS4Char; overload; static;
    class function ConvertToUtf32(const HighSurrogate, LowSurrogate: Char): UCS4Char; overload; static;

    function GetNumericValue: Double; overload;
    class function GetNumericValue(const S: string; Index: Integer): Double; overload; static;

    function GetUnicodeCategory: TUnicodeCategory; overload;
    class function GetUnicodeCategory(const S: string; Index: Integer): TUnicodeCategory; overload; static;

// -------------------------------------------------------------------------- //
// isXXXX functions
// -------------------------------------------------------------------------- //
    function IsControl: Boolean; overload;
    /// <summary>Determines if a character is defined in Unicode.</summary>
    function IsDefined: Boolean; overload;
    function IsDigit: Boolean; overload;
    function IsHighSurrogate: Boolean; overload; inline;
    function IsInArray(const SomeChars: array of Char): Boolean; overload;
    function IsLetter: Boolean; overload;
    function IsLetterOrDigit: Boolean; overload;
    function IsLower: Boolean; overload;
    function IsLowSurrogate: Boolean; overload; inline;
    function IsNumber: Boolean; overload;
    function IsPunctuation: Boolean; overload;
    function IsSeparator: Boolean; overload;
    function IsSurrogate: Boolean; overload; inline;
    function IsSymbol: Boolean; overload;
    function IsUpper: Boolean; overload;
    function IsWhiteSpace: Boolean; overload;
    function ToLower: Char; overload;
    function ToUpper: Char; overload;
    function ToUCS4Char: UCS4Char; inline;

// -------------------------------------------------------------------------- //
// isXXXX class functions
// -------------------------------------------------------------------------- //
    class function IsControl(const S: string; Index: Integer): Boolean; overload; static;
    /// <summary>Determines if a character is defined in Unicode.</summary>
    class function IsDefined(const S: string; Index: Integer): Boolean; overload; static;
    class function IsDigit(const S: string; Index: Integer): Boolean; overload; static;
    class function IsHighSurrogate(const S: string; Index: Integer): Boolean; overload; inline; static;
    class function IsInArray(const S: string; Index: Integer; const SomeChars: array of char): Boolean; overload; static;
    class function IsLetter(const S: string; Index: Integer): Boolean; overload; static;
    class function IsLetterOrDigit(const S: string; Index: Integer): Boolean; overload; static;
    class function IsLower(const S: string; Index: Integer): Boolean; overload; static;
    class function IsLowSurrogate(const S: string; Index: Integer): Boolean; overload; inline; static;
    class function IsNumber(const S: string; Index: Integer): Boolean; overload; static;
    class function IsPunctuation(const S: string; Index: Integer): Boolean; overload; static;
    class function IsSeparator(const S: string; Index: Integer): Boolean; overload; static;
    class function IsSurrogate(const S: string; Index: Integer): Boolean; overload; static;
    class function IsSurrogatePair(const HighSurrogate, LowSurrogate: Char): Boolean; overload; inline; static;
    class function IsSurrogatePair(const S: string; Index: Integer): Boolean; overload; static;
    class function IsSymbol(const S: string; Index: Integer): Boolean; overload; static;
    class function IsUpper(const S: string; Index: Integer): Boolean; overload; static;
    class function IsWhiteSpace(const S: string; Index: Integer): Boolean; overload; static;
    class function ToLower(const S: string): string; overload; static;
    class function ToUpper(const S: string): string; overload; static;


// -------------------------------------------------------------------------- //
// GetXXXX and isXXXX class functions for UCS4Char
// -------------------------------------------------------------------------- //
    class function GetNumericValue(C: UCS4Char): Double; overload; static;
    class function GetUnicodeCategory(C: UCS4Char): TUnicodeCategory; overload; static;

    class function IsControl(C: UCS4Char): Boolean; overload; static;
    /// <summary>Determines if a character is defined in Unicode.</summary>
    class function IsDefined(C: UCS4Char): Boolean; overload; static;
    class function IsDigit(C: UCS4Char): Boolean; overload; static;
    class function IsHighSurrogate(C: UCS4Char): Boolean; overload; inline; static;
    class function IsLetter(C: UCS4Char): Boolean; overload; static;
    class function IsLetterOrDigit(C: UCS4Char): Boolean; overload; static;
    class function IsLower(C: UCS4Char): Boolean; overload; static;
    class function IsLowSurrogate(C: UCS4Char): Boolean; overload; inline; static;
    class function IsNumber(C: UCS4Char): Boolean; overload; static;
    class function IsPunctuation(C: UCS4Char): Boolean; overload; static;
    class function IsSeparator(C: UCS4Char): Boolean; overload; static;
    class function IsSurrogate(Surrogate: UCS4Char): Boolean; overload; inline; static;
    class function IsSymbol(C: UCS4Char): Boolean; overload; static;
    class function IsUpper(C: UCS4Char): Boolean; overload; static;
    class function IsWhiteSpace(C: UCS4Char): Boolean; overload; static;
    class function ToLower(C: UCS4Char): UCS4Char; overload; static;
    class function ToUpper(C: UCS4Char): UCS4Char; overload; static;

  end;


implementation

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  Posix.Wctype,
{$IFDEF MACOS}
  Macapi.CoreFoundation,
{$ENDIF MACOS}
{$ENDIF POSIX}
{$IFDEF USE_LIBICU}
  System.Internal.ICU,
{$ENDIF}
  System.RTLConsts;

{$IFDEF ASSEMBLER}
{$DEFINE USE_PSEUDO_FUNCTION}
{$ELSE !ASSEMBLER}
{$DEFINE USE_CONST_BLOCK}
{$ENDIF ASSEMBLER}

// Include table information.
{$INCLUDE System.Character_definition.5.2.0.inc }

{$IFDEF USE_PSEUDO_FUNCTION}
type
{$IFDEF INDEXTABLE_IS_BYTE}
  TIndexArray = array[0..32767] of Byte;
{$ELSE !INDEXTABLE_IS_BYTE}
  TIndexArray = array[0..32767] of Word;
{$ENDIF INDEXTABLE_IS_BYTE}
  PIndexArray = ^TIndexArray;
  TIndex2Array = array[0..32767] of Word;
  PIndex2Array = ^TIndex2Array;

  TCategoryArray = array[0..65535] of TUnicodeCategory;
  PCategoryArray = ^TCategoryArray;
  TNumberArray = array[0..4095] of Double;
  PNumberArray = ^TNumberArray;
  PDataTableOffsets = ^TDataTableOffsets;
  TDataTableOffsets = record
    IndexTable1Offset: Integer;
    IndexTable2Offset: Integer;
    DataTableOffset: Integer;
    NumberIndex1Offset: Integer;
    NumberIndex2Offset: Integer;
    NumberIndex3Offset: Integer;
    NumberDataOffset: Integer;
  end;

var
  DataTable: Pointer;
  CatIndexPrimary: PIndexArray;
  CatIndexSecondary: PIndex2Array;
  CategoryTable: PCategoryArray;
  NumIndexPrimary: PIndexArray;
  NumIndexSecondary: PIndex2Array;
  NumIndexTertiary: PByte;
  NumericValueTable: PNumberArray;
{$ENDIF USE_PSEUDO_FUNCTION}

{$IFDEF USE_CONST_BLOCK}
{$INCLUDE System.Character_const.5.2.0.inc }
{$ENDIF USE_CONST_BLOCK}

{$IFDEF USE_PSEUDO_FUNCTION}
{ Internal common functions for all TxxxCharHelpers}

procedure CharTableInitialize;

{$INCLUDE System.Character.5.2.0.inc}

var
  Offsets: PDataTableOffsets;
begin
  DataTable := bin_data;
  Offsets := DataTable;
  CatIndexPrimary := Pointer(PByte(DataTable) + Offsets.IndexTable1Offset);
  CatIndexSecondary := Pointer(PByte(DataTable) + Offsets.IndexTable2Offset);
  CategoryTable := Pointer(PByte(DataTable) + Offsets.DataTableOffset);
  NumIndexPrimary := Pointer(PByte(DataTable) + Offsets.NumberIndex1Offset);
  NumIndexSecondary := Pointer(PByte(DataTable) + Offsets.NumberIndex2Offset);
  NumIndexTertiary := Pointer(PByte(DataTable) + Offsets.NumberIndex3Offset);
  NumericValueTable := Pointer(PByte(DataTable) + Offsets.NumberDataOffset);
end;
{$ENDIF USE_PSEUDO_FUNCTION}

function IsLatin1(C: UCS4Char): Boolean; Inline;
begin
  Result := C <= $FF;
end;

function IsAscii(C: UCS4Char): Boolean; Inline;
begin
  Result := C <= $7F;
end;

function CheckLetter(uc: TUnicodeCategory): Boolean; inline;
begin
  Result := uc in [TUnicodeCategory.ucUppercaseLetter, TUnicodeCategory.ucLowercaseLetter,
    TUnicodeCategory.ucTitlecaseLetter, TUnicodeCategory.ucModifierLetter,
    TUnicodeCategory.ucOtherLetter];
end;

function CheckLetterOrDigit(uc: TUnicodeCategory): Boolean; inline;
begin
  Result := uc in [TUnicodeCategory.ucUppercaseLetter, TUnicodeCategory.ucLowercaseLetter,
    TUnicodeCategory.ucTitlecaseLetter, TUnicodeCategory.ucModifierLetter,
    TUnicodeCategory.ucOtherLetter, TUnicodeCategory.ucDecimalNumber];
end;

function CheckNumber(uc: TUnicodeCategory): Boolean; inline;
begin
  Result := uc in [TUnicodeCategory.ucOtherNumber, TUnicodeCategory.ucLetterNumber,
    TUnicodeCategory.ucDecimalNumber];
end;

function CheckPunctuation(uc: TUnicodeCategory): Boolean; inline;
begin
  Result := uc in [TUnicodeCategory.ucConnectPunctuation, TUnicodeCategory.ucDashPunctuation,
    TUnicodeCategory.ucClosePunctuation, TUnicodeCategory.ucFinalPunctuation,
    TUnicodeCategory.ucInitialPunctuation, TUnicodeCategory.ucOtherPunctuation,
    TUnicodeCategory.ucOpenPunctuation];
end;

function CheckSeparator(uc: TUnicodeCategory): Boolean; inline;
begin
  Result := uc in [TUnicodeCategory.ucLineSeparator, TUnicodeCategory.ucParagraphSeparator,
    TUnicodeCategory.ucSpaceSeparator];
end;

function CheckSymbol(uc: TUnicodeCategory): Boolean; inline;
begin
  Result := uc in [TUnicodeCategory.ucCurrencySymbol, TUnicodeCategory.ucModifierSymbol,
    TUnicodeCategory.ucMathSymbol, TUnicodeCategory.ucOtherSymbol];
end;

function InternalGetLatin1Category(C: UCS4Char): TUnicodeCategory; inline;
begin
  Result := CategoryTable[C] // first 256 entry is Latin1 area
end;

function InternalGetUnicodeCategory(C: UCS4Char): TUnicodeCategory;
begin
  if C > UnicodeLastChar then
    Result := TUnicodeCategory.ucUnassigned
  else
{$IFDEF INDEXTABLE_IS_BYTE}
    Result := CategoryTable[CatIndexSecondary[CatIndexPrimary[C shr 8]*16 + ((C shr 4) and $F)] + C and $F];
{$ELSE !INDEXTABLE_IS_BYTE}
    Result := CategoryTable[CatIndexSecondary[CatIndexPrimary[C shr 8] +    ((C shr 4) and $F)] + C and $F];
{$ENDIF INDEXTABLE_IS_BYTE}
end;

function InternalNumberValue(C: UCS4Char): Double;
type
  PDouble = ^Double;
begin
  if C > UnicodeLastChar then
    Result := -1.0
  else
{$IFDEF INDEXTABLE_IS_BYTE}
    Result := PDouble(@ NumericValueTable[NumIndexTertiary[NumIndexSecondary[NumIndexPrimary[C shr 8]*16 + ((C shr 4) and $F)] + C and $F ]])^;
{$ELSE !INDEXTABLE_IS_BYTE}
    Result := PDouble(@ NumericValueTable[NumIndexTertiary[NumIndexSecondary[NumIndexPrimary[C shr 8]    + ((C shr 4) and $F)] + C and $F ]])^;
{$ENDIF INDEXTABLE_IS_BYTE}
end;

procedure CheckStringRange(const S: string; Index: Integer); inline;
var
  MaxIndex: Integer;
begin
  MaxIndex := Length(S);
  if ((Index > MaxIndex) or (Index < 1)) then
    Char.RaiseCheckStringRangeException(Index, 1, MaxIndex);
end;

{ Internal functions }

{ TCharacter }


class function TCharacter.MaxCodePoint: Integer;
begin
  Result := Char.MaxCodePoint;
end;

class function TCharacter.UnicodeDataVersion: string;
begin
  Result := Char.UnicodeDataVersion;
end;

class function TCharacter.IsLetter(C: Char): Boolean;
begin
  Result := C.IsLetter;
end;

class function TCharacter.IsLetter(C: UCS4Char): Boolean;
begin
  Result := Char.IsLetter(C);
end;

class function TCharacter.IsLetter(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsLetter(S, Index-1);
end;

class function TCharacter.IsLetterOrDigit(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsLetterOrDigit(S, Index-1);
end;

class function TCharacter.IsLetterOrDigit(C: Char): Boolean;
begin
  Result := C.IsLetterOrDigit;
end;

class function TCharacter.IsLetterOrDigit(C: UCS4Char): Boolean;
begin
  Result := Char.IsLetterOrDigit(C);
end;

class function TCharacter.IsControl(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsControl(S, Index-1);
end;

class function TCharacter.IsControl(C: Char): Boolean;
begin
  Result := C.IsControl;
end;

class function TCharacter.IsControl(C: UCS4Char): Boolean;
begin
  Result := Char.IsControl(C);
end;

class function TCharacter.IsDefined(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsDefined(S, Index-1);
end;

class function TCharacter.IsDefined(C: Char): Boolean;
begin
  Result := C.IsDefined;
end;

class function TCharacter.IsDefined(C: UCS4Char): Boolean;
begin
  Result := Char.IsDefined(C);
end;

class function TCharacter.IsDigit(C: Char): Boolean;
begin
  Result := C.IsDigit;
end;

class function TCharacter.IsDigit(C: UCS4Char): Boolean;
begin
  Result := Char.IsDigit(C);
end;

class function TCharacter.IsDigit(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsDigit(S, Index-1);
end;

class function TCharacter.IsHighSurrogate(C: Char): Boolean;
begin
  Result := C.IsHighSurrogate;
end;

class function TCharacter.IsHighSurrogate(C: UCS4Char): Boolean;
begin
  Result := Char.IsHighSurrogate(C);
end;

class function TCharacter.IsLowSurrogate(C: Char): Boolean;
begin
  Result := C.IsLowSurrogate;
end;

class function TCharacter.IsLowSurrogate(C: UCS4Char): Boolean;
begin
  Result := Char.IsLowSurrogate(C);
end;

class function TCharacter.IsSurrogate(Surrogate: Char): Boolean;
begin
  Result := Surrogate.IsSurrogate;
end;

class function TCharacter.IsSurrogate(Surrogate: UCS4Char): Boolean;
begin
  Result := Char.IsSurrogate(Surrogate);
end;

class function TCharacter.IsSurrogatePair(const HighSurrogate, LowSurrogate: Char): Boolean;
begin
  Result := Char.IsSurrogatePair(HighSurrogate,LowSurrogate);
end;

class function TCharacter.GetUnicodeCategory(C: Char): TUnicodeCategory;
begin
  Result := C.GetUnicodeCategory;
end;

class function TCharacter.GetUnicodeCategory(C: UCS4Char): TUnicodeCategory;
begin
  Result := Char.GetUnicodeCategory(C);
end;

class function TCharacter.ConvertToUtf32(const S: string; Index: Integer; out CharLength: Integer): UCS4Char;
begin
  CheckStringRange(S, Index);
  Result := Char.ConvertToUTF32(S, Index-1, CharLength);
end;

class function TCharacter.ConvertToUtf32(const S: string; Index: Integer): UCS4Char;
var
  CharLength: Integer;
begin
  Result := Char.ConvertToUtf32(S, Index-1, CharLength);
end;

class function TCharacter.ConvertFromUtf32(C: UCS4Char): string;
begin
  Result := Char.ConvertFromUTF32(C);
end;

class function TCharacter.ConvertToUtf32(const HighSurrogate, LowSurrogate: Char): UCS4Char;
begin
  Result := Char.ConvertToUTF32(HighSurrogate, LowSurrogate);
end;

class function TCharacter.GetNumericValue(C: Char): Double;
begin
  Result := Char.GetNumericValue(UCS4Char(C));
end;

class function TCharacter.GetNumericValue(C: UCS4Char): Double;
begin
  Result := Char.GetNumericValue(C);
end;

class function TCharacter.GetNumericValue(const S: string; Index: Integer): Double;
begin
  CheckStringRange(S, Index);
  Result := Char.GetNumericValue(S, Index-1);
end;

class function TCharacter.GetUnicodeCategory(const S: string; Index: Integer): TUnicodeCategory;
begin
  CheckStringRange(S, Index);
  Result := Char.GetUnicodeCategory(S, Index-1);
end;

class function TCharacter.IsHighSurrogate(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := S.Chars[Index-1].IsHighSurrogate;
end;

class function TCharacter.IsLower(C: Char): Boolean;
begin
  Result := C.IsLower;
end;

class function TCharacter.IsLower(C: UCS4Char): Boolean;
begin
  Result := Char.IsLower(C);
end;

class function TCharacter.IsLower(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsLower(S, Index-1);
end;

class function TCharacter.IsLowSurrogate(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := S.Chars[Index - 1].IsLowSurrogate;
end;

class function TCharacter.IsNumber(C: Char): Boolean;
begin
  Result := C.IsNumber;
end;

class function TCharacter.IsNumber(C: UCS4Char): Boolean;
begin
  Result := Char.IsNumber(C);
end;

class function TCharacter.IsNumber(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsNumber(S, Index-1);
end;

class function TCharacter.IsPunctuation(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsPunctuation(S, Index-1);
end;

class function TCharacter.IsPunctuation(C: Char): Boolean;
begin
  Result := C.IsPunctuation;
end;

class function TCharacter.IsPunctuation(C: UCS4Char): Boolean;
begin
  Result := Char.IsPunctuation(C);
end;

class function TCharacter.IsSeparator(C: Char): Boolean;
begin
  Result := C.IsSeparator;
end;

class function TCharacter.IsSeparator(C: UCS4Char): Boolean;
begin
  Result := Char.IsSeparator(C);
end;

class function TCharacter.IsSeparator(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsSeparator(S, Index-1);
end;

class function TCharacter.IsSurrogate(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := S.Chars[Index - 1].IsSurrogate;
end;

class function TCharacter.IsSurrogatePair(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsSurrogatePair(S, Index - 1);
end;

class function TCharacter.IsSymbol(C: Char): Boolean;
begin
  Result := C.IsSymbol;
end;

class function TCharacter.IsSymbol(C: UCS4Char): Boolean;
begin
  Result := Char.IsSymbol(C);
end;

class function TCharacter.IsSymbol(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsSymbol(S, Index-1);
end;

class function TCharacter.IsUpper(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsUpper(S, Index-1);
end;

class function TCharacter.IsUpper(C: Char): Boolean;
begin
  Result := C.IsUpper;
end;

class function TCharacter.IsUpper(C: UCS4Char): Boolean;
begin
  Result := Char.IsUpper(C);
end;

class function TCharacter.IsWhiteSpace(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsWhiteSpace(S, Index-1);
end;

class function TCharacter.ToLower(C: Char): Char;
begin
  Result := C.ToLower;
end;

class function TCharacter.ToLower(C: UCS4Char): UCS4Char;
begin
  Result := Char.ToLower(C);
end;

                                                                                                                                                                           
class function TCharacter.ToLower(const S: string): string;
begin
  Result := Char.ToLower(S);
end;

class function TCharacter.ToUpper(C: Char): Char;
begin
  Result := C.ToUpper;
end;

class function TCharacter.ToUpper(C: UCS4Char): UCS4Char;
begin
  Result := Char.ToUpper(C);
end;

class function TCharacter.ToUpper(const S: string): string;
begin
  Result := Char.ToUpper(S);
end;

class function TCharacter.IsWhiteSpace(C: Char): Boolean;
begin
  Result := C.IsWhiteSpace;
end;

class function TCharacter.IsWhiteSpace(C: UCS4Char): Boolean;
begin
  Result := Char.IsWhiteSpace(C);
end;

// Misc old Standalone functions.

function ConvertFromUtf32(C: UCS4Char): string;
begin
  Result := Char.ConvertFromUtf32(C);
end;

function ConvertToUtf32(const S: string; Index: Integer): UCS4Char;
begin
  CheckStringRange(S, Index);
  Result := Char.ConvertToUtf32(S, Index-1);
end;

function ConvertToUtf32(const S: string; Index: Integer; out CharLength: Integer): UCS4Char;
begin
  CheckStringRange(S, Index);
  Result := Char.ConvertToUtf32(S, Index-1, CharLength);
end;

function ConvertToUtf32(const HighSurrogate, LowSurrogate: Char): UCS4Char;
begin
  Result := Char.ConvertToUtf32(HighSurrogate, LowSurrogate);
end;

function GetNumericValue(C: Char): Double;
begin
  Result := C.GetNumericValue;
end;

function GetNumericValue(C: UCS4Char): Double;
begin
  Result := Char.GetNumericValue(C);
end;

function GetNumericValue(const S: string; Index: Integer): Double;
begin
  CheckStringRange(S, Index);
  Result := Char.GetNumericValue(S, Index-1);
end;

function GetUnicodeCategory(C: Char): TUnicodeCategory;
begin
  Result := C.GetUnicodeCategory;
end;

function GetUnicodeCategory(C: UCS4Char): TUnicodeCategory;
begin
  Result := Char.GetUnicodeCategory(C);
end;

function GetUnicodeCategory(const S: string; Index: Integer): TUnicodeCategory;
begin
  CheckStringRange(S, Index);
  Result := Char.GetUnicodeCategory(S, Index-1);
end;

function IsControl(C: Char): Boolean;
begin
  Result := C.IsControl;
end;

function IsControl(C: UCS4Char): Boolean;
begin
  Result := Char.IsControl(C);
end;

function IsControl(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsControl(S, Index-1);
end;

function IsDefined(C: Char): Boolean;
begin
  Result := C.IsDefined;
end;

function IsDefined(C: UCS4Char): Boolean;
begin
  Result := Char.IsDefined(C);
end;

function IsDefined(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsDefined(S, Index-1);
end;

function IsDigit(C: Char): Boolean;
begin
  Result := C.IsDigit;
end;

function IsDigit(C: UCS4Char): Boolean;
begin
  Result := Char.IsDigit(C);
end;

function IsDigit(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsDigit(S, Index-1);
end;

function IsHighSurrogate(C: Char): Boolean;
begin
  Result := C.IsHighSurrogate;
end;

function IsHighSurrogate(C: UCS4Char): Boolean;
begin
  Result := Char.IsHighSurrogate(C);
end;

function IsHighSurrogate(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsHighSurrogate(S, Index-1);
end;

function IsLetter(C: Char): Boolean;
begin
  Result := C.IsLetter;
end;

function IsLetter(C: UCS4Char): Boolean;
begin
  Result := Char.IsLetter(C);
end;

function IsLetter(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsLetter(S, Index-1);
end;

function IsLetterOrDigit(C: Char): Boolean;
begin
  Result := C.IsLetterOrDigit;
end;

function IsLetterOrDigit(C: UCS4Char): Boolean;
begin
  Result := Char.IsLetterOrDigit(C);
end;

function IsLetterOrDigit(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsLetterOrDigit(S, Index-1);
end;

function IsLower(C: Char): Boolean;
begin
  Result := C.IsLower;
end;

function IsLower(C: UCS4Char): Boolean;
begin
  Result := Char.IsLower(C);
end;

function IsLower(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsLower(S, Index-1);
end;

function IsLowSurrogate(C: Char): Boolean;
begin
  Result := C.IsLowSurrogate;
end;

function IsLowSurrogate(C: UCS4Char): Boolean;
begin
  Result := Char.IsLowSurrogate(C);
end;

function IsLowSurrogate(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsLowSurrogate(S, Index-1);
end;

function IsNumber(C: Char): Boolean;
begin
  Result := C.IsNumber;
end;

function IsNumber(C: UCS4Char): Boolean;
begin
  Result := Char.IsNumber(C);
end;

function IsNumber(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsNumber(S, Index-1);
end;

function IsPunctuation(C: Char): Boolean;
begin
  Result := C.IsPunctuation;
end;

function IsPunctuation(C: UCS4Char): Boolean;
begin
  Result := Char.IsPunctuation(C);
end;

function IsPunctuation(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsPunctuation(S, Index-1);
end;

function IsSeparator(C: Char): Boolean;
begin
  Result := C.IsSeparator;
end;

function IsSeparator(C: UCS4Char): Boolean;
begin
  Result := Char.IsSeparator(C);
end;

function IsSeparator(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsSeparator(S, Index-1);
end;

function IsSurrogate(Surrogate: Char): Boolean;
begin
  Result := Surrogate.IsSurrogate;
end;

function IsSurrogate(Surrogate: UCS4Char): Boolean;
begin
  Result := Char.IsSurrogate(Surrogate);
end;

function IsSurrogate(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsSurrogate(S, Index-1);
end;

function IsSurrogatePair(const HighSurrogate, LowSurrogate: Char): Boolean;
begin
  Result := Char.IsSurrogatePair(HighSurrogate, LowSurrogate);
end;

function IsSurrogatePair(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsSurrogatePair(S, Index-1);
end;

function IsSymbol(C: Char): Boolean;
begin
  Result := C.IsSymbol;
end;

function IsSymbol(C: UCS4Char): Boolean;
begin
  Result := Char.IsSymbol(C);
end;

function IsSymbol(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsSymbol(S, Index-1);
end;

function IsUpper(C: Char): Boolean;
begin
  Result := C.IsUpper;
end;

function IsUpper(C: UCS4Char): Boolean;
begin
  Result := Char.IsUpper(C);
end;

function IsUpper(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsUpper(S, Index-1);
end;

function IsWhiteSpace(C: Char): Boolean;
begin
  Result := C.IsWhiteSpace;
end;

function IsWhiteSpace(C: UCS4Char): Boolean;
begin
  Result := Char.IsWhiteSpace(C);
end;

function IsWhiteSpace(const S: string; Index: Integer): Boolean;
begin
  CheckStringRange(S, Index);
  Result := Char.IsWhiteSpace(S, Index-1);
end;

function ToLower(C: Char): Char;
begin
  Result := C.ToLower;
end;

function ToLower(C: UCS4Char): UCS4Char;
begin
  Result := Char.ToLower(C);
end;

function ToLower(const S: string): string;
begin
  Result := Char.ToLower(S);
end;

function ToUpper(C: Char): Char;
begin
  Result := C.ToUpper;
end;

function ToUpper(C: UCS4Char): UCS4Char;
begin
  Result := Char.ToUpper(C);
end;

function ToUpper(const S: string): string;
begin
  Result := Char.ToUpper(S);
end;

// -------------------------------------------------------------------------- //

{$ZEROBASEDSTRINGS ON}

{Internal Functions}

class procedure TCharHelper.RaiseCheckStringRangeException(Index, LowIndex, MaxIndex: Integer);
begin
  raise EArgumentOutOfRangeException.CreateResFmt(@sArgumentOutOfRange_StringIndex, [Index, LowIndex, MaxIndex]) at ReturnAddress;
end;

procedure CheckZeroStringRange(const S: string; Index: Integer); inline;
var
  MaxIndex: Integer;
begin
  MaxIndex := High(S);
  if (Index > MaxIndex) or (Index < 0) then
    Char.RaiseCheckStringRangeException(index, 0, MaxIndex);
end;

{ TCharacterHelper }

class function TCharHelper.MaxCodePoint: Integer;
begin
  Result := UnicodeLastChar;
end;

class function TCharHelper.UnicodeDataVersion: string;
begin
  Result := System.Character.UnicodeDataVersion;
end;

function TCharHelper.IsLetter: Boolean;
var
  C: UCS4Char;
begin
  C := UCS4Char(Self);
  if IsAscii(C) then
  begin
    C := C or $0020; // Set case-bit.
    Result := (C >= $0061) and (C <= $007A); // 'a' / 'z'
  end
  else if IsLatin1(C) then
    Result := CheckLetter(InternalGetLatin1Category(C))
  else
    Result := CheckLetter(InternalGetUnicodeCategory(C));
end;

function TCharHelper.IsLetterOrDigit: Boolean;
begin
  if IsLatin1(UCS4Char(Self)) then
    Result := CheckLetterOrDigit(InternalGetLatin1Category(UCS4Char(Self)))
  else
    Result := CheckLetterOrDigit(InternalGetUnicodeCategory(UCS4Char(Self)));
end;

class function TCharHelper.IsLetter(const S: string; Index: Integer): Boolean;
var
  C: UCS4Char;
begin
  CheckZeroStringRange(S, Index);
  C := UCS4Char(S[Index]);
  if IsLatin1(C) then
    Result := CheckLetterOrDigit(InternalGetUnicodeCategory(C))
  else
    Result := CheckLetterOrDigit(InternalGetUnicodeCategory(ConvertToUtf32(S, Index)));
end;

class function TCharHelper.IsLetterOrDigit(const S: string; Index: Integer): Boolean;
var
  C: UCS4Char;
begin
  CheckZeroStringRange(S, Index);
  C := UCS4Char(S[Index]);
  if IsLatin1(C) then
    Result := CheckLetterOrDigit(InternalGetUnicodeCategory(C))
  else
    Result := CheckLetterOrDigit(InternalGetUnicodeCategory(ConvertToUtf32(S, Index)));
end;

class function TCharHelper.IsControl(const S: string; Index: Integer): Boolean;
var
  C: UCS4Char;
begin
  CheckZeroStringRange(S, Index);
  C := UCS4Char(S[Index]);
  if IsLatin1(C) then
    Result := InternalGetLatin1Category(C) = TUnicodeCategory.ucControl
  else
    Result := InternalGetUnicodeCategory(ConvertToUtf32(S, Index)) = TUnicodeCategory.ucControl;
end;

class function TCharHelper.IsDefined(const S: string; Index: Integer): Boolean;
var
  C: UCS4Char;
begin
  CheckZeroStringRange(S, Index);
  C := UCS4Char(S[Index]);
  if IsLatin1(C) then
    Result := True
  else
    Result := InternalGetUnicodeCategory(ConvertToUtf32(S, Index)) <> TUnicodeCategory.ucUnassigned;
end;

function TCharHelper.IsControl: Boolean;
begin
  if IsLatin1(UCS4Char(Self)) then
    Result := InternalGetLatin1Category(UCS4Char(Self)) = TUnicodeCategory.ucControl
  else
    Result := InternalGetUnicodeCategory(UCS4Char(Self)) = TUnicodeCategory.ucControl;
end;

function TCharHelper.IsDefined: Boolean;
begin
  if IsLatin1(UCS4Char(Self)) then
    Result := True
  else
    Result := InternalGetUnicodeCategory(UCS4Char(Self)) <> TUnicodeCategory.ucUnassigned;
end;

function TCharHelper.IsDigit: Boolean;
begin
  if IsLatin1(UCS4Char(Self)) then
    Result := UCS4Char(Self) in [$0030..$0039] // '0' / '9'
  else
    Result := InternalGetUnicodeCategory(UCS4Char(Self)) = TUnicodeCategory.ucDecimalNumber
end;

class function TCharHelper.IsDigit(const S: string; Index: Integer): Boolean;
var
  C: UCS4Char;
begin
  CheckZeroStringRange(S, Index);
  C := UCS4Char(S[Index]);
  if IsLatin1(C) then
    Result := C in [$0030..$0039] // '0' / '9'
  else
    Result := InternalGetUnicodeCategory(ConvertToUtf32(S, Index)) = TUnicodeCategory.ucDecimalNumber;
end;

function TCharHelper.IsHighSurrogate: Boolean;
begin
  Result := (Self >= MinHighSurrogate) and (Self <= MaxHighSurrogate);
end;

function TCharHelper.IsInArray(const SomeChars: array of char): Boolean;
var
  AChar: Char;
begin
  for AChar in SomeChars do
    if AChar = Self then Exit(True);
  Result := False;
end;

function TCharHelper.IsLower: Boolean;
begin
  if IsAscii(UCS4Char(Self)) then
    Result := UCS4Char(Self) in [$0061..$007A] // 'a' / 'z'
  else if IsLatin1(UCS4Char(Self)) then
    Result := InternalGetLatin1Category(UCS4Char(Self)) = TUnicodeCategory.ucLowercaseLetter
  else
    Result := InternalGetUnicodeCategory(UCS4Char(Self)) = TUnicodeCategory.ucLowercaseLetter
end;

function TCharHelper.IsLowSurrogate: Boolean;
begin
  Result := (Self >= MinLowSurrogate) and (Self <= MaxLowSurrogate);
end;

function TCharHelper.IsSurrogate: Boolean;
begin
  Result := (Self >= MinSurrogate) and (Self <= MaxSurrogate);
end;

class function TCharHelper.IsSurrogatePair(const HighSurrogate, LowSurrogate: Char): Boolean;
begin
  Result := (HighSurrogate >= MinHighSurrogate) and (HighSurrogate <= MaxHighSurrogate) and
    (LowSurrogate >= MinLowSurrogate) and (LowSurrogate <= MaxLowSurrogate);
end;

function TCharHelper.GetUnicodeCategory: TUnicodeCategory;
begin
  if IsLatin1(UCS4Char(Self)) then
    Result := InternalGetLatin1Category(UCS4Char(Self))
  else
    Result := InternalGetUnicodeCategory(UCS4Char(Self));
end;

class function TCharHelper.ConvertToUtf32(const S: string; Index: Integer; out CharLength: Integer): UCS4Char;
var
  LowSurrogate, HighSurrogate: Integer;
begin
  CheckZeroStringRange(S, Index);
  CharLength := 1;
  HighSurrogate := Integer(S[Index]) - Integer(MinHighSurrogate);
  if (HighSurrogate < 0) or (HighSurrogate > $7FF) then
    Result := S[Index].ToUCS4Char
  else
  begin
    if HighSurrogate > $3FF then
      raise EArgumentOutOfRangeException.CreateResFmt(@sArgument_InvalidLowSurrogate, [Index]);
    if Index > High(S) - Low(string) then
      raise EArgumentOutOfRangeException.CreateResFmt(@sArgument_InvalidHighSurrogate, [Index]);
    LowSurrogate := Integer(S[Index+1]) - Integer(MinLowSurrogate);
    if (LowSurrogate < 0) or (LowSurrogate > $3FF) then
      raise EArgumentOutOfRangeException.CreateResFmt(@sArgument_InvalidHighSurrogate, [Index]);
    Inc(CharLength);
    Result := (HighSurrogate * $400) + LowSurrogate + $10000;
  end;
end;

class function TCharHelper.ConvertToUtf32(const S: string; Index: Integer): UCS4Char;
var
  CharLength: Integer;
begin
  Result := ConvertToUtf32(S, Index, CharLength);
end;

class function TCharHelper.ConvertFromUtf32(C: UCS4Char): string;
begin
  if (C > UnicodeLastChar) or ((C >= UCS4Char(MinHighSurrogate)) and (C <= UCS4Char(MaxLowSurrogate))) then
    raise EArgumentOutOfRangeException.CreateRes(@sArgumentOutOfRange_InvalidUTF32);
  if C < $10000 then
    Result := Char(C)
  else
  begin
    Dec(C, $10000);
    Result := Char(C div $400 + UCS4Char(MinHighSurrogate)) + Char(C mod $400 + UCS4Char(MinLowSurrogate));
  end;
end;

class function TCharHelper.ConvertToUtf32(const HighSurrogate, LowSurrogate: Char): UCS4Char;
begin
  if not HighSurrogate.IsHighSurrogate then
    raise EArgumentOutOfRangeException.CreateRes(@sArgumentOutOfRange_InvalidHighSurrogate);
  if not LowSurrogate.IsLowSurrogate then
    raise EArgumentOutOfRangeException.CreateRes(@sArgumentOutOfRange_InvalidLowSurrogate);
  Result := ((Integer(HighSurrogate) - Integer(MinHighSurrogate)) * $400) + (Integer(LowSurrogate) - Integer(MinLowSurrogate)) + $10000;
end;

function TCharHelper.GetNumericValue: Double;
begin
  Result := InternalNumberValue(UCS4Char(Self));
end;

class function TCharHelper.GetNumericValue(const S: string; Index: Integer): Double;
begin
  CheckZeroStringRange(S, Index);
  Result := InternalNumberValue(ConvertToUTF32(S, Index));
end;

class function TCharHelper.GetUnicodeCategory(const S: string; Index: Integer): TUnicodeCategory;
begin
  CheckZeroStringRange(S, Index);
  if  IsLatin1(UCS4Char(S[Index])) then
    Result := InternalGetLatin1Category(UCS4Char(S[Index]))
  else
    Result := InternalGetUnicodeCategory(ConvertToUtf32(S, Index));
end;

class function TCharHelper.IsHighSurrogate(const S: string; Index: Integer): Boolean;
begin
  CheckZeroStringRange(S, Index);
  Result := S[Index].IsHighSurrogate;
end;

class function TCharHelper.IsInArray(const S: string; Index: Integer; const SomeChars: array of char): Boolean;
begin
  CheckZeroStringRange(S, Index);
  Result := S[Index].IsInArray(SomeChars);
end;

class function TCharHelper.IsLower(const S: string; Index: Integer): Boolean;
var
  C: UCS4Char;
begin
  CheckZeroStringRange(S, Index);
  C := UCS4Char(S[Index]);
  if IsAscii(C) then
    Result := C in [$0061..$007A] // 'a' / 'z'
  else if IsLatin1(C) then
    Result := InternalGetLatin1Category(C) = TUnicodeCategory.ucLowercaseLetter
  else
    Result := InternalGetUnicodeCategory(ConvertToUtf32(S, Index)) = TUnicodeCategory.ucLowercaseLetter;
end;

class function TCharHelper.IsLowSurrogate(const S: string; Index: Integer): Boolean;
begin
  CheckZeroStringRange(S, Index);
  Result := S[Index].IsLowSurrogate;
end;

function TCharHelper.IsNumber: Boolean;
begin
  if IsAscii(UCS4Char(Self)) then
    Result := UCS4Char(Self) in [$0030..$0039] // '0' / '9'
  else if IsLatin1(UCS4Char(Self)) then
    Result := CheckNumber(InternalGetLatin1Category(UCS4Char(Self)))
  else
    Result := CheckNumber(InternalGetUnicodeCategory(UCS4Char(Self)));
end;

function TCharHelper.IsPunctuation: Boolean;
begin
  if Self = #$00AD then // 'SOFT HYPHEN' Keep backword compatibility.
    Result := True
  else if IsLatin1(UCS4Char(Self)) then
    Result := CheckPunctuation(InternalGetLatin1Category(UCS4Char(Self)))
  else
    Result := CheckPunctuation(InternalGetUnicodeCategory(UCS4Char(Self)));
end;

class function TCharHelper.IsNumber(const S: string; Index: Integer): Boolean;
var
  C: UCS4Char;
begin
  CheckZeroStringRange(S, Index);
  C := UCS4Char(S[Index]);
  if IsAscii(C) then
    Result := C in [$0030..$0039] // '0' / '9'
  else if IsLatin1(C) then
    Result := CheckNumber(InternalGetLatin1Category(C))
  else
    Result := CheckNumber(InternalGetUnicodeCategory(ConvertToUtf32(S, Index)));
end;

class function TCharHelper.IsPunctuation(const S: string; Index: Integer): Boolean;
var
  C: UCS4Char;
begin
  CheckZeroStringRange(S, Index);
  C := UCS4Char(S[Index]);

  if C = $00AD then // 'SOFT HYPHEN' Keep backword compatibility.
    Result := True
  else if IsLatin1(C) then
    Result := CheckPunctuation(InternalGetLatin1Category(C))
  else
    Result := CheckPunctuation(InternalGetUnicodeCategory(ConvertToUtf32(S, Index)));
end;

function TCharHelper.IsSeparator: Boolean;
begin
  if IsLatin1(UCS4Char(Self)) then
    Result := UCS4Char(Self) in [$0020, $00A0] // Space / No-Break Space
  else
    Result := CheckSeparator(InternalGetUnicodeCategory(UCS4Char(Self)));
end;

class function TCharHelper.IsSeparator(const S: string; Index: Integer): Boolean;
var
  C: UCS4Char;
begin
  CheckZeroStringRange(S, Index);
  C := UCS4Char(S[Index]);
  if IsLatin1(C) then
    Result := C in [$0020, $00A0] // Space / No-Break Space
  else
    Result := CheckSeparator(InternalGetUnicodeCategory(ConvertToUtf32(S, Index)));
end;

class function TCharHelper.IsSurrogate(const S: string; Index: Integer): Boolean;
begin
  CheckZeroStringRange(S, Index);
  Result := S[Index].IsSurrogate;
end;

class function TCharHelper.IsSurrogatePair(const S: string; Index: Integer): Boolean;
begin
  CheckZeroStringRange(S, Index);
  Result := (Index < High(S)) and IsSurrogatePair(S[Index], S[Index+1]);
end;

function TCharHelper.IsSymbol: Boolean;
begin
  if IsLatin1(UCS4Char(Self)) then
    Result := CheckSymbol(InternalGetLatin1Category(UCS4Char(Self)))
  else
    Result := CheckSymbol(InternalGetUnicodeCategory(UCS4Char(Self)));
end;

class function TCharHelper.IsSymbol(const S: string; Index: Integer): Boolean;
var
  C: UCS4Char;
begin
  CheckZeroStringRange(S, Index);
  C := UCS4Char(S[Index]);
  if IsLatin1(C) then
    Result := CheckSymbol(InternalGetLatin1Category(C))
  else
    Result := CheckSymbol(InternalGetUnicodeCategory(ConvertToUtf32(S, Index)));
end;

class function TCharHelper.IsUpper(const S: string; Index: Integer): Boolean;
var
  C: UCS4Char;
begin
  CheckZeroStringRange(S, Index);
  C := UCS4Char(S[Index]);
  if IsAscii(C) then
    Result := C in [$0041..$005A] // 'A' / 'Z'
  else if IsLatin1(C) then
    Result := InternalGetLatin1Category(C) = TUnicodeCategory.ucUppercaseLetter
  else
    Result := InternalGetUnicodeCategory(ConvertToUtf32(S, Index)) = TUnicodeCategory.ucUppercaseLetter
end;

function TCharHelper.IsUpper: Boolean;
begin
  if IsAscii(UCS4Char(Self)) then
    Result := UCS4Char(Self) in [$0041..$005A] // 'A' / 'Z'
  else if IsLatin1(UCS4Char(Self)) then
    Result := InternalGetLatin1Category(UCS4Char(Self)) = TUnicodeCategory.ucUppercaseLetter
  else
    Result := InternalGetUnicodeCategory(UCS4Char(Self)) = TUnicodeCategory.ucUppercaseLetter;
end;

class function TCharHelper.IsWhiteSpace(const S: string; Index: Integer): Boolean;
var
  C: UCS4Char;
begin
  CheckZeroStringRange(S, Index);
  C := UCS4Char(S[Index]);
  if IsLatin1(C) then
    Result := C in [$0020, $0009..$000D, $00A0, $0085] // SPACE, TAB,LF,LINE-TAB,FF,CR, No-break Space, NEL
  else
    Result := CheckSeparator(InternalGetUnicodeCategory(ConvertToUtf32(S, Index)));
end;

function TCharHelper.ToLower: Char;
{$IFDEF MACOS}
var
  CFStringRefBuffer: CFMutableStringRef;
{$ENDIF}
begin
{$IF Defined(USE_LIBICU)}
  Result := Char(u_tolower(UChar32(Self)));
{$ELSEIF Defined(MACOS)}
  Result := Self;
  CFStringRefBuffer := CFStringCreateMutableWithExternalCharactersNoCopy(kCFAllocatorDefault,
    @Result, 1, 1, kCFAllocatorNull);
  if CFStringRefBuffer <> nil then
  try
    CFStringLowercase(CFStringRefBuffer, UTF8CompareLocale);
  finally
    CFRelease(CFStringRefBuffer);
  end;
{$ELSEIF Defined(POSIX)}
  Result := Char(towlower_l(Self.ToUCS4Char, UTF8CompareLocale));
{$ELSEIF Defined(MSWINDOWS)}
  Result := Char(NativeInt(CharLower(PChar(Self))));
{$ENDIF}
end;

                                                                                                                                                                            
class function TCharHelper.ToLower(const S: string): string;
{$IF Defined(MACOS) or Defined(ANDROID) or Defined(LINUX64)}
begin
  Result := System.SysUtils.AnsiLowerCase(S);
end;
{$ELSEIF Defined(POSIX)}
var
  I, J, ICharLen, JCharLen, K: Integer;
  LowerChar: UCS4Char;
  Ucs2String: string;
  ResChars: TCharArray;
begin
  Result := S;
  if Result <> '' then
  begin
    UniqueString(Result);
    ResChars := Result.ToCharArray;
    I := Low(string);
    J := 0;
    while I <= High(Result) do
    begin
      ICharLen := 1;
      JCharLen := 1;
      if (S[I] >= 'A') and (S[I] <= 'Z') then
        ResChars[J] := Char(Ord(S[I]) + $20)
      else if IsAscii(UCS4Char(S[I])) then
        ResChars[J] := S[I]
      else
      begin
        if IsSurrogate(UCS4Char(S[I])) then
          LowerChar := ConvertToUtf32(S, I, ICharLen)
        else
          LowerChar := UCS4Char(S[I]);
        LowerChar := towlower_l(LowerChar, UTF8CompareLocale);
        if LowerChar < $10000 then
          ResChars[J] := Char(LowerChar)
        else
        begin
          Ucs2String := ConvertFromUtf32(LowerChar);
          JCharLen := Length(Ucs2String);
          if JCharLen > 1 then
          begin
            SetLength(ResChars, Length(ResChars) + JCharLen - 1);
            for K := Low(Ucs2String) to High(Ucs2String) do
              ResChars[J + K - Low(Ucs2String)] := Ucs2String[K];
          end
          else
            ResChars[J] := Ucs2String[Low(Ucs2String)];
        end;
      end;
      Inc(I, ICharLen);
      Inc(J, JCharLen);
    end;
    Result := string.Create(ResChars);
  end;
end;
{$ELSEIF Defined(MSWINDOWS)}
var
  MapLocale: LCID;
begin
  Result := S;
  if Result <> '' then
  begin
    UniqueString(Result);
    if TOSVersion.Check(5, 1) then
      MapLocale := LOCALE_INVARIANT
    else
      MapLocale := LOCALE_SYSTEM_DEFAULT;
    if LCMapString(MapLocale, LCMAP_LOWERCASE, PChar(S), S.Length,
      PChar(Result), Result.Length) = 0 then
      RaiseLastOSError;
  end;
end;
{$ELSE}
begin
  Error(rePlatformNotImplemented);
end;
{$ENDIF}

function TCharHelper.ToUCS4Char: UCS4Char;
begin
  Result := UCS4Char(Self);
end;

function TCharHelper.ToUpper: Char;
{$IFDEF MACOS}
var
  CFStringRefBuffer: CFMutableStringRef;
{$ENDIF}
begin
{$IF Defined(USE_LIBICU)}
  Result := Char(u_toupper(UChar32(Self)));
{$ELSEIF Defined(MACOS)}
  Result := Self;
  CFStringRefBuffer := CFStringCreateMutableWithExternalCharactersNoCopy(kCFAllocatorDefault,
    @Result, 1, 1, kCFAllocatorNull);
  if CFStringRefBuffer <> nil then
  try
    CFStringUppercase(CFStringRefBuffer, UTF8CompareLocale);
  finally
    CFRelease(CFStringRefBuffer);
  end;
{$ELSEIF Defined(POSIX)}
  Result := Char(towupper_l(UCS4Char(Self), UTF8CompareLocale));
{$ELSEIF Defined(MSWINDOWS)}
  Result := Char(NativeInt(CharUpper(PChar(Self))));
{$ENDIF}
end;

class function TCharHelper.ToUpper(const S: string): string;
{$IF Defined(MACOS) or Defined(ANDROID) or Defined(LINUX)}
begin
  Result := System.SysUtils.AnsiUpperCase(S);
end;
{$ELSEIF Defined(POSIX)}
var
  I, J, ICharLen, JCharLen, K: Integer;
  UpperChar: UCS4Char;
  Ucs2String: string;
  ResChars: TCharArray;
begin
  Result := S;
  if Result <> '' then
  begin
    UniqueString(Result);
    ResChars := Result.ToCharArray;
    I := Low(string);
    J := 0;
    while I <= High(Result) do
    begin
      ICharLen := 1;
      JCharLen := 1;
      if (S[I] >= 'a') and (S[I] <= 'z') then
        ResChars[J] := Char(Ord(S[I]) - $20)
      else if IsAscii(S[I]) then
        ResChars[J] := S[I]
      else
      begin
        if IsSurrogate(S[I]) then
          UpperChar := ConvertToUtf32(S, I, ICharLen)
        else
          UpperChar := UCS4Char(S[I]);
        UpperChar := towupper_l(UpperChar, UTF8CompareLocale);
        if UpperChar < $10000 then
          ResChars[J] := Char(UpperChar)
        else
        begin
          Ucs2String := ConvertFromUtf32(UpperChar);
          JCharLen := Ucs2String.Length;
          if JCharLen > 1 then
          begin
            SetLength(ResChars, Length(ResChars) + JCharLen - 1);
            for K := Low(Ucs2String) to High(Ucs2String) do
              ResChars[J + K - Low(Ucs2String)] := Ucs2String[K];
          end
          else
            ResChars[J] := Ucs2String[Low(Ucs2String)];
        end;
      end;
      Inc(I, ICharLen);
      Inc(J, JCharLen);
    end;
    Result := string.Create(ResChars);
  end;
end;
{$ELSEIF Defined(MSWINDOWS)}
var
  MapLocale: LCID;
begin
  Result := S;
  if Result <> '' then
  begin
    UniqueString(Result);
    if TOSVersion.Check(5, 1) then
      MapLocale := LOCALE_INVARIANT
    else
      MapLocale := LOCALE_SYSTEM_DEFAULT;
    if LCMapString(MapLocale, LCMAP_UPPERCASE, PChar(S), S.Length,
      PChar(Result), Result.Length) = 0 then
      RaiseLastOSError;
  end;
end;
{$ELSE}
begin
  Error(rePlatformNotImplemented);
end;
{$ENDIF}

function TCharHelper.IsWhiteSpace: Boolean;
begin
  if IsLatin1(UCS4Char(Self)) then
    Result := UCS4Char(Self) in [$0020, $0009..$000D, $00A0, $0085] // SPACE, TAB,LF,LINE-TAB,FF,CR, No-break Space, NEL
  else
    Result := CheckSeparator(InternalGetUnicodeCategory(UCS4Char(Self)));
end;

// -------------------------------------------------------------------------- //

// -------------------------------------------------------------------------- //
// TCharHelper class functions for the UCS4 data.
// -------------------------------------------------------------------------- //

class function TCharHelper.IsLetter(C: UCS4Char): Boolean;
begin
  if IsAscii(C) then
  begin
    C := C or $0020; // Set case-bit.
    Result := C in [$0061..$007A]; // 'a' / 'z'
  end
  else if IsLatin1(C) then
    Result := CheckLetter(InternalGetLatin1Category(C))
  else
    Result := CheckLetter(InternalGetUnicodeCategory(C));
end;

class function TCharHelper.IsLetterOrDigit(C: UCS4Char): Boolean;
begin
  if IsLatin1(C) then
    Result := CheckLetterOrDigit(InternalGetLatin1Category(C))
  else
    Result := CheckLetterOrDigit(InternalGetUnicodeCategory(C));
end;

class function TCharHelper.IsControl(C: UCS4Char): Boolean;
begin
  if IsLatin1(C) then
    Result := InternalGetLatin1Category(C) = TUnicodeCategory.ucControl
  else
    Result := InternalGetUnicodeCategory(C) = TUnicodeCategory.ucControl
end;

class function TCharHelper.IsDefined(C: UCS4Char): Boolean;
begin
  if IsLatin1(C) then
    Result := True
  else
    Result := InternalGetUnicodeCategory(C) <> TUnicodeCategory.ucUnassigned;
end;

class function TCharHelper.IsDigit(C: UCS4Char): Boolean;
begin
  if IsLatin1(C) then
    Result := C in [$0030..$0039] // '0' / '9'
  else
    Result := InternalGetUnicodeCategory(C) = TUnicodeCategory.ucDecimalNumber;
end;

class function TCharHelper.IsHighSurrogate(C: UCS4Char): Boolean;
begin
  Result := (C >= UCS4Char(MinHighSurrogate)) and (C <= UCS4Char(MaxHighSurrogate));
end;

class function TCharHelper.IsLowSurrogate(C: UCS4Char): Boolean;
begin
  Result := (C >= UCS4Char(MinLowSurrogate)) and (C <= UCS4Char(MaxLowSurrogate));
end;

class function TCharHelper.IsSurrogate(Surrogate: UCS4Char): Boolean;
begin
  Result := (Surrogate >= UCS4Char(MinSurrogate)) and (Surrogate <= UCS4Char(MaxSurrogate));
end;

class function TCharHelper.GetUnicodeCategory(C: UCS4Char): TUnicodeCategory;
begin
  if IsLatin1(C) then
    Result := InternalGetLatin1Category(C)
  else
    Result := InternalGetUnicodeCategory(C);
end;

class function TCharHelper.GetNumericValue(C: UCS4Char): Double;
begin
  Result := InternalNumberValue(C);
end;

class function TCharHelper.IsLower(C: UCS4Char): Boolean;
begin
  if IsAscii(C) then
    Result := C in [$0061..$007A] // 'a' / 'z'
  else if IsLatin1(C) then
    Result := InternalGetLatin1Category(C) = TUnicodeCategory.ucLowercaseLetter
  else
    Result := InternalGetUnicodeCategory(C) = TUnicodeCategory.ucLowercaseLetter
end;

class function TCharHelper.IsNumber(C: UCS4Char): Boolean;
begin
  if IsAscii(C) then
    Result := C in [$0030..$0039] // '0' / '9'
  else if IsLatin1(C) then
    Result := CheckNumber(InternalGetLatin1Category(C))
  else
    Result := CheckNumber(InternalGetUnicodeCategory(C));
end;

class function TCharHelper.IsPunctuation(C: UCS4Char): Boolean;
begin
  if C = $00AD then // 'SOFT HYPHEN' Keep backword compatibility.
    Result := True
  else if IsLatin1(C) then
    Result := CheckPunctuation(InternalGetLatin1Category(C))
  else
    Result := CheckPunctuation(InternalGetUnicodeCategory(C));
end;

class function TCharHelper.IsSeparator(C: UCS4Char): Boolean;
begin
  if IsLatin1(C) then
    Result := C in [$0020, $00A0] // Space / No-Break Space
  else
    Result := CheckSeparator(InternalGetUnicodeCategory(C));
end;

class function TCharHelper.IsSymbol(C: UCS4Char): Boolean;
begin
  if IsLatin1(C) then
    Result := CheckSymbol(InternalGetLatin1Category(C))
  else
    Result := CheckSymbol(InternalGetUnicodeCategory(C))
end;

class function TCharHelper.IsUpper(C: UCS4Char): Boolean;
begin
  if IsAscii(C) then
    Result := C in [$0041..$005A] // 'A' / 'Z'
  else if IsLatin1(C) then
    Result := InternalGetUnicodeCategory(C) = TUnicodeCategory.ucUppercaseLetter
  else
    Result := InternalGetUnicodeCategory(C) = TUnicodeCategory.ucUppercaseLetter;
end;

class function TCharHelper.ToLower(C: UCS4Char): UCS4Char;
{$IFDEF MSWINDOWS}
var
  C16: Char;
{$ENDIF}
begin
{$IF Defined(USE_LIBICU)}
  Result := u_tolower(C);
{$ELSEIF Defined(POSIX)}
  Result := UCS4Char(towlower_l(C, UTF8CompareLocale));
{$ELSEIF Defined(MSWINDOWS)}
  if C < $10000 then
  begin
    C16 := Char(C);
    Result := UCS4Char(NativeInt(CharLower(PChar(C16))));
  end
  else
    Result := ConvertToUtf32(ToLower(ConvertFromUtf32(C)), Low(string));
{$ENDIF}
end;

class function TCharHelper.ToUpper(C: UCS4Char): UCS4Char;
{$IFDEF MSWINDOWS}
var
  C16: Char;
{$ENDIF}
begin
{$IF Defined(USE_LIBICU)}
  Result := u_toupper(C);
{$ELSEIF Defined(POSIX)}
  Result := UCS4Char(towupper_l(C, UTF8CompareLocale));
{$ELSEIF Defined(MSWINDOWS)}
  if C < $10000 then
  begin
    C16 := Char(C);
    Result := UCS4Char(NativeInt(CharUpper(PChar(C16))));
  end
  else
    Result := ConvertToUtf32(ToUpper(ConvertFromUtf32(C)), Low(string));
{$ENDIF}
end;

class function TCharHelper.IsWhiteSpace(C: UCS4Char): Boolean;
begin
  if IsLatin1(C) then
    Result := C in [$0020, $0009..$000D, $00A0, $0085] // SPACE, TAB,LF,LINE-TAB,FF,CR, No-break Space, NEL
  else
    Result := CheckSeparator(InternalGetUnicodeCategory(C));
end;

{$ZEROBASEDSTRINGS OFF}

{$IFDEF USE_PSEUDO_FUNCTION}
initialization
  CharTableInitialize;
{$ENDIF USE_PSEUDO_FUNCTION}

end.
