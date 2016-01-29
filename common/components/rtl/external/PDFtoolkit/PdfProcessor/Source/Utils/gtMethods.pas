{ ********************************************************************* }
{                                                                       }
{                       Gnostice Utilities                              }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I gtCompilerDefines.inc}

unit gtMethods;

interface

uses
  Math, gtConstants, gtTypes,{$IFDEF VCL6ORABOVE}StrUtils{$ELSE} gtStrUtils{$ENDIF},
  Windows, SyncObjs, Classes,  SysUtils;
var
  LockDecimalSep: TCriticalSection;

function IsSpace(AChar: Integer): Boolean;

function StringTokenizer(const AString: Ansistring; APos: Cardinal): AnsiString;
function StringToInteger(const AValue: Ansistring): Integer;
function StringToFloat(AValue: AnsiString): Double;
function StringToFloatLocale(AValue: AnsiString): Double;
function RightStr(const AString: AnsiString; Position: Integer): AnsiString;
function StringPos(const AString: AnsiString; Pattern: AnsiString): Integer;
function IntegerToString(AValue: Integer): AnsiString;
function FloatToString(AValue: Double): AnsiString;
function FloatToStringLocale(AValue: Double): AnsiString;
function HexToString(AValue: AnsiString): AnsiString;
function HexToStr(AValue: AnsiString): AnsiString;
function StringToHex(AValue: AnsiString): AnsiString;
function StringToHex2(AValue: AnsiString): AnsiString;
function NextPos(SearchStr, Str: AnsiString; Position: Integer): Integer;
function LastPos(SearchStr, Str: AnsiString): Integer;
function NextPosRel(SearchStr, Str: AnsiString; Position: Integer): Integer;
function ReplaceStr(Str, SearchStr, ReplaceStr: AnsiString): AnsiString;
function IsHex(AString: AnsiString): Boolean;
function HexToByteValue(AHex: AnsiString; out AByte: Byte): Integer;
function HexToByteArray(AHex: AnsiString): Bytes;
function HexToByteString(AHex: AnsiString): AnsiString;
function PDFStringToDate(Value: AnsiString): TgtDate;
function DateToPDFString(Value: TgtDate): AnsiString;
function GetHexOfStr(ASourceString: AnsiString; ALength: Integer): AnsiString;
function GetHexOfString(AString: AnsiString): AnsiString;
function FloatToStringF(AN: Extended): AnsiString;
function FloatToStrFLocale(Value: Extended; Format: TFloatFormat;
  Precision, Digits: Integer): AnsiString;

procedure OctalToByteValue(AOctal: AnsiString; out AByte: Byte);
function UnicodeHexToString(const Value: AnsiString): WideString;
procedure EscapeStringToString(AEscapeString: AnsiString; var AString: AnsiString);
function FromUnicodeHexToStr(AStr: AnsiString): WideString;
function IsOctal(AString: AnsiString): Boolean;
function isAlpha(const c: AnsiChar): boolean;
function isNumeric(const c: AnsiChar): boolean;
function isxdigit(Ch: AnsiChar): Boolean;
procedure FreeObject(var AObject);
function ColorToPDFColor(AR, AG, AB: Byte): AnsiString;
function ParseMemStream(AStream: TMemoryStream): Integer;
function RemoveTerminalCRLF(AString: AnsiString): AnsiString;
function Cosec(const X: Extended): Extended;
//function NextPos(SubStr: AnsiString; Str: AnsiString; LastPos: DWORD
//  = 0): DWORD;


implementation

uses
  gtLogger;

{The syntax is similar to the syntax of the Pos function supplied by Delphi:

  function NextPos(Substr: AnsiString; S: AnsiString; LastPos: DWORD = 0):
    DWORD;

NextPos returns the index value of the first character in a specified substring
that occurs in a given AnsiString starting after the index value supplied by LastPos.
LastPos may be omitted.

Note: As LastPos you should pass the position of the last occurence, not last
  position + 1. Just for convinience.
}

//function NextPos(SubStr: AnsiString; Str: AnsiString; LastPos: DWORD): DWORD;
//type
//  StrRec = packed record
//    allocSiz: Longint;
//    refCnt: Longint;
//    length: Longint;
//  end;
//
//const
//  skew = sizeof(StrRec);
//
//asm
//  // Search-AnsiString passed?
//  TEST    EAX,EAX
//  JE      @@noWork
//
//  // Sub-AnsiString passed?
//  TEST    EDX,EDX
//  JE      @@stringEmpty
//
//  // Save registers affected
//  PUSH    ECX
//  PUSH    EBX
//  PUSH    ESI
//  PUSH    EDI
//
//  // Load Sub-AnsiString pointer
//  MOV     ESI,EAX
//  // Load Search-AnsiString pointer
//  MOV     EDI,EDX
//  // Save Last Position in EBX
//  MOV     EBX,ECX
//
//  // Get Search-AnsiString Length
//  MOV     ECX,[EDI-skew].StrRec.length
//  // subtract Start Position
//  SUB     ECX,EBX
//  // Save Start Position of Search AnsiString to return
//  PUSH    EDI
//  // Adjust Start Position of Search AnsiString
//  ADD     EDI,EBX
//
//  // Get Sub-AnsiString Length
//  MOV     EDX,[ESI-skew].StrRec.length
//  // Adjust
//  DEC     EDX
//  // Failed if Sub-AnsiString Length was zero
//  JS      @@fail
//  // Pull first character of Sub-AnsiString for SCASB function
//  MOV     AL,[ESI]
//  // Point to second character for CMPSB function
//  INC     ESI
//
//  // Load character count to be scanned
//  SUB     ECX,EDX
//  // Failed if Sub-AnsiString was equal or longer than Search-AnsiString
//  JLE     @@fail
//@@loop:
//  // Scan for first matching character
//  REPNE   SCASB
//  // Failed, if none are matching
//  JNE     @@fail
//  // Save counter
//  MOV     EBX,ECX
//  PUSH    ESI
//  PUSH    EDI
//  // load Sub-AnsiString length
//  MOV     ECX,EDX
//  // compare all bytes until one is not equal
//  REPE    CMPSB
//  // restore counter
//  POP     EDI
//  POP     ESI
//  // all byte were equal, search is completed
//  JE      @@found
//  // restore counter
//  MOV     ECX,EBX
//  // continue search
//  JMP     @@loop
//@@fail:
//  // saved pointer is not needed
//  POP     EDX
//  XOR     EAX,EAX
//  JMP     @@exit
//@@stringEmpty:
//  // return zero - no match
//  XOR     EAX,EAX
//  JMP     @@noWork
//@@found:
//  // restore pointer to start position of Search-AnsiString
//  POP     EDX
//  // load position of match
//  MOV     EAX,EDI
//  // difference between position and start in memory is
//  //   position of Sub
//  SUB     EAX,EDX
//@@exit:
//  // restore registers
//  POP     EDI
//  POP     ESI
//  POP     EBX
//  POP     ECX
//@@noWork:
//end;

function GetHexOfString(AString: AnsiString): AnsiString;
begin
  Result := '';
  SetLength(Result, Length(AString)*2);
  BinToHex(PChar(AString), PChar(Result), Length(AString));
end;

function ColorToPDFColor(AR, AG, AB: Byte): AnsiString;

  function PDFColor(HexCode: AnsiString): AnsiString;
  begin
    Result := Format('%1.4f',
      [StrToIntDef('$' + HexCode, 0) / 255]);
		if AnsiChar(DecimalSeparator) <> '.' then
			Result := ReplaceStr(Result, AnsiChar(DecimalSeparator), '.');
  end;

begin
  Result :=
    PDFColor(IntToHex(AR, 8)) + ' ' +
    PDFColor(IntToHex(AG, 8)) + ' ' +
    PDFColor(IntToHex(AB, 8));
end;

function isAlpha(const c: AnsiChar): boolean;
begin
  Result := c in ['a'..'z', 'A'..'Z'];
end;

function isNumeric(const c: AnsiChar): boolean;
begin
  Result := c in ['0'..'9'];
end;

function isxdigit(Ch: AnsiChar): Boolean;
begin
  Result := (ch in ['0'..'9']) or (ch in ['a'..'f']) or (ch in ['A'..'F']);
end;


function IsSpace(AChar: Integer): Boolean;
begin
  if (((AChar >= 0) and (AChar <= 255)) and (SpecialChars[AChar] = 1)) then
    Result := True
  else
    Result := False;
end;

function StringTokenizer(const AString: Ansistring; APos: Cardinal): AnsiString;
var
  LI, LStart: Integer;
begin
  for LI := APos to Length(AString) - 1 do
  begin
    if not ((AString[LI] = #0) or (AString[LI] = #9) or
      (AString[LI] = #13) or (AString[LI] = #10) or
      (AString[LI] = #32)) then
      Break; //Checking for BLANKSPACE, TAB, CR or LF
  end;
  LStart := LI;
  for LI := LI + 1 to Length(AString) - 1 do
  begin
    if ((AString[LI] = #0) or (AString[LI] = #9) or
      (AString[LI] = #13) or (AString[LI] = #10)) then
      Break; //Checking for BLANKSPACE, TAB, CR or LF
  end;
  Result := Copy(AString, LStart, LI - LStart);
end;

function StringToFloat(AValue: AnsiString): Double;
begin
  try
{$IFNDEF DOTNET}
    Result := StrToFloat(AValue);
{$ELSE}
    Result = float.parse(AValue);
{$ENDIF}
  except
    on E: Exception do
    begin
      Result := 0;
{$IFDEF DEBUG}
      Logger.LogError('Could not Convert AnsiString To Float');
      Logger.LogError('Exception Raised with %s', [E.Message]);
{$ENDIF}
      Exit;
    end;
  end;
end;

function StringToFloatLocale(AValue: AnsiString): Double;
var
  LDesSep: AnsiChar;
begin
  LDesSep := AnsiChar(DecimalSeparator);
  LockDecimalSep.Acquire;
  try
    DecimalSeparator := '.';
    Result := StrToFloat(AValue);
    DecimalSeparator := Char(LDesSep);
  finally
    LockDecimalSep.Release;
  end;
end;

//Converts a AnsiString to its corresponding integer value

function StringToInteger(const AValue: Ansistring): Integer;
begin
  try
{$IFNDEF DOTNET}
    Result := StrToInt(AValue);
{$ELSE}
    Result = Convert.ToInt32(AValue);
{$ENDIF}
  except
    on E: Exception do
    begin
      Result := 0;
{$IFDEF DEBUG}
      Logger.LogError('Could not Convert AnsiString To Integer');
      Logger.LogError('Exception Raised with %s', [E.Message]);
{$ENDIF}
      Exit;
    end;
  end;
end;

//Converts an integer to corresponding AnsiString

function IntegerToString(AValue: Integer): AnsiString;
begin
  try
{$IFNDEF DOTNET}
    Result := IntToStr(AValue);
{$ELSE}
    Result = Convert.ToString(AValue);
{$ENDIF}
  except
    on E: Exception do
    begin
      Result := '';
{$IFDEF DEBUG}
      Logger.LogError('Could not Convert Integer To AnsiString');
      Logger.LogError('Exception Raised with %s', [E.Message]);
{$ENDIF}
      Exit;
    end;
  end;
end;

// Converts a Floating point value to corresponding AnsiString

function FloatToString(AValue: Double): AnsiString;
begin
  try
{$IFNDEF DOTNET}
    Result := FloatToStr(AValue);
{$ELSE}
    Result = Convert.ToDouble(AValue);
{$ENDIF}
  except
    on E: Exception do
    begin
      Result := '';
{$IFDEF DEBUG}
      Logger.LogError('Could not Convert Double To AnsiString');
      Logger.LogError('Exception Raised with %s', [E.Message]);
{$ENDIF}
      Exit;
    end;
  end;
end;

function FloatToStringLocale(AValue: Double): AnsiString;
var
  LDesSep: AnsiChar;
begin
  LDesSep := AnsiChar(DecimalSeparator);
  LockDecimalSep.Acquire;
  try
    DecimalSeparator := '.';
    Result := FloatToStr(AValue);
    DecimalSeparator := Char(LDesSep);
  finally
    LockDecimalSep.Release;
  end;
end;

//Converts the Hex value to corresponding AnsiString

function HexToString(AValue: AnsiString): AnsiString;
var
  LI: Integer;
  LString: AnsiString;
begin
  if Copy(WideString(UpperCase(AValue)), 1, 4) = 'FEFF' then
  begin
    Result := UnicodeHexToString(AValue);
    Exit;
  end;

  Result := '';
  if (Length(AValue) mod 2) = 1 then
    AValue := '0' + AValue;
  LI := 1;
  while LI <= Length(AValue) do
  begin
    LString := AValue[LI] + AValue[LI + 1];
    LI := LI + 2;
    Result := Result + IntegerToString(StringToInteger('$' + LString));
  end;
end;

function HexToStr(AValue: AnsiString): AnsiString;
var
  LI: Integer;
  LString: AnsiString;
begin
  if Copy(WideString(UpperCase(AValue)), 1, 4) = 'FEFF' then
  begin
    Result := UnicodeHexToString(AValue);
    Exit;
  end;

  Result := '';
  if (Length(AValue) mod 2) = 1 then
    AValue := '0' + AValue;
  LI := 1;
  while LI <= Length(AValue) do
  begin
    LString := AValue[LI] + AValue[LI + 1];
    LI := LI + 2;
    Result := Result + AnsiChar(StringToInteger('$' + LString));
  end;
end;

//Converts a AnsiString to corresponding Hex value

function StringToHex(AValue: AnsiString): AnsiString;
var
  HexValue: AnsiString;
  LI: Integer;
begin
  Result := '';
  LI := 1;
  while (LI <= Length(AValue)) do
  begin
    HexValue := IntToHex(Ord(AValue[LI]), 4);
    Result := Result + HexValue;
    Inc(LI);
  end;
  Result := 'FEFF' + Result;
end;

//Converts a AnsiString to corresponding Hex value  without FEFF and padding
function StringToHex2(AValue: AnsiString): AnsiString;
var
  HexValue: AnsiString;
  LI: Integer;
begin
  Result := '';
  LI := 1;
  while (LI <= Length(AValue)) do
  begin
    HexValue := IntToHex(Ord(AValue[LI]), 2);
    Result := Result + HexValue;
    Inc(LI);
  end;
end;

// Free an Object if it is assigned

procedure FreeObject(var AObject);
var
  Temp: TObject;
begin
  Temp := TObject(AObject);
  TObject(AObject) := nil;
  Temp.Free;
end;

// Get the Position of a AnsiString, starting at the end
// Rückwärtiges Vorkommen einer Zeichenkette innerhalb eines strings, Position von hinten

function LastPos(SearchStr, Str: AnsiString): Integer;
var
  i: Integer;
  TempStr: AnsiString;
begin
  Result := Pos(SearchStr, Str);
  if Result = 0 then Exit;
  if (Length(Str) > 0) and (Length(SearchStr) > 0) then
  begin
    for i := Length(Str) + Length(SearchStr) - 1 downto Result do
    begin
      TempStr := Copy(Str, i, Length(Str));
      if Pos(SearchStr, TempStr) > 0 then
      begin
        Result := i;
        break;
      end;
    end;
  end;
end;

// Search for the next occurence of a AnsiString from a certain Position

function NextPos(SearchStr, Str: AnsiString; Position: Integer): Integer;
begin
  Delete(Str, 1, Position - 1);
  Result := Pos(SearchStr, upperCase(Str));
  if Result = 0 then Exit;
  if (Length(Str) > 0) and (Length(SearchStr) > 0) then
    Result := Result + Position + 1;
end;

// Get the number of characters from a certain Position to the AnsiString to be searched

function NextPosRel(SearchStr, Str: AnsiString; Position: Integer): Integer;
begin
  Delete(Str, 1, Position - 1);
  Result := Pos(SearchStr, UpperCase(Str)) - 1;
end;

// simple replacement for strings

function ReplaceStr(Str, SearchStr, ReplaceStr: AnsiString): AnsiString;
begin
  while Pos(SearchStr, Str) <> 0 do
  begin
    Insert(ReplaceStr, Str, Pos(SearchStr, Str));
    Delete(Str, Pos(SearchStr, Str), Length(SearchStr));
  end;
  Result := Str;
end;

// Return true if the AnsiString is Hex

function IsHex(AString: AnsiString): Boolean;
var
  LI: Integer;
  LString: AnsiString;
begin
  Result := False;
  LString := UpperCase(AString);

  for LI := 1 to Length(AString) do
    if (LString[LI] < '0') or
      ((AString[LI] > '9') and (AString[LI] < 'A')) or
      ((AString[LI] < 'A') and (AString[LI] > 'F')) then
      Exit;

  Result := True;
end;

//Returns the byte value of an Hex into AByte param

function HexToByteValue(AHex: AnsiString; out AByte: Byte): Integer;
const
  Convert: array['0'..'f'] of SmallInt =
  (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, -1, -1, -1, -1, -1, -1,
    -1, 10, 11, 12, 13, 14, 15, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, 10, 11, 12, 13, 14, 15);
var
  LI, LJ: Integer;
begin
  Result := -1;
  AByte := 0;
  LJ := 0;

  if not IsHex(AHex) then Exit;

  for LI := Length(AHex) downto 1 do
  begin
    AByte := AByte + Convert[AHex[LI]] * Trunc(Power(16, LJ));
    Inc(LJ);
  end;
  Result := 0;
end;

//Returns a Byte array of corresponding AnsiString

function HexToByteArray(AHex: AnsiString): Bytes;
var
  LS: AnsiString;
  LI, LJ, LLength: Integer;
begin
  SetLength(LS, 2);
  SetLength(Result, 0);
  LLength := Length(AHex);
  LI := 1;
  LJ := 0;
  while (LI < LLength) do
  begin
    while not (IsHex(AHex[LI])) do
      Inc(LI);
    LS[1] := AHex[LI];
    Inc(LI);

    while not (IsHex(AHex[LI])) do
      Inc(LI);
    LS[2] := AHex[LI];
    Inc(LI);

    SetLength(Result, Length(Result) + 1);
    if (HexToByteValue(LS, Result[LJ]) <> 0) then
      Exit;
    Inc(LJ);
  end;
  SetLength(LS, 0);
end;

function HexToByteString(AHex: AnsiString): AnsiString;
var
  LI: Integer;
  LS: AnsiString;
  LByte: Byte;
begin
  if Copy(WideString(UpperCase(AHex)), 1, 4) = 'FEFF' then
  begin
    Result := UnicodeHexToString(AHex);
    Exit;
  end;

  SetLength(LS, 2);
  LI := 1;
  while (LI < Length(AHex)) do
  begin
    while not (IsHex(AHex[LI])) do
      Inc(LI);

    LS[1] := AHex[LI];

    Inc(LI);
    while not (IsHex(AHex[LI])) do
      Inc(LI);

    LS[2] := AHex[LI];
    Inc(LI);
    if (HexToByteValue(LS, LByte) <> 0) then
      Exit
    else
      Result := Result + AnsiChar(LByte);
  end;
  SetLength(LS, 0);
end;


function UnicodeHexToString(const Value: AnsiString): WideString;
var
  LSourceStr: AnsiString;
  LI, LJ: Integer;
  LByte1, LByte2, LTempByte: AnsiString;
  LoByte, HiByte: Byte;
  ByteArr: array of Byte;
begin

  if Copy(WideString(UpperCase(Value)), 1, 4) = 'FEFF' then
  begin
    LI := 1;
    LJ := 0;
    LSourceStr := Copy(Value, 5, 999);
    SetLength(ByteArr, (Length(LSourceStr) div 2));
    while (LI < Length(LSourceStr)) do
    begin
      if LSourceStr[LI] = '.' then
      begin
        ByteArr[LJ] := 46;
        ByteArr[LJ + 1] := 0;
        Inc(LJ, 2);
        Inc(LI);
      end;
      LTempByte := Copy(LSourceStr, LI, 4);
      if UpperCase(LTempByte) = 'FEFF' then
        Inc(LI, 4);
      LByte1 := Copy(LSourceStr, LI, 2);
      HexToByteValue(LByte1, LoByte);
      Inc(LI, 2);

      LByte2 := Copy(LSourceStr, LI, 2);
      HexToByteValue(LByte2, HiByte);
      Inc(LI, 2);

      ByteArr[LJ] := HiByte;
      ByteArr[LJ + 1] := LoByte;
      Inc(LJ, 2);
    end;
    Result := WideString(ByteArr);
  end
  else Result := HexToByteString(Value);
end;
{$IFNDEF VCL7ORABOVE}
function AnsiRightStr(const AText: AnsiString; const ACount: Integer): AnsiString;
begin
  Result := Copy(WideString(AText), Length(WideString(AText)) + 1 - ACount, ACount);
end;
{$ENDIF}
function RightStr(const AString: AnsiString; Position: Integer): AnsiString;
begin
//  Result := AnsiRightStr(AString, Position);
end;


function StringPos(const AString: AnsiString; Pattern: AnsiString): Integer;
begin
  Result := AnsiPos(Pattern, AString);
end;

function PDFStringToDate(Value: AnsiString): TgtDate;
var
  LPos: Integer;
begin

  if Pos('D:', Value) = 0 then
  begin
    Exit;
  end;

  Delete(Value, Pos('D:', Value), 2);

  if (Length(Value) > 4) then
    Result.Year := StringToInteger(Copy(Value, 1, 4));

  if Length(Value) >= 6 then
    Result.Month := StringToInteger(Copy(Value, 5, 2));
  if (Result.Month < 1) or (Result.Month > 12) then
  begin
    Result.Month := 1;
  end;

  if Length(Value) >= 8 then
    Result.Day := StringToInteger(Copy(Value, 7, 2));
  if (Result.Day < 1) or (Result.Day > 31) then
  begin
    Result.Day := 1;
  end;

  if Length(Value) >= 10 then
    Result.Hour := StringToInteger(Copy(Value, 9, 2));
  if Result.Hour = 00 then
    Result.Hour := 12;
  if Result.Hour > 23 then
  begin
    Result.Hour := 0;
  end;

  LPos := pos('+', Value) or pos('-', Value) or pos('Z', Value);
  if (Length(Value) >= 12) and (LPos <> 11) then
    Result.Minutes := StringToInteger(Copy(Value, 11, 2));
  if Result.Minutes > 59 then
  begin
    Result.Minutes := 0;
  end;

  LPos := pos('+', Value) or pos('-', Value) or pos('Z', Value);
  if ((LPos = 0) and (Length(Value) = 14)) or (LPos = 15) then
    Result.Seconds := StringToInteger(Copy(Value, 13, 2));

  if Result.Seconds > 59 then
  begin
    Result.Seconds := 0;
  end;
end;

function DateToPDFString(Value: TgtDate): AnsiString;
var
  Month: AnsiString;
  Day: AnsiString;
  Hour: AnsiString;
  Minutes: AnsiString;
  Seconds: AnsiString;
begin
  Month := IntegerToString(Value.Month);
  if Value.Month < 10 then
    Month := '0' + Month;

  Day := IntegerToString(Value.Day);
  if Value.Day < 10 then
    Day := '0' + Day;

  Hour := IntegerToString(Value.Hour);
  if Value.Hour < 10 then
    Hour := '0' + Hour;

  Minutes := IntegerToString(Value.Minutes);
  if Value.Minutes < 10 then
    Minutes := '0' + Minutes;

  Seconds := IntegerToString(Value.Seconds);
  if Value.Seconds < 10 then
    Seconds := '0' + Seconds;

  Result := 'D:' + IntegerToString(Value.Year) + Month + Day + Hour + Minutes +
    Seconds;
end;

procedure EscapeStringToString(AEscapeString: AnsiString;
  var AString: AnsiString);
var
  LI, LJ, LLength: Integer;
  LChar: AnsiString;
  LOctal: AnsiString;
  LByte: Byte;
begin
  if AEscapeString = '' then Exit;
  SetLength(LChar, 1);
  SetLength(LOctal, 3);
  LI := 1;
  LLength := Length(AEscapeString);
  SetLength(AString, 0);
  repeat
    if (AEscapeString[LI] = '\') then
    begin
      case AEscapeString[LI + 1] of
        'n':
          begin
            LChar := AnsiChar(LINEFEED);
            Inc(LI, 2);
          end;
        'r':
          begin
            LChar := AnsiChar(CARRIAGERETURN);
            Inc(LI, 2);
          end;
        't':
          begin
            LChar := AnsiChar(TABSPACE);
            Inc(LI, 2);
          end;
        'b':
          begin
            LChar := AnsiChar(BACKSPACE);
            Inc(LI, 2);
          end;
        'f':
          begin
            LChar := AnsiChar(FORMFEED);
            Inc(LI, 2);
          end;
        '(':
          begin
            LChar := '(';
            Inc(LI, 2);
          end;
        ')':
          begin
            LChar := ')';
            Inc(LI, 2);
          end;
        '\':
          begin
            LChar := '\';
            Inc(LI, 2);
          end;
      else
        begin
          if AEscapeString[LI + 1] in ['0'..'8'] then
          begin
            Inc(LI);
            LJ := 1;
            LOctal := '';
            while (AEscapeString[LI] in ['0'..'8']) and
              (LJ <= 3) do
            begin
              SetLength(LOctal, Length(LOctal) + 1);
              LOctal[LJ] := AEscapeString[LI];
              Inc(LJ);
              Inc(LI);
            end;
            if (LJ = 2) then
              Insert('00', LOctal, 1)
            else if (LJ = 3) then
              Insert('0', LOctal, 1);
            if (LJ > 1) then
            begin
              OctalToByteValue(LOctal, LByte);
              LChar := AnsiChar(LByte);
            end;
          end
          else
          begin
            LChar := AEscapeString[LI];
            Inc(LI);
          end;
        end
      end; (* End Case *)
    end
    else
    begin
      LChar := AEscapeString[LI];
      Inc(LI);
    end;
    SetLength(AString, (Length(AString) + 1));
    AString[Length(AString)] := LChar[1];
  until (LI > LLength);
end;


function FromUnicodeHexToStr(AStr: AnsiString): WideString;
var
  LI, LJ: Integer;
  LoByte, HiByte: Byte;
  ByteArr: array of Byte;
  LIsUnicode: Boolean;
begin

  if (AStr = '') or (AStr = '()') or (AStr = '<>') then Exit;

  EscapeStringToString(AStr, AStr);
  LI := 1; LJ := 0; LIsUnicode := False;

  if (AStr[LI] = '(') or (AStr[LI] = '<') then
    AStr := System.Copy(AStr, LI + 1, Length(AStr) - 2);

  if (AStr = '') or (AStr = '()') or (AStr = '<>') then Exit;

  if (AStr[LI] = #254) and (AStr[LI + 1] = #255) then
  begin
    AStr := System.Copy(AStr, LI + 2, Length(AStr) - 2);
    LIsUnicode := True;
  end;

  if (AStr = '') or (AStr = '()') or (AStr = '<>') then Exit;

  if LeftStr(UpperCase(AStr), 4) = 'FEFF' then
  begin
    Result := UnicodeHexToString(AStr);
    exit;
  end;

  if (Byte(AStr[LI]) > $20) and not LIsUnicode then
  begin
    Result := AStr;
    exit;
  end;

  SetLength(ByteArr, Length(AStr));

  while (LI < Length(AStr)) do
  begin
    if AStr[LI] = '.' then
      Inc(LI);
    LoByte := Byte(AStr[LI]);
    HiByte := Byte(AStr[LI + 1]);
    ByteArr[LJ] := HiByte;
    ByteArr[LJ + 1] := LoByte;
    Inc(LJ, 2);
    Inc(LI, 2);
  end;

  Result := WideString(ByteArr);
end;

procedure OctalToByteValue(AOctal: AnsiString; out AByte: Byte);
const
  Convert: array['0'..'8'] of SmallInt = (0, 1, 2, 3, 4, 5, 6, 7, 8);
var
  LI, LJ: Integer;
begin
  AByte := 0;
  LJ := 0;

  if not IsOctal(AOctal) then Exit;

  for LI := Length(AOctal) downto 1 do
  begin
    AByte := AByte + Convert[AOctal[LI]] * Trunc(Power(8, LJ));
    Inc(LJ);
  end;
end;

function IsOctal(AString: AnsiString): Boolean;
var
  LI: Integer;
begin
  Result := False;

  for LI := 1 to Length(AString) do
    if ((AString[LI] < '0') or (AString[LI] > '8')) then
      Exit;

  Result := True;
end;

function GetHexOfStr(ASourceString: AnsiString; ALength: Integer): AnsiString;
const
  Convert: array[0..15] of AnsiChar = '0123456789ABCDEF';
var
  LI: Integer;
begin
  Result := '';
  for LI := 1 to ALength do
  begin
    Result := Result + Convert[Byte(ASourceString[LI]) shr 4];
    Result := Result + Convert[Byte(ASourceString[LI]) and $F];
  end;
end;

function FloatToStringF(AN: Extended): AnsiString;
var
  LDesSep: AnsiChar;
begin
  LDesSep := AnsiChar(DecimalSeparator);
  LockDecimalSep.Acquire;
  try
    DecimalSeparator := '.';
	// Convert to native AnsiString.
	  Result := FloatToStrF(AN, ffFixed, 18, 4);
    DecimalSeparator := Char(LDesSep);
  finally
    LockDecimalSep.Release;
  end;
end;

function ParseMemStream(AStream: TMemoryStream): Integer;
var
  LTemp, LJ: Integer;
  LBuff: array of AnsiChar;
begin
  Result := 0;
  LTemp := AStream.Size;
  SetLength(LBuff, LTemp);
  for LJ := 1 to AStream.Size do
  begin
    AStream.Position := 0;
    AStream.Read(LBuff[0], LJ);
    if (LBuff[LJ - 1] = '>') then
    begin
      Result := LJ;
      Break;
    end;
  end;
end;

function FloatToStrFLocale(Value: Extended; Format: TFloatFormat;
  Precision, Digits: Integer): AnsiString;
var
  LDesSep: AnsiChar;
begin
  LDesSep := AnsiChar(DecimalSeparator);
  LockDecimalSep.Acquire;
  try
    DecimalSeparator := '.';
    Result := FloatToStrF(Value,Format,Precision,Digits);
    DecimalSeparator := Char(LDesSep);
  finally
    LockDecimalSep.Release;
  end;
end;

function RemoveTerminalCRLF(AString: AnsiString): AnsiString;
var
  LLength: Integer;
begin
	LLength := Length(AString);
  SetLength(Result, LLength);
  Result := AString;
  if (LLength > 1) then begin
    if (AString[LLength - 1] = CR) and (AString[LLength] = LF) then
    begin
      SetLength(Result, (LLength - 2));
      Result := Copy(AString, 1, LLength - 2);
    end;
  end;
end;

function Cosec(const X: Extended): Extended;
{ Cosecant := 1 / Sin(X) }
asm
        FLD   X
        FSIN
        FLD1
        FDIVRP
        FWAIT
end;


initialization
  LockDecimalSep := TCriticalSection.Create;

finalization
  LockDecimalSep.free;

end.
