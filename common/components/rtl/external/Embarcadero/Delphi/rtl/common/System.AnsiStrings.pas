{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit System.AnsiStrings;

interface


{$IFDEF POSIX}
{$WARN IMPLICIT_STRING_CAST OFF}
{$WARN IMPLICIT_STRING_CAST_LOSS OFF}
{$ENDIF}

{$IFDEF CPUX86}
  {$DEFINE X86ASM}
{$ELSE !CPUX86}
  {$DEFINE PUREPASCAL}
{$ENDIF !CPUX86}

uses
  System.SysUtils, System.StrUtils,
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
{$IFDEF POSIX}
  Posix.String_,
{$ENDIF}
  System.SysConst;

{$REGION 'Code From SysUtils'}

{ Empty string and null string pointer. These constants are provided for
  backwards compatibility only.  }
const
  EmptyAnsiStr: AnsiString = '';
  NullAnsiStr: PAnsiString = @EmptyAnsiStr;


                                                            
{ NewStr allocates a string on the heap. NewStr is provided for backwards
  compatibility only. }

function NewStr(const S: AnsiString): PAnsiString; deprecated;

{ DisposeStr disposes a string pointer that was previously allocated using
  NewStr. DisposeStr is provided for backwards compatibility only. }

procedure DisposeStr(P: PAnsiString); deprecated;

{ AssignStr assigns a new dynamically allocated string to the given string
  pointer. AssignStr is provided for backwards compatibility only. }

procedure AssignStr(var P: PAnsiString; const S: AnsiString); deprecated;

{ AppendStr appends S to the end of Dest. AppendStr is provided for
  backwards compatibility only. Use "Dest := Dest + S" instead. }

procedure AppendStr(var Dest: AnsiString; const S: AnsiString); deprecated;

{ AnsiStrComp compares S1 to S2, with case-sensitivity. The compare
  operation is controlled by the current user locale. The return value
  is the same as for CompareStr. }

function AnsiStrComp(S1, S2: PAnsiChar): Integer; inline; overload;

{ AnsiStrIComp compares S1 to S2, without case-sensitivity. The compare
  operation is controlled by the current user locale. The return value
  is the same as for CompareStr. }

function AnsiStrIComp(S1, S2: PAnsiChar): Integer; inline; overload;

{ AnsiStrLComp compares S1 to S2, with case-sensitivity, up to a maximum
  length of MaxLen bytes. The compare operation is controlled by the
  current user locale. The return value is the same as for CompareStr. }

function AnsiStrLComp(S1, S2: PAnsiChar; MaxLen: Cardinal): Integer; overload;

{ AnsiStrLIComp compares S1 to S2, without case-sensitivity, up to a maximum
  length of MaxLen bytes. The compare operation is controlled by the
  current user locale. The return value is the same as for CompareStr. }

function AnsiStrLIComp(S1, S2: PAnsiChar; MaxLen: Cardinal): Integer; overload;

{ AnsiStrLower converts all characters in the given string to lower case.
  The conversion uses the current user locale. }

function AnsiStrLower(Str: PAnsiChar): PAnsiChar; overload;{$IFDEF MSWINDOWS} inline; {$ENDIF}

{ AnsiStrUpper converts all characters in the given string to upper case.
  The conversion uses the current user locale. }

function AnsiStrUpper(Str: PAnsiChar): PAnsiChar; overload;{$IFDEF MSWINDOWS} inline; {$ENDIF}

{ AnsiLastChar returns a pointer to the last full character in the string.
  This function supports multibyte characters  }
{ AnsiStrLastChar returns a pointer to the last full character in the string.
  This function supports multibyte characters.  }

function AnsiStrLastChar(P: PAnsiChar): PAnsiChar; overload;{$IFNDEF POSIX} inline; {$ENDIF}

{ AnsiExtractQuotedStr removes the Quote characters from the beginning and end
  of a quoted string, and reduces pairs of Quote characters within the quoted
  string to a single character. If the first character in Src is not the Quote
  character, the function returns an empty string.  The function copies
  characters from the Src to the result string until the second solitary
  Quote character or the first null character in Src. The Src parameter is
  updated to point to the first character following the quoted string.  If
  the Src string does not contain a matching end Quote character, the Src
  parameter is updated to point to the terminating null character in Src.
  This function supports multibyte character strings (MBCS).  }

function AnsiExtractQuotedStr(var Src: PAnsiChar; Quote: AnsiChar): AnsiString; overload;

{ StrLen returns the number of characters in Str, not counting the null
  terminator. }

function StrLen(const Str: PAnsiChar): Cardinal; overload;{$IFNDEF LEGACYSTRLEN} inline; {$ENDIF}

{ StrEnd returns a pointer to the null character that terminates Str. }

function StrEnd(const Str: PAnsiChar): PAnsiChar; overload;

{ StrMove copies exactly Count characters from Source to Dest and returns
  Dest. Source and Dest may overlap. }

function StrMove(Dest: PAnsiChar; const Source: PAnsiChar; Count: Cardinal): PAnsiChar; overload;

{ StrCopy copies Source to Dest and returns Dest. }

function StrCopy(Dest: PAnsiChar; const Source: PAnsiChar): PAnsiChar; overload;

{ StrECopy copies Source to Dest and returns StrEnd(Dest). }

function StrECopy(Dest: PAnsiChar; const Source: PAnsiChar): PAnsiChar; overload;

{ StrLCopy copies at most MaxLen characters from Source to Dest and
  returns Dest. }

function StrLCopy(Dest: PAnsiChar; const Source: PAnsiChar; MaxLen: Cardinal): PAnsiChar; overload;

{ StrPCopy copies the Pascal style string Source into Dest and
  returns Dest. }

function StrPCopy(Dest: PAnsiChar; const Source: AnsiString): PAnsiChar; overload;

{ StrPLCopy copies at most MaxLen characters from the Pascal style string
  Source into Dest and returns Dest. }

function StrPLCopy(Dest: PAnsiChar; const Source: AnsiString; MaxLen: Cardinal): PAnsiChar; overload;

{ StrCat appends a copy of Source to the end of Dest and returns Dest. }

function StrCat(Dest: PAnsiChar; const Source: PAnsiChar): PAnsiChar; overload;

{ StrLCat appends at most MaxLen - StrLen(Dest) characters from Source to
  the end of Dest, and returns Dest. }

function StrLCat(Dest: PAnsiChar; const Source: PAnsiChar; MaxLen: Cardinal): PAnsiChar; overload;

{ StrComp compares Str1 to Str2. The return value is less than 0 if
  Str1 < Str2, 0 if Str1 = Str2, or greater than 0 if Str1 > Str2. }

function StrComp(const Str1, Str2: PAnsiChar): Integer; overload;

{ StrIComp compares Str1 to Str2, without case sensitivity. The return
  value is the same as StrComp. }

function StrIComp(const Str1, Str2: PAnsiChar): Integer; overload;

{ StrLComp compares Str1 to Str2, for a maximum length of MaxLen
  characters. The return value is the same as StrComp. }

function StrLComp(const Str1, Str2: PAnsiChar; MaxLen: Cardinal): Integer; overload;

{ StrLIComp compares Str1 to Str2, for a maximum length of MaxLen
  characters, without case sensitivity. The return value is the same
  as StrComp. }

function StrLIComp(const Str1, Str2: PAnsiChar; MaxLen: Cardinal): Integer; overload;

{ StrScan returns a pointer to the first occurrence of Chr in Str. If Chr
  does not occur in Str, StrScan returns NIL. The null terminator is
  considered to be part of the string. }

function StrScan(const Str: PAnsiChar; Chr: AnsiChar): PAnsiChar; overload;

{ StrRScan returns a pointer to the last occurrence of Chr in Str. If Chr
  does not occur in Str, StrRScan returns NIL. The null terminator is
  considered to be part of the string. }

function StrRScan(const Str: PAnsiChar; Chr: AnsiChar): PAnsiChar; overload;

{ TextPos: Same as StrPos but is case insensitive }

function TextPos(Str, SubStr: PAnsiChar): PAnsiChar; overload;

{ StrPos returns a pointer to the first occurrence of Str2 in Str1. If
  Str2 does not occur in Str1, StrPos returns NIL. }

function StrPos(const Str1, Str2: PAnsiChar): PAnsiChar; overload;

{ StrUpper converts Str to upper case and returns Str. }

function StrUpper(Str: PAnsiChar): PAnsiChar; overload;

{ StrLower converts Str to lower case and returns Str. }

function StrLower(Str: PAnsiChar): PAnsiChar; overload;

{ StrPas converts Str to a Pascal style string. This function is provided
  for backwards compatibility only. To convert a null terminated string to
  a Pascal style string, use a string type cast or an assignment. }

function StrPas(const Str: PAnsiChar): AnsiString; overload;

{ StrAlloc allocates a buffer of the given size on the heap. The size of
  the allocated buffer is encoded in a four byte header that immediately
  preceeds the buffer. To dispose the buffer, use StrDispose. }

function AnsiStrAlloc(Size: Cardinal): PAnsiChar;

{ StrBufSize returns the allocated size of the given buffer, not including
  the two byte header. }

function StrBufSize(const Str: PAnsiChar): Cardinal; overload;

{ StrNew allocates a copy of Str on the heap. If Str is NIL, StrNew returns
  NIL and doesn't allocate any heap space. Otherwise, StrNew makes a
  duplicate of Str, obtaining space with a call to the StrAlloc function,
  and returns a pointer to the duplicated string. To dispose the string,
  use StrDispose. }

function StrNew(const Str: PAnsiChar): PAnsiChar; overload;

{ StrDispose disposes a string that was previously allocated with StrAlloc
  or StrNew. If Str is NIL, StrDispose does nothing. }

procedure StrDispose(Str: PAnsiChar); overload;

{ String formatting routines }

{ StrFmt formats the argument list given by Args using the format string
  given by Format into the buffer given by Buffer. It is up to the caller to
  ensure that Buffer is large enough for the resulting string. The returned
  value is Buffer. For further details, see the description of the Format
  function. }

function StrFmt(Buffer, Format: PAnsiChar; const Args: array of const): PAnsiChar; overload;
function StrFmt(Buffer, Format: PAnsiChar; const Args: array of const;
  const AFormatSettings: TFormatSettings): PAnsiChar; overload;

//{ StrLFmt formats the argument list given by Args using the format string
//  given by Format into the buffer given by Buffer. The resulting string will
//  contain no more than MaxBufLen characters, not including the null terminator.
//  The returned value is Buffer. For further details, see the description of
//  the Format function. }
//
function StrLFmt(Buffer: PAnsiChar; MaxBufLen: Cardinal; Format: PAnsiChar;
  const Args: array of const): PAnsiChar; overload;
function StrLFmt(Buffer: PAnsiChar; MaxBufLen: Cardinal; Format: PAnsiChar;
  const Args: array of const;
  const AFormatSettings: TFormatSettings): PAnsiChar; overload;

{ FormatBuf formats the argument list given by Args using the format string
  given by Format and FmtLen into the buffer given by Buffer and BufLen.
  The Format parameter is a reference to a buffer containing FmtLen
  characters, and the Buffer parameter is a reference to a buffer of BufLen
  characters. The returned value is the number of characters actually stored
  in Buffer. The returned value is always less than or equal to BufLen. For
  further details, see the description of the Format function. }

function FormatBuf(var Buffer; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const): Cardinal; overload;
function FormatBuf(var Buffer; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const;
  const AFormatSettings: TFormatSettings): Cardinal; overload;

//{ FloatToText converts the given floating-point value to its decimal
//  representation using the specified format, precision, and digits. The
//  Value parameter must be a variable of type Extended or Currency, as
//  indicated by the ValueType parameter. The resulting string of characters
//  is stored in the given buffer, and the returned value is the number of
//  characters stored. The resulting string is not null-terminated. For
//  further details, see the description of the FloatToStrF function. }

function FloatToText(BufferArg: PAnsiChar; const Value; ValueType: TFloatValue;
  Format: TFloatFormat; Precision, Digits: Integer): Integer; overload; inline;
function FloatToText(BufferArg: PAnsiChar; const Value; ValueType: TFloatValue;
  Format: TFloatFormat; Precision, Digits: Integer;
  const AFormatSettings: TFormatSettings): Integer; overload;

//{ FloatToTextFmt converts the given floating-point value to its decimal
//  representation using the specified format. The Value parameter must be a
//  variable of type Extended or Currency, as indicated by the ValueType
//  parameter. The resulting string of characters is stored in the given
//  buffer, and the returned value is the number of characters stored. The
//  resulting string is not null-terminated. For further details, see the
//  description of the FormatFloat function. }
//
function FloatToTextFmt(Buf: PAnsiChar; const Value; ValueType: TFloatValue;
  Format: PAnsiChar): Integer; overload; inline;
function FloatToTextFmt(Buf: PAnsiChar; const Value; ValueType: TFloatValue;
  Format: PAnsiChar; const AFormatSettings: TFormatSettings): Integer; overload;

//{ TextToFloat converts the null-terminated string given by Buffer to a
//  floating-point value which is returned in the variable given by Value.
//  The Value parameter must be a variable of type Extended or Currency, as
//  indicated by the ValueType parameter. The return value is True if the
//  conversion was successful, or False if the string is not a valid
//  floating-point value. For further details, see the description of the
//  StrToFloat function. }
//
function TextToFloat(Buffer: PAnsiChar; var Value;
  ValueType: TFloatValue): Boolean; overload; inline;
function TextToFloat(Buffer: PAnsiChar; var Value; ValueType: TFloatValue;
  const AFormatSettings: TFormatSettings): Boolean; overload;


function ByteType(const S: AnsiString; Index: Integer): TMbcsByteType; overload;

{ StrByteType works the same as ByteType, but on null-terminated PChar strings }

function StrByteType(Str: PAnsiChar; Index: Cardinal): TMbcsByteType; overload;

{ ByteToCharLen returns the character length of a MBCS string, scanning the
  string for up to MaxLen bytes.  In multibyte character sets, the number of
  characters in a string may be less than the number of bytes.  }

function ByteToCharLen(const S: AnsiString; MaxLen: Integer): Integer; overload; inline; deprecated 'Use ElementToCharLen';

function ElementToCharLen(const S: AnsiString; MaxLen: Integer): Integer; overload;

{ CharToByteLen returns the byte length of a MBCS string, scanning the string
  for up to MaxLen characters. }

function CharToByteLen(const S: AnsiString; MaxLen: Integer): Integer; overload; inline; deprecated 'Use CharToElementLen.';

function CharToElementLen(const S: AnsiString; MaxLen: Integer): Integer; overload;

{ ByteToCharIndex returns the 1-based character index of the Index'th byte in
  a MBCS string.  Returns zero if Index is out of range:
  (Index <= 0) or (Index > Length(S)) }

function ByteToCharIndex(const S: AnsiString; Index: Integer): Integer; overload; inline; deprecated 'Use ElementToCharIndex.';

function ElementToCharIndex(const S: AnsiString; Index: Integer): Integer; overload;

{ CharToByteIndex returns the 1-based byte index of the Index'th character
  in a MBCS string.  Returns zero if Index or Result are out of range:
  (Index <= 0) or (Index > Length(S)) or (Result would be > Length(S)) }

function CharToByteIndex(const S: AnsiString; Index: Integer): Integer; overload; inline; deprecated 'Use CharToElementIndex.';

function CharToElementIndex(const S: AnsiString; Index: Integer): Integer; overload;

{ StrCharLength returns the number of bytes required by the first character
  in Str.  In Windows, multibyte characters can be up to two bytes in length.
  In Linux, multibyte characters can be up to six bytes in length (UTF-8). }

function StrCharLength(const Str: PAnsiChar): Integer; overload;

{ StrNextChar returns a pointer to the first byte of the character following
  the character pointed to by Str.  }

function StrNextChar(const Str: PAnsiChar): PAnsiChar; inline; overload;


{ AnsiStrPos: Same as StrPos but supports MBCS strings }

function AnsiStrPos(Str, SubStr: PAnsiChar): PAnsiChar; overload;

{ AnsiStrRScan: Same as StrRScan but supports MBCS strings }

function AnsiStrRScan(Str: PAnsiChar; Chr: AnsiChar): PAnsiChar; overload;

{ AnsiStrScan: Same as StrScan but supports MBCS strings }

function AnsiStrScan(Str: PAnsiChar; Chr: AnsiChar): PAnsiChar; overload;


{$ENDREGION}


{$REGION 'Code From StrUtils'}

{ Basic-like functions / Left, Right, Mid }

function LeftStr(const AText: AnsiString; const ACount: Integer): AnsiString; overload;
function RightStr(const AText: AnsiString; const ACount: Integer): AnsiString; overload;
function MidStr(const AText: AnsiString; const AStart, ACount: Integer): AnsiString; overload;

{ Basic-like functions / LeftB, RightB, MidB
  these functions don't care locale information.}

function LeftBStr(const AText: AnsiString; const AByteCount: Integer): AnsiString;
function RightBStr(const AText: AnsiString; const AByteCount: Integer): AnsiString;
function MidBStr(const AText: AnsiString; const AByteStart, AByteCount: Integer): AnsiString;


{ SearchBuf is a search routine for arbitrary text buffers.  If a match is
  found, the function returns a pointer to the start of the matching
  string in the buffer.  If no match is found, the function returns nil.
  If soDown is specified, a forward search is performed otherwise the function
  searches backwards through the text.  Use SelStart and SelLength to skip
  "selected" text; this will cause the search to start before or after (soDown)
  the specified text. }

const
  { Default word delimiters are any character except the core alphanumerics. }
  WordDelimiters: set of Byte = [0..255] -
    [Ord('a')..Ord('z'), Ord('A')..Ord('Z'), Ord('1')..Ord('9'), Ord('0')];

function SearchBuf(Buf: PAnsiChar; BufLen: Integer; SelStart, SelLength: Integer;
  SearchString: AnsiString; Options: TStringSearchOptions = [soDown]): PAnsiChar; overload;

{$ENDREGION}

{ UpperCase converts all ASCII characters in the given AnsiString to upper case.
  The conversion affects only 7-bit ASCII characters between 'a' and 'z'. To
  convert 8-bit international characters, use AnsiUpperCase. }

function UpperCase(const S: AnsiString): AnsiString; overload;
function UpperCase(const S: AnsiString; LocaleOptions: TLocaleOptions): AnsiString; overload; inline;

{ LowerCase converts all ASCII characters in the given AnsiString to lower case.
  The conversion affects only 7-bit ASCII characters between 'A' and 'Z'. To
  convert 8-bit international characters, use AnsiLowerCase. }

function LowerCase(const S: AnsiString): AnsiString; overload;
function LowerCase(const S: AnsiString; LocaleOptions: TLocaleOptions): AnsiString; overload; inline;

{ CompareStr compares S1 to S2, with case-sensitivity. The return value is
  less than 0 if S1 < S2, 0 if S1 = S2, or greater than 0 if S1 > S2. The
  compare operation is based on the 8-bit ordinal value of each character
  and is not affected by the current user locale. }

function CompareStr(const S1, S2: AnsiString): Integer; overload;
function CompareStr(const S1, S2: AnsiString; LocaleOptions: TLocaleOptions): Integer; overload;

{ SameStr compares S1 to S2, with case-sensitivity. Returns true if
  S1 and S2 are the equal, that is, if CompareStr would return 0. }

function SameStr(const S1, S2: AnsiString): Boolean; overload;
function SameStr(const S1, S2: AnsiString; LocaleOptions: TLocaleOptions): Boolean; overload;

{ CompareText compares S1 to S2, without case-sensitivity. The return value
  is the same as for CompareStr. The compare operation is based on the 8-bit
  ordinal value of each character, after converting 'a'..'z' to 'A'..'Z',
  and is not affected by the current user locale. }

function CompareText(const S1, S2: AnsiString): Integer; overload;
function CompareText(const S1, S2: AnsiString; LocaleOptions: TLocaleOptions): Integer; overload;

{ SameText compares S1 to S2, without case-sensitivity. Returns true if
  S1 and S2 are the equal, that is, if CompareText would return 0. SameText
  has the same 8-bit limitations as CompareText }

function SameText(const S1, S2: AnsiString): Boolean; overload;
function SameText(const S1, S2: AnsiString; LocaleOptions: TLocaleOptions): Boolean; overload;

{ AnsiUpperCase converts all characters in the given AnsiString to upper case.
  The conversion uses the current user locale. }

function AnsiUpperCase(const S: AnsiString): AnsiString; overload;

{ AnsiLowerCase converts all characters in the given AnsiString to lower case.
  The conversion uses the current user locale. }

function AnsiLowerCase(const S: AnsiString): AnsiString; overload;

{ AnsiCompareStr compares S1 to S2, with case-sensitivity. The compare
  operation is controlled by the current user locale. The return value
  is the same as for CompareStr. }

function AnsiCompareStr(const S1, S2: AnsiString): Integer; inline; overload;

{ AnsiSameStr compares S1 to S2, with case-sensitivity. The compare
  operation is controlled by the current user locale. The return value
  is True if AnsiCompareStr would have returned 0. }

function AnsiSameStr(const S1, S2: AnsiString): Boolean; inline; overload;

{ AnsiCompareText compares S1 to S2, without case-sensitivity. The compare
  operation is controlled by the current user locale. The return value
  is the same as for CompareStr. }

function AnsiCompareText(const S1, S2: AnsiString): Integer; inline; overload;

{ AnsiSameText compares S1 to S2, without case-sensitivity. The compare
  operation is controlled by the current user locale. The return value
  is True if AnsiCompareText would have returned 0. }

function AnsiSameText(const S1, S2: AnsiString): Boolean; inline; overload;

{ AnsiLastChar returns a pointer to the last full character in the AnsiString.
  This function supports multibyte characters  }

function AnsiLastChar(const S: AnsiString): PAnsiChar; overload;

{ Trim trims leading and trailing spaces and control characters from the
  given AnsiString. }

function Trim(const S: AnsiString): AnsiString; overload;

{ TrimLeft trims leading spaces and control characters from the given
  AnsiString. }

function TrimLeft(const S: AnsiString): AnsiString; overload;

{ TrimRight trims trailing spaces and control characters from the given
  AnsiString. }

function TrimRight(const S: AnsiString): AnsiString; overload;

{ QuotedStr returns the given AnsiString as a quoted AnsiString. A single quote
  character is inserted at the beginning and the end of the AnsiString, and
  for each single quote character in the AnsiString, another one is added. }

function QuotedStr(const S: AnsiString): AnsiString; overload;

{ AnsiQuotedStr returns the given AnsiString as a quoted AnsiString, using the
  provided Quote character.  A Quote character is inserted at the beginning
  and end of the AnsiString, and each Quote character in the AnsiString is doubled.
  This function supports multibyte character AnsiStrings (MBCS). }

function AnsiQuotedStr(const S: AnsiString; Quote: AnsiChar): AnsiString; overload;

{ AnsiDequotedStr is a simplified version of AnsiExtractQuotedStr }

function AnsiDequotedStr(const S: AnsiString; AQuote: AnsiChar): AnsiString; overload;

{ CharLength returns the number of bytes required by the character starting
  at bytes S[Index].  }

function CharLength(const S: AnsiString; Index: Integer): Integer; overload;

{ NextCharIndex returns the byte index of the first byte of the character
  following the character starting at S[Index].  }

function NextCharIndex(const S: AnsiString; Index: Integer): Integer; overload;

{ AnsiCompareFileName supports DOS file name comparison idiosyncracies
  in Far East locales (Zenkaku) on Windows.
  In non-MBCS locales on Windows, AnsiCompareFileName is identical to
  AnsiCompareText (case insensitive).
  On Linux, AnsiCompareFileName is identical to AnsiCompareStr (case sensitive).
  For general purpose file name comparisions, you should use this function
  instead of AnsiCompareText. }

function AnsiCompareFileName(const S1, S2: AnsiString): Integer; inline;

function SameFileName(const S1, S2: AnsiString): Boolean; inline; overload;

{ AnsiLowerCaseFileName is identical to AnsiLowerCase. }

function AnsiLowerCaseFileName(const S: AnsiString): AnsiString; overload; deprecated 'Use AnsiLowerCase instead';

{ AnsiUpperCaseFileName is identical to AnsiUpperCase. }

function AnsiUpperCaseFileName(const S: AnsiString): AnsiString; overload; deprecated 'Use AnsiUpperCase instead';

{ AnsiPos:  Same as Pos but supports MBCS AnsiStrings }

function AnsiPos(const Substr, S: AnsiString): Integer; overload;

{ From StrUtils }

{ AnsiContainsText returns true if the subtext is found, without
  case-sensitivity, in the given text }

function ContainsText(const AText, ASubText: AnsiString): Boolean; inline; overload;
function AnsiContainsText(const AText, ASubText: AnsiString): Boolean; overload;

{ AnsiStartsText & AnsiEndText return true if the leading or trailing part
  of the given text matches, without case-sensitivity, the subtext }

function StartsText(const ASubText, AText: AnsiString): Boolean; inline; overload;
function AnsiStartsText(const ASubText, AText: AnsiString): Boolean; overload;

function EndsText(const ASubText, AText: AnsiString): Boolean; inline; overload;
function AnsiEndsText(const ASubText, AText: AnsiString): Boolean; overload;

{ AnsiReplaceText will replace all occurrences of a substring, without
  case-sensitivity, with another substring (recursion substring replacement
  is not supported) }

function ReplaceText(const AText, AFromText, AToText: AnsiString): AnsiString; inline; overload;
function AnsiReplaceText(const AText, AFromText, AToText: AnsiString): AnsiString; overload;

{ AnsiMatchText & AnsiIndexText provide case like function for dealing with
  strings }

function MatchText(const AText: AnsiString; const AValues: array of AnsiString): Boolean; overload;
function AnsiMatchText(const AText: AnsiString; const AValues: array of AnsiString): Boolean; overload;

function IndexText(const AText: AnsiString; const AValues: array of AnsiString): Integer; overload;
function AnsiIndexText(const AText: AnsiString; const AValues: array of AnsiString): Integer; overload;

{ These function are similar to some of the above but are case-sensitive }

function ContainsStr(const AText, ASubText: AnsiString): Boolean; inline; overload;
function AnsiContainsStr(const AText, ASubText: AnsiString): Boolean; overload;

function StartsStr(const ASubText, AText: AnsiString): Boolean; inline; overload;
function AnsiStartsStr(const ASubText, AText: AnsiString): Boolean; overload;

function EndsStr(const ASubText, AText: AnsiString): Boolean; inline; overload;
function AnsiEndsStr(const ASubText, AText: AnsiString): Boolean; overload;

function ReplaceStr(const AText, AFromText, AToText: AnsiString): AnsiString; inline; overload;
function AnsiReplaceStr(const AText, AFromText, AToText: AnsiString): AnsiString; overload;

function MatchStr(const AText: AnsiString; const AValues: array of AnsiString): Boolean; overload;
function AnsiMatchStr(const AText: AnsiString; const AValues: array of AnsiString): Boolean; overload;

function IndexStr(const AText: AnsiString; const AValues: array of AnsiString): Integer; overload;
function AnsiIndexStr(const AText: AnsiString; const AValues: array of AnsiString): Integer; overload;

{ DupeString will return N copies of the given AnsiString }

function DupeString(const AText: AnsiString; ACount: Integer): AnsiString; overload;

{ ReverseString simply reverses the given AnsiString }

function ReverseString(const AText: AnsiString): AnsiString; overload;
function AnsiReverseString(const AText: AnsiString): AnsiString; overload;

{ StuffString replaces a segment of a AnsiString with another one }

function StuffString(const AText: AnsiString; AStart, ALength: Cardinal;
  const ASubText: AnsiString): AnsiString; overload;

{ RandomFrom will randomly return one of the given strings }

function RandomFrom(const AValues: array of AnsiString): AnsiString; overload;

function StringReplace(const S, OldPattern, NewPattern: AnsiString;
  Flags: TReplaceFlags): AnsiString; overload;


{ ChangeFileExt changes the extension of a filename. FileName specifies a
  filename with or without an extension, and Extension specifies the new
  extension for the filename. The new extension can be a an empty AnsiString or
  a period followed by up to three characters. }

function ChangeFileExt(const FileName, Extension: AnsiString): AnsiString; overload;

{ ChangeFilePath changes the path of a filename. FileName specifies a
  filename with or without an extension, and Path specifies the new
  path for the filename. The new path is not required to contain the trailing
  path delimiter. }

function ChangeFilePath(const FileName, Path: AnsiString): AnsiString; overload;

{ ExtractFilePath extracts the drive and directory parts of the given
  filename. The resulting AnsiString is the leftmost characters of FileName,
  up to and including the colon or backslash that separates the path
  information from the name and extension. The resulting AnsiString is empty
  if FileName contains no drive and directory parts. }

function ExtractFilePath(const FileName: AnsiString): AnsiString; overload;

{ ExtractFileDir extracts the drive and directory parts of the given
  filename. The resulting AnsiString is a directory name suitable for passing
  to SetCurrentDir, CreateDir, etc. The resulting AnsiString is empty if
  FileName contains no drive and directory parts. }

function ExtractFileDir(const FileName: AnsiString): AnsiString; overload;

{ ExtractFileDrive extracts the drive part of the given filename.  For
  filenames with drive letters, the resulting AnsiString is '<drive>:'.
  For filenames with a UNC path, the resulting AnsiString is in the form
  '\\<servername>\<sharename>'.  If the given path contains neither
  style of filename, the result is an empty AnsiString. }

function ExtractFileDrive(const FileName: AnsiString): AnsiString; overload;

{ ExtractFileName extracts the name and extension parts of the given
  filename. The resulting AnsiString is the leftmost characters of FileName,
  starting with the first character after the colon or backslash that
  separates the path information from the name and extension. The resulting
  AnsiString is equal to FileName if FileName contains no drive and directory
  parts. }

function ExtractFileName(const FileName: AnsiString): AnsiString; overload;

{ ExtractFileExt extracts the extension part of the given filename. The
  resulting AnsiString includes the period character that separates the name
  and extension parts. The resulting AnsiString is empty if the given filename
  has no extension. }

function ExtractFileExt(const FileName: AnsiString): AnsiString; overload;

{ ExpandFileName expands the given filename to a fully qualified filename.
  The resulting AnsiString consists of a drive letter, a colon, a root relative
  directory path, and a filename. Embedded '.' and '..' directory references
  are removed. }

function ExpandFileName(const FileName: AnsiString): AnsiString; overload;

{ ExpandFilenameCase returns a fully qualified filename like ExpandFilename,
  but performs a case-insensitive filename search looking for a close match
  in the actual file system, differing only in uppercase versus lowercase of
  the letters.  This is useful to convert lazy user input into useable file
  names, or to convert filename data created on a case-insensitive file
  system (Win32) to something useable on a case-sensitive file system (Linux).

  The MatchFound out parameter indicates what kind of match was found in the
  file system, and what the function result is based upon:

  ( in order of increasing difficulty or complexity )
  mkExactMatch:  Case-sensitive match.  Result := ExpandFileName(FileName).
  mkSingleMatch: Exactly one file in the given directory path matches the
        given filename on a case-insensitive basis.
        Result := ExpandFileName(FileName as found in file system).
  mkAmbiguous: More than one file in the given directory path matches the
        given filename case-insensitively.
        In many cases, this should be considered an error.
        Result := ExpandFileName(First matching filename found).
  mkNone:  File not found at all.  Result := ExpandFileName(FileName).

  Note that because this function has to search the file system it may be
  much slower than ExpandFileName, particularly when the given filename is
  ambiguous or does not exist.  Use ExpandFilenameCase only when you have
  a filename of dubious orgin - such as from user input - and you want
  to make a best guess before failing.  }

type
  TFilenameCaseMatch = (mkNone, mkExactMatch, mkSingleMatch, mkAmbiguous);

function ExpandFileNameCase(const FileName: AnsiString;
  out MatchFound: TFilenameCaseMatch): AnsiString; overload;

{ ExpandUNCFileName expands the given filename to a fully qualified filename.
  This function is the same as ExpandFileName except that it will return the
  drive portion of the filename in the format '\\<servername>\<sharename> if
  that drive is actually a network resource instead of a local resource.
  Like ExpandFileName, embedded '.' and '..' directory references are
  removed. }

function ExpandUNCFileName(const FileName: AnsiString): AnsiString; overload;

{ ExtractRelativePath will return a file path name relative to the given
  BaseName.  It strips the common path dirs and adds '..\' on Windows,
  and '../' on Linux for each level up from the BaseName path. }

function ExtractRelativePath(const BaseName, DestName: AnsiString): AnsiString; overload;

{$IFDEF MSWINDOWS}
{ ExtractShortPathName will convert the given filename to the short form
  by calling the GetShortPathName API.  Will return an empty AnsiString if
  the file or directory specified does not exist }

function ExtractShortPathName(const FileName: AnsiString): AnsiString; overload;
{$ENDIF}

{ LastDelimiter returns the byte index in S of the rightmost whole
  character that matches any character in Delimiters (except null (#0)).
  S may contain multibyte characters; Delimiters must contain only single
  byte non-null characters.
  Example: LastDelimiter('\.:', 'c:\filename.ext') returns 12. }

function LastDelimiter(const Delimiters, S: AnsiString): Integer; overload;


{ IsPathDelimiter returns True if the character at byte S[Index]
  is a PathDelimiter ('\' or '/'), and it is not a MBCS lead or trail byte. }

function IsPathDelimiter(const S: AnsiString; Index: Integer): Boolean; overload;

{ IsDelimiter returns True if the character at byte S[Index] matches any
  character in the Delimiters AnsiString, and the character is not a MBCS lead or
  trail byte.  S may contain multibyte characters; Delimiters must contain
  only single byte characters. }

function IsDelimiter(const Delimiters, S: AnsiString; Index: Integer): Boolean; overload;

{ IncludeTrailingPathDelimiter returns the path with a PathDelimiter
  ('/' or '\') at the end.  This function is MBCS enabled. }

function IncludeTrailingPathDelimiter(const S: AnsiString): AnsiString; overload;

{ IncludeTrailingBackslash is the old name for IncludeTrailingPathDelimiter. }

function IncludeTrailingBackslash(const S: AnsiString): AnsiString; platform; overload; inline;

{ ExcludeTrailingPathDelimiter returns the path without a PathDelimiter
  ('\' or '/') at the end.  This function is MBCS enabled. }

function ExcludeTrailingPathDelimiter(const S: AnsiString): AnsiString; overload;

{ ExcludeTrailingBackslash is the old name for ExcludeTrailingPathDelimiter. }

function ExcludeTrailingBackslash(const S: AnsiString): AnsiString; platform; overload; inline;

function PosEx(const SubStr, S: AnsiString; Offset: Integer = 1): Integer; inline; overload;

{ String formatting routines }

{ The Format routine formats the argument list given by the Args parameter
  using the format string given by the Format parameter.

  Format strings contain two types of objects--plain characters and format
  specifiers. Plain characters are copied verbatim to the resulting string.
  Format specifiers fetch arguments from the argument list and apply
  formatting to them.

  Format specifiers have the following form:

    "%" [index ":"] ["-"] [width] ["." prec] type

  A format specifier begins with a % character. After the % come the
  following, in this order:

  -  an optional argument index specifier, [index ":"]
  -  an optional left-justification indicator, ["-"]
  -  an optional width specifier, [width]
  -  an optional precision specifier, ["." prec]
  -  the conversion type character, type

  The following conversion characters are supported:

  d  Decimal. The argument must be an integer value. The value is converted
     to a string of decimal digits. If the format string contains a precision
     specifier, it indicates that the resulting string must contain at least
     the specified number of digits; if the value has less digits, the
     resulting string is left-padded with zeros.

  u  Unsigned decimal.  Similar to 'd' but no sign is output.

  e  Scientific. The argument must be a floating-point value. The value is
     converted to a string of the form "-d.ddd...E+ddd". The resulting
     string starts with a minus sign if the number is negative, and one digit
     always precedes the decimal point. The total number of digits in the
     resulting string (including the one before the decimal point) is given
     by the precision specifer in the format string--a default precision of
     15 is assumed if no precision specifer is present. The "E" exponent
     character in the resulting string is always followed by a plus or minus
     sign and at least three digits.

  f  Fixed. The argument must be a floating-point value. The value is
     converted to a string of the form "-ddd.ddd...". The resulting string
     starts with a minus sign if the number is negative. The number of digits
     after the decimal point is given by the precision specifier in the
     format string--a default of 2 decimal digits is assumed if no precision
     specifier is present.

  g  General. The argument must be a floating-point value. The value is
     converted to the shortest possible decimal string using fixed or
     scientific format. The number of significant digits in the resulting
     string is given by the precision specifier in the format string--a
     default precision of 15 is assumed if no precision specifier is present.
     Trailing zeros are removed from the resulting string, and a decimal
     point appears only if necessary. The resulting string uses fixed point
     format if the number of digits to the left of the decimal point in the
     value is less than or equal to the specified precision, and if the
     value is greater than or equal to 0.00001. Otherwise the resulting
     string uses scientific format.

  n  Number. The argument must be a floating-point value. The value is
     converted to a string of the form "-d,ddd,ddd.ddd...". The "n" format
     corresponds to the "f" format, except that the resulting string
     contains thousand separators.

  m  Money. The argument must be a floating-point value. The value is
     converted to a string that represents a currency amount. The conversion
     is controlled by the CurrencyString, CurrencyFormat, NegCurrFormat,
     ThousandSeparator, DecimalSeparator, and CurrencyDecimals global
     variables, all of which are initialized from locale settings provided
     by the operating system.  For example, Currency Format preferences can be
     set in the International section of the Windows Control Panel. If the format
     string contains a precision specifier, it overrides the value given
     by the CurrencyDecimals global variable.

  p  Pointer. The argument must be a pointer value. The value is converted
     to a string of the form "XXXX:YYYY" where XXXX and YYYY are the
     segment and offset parts of the pointer expressed as four hexadecimal
     digits.

  s  String. The argument must be a character, a string, or a PChar value.
     The string or character is inserted in place of the format specifier.
     The precision specifier, if present in the format string, specifies the
     maximum length of the resulting string. If the argument is a string
     that is longer than this maximum, the string is truncated.

  x  Hexadecimal. The argument must be an integer value. The value is
     converted to a string of hexadecimal digits. If the format string
     contains a precision specifier, it indicates that the resulting string
     must contain at least the specified number of digits; if the value has
     less digits, the resulting string is left-padded with zeros.

  Conversion characters may be specified in upper case as well as in lower
  case--both produce the same results.

  For all floating-point formats, the actual characters used as decimal and
  thousand separators are obtained from the DecimalSeparator and
  ThousandSeparator global variables.

  Index, width, and precision specifiers can be specified directly using
  decimal digit string (for example "%10d"), or indirectly using an asterisk
  charcater (for example "%*.*f"). When using an asterisk, the next argument
  in the argument list (which must be an integer value) becomes the value
  that is actually used. For example "Format('%*.*f', [8, 2, 123.456])" is
  the same as "Format('%8.2f', [123.456])".

  A width specifier sets the minimum field width for a conversion. If the
  resulting string is shorter than the minimum field width, it is padded
  with blanks to increase the field width. The default is to right-justify
  the result by adding blanks in front of the value, but if the format
  specifier contains a left-justification indicator (a "-" character
  preceding the width specifier), the result is left-justified by adding
  blanks after the value.

  An index specifier sets the current argument list index to the specified
  value. The index of the first argument in the argument list is 0. Using
  index specifiers, it is possible to format the same argument multiple
  times. For example "Format('%d %d %0:d %d', [10, 20])" produces the string
  '10 20 10 20'.

  The Format function can be combined with other formatting functions. For
  example

    S := Format('Your total was %s on %s', [
      FormatFloat('$#,##0.00;;zero', Total),
      FormatDateTime('mm/dd/yy', Date)]);

  which uses the FormatFloat and FormatDateTime functions to customize the
  format beyond what is possible with Format.

  Each of the string formatting routines that uses global variables for
  formatting (separators, decimals, date/time formats etc.), has an
  overloaded equivalent requiring a parameter of type TFormatSettings. This
  additional parameter provides the formatting information rather than the
  global variables. For more information see the notes at TFormatSettings.  }

function Format(const Format: AnsiString;
  const Args: array of const): AnsiString; overload;
function Format(const Format: AnsiString; const Args: array of const;
  const AFormatSettings: TFormatSettings): AnsiString; overload;

{ FmtStr formats the argument list given by Args using the format string
  given by Format into the string variable given by Result. For further
  details, see the description of the Format function. }

procedure FmtStr(var Result: AnsiString; const Format: AnsiString;
  const Args: array of const); overload;
procedure FmtStr(var Result: AnsiString; const Format: AnsiString;
  const Args: array of const; const AFormatSettings: TFormatSettings); overload;

{ FormatBuf formats the argument list given by Args using the format string
  given by Format and FmtLen into the buffer given by Buffer and BufLen.
  The Format parameter is a reference to a buffer containing FmtLen
  characters, and the Buffer parameter is a reference to a buffer of BufLen
  characters. The returned value is the number of characters actually stored
  in Buffer. The returned value is always less than or equal to BufLen. For
  further details, see the description of the Format function. }

function AnsiFormatBuf(var Buffer; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const): Cardinal; overload;
function AnsiFormatBuf(var Buffer; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const;
  const AFormatSettings: TFormatSettings): Cardinal; overload;

function AnsiLeftStr(const AText: AnsiString; const ACount: Integer): AnsiString; overload;
function AnsiRightStr(const AText: AnsiString; const ACount: Integer): AnsiString; overload;
function AnsiMidStr(const AText: AnsiString; const AStart, ACount: Integer): AnsiString; overload;

implementation

{$IFDEF MACOS}
{ Mac OS/X ABI requires stack to be aligned to 16 bytes at the
  point of a function call. }
{$DEFINE ALIGN_STACK}
{$ENDIF}

uses
{$IFDEF POSIX}
  Posix.Stdlib,
  Posix.Wctype,
{$ENDIF POSIX}
{$IFDEF MACOS}
  Macapi.CoreFoundation, Posix.Dirent,
{$ENDIF MACOS}
  System.Character;

{$IFDEF PIC}
{ Do not remove export or the begin block. }
function GetGOT: Pointer; export;
begin
  asm
        MOV     Result,EBX
  end;
end;
{$ENDIF}

const
  // 1E18 as a 64-bit integer
  Const1E18Lo = $0A7640000;
  Const1E18Hi = $00DE0B6B3;
  FCon1E18: Extended = 1E18;
  DCon10: Integer = 10;

const
// 8087/SSE status word masks
  mIE = $0001;
  mDE = $0002;
  mZE = $0004;
  mOE = $0008;
  mUE = $0010;
  mPE = $0020;
{$IFDEF CPUX86}
  mC0 = $0100;
  mC1 = $0200;
  mC2 = $0400;
  mC3 = $4000;
{$ENDIF CPUX86}


{$IFDEF CPUX86}
const
// 8087 control word
// Infinity control  = 1 Affine
// Rounding Control  = 0 Round to nearest or even
// Precision Control = 3 64 bits
// All interrupts masked
  CWNear: Word = $133F;
{$ENDIF CPUX86}
{$IFDEF CPUX64}
const
//  MXCSR control word
// Rounding Control  = 0 Round to nearest or even
// All interrupts masked
  MXCSRNear: UInt32 = $1F80;
{$ENDIF CPUX64}



procedure ConvertErrorFmt(ResString: PResStringRec; const Args: array of const); local;
begin
  raise EConvertError.CreateResFmt(ResString, Args);
end;


function Format(const Format: AnsiString; const Args: array of const): AnsiString;
begin
  Result := System.AnsiStrings.Format(Format, Args, FormatSettings);
end;

function Format(const Format: AnsiString; const Args: array of const;
  const AFormatSettings: TFormatSettings): AnsiString;
begin
  FmtStr(Result, Format, Args, AFormatSettings);
end;

procedure FmtStr(var Result: AnsiString; const Format: AnsiString;
  const Args: array of const);
begin
  FmtStr(Result, Format, Args, FormatSettings);
end;

procedure FmtStr(var Result: AnsiString; const Format: AnsiString;
  const Args: array of const; const AFormatSettings: TFormatSettings);
var
  Len, BufLen: Integer;
  Buffer: array[0..4095] of AnsiChar;
begin
  BufLen := SizeOf(Buffer);
  if Length(Format) < (sizeof(Buffer) - (sizeof(Buffer) div 4)) then
    Len := AnsiFormatBuf(Buffer, sizeof(Buffer) - 1, Pointer(Format)^, Length(Format),
      Args, AFormatSettings)
  else
  begin
    BufLen := Length(Format);
    Len := BufLen;
  end;
  if Len >= BufLen - 1 then
  begin
    while Len >= BufLen - 1 do
    begin
      Inc(BufLen, BufLen);
      Result := '';          // prevent copying of existing data, for speed
      SetLength(Result, BufLen);
      Len := AnsiFormatBuf(Pointer(Result)^, BufLen - 1, Pointer(Format)^,
        Length(Format), Args, AFormatSettings);
    end;
    SetLength(Result, Len);
  end
  else
    SetString(Result, Buffer, Len);
end;


function AnsiFormatBuf(var Buffer; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const): Cardinal;
begin
  Result := AnsiFormatBuf(Buffer, BufLen, Format, FmtLen, Args, FormatSettings);
end;

function AnsiFormatBuf(var Buffer; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const;
  const AFormatSettings: TFormatSettings): Cardinal;
begin
  Result := FormatBuf(Buffer, BufLen, Format, FmtLen, Args, AFormatSettings);
end;

function StringReplace(const S, OldPattern, NewPattern: AnsiString;
  Flags: TReplaceFlags): AnsiString;
var
  SearchStr, Patt, NewStr: AnsiString;
  Offset: Integer;
begin
  if rfIgnoreCase in Flags then
  begin
    SearchStr := AnsiUpperCase(S);
    Patt := AnsiUpperCase(OldPattern);
  end else
  begin
    SearchStr := S;
    Patt := OldPattern;
  end;
  NewStr := S;
  Result := '';
  while SearchStr <> '' do
  begin
    Offset := AnsiPos(Patt, SearchStr);
    if Offset = 0 then
    begin
      Result := Result + NewStr;
      Break;
    end;
    Result := Result + Copy(NewStr, 1, Offset - 1) + NewPattern;
    NewStr := Copy(NewStr, Offset + Length(OldPattern), MaxInt);
    if not (rfReplaceAll in Flags) then
    begin
      Result := Result + NewStr;
      Break;
    end;
    SearchStr := Copy(SearchStr, Offset + Length(Patt), MaxInt);
  end;
end;

function UpperCase(const S: AnsiString): AnsiString;
{$IFDEF PUREPASCAL}
var
  L, I: Integer;
begin
  L := Length(S);
  SetLength(Result, L);
  SetCodePage(RawByteString(Result), StringCodePage(S), False);

  for I := 1 to L do
    if S[I] in ['a' .. 'z'] then
      Result[I] := AnsiChar(Byte(S[I]) - $20)
    else
      Result[I] := S[I];
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
(* ***** BEGIN LICENSE BLOCK *****
 *
 * The function UpperCase is licensed under the CodeGear license terms.
 *
 * The initial developer of the original code is Fastcode
 *
 * Portions created by the initial developer are Copyright (C) 2002-2004
 * the initial developer. All Rights Reserved.
 *
 * Contributor(s): John O'Harrow
 *
 * ***** END LICENSE BLOCK ***** *)
asm {Size = 134 Bytes}
  push    ebx
  push    edi
  push    esi
  test    eax, eax               {Test for S = NIL}
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  jz      @@Null                 {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
  test    edx, edx
  je      @@Null                 {Length(S) = 0}
  mov     ebx, edx
  movzx   ecx, word ptr [esi-12] {Set code page}
  call    system.@LStrSetLength  {Create Result AnsiString}
  mov     edi, [edi]             {@Result}
  mov     eax, [esi+ebx-4]       {Convert the Last 4 Characters of AnsiString}
  mov     ecx, eax               {4 Original Bytes}
  or      eax, $80808080         {Set High Bit of each Byte}
  mov     edx, eax               {Comments Below apply to each Byte...}
  sub     eax, $7B7B7B7B         {Set High Bit if Original <= Ord('z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('a')}
  and     eax, edx               {80h if Orig in 'a'..'z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  sub     ecx, eax               {Clear Bit 5 if Original in 'a'..'z'}
  mov     [edi+ebx-4], ecx
  sub     ebx, 1
  and     ebx, -4
  jmp     @@CheckDone
@@Null:
  pop     esi
  pop     edi
  pop     ebx
  jmp     System.@LStrClr
@@Loop:                          {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, eax               {4 Original Bytes}
  or      eax, $80808080         {Set High Bit of each Byte}
  mov     edx, eax               {Comments Below apply to each Byte...}
  sub     eax, $7B7B7B7B         {Set High Bit if Original <= Ord('z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('a')}
  and     eax, edx               {80h if Orig in 'a'..'z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  sub     ecx, eax               {Clear Bit 5 if Original in 'a'..'z'}
  mov     [edi+ebx], ecx
@@CheckDone:
  sub     ebx, 4
  jnc     @@Loop
  pop     esi
  pop     edi
  pop     ebx
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function UpperCase(const S: AnsiString; LocaleOptions: TLocaleOptions): AnsiString;
begin
  if LocaleOptions = loUserLocale then
    Result := AnsiUpperCase(S)
  else
    Result := UpperCase(S);
end;

function LowerCase(const S: AnsiString): AnsiString;
{$IFDEF PUREPASCAL}
var
  L, I: Integer;
begin
  L := Length(S);
  SetLength(Result, L);
  SetCodePage(RawByteString(Result), StringCodePage(S), False);

  for I := 1 to L do
    if S[I] in ['A' .. 'Z'] then
      Result[I] := AnsiChar(Byte(S[I]) + $20)
    else
      Result[I] := S[I];
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
(* ***** BEGIN LICENSE BLOCK *****
 *
 * The function LowerCase is licensed under the CodeGear license terms.
 *
 * The initial developer of the original code is Fastcode
 *
 * Portions created by the initial developer are Copyright (C) 2002-2004
 * the initial developer. All Rights Reserved.
 *
 * Contributor(s): John O'Harrow
 *
 * ***** END LICENSE BLOCK ***** *)
asm {Size = 134 Bytes}
  push    ebx
  push    edi
  push    esi
  test    eax, eax               {Test for S = NIL}
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  jz      @@Null                 {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
  test    edx, edx
  je      @@Null                 {Length(S) = 0}
  mov     ebx, edx
  movzx   ecx, word ptr [esi-12] {Set code page}
  call    system.@LStrSetLength  {Create Result AnsiString}
  mov     edi, [edi]             {@Result}
  mov     eax, [esi+ebx-4]       {Convert the Last 4 Characters of AnsiString}
  mov     ecx, eax               {4 Original Bytes}
  or      eax, $80808080         {Set High Bit of each Byte}
  mov     edx, eax               {Comments Below apply to each Byte...}
  sub     eax, $5B5B5B5B         {Set High Bit if Original <= Ord('Z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('A')}
  and     eax, edx               {80h if Orig in 'A'..'Z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  add     ecx, eax               {Set Bit 5 if Original in 'A'..'Z'}
  mov     [edi+ebx-4], ecx
  sub     ebx, 1
  and     ebx, -4
  jmp     @@CheckDone
@@Null:
  pop     esi
  pop     edi
  pop     ebx
  jmp     System.@LStrClr
@@Loop:                          {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, eax               {4 Original Bytes}
  or      eax, $80808080         {Set High Bit of each Byte}
  mov     edx, eax               {Comments Below apply to each Byte...}
  sub     eax, $5B5B5B5B         {Set High Bit if Original <= Ord('Z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('A')}
  and     eax, edx               {80h if Orig in 'A'..'Z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  add     ecx, eax               {Set Bit 5 if Original in 'A'..'Z'}
  mov     [edi+ebx], ecx
@@CheckDone:
  sub     ebx, 4
  jnc     @@Loop
  pop     esi
  pop     edi
  pop     ebx
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function LowerCase(const S: AnsiString; LocaleOptions: TLocaleOptions): AnsiString;
begin
  if LocaleOptions = loUserLocale then
    Result := AnsiLowerCase(S)
  else
    Result := LowerCase(S);
end;

function CompareStr(const S1, S2: AnsiString): Integer;
{$IFDEF PUREPASCAL}
var
  P1, P2: PAnsiChar;
  I: Integer;
  L1, L2: Integer;
begin
  { Length and PChar of S1 }
  L1 := Length(S1);
  P1 := PAnsiChar(S1);

  { Length and PChar of S2 }
  L2 := Length(S2);
  P2 := PAnsiChar(S2);

  { Continue the loop until the end of one string is reached. }
  I := 0;
  while (I < L1) and (I < L2) do
  begin
    if (P1^ <> P2^) then
      Exit(Ord(P1^) - Ord(P2^));

    Inc(P1);
    Inc(P2);
    Inc(I);
  end;

  { If chars were not different return the difference in length }
  Result := L1 - L2;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
(* ***** BEGIN LICENSE BLOCK *****
 *
 * The function CompareStr is licensed under the CodeGear license terms.
 *
 * The initial developer of the original code is Fastcode
 *
 * Portions created by the initial developer are Copyright (C) 2002-2007
 * the initial developer. All Rights Reserved.
 *
 * Contributor(s): Pierre le Riche
 *
 * ***** END LICENSE BLOCK ***** *)
asm
  {On entry:
     eax = @S1[1]
     edx = @S2[1]
   On exit:
     Result in eax:
       0 if S1 = S2,
       > 0 if S1 > S2,
       < 0 if S1 < S2
   Code size:
     101 bytes}
  cmp eax, edx
  je @SameAnsiString
  {Is either of the AnsiStrings perhaps nil?}
  test eax, edx
  jz @PossibleNilAnsiString
  {Compare the first four characters (there has to be a trailing #0). In random
   AnsiString compares this can save a lot of CPU time.}
@BothNonNil:
  {Compare the first character}
  movzx ecx, byte ptr [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {First character differs}
  movzx eax, byte ptr [eax]
  sub eax, ecx
  ret
@FirstCharacterSame:
  {Save ebx}
  push ebx
  {Set ebx = length(S1)}
  mov ebx, [eax - 4]
  xor ecx, ecx
  {Set ebx = length(S1) - length(S2)}
  sub ebx, [edx - 4]
  {Save the length difference on the stack}
  push ebx
  {Set ecx = 0 if length(S1) < length(S2), $ffffffff otherwise}
  adc ecx, -1
  {Set ecx = - min(length(S1), length(S2))}
  and ecx, ebx
  sub ecx, [eax - 4]
  {Adjust the pointers to be negative based}
  sub eax, ecx
  sub edx, ecx
@CompareLoop:
  mov ebx, [eax + ecx]
  xor ebx, [edx + ecx]
  jnz @Mismatch
  add ecx, 4
  js @CompareLoop
  {All characters match - return the difference in length}
@MatchUpToLength:
  pop eax
  pop ebx
  ret
@Mismatch:
  bsf ebx, ebx
  shr ebx, 3
  add ecx, ebx
  jns @MatchUpToLength
  movzx eax, byte ptr [eax + ecx]
  movzx edx, byte ptr [edx + ecx]
  sub eax, edx
  pop ebx
  pop ebx
  ret
  {It is the same AnsiString}
@SameAnsiString:
  xor eax, eax
  ret
  {Good possibility that at least one of the AnsiStrings are nil}
@PossibleNilAnsiString:
  test eax, eax
  jz @FirstAnsiStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first AnsiString length: second AnsiString is nil}
  mov eax, [eax - 4]
  ret
@FirstAnsiStringNil:
  {Return 0 - length(S2): first AnsiString is nil}
  sub eax, [edx - 4]
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function CompareStr(const S1, S2: AnsiString; LocaleOptions: TLocaleOptions): Integer;
begin
  if LocaleOptions = loUserLocale then
    Result := AnsiCompareStr(S1, S2)
  else
    Result := CompareStr(S1, S2);
end;

function CompareStrProxy(const S1, S2: AnsiString): Integer; inline;
begin
  Result := CompareStr(S1, S2);
end;

function SameStr(const S1, S2: AnsiString): Boolean;
{$IFDEF PUREPASCAL}
begin
  Result := CompareStr(S1, S2) = 0;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAligned
        CMP     EAX,EDX
        JZ      @1
        OR      EAX,EAX
        JZ      @2
        OR      EDX,EDX
        JZ      @3
        MOV     ECX,[EAX-4]
        CMP     ECX,[EDX-4]
        JNE     @3
{$IFDEF ALIGN_STACK}
        SUB     ESP,12
{$ENDIF ALIGN_STACK}
        CALL    CompareStrProxy
{$IFDEF ALIGN_STACK}
        ADD     ESP,12
{$ENDIF ALIGN_STACK}
        TEST    EAX,EAX
        JNZ     @3
@1:     MOV     AL,1
@2:     RET
@3:     XOR     EAX,EAX
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function SameStr(const S1, S2: AnsiString; LocaleOptions: TLocaleOptions): Boolean;
begin
  if LocaleOptions = loUserLocale then
    Result := AnsiSameStr(S1, S2)
  else
    Result := SameStr(S1, S2);
end;

function CompareText(const S1, S2: AnsiString): Integer;
{$IFDEF PUREPASCAL}
var
  P1, P2: PAnsiChar;
  I: Integer;
  C1, C2: AnsiChar;
  L1, L2: Integer;
begin
  { Length and PChar of S1 }
  L1 := Length(S1);
  P1 := PAnsiChar(S1);

  { Length and PChar of S2 }
  L2 := Length(S2);
  P2 := PAnsiChar(S2);

  { Continue the loop until the end of one string is reached. }
  I := 0;
  while (I < L1) and (I < L2) do
  begin
    if P1^ in ['a'..'z'] then
      C1 := AnsiChar(Byte(P1^) xor $20)
    else
      C1 := P1^;

    if P2^ in ['a'..'z'] then
      C2 := AnsiChar(Byte(P2^) xor $20)
    else
      C2 := P2^;

    if (C1 <> C2) then
      Exit(Ord(C1) - Ord(C2));

    Inc(P1);
    Inc(P2);
    Inc(I);
  end;

  { If chars were not different return the difference in length }
  Result := L1 - L2;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
(* ***** BEGIN LICENSE BLOCK *****
 *
 * The function CompareText is licensed under the CodeGear license terms.
 *
 * The initial developer of the original code is Fastcode
 *
 * Portions created by the initial developer are Copyright (C) 2002-2004
 * the initial developer. All Rights Reserved.
 *
 * Contributor(s): John O'Harrow
 *
 * ***** END LICENSE BLOCK ***** *)
asm
        TEST   EAX, EAX
        JNZ    @@CheckS2
        TEST   EDX, EDX
        JZ     @@Ret
        MOV    EAX, [EDX-4]
        NEG    EAX
@@Ret:
        RET
@@CheckS2:
        TEST   EDX, EDX
        JNZ    @@Compare
        MOV    EAX, [EAX-4]
        RET
@@Compare:
        PUSH   EBX
        PUSH   EBP
        PUSH   ESI
        MOV    EBP, [EAX-4]     // length(S1)
        MOV    EBX, [EDX-4]     // length(S2)
        SUB    EBP, EBX         // Result if All Compared Characters Match
        SBB    ECX, ECX
        AND    ECX, EBP
        ADD    ECX, EBX         // min(length(S1),length(S2)) = Compare Length
        LEA    ESI, [EAX+ECX]   // Last Compare Position in S1
        ADD    EDX, ECX         // Last Compare Position in S2
        NEG    ECX
        JZ     @@SetResult      // Exit if Smallest Length = 0
@@Loop:                         // Load Next 2 Chars from S1 and S2
                                // May Include Null Terminator}
        MOVZX  EAX, WORD PTR [ESI+ECX]
        MOVZX  EBX, WORD PTR [EDX+ECX]
        CMP    EAX, EBX
        JE     @@Next           // Next 2 Chars Match
        CMP    AL, BL
        JE     @@SecondPair     // First AnsiChar Matches
        MOV    AH, 0
        MOV    BH, 0
        CMP    AL, 'a'
        JL     @@UC1
        CMP    AL, 'z'
        JG     @@UC1
        SUB    EAX, 'a'-'A'
@@UC1:
        CMP    BL, 'a'
        JL     @@UC2
        CMP    BL, 'z'
        JG     @@UC2
        SUB    EBX, 'a'-'A'
@@UC2:
        SUB    EAX, EBX         // Compare Both Uppercase Chars
        JNE    @@Done           // Exit with Result in EAX if Not Equal
        MOVZX  EAX, WORD PTR [ESI+ECX] // Reload Same 2 Chars from S1
        MOVZX  EBX, WORD PTR [EDX+ECX] // Reload Same 2 Chars from S2
        CMP    AH, BH
        JE     @@Next           // Second AnsiChar Matches
@@SecondPair:
        SHR    EAX, 8
        SHR    EBX, 8
        CMP    AL, 'a'
        JL     @@UC3
        CMP    AL, 'z'
        JG     @@UC3
        SUB    EAX, 'a'-'A'
@@UC3:
        CMP    BL, 'a'
        JL     @@UC4
        CMP    BL, 'z'
        JG     @@UC4
        SUB    EBX, 'a'-'A'
@@UC4:
        SUB    EAX, EBX         // Compare Both Uppercase Chars
        JNE    @@Done           // Exit with Result in EAX if Not Equal
@@Next:
        ADD    ECX, 2
        JL     @@Loop           // Loop until All required Chars Compared
@@SetResult:
        MOV    EAX, EBP         // All Matched, Set Result from Lengths
@@Done:
        POP    ESI
        POP    EBP
        POP    EBX
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function CompareText(const S1, S2: AnsiString; LocaleOptions: TLocaleOptions): Integer;
begin
  if LocaleOptions = loUserLocale then
    Result := AnsiCompareText(S1, S2)
  else
    Result := CompareText(S1, S2);
end;

function CompareTextProxy(const S1, S2: AnsiString): Integer; inline;
begin
  Result := CompareText(S1, S2);
end;

function SameText(const S1, S2: AnsiString): Boolean;
{$IFDEF PUREPASCAL}
begin
  Result := CompareText(S1, S2) = 0;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAligned
        CMP     EAX,EDX
        JZ      @1
        OR      EAX,EAX
        JZ      @2
        OR      EDX,EDX
        JZ      @3
        MOV     ECX,[EAX-4]
        CMP     ECX,[EDX-4]
        JNE     @3
{$IFDEF ALIGN_STACK}
        SUB     ESP,12
{$ENDIF ALIGN_STACK}
        CALL    CompareTextProxy
{$IFDEF ALIGN_STACK}
        ADD     ESP,12
{$ENDIF ALIGN_STACK}
        TEST    EAX,EAX
        JNZ     @3
@1:     MOV     AL,1
@2:     RET
@3:     XOR     EAX,EAX
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function SameText(const S1, S2: AnsiString; LocaleOptions: TLocaleOptions): Boolean;
begin
  if LocaleOptions = loUserLocale then
    Result := AnsiSameText(S1, S2)
  else
    Result := SameText(S1, S2);
end;

function AnsiUpperCase(const S: AnsiString): AnsiString;
var
  Len: Integer;
{$IFDEF MSWINDOWS}
begin
  Len := Length(S);
  SetString(Result, PAnsiChar(S), Len);
  if Len > 0 then CharUpperBuffA(Pointer(Result), Len);
end;
{$ENDIF}
{$IFDEF POSIX}
begin
  Len := Length(S);
  SetString(Result, PAnsiChar(S), Len);
  if Len > 0 then Result := System.AnsiStrings.AnsiStrUpper(PAnsiChar(Result));
end;
{$ENDIF}

function AnsiLowerCase(const S: AnsiString): AnsiString;
var
  Len: Integer;
{$IFDEF MSWINDOWS}
begin
  Len := Length(S);
  SetString(Result, PAnsiChar(S), Len);
  if Len > 0 then CharLowerBuffA(Pointer(Result), Len);
end;
{$ENDIF}
{$IFDEF POSIX}
begin
  Len := Length(S);
  SetString(Result, PAnsiChar(S), Len);
  if Len > 0 then Result := System.AnsiStrings.AnsiStrLower(PAnsiChar(Result));
end;
{$ENDIF}

function AnsiCompareStr(const S1, S2: AnsiString): Integer;
begin
{$IFDEF MSWINDOWS}
  Result := CompareStringA(LOCALE_USER_DEFAULT, 0, PAnsiChar(S1), Length(S1),
    PAnsiChar(S2), Length(S2)) - 2;
{$ENDIF}
{$IFDEF POSIX}
  Result := System.SysUtils.AnsiCompareStr(string(S1), string(S2));
{$ENDIF POSIX}
end;

function AnsiSameStr(const S1, S2: AnsiString): Boolean;
begin
  Result := AnsiCompareStr(S1, S2) = 0;
end;

function AnsiCompareText(const S1, S2: AnsiString): Integer;
begin
{$IFDEF MSWINDOWS}
  Result := CompareStringA(LOCALE_USER_DEFAULT, NORM_IGNORECASE, PAnsiChar(S1),
    Length(S1), PAnsiChar(S2), Length(S2)) - 2;
{$ENDIF}
{$IFDEF POSIX}
  Result := System.SysUtils.AnsiCompareText(string(S1), string(S2));
{$ENDIF}
end;

function AnsiSameText(const S1, S2: AnsiString): Boolean;
begin
  Result := AnsiCompareText(S1, S2) = 0;
end;

function AnsiLastChar(const S: AnsiString): PAnsiChar;
var
  LastByte: Integer;
begin
  LastByte := Length(S);
  if LastByte <> 0 then
  begin
    while System.AnsiStrings.ByteType(S, LastByte) = mbTrailByte do Dec(LastByte);
    Result := @S[LastByte];
  end
  else
    Result := nil;
end;

function Trim(const S: AnsiString): AnsiString;
var
  I, L: Integer;
begin
  L := Length(S);
  I := 1;
  if (L > 0) and (S[I] > ' ') and (S[L] > ' ') then Exit(S);
  while (I <= L) and (S[I] <= ' ') do Inc(I);
  if I > L then Exit('');
  while S[L] <= ' ' do Dec(L);
  Result := Copy(S, I, L - I + 1);
end;

function TrimLeft(const S: AnsiString): AnsiString;
var
  I, L: Integer;
begin
  L := Length(S);
  I := 1;
  while (I <= L) and (S[I] <= ' ') do Inc(I);
  if I = 1 then Exit(S);
  Result := Copy(S, I, Maxint);
end;

function TrimRight(const S: AnsiString): AnsiString;
var
  I: Integer;
begin
  I := Length(S);
  if (I > 0) and (S[I] > ' ') then Exit(S);
  while (I > 0) and (S[I] <= ' ') do Dec(I);
  Result := Copy(S, 1, I);
end;

function QuotedStr(const S: AnsiString): AnsiString;
var
  I: Integer;
begin
  Result := S;
  for I := Length(Result) downto 1 do
    if Result[I] = '''' then Insert('''', Result, I);
  Result := '''' + Result + '''';
end;

function AnsiQuotedStr(const S: AnsiString; Quote: AnsiChar): AnsiString;
var
  P, Src, Dest: PAnsiChar;
  AddCount: Integer;
begin
  AddCount := 0;
  P := System.AnsiStrings.AnsiStrScan(PAnsiChar(S), Quote);
  while P <> nil do
  begin
    Inc(P);
    Inc(AddCount);
    P := System.AnsiStrings.AnsiStrScan(P, Quote);
  end;
  if AddCount = 0 then
  begin
    Result := Quote + S + Quote;
    Exit;
  end;
  SetLength(Result, Length(S) + AddCount + 2);
  Dest := Pointer(Result);
  Dest^ := Quote;
  Inc(Dest);
  Src := Pointer(S);
  P := System.AnsiStrings.AnsiStrScan(Src, Quote);
  repeat
    Inc(P);
    Move(Src^, Dest^, P - Src);
    Inc(Dest, P - Src);
    Dest^ := Quote;
    Inc(Dest);
    Src := P;
    P := System.AnsiStrings.AnsiStrScan(Src, Quote);
  until P = nil;
  P := System.AnsiStrings.StrEnd(Src);
  Move(Src^, Dest^, P - Src);
  Inc(Dest, P - Src);
  Dest^ := Quote;
end;

function AnsiDequotedStr(const S: AnsiString; AQuote: AnsiChar): AnsiString;
var
  LText: PAnsiChar;
begin
  LText := PAnsiChar(S);
  Result := System.Ansistrings.AnsiExtractQuotedStr(LText, AQuote);
  if ((Result = '') or (LText^ = #0)) and
     (Length(S) > 0) and ((S[1] <> AQuote) or (System.AnsiStrings.AnsiLastChar(S)^ <> AQuote)) then
    Result := S;
end;

function AdjustLineBreaks(const S: AnsiString; Style: TTextLineBreakStyle): AnsiString;
var
  Source, SourceEnd, Dest: PAnsiChar;
  DestLen: Integer;
  L: Integer;
begin
  Source := Pointer(S);
  SourceEnd := Source + Length(S);
  DestLen := Length(S);
  while Source < SourceEnd do
  begin
    case Source^ of
      #10:
        if Style = tlbsCRLF then
          Inc(DestLen);
      #13:
        if Style = tlbsCRLF then
          if Source[1] = #10 then
            Inc(Source)
          else
            Inc(DestLen)
        else
          if Source[1] = #10 then
            Dec(DestLen);
    else
      if IsLeadChar(Source^) then
      begin
        Source := System.AnsiStrings.StrNextChar(Source);
        continue;
      end;
    end;
    Inc(Source);
  end;
  if DestLen = Length(Source) then
    Result := S
  else
  begin
    Source := Pointer(S);
    SetString(Result, nil, DestLen);
    Dest := Pointer(Result);
    while Source < SourceEnd do
      case Source^ of
        #10:
          begin
            if Style = tlbsCRLF then
            begin
              Dest^ := #13;
              Inc(Dest);
            end;
            Dest^ := #10;
            Inc(Dest);
            Inc(Source);
          end;
        #13:
          begin
            if Style = tlbsCRLF then
            begin
              Dest^ := #13;
              Inc(Dest);
            end;
            Dest^ := #10;
            Inc(Dest);
            Inc(Source);
            if Source^ = #10 then Inc(Source);
          end;
      else
        if IsLeadChar(Source^) then
        begin
          L := System.AnsiStrings.StrCharLength(Source);
          Move(Source^, Dest^, L);
          Inc(Dest, L);
          Inc(Source, L);
          continue;
        end;
        Dest^ := Source^;
        Inc(Dest);
        Inc(Source);
      end;
  end;
end;

function IsValidIdent(const Ident: AnsiString; AllowDots: Boolean): Boolean;
const
  Alpha = ['A'..'Z', 'a'..'z', '_'];
  AlphaNumeric = Alpha + ['0'..'9'];
  AlphaNumericDot = AlphaNumeric + ['.'];
var
  I: Integer;
begin
  Result := False;
  if (Length(Ident) = 0) or not (Ident[1] in Alpha) then Exit;
  if AllowDots then
    for I := 2 to Length(Ident) do
      begin
        if not (Ident[I] in AlphaNumericDot) then Exit
      end
  else
    for I := 2 to Length(Ident) do if not (Ident[I] in AlphaNumeric) then Exit;
  Result := True;
end;

function CharLength(const S: AnsiString; Index: Integer): Integer;
begin
  Result := 1;
  assert((Index > 0) and (Index <= Length(S)));
  if SysLocale.FarEast and IsLeadChar(S[Index]) then
    Result := System.AnsiStrings.StrCharLength(PAnsiChar(S) + Index - 1);
end;

function NextCharIndex(const S: AnsiString; Index: Integer): Integer;
begin
  Result := Index + 1;
  assert((Index > 0) and (Index <= Length(S)));
  if SysLocale.FarEast and IsLeadChar(S[Index]) then
    Result := Index + System.AnsiStrings.StrCharLength(PAnsiChar(S) + Index - 1);
end;

function AnsiCompareFileName(const S1, S2: AnsiString): Integer;
{$IFDEF MSWINDOWS}
begin
  Result := CompareStr(AnsiLowerCase(S1), AnsiLowerCase(S2));
end;
{$ENDIF MSWINDOWS}
{$IFDEF MACOS}
begin
  Result := System.SysUtils.AnsiCompareFileName(string(S1), string(S2));
end;
{$ENDIF MACOS}
{$IFDEF LINUX}
begin
  Result := AnsiCompareStr(S1, S2);
end;
{$ENDIF LINUX}

function SameFileName(const S1, S2: AnsiString): Boolean;
begin
  Result := AnsiCompareFileName(S1, S2) = 0;
end;

function AnsiLowerCaseFileName(const S: AnsiString): AnsiString;
begin
  Result := AnsiLowerCase(S);
end;

function AnsiUpperCaseFileName(const S: AnsiString): AnsiString;
begin
  Result := AnsiUpperCase(S);
end;

function AnsiPos(const Substr, S: AnsiString): Integer;
var
  P: PAnsiChar;
begin
  Result := 0;
  P := System.AnsiStrings.AnsiStrPos(PAnsiChar(S), PAnsiChar(SubStr));
  if P <> nil then
    Result := IntPtr(P) - IntPtr(PAnsiChar(S)) + 1;
end;

function ContainsText(const AText, ASubText: AnsiString): Boolean;
begin
  Result := AnsiContainsText(AText, ASubText);
end;

function AnsiContainsText(const AText, ASubText: AnsiString): Boolean;
begin
  Result := AnsiPos(AnsiUppercase(ASubText), AnsiUppercase(AText)) > 0;
end;

function StartsText(const ASubText, AText: AnsiString): Boolean;
begin
  Result := AnsiStartsText(ASubText, AText);
end;

function AnsiStartsText(const ASubText, AText: AnsiString): Boolean;
var
{$IFDEF MSWINDOWS}
  P: PAnsiChar;
{$ENDIF}
  L, L2: Integer;
begin
{$IFDEF MSWINDOWS}
  P := PAnsiChar(AText);
{$ENDIF}
  L := Length(ASubText);
  L2 := Length(AText);
  if L > L2 then
    Result := False
  else
{$IFDEF MSWINDOWS}
    Result := CompareStringA(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
      P, L, PAnsiChar(ASubText), L) = 2;
{$ENDIF}
{$IFDEF POSIX}
    Result := AnsiSameText(ASubText, Copy(AText, 1, L));
{$ENDIF}
end;

function EndsText(const ASubText, AText: AnsiString): Boolean;
begin
  Result := AnsiEndsText(ASubText, AText);
end;

function AnsiEndsText(const ASubText, AText: AnsiString): Boolean;
var
  SubTextLocation: Integer;
begin
  SubTextLocation := Length(AText) - Length(ASubText) + 1;
  if (SubTextLocation > 0) and (ASubText <> '') and
     (System.AnsiStrings.ByteType(AText, SubTextLocation) <> mbTrailByte) then
    Result := System.AnsiStrings.AnsiStrIComp(Pointer(ASubText), PAnsiChar(@AText[SubTextLocation])) = 0
  else
    Result := False;
end;

function ReplaceStr(const AText, AFromText, AToText: AnsiString): AnsiString;
begin
  Result := AnsiReplaceStr(AText, AFromText, AToText);
end;

function AnsiReplaceStr(const AText, AFromText, AToText: AnsiString): AnsiString;
begin
  Result := StringReplace(AText, AFromText, AToText, [rfReplaceAll]);
end;

function ReplaceText(const AText, AFromText, AToText: AnsiString): AnsiString;
begin
  Result := AnsiReplaceText(AText, AFromText, AToText);
end;

function AnsiReplaceText(const AText, AFromText, AToText: AnsiString): AnsiString;
begin
  Result := StringReplace(AText, AFromText, AToText, [rfReplaceAll, rfIgnoreCase]);
end;

function MatchText(const AText: AnsiString; const AValues: array of AnsiString): Boolean;
begin
  Result := AnsiMatchText(AText, AValues);
end;

function AnsiMatchText(const AText: AnsiString; const AValues: array of AnsiString): Boolean;
begin
  Result := AnsiIndexText(AText, AValues) <> -1;
end;

function IndexText(const AText: AnsiString; const AValues: array of AnsiString): Integer;
begin
  Result := AnsiIndexText(AText, AValues);
end;

function AnsiIndexText(const AText: AnsiString; const AValues: array of AnsiString): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := Low(AValues) to High(AValues) do
    if AnsiSameText(AText, AValues[I]) then
    begin
      Result := I;
      Break;
    end;
end;

function ContainsStr(const AText, ASubText: AnsiString): Boolean;
begin
  Result := AnsiContainsStr(AText, ASubText);
end;

function AnsiContainsStr(const AText, ASubText: AnsiString): Boolean;
begin
  Result := AnsiPos(ASubText, AText) > 0;
end;

function StartsStr(const ASubText, AText: AnsiString): Boolean;
begin
  Result := AnsiStartsStr(ASubText, AText);
end;

function AnsiStartsStr(const ASubText, AText: AnsiString): Boolean;
begin
  Result := AnsiSameStr(ASubText, Copy(AText, 1, Length(ASubText)));
end;

function EndsStr(const ASubText, AText: AnsiString): Boolean;
begin
  Result := AnsiEndsStr(ASubText, AText);
end;

function AnsiEndsStr(const ASubText, AText: AnsiString): Boolean;
var
  SubTextLocation: Integer;
begin
  SubTextLocation := Length(AText) - Length(ASubText) + 1;
  if (SubTextLocation > 0) and (ASubText <> '') and
     (System.AnsiStrings.ByteType(AText, SubTextLocation) <> mbTrailByte) then
    Result := System.AnsiStrings.AnsiStrComp(Pointer(ASubText), PAnsiChar(@AText[SubTextLocation])) = 0
  else
    Result := False;
end;

function MatchStr(const AText: AnsiString; const AValues: array of AnsiString): Boolean;
begin
  Result := AnsiMatchStr(AText, AValues);
end;

function AnsiMatchStr(const AText: AnsiString; const AValues: array of AnsiString): Boolean;
begin
  Result := AnsiIndexStr(AText, AValues) <> -1;
end;

function IndexStr(const AText: AnsiString; const AValues: array of AnsiString): Integer;
begin
  Result := AnsiIndexStr(AText, AValues);
end;

function AnsiIndexStr(const AText: AnsiString; const AValues: array of AnsiString): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := Low(AValues) to High(AValues) do
    if AnsiSameStr(AText, AValues[I]) then
    begin
      Result := I;
      Break;
    end;
end;

function DupeString(const AText: AnsiString; ACount: Integer): AnsiString;
var
  P: PAnsiChar;
  C: Integer;
begin
  C := Length(AText);
  SetLength(Result, C * ACount);
  P := Pointer(Result);
  if P = nil then Exit;
  while ACount > 0 do
  begin
    Move(Pointer(AText)^, P^, C);
    Inc(P, C);
    Dec(ACount);
  end;
end;

function ReverseString(const AText: AnsiString): AnsiString;
var
  I: Integer;
  P: PAnsiChar;
begin
  SetLength(Result, Length(AText));
  P := PAnsiChar(Result);
  for I := Length(AText) downto 1 do
  begin
    P^ := AText[I];
    Inc(P);
  end;
end;

function AnsiReverseString(const AText: AnsiString): AnsiString;
var
  I: Integer;
  Len, CharByteLen: Integer;
  L, R, RR, Tail: PAnsiChar;
begin
  Len := Length(AText);
  SetLength(Result, Len);
  if AText = '' then exit;
  L := PAnsiChar(AText);
  Tail := L+Len;
  R := PAnsiChar(Result)+Len;

  while L < Tail do
  begin
    CharByteLen := 1;
    if IsLeadChar(L^) then
      CharByteLen := System.AnsiStrings.StrCharLength(L);
    RR := R - CharByteLen;
    R := RR;
    for I := 0 to CharByteLen - 1 do
    begin
      RR^ := L^;
      Inc(L);
      Inc(RR);
    end;
  end;
end;

function StuffString(const AText: AnsiString; AStart, ALength: Cardinal;
  const ASubText: AnsiString): AnsiString;
begin
  Result := Copy(AText, 1, AStart - 1) +
            ASubText +
            Copy(AText, AStart + ALength, MaxInt);
end;

function RandomFrom(const AValues: array of AnsiString): AnsiString;
begin
  Result := AValues[Random(High(AValues) + 1)];
end;

function PosEx(const SubStr, S: AnsiString; Offset: Integer = 1): Integer;
begin
  Result := System.Pos(SubStr, S, Offset);
end;

function ChangeFileExt(const FileName, Extension: AnsiString): AnsiString;
var
  I: Integer;
begin
  I := LastDelimiter(AnsiString('.' + PathDelim + DriveDelim),Filename);
  if (I = 0) or (FileName[I] <> '.') then I := MaxInt;
  Result := Copy(FileName, 1, I - 1) + Extension;
end;

function ChangeFilePath(const FileName, Path: AnsiString): AnsiString;
begin
  Result := IncludeTrailingPathDelimiter(Path) + ExtractFileName(FileName);
end;

function ExtractFilePath(const FileName: AnsiString): AnsiString;
var
  I: Integer;
begin
  I := LastDelimiter(AnsiString(PathDelim + DriveDelim), FileName);
  Result := Copy(FileName, 1, I);
end;

function ExtractFileDir(const FileName: AnsiString): AnsiString;
var
  I: Integer;
begin
  I := LastDelimiter(AnsiString(PathDelim + DriveDelim), Filename);
  if (I > 1) and (FileName[I] = PathDelim) and
    (not IsDelimiter( AnsiString(PathDelim + DriveDelim), FileName, I-1)) then 
    Dec(I);
  Result := Copy(FileName, 1, I);
end;

function ExtractFileDrive(const FileName: AnsiString): AnsiString;
{$IFDEF MSWINDOWS}
var
  I, J: Integer;
begin
  if (Length(FileName) >= 2) and (FileName[2] = DriveDelim) then
    Result := Copy(FileName, 1, 2)
  else if (Length(FileName) >= 2) and (FileName[1] = PathDelim) and
    (FileName[2] = PathDelim) then
  begin
    J := 0;
    I := 3;
    While (I < Length(FileName)) and (J < 2) do
    begin
      if FileName[I] = PathDelim then Inc(J);
      if J < 2 then Inc(I);
    end;
    if FileName[I] = PathDelim then Dec(I);
    Result := Copy(FileName, 1, I);
  end else Result := '';
end;
{$ENDIF}
{$IFDEF POSIX}
begin
  Result := '';  // Linux doesn't support drive letters
end;
{$ENDIF}

function ExtractFileName(const FileName: AnsiString): AnsiString;
var
  I: Integer;
begin
  I := LastDelimiter(AnsiString(PathDelim + DriveDelim), FileName);
  Result := Copy(FileName, I + 1, MaxInt);
end;

function ExtractFileExt(const FileName: AnsiString): AnsiString;
var
  I: Integer;
begin
  I := LastDelimiter(AnsiString('.' + PathDelim + DriveDelim), FileName);
  if (I > 0) and (FileName[I] = '.') then
    Result := Copy(FileName, I, MaxInt) else
    Result := '';
end;

function ExpandFileName(const FileName: AnsiString): AnsiString;
{$IFDEF MSWINDOWS}
var
  FName: PAnsiChar;
  Buffer: array[0..MAX_PATH - 1] of AnsiChar;
  Len: Integer;
begin
  Len := GetFullPathNameA(PAnsiChar(FileName), Length(Buffer), Buffer, FName);
  if Len <= Length(Buffer) then
    SetString(Result, Buffer, Len)
  else if Len > 0 then
  begin
    SetLength(Result, Len);
    Len := GetFullPathNameA(PAnsiChar(FileName), Len, PAnsiChar(Result), FName);
    if Len < Length(Result) then
      SetLength(Result, Len);
  end;
end;
{$ENDIF}

{$IFDEF POSIX}
function ExpandTilde(const InString: AnsiString): AnsiString;
begin
  Result := AnsiString(GetHomePath()) + Copy(InString, 2, Length(InString));
end;

var
  I, J: Integer;
  LastWasPathDelim: Boolean;
  TempName: AnsiString;
begin
  { Special case for root path. '/', '/.' and '/..' refer to the same directory - '/' }
  if (Filename = PathDelim) or (Filename = PathDelim + '.') or (Filename = PathDelim + '..') then
    Exit(PathDelim)
  else
    Result := '';

  if Length(Filename) = 0 then Exit;

  if FileName[1] = PathDelim then
    TempName := FileName
  else
  begin
    TempName := FileName;
    if FileName[1] = '~' then
      TempName := ExpandTilde(TempName)
    else
      TempName := IncludeTrailingPathDelimiter(GetCurrentDir) + TempName;
  end;

  I := 1;
  J := 1;

  LastWasPathDelim := False;

  while I <= Length(TempName) do
  begin
    case TempName[I] of
      PathDelim:
        if J < I then
        begin
          // Check for consecutive 'PathDelim' characters and skip them if present
          if (I = 1) or (TempName[I - 1] <> PathDelim) then
            Result := Result + Copy(TempName, J, I - J);
          J := I;
          // Set a flag indicating that we just processed a path delimiter
          LastWasPathDelim := True;
        end;
      '.':
        begin
          // If the last character was a path delimiter then this '.' is
          // possibly a relative path modifier
          if LastWasPathDelim then
          begin
            // Check if the path ends in a '.'
            if I < Length(TempName) then
            begin
              // If the next characters are './' then this is a relative path
              // Otherwise simply treat this as just another filename.
              if (TempName[I + 1] = '.') and
                ((I + 1 = Length(TempName)) or (TempName[I + 2] = PathDelim)) then
              begin
                // Don't attempt to backup past the Root dir
                if Length(Result) > 1 then
                  // For the purpose of this excercise, treat the last dir as a
                  // filename so we can use this function to remove it
                  Result := ExtractFilePath(ExcludeTrailingPathDelimiter(Result));
                J := I;
              end
              // Simply skip over and ignore any 'current dir' constrcucts, './'
              // or the remaining './' from a ../ constrcut.
              else if TempName[I + 1] = PathDelim then
              begin
                Result := IncludeTrailingPathDelimiter(Result);
                if IsLeadChar(TempName[I]) then
                  Inc(I, System.AnsiStrings.StrCharLength(PAnsiChar(@TempName[I])))
                else
                  Inc(I);
                J := I + 1;
              end else
                // If any of the above tests fail, then this is not a 'current dir' or
                // 'parent dir' construct so just clear the state and continue.
                LastWasPathDelim := False;
            end else
            begin
              // Don't let the expanded path end in a 'PathDelim' character
              Result := ExcludeTrailingPathDelimiter(Result);
              J := I + 1;
            end;
          end;
        end;
    else
      LastWasPathDelim := False;
    end;
    if IsLeadChar(TempName[I]) then
      Inc(I, System.AnsiStrings.StrCharLength(PAnsiChar(@TempName[I])))
    else
      Inc(I);
  end;
  // This will finally append what is left
  if (I - J > 1) then
    Result := Result + Copy(TempName, J, I - J);
end;
{$ENDIF}

function ExpandFileNameCase(const FileName: AnsiString;
  out MatchFound: TFilenameCaseMatch): AnsiString;
var
  SR: TSearchRec;
  FullPath, Name: AnsiString;
  Temp: Integer;
  FoundOne: Boolean;
{$IFDEF POSIX}
  Scans: Byte;
  FirstLetter, TestLetter: AnsiString;
{$ENDIF}
begin
  Result := ExpandFileName(FileName);
  MatchFound := mkNone;

  if FileName = '' then
    Exit;

  FullPath := ExtractFilePath(Result);
  Name := ExtractFileName(Result);


  // if FullPath is not the root directory  (portable)
  if not SameFileName(FullPath, IncludeTrailingPathDelimiter(ExtractFileDrive(FullPath))) then
  begin  // Does the path need case-sensitive work?
    Temp := FindFirst(string(ExcludeTrailingPathDelimiter(FullPath)), faAnyFile, SR);
    System.SysUtils.FindClose(SR);   // close search before going recursive
    if Temp <> 0 then
    begin
      FullPath := ExcludeTrailingPathDelimiter(FullPath);
      FullPath := ExpandFileNameCase(FullPath, MatchFound);
      if MatchFound = mkNone then
        Exit;    // if we can't find the path, we certainly can't find the file!
      FullPath := IncludeTrailingPathDelimiter(FullPath);
    end;
  end;

  // Path is validated / adjusted.  Now for the file itself
  try
    if FindFirst(string(FullPath + Name), faAnyFile, SR)= 0 then    // exact match on filename
    begin
      if not (MatchFound in [mkSingleMatch, mkAmbiguous]) then  // path might have been inexact
        MatchFound := mkExactMatch;
      Result := FullPath + AnsiString(SR.Name);
      Exit;
    end;
  finally
    System.SysUtils.FindClose(SR);
  end;

  FoundOne := False; // Windows should never get to here except for file-not-found

{$IFDEF POSIX}

{ Scan the directory.
  To minimize the number of filenames tested, scan the directory
  using upper/lowercase first letter + wildcard.
  This results in two scans of the directory (particularly on Linux) but
  vastly reduces the number of times we have to perform an expensive
  locale-charset case-insensitive AnsiString compare.  }

  // First, scan for lowercase first letter
  FirstLetter := AnsiLowerCase(Name[1]);
  for Scans := 0 to 1 do
  begin
    Temp := FindFirst(FullPath + FirstLetter + '*', faAnyFile, SR);
    while Temp = 0 do
    begin
      if AnsiSameText(SR.Name, Name) then
      begin
        if FoundOne then
        begin  // this is the second match
          MatchFound := mkAmbiguous;
          Exit;
        end
        else
        begin
          FoundOne := True;
          Result := FullPath + SR.Name;
        end;
      end;
      Temp := FindNext(SR);
    end;
    FindClose(SR);
    TestLetter := AnsiUpperCase(Name[1]);
    if TestLetter = FirstLetter then Break;
    FirstLetter := TestLetter;
  end;
{$ENDIF}

  if MatchFound <> mkAmbiguous then
  begin
    if FoundOne then
      MatchFound := mkSingleMatch
    else
      MatchFound := mkNone;
  end;
end;

{$IFDEF MSWINDOWS}
function GetUniversalName(const FileName: AnsiString): AnsiString;
type
  PNetResourceArray = ^TNetResourceArrayA;
  TNetResourceArrayA = array[0..MaxInt div SizeOf(TNetResource) - 1] of TNetResourceA;
var
  I, BufSize, NetResult: Integer;
  Count, Size: LongWord;
  Drive: AnsiChar;
  NetHandle: THandle;
  NetResources: PNetResourceArray;
  RemoteNameInfo: array[0..1023] of Byte;
begin
  Result := FileName;
  if (Win32Platform <> VER_PLATFORM_WIN32_WINDOWS) or (Win32MajorVersion > 4) then
  begin
    Size := SizeOf(RemoteNameInfo);
    if WNetGetUniversalNameA(PAnsiChar(FileName), UNIVERSAL_NAME_INFO_LEVEL,
      @RemoteNameInfo, Size) <> NO_ERROR then Exit;
    Result := AnsiString(string(PRemoteNameInfo(@RemoteNameInfo).lpUniversalName));
  end else
  begin
  { The following works around a bug in WNetGetUniversalName under Windows 95 }
    Drive := UpCase(FileName[1]);
    if (Drive < 'A') or (Drive > 'Z') or (Length(FileName) < 3) or
      (FileName[2] <> ':') or (FileName[3] <> '\') then
      Exit;
    if WNetOpenEnum(RESOURCE_CONNECTED, RESOURCETYPE_DISK, 0, nil,
      NetHandle) <> NO_ERROR then Exit;
    try
      BufSize := 50 * SizeOf(TNetResource);
      GetMem(NetResources, BufSize);
      try
        while True do
        begin
          Count := $FFFFFFFF;
          Size := BufSize;
          NetResult := WNetEnumResourceA(NetHandle, Count, NetResources, Size);
          if NetResult = ERROR_MORE_DATA then
          begin
            BufSize := Size;
            ReallocMem(NetResources, BufSize);
            Continue;
          end;
          if NetResult <> NO_ERROR then Exit;
          for I := 0 to Count - 1 do
            with NetResources^[I] do
              if (lpLocalName <> nil) and (Drive = UpCase(lpLocalName[0])) then
              begin
                Result := lpRemoteName + Copy(FileName, 3, Length(FileName) - 2);
                Exit;
              end;
        end;
      finally
        FreeMem(NetResources, BufSize);
      end;
    finally
      WNetCloseEnum(NetHandle);
    end;
  end;
end;

function ExpandUNCFileName(const FileName: AnsiString): AnsiString;
begin
  { First get the local resource version of the file name }
  Result := ExpandFileName(FileName);
  if (Length(Result) >= 3) and (Result[2] = ':') and (Upcase(Result[1]) >= 'A')
    and (Upcase(Result[1]) <= 'Z') then
    Result := GetUniversalName(Result);
end;
{$ENDIF}

{$IFDEF POSIX}
function ExpandUNCFileName(const FileName: AnsiString): AnsiString;
begin
  Result := ExpandFileName(FileName);
end;
{$ENDIF}

function ExtractRelativePath(const BaseName, DestName: AnsiString): AnsiString;
var
  BasePath, DestPath: AnsiString;
  BaseLead, DestLead: PAnsiChar;
  BasePtr, DestPtr: PAnsiChar;

  function ExtractFilePathNoDrive(const FileName: AnsiString): AnsiString;
  begin
    Result := ExtractFilePath(FileName);
    Delete(Result, 1, Length(ExtractFileDrive(FileName)));
  end;

  function Next(var Lead: PAnsiChar): PAnsiChar;
  begin
    Result := Lead;
    if Result = nil then Exit;
    Lead := System.AnsiStrings.AnsiStrScan(Lead, PathDelim);
    if Lead <> nil then
    begin
      Lead^ := #0;
      Inc(Lead);
    end;
  end;

begin
  if SameFilename(ExtractFileDrive(BaseName), ExtractFileDrive(DestName)) then
  begin
    BasePath := ExtractFilePathNoDrive(BaseName);
    UniqueString(BasePath);
    DestPath := ExtractFilePathNoDrive(DestName);
    UniqueString(DestPath);
    BaseLead := Pointer(BasePath);
    BasePtr := Next(BaseLead);
    DestLead := Pointer(DestPath);
    DestPtr := Next(DestLead);
    while (BasePtr <> nil) and (DestPtr <> nil) and SameFilename(BasePtr, DestPtr) do
    begin
      BasePtr := Next(BaseLead);
      DestPtr := Next(DestLead);
    end;
    Result := '';
    while BaseLead <> nil do
    begin
      Result := Result + '..' + PathDelim;             { Do not localize }
      Next(BaseLead);
    end;
    if (DestPtr <> nil) and (DestPtr^ <> #0) then
      Result := Result + DestPtr + PathDelim;
    if DestLead <> nil then
      Result := Result + DestLead;     // destlead already has a trailing backslash
    Result := Result + ExtractFileName(DestName);
  end
  else
    Result := DestName;
end;

{$IFDEF MSWINDOWS}
function ExtractShortPathName(const FileName: AnsiString): AnsiString;
var
  Buffer: array[0..MAX_PATH - 1] of AnsiChar;
  Len: Integer;
begin
  Len := GetShortPathNameA(PAnsiChar(FileName), Buffer, Length(Buffer));
  if Len <= Length(Buffer) then
    SetString(Result, Buffer, Len)
  else
    if Len > 0 then
    begin
      SetLength(Result, Len);
      Len := GetShortPathNameA(PAnsiChar(FileName), PAnsiChar(Result), Len);
      if Len < Length(Result) then
        SetLength(Result, Len);
    end;
end;
{$ENDIF}

function LastDelimiter(const Delimiters, S: AnsiString): Integer;
var
  P: PAnsiChar;
begin
  Result := Length(S);
  P := PAnsiChar(Delimiters);
  while Result > 0 do
  begin
    if (S[Result] <> #0) and (System.AnsiStrings.StrScan(P, S[Result]) <> nil) then
      if (System.AnsiStrings.ByteType(S, Result) = mbTrailByte) then
        Dec(Result)
      else
        Exit;
    Dec(Result);
  end;
end;

function IsPathDelimiter(const S: AnsiString; Index: Integer): Boolean;
begin
  Result := (Index > 0) and (Index <= Length(S)) and (S[Index] = PathDelim)
    and (System.AnsiStrings.ByteType(S, Index) = mbSingleByte);
end;

function IsDelimiter(const Delimiters, S: AnsiString; Index: Integer): Boolean;
begin
  Result := False;
  if (Index <= 0) or (Index > Length(S)) or (System.AnsiStrings.ByteType(S, Index) <> mbSingleByte) then exit;
  Result := System.AnsiStrings.StrScan(PAnsiChar(Delimiters), S[Index]) <> nil;
end;

function IncludeTrailingBackslash(const S: AnsiString): AnsiString;
begin
  Result := IncludeTrailingPathDelimiter(S);
end;

function IncludeTrailingPathDelimiter(const S: AnsiString): AnsiString;
begin
  Result := S;
  if not IsPathDelimiter(Result, Length(Result)) then
    Result := Result + PathDelim;
end;

function ExcludeTrailingBackslash(const S: AnsiString): AnsiString;
begin
  Result := ExcludeTrailingPathDelimiter(S);
end;

function ExcludeTrailingPathDelimiter(const S: AnsiString): AnsiString;
begin
  Result := S;
  if IsPathDelimiter(Result, Length(Result)) then
    SetLength(Result, Length(Result)-1);
end;

function AnsiCountElems(const AText: AnsiString; AStartIndex, ACharCount: Integer): Integer;
var
  S, P: PAnsiChar;
  Len, CharLen: Integer;
begin
  Result := 0;
  if AStartIndex <= 0 then
    AStartIndex := 1;
  Len := Length(AText);
  if (Len > 0) and (AStartIndex <= Len) then
  begin
    P := PAnsiChar(AText) + AStartIndex - 1;
    S := P;
    while (Len > 0) and (ACharCount > 0) do
    begin
      CharLen := 1;
      if IsLeadChar(P^) then
        CharLen := System.AnsiStrings.StrCharLength(P);
      if CharLen > Len then
        CharLen := Len;
      Inc(P, CharLen);
      Dec(Len, CharLen);
      Dec(ACharCount);
    end;
    Result := P - S;
  end;
end;

function AnsiCountChars(const AText: AnsiString): Integer;
var
  Len, CharLen: Integer;
  P: PAnsiChar;
begin
  Result := 0;
  Len := Length(AText);
  if Len > 0 then
  begin
    P := PAnsiChar(AText);
    while Len > 0 do
    begin
      CharLen := 1;
      if IsLeadChar(P^) then
        CharLen := System.AnsiStrings.StrCharLength(P);
      if CharLen > Len then
        CharLen := Len;
      Inc(P, CharLen);
      Dec(Len, CharLen);
      Inc(Result);
    end;
  end;
end;

function AnsiLeftStr(const AText: AnsiString; const ACount: Integer): AnsiString;
var
  Count: Integer;
begin
  Result := '';
  if (ACount > 0) and (Length(AText) > 0) then
  begin
    Count := AnsiCountElems(AText, 1, ACount);
    Result := Copy(AText, 1, Count);
  end;
end;

function AnsiRightStr(const AText: AnsiString; const ACount: Integer): AnsiString;
var
  CharCount: Integer;
begin
  Result := '';
  CharCount := AnsiCountChars(AText);
  if CharCount > 0 then
    Result := AnsiMidStr(AText, CharCount - ACount + 1, ACount);
end;

function AnsiMidStr(const AText: AnsiString; const AStart, ACount: Integer): AnsiString;
var
  Len, Start, Count: Integer;
begin
  Result := '';
  if ACount > 0 then
  begin
    Len := Length(AText);
    if Len > 0 then
    begin
      Start := 1;
      if AStart > 0 then
        Start := AnsiCountElems(AText, 1, AStart - 1) + 1;
      if Len >= Start then
      begin
        Count := AnsiCountElems(AText, Start, ACount);
        Result := Copy(AText, Start, Count);
      end;
    end;
  end;
end;

{$REGION 'Code From SysUtils'}

function NewStr(const S: AnsiString): PAnsiString;
begin
  if S = '' then Result := NullAnsiStr else
  begin
    New(Result);
    Result^ := S;
  end;
end;

procedure DisposeStr(P: PAnsiString);
begin
  if (P <> nil) and (P^ <> '') then Dispose(P);
end;

procedure AssignStr(var P: PAnsiString; const S: AnsiString);
var
  Temp: PAnsiString;
begin
  Temp := P;
  P := NewStr(S);
  DisposeStr(Temp);
end;

procedure AppendStr(var Dest: AnsiString; const S: AnsiString);
begin
  Dest := Dest + S;
end;

function AnsiStrComp(S1, S2: PAnsiChar): Integer;
{$IFDEF MSWINDOWS}
begin
  Result := CompareStringA(LOCALE_USER_DEFAULT, 0, S1, -1, S2, -1) - CSTR_EQUAL;
end;
{$ENDIF}
{$IFDEF POSIX}
begin
  Result := strcoll_l(PAnsiChar(UTF8String(S1)), PAnsiChar(UTF8String(S2)), UTF8CompareLocale);
end;
{$ENDIF}

function AnsiStrIComp(S1, S2: PAnsiChar): Integer;
{$IFDEF MSWINDOWS}
begin
  Result := CompareStringA(LOCALE_USER_DEFAULT, NORM_IGNORECASE, S1, -1,
    S2, -1) - CSTR_EQUAL;
end;
{$ENDIF}
{$IFDEF POSIX}
begin
  Result := AnsiCompareText(string(S1), string(S2));
end;
{$ENDIF}

// StrLenLimit:  Scan Src for a null terminator up to MaxLen bytes
function StrLenLimit(Src: PAnsiChar; MaxLen: Cardinal): Cardinal; overload;
begin
  if Src = nil then
  begin
    Result := 0;
    Exit;
  end;
  Result := MaxLen;
  while (Src^ <> #0) and (Result > 0) do
  begin
    Inc(Src);
    Dec(Result);
  end;
  Result := MaxLen - Result;
end;

{ StrBufLimit: Return a pointer to a buffer that contains no more than MaxLen
  bytes of Src, avoiding heap allocation if possible.
  If clipped Src length is less than MaxLen, return Src.  Allocated = False.
  If clipped Src length is less than StaticBufLen, return StaticBuf with a
    copy of Src.  Allocated = False.
  Otherwise, return a heap allocated buffer with a copy of Src.  Allocated = True.
}
function StrBufLimit(Src: PAnsiChar; MaxLen: Cardinal; StaticBuf: PAnsiChar;
  StaticBufLen: Cardinal): PAnsiChar; overload;
var
  Len: Cardinal;
begin
  Len := StrLenLimit(Src, MaxLen);
  if Len < MaxLen then
    Result := Src
  else
  begin
    if Len < StaticBufLen then
      Result := StaticBuf
    else
    begin
      GetMem(Result, Len+1);
    end;
    Move(Src^, Result^, Len);
    Result[Len] := #0;
  end;
end;

function InternalAnsiStrLComp(S1, S2: PAnsiChar; MaxLen: Cardinal; CaseSensitive: Boolean): Integer; overload;
var
  Buf1, Buf2: array [0..4095] of AnsiChar;
  P1, P2: PAnsiChar;
begin
  // glibc has no length-limited strcoll!
  P1 := nil;
  P2 := nil;
  try
    P1 := StrBufLimit(S1, MaxLen, Buf1, High(Buf1));
    P2 := StrBufLimit(S2, MaxLen, Buf2, High(Buf2));
    if CaseSensitive then
      Result := System.AnsiStrings.AnsiStrComp(P1, P2)
    else
      Result := System.AnsiStrings.AnsiStrIComp(P1, P2);
  finally
    if P1 <> @Buf1 then
      FreeMem(P1);
    if P2 <> @Buf2 then
      FreeMem(P2);
  end;
end;

function AnsiStrLComp(S1, S2: PAnsiChar; MaxLen: Cardinal): Integer;
begin
{$IFDEF MSWINDOWS}
  Result := CompareStringA(LOCALE_USER_DEFAULT, 0,
    S1, MaxLen, S2, MaxLen) - CSTR_EQUAL;
{$ENDIF}
{$IFDEF POSIX}
  Result := InternalAnsiStrLComp(S1, S2, MaxLen, True);
{$ENDIF}
end;

function AnsiStrLIComp(S1, S2: PAnsiChar; MaxLen: Cardinal): Integer;
begin
{$IFDEF MSWINDOWS}
  Result := CompareStringA(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
    S1, MaxLen, S2, MaxLen) - CSTR_EQUAL;
{$ENDIF}
{$IFDEF POSIX}
  Result := InternalAnsiStrLComp(S1, S2, MaxLen, False);
{$ENDIF}
end;

function AnsiStrLower(Str: PAnsiChar): PAnsiChar;
{$IFDEF MSWINDOWS}
begin
  Result := CharLowerA(Str);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  Temp: string;
  Squish: AnsiString;
  I: Integer;
begin
  Temp := string(Str);     // expand and copy multibyte to widechar
  for I := 1 to Length(Temp) do
    Temp[I] := WideChar(towlower(UCS4Char(Temp[I])));
  Squish := AnsiString(Temp);  // reduce and copy widechar to multibyte

  if Cardinal(Length(Squish)) > StrLen(Str) then
    raise ERangeError.CreateRes(@SRangeError);

  Move(Squish[1], Str^, Length(Squish));
  Result := Str;
end;
{$ENDIF POSIX}

function AnsiStrUpper(Str: PAnsiChar): PAnsiChar;
{$IFDEF MSWINDOWS}
begin
  Result := CharUpperA(Str);
end;
{$ENDIF}
{$IFDEF POSIX}
var
  Temp: string;
  Squish: AnsiString;
  I: Integer;
begin
  Temp := string(Str);    // expand and copy multibyte to widechar
  for I := Low(string) to High(Temp) do
    Temp[I] := WideChar(towupper(UCS4Char(Temp[I])));
  Squish := AnsiString(Temp);  // reduce and copy widechar to multibyte
  if Cardinal(Length(Squish)) > StrLen(Str) then
    raise ERangeError.CreateRes(@SRangeError);

  Move(Squish[Low(string)], Str^, Length(Squish));
  Result := Str;
end;
{$ENDIF POSIX}

function AnsiStrLastChar(P: PAnsiChar): PAnsiChar;
var
  LastByte: Integer;
begin
  LastByte := System.AnsiStrings.StrLen(P) - 1;
  Result := @P[LastByte];
{$IFDEF MSWINDOWS}
  if System.AnsiStrings.StrByteType(P, LastByte) = mbTrailByte then Dec(Result);
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  while System.AnsiStrings.StrByteType(P, Result - P) = mbTrailByte do Dec(Result);
{$ENDIF POSIX}
end;

function AnsiExtractQuotedStr(var Src: PAnsiChar; Quote: AnsiChar): AnsiString;
var
  P, Dest: PAnsiChar;
  DropCount: Integer;
  EndSuffix: Integer;
begin
  Result := '';
  if (Src = nil) or (Src^ <> Quote) then Exit;
  Inc(Src);
  DropCount := 1;
  P := Src;
  Src := System.AnsiStrings.AnsiStrScan(Src, Quote);
  while Src <> nil do   // count adjacent pairs of quote chars
  begin
    Inc(Src);
    if Src^ <> Quote then Break;
    Inc(Src);
    Inc(DropCount);
    Src := System.AnsiStrings.AnsiStrScan(Src, Quote);
  end;
  EndSuffix := Ord(Src = nil); // Has an ending quoatation mark?
  if Src = nil then Src := System.AnsiStrings.StrEnd(P);
  if ((Src - P) <= 1 - EndSuffix) or ((Src - P - DropCount) = EndSuffix) then Exit;
  if DropCount = 1 then
    SetString(Result, P, Src - P - 1 + EndSuffix)
  else
  begin
    SetLength(Result, Src - P - DropCount + EndSuffix);
    Dest := PAnsiChar(Result);
    Src := System.AnsiStrings.AnsiStrScan(P, Quote);
    while Src <> nil do
    begin
      Inc(Src);
      if Src^ <> Quote then Break;
      Move(P^, Dest^, Src - P);
      Inc(Dest, Src - P);
      Inc(Src);
      P := Src;
      Src := System.AnsiStrings.AnsiStrScan(Src, Quote);
    end;
    if Src = nil then Src := System.AnsiStrings.StrEnd(P);
    Move(P^, Dest^, Src - P - 1 + EndSuffix);
  end;
end;

{ PChar routines }

function StrLen(const Str: PAnsiChar): Cardinal;
{$IFNDEF LEGACYSTRLEN}
begin
  Result := Length(Str);
end;
{$ELSE !LEGACYSTRLEN}
{$IFDEF X86ASM}
(* ***** BEGIN LICENSE BLOCK *****
 *
 * The function StrLen is licensed under the CodeGear license terms.
 *
 * The initial developer of the original code is Fastcode
 *
 * Portions created by the initial developer are Copyright (C) 2002-2007
 * the initial developer. All Rights Reserved.
 *
 * Contributor(s): Pierre le Riche
 *
 * ***** END LICENSE BLOCK ***** *)
asm //StackAlignSafe
        {Check the first byte}
        CMP BYTE PTR [EAX], 0
        JE @ZeroLength
        {Get the negative of the string start in edx}
        MOV EDX, EAX
        NEG EDX
        {Word align}
        ADD EAX, 1
        AND EAX, -2
@ScanLoop:
        MOV CX, [EAX]
        ADD EAX, 2
        TEST CL, CH
        JNZ @ScanLoop
        TEST CL, CL
        JZ @ReturnLess2
        TEST CH, CH
        JNZ @ScanLoop
        LEA EAX, [EAX + EDX - 1]
        RET
@ReturnLess2:
        LEA EAX, [EAX + EDX - 2]
        RET
@ZeroLength:
        XOR EAX, EAX
end;
{$ENDIF X86ASM}
{$ENDIF !LEGACYSTRLEN}

function StrEnd(const Str: PAnsiChar): PAnsiChar;
{$IFDEF PUREPASCAL}
begin
  Result := Str;
  while Result^ <> #0 do
    Inc(Result);
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAlignSafe
        {Check the first byte}
        CMP BYTE PTR [EAX], 0
        JE @ZeroLength
        INC EAX
@ScanLoop:
        MOV CL, BYTE PTR [EAX]
        INC EAX
        TEST CL, CL
        JNZ @ScanLoop
        DEC EAX
        RET
@ZeroLength:
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function StrMove(Dest: PAnsiChar; const Source: PAnsiChar; Count: Cardinal): PAnsiChar;
begin
  Result := Dest;
  Move(Source^, Dest^, Count * SizeOf(AnsiChar));
end;

function StrCopy(Dest: PAnsiChar; const Source: PAnsiChar): PAnsiChar;
{$IFDEF PUREPASCAL}
begin
  Move(Source^, Dest^, (System.AnsiStrings.StrLen(Source) + 1) * SizeOf(AnsiChar));
  Result := Dest;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
(* ***** BEGIN LICENSE BLOCK *****
 *
 * The function StrCopy is licensed under the CodeGear license terms.
 *
 * The initial developer of the original code is Fastcode
 *
 * Portions created by the initial developer are Copyright (C) 2002-2004
 * the initial developer. All Rights Reserved.
 *
 * Contributor(s): Aleksandr Sharahov
 *
 * ***** END LICENSE BLOCK ***** *)
asm //StackAlignSafe
        SUB   EDX, EAX
        TEST  EAX, 1
        PUSH  EAX
        JZ    @loop
        MOVZX ECX, BYTE PTR[EAX+EDX]
        MOV   [EAX], CL
        TEST  ECX, ECX
        JZ    @RET
        INC   EAX
@loop:
        MOVZX ECX, BYTE PTR[EAX+EDX]
        TEST  ECX, ECX
        JZ    @move0
        MOVZX ECX, WORD PTR[EAX+EDX]
        MOV   [EAX], CX
        ADD   EAX, 2
        CMP   ECX, 255
        JA    @loop
@ret:
        POP   EAX
        RET
@move0:
        MOV   [EAX], CL
        POP   EAX
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function StrECopy(Dest: PAnsiChar; const Source: PAnsiChar): PAnsiChar;
{$IFDEF PUREPASCAL}
var
  Len: Integer;
begin
  Len := System.AnsiStrings.StrLen(Source);
  Move(Source^, Dest^, (Len + 1) * SizeOf(AnsiChar));
  Result := Dest + Len;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAlignSafe
        PUSH    EDI
        PUSH    ESI
        MOV     ESI, EAX
        MOV     EDI, EDX
        MOV     ECX, 0FFFFFFFFH
        XOR     AL, AL
        REPNE   SCASB
        NOT     ECX
        MOV     EDI, ESI
        MOV     ESI, EDX
        MOV     EDX, ECX
        SHR     ECX, 2
        REP     MOVSD
        MOV     ECX, EDX
        AND     ECX, 3
        REP     MOVSB
        LEA     EAX, [EDI-1]
        POP     ESI
        POP     EDI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function StrLCopy(Dest: PAnsiChar; const Source: PAnsiChar; MaxLen: Cardinal): PAnsiChar;
{$IFDEF PUREPASCAL}
var
  Len: Cardinal;
begin
  Result := Dest;
  Len := System.AnsiStrings.StrLen(Source);
  if Len > MaxLen then
    Len := MaxLen;
  Move(Source^, Dest^, Len * SizeOf(AnsiChar));
  Dest[Len] := #0;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAlignSafe
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     ESI, EAX
        MOV     EDI, EDX
        MOV     EBX, ECX
        XOR     AL, AL
        TEST    ECX, ECX
        JZ      @@1
        REPNE   SCASB
        JNE     @@1
        INC     ECX
@@1:    SUB     EBX, ECX
        MOV     EDI, ESI
        MOV     ESI, EDX
        MOV     EDX, EDI
        MOV     ECX, EBX
        SHR     ECX, 2
        REP     MOVSD
        MOV     ECX, EBX
        AND     ECX, 3
        REP     MOVSB
        STOSB
        MOV     EAX, EDX
        POP     EBX
        POP     ESI
        POP     EDI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function StrPCopy(Dest: PAnsiChar; const Source: AnsiString): PAnsiChar;
begin
  Result := System.AnsiStrings.StrLCopy(Dest, PAnsiChar(Source), Length(Source));
end;

function StrPLCopy(Dest: PAnsiChar; const Source: AnsiString; MaxLen: Cardinal): PAnsiChar;
begin
  Result := System.AnsiStrings.StrLCopy(Dest, PAnsiChar(Source), MaxLen);
end;

function StrCat(Dest: PAnsiChar; const Source: PAnsiChar): PAnsiChar;
begin
  System.AnsiStrings.StrCopy(System.AnsiStrings.StrEnd(Dest), Source);
  Result := Dest;
end;

function StrLCat(Dest: PAnsiChar; const Source: PAnsiChar; MaxLen: Cardinal): PAnsiChar;
{$IFDEF PUREPASCAL}
var
  DestLen: Cardinal;
begin
  Result := Dest;
  DestLen := System.AnsiStrings.StrLen(Dest);
  if DestLen < MaxLen then
    System.AnsiStrings.StrLCopy(PAnsiChar(@Dest[DestLen]), Source, MaxLen - DestLen);
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAligned
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     EDI,Dest
        MOV     ESI,Source
        MOV     EBX,MaxLen
        CALL    System.AnsiStrings.StrEnd
        MOV     ECX,EDI
        ADD     ECX,EBX
        SUB     ECX,EAX
        JBE     @@1
        MOV     EDX,ESI
        CALL    system.AnsiStrings.StrLCopy
@@1:    MOV     EAX,EDI
        POP     EBX
        POP     ESI
        POP     EDI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function StrComp(const Str1, Str2: PAnsiChar): Integer;
{$IFDEF PUREPASCAL}
var
  P1, P2: PAnsiChar;
begin
  P1 := Str1;
  P2 := Str2;
  while True do
  begin
    if (P1^ <> P2^) or (P1^ = #0) then
      Exit(Ord(P1^) - Ord(P2^));
    Inc(P1);
    Inc(P2);
  end;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
(* ***** BEGIN LICENSE BLOCK *****
 *
 * The function StrComp is licensed under the CodeGear license terms.
 *
 * The initial developer of the original code is Fastcode
 *
 * Portions created by the initial developer are Copyright (C) 2002-2004
 * the initial developer. All Rights Reserved.
 *
 * Contributor(s): Aleksandr Sharahov
 *
 * ***** END LICENSE BLOCK ***** *)
asm //StackAlignSafe
        SUB   EDX, EAX
        JNZ   @next
        XOR   EAX, EAX
        JMP   @ret
@next:
        MOVZX ECX, [EAX+EDX]
        CMP   CL, [EAX]
        JNE   @stop
        TEST  CL, CL
        JZ    @stop
        MOVZX ECX, [EAX+EDX+1]
        CMP   CL, [EAX+1]
        JNE   @stop1
        TEST  CL, CL
        JZ    @stop1
        MOVZX ECX, [EAX+EDX+2]
        CMP   CL, [EAX+2]
        JNE   @stop2
        TEST  CL, CL
        JZ    @stop2
        MOVZX ECX, [EAX+EDX+3]
        CMP   CL, [EAX+3]
        JNE   @stop3
        ADD   EAX, 4
        TEST  CL, CL
        JZ    @stop4
        MOVZX ECX, [EAX+EDX]
        CMP   CL, [EAX]
        JNE   @stop
        TEST  CL, CL
        JZ    @stop
        MOVZX ECX, [EAX+EDX+1]
        CMP   CL, [EAX+1]
        JNE   @stop1
        TEST  CL, CL
        JZ    @stop1
        MOVZX ECX, [EAX+EDX+2]
        CMP   CL, [EAX+2]
        JNE   @stop2
        TEST  CL, CL
        JZ    @stop2
        MOVZX ECX, [EAX+EDX+3]
        CMP   CL, [EAX+3]
        JNE   @stop3
        ADD   EAX, 4
        TEST  CL, CL
        JNZ   @next
@stop4:
        SUB   EAX, 4
@stop3:
        ADD   EAX, 1
@stop2:
        ADD   EAX, 1
@stop1:
        ADD   EAX, 1
@stop:
        MOVZX EAX, [EAX]
        SUB   EAX, ECX
@ret:
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function StrIComp(const Str1, Str2: PAnsiChar): Integer;
{$IFDEF PUREPASCAL}
var
  P1, P2: PAnsiChar;
  C1, C2: AnsiChar;
begin
  P1 := Str1;
  P2 := Str2;
  while True do
  begin
    if P1^ in ['a'..'z'] then
      C1 := AnsiChar(Byte(P1^) xor $20)
    else
      C1 := P1^;

    if P2^ in ['a'..'z'] then
      C2 := AnsiChar(Byte(P2^) xor $20)
    else
      C2 := P2^;

    if (C1 <> C2) or (C1 = #0) then
      Exit(Ord(C1) - Ord(C2));
    Inc(P1);
    Inc(P2);
  end;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAlignSafe
        PUSH    EDI
        PUSH    ESI
        MOV     EDI,EDX
        MOV     ESI,EAX
        MOV     ECX,0FFFFFFFFH
        XOR     EAX,EAX
        REPNE   SCASB
        NOT     ECX
        MOV     EDI,EDX
        XOR     EDX,EDX
@@1:    REPE    CMPSB
        JE      @@4
        MOV     AL,[ESI-1]
        CMP     AL,'a'
        JB      @@2
        CMP     AL,'z'
        JA      @@2
        SUB     AL,20H
@@2:    MOV     DL,[EDI-1]
        CMP     DL,'a'
        JB      @@3
        CMP     DL,'z'
        JA      @@3
        SUB     DL,20H
@@3:    SUB     EAX,EDX
        JE      @@1
@@4:    POP     ESI
        POP     EDI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function StrLComp(const Str1, Str2: PAnsiChar; MaxLen: Cardinal): Integer;
{$IFDEF PUREPASCAL}
var
  I: Cardinal;
  P1, P2: PAnsiChar;
begin
  P1 := Str1;
  P2 := Str2;
  I := 0;
  while I < MaxLen do
  begin
    if (P1^ <> P2^) or (P1^ = #0) then
      Exit(Ord(P1^) - Ord(P2^));

    Inc(P1);
    Inc(P2);
    Inc(I);
  end;
  Result := 0;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAlignSafe
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     EDI, EDX
        MOV     ESI, EAX
        MOV     EBX, ECX
        XOR     EAX, EAX
        OR      ECX, ECX
        JE      @@1
        REPNE   SCASB
        SUB     EBX, ECX
        MOV     ECX, EBX
        MOV     EDI, EDX
        XOR     EDX, EDX
        REPE    CMPSB
        MOV     AL, [ESI-1]
        MOV     DL, [EDI-1]
        SUB     EAX, EDX
@@1:    POP     EBX
        POP     ESI
        POP     EDI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function StrLIComp(const Str1, Str2: PAnsiChar; MaxLen: Cardinal): Integer;
{$IFDEF PUREPASCAL}
var
  P1, P2: PAnsiChar;
  I: Cardinal;
  C1, C2: AnsiChar;
begin
  P1 := Str1;
  P2 := Str2;
  I := 0;
  while I < MaxLen do
  begin
    if P1^ in ['a'..'z'] then
      C1 := AnsiChar(Byte(P1^) xor $20)
    else
      C1 := P1^;

    if P2^ in ['a'..'z'] then
      C2 := AnsiChar(Byte(P2^) xor $20)
    else
      C2 := P2^;

    if (C1 <> C2) or (C1 = #0) then
      Exit(Ord(C1) - Ord(C2));

    Inc(P1);
    Inc(P2);
    Inc(I);
  end;
  Result := 0;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAlignSafe
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     EDI, EDX
        MOV     ESI, EAX
        MOV     EBX, ECX
        XOR     EAX, EAX
        OR      ECX, ECX
        JE      @@4
        REPNE   SCASB
        SUB     EBX, ECX
        MOV     ECX, EBX
        MOV     EDI, EDX
        XOR     EDX, EDX
@@1:    REPE    CMPSB
        JE      @@4
        MOV     AL, [ESI-1]
        CMP     AL, 'a'
        JB      @@2
        CMP     AL, 'z'
        JA      @@2
        SUB     AL, 20H
@@2:    MOV     DL, [EDI-1]
        CMP     DL, 'a'
        JB      @@3
        CMP     DL, 'z'
        JA      @@3
        SUB     DL, 20H
@@3:    SUB     EAX, EDX
        JE      @@1
@@4:    POP     EBX
        POP     ESI
        POP     EDI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function StrScan(const Str: PAnsiChar; Chr: AnsiChar): PAnsiChar;
begin
  Result := Str;
  while Result^ <> #0 do
  begin
    if Result^ = Chr then
      Exit;
    Inc(Result);
  end;
  if Chr <> #0 then
    Result := nil;
end;

function StrRScan(const Str: PAnsiChar; Chr: AnsiChar): PAnsiChar;
var
  MostRecentFound: PAnsiChar;
begin
  if Chr = AnsiChar(#0) then
    Result := System.AnsiStrings.StrEnd(Str)
  else
  begin
    Result := nil;

    MostRecentFound := Str;
    while True do
    begin
      while MostRecentFound^ <> Chr do
      begin
        if MostRecentFound^ = AnsiChar(#0) then
          Exit;
        Inc(MostRecentFound);
      end;
      Result := MostRecentFound;
      Inc(MostRecentFound);
    end;
  end;
end;

function TextPos(Str, SubStr: PAnsiChar): PAnsiChar;
var
  LowerStr, LowerSubStr: PAnsiChar;
begin
  LowerSubStr := nil;
  LowerStr := System.AnsiStrings.StrLower(System.AnsiStrings.StrNew(Str));
  try
    LowerSubStr := System.AnsiStrings.StrLower(System.AnsiStrings.StrNew(SubStr));
    Result := System.AnsiStrings.StrPos(LowerStr, LowerSubStr);
    if Result <> nil then
      Result := PAnsiChar(PByte(Str) + (PByte(Result) - PByte(LowerStr)));
  finally
    System.AnsiStrings.StrDispose(LowerSubStr);
    System.AnsiStrings.StrDispose(LowerStr);
  end;
end;

function StrPos(const Str1, Str2: PAnsiChar): PAnsiChar;
{$IFDEF PUREPASCAL}
var
  MatchStart, LStr1, LStr2: PAnsiChar;
begin
  Result := nil;
  if (Str1^ = #0) or (Str2^ = #0) then
    Exit;

  MatchStart := Str1;
  while MatchStart^<> #0 do
  begin
    if MatchStart^ = Str2^ then
    begin
      LStr1 := MatchStart+1;
      LStr2 := Str2+1;
      while True do
      begin
        if LStr2^ = #0 then
          Exit(MatchStart);
        if (LStr1^ <> LStr2^) or (LStr1^ = #0) then
          Break;
        Inc(LStr1);
        Inc(LStr2);
      end;
    end;
    Inc(MatchStart);
  end;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        OR      EAX, EAX
        JE      @@2
        OR      EDX, EDX
        JE      @@2
        MOV     EBX, EAX
        MOV     EDI, EDX
        XOR     AL, AL
        MOV     ECX, 0FFFFFFFFH
        REPNE   SCASB
        NOT     ECX
        DEC     ECX
        JE      @@2
        MOV     ESI, ECX
        MOV     EDI, EBX
        MOV     ECX, 0FFFFFFFFH
        REPNE   SCASB
        NOT     ECX
        SUB     ECX, ESI
        JBE     @@2
        MOV     EDI, EBX
        LEA     EBX, [ESI-1]
@@1:    MOV     ESI, EDX
        LODSB
        REPNE   SCASB
        JNE     @@2
        MOV     EAX, ECX
        PUSH    EDI
        MOV     ECX, EBX
        REPE    CMPSB
        POP     EDI
        MOV     ECX, EAX
        JNE     @@1
        LEA     EAX, [EDI-1]
        JMP     @@3
@@2:    XOR     EAX, EAX
@@3:    POP     EBX
        POP     ESI
        POP     EDI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function StrUpper(Str: PAnsiChar): PAnsiChar;
{$IFDEF PUREPASCAL}
begin
  Result := Str;
  while Str^ <> #0 do
  begin
    if Str^ in ['a'..'z'] then
      Dec(Str^, $20);
    Inc(Str);
  end;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAlignSafe
        PUSH    ESI
        MOV     ESI, Str
        MOV     EDX, Str
@@1:    LODSB
        OR      AL, AL
        JE      @@2
        CMP     AL, 'a'
        JB      @@1
        CMP     AL, 'z'
        JA      @@1
        SUB     AL, 20H
        MOV     [ESI-1], AL
        JMP     @@1
@@2:    XCHG    EAX, EDX
        POP     ESI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function StrLower(Str: PAnsiChar): PAnsiChar;
{$IFDEF PUREPASCAL}
begin
  Result := Str;
  while Str^ <> #0 do
  begin
    if Str^ in ['A'..'Z'] then
      Inc(Str^, $20);
    Inc(Str);
  end;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAlignSafe
        PUSH    ESI
        MOV     ESI, Str
        MOV     EDX, Str
@@1:    LODSB
        OR      AL, AL
        JE      @@2
        CMP     AL, 'A'
        JB      @@1
        CMP     AL, 'Z'
        JA      @@1
        ADD     AL, 20H
        MOV     [ESI-1], AL
        JMP     @@1
@@2:    XCHG    EAX, EDX
        POP     ESI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function StrPas(const Str: PAnsiChar): AnsiString;
begin
  Result := Str;
end;

function AnsiStrAlloc(Size: Cardinal): PAnsiChar;
begin
  Inc(Size, SizeOf(Cardinal));
  GetMem(Result, Size);
  Cardinal(Pointer(Result)^) := Size;
  Inc(Result, SizeOf(Cardinal));
end;

function StrBufSize(const Str: PAnsiChar): Cardinal;
var
  P: PAnsiChar;
begin
  P := Str;
  Dec(P, SizeOf(Cardinal));
  Result := Cardinal(Pointer(P)^) - SizeOf(Cardinal);
end;

function StrNew(const Str: PAnsiChar): PAnsiChar;
var
  Size: Cardinal;
begin
  if Str = nil then Result := nil else
  begin
    Size := System.AnsiStrings.StrLen(Str) + 1;
    Result := System.AnsiStrings.StrMove(AnsiStrAlloc(Size), Str, Size);
  end;
end;

procedure StrDispose(Str: PAnsiChar);
begin
  if Str <> nil then
  begin
    Dec(Str, SizeOf(Cardinal));
    FreeMem(Str, Cardinal(Pointer(Str)^));
  end;
end;

procedure FormatError(ErrorCode: Integer; Format: PChar; FmtLen: Cardinal);
const
  FormatErrorStrs: array[0..1] of PResStringRec = (
    @SInvalidFormat, @SArgumentMissing);
var
  Buffer: array[0..31] of Char;
begin
  if FmtLen > 31 then FmtLen := 31;
                                                                            
  if StrByteType(Format, FmtLen-1) = mbLeadByte then Dec(FmtLen);
  StrMove(Buffer, Format, FmtLen);
  Buffer[FmtLen] := #0;
  ConvertErrorFmt(FormatErrorStrs[ErrorCode], [PChar(@Buffer)]);
end;

procedure AnsiFormatError(ErrorCode: Integer; Format: PAnsiChar; FmtLen: Cardinal);
var
  FormatText: string;
begin
  FormatText := UTF8ToUnicodeString(Format);
  FormatError(ErrorCode, PChar(FormatText), FmtLen);
end;

procedure FormatVarToStr(var S: AnsiString; const V: TVarData);
begin
  if Assigned(System.VarToLStrProc) then
    System.VarToLStrProc(S, V)
  else
    System.Error(reVarInvalidOp);
end;

procedure FormatClearStr(var S: AnsiString);
begin
  S := '';
end;

function FormatBuf(var Buffer; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const): Cardinal;
begin
  Result := System.AnsiStrings.FormatBuf(Buffer, BufLen, Format, FmtLen, Args, FormatSettings);
end;

function StrFmt(Buffer, Format: PAnsiChar; const Args: array of const): PAnsiChar;
begin
  Result := System.AnsiStrings.StrFmt(Buffer, Format, Args, FormatSettings);
end;

function StrFmt(Buffer, Format: PAnsiChar; const Args: array of const;
  const AFormatSettings: TFormatSettings): PAnsiChar;
begin
  if (Buffer <> nil) and (Format <> nil) then
  begin
    Buffer[System.AnsiStrings.FormatBuf(Buffer^, MaxInt, Format^, System.AnsiStrings.StrLen(Format), Args,
      AFormatSettings)] := AnsiChar(#0);
    Result := Buffer;
  end
  else
    Result := nil;
end;

function StrLFmt(Buffer: PAnsiChar; MaxBufLen: Cardinal; Format: PAnsiChar;
  const Args: array of const): PAnsiChar;
begin
  Result := System.AnsiStrings.StrLFmt(Buffer, MaxBufLen, Format, Args, FormatSettings);
end;

function StrLFmt(Buffer: PAnsiChar; MaxBufLen: Cardinal; Format: PAnsiChar;
  const Args: array of const; const AFormatSettings: TFormatSettings): PAnsiChar;
begin
  if (Buffer <> nil) and (Format <> nil) then
  begin
    Buffer[System.AnsiStrings.FormatBuf(Buffer^, MaxBufLen, Format^, System.AnsiStrings.StrLen(Format), Args,
      AFormatSettings)] := AnsiChar(#0);
    Result := Buffer;
  end
  else
    Result := nil;
end;

function AnsiFloatToTextEx(BufferArg: PAnsiChar; const Value; ValueType: TFloatValue;
  Format: TFloatFormat; Precision, Digits: Integer;
  const AFormatSettings: TFormatSettings): Integer;
begin
  Result := System.AnsiStrings.FloatToText(BufferArg, Value, ValueType, Format, Precision, Digits,
    AFormatSettings);
end;



{$IFDEF X86ASM}
procedure PutExponent;
// Store exponent
// In   AL  = Exponent character ('E' or 'e')
//      AH  = Positive sign character ('+' or 0)
//      BL  = Zero indicator
//      BH  = Destination buffer type: 0=Ansi, 1=Unicode
//      ECX = Minimum number of digits (0..4)
//      EDX = Exponent
//      EDI = Destination buffer
asm //StackAlignSafe - internal method can be called unaligned
        PUSH    ESI
{$IFDEF PIC}
        PUSH    EAX
        PUSH    ECX
        CALL    GetGOT
        MOV     ESI,EAX
        POP     ECX
        POP     EAX
{$ELSE !PIC}
        XOR     ESI,ESI
{$ENDIF !PIC}
        STOSB
        CMP     BH,0
        JE      @@a
        XOR     AL,AL
        STOSB
@@a:    OR      BL,BL
        JNE     @@0
        XOR     EDX,EDX
        JMP     @@1
@@0:    OR      EDX,EDX
        JGE     @@1
        MOV     AL,'-'
        NEG     EDX
        JMP     @@2
@@1:    OR      AH,AH
        JE      @@3
        MOV     AL,AH
@@2:    STOSB
        CMP     BH,0
        JE      @@3
        XOR     AL,AL
        STOSB
@@3:    XCHG    EAX,EDX
        PUSH    EAX
        PUSH    EBX
        MOV     EBX,ESP
        SUB     EBX,8
        PUSH    EBX
@@4:    XOR     EDX,EDX
        DIV     [ESI].DCon10
        ADD     DL,'0'
        MOV     [EBX],DL
        INC     EBX
        DEC     ECX
        OR      EAX,EAX
        JNE     @@4
        OR      ECX,ECX
        JG      @@4
        POP     EDX
        POP     ECX
@@5:    DEC     EBX
        MOV     AL,[EBX]
        STOSB
        CMP     CH,0
        JE      @@6
        XOR     AL,AL
        STOSB
@@6:    CMP     EBX,EDX
        JNE     @@5
        POP     EAX
        POP     ESI
end;
{$ENDIF X86ASM}

{ $IFDEF PUREPASCAL}
function InternalFloatToText(
  ABuffer: PByte;
  ABufferIsUnicode: Boolean;
  const AValue;
  AValueType: TFloatValue;
  AFormat: TFloatFormat;
  APrecision, ADigits: Integer;
  const AFormatSettings: TFormatSettings): Integer;
const
  CMinExtPrecision = 2;
{$IFDEF EXTENDEDIS10BYTES}
  CMaxExtPrecision = 18;
{$ELSE !EXTENDEDIS10BYTES}
  CMaxExtPrecision = 17;
{$ENDIF EXTENDEDIS10BYTES}

  CCurrPrecision = 19;
  CGenExpDigits = 9999;

  CExpChar = 'E';          // DO NOT LOCALIZE
  CMinusSign: Char = '-';  // DO NOT LOCALIZE
  CPlusSign: Char = '+';   // DO NOT LOCALIZE
  CZero: Char = '0';       // DO NOT LOCALIZE
  CSpecial: array[0 .. 1] of string = ('INF', 'NAN'); // DO NOT LOCALIZE
  CCurrencyFormats: array[0 .. 3] of string = ('$*@@@', '*$@@@', '$ *@@', '* $@@'); // DO NOT LOCALIZE
  CNegCurrencyFormats: array[0 .. 15] of string =
  (
    '($*)@', '-$*@@', '$-*@@', '$*-@@', '(*$)@', '-*$@@', // DO NOT LOCALIZE
    '*-$@@', '*$-@@', '-* $@', '-$ *@', '* $-@', // DO NOT LOCALIZE
    '$ *-@', '$ -*@', '*- $@', '($ *)', '(* $)' // DO NOT LOCALIZE
  );

var
  FloatRec: TFloatRec;

  LDigits: Integer;
  LExponent: Cardinal;
  LUseENotation: Boolean;

  LCurrentFormat: string;
  //LCurrChar: Char;
  ICurrChar: integer;
  LFloatRecDigit: Integer;
  LNextThousand: Integer;

  procedure AppendChar(const AChar: Char);
  begin
    if ABufferIsUnicode then
    begin
      PChar(ABuffer)^ := AChar;
      Inc(ABuffer, SizeOf(Char));
    end else
    begin
      PByte(ABuffer)^ := Byte(AChar);
      Inc(ABuffer, SizeOf(Byte));
    end;

    Inc(Result);
  end;

  procedure AppendString(const AStr: String);
  var
    I, L: Integer;
  begin
    L := Astr.Length;

    if L > 0 then
    begin
      if ABufferIsUnicode then
      begin
        { Unicode -- move directly }
        MoveChars(AStr[Low(string)], ABuffer^, L);
        Inc(ABuffer, L * SizeOf(Char));
      end else
      begin
        { ANSI -- loop }
        for I := Low(string) to High(AStr) do
        begin
          PByte(ABuffer)^ := Byte(AStr[I]);
          Inc(ABuffer, SizeOf(Byte));
        end;
      end;

      Inc(Result, L);
    end;
  end;

  function GetDigit: Byte;
  begin
    Result := FloatRec.Digits[LFloatRecDigit];

    if Result = Ord(#0) then
      Result := Ord('0')
    else
      Inc(LFloatRecDigit);
  end;

  procedure FormatNumber;
  var
    K: Integer;
  begin
    if ADigits > CMaxExtPrecision then
      LDigits := CMaxExtPrecision
    else
      LDigits := ADigits;

    K := FloatRec.Exponent;
    if K > 0 then
    begin
      { Find the position of the next thousand separator }
      LNextThousand := 0;
      if AFormat <> ffFixed then
        LNextThousand := ((K - 1) mod 3) + 1;

      repeat
        { Append the next digit }
        AppendChar(Char(GetDigit));

        { Update loop counters }
        Dec(K);
        Dec(LNextThousand);

        { Try to append the thousands separator and reset the counter }
        if (LNextThousand = 0) and (K > 0) then
        begin
          LNextThousand := 3;

          if AFormatSettings.ThousandSeparator <> #0 then
            AppendChar(AFormatSettings.ThousandSeparator);
        end;
      until (K = 0);

    end else
      AppendChar(CZero);

    { If there are ADigits left to fill }
    if LDigits <> 0 then
    begin
      { Put in the decimal separator if it was specified }
      if AFormatSettings.DecimalSeparator <> #0 then
        AppendChar(AFormatSettings.DecimalSeparator);

      { If there is  negative exponent }
      if K < 0 then
      begin
        { Fill with zeroes until the exponent or ADigits are exhausted}
        repeat
          AppendChar(CZero);

          Inc(K);
          Dec(LDigits);
        until (K = 0) or (LDigits = 0);
      end;

      if LDigits > 0 then
      begin
        { Exponent was filled, there are still ADigits left to fill }
        repeat
          AppendChar(Char(GetDigit));
          Dec(LDigits);
        until (LDigits <= 0);
      end;
    end;
  end;

  procedure FormatExponent;
  var
    LMinCnt, LExponent: Integer;
    LExpString: string;
    LDigitCnt: Integer;
  begin
    { Adjust digit count }
    if ADigits > 4 then
      LMinCnt := 0
    else
      LMinCnt := ADigits;

    { Get exponent }
    LExponent := FloatRec.Exponent - 1;

    { Place the E character into position }
    AppendChar(CExpChar);

    if Byte(FloatRec.Digits[0]) <> Ord(#0) then
    begin
      if LExponent < 0 then
      begin
        LExponent := -LExponent;
        AppendChar(CMinusSign);
      end
      else
      begin
        if AFormat <> ffGeneral then
          AppendChar(CPlusSign);
      end;
    end else
    begin
      if AFormat <> ffGeneral then
        AppendChar(CPlusSign);
      LExponent := 0;
    end;

    LExpString := IntToStr(LExponent);
    LDigitCnt := LExpString.Length;

    while LDigitCnt < LMinCnt do
    begin
      AppendChar(CZero);
      Inc(LDigitCnt);
    end;

    AppendString(LExpString);
  end;

begin
  LFloatRecDigit := 0;
  Result := 0;

  if AValueType = fvExtended then
  begin
    { Check min and max precisions for an Extended }
    if APrecision < CMinExtPrecision then
      APrecision := CMinExtPrecision
    else if APrecision > CMaxExtPrecision then
      APrecision := CMaxExtPrecision;
  end else
    APrecision := CCurrPrecision;

  { Check the number of ADigits to use }
  if AFormat in [ffGeneral, ffExponent] then
    LDigits := CGenExpDigits
  else
    LDigits := ADigits;

  { Decode the float }
  FloatToDecimal(FloatRec, AValue, AValueType, APrecision, LDigits);
{$IFDEF EXTENDEDIS10BYTES}
  LExponent := UInt16(FloatRec.Exponent) - $7FFF;
{$ELSE !EXTENDEDIS10BYTES}
  LExponent := UInt16(Int16(FloatRec.Exponent) - $7FF);
{$ENDIF EXTENDEDIS10BYTES}

  { Check for INF or NAN}
  if LExponent < 2 then
  begin
    { Append the sign to output buffer }
    if FloatRec.Negative then
      AppendChar(CMinusSign);

    AppendString(CSpecial[LExponent]);
    Exit;
  end;

  if (not (AFormat in [ffGeneral .. ffCurrency])) or
    ((FloatRec.Exponent > APrecision) and (AFormat <> ffExponent)) then
    AFormat := ffGeneral;

  case AFormat of
    ffGeneral:
    begin
      { Append the sign to output buffer }
      if FloatRec.Negative then
        AppendChar(CMinusSign);

      LUseENotation := False;

      { Obtain digit count and whether to use the E notation }
      LDigits := FloatRec.Exponent;
      if (LDigits > APrecision) or (LDigits < -3) then
      begin
        LDigits := 1;
        LUseENotation := True;
      end;

      if LDigits > 0 then
      begin
        { Append the ADigits that precede decimal separator }
        while LDigits > 0 do
        begin
          AppendChar(Char(GetDigit));
          Dec(LDigits);
        end;

        { Append the decimal separator and the following digit }
        if FloatRec.Digits[LFloatRecDigit] <> Ord(#0) then
        begin
          AppendChar(AFormatSettings.DecimalSeparator);

          { Append the ADigits that come after the decimal separator }
          while FloatRec.Digits[LFloatRecDigit] <> Ord(#0) do
            AppendChar(Char(GetDigit));
        end;

        if LUseENotation then
          FormatExponent();
      end else
      begin
        AppendChar(CZero);

        if FloatRec.Digits[0] <> Ord(#0) then
        begin
          AppendChar(AFormatSettings.DecimalSeparator);
          LDigits := -LDigits;

          { Append zeroes to fulfill the exponent }
          while LDigits > 0 do
          begin
            AppendChar(CZero);
            Dec(LDigits);
          end;

          { Attach all the other ADigits now }
          while FloatRec.Digits[LFloatRecDigit] <> Ord(#0) do
            AppendChar(Char(GetDigit));
        end;
      end;
    end;

    ffExponent:
    begin
      { Append the sign to output buffer }
      if FloatRec.Negative then
        AppendChar(CMinusSign);

      { Append the first digit and the decimal separator }
      AppendChar(Char(GetDigit));
      AppendChar(AFormatSettings.DecimalSeparator);

      { Append ADigits based on the APrecision requirements }
      Dec(APrecision);
      repeat
        AppendChar(Char(GetDigit));
        Dec(APrecision);
      until (APrecision = 0);

      FormatExponent();
    end;

    ffNumber, ffFixed:
    begin
      { Append the sign to output buffer }
      if FloatRec.Negative then
        AppendChar(CMinusSign);

      FormatNumber();
    end;

    ffCurrency:
    begin
      { Select the appropriate currency AFormat}
      if FloatRec.Negative then
      begin
        {  negative AFormat is used, check for bounds and select }
        if AFormatSettings.NegCurrFormat > High(CNegCurrencyFormats) then
          LCurrentFormat := CNegCurrencyFormats[High(CNegCurrencyFormats)]
        else
          LCurrentFormat := CNegCurrencyFormats[AFormatSettings.NegCurrFormat];
      end else
      begin
        {  positive AFormat is used, check for bounds and select }
        if AFormatSettings.CurrencyFormat > High(CCurrencyFormats) then
          LCurrentFormat := CCurrencyFormats[High(CCurrencyFormats)]
        else
          LCurrentFormat := CCurrencyFormats[AFormatSettings.CurrencyFormat];
      end;

      { Iterate over each charater in the AFormat string }
//      for LCurrChar in LCurrentFormat do
//        case LCurrChar of
      for ICurrChar := Low(string) to High(LCurrentFormat) do
        case LCurrentFormat[ICurrChar] of
          '@': break;
          '$':
            if AFormatSettings.CurrencyString <> EmptyStr then
              AppendString(AFormatSettings.CurrencyString);
          '*': FormatNumber();
          else
             //AppendChar(LCurrChar);
             AppendChar(LCurrentFormat[ICurrChar]);
        end;
    end;
  end;
end;
{ $ENDIF PUREPASCAL}


function FloatToText(BufferArg: PAnsiChar; const Value; ValueType: TFloatValue;
  Format: TFloatFormat; Precision, Digits: Integer): Integer;
begin
  Result := System.AnsiStrings.FloatToText(BufferArg, Value, ValueType, Format, Precision,
    Digits, FormatSettings);
end;

function FloatToText(BufferArg: PAnsiChar; const Value; ValueType: TFloatValue;
  Format: TFloatFormat; Precision, Digits: Integer;
  const AFormatSettings: TFormatSettings): Integer;
{$IFDEF PUREPASCAL}
begin
  { Call internal helper. Specify that we're using an ANSI buffer }
  Result := InternalFloatToText(PByte(BufferArg), False, Value, ValueType, Format, Precision, Digits, AFormatSettings);
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
var
  Buffer: Pointer;
  FloatRec: TFloatRec;
  SaveGOT: Integer;
  DecimalSep: AnsiChar;
  ThousandSep: AnsiChar;
  CurrencyStr: Pointer;
  CurrFmt: Byte;
  NegCurrFmt: Byte;
  AnsiCurrencyStr: AnsiString;
asm //StackAligned
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     Buffer,EAX
{$IFDEF PIC}
        PUSH    ECX
        CALL    GetGOT
        MOV     SaveGOT,EAX
        POP     ECX
{$ELSE !PIC}
        MOV     SaveGOT,0
{$ENDIF !PIC}
{$IFDEF ALIGN_STACK}
        SUB     ESP,4
{$ENDIF ALIGN_STACK}
        PUSH    ECX
        PUSH    EDX
{$IFDEF PIC}                                    // Double indirect using GOT
        MOV     ECX, [EAX].DefaultSystemCodePage
        MOV     ECX, [ECX]
{$ELSE !PIC}
        MOV     ECX, DefaultSystemCodePage
{$ENDIF}
        LEA     EAX,AnsiCurrencyStr
        MOV     EDX,AFormatSettings
        MOV     EDX,[EDX].TFormatSettings.CurrencyString
        CALL    System.@LStrFromUStr
        MOV     EAX,AnsiCurrencyStr
        MOV     CurrencyStr,EAX
        POP     EDX
        POP     ECX
        MOV     EAX,AFormatSettings
        MOV     AL,AnsiChar([EAX].TFormatSettings.DecimalSeparator)
        MOV     DecimalSep,AL
        MOV     EAX,AFormatSettings
        MOV     AL,AnsiChar([EAX].TFormatSettings.ThousandSeparator)
        MOV     ThousandSep,AL
        MOV     EAX,AFormatSettings
        MOV     AL,[EAX].TFormatSettings.CurrencyFormat
        MOV     CurrFmt,AL
        MOV     EAX,AFormatSettings
        MOV     AL,[EAX].TFormatSettings.NegCurrFormat
        MOV     NegCurrFmt,AL

        MOV     EAX,19
        CMP     CL,fvExtended
        JNE     @@2
        MOV     EAX,Precision
        CMP     EAX,2
        JGE     @@1
        MOV     EAX,2
@@1:    CMP     EAX,18
        JLE     @@2
        MOV     EAX,18
@@2:    MOV     Precision,EAX
        PUSH    EAX
        MOV     EAX,9999
        CMP     Format,ffFixed
        JB      @@3
        MOV     EAX,Digits
@@3:    PUSH    EAX
        LEA     EAX,FloatRec
        CALL    FloatToDecimal
        MOV     EDI,Buffer
        MOVZX   EAX,FloatRec.Exponent
        SUB     EAX,7FFFH
        CMP     EAX,2
        JAE     @@4
        MOV     ECX, EAX
        CALL    @@PutSign
        LEA     ESI,@@INFNAN[ECX+ECX*2]
        ADD     ESI,SaveGOT
        MOV     ECX,3
        REP     MOVSB
        JMP     @@7
@@4:    LEA     ESI,FloatRec.Digits
        MOVZX   EBX,Format
        CMP     BL,ffExponent
        JE      @@6
        CMP     BL,ffCurrency
        JA      @@5
        MOVSX   EAX,FloatRec.Exponent
        CMP     EAX,Precision
        JLE     @@6
@@5:    MOV     BL,ffGeneral
@@6:    LEA     EBX,@@FormatVector[EBX*4]
        ADD     EBX,SaveGOT
        MOV     EBX,[EBX]
        ADD     EBX,SaveGOT
        CALL    EBX
@@7:    MOV     EAX,EDI
        SUB     EAX,Buffer
{$IFDEF ALIGN_STACK}
        ADD     ESP, 4
{$ENDIF ALIGN_STACK}
        POP     EBX
        POP     ESI
        POP     EDI
        JMP     @@Exit

@@FormatVector:
        DD      @@PutFGeneral
        DD      @@PutFExponent
        DD      @@PutFFixed
        DD      @@PutFNumber
        DD      @@PutFCurrency

@@INFNAN: DB 'INFNAN'

// Get digit or '0' if at end of digit string

@@GetDigit:

        LODSB
        OR      AL,AL
        JNE     @@a1
        MOV     AL,'0'
        DEC     ESI
@@a1:   RET

// Store '-' if number is negative

@@PutSign:

        CMP     FloatRec.Negative,0
        JE      @@b1
        MOV     AL,'-'
        STOSB
@@b1:   RET

// Convert number using ffGeneral format

@@PutFGeneral:

        CALL    @@PutSign
        MOVSX   ECX,FloatRec.Exponent
        XOR     EDX,EDX
        CMP     ECX,Precision
        JG      @@c1
        CMP     ECX,-3
        JL      @@c1
        OR      ECX,ECX
        JG      @@c2
        MOV     AL,'0'
        STOSB
        CMP     BYTE PTR [ESI],0
        JE      @@c6
        MOV     AL,DecimalSep
        STOSB
        NEG     ECX
        MOV     AL,'0'
        REP     STOSB
        JMP     @@c3
@@c1:   MOV     ECX,1
        INC     EDX
@@c2:   LODSB
        OR      AL,AL
        JE      @@c4
        STOSB
        LOOP    @@c2
        LODSB
        OR      AL,AL
        JE      @@c5
        MOV     AH,AL
        MOV     AL,DecimalSep
        STOSW
@@c3:   LODSB
        OR      AL,AL
        JE      @@c5
        STOSB
        JMP     @@c3
@@c4:   MOV     AL,'0'
        REP     STOSB
@@c5:   OR      EDX,EDX
        JE      @@c6
        XOR     EAX,EAX
        JMP     @@PutFloatExpWithDigits
@@c6:   RET

// Convert number using ffExponent format

@@PutFExponent:

        CALL    @@PutSign
        CALL    @@GetDigit
        MOV     AH,DecimalSep
        STOSW
        MOV     ECX,Precision
        DEC     ECX
@@d1:   CALL    @@GetDigit
        STOSB
        LOOP    @@d1
        MOV     AH,'+'

@@PutFloatExpWithDigits:

        MOV     ECX,Digits
        CMP     ECX,4
        JBE     @@PutFloatExp
        XOR     ECX,ECX

// Store exponent
// In   AH  = Positive sign character ('+' or 0)
//      ECX = Minimum number of digits (0..4)

@@PutFloatExp:

        MOV     AL,'E'
        MOV     BL, FloatRec.Digits.Byte
        XOR     BH,BH
        MOVSX   EDX,FloatRec.Exponent
        DEC     EDX
        CALL    PutExponent   {Safe to call unaligned}
        RET

// Convert number using ffFixed or ffNumber format

@@PutFFixed:
@@PutFNumber:

        CALL    @@PutSign

// Store number in fixed point format

@@PutNumber:

        MOV     EDX,Digits
        CMP     EDX,18
        JB      @@f1
        MOV     EDX,18
@@f1:   MOVSX   ECX,FloatRec.Exponent
        OR      ECX,ECX
        JG      @@f2
        MOV     AL,'0'
        STOSB
        JMP     @@f4
@@f2:   XOR     EBX,EBX
        CMP     Format,ffFixed
        JE      @@f3
        MOV     EAX,ECX
        DEC     EAX
        MOV     BL,3
        DIV     BL
        MOV     BL,AH
        INC     EBX
@@f3:   CALL    @@GetDigit
        STOSB
        DEC     ECX
        JE      @@f4
        DEC     EBX
        JNE     @@f3
        MOV     AL,ThousandSep
        TEST    AL,AL
        JZ      @@f3
        STOSB
        MOV     BL,3
        JMP     @@f3
@@f4:   OR      EDX,EDX
        JE      @@f7
        MOV     AL,DecimalSep
        TEST    AL,AL
        JZ      @@f4b
        STOSB
@@f4b:  JECXZ   @@f6
        MOV     AL,'0'
@@f5:   STOSB
        DEC     EDX
        JE      @@f7
        INC     ECX
        JNE     @@f5
@@f6:   CALL    @@GetDigit
        STOSB
        DEC     EDX
        JNE     @@f6
@@f7:   RET

// Convert number using ffCurrency format

@@PutFCurrency:

        XOR     EBX,EBX
        MOV     BL,CurrFmt.Byte
        MOV     ECX,0003H
        CMP     FloatRec.Negative,0
        JE      @@g1
        MOV     BL,NegCurrFmt.Byte
        MOV     ECX,040FH
@@g1:   CMP     BL,CL
        JBE     @@g2
        MOV     BL,CL
@@g2:   ADD     BL,CH
        LEA     EBX,@@MoneyFormats[EBX+EBX*4]
        ADD     EBX,SaveGOT
        MOV     ECX,5
@@g10:  MOV     AL,[EBX]
        CMP     AL,'@'
        JE      @@g14
        PUSH    ECX
        PUSH    EBX
        CMP     AL,'$'
        JE      @@g11
        CMP     AL,'*'
        JE      @@g12
        STOSB
        JMP     @@g13
@@g11:  CALL    @@PutCurSym
        JMP     @@g13
@@g12:  CALL    @@PutNumber
@@g13:  POP     EBX
        POP     ECX
        INC     EBX
        LOOP    @@g10
@@g14:  RET

// Store currency symbol string

@@PutCurSym:

        PUSH    ESI
        MOV     ESI,CurrencyStr
        TEST    ESI,ESI
        JE      @@h1
        MOV     ECX,[ESI-4]
        REP     MOVSB
@@h1:   POP     ESI
        RET

// Currency formatting templates

@@MoneyFormats:
        DB      '$*@@@'
        DB      '*$@@@'
        DB      '$ *@@'
        DB      '* $@@'
        DB      '($*)@'
        DB      '-$*@@'
        DB      '$-*@@'
        DB      '$*-@@'
        DB      '(*$)@'
        DB      '-*$@@'
        DB      '*-$@@'
        DB      '*$-@@'
        DB      '-* $@'
        DB      '-$ *@'
        DB      '* $-@'
        DB      '$ *-@'
        DB      '$ -*@'
        DB      '*- $@'
        DB      '($ *)'
        DB      '(* $)'

@@Exit:
{$IFDEF ALIGN_STACK}
        SUB     ESP, 4
{$ENDIF ALIGN_STACK}
        PUSH    EAX
        PUSH    EBX
        LEA     EAX,AnsiCurrencyStr
        MOV     EBX,SaveGOT
        CALL    System.@LStrClr
        POP     EBX
        POP     EAX
{$IFDEF ALIGN_STACK}
        ADD     ESP, 4
{$ENDIF ALIGN_STACK}
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function FormatBuf(var Buffer; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const;
  const AFormatSettings: TFormatSettings): Cardinal;
{$IF not defined(LEGACY_FORMAT) or defined(PUREPASCAL)}
var
  BufPtr: PAnsiChar;
  FormatPtr: PAnsiChar;
  FormatStartPtr: PAnsiChar;
  FormatEndPtr: PAnsiChar;
  ArgsIndex: Integer;
  ArgsLength: Integer;
  BufMaxLen: Cardinal;
  Overwrite: Boolean;
  FormatChar: AnsiChar;
  S: AnsiString;
  StrBuf: array[0..64] of AnsiChar;
  LeftJustification: Boolean;
  Width: Integer;
  Precision: Integer;
  Len: Integer;
  FirstNumber: Integer;
  CurrentArg: TVarRec;
  FloatVal: TFloatValue;

  function ApplyWidth(NumChar, Negitive: Integer): Boolean;
  var
    I: Integer;
    Max: Integer;
  begin
    Result := False;
    if (Precision > NumChar) and (FormatChar <> 'S') then
      Max := Precision
    else
      Max := NumChar;
    if (Width <> 0) and (Width > Max + Negitive) then
    begin
      for I := Max + 1  + Negitive to Width do
      begin
        if BufMaxLen = 0 then
        begin
          Result := True;
          Break;
        end;
        BufPtr^ := ' ';
        Inc(BufPtr);
        Dec(BufMaxLen, Sizeof(AnsiChar));
      end;
    end;
  end;

  function AddBuf(const AItem: PAnsiChar; ItemLen: Integer = -1; StringLen: Integer = -1): Boolean;
  var
    NumChar: Integer;
    Len: Integer;
    I: Integer;
    Item: PAnsiChar;
    Negitive: Integer;
    BytesToCopy: Cardinal;
  begin
    Item := AItem;
    if Assigned(AItem) then
      if StringLen = -1 then
        NumChar := System.AnsiStrings.StrLen(Item)
      else
        NumChar := StringLen
    else
      NumChar := 0;
    if (ItemLen > -1) and (NumChar > ItemLen) then
      NumChar := ItemLen;
    Len := NumChar * Sizeof(AnsiChar);
    if (Assigned(AItem)) and (Item^ = '-') and (FormatChar <> 'S') then
    begin
      Dec(Len, Sizeof(AnsiChar));
      Dec(NumChar);
      Negitive := 1;
    end
    else
      Negitive := 0;
    if not LeftJustification then
    begin
      Result := ApplyWidth(NumChar, Negitive);
      if Result then
        Exit;
    end;
    if Negitive = 1 then
    begin
      if BufMaxLen = 0 then
      begin
        Result := True;
        Exit;
      end;
      Inc(Item);
      BufPtr^ := '-';
      Inc(BufPtr);
      Dec(BufMaxLen, Sizeof(AnsiChar));
    end;
    if (Precision <> -1) and (Precision > NumChar) and (FormatChar <> 'S') then
      for I := NumChar + 1 to Precision do
      begin
        if BufMaxLen = 0 then
        begin
          Result := True;
          Exit;
        end;
        BufPtr^ := '0';
        Inc(BufPtr);
        Dec(BufMaxLen, Sizeof(AnsiChar));
      end;
    if Assigned(AItem) then
    begin
      Result := BufMaxLen < Cardinal(Len);
      if Result then
        BytesToCopy := BufMaxLen
      else
        BytesToCopy := Len;
      Move(Item^, BufPtr^, BytesToCopy);
      BufPtr := PAnsiChar(PByte(BufPtr) + BytesToCopy);
      Dec(BufMaxLen, BytesToCopy);
    end
    else
      Result := False;
    if LeftJustification then
      Result := ApplyWidth(NumChar, Negitive);
  end;

  function VariantToAnsiString(V: TVarData): AnsiString;
  begin
    Result := '';
    if Assigned(System.VarToLStrProc) then
      System.VarToLStrProc(Result, V)
    else
      System.Error(reVarInvalidOp);
  end;

begin
  if (not Assigned(@Buffer)) or  (not Assigned(@Format)) then
  begin
    Result := 0;
    Exit;
  end;
  ArgsIndex := -1;
  ArgsLength := Length(Args);
  BufPtr := PAnsiChar(@Buffer);
  FormatPtr := PAnsiChar(@Format);
  if BufLen < $7FFFFFFF then
    BufMaxLen := BufLen * Sizeof(AnsiChar)
  else
    BufMaxLen := BufLen;
  FormatEndPtr := FormatPtr + FmtLen;
  while (FormatPtr < FormatEndPtr) do
    if FormatPtr^ = '%' then
    begin
      Inc(FormatPtr);
      if (FormatPtr >= FormatEndPtr) then
        Break;
      if FormatPtr^ = '%' then
      begin
        if BufMaxLen = 0 then
          AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
        BufPtr^ := FormatPtr^;
        Inc(FormatPtr);
        Inc(BufPtr);
        Dec(BufMaxLen, Sizeof(AnsiChar));
        Continue;
      end;
      Width := 0;
      // Gather Index
      Inc(ArgsIndex);
      if Char(FormatPtr^).IsNumber then
      begin
        FormatStartPtr := FormatPtr;
        while (FormatPtr < FormatEndPtr) and (Char(FormatPtr^).IsNumber)  do
          Inc(FormatPtr);
        if FormatStartPtr <> FormatPtr then
        begin
          System.AnsiStrings.StrLCopy(StrBuf, FormatStartPtr, Integer(FormatPtr - FormatStartPtr));
          if not TryStrToInt(string(StrBuf), FirstNumber) then
            AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
          if FormatPtr^ = ':' then
          begin
            Inc(FormatPtr);
            ArgsIndex := FirstNumber;
          end
          else
            Width := FirstNumber;
        end;
      end
      else if FormatPtr^ = ':' then
      begin
        ArgsIndex := 0;
        Inc(FormatPtr);
      end;
      // Gather Justification
      if FormatPtr^ = '-' then
      begin
        LeftJustification := True;
        Inc(FormatPtr);
      end
      else
        LeftJustification := False;
      // Gather Width
      FormatStartPtr := FormatPtr;
      if FormatPtr^ = '*' then
      begin
        Width := -2;
        Inc(FormatPtr);
      end
      else if Char(FormatPtr^).IsNumber then
      begin
        while (FormatPtr < FormatEndPtr) and (Char(FormatPtr^).IsNumber)  do
          Inc(FormatPtr);
        if FormatStartPtr <> FormatPtr then
        begin
          System.AnsiStrings.StrLCopy(StrBuf, FormatStartPtr, Integer(FormatPtr - FormatStartPtr));
          if not TryStrToInt(string(StrBuf), Width) then
            AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
        end
      end;
      // Gather Precision
      if FormatPtr^ = '.' then
      begin
        Inc(FormatPtr);
        if (FormatPtr >= FormatEndPtr) then
          Break;
        if FormatPtr^ = '*' then
        begin
          Precision := -2;
          Inc(FormatPtr);
        end
        else
        begin
          FormatStartPtr := FormatPtr;
          while (FormatPtr < FormatEndPtr) and (Char(FormatPtr^).IsNumber)  do
            Inc(FormatPtr);
          System.AnsiStrings.StrLCopy(StrBuf, FormatStartPtr, Integer(FormatPtr - FormatStartPtr));
          if not TryStrToInt(string(StrBuf), Precision) then
            AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
        end;
      end
      else
        Precision := -1;

      // Gather Conversion Character
      if not Char(FormatPtr^).IsLetter then
        Break;
      case FormatPtr^ of
        'a'..'z':
          FormatChar := AnsiChar(Byte(FormatPtr^) xor $20);
      else
        FormatChar := FormatPtr^;
      end;
      Inc(FormatPtr);

      // Handle Args
      if Width = -2 then // If * width was found
      begin
        if ArgsIndex >= ArgsLength then
          AnsiFormatError(1, PAnsiChar(@Format), FmtLen);
        if Args[ArgsIndex].VType = vtInteger then
        begin
          if ArgsIndex >= ArgsLength then
            AnsiFormatError(1, PAnsiChar(@Format), FmtLen);
          Width := Args[ArgsIndex].VInteger;
          if Width < 0 then
          begin
            LeftJustification := not LeftJustification;
            Width := -Width;
          end;
          Inc(ArgsIndex);
        end
        else
          AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
      end;
      if Precision = -2 then
      begin
        if ArgsIndex >= ArgsLength then
          AnsiFormatError(1, PAnsiChar(@Format), FmtLen);
        if Args[ArgsIndex].VType = vtInteger then
        begin
          if ArgsIndex >= ArgsLength then
            AnsiFormatError(1, PAnsiChar(@Format), FmtLen);
          Precision := Args[ArgsIndex].VInteger;
          Inc(ArgsIndex);
        end
        else
          AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
      end;

      if ArgsIndex >= ArgsLength then
        AnsiFormatError(1, PAnsiChar(@Format), FmtLen);
      CurrentArg := Args[ArgsIndex];

      Overwrite := False;
      case CurrentArg.VType of
        vtBoolean,
        vtObject,
        vtClass,
        vtWideChar,
        vtPWideChar,
        vtWideString,
        vtInterface: AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
        vtInteger:
          begin
            if (Precision > 16) or (Precision = -1) then
              Precision := 0;
            case FormatChar of
              'D': S := AnsiString(IntToStr(CurrentArg.VInteger));
              'U': S := AnsiString(UIntToStr(Cardinal(CurrentArg.VInteger)));
              'X': S := AnsiString(IntToHex(CurrentArg.VInteger, 0));
            else
              AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
            end;
            Overwrite := AddBuf(PAnsiChar(S));
          end;
        vtChar:
          if FormatChar = 'S' then
          begin
            S := AnsiChar(CurrentArg.VChar);
            Overwrite := AddBuf(PAnsiChar(S), Precision);
          end
          else
            AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
        vtExtended, vtCurrency:
          begin
            if CurrentArg.VType = vtExtended then
              FloatVal := fvExtended
            else
              FloatVal := fvCurrency;
            Len := 0;
            if (FormatChar = 'G') or (FormatChar = 'E') then
            begin
              if Cardinal(Precision) > 18 then
                Precision := 15;
            end
            else if Cardinal(Precision) > 18 then
            begin
              Precision := 2;
              if FormatChar = 'M' then
                Precision := AFormatSettings.CurrencyDecimals;
            end;
            case FormatChar of
              'G': Len := System.AnsiStrings.FloatToText(StrBuf, CurrentArg.VExtended^, FloatVal, ffGeneral, Precision, 3, AFormatSettings);
              'E': Len := System.AnsiStrings.FloatToText(StrBuf, CurrentArg.VExtended^, FloatVal, ffExponent, Precision, 3, AFormatSettings);
              'F': Len := System.AnsiStrings.FloatToText(StrBuf, CurrentArg.VExtended^, FloatVal, ffFixed, 18, Precision, AFormatSettings);
              'N': Len := System.AnsiStrings.FloatToText(StrBuf, CurrentArg.VExtended^, FloatVal, ffNumber, 18, Precision, AFormatSettings);
              'M': Len := System.AnsiStrings.FloatToText(StrBuf, CurrentArg.VExtended^, FloatVal, ffCurrency, 18, Precision, AFormatSettings);
            else
              AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
            end;
            StrBuf[Len] := #0;
            Precision := 0;
            Overwrite := AddBuf(StrBuf);
          end;
        vtString:
          if FormatChar = 'S' then
            Overwrite := AddBuf(PAnsiChar(AnsiString(ShortString(PShortString(CurrentArg.VAnsiString)^))), Precision)
          else
            AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
        vtUnicodeString:
          if FormatChar = 'S' then
            Overwrite := AddBuf(PAnsiChar(AnsiString(CurrentArg.VPWideChar)), Precision)
          else
            AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
        vtVariant:
          if FormatChar = 'S' then
            Overwrite := AddBuf(PAnsiChar(VariantToAnsiString(TVarData(CurrentArg.VVariant^))), Precision)
          else
            AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
        vtPointer:
          if FormatChar = 'P' then
          begin
            S := AnsiString(IntToHex(IntPtr(CurrentArg.VPointer), SizeOf(Pointer)*2));
            Overwrite := AddBuf(PAnsiChar(S));
          end
          else
            AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
        vtPChar:
          if FormatChar = 'S' then
            Overwrite := AddBuf(CurrentArg.VWideString, Precision)
          else
            AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
        vtAnsiString:
          if FormatChar = 'S' then
            Overwrite := AddBuf(CurrentArg.VAnsiString, Precision, Length(AnsiString(CurrentArg.VAnsiString)))
          else
            AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
        vtInt64:
          begin
            if (Precision > 32) or (Precision = -1)  then
              Precision := 0;
            case FormatChar of
              'D': S := AnsiString(IntToStr(CurrentArg.VInt64^));
              'U': S := AnsiString(UIntToStr(UInt64(CurrentArg.VInt64^)));
              'X': S := AnsiString(IntToHex(CurrentArg.VInt64^, 0));
            else
              AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
            end;
            Overwrite := AddBuf(PAnsiChar(S));
          end;
      end;
      if Overwrite then
      begin
        Result := BufPtr - PAnsiChar(@Buffer);
        Exit;
      end;
    end
    else
    begin
      if BufMaxLen = 0 then
      begin
        Result := BufPtr - PAnsiChar(@Buffer);
        Exit;
      end;
      BufPtr^ := FormatPtr^;
      Inc(FormatPtr);
      Inc(BufPtr);
      Dec(BufMaxLen, Sizeof(AnsiChar));
    end;
  Result := BufPtr - PAnsiChar(@Buffer);
end;
{$ELSE LEGACY_FORMAT or !PUREPASCAL}
{$IFDEF X86ASM}
  function AnsiFloatToTextEx(BufferArg: PAnsiChar; const Value; ValueType: TFloatValue;
    Format: TFloatFormat; Precision, Digits: Integer;
    const AFormatSettings: TFormatSettings): Integer;
  begin
    Result := FloatToText(BufferArg, Value, ValueType, Format, Precision, Digits,
      AFormatSettings);
  end;

var
  ArgIndex, Width, Prec: Integer;
  BufferOrg, FormatOrg, FormatPtr: PAnsiChar;
  JustFlag: Byte;
  StrBuf: array[0..64] of AnsiChar;
  TempAnsiStr: AnsiString;
  SaveGOT: Integer;
asm
        { -> eax     Buffer }
        {    edx     BufLen }
        {    ecx     Format }

        PUSH    EBX
        PUSH    ESI
        PUSH    EDI
        MOV     EDI, EAX
        MOV     ESI, ECX
{$IFDEF PIC}
        PUSH    ECX
        CALL    GetGOT
        POP     ECX
{$ELSE !PIC}
        XOR     EAX, EAX
{$ENDIF !PIC}
        MOV     SaveGOT, EAX
        ADD     ECX, FmtLen
        MOV     BufferOrg, EDI
        XOR     EAX, EAX
        MOV     ArgIndex, EAX
        MOV     TempAnsiStr, EAX

@Loop:
        OR      EDX, EDX
        JE      @Done

@NextChar:
        CMP     ESI, ECX
        JE      @Done
        LODSB
        CMP     AL, '%'
        JE      @Format

@StoreChar:
        STOSB
        DEC     EDX
        JNE     @NextChar

@Done:
        MOV     EAX, EDI
        SUB     EAX, BufferOrg
        JMP     @Exit

@Format:
        CMP     ESI, ECX
        JE      @Done
        LODSB
        CMP     AL, '%'
        JE      @StoreChar
        LEA     EBX, [ESI-2]
        MOV     FormatOrg, EBX
@A0:    MOV     JustFlag, AL
        CMP     AL, '-'
        JNE     @A1
        CMP     ESI, ECX
        JE      @Done
        LODSB
@A1:    CALL    @Specifier
        CMP     AL, ':'
        JNE     @A2
        MOV     ArgIndex, EBX
        CMP     ESI, ECX
        JE      @Done
        LODSB
        JMP     @A0

@A2:    OR      EBX, EBX
        JNS     @A2_3
        NEG     EBX
        CMP     JustFlag, '-'
        JE      @A2_2
        MOV     JustFlag, '-'
        JMP     @A2_3

@A2_2:  MOV     JustFlag, '*'

@A2_3:  MOV     Width, EBX
        MOV     EBX, -1
        CMP     AL, '.'
        JNE     @A3
        CMP     ESI, ECX
        JE      @Done
        LODSB
        CALL    @Specifier
@A3:    MOV     Prec, EBX
        MOV     FormatPtr, ESI
        PUSH    ECX
        PUSH    EDX
{$IFDEF ALIGN_STACK}
        SUB     ESP, 8
{$ENDIF}
        CALL    @Convert
{$IFDEF ALIGN_STACK}
        ADD     ESP, 8
{$ENDIF}

        POP     EDX
        MOV     EBX, Width
        SUB     EBX, ECX       // ECX <=> number of characters output
        JAE     @A4            //         jump -> output smaller than width
        XOR     EBX, EBX

@A4:    CMP     JustFlag, '-'
        JNE     @A6
        SUB     EDX, ECX
        JAE     @A5
        ADD     ECX, EDX
        XOR     EDX, EDX

@A5:    REP     MOVSB

@A6:    XCHG    EBX, ECX
        SUB     EDX, ECX
        JAE     @A7
        ADD     ECX, EDX
        XOR     EDX, EDX
@A7:    MOV     AL, ' '
        REP     STOSB
        XCHG    EBX, ECX
        SUB     EDX, ECX
        JAE     @A8
        ADD     ECX, EDX
        XOR     EDX, EDX
@A8:    REP     MOVSB
        CMP     TempAnsiStr, 0
        JE      @A9
        PUSH    EDX
        LEA     EAX, TempAnsiStr
{$IFDEF ALIGN_STACK}
        SUB     ESP, 8
{$ENDIF ALIGN_STACK}
        CALL    FormatClearStr
{$IFDEF ALIGN_STACK}
        ADD     ESP, 8
{$ENDIF ALIGN_STACK}
        POP     EDX
@A9:    POP     ECX
        MOV     ESI,FormatPtr
        JMP     @Loop

@Specifier:
        XOR     EBX, EBX
        CMP     AL, '*'
        JE      @B3
@B1:    CMP     AL, '0'
        JB      @B5
        CMP     AL, '9'
        JA      @B5
        IMUL    EBX, EBX, 10
        SUB     AL, '0'
        MOVZX   EAX, AL
        ADD     EBX, EAX
        CMP     ESI, ECX
        JE      @B2
        LODSB
        JMP     @B1
@B2:    POP     EAX
        JMP     @Done
@B3:    MOV     EAX, ArgIndex
        CMP     EAX, Args.Integer[-4]
        JG      @B4
        INC     ArgIndex
        MOV     EBX, Args
        CMP     [EBX+EAX*8].Byte[4], vtInteger
        MOV     EBX, [EBX+EAX*8]
        JE      @B4
        XOR     EBX, EBX
@B4:    CMP     ESI, ECX
        JE      @B2
        LODSB
@B5:    RET

@Convert:
        AND     AL, 0DFH
        MOV     CL, AL
        MOV     EAX, 1
        MOV     EBX, ArgIndex
        CMP     EBX, Args.Integer[-4]
        JG      @ErrorExit
        INC     ArgIndex
        MOV     ESI, Args
        LEA     ESI, [ESI+EBX*8]
        MOV     EAX, [ESI].Integer[0]       // TVarRec.data
        MOVZX   EDX, [ESI].Byte[4]          // TVarRec.VType
{$IFDEF PIC}
        MOV     EBX, SaveGOT
        ADD     EBX, offset @CvtVector
        MOV     EBX, [EBX+EDX*4]
        ADD     EBX, SaveGOT
        JMP     EBX
{$ELSE !PIC}
        JMP     @CvtVector.Pointer[EDX*4]
{$ENDIF !PIC}

@CvtVector:
        DD      @CvtInteger                // vtInteger
        DD      @CvtBoolean                // vtBoolean
        DD      @CvtChar                   // vtChar
        DD      @CvtExtended               // vtExtended
        DD      @CvtShortStr               // vtString
        DD      @CvtPointer                // vtPointer
        DD      @CvtPChar                  // vtPChar
        DD      @CvtObject                 // vtObject
        DD      @CvtClass                  // vtClass
        DD      @CvtWideChar               // vtWideChar
        DD      @CvtPWideChar              // vtPWideChar
        DD      @CvtAnsiStr                // vtAnsiString
        DD      @CvtCurrency               // vtCurrency
        DD      @CvtVariant                // vtVariant
        DD      @CvtInterface              // vtInterface
        DD      @CvtWideString             // vtWideString
        DD      @CvtInt64                  // vtInt64
        DD      @CvtUnicodeString          // vtUnicodeString

@CvtBoolean:
@CvtObject:
@CvtClass:
@CvtWideChar:
@CvtInterface:
@CvtError:
        XOR     EAX,EAX

@ErrorExit:
{$IFDEF ALIGN_STACK}
        SUB     ESP, 12
{$ENDIF}
        CALL    @ClearTmpAnsiStr
{$IFDEF ALIGN_STACK}
        ADD     ESP, 12
{$ENDIF}
        MOV     EDX, FormatOrg
        MOV     ECX, FormatPtr
        SUB     ECX, EDX
        MOV     EBX, SaveGOT
{$IFDEF PC_MAPPED_EXCEPTIONS}
        //  Because of all the assembly code here, we can't call a routine
        //  that throws an exception if it looks like we're still on the
        //  stack.  The static disassembler cannot give sufficient unwind
        //  frame info to unwind the confusion that is generated from the
        //  assembly code above.  So before we throw the exception, we
        //  go to some lengths to excise ourselves from the stack chain.
        //  We were passed 12 bytes of parameters on the stack, and we have
        //  to make sure that we get rid of those, too.
{$IFDEF ALIGN_STACK}
        MOV     ESP, EBP        // Ditch everthing to the frame
        POP     EBP             // Ditch the rest of the frame
{$ELSE  !ALIGN_STACK}
        MOV     ESP, EBP        // Ditch everthing to the frame
        MOV     EBP, [ESP + 4]  // Get the return addr
        MOV     [ESP + 16], EBP // Move the ret addr up in the stack
        POP     EBP             // Ditch the rest of the frame
        ADD     ESP, 12         // Ditch the space that was taken by params
{$ENDIF !ALIGN_STACK}
        JMP     FormatError     // Off to FormatErr
{$ELSE !PC_MAPPED_EXCEPTIONS}
        CALL    FormatError
{$ENDIF !PC_MAPPED_EXCEPTIONS}
        // The above call raises an exception and does not return

@CvtInt64:
        // CL  <= format character
        // EAX <= address of int64
        // EBX <= TVarRec.VType

        LEA     ESI, StrBuf[32]
        MOV     EDX, Prec
        CMP     EDX, 32
        JBE     @I64_1           // zero padded field width > buffer => no padding
        XOR     EDX, EDX
@I64_1: MOV     EBX, ECX
        SUB     CL, 'D'
        JZ      CvtInt64         // branch predict backward jump taken
        MOV     ECX, 16
        CMP     BL, 'X'
        JE      CvtInt64
        MOV     ECX, 10
        CMP     BL, 'U'
        JE      CvtInt64
        JMP     @CvtError

@CvtInteger:
        LEA     ESI, StrBuf[16]
        MOV     EDX, Prec
        MOV     EBX, ECX
        CMP     EDX, 16
        JBE     @C1             // zero padded field width > buffer => no padding
        XOR     EDX, EDX
@C1:    SUB     CL, 'D'
        JZ      CvtInt          // branch predict backward jump taken
        MOV     ECX, 16
        CMP     BL, 'X'
        JE      CvtInt
        MOV     ECX, 10
        CMP     BL, 'U'
        JE      CvtInt
        JMP     @CvtError

@CvtChar:
        CMP     CL, 'S'
        JNE     @CvtError
        MOV     ECX, 1
        JMP     @CvtStrLen

@CvtVariant:
        CMP     CL, 'S'
        JNE     @CvtError
        CMP     [EAX].TVarData.VType, varNull
        JBE     @CvtEmptyStr
        MOV     EDX, EAX
        LEA     EAX, TempAnsiStr
        CALL    FormatVarToStr
        MOV     ESI, TempAnsiStr
        JMP     @CvtStrRef

@CvtEmptyStr:
        XOR     ECX,ECX
        RET

@CvtShortStr:
        CMP     CL, 'S'
        JNE     @CvtError
        MOV     ESI, EAX
        LODSB
        MOVZX   ECX, AL
        JMP     @CvtStrLen

@CvtPWideChar:
        MOV    ESI, OFFSET System.@LStrFromPWChar
        JMP    @CvtWideThing

@CvtUnicodeString:
        MOV    ESI, OFFSET System.@LStrFromUStr
        JMP    @CvtWideThing

@CvtWideString:
        MOV    ESI, OFFSET System.@LStrFromWStr

@CvtWideThing:
{$IFDEF PIC}
        ADD    ESI, SaveGOT
{$ENDIF PIC}
        CMP    CL, 'S'
        JNE    @CvtError
        MOV    EDX, EAX
        LEA    EAX, TempAnsiStr
{$IFDEF ALIGN_STACK}
        SUB    ESP, 4
{$ENDIF}
        PUSH   EBX
        PUSH   ECX
        MOV    EBX, SaveGOT
{$IFDEF PIC}                                    // Double indirect using GOT
        MOV    ECX, [EBX].DefaultSystemCodePage
        MOV    ECX, [ECX]
{$ELSE !PIC}
        MOV    ECX, DefaultSystemCodePage
{$ENDIF}
        CALL   ESI
        POP    ECX
        POP    EBX
{$IFDEF ALIGN_STACK}
        ADD    ESP, 4
{$ENDIF}
        MOV    ESI, TempAnsiStr
        MOV    EAX, ESI
        JMP    @CvtStrRef

@CvtAnsiStr:
        CMP     CL, 'S'
        JNE     @CvtError
        MOV     ESI, EAX

@CvtStrRef:
        OR      ESI, ESI
        JE      @CvtEmptyStr
        MOV     ECX, [ESI-4]

@CvtStrLen:
        CMP     ECX, Prec
        JA      @E1
        RET
@E1:    MOV     ECX, Prec
        RET

@CvtPChar:
        CMP     CL, 'S'
        JNE     @CvtError
        MOV     ESI, EAX
        PUSH    EDI
        MOV     EDI, EAX
        XOR     AL, AL
        MOV     ECX, Prec
        JECXZ   @F1
        REPNE   SCASB
        JNE     @F1
        DEC     EDI
@F1:    MOV     ECX, EDI
        SUB     ECX, ESI
        POP     EDI
        RET

@CvtPointer:
        CMP     CL, 'P'
        JNE     @CvtError
        MOV     EDX, 8
        MOV     ECX, 16
        LEA     ESI, StrBuf[16]
        JMP     CvtInt

@CvtCurrency:
        MOV     BH, fvCurrency
        JMP     @CvtFloat

@CvtExtended:
        MOV     BH, fvExtended

@CvtFloat:
        MOV     ESI, EAX
        MOV     BL, ffGeneral
        CMP     CL, 'G'
        JE      @G2
        MOV     BL, ffExponent
        CMP     CL, 'E'
        JE      @G2
        MOV     BL, ffFixed
        CMP     CL, 'F'
        JE      @G1
        MOV     BL, ffNumber
        CMP     CL, 'N'
        JE      @G1
        CMP     CL, 'M'
        JNE     @CvtError
        MOV     BL, ffCurrency
@G1:    MOV     EAX, 18
        MOV     EDX, Prec
        CMP     EDX, EAX
        JBE     @G3
        MOV     EDX, 2
        CMP     CL, 'M'
        JNE     @G3
        MOV     EDX, AFormatSettings
        MOVZX   EDX, [EDX].TFormatSettings.CurrencyDecimals
        JMP     @G3
@G2:    MOV     EAX, Prec
        MOV     EDX, 3
        CMP     EAX, 18
        JBE     @G3
        MOV     EAX, 15
@G3:
{$IFDEF ALIGN_STACK}
        SUB     ESP, 12
{$ENDIF ALIGN_STACK}
        PUSH    EBX
        PUSH    EAX
        PUSH    EDX
        MOV     EDX, [AFormatSettings]
        PUSH    EDX
        LEA     EAX, StrBuf
        MOV     EDX, ESI
        MOVZX   ECX, BH
        MOV     EBX, SaveGOT
        CALL    AnsiFloatToTextEx
        MOV     ECX, EAX
        LEA     ESI, StrBuf
{$IFDEF ALIGN_STACK}
        ADD     ESP, 12
{$ENDIF ALIGN_STACK}
        RET

@ClearTmpAnsiStr:
        PUSH    EBX
        PUSH    EAX
        LEA     EAX, TempAnsiStr
        MOV     EBX, SaveGOT
{$IFDEF ALIGN_STACK}
        SUB     ESP, 4
{$ENDIF}
        CALL    System.@LStrClr
{$IFDEF ALIGN_STACK}
        ADD     ESP, 4
{$ENDIF}
        POP     EAX
        POP     EBX
        RET

@Exit:
        CALL    @ClearTmpAnsiStr
        POP     EDI
        POP     ESI
        POP     EBX
end;
{$ENDIF X86ASM}
{$ENDIF LEGACY_FORMAT or !PUREPASCAL}

{$IFDEF PUREPASCAL}
function InternalFloatToTextFmt(Buf: PByte; const Value; ValueType: TFloatValue; Format: PByte;
  const AFormatSettings: TFormatSettings; const Unicode: Boolean): Integer;
const
  CMinExtPrecision = 2;
{$IFDEF EXTENDEDIS10BYTES}
  CMaxExtPrecision = 18;
{$ELSE !EXTENDEDIS10BYTES}
  CMaxExtPrecision = 17;
{$ENDIF EXTENDEDIS10BYTES}

var
  AIndex: Integer;
  ThousandSep: Boolean;
  Section: String;
  SectionIndex: Integer;
  FloatValue: TFloatRec;
  DecimalIndex: Integer;
  FirstDigit: Integer;
  LastDigit: Integer;
  DigitCount: Integer;
  Scientific: Boolean;
  Precision: Integer;
  Digits: Integer;
  DecimalSep: Char;
  ThousandsSep: Char;
  FormatLength: Integer;

  procedure AppendChar(const AChar: Char);
  begin
    if Unicode then
    begin
      PWideChar(Buf)^ := AChar;
      Inc(Buf, SizeOf(Char));
    end else
    begin
      PByte(Buf)^ := Byte(AChar);
      Inc(Buf, SizeOf(Byte));
    end;

    Inc(Result);
  end;

  function GetLength(const ABuf: PByte): Integer;
  var
    AWide: PChar;
    AAnsi: PByte;
  begin
    Result := 0;
    if Unicode then
    begin
      AWide := PChar(ABuf);
      while AWide^ <> #0 do
      begin
        Inc(AWide);
        Inc(Result);
      end;
    end else
    begin
      AAnsi := PByte(ABuf);
      while AAnsi^ <> Ord(#0) do
      begin
        Inc(AAnsi);
        Inc(Result);
      end;
    end;
  end;

  function GetCharIndex(const ABuf: PByte; const Index: Integer): Char;
  begin
    if Unicode then
      Result := PWideChar(ABuf)[Index]
    else
      Result := Char(PByte(ABuf)[Index]);
  end;

  procedure AppendString(const AStr: String);
  var
    I, L: Integer;
  begin
    L := AStr.Length;

    if L > 0 then
    begin
      if Unicode then
      begin
        { Unicode -- move directly }
        MoveChars(AStr[Low(string)], Buf^, L);
        Inc(Buf, L * SizeOf(Char));
      end else
      begin
        { ANSI -- loop }
        for I := Low(string) to High(AStr) do
        begin
          PByte(Buf)^ := Byte(AStr[I]);
          Inc(Buf, SizeOf(Byte));
        end;
      end;

      Inc(Result, L);
    end;
  end;

  function FindSection(AIndex: Integer): Integer;
  var
    Section: Integer;
    C: Integer;
  begin
    Section := 0;
    C := 0;
    FormatLength := GetLength(Format);
    while (Section <> AIndex) and (C < FormatLength) do
    begin
      case GetCharIndex(Format, C) of
        ';': begin
          Inc(Section);
          Inc(C);
        end;

        '"': begin
          Inc(C);
          while (C < FormatLength) and (GetCharIndex(Format, C) <> '"') do
            Inc(C);
          if C < FormatLength then
            Inc(C);
        end;

        '''': begin
          Inc(C);
          while (C < FormatLength) and (GetCharIndex(Format, C) <> '''') do
            Inc(C);
          if C < FormatLength then
            Inc(C);
        end;

        else
          Inc(C);
      end;
    end;
    if (Section < AIndex) or (C = FormatLength) then
      Result := 0
    else
      Result := C;
  end;

  function ScanSection(APos: Integer): String;
  var
    C: Integer;
    AChar: Char;
    I: Integer;
  begin
    DecimalIndex := -1;
    Scientific := false;
    ThousandSep := false;
    C := APos;
    FirstDigit := 32767;
    DigitCount := 0;
    LastDigit := 0;
    while (C < FormatLength) and (GetCharIndex(Format, C) <> ';') do
    begin
      case GetCharIndex(Format, C) of
        ',': begin
          ThousandSep := true;
          Inc(C);
        end;

        '.': begin
          if DecimalIndex = -1 then
            DecimalIndex := DigitCount;
          Inc(C);
        end;

        '"': begin
          Inc(C);
          while (C < FormatLength) and (GetCharIndex(Format, C) <> '"') do
            Inc(C);
          if C < FormatLength then
            Inc(C);
        end;

        '''': begin
          Inc(C);
          while (C < FormatLength) and (GetCharIndex(Format, C) <> '''') do
            Inc(C);
          if C < FormatLength then
            Inc(C);
        end;

        'e', 'E': begin
          Inc(C);
          if C < FormatLength then
          begin
            AChar := GetCharIndex(Format, C);
            if (AChar = '-') or (AChar = '+') then begin
              Scientific := true;
              Inc(C);
              while (C < FormatLength) and (GetCharIndex(Format, C) = '0') do
                Inc(C);
            end;
          end;
        end;

        '#': begin
          Inc(DigitCount);
          Inc(C);
        end;

        '0': begin
          if DigitCount < FirstDigit then
            FirstDigit := DigitCount;

          Inc(DigitCount);
          LastDigit := DigitCount;
          Inc(C);
        end;

        else
          Inc(C);
      end;
    end;

    if DecimalIndex = -1 then
      DecimalIndex := DigitCount;
    LastDigit := DecimalIndex - LastDigit;
    if LastDigit > 0 then
      LastDigit := 0;

    FirstDigit := DecimalIndex - FirstDigit;
    if FirstDigit < 0 then
      FirstDigit := 0;
    Result := '';
    for I := APos to APos + (C - APos - 1) do
      Result := Result + GetCharIndex(Format, I);
  end;

  function DigitsLength: Integer;
  var
    C: Integer;
  begin
    Result := 0;
    C := Low(FloatValue.Digits);
    while (C <= High(FloatValue.Digits)) and (FloatValue.Digits[C] <> Ord(#0)) do
    begin
      Inc(C);
      Inc(Result);
    end;
  end;

  procedure ApplyFormat;
  var
    C: Integer;
    DigitDelta: Integer;
    DigitPlace: Integer;
    DigitsC: Integer;
    DigitsLimit: Integer;
    OldC: Char;
    Sign: Char;
    Zeros: Integer;

    procedure WriteDigit(ADigit: Char);
    begin
      if DigitPlace = 0 then
      begin
        AppendChar(DecimalSep);
        AppendChar(ADigit);
        Dec(DigitPlace);
      end
      else
      begin
        AppendChar(ADigit);
        Dec(DigitPlace);
        if ThousandSep and (DigitPlace > 1) and ((DigitPlace mod 3) = 0) then
          AppendChar(ThousandsSep);
      end;
    end;

    procedure AddDigit;
    var
      AChar: Char;
    begin
      if DigitsC <= DigitsLimit then
      begin
        AChar := Char(FloatValue.Digits[DigitsC]);
        Inc(DigitsC);
        WriteDigit(AChar);
      end
      else
      begin
        if DigitPlace <= LastDigit then
          Dec(DigitPlace)
        else
          WriteDigit('0');
      end;
    end;

    procedure PutFmtDigit;
    begin
      if DigitDelta < 0 then
      begin
        Inc(DigitDelta);
        if DigitPlace <= FirstDigit then
          WriteDigit('0')
        else
          Dec(DigitPlace);
      end
      else
      begin
        if DigitDelta = 0 then
          AddDigit
        else
        begin  // DigitDelta > 0
          while DigitDelta > 0 do
          begin
            AddDigit;
            Dec(DigitDelta);
          end;
          AddDigit;
        end;
      end;
    end;

    procedure PutExponent(EChar: Char; Sign: Char; Zeros: Integer; Exponent: Integer);
    var
      Exp: String;
      WriteSign: String;
    begin
      AppendChar(EChar);
      if (Sign = '+') and (Exponent >=0) then
        WriteSign := '+'
      else
        if Exponent < 0 then
          WriteSign := '-'
        else
          WriteSign := '';

      Exp := IntToStr(Abs(Exponent));
      AppendString(WriteSign + StringOfChar('0', Zeros - Exp.Length) + Exp);
    end;

  begin
    if (FloatValue.Negative) and (SectionIndex = 0) then
      AppendChar('-');

    if Scientific then
    begin
      DigitPlace := DecimalIndex;
      DigitDelta := 0;
    end
    else
    begin
      DigitDelta := FloatValue.Exponent - DecimalIndex;
      if DigitDelta >= 0 then
        DigitPlace := FloatValue.Exponent
      else
        DigitPlace := DecimalIndex;
    end;

    DigitsLimit := DigitsLength - 1;
    C := 0;
    DigitsC := 0;
    while C < Section.Length do
    begin
      case Section.Chars[C] of
        '0', '#': begin
          PutFmtDigit;
          Inc(C);
        end;

        '.', ',': Inc(C);

        '"', '''': begin
          OldC := Section.Chars[C];
          Inc(C);
          while (C < Section.Length-1) and (Section.Chars[C] <> OldC) do
          begin
            AppendChar(Section.Chars[C]);
            Inc(C);
          end;
          Inc(C);
        end;

        'e', 'E': begin
          OldC := Section.Chars[C];
          Inc(C);
          if C < Section.Length then
          begin
            Sign := Section.Chars[C];
            if (Sign <> '+') and (Sign <> '-') then
              AppendChar(OldC)
            else
            begin
              Zeros := 0;
              Inc(C);
              while (C < Section.Length) and (Section.Chars[C] = '0') do
              begin
                Inc(C);
                if Zeros < 4 then Inc(Zeros);
              end;
              PutExponent(OldC, Sign, Zeros, FloatValue.Exponent - DecimalIndex);
            end;
          end;
        end;

        else
        begin
          AppendChar(Section.Chars[C]);
          Inc(C);
        end;
      end;
    end;
    if Result > 0 then begin
      AppendChar(#0);
      Dec(Result);
    end;
  end;

var
  Temp: Extended;

begin
  Result := 0;
  DecimalSep := AFormatSettings.DecimalSeparator;
  ThousandsSep := AFormatSettings.ThousandSeparator;

  if ValueType = fvCurrency then
    Temp := Currency(Value)
  else
    Temp := Extended(Value);

  if Extended(Temp) > 0 then
    AIndex := 0
  else
    if Extended(Temp) < 0 then
      AIndex := 1
    else
      AIndex := 2;

  SectionIndex := FindSection(AIndex);
  Section := ScanSection(SectionIndex);
  if Section = '' then
  begin
    SectionIndex := FindSection(0);
    Section := ScanSection(SectionIndex);
  end;

  if Scientific then
  begin
    Precision := DigitCount;
    Digits := 9999;
  end
  else begin
    Precision := CMaxExtPrecision;
    Digits := DigitCount - DecimalIndex;
  end;
  FloatToDecimal(FloatValue, Value, ValueType, Precision, Digits);

  if (FormatLength = 0) or (GetCharIndex(Format, 0) = ';') or
    ((FloatValue.Exponent >= 18) and (not Scientific)) or
    (FloatValue.Exponent = $7FF) or (FloatValue.Exponent = $800) then
{$IFNDEF NEXTGEN}
    if Unicode then
      Result := FloatToText(PWideChar(Buf), Value, ValueType, ffGeneral, 15, 0)
    else
      Result := FloatToText(PAnsiChar(Buf), Value, ValueType, ffGeneral, 15, 0)
{$ELSE NEXTGEN}
    Result := FloatToText(PWideChar(Buf), Value, ValueType, ffGeneral, 15, 0)
{$ENDIF !NEXTGEN}
  else
    ApplyFormat;
end;
{$ENDIF PUREPASCAL}

function FloatToTextFmt(Buf: PAnsiChar; const Value; ValueType: TFloatValue; Format: PAnsiChar): Integer;
begin
  Result := FloatToTextFmt(Buf, Value, ValueType, Format, FormatSettings);
end;

function FloatToTextFmt(Buf: PAnsiChar; const Value; ValueType: TFloatValue;
  Format: PAnsiChar; const AFormatSettings: TFormatSettings): Integer;
{$IFDEF PUREPASCAL}
begin
  Result := InternalFloatToTextFmt(PByte(Buf), Value, ValueType, PByte(Format), AFormatSettings, False);
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
var
  Buffer: Pointer;
  ThousandSep: Boolean;
  DecimalSep: AnsiChar;
  ThousandsSep: AnsiChar;
  Scientific: Boolean;
  Section: Integer;
  DigitCount: Integer;
  DecimalIndex: Integer;
  FirstDigit: Integer;
  LastDigit: Integer;
  DigitPlace: Integer;
  DigitDelta: Integer;
  FloatRec: TFloatRec;
asm
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     Buffer,EAX
        MOV     EDI,EDX
        MOV     EBX,ECX
        MOV     EAX,AFormatSettings
        MOV     AL,AnsiChar([EAX].TFormatSettings.DecimalSeparator)
        MOV     DecimalSep,AL
        MOV     EAX,AFormatSettings
        MOV     AL,AnsiChar([EAX].TFormatSettings.ThousandSeparator)
        MOV     ThousandsSep,AL
        MOV     ECX,2
        CMP     BL,fvExtended
        JE      @@1
        MOV     EAX,[EDI].Integer
        OR      EAX,[EDI].Integer[4]
        JE      @@2
        MOV     ECX,[EDI].Integer[4]
        SHR     ECX,31
        JMP     @@2
@@1:    MOVZX   EAX,[EDI].Word[8]
        OR      EAX,[EDI].Integer[0]
        OR      EAX,[EDI].Integer[4]
        JE      @@2
        MOVZX   ECX,[EDI].Word[8]
        SHR     ECX,15
@@2:    CALL    @@FindSection
        JE      @@5
        CALL    @@ScanSection
        MOV     EAX,DigitCount
        MOV     EDX,9999
        CMP     Scientific,0
        JNE     @@3
        SUB     EAX,DecimalIndex
        MOV     EDX,EAX
        MOV     EAX,18
@@3:    PUSH    EAX
        PUSH    EDX
        LEA     EAX,FloatRec
        MOV     EDX,EDI
        MOV     ECX,EBX
        CALL    FloatToDecimal                { Stack aligned - ESP(xxxxxxx0h) on call }
        MOV     AX,FloatRec.Exponent
        CMP     AX,8000H
        JE      @@5
        CMP     AX,7FFFH
        JE      @@5
        CMP     BL,fvExtended
        JNE     @@6
        CMP     AX,18
        JLE     @@6
        CMP     Scientific,0
        JNE     @@6
@@5:
{$IFDEF ALIGN_STACK}
        SUB     ESP, 8
{$ENDIF ALIGN_STACK}
        PUSH    ffGeneral
        PUSH    15
        PUSH    0
        MOV     EAX,[AFormatSettings]
        PUSH    EAX
        MOV     EAX,Buffer
        MOV     EDX,EDI
        MOV     ECX,EBX
        CALL    AnsiFloatToTextEx
{$IFDEF ALIGN_STACK}
        ADD     ESP, 8
{$ENDIF ALIGN_STACK}
        JMP     @@Exit
@@6:    CMP     FloatRec.Digits.Byte,0
        JNE     @@7
        MOV     ECX,2
        CALL    @@FindSection
        JE      @@5
        CMP     ESI,Section
        JE      @@7
        CALL    @@ScanSection
@@7:    CALL    @@ApplyFormat
        JMP     @@Exit

// Find format section
// In   ECX = Section index
// Out  ESI = Section offset
//      ZF  = 1 if section is empty

@@FindSection:
        MOV     ESI,Format
        JECXZ   @@fs2
@@fs1:  LODSB
        CMP     AL,"'"
        JE      @@fs4
        CMP     AL,'"'
        JE      @@fs4
        OR      AL,AL
        JE      @@fs2
        CMP     AL,';'
        JNE     @@fs1
        LOOP    @@fs1
        MOV     AL,byte ptr [ESI]
        OR      AL,AL
        JE      @@fs2
        CMP     AL,';'
        JNE     @@fs3
@@fs2:  MOV     ESI,Format
        MOV     AL,byte ptr [ESI]
        OR      AL,AL
        JE      @@fs3
        CMP     AL,';'
@@fs3:  RET
@@fs4:  MOV     AH,AL
@@fs5:  LODSB
        CMP     AL,AH
        JE      @@fs1
        OR      AL,AL
        JNE     @@fs5
        JMP     @@fs2

// Scan format section

@@ScanSection:
        PUSH    EBX
        MOV     Section,ESI
        MOV     EBX,32767
        XOR     ECX,ECX
        XOR     EDX,EDX
        MOV     DecimalIndex,-1
        MOV     ThousandSep,DL
        MOV     Scientific,DL
@@ss1:  LODSB
@@ss2:  CMP     AL,'#'
        JE      @@ss10
        CMP     AL,'0'
        JE      @@ss11
        CMP     AL,'.'
        JE      @@ss13
        CMP     AL,','
        JE      @@ss14
        CMP     AL,"'"
        JE      @@ss15
        CMP     AL,'"'
        JE      @@ss15
        CMP     AL,'E'
        JE      @@ss20
        CMP     AL,'e'
        JE      @@ss20
        CMP     AL,';'
        JE      @@ss30
        OR      AL,AL
        JNE     @@ss1
        JMP     @@ss30
@@ss10: INC     EDX
        JMP     @@ss1
@@ss11: CMP     EDX,EBX
        JGE     @@ss12
        MOV     EBX,EDX
@@ss12: INC     EDX
        MOV     ECX,EDX
        JMP     @@ss1
@@ss13: CMP     DecimalIndex,-1
        JNE     @@ss1
        MOV     DecimalIndex,EDX
        JMP     @@ss1
@@ss14: MOV     ThousandSep,1
        JMP     @@ss1
@@ss15: MOV     AH,AL
@@ss16: LODSB
        CMP     AL,AH
        JE      @@ss1
        OR      AL,AL
        JNE     @@ss16
        JMP     @@ss30
@@ss20: LODSB
        CMP     AL,'-'
        JE      @@ss21
        CMP     AL,'+'
        JNE     @@ss2
@@ss21: MOV     Scientific,1
@@ss22: LODSB
        CMP     AL,'0'
        JE      @@ss22
        JMP     @@ss2
@@ss30: MOV     DigitCount,EDX
        CMP     DecimalIndex,-1
        JNE     @@ss31
        MOV     DecimalIndex,EDX
@@ss31: MOV     EAX,DecimalIndex
        SUB     EAX,ECX
        JLE     @@ss32
        XOR     EAX,EAX
@@ss32: MOV     LastDigit,EAX
        MOV     EAX,DecimalIndex
        SUB     EAX,EBX
        JGE     @@ss33
        XOR     EAX,EAX
@@ss33: MOV     FirstDigit,EAX
        POP     EBX
        RET

// Apply format string

@@ApplyFormat:
        CMP     Scientific,0
        JE      @@af1
        MOV     EAX,DecimalIndex
        XOR     EDX,EDX
        JMP     @@af3
@@af1:  MOVSX   EAX,FloatRec.Exponent
        CMP     EAX,DecimalIndex
        JG      @@af2
        MOV     EAX,DecimalIndex
@@af2:  MOVSX   EDX,FloatRec.Exponent
        SUB     EDX,DecimalIndex
@@af3:  MOV     DigitPlace,EAX
        MOV     DigitDelta,EDX
        MOV     ESI,Section
        MOV     EDI,Buffer
        LEA     EBX,FloatRec.Digits
        CMP     FloatRec.Negative,0
        JE      @@af10
        CMP     ESI,Format
        JNE     @@af10
        MOV     AL,'-'
        STOSB
@@af10: LODSB
        CMP     AL,'#'
        JE      @@af20
        CMP     AL,'0'
        JE      @@af20
        CMP     AL,'.'
        JE      @@af10
        CMP     AL,','
        JE      @@af10
        CMP     AL,"'"
        JE      @@af25
        CMP     AL,'"'
        JE      @@af25
        CMP     AL,'E'
        JE      @@af30
        CMP     AL,'e'
        JE      @@af30
        CMP     AL,';'
        JE      @@af40
        OR      AL,AL
        JE      @@af40
@@af11: STOSB
        JMP     @@af10
@@af20: CALL    @@PutFmtDigit
        JMP     @@af10
@@af25: MOV     AH,AL
@@af26: LODSB
        CMP     AL,AH
        JE      @@af10
        OR      AL,AL
        JE      @@af40
        STOSB
        JMP     @@af26
@@af30: MOV     AH,[ESI]
        CMP     AH,'+'
        JE      @@af31
        CMP     AH,'-'
        JNE     @@af11
        XOR     AH,AH
@@af31: MOV     ECX,-1
@@af32: INC     ECX
        INC     ESI
        CMP     [ESI].Byte,'0'
        JE      @@af32
        CMP     ECX,4
        JB      @@af33
        MOV     ECX,4
@@af33: PUSH    EBX
        MOV     BL,FloatRec.Digits.Byte
        XOR     BH,BH
        MOVSX   EDX,FloatRec.Exponent
        SUB     EDX,DecimalIndex
        CALL    PutExponent   {Safe to call unaligned}
        POP     EBX
        JMP     @@af10
@@af40: MOV     EAX,EDI
        SUB     EAX,Buffer
        RET

// Store formatted digit

@@PutFmtDigit:
        CMP     DigitDelta,0
        JE      @@fd3
        JL      @@fd2
@@fd1:  CALL    @@fd3
        DEC     DigitDelta
        JNE     @@fd1
        JMP     @@fd3
@@fd2:  INC     DigitDelta
        MOV     EAX,DigitPlace
        CMP     EAX,FirstDigit
        JLE     @@fd4
        JMP     @@fd7
@@fd3:  MOV     AL,[EBX]
        INC     EBX
        OR      AL,AL
        JNE     @@fd5
        DEC     EBX
        MOV     EAX,DigitPlace
        CMP     EAX,LastDigit
        JLE     @@fd7
@@fd4:  MOV     AL,'0'
@@fd5:  CMP     DigitPlace,0
        JNE     @@fd6
        MOV     AH,AL
        MOV     AL,DecimalSep
        STOSW
        JMP     @@fd7
@@fd6:  STOSB
        CMP     ThousandSep,0
        JE      @@fd7
        MOV     EAX,DigitPlace
        CMP     EAX,1
        JLE     @@fd7
        MOV     DL,3
        DIV     DL
        CMP     AH,1
        JNE     @@fd7
        MOV     AL,ThousandsSep
        TEST    AL,AL
        JZ      @@fd7
        STOSB
@@fd7:  DEC     DigitPlace
        RET

@@exit:
        POP     EBX
        POP     ESI
        POP     EDI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}


function TextToFloat(Buffer: PAnsiChar; var Value; ValueType: TFloatValue): Boolean;
begin
  Result := TextToFloat(Buffer, Value, ValueType, FormatSettings);
end;

function TextToFloat(Buffer: PAnsiChar; var Value;
  ValueType: TFloatValue; const AFormatSettings: TFormatSettings): Boolean;
{$IFDEF PUREPASCAL}
var
  S: string;
begin
  S := string(AnsiString(Buffer));
  Result := TextToFloat( PChar(s), Value, ValueType, AFormatSettings);
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
var
  Temp: Integer;
  CtrlWord: Word;
  DecimalSep: AnsiChar;
  SaveGOT: Integer;
asm //StackAligned
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     ESI,EAX
        MOV     EDI,EDX
{$IFDEF PIC}
        PUSH    ECX
        CALL    GetGOT
        POP     EBX
        MOV     SaveGOT,EAX
{$ELSE !PIC}
        MOV     SaveGOT,0
        MOV     EBX,ECX
{$ENDIF !PIC}
        MOV     EAX,AFormatSettings
        MOV     AL,AnsiChar([EAX].TFormatSettings.DecimalSeparator)
        MOV     DecimalSep,AL
        FSTCW   CtrlWord
        FCLEX
{$IFDEF PIC}
        MOV     EAX, SaveGOT
        FLDCW   [EAX].CWNear
{$ELSE !PIC}
        FLDCW   CWNear
{$ENDIF !PIC}
        FLDZ
        CALL    @@SkipBlanks
        MOV     BH, byte ptr [ESI]
        CMP     BH,'+'
        JE      @@1
        CMP     BH,'-'
        JNE     @@2
@@1:    INC     ESI
@@2:    MOV     ECX,ESI
        CALL    @@GetDigitStr
        XOR     EDX,EDX
        MOV     AL,[ESI]
        CMP     AL,DecimalSep
        JNE     @@3
        INC     ESI
        CALL    @@GetDigitStr
        NEG     EDX
@@3:    CMP     ECX,ESI
        JE      @@9
        MOV     AL, byte ptr [ESI]
        AND     AL,0DFH
        CMP     AL,'E'
        JNE     @@4
        INC     ESI
        PUSH    EDX
        CALL    @@GetExponent
        POP     EAX
        ADD     EDX,EAX
@@4:    CALL    @@SkipBlanks
        CMP     BYTE PTR [ESI],0
        JNE     @@9
        MOV     EAX,EDX
        CMP     BL,fvCurrency
        JNE     @@5
        ADD     EAX,4
@@5:
{$IFDEF ALIGN_STACK}
        SUB     ESP, 12
{$ENDIF ALIGN_STACK}
        PUSH    EBX
        MOV     EBX,SaveGOT
        CALL    FPower10
        POP     EBX
{$IFDEF ALIGN_STACK}
        ADD     ESP, 12
{$ENDIF ALIGN_STACK}
        CMP     BH,'-'
        JNE     @@6
        FCHS
@@6:    CMP     BL,fvExtended
        JE      @@7
        FISTP   QWORD PTR [EDI]
        JMP     @@8
@@7:    FSTP    TBYTE PTR [EDI]
@@8:    FSTSW   AX
        TEST    AX,mIE+mOE
        JNE     @@10
        MOV     AL,1
        JMP     @@11
@@9:    FSTP    ST(0)
@@10:   XOR     EAX,EAX
@@11:   FCLEX
        FLDCW   CtrlWord
        FWAIT
        JMP     @@Exit

@@SkipBlanks:

@@21:   LODSB
        OR      AL,AL
        JE      @@22
        CMP     AL,' '
        JE      @@21
@@22:   DEC     ESI
        RET

// Process string of digits
// Out EDX = Digit count

@@GetDigitStr:

        XOR     EAX,EAX
        XOR     EDX,EDX
@@31:   LODSB
        SUB     AL,'0'+10
        ADD     AL,10
        JNC     @@32
{$IFDEF PIC}
        XCHG    SaveGOT,EBX
        FIMUL   [EBX].DCon10
        XCHG    SaveGOT,EBX
{$ELSE !PIC}
        FIMUL   DCon10
{$ENDIF !PIC}
        MOV     Temp,EAX
        FIADD   Temp
        INC     EDX
        JMP     @@31
@@32:   DEC     ESI
        RET

// Get exponent
// Out EDX = Exponent (-4999..4999)

@@GetExponent:

        XOR     EAX,EAX
        XOR     EDX,EDX
        MOV     CL, byte ptr [ESI]
        CMP     CL,'+'
        JE      @@41
        CMP     CL,'-'
        JNE     @@42
@@41:   INC     ESI
@@42:   MOV     AL, byte ptr [ESI]
        SUB     AL,'0'+10
        ADD     AL,10
        JNC     @@43
        INC     ESI
        IMUL    EDX,10
        ADD     EDX,EAX
        CMP     EDX,500
        JB      @@42
@@43:   CMP     CL,'-'
        JNE     @@44
        NEG     EDX
@@44:   RET

@@Exit:
        POP     EBX
        POP     ESI
        POP     EDI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}




function AnsiStrPos(Str, SubStr: PAnsiChar): PAnsiChar;
var
  L1, L2: Cardinal;
  ByteType : TMbcsByteType;
begin
  Result := nil;
  if (Str = nil) or (Str^ = #0) or (SubStr = nil) or (SubStr^ = #0) then Exit;
  L1 := System.AnsiStrings.StrLen(Str);
  L2 := System.AnsiStrings.StrLen(SubStr);
  Result := System.AnsiStrings.StrPos(Str, SubStr);
  while (Result <> nil) and ((L1 - Cardinal(Result - Str)) >= L2) do
  begin
    ByteType := System.AnsiStrings.StrByteType(Str, Integer(Result-Str));
{$IFDEF MSWINDOWS}
    if (ByteType <> mbTrailByte) and
      (CompareStringA(LOCALE_USER_DEFAULT, 0, Result, L2, SubStr, L2) = CSTR_EQUAL) then Exit;
    if (ByteType = mbLeadByte) then Inc(Result);
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
    if (ByteType <> mbTrailByte) and
      (strncmp(Result, SubStr, L2) = 0) then Exit;
{$ENDIF POSIX}
    Inc(Result);
    Result := System.AnsiStrings.StrPos(Result, SubStr);
  end;
  Result := nil;
end;

function AnsiStrRScan(Str: PAnsiChar; Chr: AnsiChar): PAnsiChar;
begin
  Str := System.AnsiStrings.AnsiStrScan(Str, Chr);
  Result := Str;
  if Chr <> AnsiChar(#$0) then
  begin
    while Str <> nil do
    begin
      Result := Str;
      Inc(Str);
      Str := System.AnsiStrings.AnsiStrScan(Str, Chr);
    end;
  end
end;

function AnsiStrScan(Str: PAnsiChar; Chr: AnsiChar): PAnsiChar;
begin
  Result := System.AnsiStrings.StrScan(Str, Chr);
  while Result <> nil do
  begin
{$IFDEF MSWINDOWS}
    case System.AnsiStrings.StrByteType(Str, Integer(Result-Str)) of
      mbSingleByte: Exit;
      mbLeadByte: Inc(Result);
    end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
    if System.AnsiStrings.StrByteType(Str, Integer(Result-Str)) = mbSingleByte then Exit;
{$ENDIF POSIX}
    Inc(Result);
    Result := System.AnsiStrings.StrScan(Result, Chr);
  end;
end;


function AnsiNextCharIndex(const S: AnsiString; Index: Integer): Integer;
begin
  Result := Index + 1;
  assert((Index > 0) and (Index <= Length(S)));
  if IsLeadChar(S[Index]) then
    Result := Index + System.AnsiStrings.StrCharLength(PAnsiChar(S) + Index - 1);
end;

{ MBCS functions }

function ByteTypeTest(P: PByte; Index: Integer): TMbcsByteType;
{$IFDEF MSWINDOWS}
var
  I: Integer;
begin
  Result := mbSingleByte;
  if (P = nil) or (P[Index] = Ord(#$0)) then Exit;
  if (Index = 0) then
  begin
    if IsLeadChar(P[0]) then Result := mbLeadByte;
  end
  else
  begin
    I := Index - 1;
    while (I >= 0) and IsLeadChar(Byte(P[I])) do Dec(I);
    if ((Index - I) mod 2) = 0 then Result := mbTrailByte
    else if IsLeadChar(P[Index]) then Result := mbLeadByte;
  end;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  I, L: Integer;
begin
  Result := mbSingleByte;
  if (P = nil) or (P[Index] = Ord(#$0)) then Exit;

  I := 0;
  repeat
    if IsLeadChar(P[I]) then
{$IFNDEF NEXTGEN}
      L := System.AnsiStrings.StrCharLength(PAnsiChar(P + I))
{$ELSE NEXTGEN}
      L := StrCharLength(PByte(P + I))
{$ENDIF !NEXTGEN}
    else
      L := 1;
    Inc(I, L);
  until (I > Index);

  if (L <> 1) then
    if (I - L = Index) then
      Result := mbLeadByte
    else
      Result := mbTrailByte;
end;
{$ENDIF POSIX}

function ByteType(const S: AnsiString; Index: Integer): TMbcsByteType;
begin
  Result := mbSingleByte;
  if SysLocale.FarEast then
    Result := ByteTypeTest(PByte(MarshaledAString(S)), Index-1);
end;

function StrByteType(Str: PAnsiChar; Index: Cardinal): TMbcsByteType;
begin
  Result := mbSingleByte;
  if SysLocale.FarEast then
    Result := ByteTypeTest(PByte(Str), Index);
end;

function ElementToCharLen(const S: AnsiString; MaxLen: Integer): Integer;
begin
  if Length(S) < MaxLen then MaxLen := Length(S);
  Result := System.AnsiStrings.ByteToCharIndex(S, MaxLen);
end;

function ByteToCharLen(const S: AnsiString; MaxLen: Integer): Integer;
begin
  Result := System.AnsiStrings.ElementToCharLen(S, MaxLen);
end;

function ElementToCharIndex(const S: AnsiString; Index: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  if (Index <= 0) or (Index > Length(S)) then Exit;
  Result := Index;
  if not SysLocale.FarEast then Exit;
  I := 1;
  Result := 0;
  while I <= Index do
  begin
    if IsLeadChar(S[I]) then
      I := AnsiNextCharIndex(S, I)
    else
      Inc(I);
    Inc(Result);
  end;
end;


function ByteToCharIndex(const S: AnsiString; Index: Integer): Integer;
begin
  Result := System.AnsiStrings.ElementToCharIndex(S, Index);
end;

procedure CountChars(const S: AnsiString; MaxChars: Integer; var CharCount, ByteCount: Integer); overload;
var
  C, L, B: Integer;
begin
  L := Length(S) * SizeOf(Char);
  C := 1;
  B := 1;
  while (B < L) and (C < MaxChars) do
  begin
    Inc(C);
    if IsLeadChar(S[B]) then
      B := AnsiNextCharIndex(S, B)
    else
      Inc(B);
  end;
  if (C = MaxChars) and (B < L) and IsLeadChar(S[B]) then
    B := AnsiNextCharIndex(S, B) - 1;
  CharCount := C;
  ByteCount := B;
end;

function CharToElementIndex(const S: AnsiString; Index: Integer): Integer;
var
  Chars: Integer;
begin
  Result := 0;
  if (Index <= 0) or (Index > Length(S)) then Exit;
  if (Index > 1) and SysLocale.FarEast then
  begin
    CountChars(S, Index-1, Chars, Result);
    if (Chars < (Index-1)) or (Result >= Length(S)) then
      Result := 0  // Char index out of range
    else
      Inc(Result);
  end
  else
    Result := Index;
end;

function CharToByteIndex(const S: AnsiString; Index: Integer): Integer;
begin
  Result := System.AnsiStrings.CharToElementIndex(S, Index);
end;

function CharToElementLen(const S: AnsiString; MaxLen: Integer): Integer;
var
  Chars: Integer;
begin
  Result := 0;
  if MaxLen <= 0 then Exit;
  if MaxLen > Length(S) then MaxLen := Length(S);
  if SysLocale.FarEast then
  begin
    CountChars(S, MaxLen, Chars, Result);
    if Result > Length(S) then
      Result := Length(S);
  end
  else
    Result := MaxLen;
end;

function CharToByteLen(const S: AnsiString; MaxLen: Integer): Integer;
begin
  Result := System.AnsiStrings.CharToElementLen(S, MaxLen);
end;

function StrNextChar(const Str: PAnsiChar): PAnsiChar;
{$IFDEF MSWINDOWS}
begin
  Result := CharNextA(Str);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
begin
  Result := Str + System.AnsiStrings.StrCharLength(Str);
end;
{$ENDIF POSIX}

function StrCharLength(const Str: MarshaledAString): Integer;
const
  chZERO: AnsiChar = #0;
{$IFDEF MSWINDOWS}
begin
  if SysLocale.FarEast and (Str^ <> chZERO) then
    Result := IntPtr(AnsiNext(MarshaledAString(Str))) - IntPtr(Str)
  else
    Result := 1;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
begin
  Result := mblen(MarshaledAString(Str), MB_CUR_MAX);
  if (Result = -1) then Result := 1;
end;
{$ENDIF POSIX}


{$ENDREGION}

{$REGION 'Code From StrUtils'}
function LeftStr(const AText: AnsiString; const ACount: Integer): AnsiString; overload;
begin
  Result := Copy(AText, 1, ACount);
end;

function RightStr(const AText: AnsiString; const ACount: Integer): AnsiString; overload;
begin
  Result := Copy(AText, Length(AText) + 1 - ACount, ACount);
end;

function MidStr(const AText: AnsiString; const AStart, ACount: Integer): AnsiString; overload;
begin
  Result := Copy(AText, AStart, ACount);
end;

function LeftBStr(const AText: AnsiString; const AByteCount: Integer): AnsiString;
begin
  Result := Copy(AText, 1, AByteCount);
end;

function RightBStr(const AText: AnsiString; const AByteCount: Integer): AnsiString;
begin
  Result := Copy(AText, Length(AText) + 1 - AByteCount, AByteCount);
end;

function MidBStr(const AText: AnsiString; const AByteStart, AByteCount: Integer): AnsiString;
begin
  Result := Copy(AText, AByteStart, AByteCount);
end;


function SearchBuf(Buf: PAnsiChar; BufLen: Integer; SelStart, SelLength: Integer;
  SearchString: AnsiString; Options: TStringSearchOptions): PAnsiChar;
var
  SearchCount, I: Integer;
  C: AnsiChar;
  Direction: Shortint;
  ShadowMap: array[0..256] of AnsiChar;
  CharMap: array [AnsiChar] of AnsiChar absolute ShadowMap;

  function FindNextWordStart(var BufPtr: PAnsiChar): Boolean;
  begin                   { (True XOR N) is equivalent to (not N) }
                          { (False XOR N) is equivalent to (N)    }
     { When Direction is forward (1), skip non delimiters, then skip delimiters. }
     { When Direction is backward (-1), skip delims, then skip non delims }
    while (SearchCount > 0) and
          ((Direction = 1) xor (Byte(BufPtr^) in WordDelimiters)) do
    begin
      Inc(BufPtr, Direction);
      Dec(SearchCount);
    end;
    while (SearchCount > 0) and
          ((Direction = -1) xor (Byte(BufPtr^) in WordDelimiters)) do
    begin
      Inc(BufPtr, Direction);
      Dec(SearchCount);
    end;
    Result := SearchCount > 0;
    if Direction = -1 then
    begin   { back up one char, to leave ptr on first non delim }
      Dec(BufPtr, Direction);
      Inc(SearchCount);
    end;
  end;

begin
  Result := nil;
  if BufLen <= 0 then Exit;
  if soDown in Options then
  begin
    Direction := 1;
    Inc(SelStart, SelLength);  { start search past end of selection }
    SearchCount := BufLen - SelStart - Length(SearchString) + 1;
    if SearchCount < 0 then Exit;
    if Longint(SelStart) + SearchCount > BufLen then Exit;
  end
  else
  begin
    Direction := -1;
    Dec(SelStart, Length(SearchString));
    SearchCount := SelStart + 1;
  end;
  if (SelStart < 0) or (SelStart > BufLen) then Exit;
  Result := @Buf[SelStart];

  { Using a Char map array is faster than calling AnsiUpper on every character }
  for C := Low(CharMap) to High(CharMap) do
    CharMap[(C)] := (C);
  { Since CharMap is overlayed onto the ShadowMap and ShadowMap is 1 byte longer,
    we can use that extra byte as a guard NULL }
  ShadowMap[256] := #0;

  if not (soMatchCase in Options) then
  begin
{$IFDEF MSWINDOWS}
    CharUpperBuffA(PAnsiChar(@CharMap), Length(CharMap));
    CharUpperBuffA(@SearchString[1], Length(SearchString));
{$ENDIF}
{$IFDEF POSIX}
    System.AnsiStrings.AnsiStrUpper(PAnsiChar(@CharMap[#1]));
    System.AnsiStrings.AnsiStrUpper(PAnsIChar(@SearchString[1]));
{$ENDIF POSIX}
  end;

  while SearchCount > 0 do
  begin
    if (soWholeWord in Options) and (Result <> @Buf[SelStart]) then
      if not FindNextWordStart(Result) then Break;
    I := 0;
    while (CharMap[(Result[I])] = (SearchString[I+1])) do
    begin
      Inc(I);
      if I >= Length(SearchString) then
      begin
        if (not (soWholeWord in Options)) or
           (SearchCount = 0) or
           ((Byte(Result[I])) in WordDelimiters) then
          Exit;
        Break;
      end;
    end;
    Inc(Result, Direction);
    Dec(SearchCount);
  end;
  Result := nil;
end;

{$ENDREGION}

end.

