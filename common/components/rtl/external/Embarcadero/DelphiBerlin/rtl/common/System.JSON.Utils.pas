{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.JSON.Utils;

interface

{$SCOPEDENUMS ON}

uses System.SysUtils, System.Types, System.TypInfo, System.Classes, System.JSON.Types, System.NetEncoding;

type
  TJsonTextUtils = class
  const
    kArrayEscapedArraySize = 128;
    EscapedUnicodeText = '!';
  private
    class var FSingleQuoteCharEscapeFlags: TBooleanDynArray;
    class var FDoubleQuoteCharEscapeFlags: TBooleanDynArray;
    class var FHtmlCharEscapeFlags: TBooleanDynArray;
  public
    class constructor Create;
    class procedure WriteEscapedString(const Writer: TTextWriter; const Str: string; Delimiter: Char;
      AppendDelimiters: Boolean; const CharEscapeFlags: array of Boolean; StringEscapeHandling: TJsonStringEscapeHandling;
      var WriteBuffer: TCharArray);
    class function ShouldEscapeJavaScriptString(const S: string; const CharEscapeFlags: array of Boolean): Boolean;
    class property SingleQuoteCharEscapeFlags: TBooleanDynArray read FSingleQuoteCharEscapeFlags;
    class property DoubleQuoteCharEscapeFlags: TBooleanDynArray read FDoubleQuoteCharEscapeFlags;
    class property HtmlCharEscapeFlags: TBooleanDynArray read FHtmlCharEscapeFlags;
    class procedure ToCharAsUnicode(C: Char; var Buffer: array of Char);
    class function IsWhiteSpace(const Str: string): Boolean;
  end;

  TJsonTypeUtils = class
  public
    class function InheritsFrom(ATypeInfo: PTypeInfo; const AParentClass: TClass): Boolean; static;
    class function IsAssignableFrom(ATo, AFrom: PTypeInfo): Boolean; static;
  end;

implementation

uses System.Generics.Collections, System.Character, System.DateUtils;

{ TJsonTextUtils }

class constructor TJsonTextUtils.Create;
const                                   //  \n  \r   \t  \\   \f   \b
  InitEscapedChars: array[0..5] of Char = (#10, #13, #9, #92, #12, #8);
var
  EscapeChar: Char;
  I: Integer;
begin
  SetLength(FSingleQuoteCharEscapeFlags, kArrayEscapedArraySize);
  SetLength(FDoubleQuoteCharEscapeFlags, kArrayEscapedArraySize);
  SetLength(FHtmlCharEscapeFlags, kArrayEscapedArraySize);

  for EscapeChar in InitEscapedChars do
  begin
    FSingleQuoteCharEscapeFlags[Ord(EscapeChar)] := True;
    FDoubleQuoteCharEscapeFlags[Ord(EscapeChar)] := True;
    FHtmlCharEscapeFlags[Ord(EscapeChar)] := True;
  end;

  I := 0;
  while I < Ord(' ') do
  begin
    FSingleQuoteCharEscapeFlags[I] := True;
    FDoubleQuoteCharEscapeFlags[I] := True;
    FHtmlCharEscapeFlags[I] := True;
    Inc(I);
  end;

  FSingleQuoteCharEscapeFlags[Ord('''')] := True;

  FDoubleQuoteCharEscapeFlags[Ord('"')] := True;

  FHtmlCharEscapeFlags[Ord('"')] := True;
  FHtmlCharEscapeFlags[Ord('''')] := True;
  FHtmlCharEscapeFlags[Ord('<')] := True;
  FHtmlCharEscapeFlags[Ord('>')] := True;
  FHtmlCharEscapeFlags[Ord('&')] := True;
end;

class function TJsonTextUtils.ShouldEscapeJavaScriptString(const S: string; const CharEscapeFlags: array of Boolean): Boolean;
var
  C: Char;
begin
  Result := False;
  if S <> '' then
    for C in S do
      if (Ord(C) >= Length(CharEscapeFlags)) or CharEscapeFlags[Ord(C)] then
        Exit(True);
end;

class procedure TJsonTextUtils.WriteEscapedString(const Writer: TTextWriter; const Str: string; Delimiter: Char;
  AppendDelimiters: Boolean; const CharEscapeFlags: array of Boolean; StringEscapeHandling: TJsonStringEscapeHandling;
  var WriteBuffer: TCharArray);
var
  LastWritePosition, I, Start, Len: Integer;
  EscapedValue: string;
  C: Char;
  IsEscapedUnicodeText: Boolean;
begin
  if AppendDelimiters then
    Writer.Write(Delimiter);

  LastWritePosition := 0;
  for I := 0 to Length(Str) - 1 do
  begin
    C := Str[I + Low(Str)];

    if (Ord(C) < Length(CharEscapeFlags)) and not CharEscapeFlags[Ord(C)] then
      Continue;

    case C of
      // tab
      #9:
        EscapedValue := '\t';
      // end line
      #10:
        EscapedValue := '\n';
      // carriage return
      #13:
        EscapedValue := '\r';
      // formfeed
      #12:
        EscapedValue := '\f';
      // backspace
      #8:
        EscapedValue := '\b';
      // backslash
      #92:
        EscapedValue := '\\';
      // new line
      #$0085:
        EscapedValue := '\u0085';
      // line separator
      #$2028:
        EscapedValue := '\u2028';
      // paragraph separator
      #$2029:
        EscapedValue := '\u2029';
      else
      begin
        if (Ord(C) < Length(CharEscapeFlags)) or (StringEscapeHandling = TJsonStringEscapeHandling.EscapeNonAscii) then
        begin
          if (C = '''') and (StringEscapeHandling <> TJsonStringEscapeHandling.EscapeHtml) then
            EscapedValue := '\'''
          else if (C = '"') and (StringEscapeHandling <> TJsonStringEscapeHandling.EscapeHtml) then
            EscapedValue := '\"'
          else
          begin
            if Length(WriteBuffer) = 0 then
              SetLength(WriteBuffer, 6);
            TJsonTextUtils.ToCharAsUnicode(C, WriteBuffer);
            EscapedValue := EscapedUnicodeText;
          end;
        end
        else
          EscapedValue := '';
      end;
    end; // case

    if EscapedValue = '' then
      Continue;

    IsEscapedUnicodeText := EscapedValue = EscapedUnicodeText;

    if (I > LastWritePosition) then
    begin
      Len := I - LastWritePosition;
      Start := 0;
      if IsEscapedUnicodeText then
      begin
        Inc(Len, 6);
        Inc(Start, 6);
      end;

      if (Length(WriteBuffer) = 0) or (Length(WriteBuffer) < Len) then
        SetLength(WriteBuffer, Len);

      Move(Str[Low(string) + LastWritePosition], WriteBuffer[Start], (Len - Start) * SizeOf(Char));
      Writer.Write(WriteBuffer, Start, Len - Start);
    end;
    LastWritePosition := I + 1;
    if not IsEscapedUnicodeText then
      Writer.Write(EscapedValue)
    else
      Writer.Write(WriteBuffer, 0, 6);
  end; // for

  if LastWritePosition = 0 then
    Writer.Write(Str)
  else
  begin
    Len := Length(Str) - LastWritePosition;
    if (Length(WriteBuffer) = 0) or (Length(WriteBuffer) < Len) then
      SetLength(WriteBuffer, Len);

    if Len > 0 then
    begin
      Move(Str[Low(string) + LastWritePosition], WriteBuffer[0], Len * SizeOf(Char));
      Writer.Write(WriteBuffer, 0, Len);
    end;
  end;

  if AppendDelimiters then
    Writer.Write(Delimiter);
end;

{ TStringUtils }


class function TJsonTextUtils.IsWhiteSpace(const Str: string): Boolean;
var
  I: Integer;
begin
  if (Length(Str) = 0) then
    Exit(False);
  for I := Low(Str) to High(Str) do
    if not Str[I].IsWhiteSpace then
      Exit(False);
  Result := True;
end;

class procedure TJsonTextUtils.ToCharAsUnicode(C: Char; var Buffer: array of Char);
const
  HexChars = '0123456789ABCDEF';
var
  UnicodeValue: Integer;
begin
  Buffer[0] := '\';
  Buffer[1] := 'u';
  UnicodeValue := Ord(C);
  Buffer[2] := HexChars.Chars[(UnicodeValue and $F000) shr 12];
  Buffer[3] := HexChars.Chars[(UnicodeValue and $F00) shr 8];
  Buffer[4] := HexChars.Chars[(UnicodeValue and $F0) shr 4];
  Buffer[5] := HexChars.Chars[(UnicodeValue and $F)];
end;

{ TJsonTypeUtil }

class function TJsonTypeUtils.InheritsFrom(ATypeInfo: PTypeInfo; const AParentClass: TClass): Boolean;
begin
 if ATypeInfo^.Kind = tkClass then
    Result := ATypeInfo^.TypeData^.ClassType.InheritsFrom(AParentClass)
 else
    Result := False;
end;

class function TJsonTypeUtils.IsAssignableFrom(ATo, AFrom: PTypeInfo): Boolean;
begin
  case ATo^.Kind of
    tkUnknown:
      Result := False;
    tkInteger,
    tkEnumeration,
    tkFloat,
    tkVariant,
    tkInt64,
    tkSet:
      Result := GetTypeData(ATo) = GetTypeData(AFrom);
    tkClass:
      if AFrom^.Kind = tkClass then
        Result := ATo.TypeData^.ClassType.InheritsFrom(AFrom.TypeData^.ClassType)
      else
        Result := False;
    tkProcedure,
    tkMethod:
      Result := False;
    tkString, tkLString, tkWString, tkChar, tkWChar, tkUString:
      case AFrom^.Kind of
        tkString, tkLString, tkWString, tkChar, tkWChar, tkUString:
          Result := True
        else
          Result := False
      end;
    tkArray,
    tkDynArray:
      if AFrom^.Kind = tkArray then
        Result := AFrom^.TypeData^.DynArrElType^ = ATo^.TypeData^.DynArrElType^
      else
        Result := False;
    tkRecord:
      if AFrom^.Kind = tkRecord then
        Result := ATo = AFrom
      else
        Result := False;
    tkPointer,
    tkInterface:
      Result := ATo = AFrom;
    tkClassRef:
      Result := AFrom^.Kind = tkClass;
    else
      Result := False;
  end;
end;

end.
