{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.MaskUtils;

{$R-,T-,H+,X+}
{$WARN WIDECHAR_REDUCED OFF}

interface

const
  mDirReverse = '!';         { removes leading blanks if true, else trailing blanks}
  mDirUpperCase = '>';       { all chars that follow to upper case }
  mDirLowerCase = '<';       { all chars that follow to lower case }
                             { '<>' means remove casing directive }
  mDirLiteral = '\';         { char that immediately follows is a literal }

  mMskAlpha = 'L';           { in US = A-Z,a-z }
  mMskAlphaOpt = 'l';
  mMskAlphaNum = 'A';        { in US = A-Z,a-z,0-9 }
  mMskAlphaNumOpt  = 'a';
  mMskAscii = 'C';           { any character}
  mMskAsciiOpt = 'c';
  mMskNumeric = '0';         { 0-9, no plus or minus }
  mMskNumericOpt = '9';
  mMskNumSymOpt = '#';       { 0-9, plus and minus }

   { intl literals }
  mMskTimeSeparator = ':';
  mMskDateSeparator = '/';

type
  TMaskCharType = (mcNone, mcLiteral, mcIntlLiteral, mcDirective, mcMask,
    mcMaskOpt, mcFieldSeparator, mcField);
  TMaskDirectives = set of (mdReverseDir, mdUpperCase, mdLowerCase,
    mdLiteralChar);
  TMaskedText = type string;
  TEditMask = type string;

function FormatMaskText(const EditMask: string; const Value: string): string;
function MaskGetMaskSave(const EditMask: string): Boolean;
function MaskGetMaskBlank(const EditMask: string): Char;
function MaskGetFldSeparator(const EditMask: string): Integer;
function PadInputLiterals(const EditMask: String; const Value: string; Blank: Char): string;
function MaskOffsetToOffset(const EditMask: String; MaskOffset: Integer): Integer;
function MaskOffsetToWideOffset(const EditMask: String; MaskOffset: Integer): Integer;
function IsLiteralChar(const EditMask: string; Offset: Integer): Boolean;
function MaskGetCharType(const EditMask: string; MaskOffset: Integer): TMaskCharType;
function MaskGetCurrentDirectives(const EditMask: string; MaskOffset: Integer): TMaskDirectives;
function MaskIntlLiteralToChar(IChar: Char): Char;
function OffsetToMaskOffset(const EditMask: string; Offset: Integer): Integer;
function MaskDoFormatText(const EditMask: string; const Value: string; Blank: Char): string;

var
  DefaultBlank: Char = '_';
  MaskFieldSeparator: Char = ';';
  MaskNoSave: Char = '0';

implementation

uses
  System.SysUtils;

{ Mask utility routines }

function MaskGetCharType(const EditMask: string; MaskOffset: Integer): TMaskCharType;
var
  MaskChar: Char;
begin
  Result := mcLiteral;
  MaskChar := #0;
  if MaskOffset <= EditMask.Length then
    MaskChar := EditMask.Chars[MaskOffset-1];
  if MaskOffset > EditMask.Length then
    Result := mcNone

  else if ByteType(EditMask, MaskOffset) <> mbSingleByte then
    Result := mcLiteral

  else if (MaskOffset > 1) and (EditMask.Chars[MaskOffset - 1 - 1] = mDirLiteral) and
      (ByteType(EditMask, MaskOffset - 1) = mbSingleByte) and
      not ((MaskOffset > 2) and (EditMask.Chars[MaskOffset - 2 - 1] = mDirLiteral) and
      (ByteType(EditMask, MaskOffset - 2) = mbSingleByte)) then
    Result := mcLiteral

  else if (MaskChar = MaskFieldSeparator) and
         (EditMask.Length >= 4) and
         (MaskOffset > EditMask.Length - 4) then
    Result := mcFieldSeparator

  else if (EditMask.Length >= 4) and
         (MaskOffset > (EditMask.Length - 4)) and
         (EditMask.Chars[MaskOffset - 1 - 1] = MaskFieldSeparator) and
         not ((MaskOffset > 2) and (EditMask.Chars[MaskOffset - 2 - 1] = mDirLiteral) and
         (ByteType(EditMask, MaskOffset - 2) <> mbTrailByte)) then
    Result := mcField

  else if MaskChar in [mMskTimeSeparator, mMskDateSeparator] then
    Result := mcIntlLiteral

  else if MaskChar in [mDirReverse, mDirUpperCase, mDirLowerCase,
      mDirLiteral] then
    Result := mcDirective

  else if MaskChar in [mMskAlphaOpt, mMskAlphaNumOpt, mMskAsciiOpt,
      mMskNumSymOpt, mMskNumericOpt] then
    Result := mcMaskOpt

  else if MaskChar in [mMskAlpha, mMskAlphaNum, mMskAscii, mMskNumeric] then
    Result := mcMask;
end;

function MaskGetCurrentDirectives(const EditMask: string;
  MaskOffset: Integer): TMaskDirectives;
var
  I: Integer;
  MaskChar: Char;
begin
  Result := [];
  for I := 0 to EditMask.Length - 1 do
  begin
    MaskChar := EditMask.Chars[I];
    if (MaskChar = mDirReverse) then
      Include(Result, mdReverseDir)
    else if (MaskChar = mDirUpperCase) and (I < MaskOffset-1) then
    begin
      Exclude(Result, mdLowerCase);
      if not ((I > 0) and (EditMask.Chars[I-1] = mDirLowerCase)) then
        Include(Result, mdUpperCase);
    end
    else if (MaskChar = mDirLowerCase) and (I < MaskOffset-1) then
    begin
      Exclude(Result, mdUpperCase);
      Include(Result, mdLowerCase);
    end;
  end;
  if MaskGetCharType(EditMask, MaskOffset) = mcLiteral then
    Include(Result, mdLiteralChar);
end;

function MaskIntlLiteralToChar(IChar: Char): Char;
begin
  Result := IChar;
  case IChar of
    mMskTimeSeparator: Result := Char(FormatSettings.TimeSeparator);
    mMskDateSeparator: Result := Char(FormatSettings.DateSeparator);
  end;
end;

function MaskDoFormatText(const EditMask: string; const Value: string;
  Blank: Char): string;
var
  I: Integer;
  Offset, MaskOffset: Integer;
  CType: TMaskCharType;
  Dir: TMaskDirectives;
begin
  Result := Value;
  Dir := MaskGetCurrentDirectives(EditMask, 1);

  if not (mdReverseDir in Dir) then
  begin
    { starting at the beginning, insert literal chars in the string
      and add spaces on the end }
    Offset := 1;
    for MaskOffset := 1 to EditMask.Length do
    begin
      CType := MaskGetCharType(EditMask, MaskOffset);

      if CType in [mcLiteral, mcIntlLiteral] then
      begin
        Result := Result.SubString( 0, Offset - 1) +
          MaskIntlLiteralToChar(EditMask.Chars[MaskOffset-1]) +
          Result.SubString( Offset-1, Result.Length - Offset + 1);
        Inc(Offset);
      end
      else if CType in [mcMask, mcMaskOpt] then
      begin
        if Offset > Result.Length then
          Result := Result + Blank;
        Inc(Offset);
      end;
    end;
  end
  else
  begin
      { starting at the end, insert literal chars in the string
        and add spaces at the beginning }
    Offset := Result.Length;
    for I := 0 to (EditMask.Length - 1) do
    begin
      MaskOffset := EditMask.Length - I;
      CType := MaskGetCharType(EditMask, MaskOffset);
      if CType in [mcLiteral, mcIntlLiteral] then
      begin
        Result := Result.Substring( 0, Offset) +
               MaskIntlLiteralToChar(EditMask.Chars[MaskOffset-1]) +
               Result.SubString( Offset, Result.Length - Offset);
      end
      else if CType in [mcMask, mcMaskOpt] then
      begin
        if Offset < 1 then
          Result := Blank + Result
        else
          Dec(Offset);
      end;
    end;
  end;
end;

function MaskGetMaskSave(const EditMask: string): Boolean;
var
  I: Integer;
  Sep1, Sep2: Integer;
begin
  Result := True;
  if EditMask.Length >= 4 then
  begin
    Sep1 := -1;
    Sep2 := -1;
    I := EditMask.Length;
    while Sep2 < 0 do
    begin
      if (MaskGetCharType(EditMask, I) =  mcFieldSeparator) then
      begin
        if Sep1 < 0 then
          Sep1 := I
        else
          Sep2 := I;
      end;
      Dec(I);
      if (I <= 0) or(I < EditMask.Length - 4) then
        Break;
    end;
    if Sep2 < 0 then
      Sep2 := Sep1;
    if (Sep2 > 0) and (Sep2 <> EditMask.Length) then
      Result := not (EditMask.Chars[Sep2] = MaskNoSave);
  end;
end;

function MaskGetMaskBlank(const EditMask: string): Char;
begin
  Result := DefaultBlank;
  if EditMask.Length >= 4 then
  begin
    if (MaskGetCharType(EditMask, EditMask.Length - 1) = mcFieldSeparator) then
    begin
      {in order for blank specifier to be valid, there must also be a save specifier }
      if (MaskGetCharType(EditMask, EditMask.Length - 2) = mcFieldSeparator) or
        (MaskGetCharType(EditMask, EditMask.Length - 3) = mcFieldSeparator) then
      begin
        Result := EditMask.Chars[EditMask.Length-1];
      end;
    end;
  end;
end;

function MaskGetFldSeparator(const EditMask: String): Integer;
var
  I: Integer;
begin
  Result := -1;
  if EditMask.Length >= 4 then
  begin
    for I := (EditMask.Length - 4) to EditMask.Length do
    begin
      if (MaskGetCharType(EditMask, I) = mcFieldSeparator) then
      begin
        Result := I;
        Exit;
      end;
    end;
  end;
end;

function MaskOffsetToString(const EditMask: String; MaskOffset: Integer): string;
var
  I: Integer;
  CType: TMaskCharType;
begin
  Result := '';
  for I := 1 to MaskOffset do
  begin
    CType := MaskGetCharType(EditMask, I);
    if not (CType in [mcDirective, mcField, mcFieldSeparator]) then
      Result := Result + EditMask.Chars[I-1];
  end;
end;

function MaskOffsetToOffset(const EditMask: String; MaskOffset: Integer): Integer;
begin
  Result := Length(MaskOffsetToString(Editmask, MaskOffset));
end;

function MaskOffsetToWideOffset(const EditMask: String; MaskOffset: Integer): Integer;
begin
  Result := Length(MaskOffsetToString(Editmask, MaskOffset));
end;

function OffsetToMaskOffset(const EditMask: string; Offset: Integer): Integer;
var
  I: Integer;
  Count: Integer;
  MaxChars: Integer;
begin
  MaxChars := MaskOffsetToOffset(EditMask, EditMask.Length);
  if Offset > MaxChars then
  begin
    Result := -1;
    Exit;
  end;

  Result := 0;
  Count := Offset;
  for I := 1 to EditMask.Length do
  begin
    Inc(Result);
    if not (mcDirective = MaskGetCharType(EditMask, I)) then
    begin
      Dec(Count);
      if Count < 0 then
        Exit;
    end;
  end;
end;

function IsLiteralChar(const EditMask: string; Offset: Integer): Boolean;
var
  MaskOffset: Integer;
  CType: TMaskCharType;
begin
  Result := False;
  MaskOffset := OffsetToMaskOffset(EditMask, Offset);
  if MaskOffset >= 0 then
  begin
    CType := MaskGetCharType(EditMask, MaskOffset);
    Result := CType in [mcLiteral, mcIntlLiteral];
  end;
end;

function PadSubField(const EditMask: String; const Value: string;
  StartFld, StopFld, Len: Integer; Blank: Char): string;
var
  Dir: TMaskDirectives;
  StartPad: Integer;
  K: Integer;
begin
  if (StopFld - StartFld) < Len then
  begin
     { found literal at position J, now pad it }
    Dir := MaskGetCurrentDirectives(EditMask, 1);
    StartPad := StopFld - 1;
    if mdReverseDir in Dir then
      StartPad := StartFld - 1;
    Result := Value.SubString(0, StartPad);
    for K := 1 to (Len - (StopFld - StartFld)) do
      Result := Result + Blank;
    Result := Result + Value.SubString(StartPad, Value.Length);
  end
  else if (StopFld - StartFld) > Len then
  begin
    Dir := MaskGetCurrentDirectives(EditMask, 1);
    if mdReverseDir in Dir then
      Result := Value.SubString(0, StartFld - 1) +
        Value.SubString(StopFld - 1 - Len, Value.Length)
    else
      Result := Value.SubString(0, StartFld + Len - 1) +
        Value.SubString(StopFld - 1, Value.Length);
  end
  else
    Result := Value;
end;

function PadInputLiterals(const EditMask: String; const Value: string;
  Blank: Char): string;
var
  J: Integer;
  LastLiteral, EndSubFld: Integer;
  Offset, MaskOffset: Integer;
  CType: TMaskCharType;
  MaxChars: Integer;
begin
  LastLiteral := 0;
  Result := Value;
  for MaskOffset := 1 to EditMask.Length do
  begin
    CType := MaskGetCharType(EditMask, MaskOffset);
    if CType in [mcLiteral, mcIntlLiteral] then
    begin
      Offset := MaskOffsetToOffset(EditMask, MaskOffset);
      EndSubFld := Result.Length + 1;
      for J := LastLiteral to Result.Length -1 do
      begin
        if Result.Chars[J] = MaskIntlLiteralToChar(EditMask.Chars[MaskOffset-1]) then
        begin
          EndSubFld := J+1;
          Break;
        end;
      end;
       { we have found a subfield, ensure that it complies }
      if EndSubFld > Result.Length then
        Result := Result + MaskIntlLiteralToChar(EditMask.Chars[MaskOffset-1]);
      Result := PadSubField(EditMask, Result, LastLiteral + 1, EndSubFld,
        Offset - (LastLiteral + 1), Blank);
      LastLiteral := Offset;
    end;
  end;

    {ensure that the remainder complies, too }
  MaxChars  := MaskOffsetToOffset(EditMask, EditMask.Length);
  if Result.Length <> MaxChars then
    Result := PadSubField(EditMask, Result, LastLiteral + 1, Result.Length + 1,
      MaxChars - LastLiteral, Blank);

    { replace non-literal blanks with blank char }
  for Offset := 0 to Result.Length - 1 do
  begin
    if Result.Chars[Offset] = ' ' then
    begin
      if not IsLiteralChar(EditMask, Offset) then
      begin
        Result := Result.SubString(0, Offset) + Blank + Result.Substring( Offset+1);
      end;
    end;
  end;
end;

function FormatMaskText(const EditMask: string; const Value: string ): string;
begin
  if MaskGetMaskSave(EditMask) then
    Result := PadInputLiterals(EditMask, Value, ' ')
  else
    Result := MaskDoFormatText(EditMask, Value, ' ');
end;

end.

