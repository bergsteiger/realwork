{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit System.StrUtils;

interface

{$IFDEF CPUX86}
  {$DEFINE X86ASM}
{$ELSE !CPUX86}
  {$DEFINE PUREPASCAL}
{$ENDIF !CPUX86}

uses
  System.Types;

{$WARN WIDECHAR_REDUCED OFF}

{ AnsiResemblesText returns true if the two strings are similar (using a
  Soundex algorithm or something similar) }

function ResemblesText(const AText, AOther: string): Boolean; overload;
function AnsiResemblesText(const AText, AOther: string): Boolean; overload;

{ AnsiContainsText returns true if the subtext is found, without
  case-sensitivity, in the given text }

function ContainsText(const AText, ASubText: string): Boolean; inline; overload;
function AnsiContainsText(const AText, ASubText: string): Boolean; overload;

{ AnsiStartsText & AnsiEndText return true if the leading or trailing part
  of the given text matches, without case-sensitivity, the subtext }

function StartsText(const ASubText, AText: string): Boolean; inline; overload;
function AnsiStartsText(const ASubText, AText: string): Boolean; overload;

function EndsText(const ASubText, AText: string): Boolean; inline; overload;
function AnsiEndsText(const ASubText, AText: string): Boolean; inline; overload;

{ AnsiReplaceText will replace all occurrences of a substring, without
  case-sensitivity, with another substring (recursion substring replacement
  is not supported) }

function ReplaceText(const AText, AFromText, AToText: string): string; inline; overload;
function AnsiReplaceText(const AText, AFromText, AToText: string): string; overload;

{ AnsiMatchText & AnsiIndexText provide case like function for dealing with
  strings }

function MatchText(const AText: string; const AValues: array of string): Boolean; overload;
function AnsiMatchText(const AText: string; const AValues: array of string): Boolean; overload;

function IndexText(const AText: string; const AValues: array of string): Integer; overload;
function AnsiIndexText(const AText: string; const AValues: array of string): Integer; overload;

{ These function are similar to some of the above but are case-sensitive }

function ContainsStr(const AText, ASubText: string): Boolean; inline; overload;
function AnsiContainsStr(const AText, ASubText: string): Boolean; overload;

function StartsStr(const ASubText, AText: string): Boolean; inline; overload;
function AnsiStartsStr(const ASubText, AText: string): Boolean; overload;

function EndsStr(const ASubText, AText: string): Boolean; inline; overload;
function AnsiEndsStr(const ASubText, AText: string): Boolean; overload;

function ReplaceStr(const AText, AFromText, AToText: string): string; inline; overload;
function AnsiReplaceStr(const AText, AFromText, AToText: string): string; overload;

function MatchStr(const AText: string; const AValues: array of string): Boolean; overload;
function AnsiMatchStr(const AText: string; const AValues: array of string): Boolean; overload;

function IndexStr(const AText: string; const AValues: array of string): Integer; overload;
function AnsiIndexStr(const AText: string; const AValues: array of string): Integer; overload;

{ DupeString will return N copies of the given string }

function DupeString(const AText: string; ACount: Integer): string; overload;

{ ReverseString simply reverses the given string }

function ReverseString(const AText: string): string; overload;
function AnsiReverseString(const AText: string): string; overload;

{ StuffString replaces a segment of a string with another one }

function StuffString(const AText: string; AStart, ALength: Cardinal;
  const ASubText: string): string; overload;

{ RandomFrom will randomly return one of the given strings }

function RandomFrom(const AValues: array of string): string; overload;

{ IfThen will return the true string if the value passed in is true, else
  it will return the false string }

function IfThen(AValue: Boolean; const ATrue: string;
  AFalse: string = ''): string; overload; inline;

{ SplitString splits a string into different parts delimited by the
  specified delimiter characters }

function SplitString(const S, Delimiters: string): TStringDynArray;

{ Basic-like functions / Left, Right, Mid }

{$IFNDEF NEXTGEN}
function LeftStr(const AText: AnsiString; const ACount: Integer): AnsiString; overload; deprecated 'Moved to the AnsiStrings unit';
function RightStr(const AText: AnsiString; const ACount: Integer): AnsiString; overload; deprecated 'Moved to the AnsiStrings unit';
function MidStr(const AText: AnsiString; const AStart, ACount: Integer): AnsiString; overload; deprecated 'Moved to the AnsiStrings unit';

{ Basic-like functions / LeftB, RightB, MidB
  these functions don't care locale information.}

function LeftBStr(const AText: AnsiString; const AByteCount: Integer): AnsiString; deprecated 'Moved to the AnsiStrings unit';
function RightBStr(const AText: AnsiString; const AByteCount: Integer): AnsiString; deprecated 'Moved to the AnsiStrings unit';
function MidBStr(const AText: AnsiString; const AByteStart, AByteCount: Integer): AnsiString; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}

function LeftStr(const AText: string; const ACount: Integer): string; overload;
function RightStr(const AText: string; const ACount: Integer): string; overload;
function MidStr(const AText: string; const AStart, ACount: Integer): string; overload;

{ Basic-like functions / Delphi style function name }

function AnsiLeftStr(const AText: string; const ACount: Integer): string; overload;
function AnsiRightStr(const AText: string; const ACount: Integer): string; overload;
function AnsiMidStr(const AText: string; const AStart, ACount: Integer): string; overload;


type
  TStringSeachOption = (soDown, soMatchCase, soWholeWord);
  TStringSearchOptions = set of TStringSeachOption;

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

{$IFNDEF NEXTGEN}
function SearchBuf(Buf: PAnsiChar; BufLen: Integer; SelStart, SelLength: Integer;
  SearchString: AnsiString; Options: TStringSearchOptions = [soDown]): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF}

{$IFDEF UNICODE}
function SearchBuf(Buf: PChar; BufLen: Integer; SelStart, SelLength: Integer;
  SearchString: String; Options: TStringSearchOptions = [soDown]): PChar; overload;
{$ENDIF}


{ PosEx searches for SubStr in S and returns the index position of
  SubStr if found and 0 otherwise.  If Offset is not given then the result is
  the same as calling Pos.  If Offset is specified and > 1 then the search
  starts at position Offset within S.  If Offset is larger than Length(S)
  then PosEx returns 0.  By default, Offset equals 1.  }

function PosEx(const SubStr, S: string; Offset: Integer = 1): Integer; inline; overload;

{ Soundex function returns the Soundex code for the given string.  Unlike
  the original Soundex routine this function can return codes of varying
  lengths.  This function is loosely based on SoundBts which was written
  by John Midwinter.  For more information about Soundex see:

    http://www.nara.gov/genealogy/coding.html

  The general theory behind this function was originally patented way back in
  1918 (US1261167 & US1435663) but are now in the public domain.

  NOTE: This function does not attempt to deal with 'names with prefixes'
        issue.
  }

type
  TSoundexLength = 1..MaxInt;

function Soundex(const AText: string; ALength: TSoundexLength = 4): string;

{ SoundexInt uses Soundex but returns the resulting Soundex code encoded
  into an integer.  However, due to limits on the size of an integer, this
  function is limited to Soundex codes of eight characters or less.

  DecodeSoundexInt is designed to decode the results of SoundexInt back to
  a normal Soundex code.  Length is not required since it was encoded into
  the results of SoundexInt. }

type
  TSoundexIntLength = 1..8;

function SoundexInt(const AText: string; ALength: TSoundexIntLength = 4): Integer;
function DecodeSoundexInt(AValue: Integer): string;

{ SoundexWord is a special case version of SoundexInt that returns the
  Soundex code encoded into a word.  However, due to limits on the size of a
  word, this function uses a four character Soundex code.

  DecodeSoundexWord is designed to decode the results of SoundexWord back to
  a normal Soundex code. }

function SoundexWord(const AText: string): Word;
function DecodeSoundexWord(AValue: Word): string;

{ SoundexSimilar and SoundexCompare are simple comparison functions that use
  the Soundex encoding function. }

function SoundexSimilar(const AText, AOther: string;
  ALength: TSoundexLength = 4): Boolean;
function SoundexCompare(const AText, AOther: string;
  ALength: TSoundexLength = 4): Integer;

{ Default entry point for AnsiResemblesText }

function SoundexProc(const AText, AOther: string): Boolean;

type
  TCompareTextProc = function(const AText, AOther: string): Boolean;

{ If the default behavior of AnsiResemblesText (using Soundex) is not suitable
  for your situation, you can redirect it to a function of your own choosing }

var
  ResemblesProc: TCompareTextProc = SoundexProc;
  AnsiResemblesProc: TCompareTextProc = SoundexProc;

implementation

uses
{$IFDEF MSWINDOWS}
   Winapi.Windows,
{$ENDIF MSWINDOWS}
  System.SysUtils, System.Character;

function ResemblesText(const AText, AOther: string): Boolean;
begin
  Result := False;
  if Assigned(ResemblesProc) then
    Result := ResemblesProc(AText, AOther);
end;

function AnsiResemblesText(const AText, AOther: string): Boolean;
begin
  Result := False;
  if Assigned(AnsiResemblesProc) then
    Result := AnsiResemblesProc(AText, AOther);
end;

function ContainsText(const AText, ASubText: string): Boolean;
begin
  Result := AnsiContainsText(AText, ASubText);
end;

function AnsiContainsText(const AText, ASubText: string): Boolean;
begin
  Result := AnsiPos(AnsiUppercase(ASubText), AnsiUppercase(AText)) > 0;
end;

function StartsText(const ASubText, AText: string): Boolean;
begin
  Result := AnsiStartsText(ASubText, AText);
end;

function AnsiStartsText(const ASubText, AText: string): Boolean;
var
{$IFDEF MSWINDOWS}
  P: PChar;
{$ENDIF}
  L, L2: Integer;
begin
{$IFDEF MSWINDOWS}
  P := PChar(AText);
{$ENDIF}
  L := Length(ASubText);
  L2 := Length(AText);
  if L > L2 then
    Result := False
  else
{$IFDEF MSWINDOWS}
    Result := CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
      P, L, PChar(ASubText), L) = 2;
{$ENDIF}
{$IFDEF POSIX}
    Result := SameText(ASubText, Copy(AText, 1, L));
{$ENDIF}
end;

function EndsText(const ASubText, AText: string): Boolean;
begin
  Result := AnsiEndsText(ASubText, AText);
end;

function AnsiEndsText(const ASubText, AText: string): Boolean;
begin
  Result := string.EndsText(ASubTExt, AText);
end;

function ReplaceStr(const AText, AFromText, AToText: string): string;
begin
  Result := AnsiReplaceStr(AText, AFromText, AToText);
end;

function AnsiReplaceStr(const AText, AFromText, AToText: string): string;
begin
  Result := StringReplace(AText, AFromText, AToText, [rfReplaceAll]);
end;

function ReplaceText(const AText, AFromText, AToText: string): string;
begin
  Result := AnsiReplaceText(AText, AFromText, AToText);
end;

function AnsiReplaceText(const AText, AFromText, AToText: string): string;
begin
  Result := StringReplace(AText, AFromText, AToText, [rfReplaceAll, rfIgnoreCase]);
end;

function MatchText(const AText: string; const AValues: array of string): Boolean;
begin
  Result := AnsiMatchText(AText, AValues);
end;

function AnsiMatchText(const AText: string; const AValues: array of string): Boolean;
begin
  Result := AnsiIndexText(AText, AValues) <> -1;
end;

function IndexText(const AText: string; const AValues: array of string): Integer;
begin
  Result := AnsiIndexText(AText, AValues);
end;

function AnsiIndexText(const AText: string; const AValues: array of string): Integer;
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

function ContainsStr(const AText, ASubText: string): Boolean;
begin
  Result := AnsiContainsStr(AText, ASubText);
end;

function AnsiContainsStr(const AText, ASubText: string): Boolean;
begin
  Result := AnsiPos(ASubText, AText) > 0;
end;

function StartsStr(const ASubText, AText: string): Boolean;
begin
  Result := AnsiStartsStr(ASubText, AText);
end;

function AnsiStartsStr(const ASubText, AText: string): Boolean;
begin
  Result := AnsiSameStr(ASubText, Copy(AText, 1, Length(ASubText)));
end;

function EndsStr(const ASubText, AText: string): Boolean;
begin
  Result := AText.EndsWith(ASubText);
end;

function AnsiEndsStr(const ASubText, AText: string): Boolean;
const
  StrAdjust = 1 - Low(string);
var
  SubTextLocation: Integer;
begin
  SubTextLocation := Length(AText) - Length(ASubText) + 1;
  if (SubTextLocation > 0) and (ASubText <> '') and
     (ByteType(AText, SubTextLocation) <> mbTrailByte) then
    Result := AnsiStrComp(PChar(ASubText), PChar(@AText[SubTextLocation - StrAdjust])) = 0
  else
    Result := False;
end;

function MatchStr(const AText: string; const AValues: array of string): Boolean;
begin
  Result := AnsiMatchStr(AText, AValues);
end;

function AnsiMatchStr(const AText: string; const AValues: array of string): Boolean;
begin
  Result := AnsiIndexStr(AText, AValues) <> -1;
end;

function IndexStr(const AText: string; const AValues: array of string): Integer;
begin
  Result := AnsiIndexStr(AText, AValues);
end;

function AnsiIndexStr(const AText: string; const AValues: array of string): Integer;
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

function DupeString(const AText: string; ACount: Integer): string;
var
  P: PChar;
  C: Integer;
begin
  C := Length(AText);
  SetLength(Result, C * ACount);
  P := Pointer(Result);
  if P = nil then Exit;
  while ACount > 0 do
  begin
    Move(Pointer(AText)^, P^, C * SizeOf(Char));
    Inc(P, C);
    Dec(ACount);
  end;
end;

function ReverseString(const AText: string): string;
var
  I: Integer;
  P: PChar;
begin
  SetLength(Result, Length(AText));
  P := PChar(Result);
  for I := High(AText) downto Low(AText) do
  begin
    P^ := AText[I];
    Inc(P);
  end;
end;

function AnsiReverseString(const AText: string): string;
var
  I: Integer;
  Len, CharLen: Integer;
  P, R, Tail: PWideChar;
begin
  Result := '';
  Len := Length(AText);
  if Len > 0 then
  begin
    SetLength(Result, Len);
    P := PWideChar(AText);
    R := PWideChar(Result) + Len;
    Tail := P + Len;
    while P < Tail do
    begin
      CharLen := 1;
      if IsLeadChar(P^) then
        CharLen := StrNextChar(P) - P;
      Dec(R, CharLen);
      for I := 0 to CharLen - 1 do
        R[I] := P[I];
      Inc(P, CharLen);
    end;
  end;
end;

function StuffString(const AText: string; AStart, ALength: Cardinal;
  const ASubText: string): string;
begin
  Result := Copy(AText, 1, AStart - 1) +
            ASubText +
            Copy(AText, AStart + ALength, MaxInt);
end;

function RandomFrom(const AValues: array of string): string;
begin
  Result := AValues[Random(High(AValues) + 1)];
end;

function IfThen(AValue: Boolean; const ATrue: string;
  AFalse: string = ''): string;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function SplitString(const S, Delimiters: string): TStringDynArray;
var
  StartIdx: Integer;
  FoundIdx: Integer;
  SplitPoints: Integer;
  CurrentSplit: Integer;
  i: Integer;
begin
  Result := nil;

  if S <> '' then
  begin
    { Determine the length of the resulting array }
    SplitPoints := 0;
    for i := 1 to S.Length do
      if IsDelimiter(Delimiters, S, i) then
        Inc(SplitPoints);

    SetLength(Result, SplitPoints + 1);

    { Split the string and fill the resulting array }
    StartIdx := 1;
    CurrentSplit := 0;
    repeat
      FoundIdx := FindDelimiter(Delimiters, S, StartIdx);
      if FoundIdx <> 0 then
      begin
        Result[CurrentSplit] := Copy(S, StartIdx, FoundIdx - StartIdx);
        Inc(CurrentSplit);
        StartIdx := FoundIdx + 1;
      end;
    until CurrentSplit = SplitPoints;

    // copy the remaining part in case the string does not end in a delimiter
    Result[SplitPoints] := Copy(S, StartIdx, S.Length - StartIdx + 1);
  end;
end;

{$IFNDEF NEXTGEN}
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
{$ENDIF}

function LeftStr(const AText: string; const ACount: Integer): string; overload;
begin
  Result := Copy(AText, 1, ACount);
end;

function RightStr(const AText: string; const ACount: Integer): string; overload;
begin
  Result := Copy(AText, Length(AText) + 1 - ACount, ACount);
end;

function MidStr(const AText: string; const AStart, ACount: Integer): string; overload;
begin
  Result := Copy(AText, AStart, ACount);
end;


function AnsiCountElems(const AText: UnicodeString; AStartIndex, ACharCount: Integer): Integer;
var
  S, P: PWideChar;
  Len, CharLen: Integer;
begin
  Result := 0;
  if AStartIndex <= 0 then
    AStartIndex := 1;
  Len := Length(AText) - AStartIndex + 1;
  if Len > 0 then
  begin
    P := PWideChar(AText) + AStartIndex - 1;
    S := P;
    while (Len > 0) and (ACharCount > 0) do
    begin
      CharLen := 1;
      if IsLeadChar(P^) then
        CharLen := StrNextChar(P) - P;
      if CharLen > Len then
        CharLen := Len;
      Inc(P, CharLen);
      Dec(Len, CharLen);
      Dec(ACharCount);
    end;
    Result := P - S;
  end;
end;

function AnsiCountChars(const AText: UnicodeString): Integer;
var
  P: PWideChar;
  Len, CharLen: Integer;
begin
  Result := 0;
  Len := Length(AText);
  if Len > 0 then
  begin
    P := PWideChar(AText);
    while Len > 0 do
    begin
      CharLen := 1;
      if IsLeadChar(P^) then
        CharLen := StrNextChar(P) - P;
      if CharLen > Len then
        CharLen := Len;
      Inc(P, CharLen);
      Dec(Len, CharLen);
      Inc(Result);
    end;
  end;
end;

function AnsiLeftStr(const AText: string; const ACount: Integer): string;
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

function AnsiRightStr(const AText: string; const ACount: Integer): string;
var
  CharCount: Integer;
begin
  Result := '';
  CharCount := AnsiCountChars(AText);
  if CharCount > 0 then
    Result := AnsiMidStr(AText, CharCount - ACount + 1, ACount);
end;

function AnsiMidStr(const AText: string; const AStart, ACount: Integer): string;
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

{$IFNDEF NEXTGEN}
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
    AnsiStrUpper(PAnsiChar(@CharMap[#1]));
    AnsiStrUpper(PAnsIChar(@SearchString[1]));
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
{$ENDIF !NEXTGEN}

{$IFDEF UNICODE}
function SearchBuf(Buf: PChar; BufLen: Integer; SelStart, SelLength: Integer;
  SearchString: string; Options: TStringSearchOptions): PChar;
var
  SearchCount, I: Integer;
  Direction: Shortint;

  function FindNextWordStart(var BufPtr: PChar): Boolean;
  begin                   { (True XOR N) is equivalent to (not N) }
                          { (False XOR N) is equivalent to (N)    }
     { When Direction is forward (1), skip non delimiters, then skip delimiters. }
     { When Direction is backward (-1), skip delims, then skip non delims }
    while (SearchCount > 0) and
          ((Direction = -1) xor (not BufPtr^.IsLetterOrDigit)) do
    begin
      Inc(BufPtr, Direction);
      Dec(SearchCount);
    end;
    while (SearchCount > 0) and
          ((Direction = -1) xor (not BufPtr^.IsLetterOrDigit)) do
    begin
      Inc(BufPtr, Direction);
      Dec(SearchCount);
    end;
    Result := SearchCount > 0;
    if Direction = -1 then
    begin   { back up one WideChar, to leave ptr on first non delim }
      Dec(BufPtr, Direction);
      Inc(SearchCount);
    end;
  end;

  function NextChar(S: PChar): Char;
  begin
    if not (soMatchCase in Options) then
      Result := Char(S[I]).ToUpper
    else
      Result := S[I];
  end;

begin
  Result := nil;
  if BufLen <= 0 then Exit;
  if soDown in Options then
  begin
    Direction := 1;
    Inc(SelStart, SelLength);  { start search past end of selection }
    SearchCount := BufLen - SelStart - SearchString.Length + 1;
    if SearchCount < 0 then Exit;
    if Longint(SelStart) + SearchCount > BufLen then Exit;
  end
  else
  begin
    Direction := -1;
    Dec(SelStart, SearchString.Length);
    SearchCount := SelStart + 1;
  end;
  if (SelStart < 0) or (SelStart > BufLen) then Exit;
  Result := @Buf[SelStart];

  if not (soMatchCase in Options) then
     SearchString := Char.ToUpper(SearchString);

  while SearchCount > 0 do
  begin
    if (soWholeWord in Options) and (Result <> @Buf[SelStart]) then
      if not FindNextWordStart(Result) then Break;
    I := 0;
    while NextChar(Result) = SearchString[I+Low(string)] do
    begin
      Inc(I);
      if I >= Length(SearchString) then
      begin
        if (not (soWholeWord in Options)) or
           (SearchCount = 0) or
           (not Char(Result[I]).IsLetterOrDigit) then
          Exit;
        Break;
      end;
    end;
    Inc(Result, Direction);
    Dec(SearchCount);
  end;
  Result := nil;
end;
{$ENDIF}

function PosEx(const SubStr, S: string; Offset: Integer): Integer;
begin
  Result := System.Pos(SubStr, S, Offset);
end;

{ This function is loosely based on SoundBts which was written by John Midwinter }
function Soundex(const AText: string; ALength: TSoundexLength): string;
const

  // This table gives the Soundex score for all characters upper- and lower-
  // case hence no need to convert.  This is faster than doing an UpCase on the
  // whole input string.  The 5 non characters in middle are just given 0.
  CSoundexTable: array[65..122] of Integer =
  // A  B  C  D  E  F  G  H   I  J  K  L  M  N  O  P  Q  R  S  T  U  V  W   X  Y  Z
    (0, 1, 2, 3, 0, 1, 2, -1, 0, 2, 2, 4, 5, 5, 0, 1, 2, 6, 2, 3, 0, 1, -1, 2, 0, 2,
  // [  /  ]  ^  _  '
     0, 0, 0, 0, 0, 0,
  // a  b  c  d  e  f  g  h   i  j  k  l  m  n  o  p  q  r  s  t  u  v  w   x  y  z
     0, 1, 2, 3, 0, 1, 2, -1, 0, 2, 2, 4, 5, 5, 0, 1, 2, 6, 2, 3, 0, 1, -1, 2, 0, 2);

  function Score(AChar: Integer): Integer;
  begin
    Result := 0;
    if (AChar >= Low(CSoundexTable)) and (AChar <= High(CSoundexTable)) then
      Result := CSoundexTable[AChar];
  end;

var
  I, LScore, LPrevScore: Integer;
  Str: PChar;
begin
  Result := '';
  if AText <> '' then
  begin
    Str := PChar(@AText[Low(string)+1]);
    Result := Upcase(AText[Low(string)]);
    LPrevScore := Score(Integer(AText[Low(string)]));
    for I := 2 to AText.Length do
    begin
      LScore := Score(Integer(Str^));
      if (LScore > 0) and (LScore <> LPrevScore) then
      begin
        Result := Result + IntToStr(LScore);
        if Result.Length = ALength then
          Break;
      end;
      if LScore <> -1 then
        LPrevScore := LScore;
      Inc(Str);
    end;
    if Result.Length < ALength then
      Result := Copy(Result + DupeString('0', ALength), 1, ALength);
  end;
end;

function SoundexInt(const AText: string; ALength: TSoundexIntLength): Integer;
var
  LResult: string;
  I: Integer;
begin
  Result := 0;
  if AText <> '' then
  begin
    LResult := Soundex(AText, ALength);
    Result := Ord(LResult.Chars[0]) - Ord('A');
    if ALength > 1 then
    begin
      Result := Result * 26 + StrToInt(LResult.Chars[1]);
      for I := 3 to ALength do
        Result := Result * 7 + StrToInt(LResult.Chars[I-1]);
    end;
    Result := Result * 9 + ALength;
  end;
end;

function DecodeSoundexInt(AValue: Integer): string;
var
  I, LLength: Integer;
begin
  Result := '';
  LLength := AValue mod 9;
  AValue := AValue div 9;
  for I := LLength downto 3 do
  begin
    Result := IntToStr(AValue mod 7) + Result;
    AValue := AValue div 7;
  end;
  if LLength > 2 then
    Result := IntToStr(AValue mod 26) + Result;
  AValue := AValue div 26;
  Result := Chr(AValue + Ord('A')) + Result;
end;

function SoundexWord(const AText: string): Word;
var
  LResult: string;
begin
  LResult := Soundex(AText, 4);
  Result := Ord(LResult.Chars[0]) - Ord('A');
  Result := Result * 26 + StrToInt(LResult.Chars[1]);
  Result := Result * 7 + StrToInt(LResult.Chars[2]);
  Result := Result * 7 + StrToInt(LResult.Chars[3]);
end;

function DecodeSoundexWord(AValue: Word): string;
begin
  Result := IntToStr(AValue mod 7) + Result;
  AValue := AValue div 7;
  Result := IntToStr(AValue mod 7) + Result;
  AValue := AValue div 7;
  Result := IntToStr(AValue mod 26) + Result;
  AValue := AValue div 26;
  Result := Chr(AValue + Ord('A')) + Result;
end;

function SoundexSimilar(const AText, AOther: string; ALength: TSoundexLength): Boolean;
begin
  Result := Soundex(AText, ALength) = Soundex(AOther, ALength);
end;

function SoundexCompare(const AText, AOther: string; ALength: TSoundexLength): Integer;
begin
  Result := AnsiCompareStr(Soundex(AText, ALength), Soundex(AOther, ALength));
end;

function SoundexProc(const AText, AOther: string): Boolean;
begin
  Result := SoundexSimilar(AText, AOther);
end;

end.
