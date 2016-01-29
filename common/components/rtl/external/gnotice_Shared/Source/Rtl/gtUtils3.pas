{ ****************************************************************************** }
{ }
{ Gnostice Shared Visual Component Library }
{ }
{ Copyright © 2002-2008 Gnostice Information Technologies Private Limited }
{ http://www.gnostice.com }
{ }
{ ****************************************************************************** }
{$I ..\gtSharedDefines.inc}
unit gtUtils3;

interface

uses Windows, SysUtils, Graphics, StdCtrls, Controls, Classes, SyncObjs,
  ExtCtrls, Dialogs;

const
  { Default word delimiters are any character except the core alphanumerics. }
  WordDelimiters: set of AnsiChar = [#0 .. #255] - ['a' .. 'z', 'A' .. 'Z',
    '1' .. '9', '0'];

var
  LockDecimalSep: TCriticalSection;
  boolTrueType: Boolean;

const
  HoursPerDay = 24;

  MinsPerHour = 60;

  SecsPerMin = 60;

  MSecsPerSec = 1000;

  MinsPerDay = HoursPerDay * MinsPerHour;

  SecsPerDay = MinsPerDay * SecsPerMin;

  SecsPerHour = SecsPerMin * MinsPerHour;

  MSecsPerDay = SecsPerDay * MSecsPerSec;

type
  // MD5
  TgtByteArray1 = array of Byte;

  MD5Count = array [0 .. 1] of DWORD;

  MD5State = array [0 .. 3] of DWORD;

  MD5Block = array [0 .. 15] of DWORD;

  MD5CBits = array [0 .. 7] of Byte;

  MD5Digest = array [0 .. 15] of Byte;

  MD5Buffer = array [0 .. 63] of Byte;

  MD5Context = record
    State: MD5State;
    Count: MD5Count;
    Buffer: MD5Buffer;
  end;

  TgtSigCertLevel = (clNoChange, clFillFormFields, clInsertAnnots);
  TgtSigFieldAppearenceOption = (sfaoShowName, sfaoShowReason, sfaoShowLocation,
    sfaoShowDate, sfaoShowLabels);

  THackWinControl = class(TWinControl);

  TgtByteArray = array of Byte;

  TStringSeachOption = (soDown, soMatchCase, soWholeWord);

  TStringSearchOptions = set of TStringSeachOption;

  TgtRect = record
    Left, Top, Right, Bottom: Double;
  end;

  { TgtMD5 }

  TgtMD5 = class(Tobject)
  private
    FContext: MD5Context;
    FBufferPad: MD5Buffer;
    procedure Transform(ABuffer: Pointer; var AState: MD5State);
    function F(AX, AY, AZ: DWORD): DWORD;
    procedure FF(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: Byte;
      ADWORD: DWORD);
    function G(AX, AY, AZ: DWORD): DWORD;
    procedure GG(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: Byte;
      ADWORD: DWORD);
    function H(AX, AY, AZ: DWORD): DWORD;
    procedure HH(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: Byte;
      ADWORD: DWORD);
    function I(AX, AY, AZ: DWORD): DWORD;
    procedure II(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: Byte;
      ADWORD: DWORD);
    procedure Rot(var AX: DWORD; AN: Byte);
    procedure Decode(ASource, ATarget: Pointer; ACount: Longword);
    procedure Encode(ASource, ATarget: Pointer; ACount: Longword);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Initilize;
    procedure Update(AInput: Pointer; ALength: Longword;
      Flag: Boolean); overload;
    procedure Update(AInput: array of Byte; ALength: Longword); overload;
    procedure Finalize(var ADigest: MD5Digest);
    procedure GetHash(AInput: TgtByteArray1; ALength: Longword;
      var ADigest: MD5Digest); overload;
    procedure GetHash(AInput: TStream; var ADigest: MD5Digest); overload;
    function CompareHash(const AHash1, AHash2: MD5Digest): Boolean;
  end;

  TDateOrder = (doMDY, doDMY, doYMD);

  // Conditional Routines
function IfThen(AValue: Boolean; const ATrue: Integer;
  const AFalse: Integer = 0): Integer; overload;
function IfThen(AValue: Boolean; const ATrue: DWORD; const AFalse: DWORD = 0)
  : DWORD; overload;
function IfThen(AValue: Boolean; const ATrue: Double;
  const AFalse: Double = 0.0): Double; overload;
function IfThen(AValue: Boolean; const ATrue: String; const AFalse: String = '')
  : String; overload;

// String Handling Routines
function RightStr(const AText: String; const ACount: Integer): String;

function LeftStr(const AText: String; const ACount: Integer): String;

function MidStr(const AText: String; const AStart, ACount: Integer): String;

function PosEx(const SubStr, S: String; Offset: Cardinal = 1): Integer;

function SearchBuf(Buf: PChar; BufLen: Integer; SelStart, SelLength: Integer;
  SearchString: String; Options: TStringSearchOptions = [soDown]): PChar;

function TryStrToInt(const S: String; out Value: Integer): Boolean;

{$IFDEF gtDelphi5}
function CurrentYear: Word;
function IsLeadChar(C: AnsiChar): Boolean;
function NextCharIndex(const S: AnsiString; Index: Integer): Integer;

function StrCharLength(const Str: PAnsiChar): Integer;
function GetEraYearOffset(const Name: string): Integer;

function TryEncodeDate(Year, Month, Day: Word; out Date: TDateTime): Boolean;
function TryEncodeTime(Hour, Min, Sec, MSec: Word; out Time: TDateTime)
  : Boolean;
function GetDateOrder(const DateFormat: string): TDateOrder;

procedure ScanBlanks(const S: string; var Pos: Integer);

function ScanNumber(const S: string; var Pos: Integer; var Number: Word;
  var CharCount: Byte): Boolean;

function ScanString(const S: string; var Pos: Integer;
  const Symbol: string): Boolean;

function ScanChar(const S: string; var Pos: Integer; Ch: Char): Boolean;

procedure ScanToNumber(const S: string; var Pos: Integer);

function ScanDate(const S: string; var Pos: Integer;
  var Date: TDateTime): Boolean;

function ScanTime(const S: string; var Pos: Integer;
  var Time: TDateTime): Boolean;

function TryStrToDate(const S: string; out Value: TDateTime): Boolean;

function TryStrToTime(const S: string; out Value: TDateTime): Boolean;

function TryStrToDateTime(const S: string; out Value: TDateTime): Boolean;

{$ENDIF}
function ReplaceString(const S, OldPattern, NewPattern: WideString)
  : WideString; overload;

function ReplaceStringPos(const S: String; Offset: Integer;
  OldPattern, NewPattern: String): String;

procedure RemoveNullCharacters(var S: String);

function AnsiContainsText(const AText, ASubText: String): Boolean;

procedure FreeAndNil(var Obj);
function TextSize(const Text: String; AFont: TFont): TSize;

function ColorToPDFColor(AColor: TColor): String;

function ColorBGRToRGB(AColor: TColor): String;

procedure CheckSysColor(var Color: TColor);

procedure SetControlsEnabled(AControl: TWinControl; AState: Boolean;
  AIgnoreList: TList = nil);
// Unit Conversion Functions.
function DegreesToRadians(Degrees: Extended): Extended;
function PixelsToPoints(X: Extended): Extended;
function PointsToPixels(X: Extended): Extended;
function RadiansToDegrees(Radians: Extended): Extended;

// Conversion Routines
function IsHex(AString: String): Boolean;

function IsOctal(AString: String): Boolean;

function GetHexOfStr(AString: AnsiString): AnsiString;

function GetHexOfStrw(AString: String): String;

{$IFNDEF gtDelphi6Up}
procedure BinToHex(Buffer, Text: PChar; BufSize: Integer);
{$ENDIF}
function HexToByteArray(AHex: String): TgtByteArray;

function HexToByteValue(AHex: String; out AByte: Byte): Integer;

function HexToByteString(AHex: String): String;

procedure OctalToByteValue(AOctal: String; out AByte: Byte);

procedure EscapeStringToByteArray(AEscapeString: AnsiString;
  var AByte: array of Byte);

procedure EscapeStringToString(AEscapeString: String; var AString: String);

function StringToEscapeString(AString: String): String;

function ConvertTabsToSpaces(Str: String; Fonts: TFont;
  TabsStops: TStringList): String;

// Float to String Locale
function FloatToStrLocale(Value: Double): String;

function FloatToStrFLocale(Value: Extended; Format: TFloatFormat;
  Precision, Digits: Integer): String;

// String to Float Locale
function StrToFloatLocale(AString: String): Double;

function gtRect(Left, Top, Right, Bottom: Double): TgtRect; overload;

function gtRect(ARect: TgtRect; AFactor: Double): TgtRect; overload;

function gtRect(ARect: TgtRect; AXFactor, AYFactor: Double): TgtRect; overload;

// Font Charsets collection
procedure GetSupportedCharSets(const FaceName: String; CharSets: TList);

{ var
  MD5Data: MD5Context;

  procedure MD5Final(var AContext: MD5Context; var ADigest: MD5Digest);
  procedure MD5Init(var AContext: MD5Context);
  procedure MD5Update(var AContext: MD5Context; AInput: array of Byte;
  ALength: Longword);
  function GetHash(AInput: TStream): MD5Digest; overload;
  function CompareHash(const AHash1, AHash2: MD5Digest): Boolean; }

implementation

uses
  Math, gtConsts3, Forms;

type
  TNewTextMetricEx = packed record
    NewTextMetric: TNewTextMetric;
    FontSignature: TFontSignature end;

    (* ---------------------------------------------------------------------------- *)

    function EnumFontFamExProc(const EnumLogFontEx: TEnumLogFontEx;
      const NewTextMetricEx: TNewTextMetricEx; FontType: Integer; lParam: TList)
      : Integer; stdcall;

  var
    LI: Integer;
  begin
    LI := EnumLogFontEx.elfLogFont.lfCharSet;
    case (LI) of
      ANSI_CHARSET, SYMBOL_CHARSET, SHIFTJIS_CHARSET, HANGEUL_CHARSET,
        GB2312_CHARSET, CHINESEBIG5_CHARSET, OEM_CHARSET, JOHAB_CHARSET,
        HEBREW_CHARSET, ARABIC_CHARSET, GREEK_CHARSET, TURKISH_CHARSET,
        VIETNAMESE_CHARSET, THAI_CHARSET, EASTEUROPE_CHARSET, RUSSIAN_CHARSET,
        MAC_CHARSET, BALTIC_CHARSET:
        begin
          if (lParam.IndexOf(Tobject(LI)) = -1) then
            lParam.Add(Tobject(LI));
        end;
    end;
    Result := 1;
  end;

  (* ---------------------------------------------------------------------------- *)

  procedure GetSupportedCharSets(const FaceName: String; CharSets: TList);

  var
    DC: THandle;
    LogFont: TLogFont;
{$IFDEF gtDelphi2009Up}
    LWideString: WideString;
    I: Integer;
{$ENDIF}
  begin
    DC := GetDC(GetDesktopWindow);
    if DC <> 0 then
      try
        FillChar(LogFont, SizeOf(LogFont), 0);
{$IFDEF gtDelphi2009Up}
        LWideString := FaceName;
        for I := 0 to Length(LWideString) - 1 do
          LogFont.lfFaceName[I] := LWideString[I + 1];
{$ELSE}
        Move(FaceName[1], LogFont.lfFaceName, Length(FaceName));
{$ENDIF}
        LogFont.lfCharSet := DEFAULT_CHARSET;
        EnumFontFamiliesEx(DC, LogFont, @EnumFontFamExProc,
          lParam(CharSets), 0);
      finally
        ReleaseDC(GetDesktopWindow, DC)
      end
  end;

  (* ---------------------------------------------------------------------------- *)

  function GetHexOfStr(AString: AnsiString): AnsiString;
  begin
    Result := '';
    SetLength(Result, Length(AString) * 2);
    BinToHex(PAnsiChar(AString), PAnsiChar(Result), Length(AString));
  end;

  function GetHexOfStrw(AString: String): String;

  var
    Val: Integer;
    Len, LI: Integer;
  begin
    Result := '';
    Len := Length(AString);
    for LI := 1 to Len do
    begin
      Val := Ord(AString[LI]);
      Result := Result + IntToHex(Val, 4);
    end;

  end;
  (* ---------------------------------------------------------------------------- *)

  function ColorToPDFColor(AColor: TColor): String;
  function PDFColor(HexCode: String): String;
  begin
    CheckSysColor(AColor);
    Result := Format('%1.4f', [StrToIntDef('$' + HexCode, 0) / 255]);
    if {$IFDEF gtDelphiXEUp} FormatSettings.
{$ENDIF} DecimalSeparator <> '.' then
      Result := ReplaceString(Result,
{$IFDEF gtDelphiXEUp} FormatSettings.{$ENDIF} DecimalSeparator, '.');
  end;
  begin
    Result := Copy(IntToHex(ColorToRGB(AColor), 8), 3, 6);
    Result := PDFColor(Copy(Result, 5, 2)) + ' ' + PDFColor(Copy(Result, 3, 2))
      + ' ' + PDFColor(Copy(Result, 1, 2));
  end;

  (* ---------------------------------------------------------------------------- *)

  function TextSize(const Text: String; AFont: TFont): TSize;

  var
    DC: HDC;
    SaveFont: HFont;
    LSize: TSize;
  begin
    DC := GetDC(0);
    SaveFont := SelectObject(DC, AFont.Handle);
    GetTextExtentPoint32(DC, PChar(Text), Length(Text), LSize);
    SelectObject(DC, SaveFont);
    ReleaseDC(0, DC);
    Result := LSize;
  end;

  (* ---------------------------------------------------------------------------- *)

  function RightStr(const AText: String; const ACount: Integer): String;
  begin
    Result := Copy(WideString(AText), Length(WideString(AText)) + 1 -
      ACount, ACount);
  end;

  (* ---------------------------------------------------------------------------- *)

  function LeftStr(const AText: String; const ACount: Integer): String;
  begin
    Result := Copy(WideString(AText), 1, ACount);
  end;

  (* ---------------------------------------------------------------------------- *)

  function MidStr(const AText: String; const AStart, ACount: Integer): String;
  begin
    Result := Copy(WideString(AText), AStart, ACount);
  end;

  (* ---------------------------------------------------------------------------- *)

  function PosEx(const SubStr, S: String; Offset: Cardinal = 1): Integer;

  var
    I, X: Integer;
    Len, LenSubStr: Integer;
  begin
    if Offset = 1 then
      Result := Pos(SubStr, S)
    else
    begin
      I := Offset;
      LenSubStr := Length(SubStr);
      Len := Length(S) - LenSubStr + 1;
      while I <= Len do
      begin
        if S[I] = SubStr[1] then
        begin
          X := 1;
          while (X < LenSubStr) and (S[I + X] = SubStr[X + 1]) do
            Inc(X);
          if (X = LenSubStr) then
          begin
            Result := I;
            exit;
          end;
        end;
        Inc(I);
      end;
      Result := 0;
    end;
  end;

  (* ---------------------------------------------------------------------------- *)

  function SearchBuf(Buf: PChar; BufLen: Integer; SelStart, SelLength: Integer;
    SearchString: String; Options: TStringSearchOptions): PChar;

  var
    SearchCount, I: Integer;
    C: Char;
    Direction: Shortint;
    ShadowMap: array [0 .. 256] of Char;
    CharMap: array [Char] of Char absolute ShadowMap;

    function FindNextWordStart(var BufPtr: PChar): Boolean;
    begin { (True XOR N) is equivalent to (not N) }
      { (False XOR N) is equivalent to (N) }
      { When Direction is forward (1), skip non delimiters, then skip delimiters. }
      { When Direction is backward (-1), skip delims, then skip non delims }
{$IFDEF gtDelphi2009Up}
      while (SearchCount > 0) and
        ((Direction = 1) xor SysUtils.CharInSet(BufPtr^, WordDelimiters)) do
{$ELSE}
      while (SearchCount > 0) and
        ((Direction = 1) xor (BufPtr^ in WordDelimiters)) do
{$ENDIF}
      begin
        Inc(BufPtr, Direction);
        Dec(SearchCount);
      end;
{$IFDEF gtDelphi2009Up}
      while (SearchCount > 0) and
        ((Direction = -1) xor SysUtils.CharInSet(BufPtr^, WordDelimiters)) do
{$ELSE}
      while (SearchCount > 0) and
        ((Direction = -1) xor (BufPtr^ in WordDelimiters)) do
{$ENDIF}
      begin
        Inc(BufPtr, Direction);
        Dec(SearchCount);
      end;
      Result := SearchCount > 0;
      if Direction = -1 then
      begin { back up one Char, to leave ptr on first non delim }
        Dec(BufPtr, Direction);
        Inc(SearchCount);
      end;
    end;

    begin
      Result := nil;
      if BufLen <= 0 then
        exit;
      if soDown in Options then
      begin
        Direction := 1;
        Inc(SelStart, SelLength); { start search past end of selection }
        SearchCount := BufLen - SelStart - Length(SearchString) + 1;
        if SearchCount < 0 then
          exit;
        if Longint(SelStart) + SearchCount > BufLen then
          exit;
      end
      else
      begin
        Direction := -1;
        Dec(SelStart, Length(SearchString));
        SearchCount := SelStart + 1;
      end;
      if (SelStart < 0) or (SelStart > BufLen) then
        exit;
      Result := @Buf[SelStart];

      { Using a Char map array is faster than calling AnsiUpper on every character }
      for C := Low(CharMap) to High(CharMap) do
        CharMap[C] := C;
      { Since CharMap is overlayed onto the ShadowMap and ShadowMap is 1 byte longer,
        we can use that extra byte as a guard NULL }
      ShadowMap[256] := #0;

      if not(soMatchCase in Options) then
      begin
{$IFDEF MSWINDOWS}
        AnsiUpperBuff(PAnsiChar(@CharMap), SizeOf(CharMap));
        AnsiUpperBuff(@SearchString[1], Length(SearchString));
{$ENDIF}
{$IFDEF LINUX}
        AnsiStrUpper(@CharMap[#1]);
        SearchString := AnsiUpperCase(SearchString);
{$ENDIF}
      end;

      while SearchCount > 0 do
      begin
        if (soWholeWord in Options) and (Result <> @Buf[SelStart]) then
          if not FindNextWordStart(Result) then
            Break;
        I := 0;
        while (CharMap[Result[I]] = SearchString[I + 1]) do
        begin
          Inc(I);
          if I >= Length(SearchString) then
          begin
{$IFDEF gtDelphi2009Up}
            if (not(soWholeWord in Options)) or (SearchCount = 0) or
              SysUtils.CharInSet(Result[I], WordDelimiters) then
{$ELSE}
            if (not(soWholeWord in Options)) or (SearchCount = 0) or
              (Result[I] in WordDelimiters) then
{$ENDIF}
              exit;
            Break;
          end;
        end;
        Inc(Result, Direction);
        Dec(SearchCount);
      end;
      Result := nil;
    end;

    (* ---------------------------------------------------------------------------- *)

    function TryStrToInt(const S: String; out Value: Integer): Boolean;

  var
    E: Integer;
  begin
    Val(S, Value, E);
    Result := E = 0;
  end;

  (* ---------------------------------------------------------------------------- *)
{$IFDEF gtDelphi5}
  function CurrentYear: Word;
{$IFDEF MSWINDOWS}

  var
    SystemTime: TSystemTime;
  begin
    GetLocalTime(SystemTime);
    Result := SystemTime.wYear;
  end;
{$ENDIF}
{$IFDEF LINUX}

  var
    T: TTime_T;
    UT: TUnixTime;
  begin
    __time(@T);
    localtime_r(@T, UT);
    Result := UT.tm_year + 1900;
  end;
{$ENDIF}
  (* ---------------------------------------------------------------------------- *)

  function IsLeadChar(C: AnsiChar): Boolean;
  begin
    Result := C in LeadBytes;
  end;

  (* ---------------------------------------------------------------------------- *)

  function NextCharIndex(const S: AnsiString; Index: Integer): Integer;
  begin
    Result := Index + 1;
    assert((Index > 0) and (Index <= Length(S)));
    if IsLeadChar(S[Index]) then
      Result := Index + StrCharLength(PAnsiChar(S) + Index - 1);
  end;

  (* ---------------------------------------------------------------------------- *)

  function StrCharLength(const Str: PAnsiChar): Integer;
  begin
{$IFDEF LINUX}
    Result := mblen(Str, MB_CUR_MAX);
    if (Result = -1) then
      Result := 1;
{$ENDIF}
{$IFDEF MSWINDOWS}
    if SysLocale.FarEast and (Str^ <> #0) then
      Result := Integer(CharNextA(Str)) - Integer(Str)
    else
      Result := 1;
{$ENDIF}
  end;

  (* ---------------------------------------------------------------------------- *)

  function GetEraYearOffset(const Name: string): Integer;

  var
    I: Integer;
  begin
    Result := 0;
    for I := Low(EraNames) to High(EraNames) do
    begin
      if EraNames[I] = '' then
        Break;
      if AnsiStrPos(PChar(EraNames[I]), PChar(Name)) <> nil then
      begin
        Result := EraYearOffsets[I];
        exit;
      end;
    end;
  end;

  (* ---------------------------------------------------------------------------- *)

  function TryEncodeDate(Year, Month, Day: Word; out Date: TDateTime): Boolean;

  var
    I: Integer;
    DayTable: PDayTable;
  begin
    Result := False;
    DayTable := @MonthDays[IsLeapYear(Year)];
    if (Year >= 1) and (Year <= 9999) and (Month >= 1) and (Month <= 12) and
      (Day >= 1) and (Day <= DayTable^[Month]) then
    begin
      for I := 1 to Month - 1 do
        Inc(Day, DayTable^[I]);
      I := Year - 1;
      Date := I * 365 + I div 4 - I div 100 + I div 400 + Day - DateDelta;
      Result := True;
    end;
  end;

  (* ---------------------------------------------------------------------------- *)

  function TryEncodeTime(Hour, Min, Sec, MSec: Word;
    out Time: TDateTime): Boolean;
  begin
    Result := False;
    if (Hour < HoursPerDay) and (Min < MinsPerHour) and (Sec < SecsPerMin) and
      (MSec < MSecsPerSec) then
    begin
      Time := (Hour * (MinsPerHour * SecsPerMin * MSecsPerSec) + Min *
        (SecsPerMin * MSecsPerSec) + Sec * MSecsPerSec + MSec) / MSecsPerDay;
      Result := True;
    end;
  end;

  (* ---------------------------------------------------------------------------- *)

  function GetDateOrder(const DateFormat: string): TDateOrder;

  var
    I: Integer;
  begin
    Result := doMDY;
    I := 1;
    while I <= Length(DateFormat) do
    begin
      case Chr(Ord(DateFormat[I]) and $DF) of
        'E':
          Result := doYMD;
        'Y':
          Result := doYMD;
        'M':
          Result := doMDY;
        'D':
          Result := doDMY;
      else
        Inc(I);
        Continue;
      end;
      exit;
    end;
    Result := doMDY;
  end;

  (* ---------------------------------------------------------------------------- *)

  procedure ScanBlanks(const S: string; var Pos: Integer);

  var
    I: Integer;
  begin
    I := Pos;
    while (I <= Length(S)) and (S[I] = ' ') do
      Inc(I);
    Pos := I;
  end;

  (* ---------------------------------------------------------------------------- *)

  function ScanNumber(const S: string; var Pos: Integer; var Number: Word;
    var CharCount: Byte): Boolean;

  var
    I: Integer;
    N: Word;
  begin
    Result := False;
    CharCount := 0;
    ScanBlanks(S, Pos);
    I := Pos;
    N := 0;
    while (I <= Length(S)) and (S[I] in ['0' .. '9']) and (N < 1000) do
    begin
      N := N * 10 + (Ord(S[I]) - Ord('0'));
      Inc(I);
    end;
    if I > Pos then
    begin
      CharCount := I - Pos;
      Pos := I;
      Number := N;
      Result := True;
    end;
  end;

  (* ---------------------------------------------------------------------------- *)

  function ScanString(const S: string; var Pos: Integer;
    const Symbol: string): Boolean;
  begin
    Result := False;
    if Symbol <> '' then
    begin
      ScanBlanks(S, Pos);
      if AnsiCompareText(Symbol, Copy(S, Pos, Length(Symbol))) = 0 then
      begin
        Inc(Pos, Length(Symbol));
        Result := True;
      end;
    end;
  end;

  (* ---------------------------------------------------------------------------- *)

  function ScanChar(const S: string; var Pos: Integer; Ch: Char): Boolean;
  begin
    Result := False;
    ScanBlanks(S, Pos);
    if (Pos <= Length(S)) and (S[Pos] = Ch) then
    begin
      Inc(Pos);
      Result := True;
    end;
  end;

  (* ---------------------------------------------------------------------------- *)

  procedure ScanToNumber(const S: string; var Pos: Integer);
  begin
    while (Pos <= Length(S)) and not(S[Pos] in ['0' .. '9']) do
    begin
      if IsLeadChar(AnsiChar(S[Pos])) then
        Pos := NextCharIndex(S, Pos)
      else
        Inc(Pos);
    end;
  end;

  (* ---------------------------------------------------------------------------- *)

  function ScanDate(const S: string; var Pos: Integer;
    var Date: TDateTime): Boolean;

  var
    DateOrder: TDateOrder;
    N1, N2, N3, Y, M, D: Word;
    L1, L2, L3, YearLen: Byte;
    CenturyBase: Integer;
    EraName: string;
    EraYearOffset: Integer;

    function EraToYear(Year: Integer): Integer;
    begin
{$IFDEF MSWINDOWS}
      if SysLocale.PriLangID = LANG_KOREAN then
      begin
        if Year <= 99 then
          Inc(Year, (CurrentYear + Abs(EraYearOffset)) div 100 * 100);
        if EraYearOffset > 0 then
          EraYearOffset := -EraYearOffset;
      end
      else
        Dec(EraYearOffset);
{$ENDIF}
      Result := Year + EraYearOffset;
    end;

    begin
      Y := 0;
      M := 0;
      D := 0;
      YearLen := 0;
      Result := False;
      DateOrder := GetDateOrder(ShortDateFormat);
      EraYearOffset := 0;
      if ShortDateFormat[1] = 'g' then // skip over prefix text
      begin
        ScanToNumber(S, Pos);
        EraName := Trim(Copy(S, 1, Pos - 1));
        EraYearOffset := GetEraYearOffset(EraName);
      end
      else if AnsiPos('e', ShortDateFormat) > 0 then
        EraYearOffset := EraYearOffsets[1];
      if not(ScanNumber(S, Pos, N1, L1) and ScanChar(S, Pos, DateSeparator) and
        ScanNumber(S, Pos, N2, L2)) then
        exit;
      if ScanChar(S, Pos, DateSeparator) then
      begin
        if not ScanNumber(S, Pos, N3, L3) then
          exit;
        case DateOrder of
          doMDY:
            begin
              Y := N3;
              YearLen := L3;
              M := N1;
              D := N2;
            end;
          doDMY:
            begin
              Y := N3;
              YearLen := L3;
              M := N2;
              D := N1;
            end;
          doYMD:
            begin
              Y := N1;
              YearLen := L1;
              M := N2;
              D := N3;
            end;
        end;
        if EraYearOffset > 0 then
          Y := EraToYear(Y)
        else if (YearLen <= 2) then
        begin
          CenturyBase := CurrentYear - TwoDigitYearCenturyWindow;
          Inc(Y, CenturyBase div 100 * 100);
          if (TwoDigitYearCenturyWindow > 0) and (Y < CenturyBase) then
            Inc(Y, 100);
        end;
      end
      else
      begin
        Y := CurrentYear;
        if DateOrder = doDMY then
        begin
          D := N1;
          M := N2;
        end
        else
        begin
          M := N1;
          D := N2;
        end;
      end;
      ScanChar(S, Pos, DateSeparator);
      ScanBlanks(S, Pos);
      if SysLocale.FarEast and (System.Pos('ddd', ShortDateFormat) <> 0) then
      begin // ignore trailing text
        if ShortTimeFormat[1] in ['0' .. '9'] then // stop at time digit
          ScanToNumber(S, Pos)
        else // stop at time prefix
          repeat
            while (Pos <= Length(S)) and (S[Pos] <> ' ') do
              Inc(Pos);
            ScanBlanks(S, Pos);
          until (Pos > Length(S)) or
            (AnsiCompareText(TimeAMString, Copy(S, Pos, Length(TimeAMString)))
            = 0) or (AnsiCompareText(TimePMString,
            Copy(S, Pos, Length(TimePMString))) = 0);
      end;
      Result := TryEncodeDate(Y, M, D, Date);
    end;

    (* ---------------------------------------------------------------------------- *)

    function ScanTime(const S: string; var Pos: Integer;
      var Time: TDateTime): Boolean;

  var
    BaseHour: Integer;
    Hour, Min, Sec, MSec: Word;
    Junk: Byte;
  begin
    Result := False;
    BaseHour := -1;
    if ScanString(S, Pos, TimeAMString) or ScanString(S, Pos, 'AM') then
      BaseHour := 0
    else if ScanString(S, Pos, TimePMString) or ScanString(S, Pos, 'PM') then
      BaseHour := 12;
    if BaseHour >= 0 then
      ScanBlanks(S, Pos);
    if not ScanNumber(S, Pos, Hour, Junk) then
      exit;
    Min := 0;
    Sec := 0;
    MSec := 0;
    if ScanChar(S, Pos, TimeSeparator) then
    begin
      if not ScanNumber(S, Pos, Min, Junk) then
        exit;
      if ScanChar(S, Pos, TimeSeparator) then
      begin
        if not ScanNumber(S, Pos, Sec, Junk) then
          exit;
        if ScanChar(S, Pos, DecimalSeparator) then
          if not ScanNumber(S, Pos, MSec, Junk) then
            exit;
      end;
    end;
    if BaseHour < 0 then
      if ScanString(S, Pos, TimeAMString) or ScanString(S, Pos, 'AM') then
        BaseHour := 0
      else if ScanString(S, Pos, TimePMString) or ScanString(S, Pos, 'PM') then
        BaseHour := 12;
    if BaseHour >= 0 then
    begin
      if (Hour = 0) or (Hour > 12) then
        exit;
      if Hour = 12 then
        Hour := 0;
      Inc(Hour, BaseHour);
    end;
    ScanBlanks(S, Pos);
    Result := TryEncodeTime(Hour, Min, Sec, MSec, Time);
  end;

  (* ---------------------------------------------------------------------------- *)

  function TryStrToDate(const S: string; out Value: TDateTime): Boolean;

  var
    Pos: Integer;
  begin
    Pos := 1;
    Result := ScanDate(S, Pos, Value) and (Pos > Length(S));
  end;

  (* ---------------------------------------------------------------------------- *)

  function TryStrToTime(const S: string; out Value: TDateTime): Boolean;

  var
    Pos: Integer;
  begin
    Pos := 1;
    Result := ScanTime(S, Pos, Value) and (Pos > Length(S));
  end;

  (* ---------------------------------------------------------------------------- *)

  function TryStrToDateTime(const S: string; out Value: TDateTime): Boolean;

  var
    Pos: Integer;
    NumberPos: Integer;
    BlankPos, LastBlankPos, OrigBlankPos: Integer;
    LDate, LTime: TDateTime;
    Stop: Boolean;
  begin
    Result := True;
    Pos := 1;
    LTime := 0;

    // jump over all the non-numeric characters before the date data
    ScanToNumber(S, Pos);

    // date data scanned; searched for the time data
    if ScanDate(S, Pos, LDate) then
    begin
      // search for time data; search for the first number in the time data
      NumberPos := Pos;
      ScanToNumber(S, NumberPos);

      // the first number of the time data was found
      if NumberPos < Length(S) then
      begin
        // search between the end of date and the start of time for AM and PM
        // strings; if found, then ScanTime from this position where it is found
        BlankPos := Pos - 1;
        Stop := False;
        while (not Stop) and (BlankPos < NumberPos) do
        begin
          // blank was found; scan for AM/PM strings that may follow the blank
          if (BlankPos > 0) and (BlankPos < NumberPos) then
          begin
            Inc(BlankPos); // start after the blank
            OrigBlankPos := BlankPos;
            // keep BlankPos because ScanString modifies it
            Stop := ScanString(S, BlankPos, TimeAMString) or
              ScanString(S, BlankPos, 'AM') or
              ScanString(S, BlankPos, TimePMString) or
              ScanString(S, BlankPos, 'PM');

            // ScanString jumps over the AM/PM string; if found, then it is needed
            // by ScanTime to correctly scan the time
            BlankPos := OrigBlankPos;
          end
          // no more blanks found; end the loop
          else
            Stop := True;

          // search of the next blank if no AM/PM string has been found
          if not Stop then
          begin
            LastBlankPos := BlankPos;
            BlankPos := PosEx(' ', S, LastBlankPos);
          end;
        end;

        // loop was forcely stopped; check if AM/PM has been found
        if Stop then
          // AM/PM has been found; check if it is before or after the time data
          if BlankPos > 0 then
            if BlankPos < NumberPos then // AM/PM is before the time number
              Pos := BlankPos
            else
              Pos := NumberPos // AM/PM is after the time number
          else
            Pos := NumberPos
            // the blank found is after the the first number in time data
        else
          Pos := NumberPos;

        // get the time data
        Result := ScanTime(S, Pos, LTime);

        // time data scanned with no errors
        if Result then
          if LDate >= 0 then
            Value := LDate + LTime
          else
            Value := LDate - LTime
      end
      // no time data; return only date data
      else
        Value := LDate;
    end
    // could not scan date data; try to scan time data
    else
      Result := TryStrToTime(S, Value)
  end;
{$ENDIF}
  (* ---------------------------------------------------------------------------- *)

  function ReplaceString(const S, OldPattern, NewPattern: WideString)
    : WideString;

  var
    I: Integer;
    SearchStr, Str, OldPat: WideString;
  begin
    Result := '';
    if S <> '' then
      if IsDBCSLeadByte(Byte(S[1])) then
      begin
        SearchStr := AnsiUpperCase(S);
        OldPat := AnsiUpperCase(OldPattern);
        Str := S;
        Result := '';
        while SearchStr <> '' do
        begin
          I := AnsiPos(OldPat, SearchStr);
          if I = 0 then
          begin
            Result := Result + Str;
            Break;
          end;
          Result := Result + Copy(Str, 1, I - 1) + NewPattern;
          Str := Copy(Str, I + Length(OldPattern), MaxInt);
          SearchStr := Copy(SearchStr, I + Length(OldPat), MaxInt);
        end;
      end
      else
      begin
        SearchStr := AnsiUpperCase(S);
        OldPat := AnsiUpperCase(OldPattern);
        Str := S;
        Result := '';
        while SearchStr <> '' do
        begin
          I := AnsiPos(OldPat, SearchStr);
          if I = 0 then
          begin
            Result := Result + Str;
            Break;
          end;
          Result := Result + Copy(Str, 1, I - 1) + NewPattern;
          Str := Copy(Str, I + Length(OldPattern), MaxInt);
          SearchStr := Copy(SearchStr, I + Length(OldPat), MaxInt);
        end;
      end;
  end;

  (* ---------------------------------------------------------------------------- *)

  function ReplaceStringPos(const S: String; Offset: Integer;
    OldPattern, NewPattern: String): String;

  var
    I: Integer;
    SearchStr, Str, OldPat: String;
  begin
    SearchStr := AnsiUpperCase(S);
    OldPat := AnsiUpperCase(OldPattern);
    Str := S;
    Result := '';

    Result := Copy(Str, 1, Offset - 1);
    Str := Copy(Str, Offset, MaxInt);
    SearchStr := AnsiUpperCase(Str);

    I := AnsiPos(OldPat, SearchStr);
    if I = 0 then
    begin
      Result := Result + Str;
      exit;
    end;
    Result := Result + Copy(Str, 1, I - 1) + NewPattern;
    Result := Result + Copy(Str, I + Length(OldPattern), MaxInt);
  end;
  (* ---------------------------------------------------------------------------- *)

  procedure RemoveNullCharacters(var S: String);

  var
    I, j: Integer;
  begin
    j := 0;
    for I := 1 to Length(S) do
      if S[I] <> #0 then
      begin
        Inc(j);
        S[j] := S[I];
      end;
    if j < Length(S) then
      SetLength(S, j);
  end;
  (* ---------------------------------------------------------------------------- *)

  function AnsiContainsText(const AText, ASubText: String): Boolean;
  begin
    Result := AnsiPos(AnsiUpperCase(ASubText), AnsiUpperCase(AText)) > 0;
  end;

  (* ---------------------------------------------------------------------------- *)
{$IFNDEF gtDelphi6Up}
  procedure BinToHex(Buffer, Text: PChar; BufSize: Integer);

  const
    Convert: array [0 .. 15] of Char = '0123456789ABCDEF';

  var
    I: Integer;
  begin
    for I := 0 to BufSize - 1 do
    begin
      Text[0] := Convert[Byte(Buffer[I]) shr 4];
      Text[1] := Convert[Byte(Buffer[I]) and $F];
      Inc(Text, 2);
    end;
  end;
{$ENDIF}
  (* ---------------------------------------------------------------------------- *)

  function StringToEscapeString(AString: String): String;

  var
    LI, Tabs, Rem, Pos, I, Count: Integer;
    TempStr: String;
  begin
    Tabs := 8;
    Count := 8;
    Result := '';
    TempStr := '';
    for LI := 1 to Length(AString) do
    begin
      case AString[LI] of
        '(':
          begin
            Result := Result + '\(';
            Count := Count - 1;
          end;
        ')':
          begin
            Result := Result + '\)';
            Count := Count - 1;
          end;
        '\':
          begin
            Result := Result + '\\';
            Count := Count - 1;
          end;
        #13:
          begin
            Result := Result + '\r';
            Count := Count - 1;
          end;
        #10:
          begin
            Result := Result + '\n';
            Count := Count - 1;
          end;
        #9:
          begin
            Rem := 8 - Count;
            Pos := Tabs - Rem;
            for I := LI to (LI + Pos - 1) do
            begin
              TempStr := TempStr + ' ';
              Count := Count - 1;
            end;
            Result := Result + TempStr;
            TempStr := '';
          end;
        #8:
          Result := Result + '\b';
        #12:
          Result := Result + '\f';
      else
        begin
          Result := Result + AString[LI];
          Count := Count - 1;
        end;
      end;
      if (Count = 0) then
        Count := 8;
    end;
  end;

  (* ---------------------------------------------------------------------------- *)

  function GetCountOfSpaces(Spaces: Double; SingleSpaces: Double;
    UseDefault: Boolean): Integer;

  var
    Time: Integer;
  begin
    if not UseDefault then
      Time := round(Spaces / (Double(SingleSpaces) / round(CPixelsPerInch)))
    else
      Time := Floor(Spaces / SingleSpaces);
    Result := Time;
  end;

  (* ---------------------------------------------------------------------------- *)

  function GetRemainingSpaces(DataWidths: Double; TabSpaces: Double): Double;

  var
    Spaces, Extras: Double;
  begin
    if (DataWidths > TabSpaces) then
    begin
      Extras := DataWidths - TabSpaces;
      while Extras > TabSpaces do
        Extras := Extras - TabSpaces;
      Spaces := TabSpaces - Extras;
    end
    else
      Spaces := TabSpaces - DataWidths;
    Result := Spaces;
  end;

  (* ---------------------------------------------------------------------------- *)

  function ConvertTabsToSpaces(Str: String; Fonts: TFont;
    TabsStops: TStringList): String;

  var
    UseDefaultTab, IsVisited: Boolean;
    L, N, LI, Times, T, K: Integer;
    Space, Extra, DataWidth, SingleSpace, TabSpace, Diff, PrevTab: Double;
    Data: String;
  begin
    Data := '';
    UseDefaultTab := False;
    IsVisited := False;
    L := 0;
    T := 0;
    K := 0;
    PrevTab := 0.0;
    Diff := 0.0;
    Space := 0.0;

    N := TabsStops.Count;
    Result := '';
    for LI := 1 to Length(Str) do
    begin
      if Str[LI] = #9 then
      begin
        DataWidth := TextSize(Data, Fonts).cx;
        SingleSpace := TextSize(' ', Fonts).cx;
        // Conversion of Tab Value from Inches to Pixels
        TabSpace := (2.083 / 32) * Fonts.Size * CPixelsPerInch;
        // For none specified in the TStringlist
        if N = 0 then
        begin
          UseDefaultTab := True;
          Space := GetRemainingSpaces(DataWidth, TabSpace);
        end
        else if N = 1 then
        begin
          // For only 1 no. in TStringList
          if ((Double(DataWidth) / round(CPixelsPerInch)) >
            (StrToFloat(TabsStops.Strings[0]) / 25400)) then
          begin
            Extra := (Double(DataWidth) / round(CPixelsPerInch)) -
              (StrToFloat(TabsStops.Strings[0]) / 25400);
            while Extra > (StrToFloat(TabsStops.Strings[0]) / 25400) do
              Extra := Extra - (StrToFloat(TabsStops.Strings[0]) / 25400);
            Space := (StrToFloat(TabsStops.Strings[0]) / 25400) - Extra;
          end
          else
            Space := (StrToFloat(TabsStops.Strings[0]) / 25400) -
              (Double(DataWidth) / round(CPixelsPerInch));
        end
        else
        begin
          // For more than 1 entries in TSringList
          if L < N then
          begin
            T := L;
            Diff := (StrToFloat(TabsStops.Strings[L]) / 25400) - PrevTab;
          end;
          if ((L + 1) < N) then
          begin
            if ((Double(DataWidth) / round(CPixelsPerInch)) > Diff) then
            begin
              Extra := (Double(DataWidth) / round(CPixelsPerInch));
              while Extra > Diff do
              begin
                Extra := Extra - Diff;
                PrevTab := (StrToFloat(TabsStops.Strings[L]) / 25400);
                if (((L + 1) <= N) and (L = T)) then
                begin
                  L := L + 1;
                  T := L;
                  Diff := (StrToFloat(TabsStops.Strings[L]) / 25400) - PrevTab;
                  Space := Diff - Extra;
                end
                else
                begin
                  UseDefaultTab := True;
                  Space := GetRemainingSpaces(DataWidth, TabSpace);
                end;
              end;
              PrevTab := (StrToFloat(TabsStops.Strings[L]) / 25400);
              if (((L + 1) <= N) and (L = T)) then
              begin
                L := L + 1;
              end
              else
              begin
                UseDefaultTab := True;
                Space := GetRemainingSpaces(DataWidth, TabSpace);
              end;
            end
            else
            begin
              Space := Diff - (Double(DataWidth) / round(CPixelsPerInch));
              PrevTab := (StrToFloat(TabsStops.Strings[L]) / 25400);
              if (((L + 1) <= N) and (L = T)) then
              begin
                L := L + 1;
              end
              else
              begin
                UseDefaultTab := True;
                Space := GetRemainingSpaces(DataWidth, TabSpace);
              end;
            end;
          end
          else
          begin
            if ((L = N) or (L = (N - 1))) then
            begin
              K := K + 1;
              if IsVisited then
              begin
                UseDefaultTab := True;
                Space := GetRemainingSpaces(DataWidth, TabSpace);
              end
              else
              begin
                Space := Diff - (Double(DataWidth) / round(CPixelsPerInch));
                if K = 2 then
                  IsVisited := True
                else
                  L := L + 1;
              end;
            end
            else
            begin
              UseDefaultTab := True;
              Space := GetRemainingSpaces(DataWidth, TabSpace);
            end;
          end;
        end;

        Times := GetCountOfSpaces(Space, SingleSpace, UseDefaultTab);
        Result := Result + StringOfChar(' ', Times);
        Data := '';
      end
      else
      begin
        Result := Result + Str[LI];
        Data := Data + Str[LI];
      end;
    end;
  end;

  (* ---------------------------------------------------------------------------- *)

  procedure FreeAndNil(var Obj);

  var
    Temp: Tobject;
  begin
    Temp := Tobject(Obj);
    Pointer(Obj) := nil;
    Temp.Free;
  end;

  (* ---------------------------------------------------------------------------- *)

  function IfThen(AValue: Boolean; const ATrue: Integer;
    const AFalse: Integer = 0): Integer; overload;
  begin
    if AValue then
      Result := ATrue
    else
      Result := AFalse;
  end;

  (* ---------------------------------------------------------------------------- *)

  function IfThen(AValue: Boolean; const ATrue: DWORD; const AFalse: DWORD = 0)
    : DWORD; overload;
  begin
    if AValue then
      Result := ATrue
    else
      Result := AFalse;
  end;

  (* ---------------------------------------------------------------------------- *)

  function IfThen(AValue: Boolean; const ATrue: Double;
    const AFalse: Double = 0.0): Double; overload;
  begin
    if AValue then
      Result := ATrue
    else
      Result := AFalse;
  end;

  (* ---------------------------------------------------------------------------- *)

  function IfThen(AValue: Boolean; const ATrue: String;
    const AFalse: String = ''): String; overload;
  begin
    if AValue then
      Result := ATrue
    else
      Result := AFalse;
  end;

  (* ---------------------------------------------------------------------------- *)

  function DegreesToRadians(Degrees: Extended): Extended;
  begin
    Result := Degrees * (PI / 180);
  end;

  (* ---------------------------------------------------------------------------- *)

  function PixelsToPoints(X: Extended): Extended;
  begin
    Result := X / CPixelsPerInch * CInchesToPoints;
  end;

  (* ---------------------------------------------------------------------------- *)

  function PointsToPixels(X: Extended): Extended;
  begin
    Result := X * CPointsToPixels;
  end;

  (* ---------------------------------------------------------------------------- *)

  function RadiansToDegrees(Radians: Extended): Extended;
  begin
    Result := Radians * (180 / PI);
  end;

  (* ---------------------------------------------------------------------------- *)

  function ColorBGRToRGB(AColor: TColor): String;
  begin
    CheckSysColor(AColor);
    Result := IntToHex(GetRValue(AColor), 2) + IntToHex(GetGValue(AColor), 2) +
      IntToHex(GetBValue(AColor), 2);
  end;

  procedure CheckSysColor(var Color: TColor);

  const
    CgtSysColor = $FF000000;
  begin
    if (Color and CgtSysColor) = CgtSysColor then
    begin
      Color := Color and (not CgtSysColor);
      Color := GetSysColor(Color);
    end;
  end;

  (* ---------------------------------------------------------------------------- *)

  procedure SetControlsEnabled(AControl: TWinControl; AState: Boolean;
    AIgnoreList: TList = nil);

  const
    StateColor: array [Boolean] of TColor = (clInactiveBorder, clWindow);
    StatePenMode: array [Boolean] of TPenMode = (pmMask, pmCopy);

  var
    I: Integer;
  begin
    with AControl do
      for I := 0 to ControlCount - 1 do
      begin

        if (AIgnoreList <> nil) and (AIgnoreList.IndexOf(Controls[I]) <> -1)
        then
          Continue;
        if ((Controls[I] is TWinControl) and
          (TWinControl(Controls[I]).ControlCount > 0)) then
          SetControlsEnabled(TWinControl(Controls[I]), AState, AIgnoreList);
        if (Controls[I] is TCustomEdit) then
          THackWinControl(Controls[I]).Color := StateColor[AState]
        else if (Controls[I] is TCustomComboBox) then
          THackWinControl(Controls[I]).Color := StateColor[AState]
        else if (Controls[I] is TShape) then
          TShape(Controls[I]).Pen.Mode := StatePenMode[AState];
        Controls[I].Enabled := AState;
      end;
  end;

  (* ---------------------------------------------------------------------------- *)

  function IsHex(AString: String): Boolean;

  var
    LI: Integer;
    LString: String;
  begin
    Result := False;
    LString := UpperCase(AString);

    for LI := 1 to Length(AString) do
      if (LString[LI] < '0') or ((AString[LI] > '9') and (AString[LI] < 'A')) or
        ((AString[LI] < 'A') and (AString[LI] > 'F')) then
        exit;

    Result := True;
  end;

  (* ---------------------------------------------------------------------------- *)

  function HexToByteArray(AHex: String): TgtByteArray;

  var
    LS: String;
    LI, LJ, LLength: Integer;
  begin
    SetLength(LS, 2);
    SetLength(Result, 0);
    LLength := Length(AHex);
    LI := 0;
    LJ := 0;
    while (LI < LLength) do
    begin
      while not(IsHex(AHex[LI])) do
        Inc(LI);
      LS[1] := AHex[LI];
      Inc(LI);

      while not(IsHex(AHex[LI])) do
        Inc(LI);
      LS[2] := AHex[LI];
      Inc(LI);

      SetLength(Result, Length(Result) + 1);
      if (HexToByteValue(PChar(LS), Result[LJ]) <> 0) then
        exit;
      Inc(LJ);
    end;
  end;

  (* ---------------------------------------------------------------------------- *)

  function HexToByteValue(AHex: String; out AByte: Byte): Integer;

  const
    Convert: array ['0' .. 'f'] of SmallInt = (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, -1,
      -1, -1, -1, -1, -1, -1, 10, 11, 12, 13, 14, 15, -1, -1, -1, -1, -1, -1,
      -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
      -1, -1, 10, 11, 12, 13, 14, 15);

  var
    LI, LJ: Integer;
  begin
    Result := -1;
    AByte := 0;
    LJ := 0;

    if not IsHex(AHex) then
      exit;

    for LI := Length(AHex) downto 1 do
    begin
      AByte := AByte + Convert[AHex[LI]] * Trunc(Power(16, LJ));
      Inc(LJ);
    end;
    Result := 0;
  end;

  (* ---------------------------------------------------------------------------- *)

  function HexToByteString(AHex: String): String;

  var
    LI: Integer;
    LS: String;
    LByte: Byte;
  begin
    SetLength(LS, 2);
    LI := 0;
    while (LI < Length(AHex)) do
    begin
      while not(IsHex(AHex[LI])) do
        Inc(LI);

      LS[1] := AHex[LI];

      Inc(LI);
      while not(IsHex(AHex[LI])) do
        Inc(LI);

      LS[2] := AHex[LI];
      Inc(LI);
      if (HexToByteValue(PChar(LS), LByte) <> 0) then
        exit
      else
        Result := Result + Chr(LByte);
    end;
  end;

  (* ---------------------------------------------------------------------------- *)

  procedure EscapeStringToByteArray(AEscapeString: AnsiString;
    var AByte: array of Byte);

  var
    LI, LJ, LLength: Integer;
    LChar: AnsiString;
    LOctal: AnsiString;
    LByte: Byte;
    LIndex: Integer;
  begin
    if (Length(AByte) = 0) then
      exit;

    LIndex := 0;
    SetLength(LChar, 1);
    SetLength(LOctal, 3);
    LI := 1;
    LLength := Length(AEscapeString);
    repeat
      if (AEscapeString[LI] = '\') then
      begin
        case AEscapeString[LI + 1] of
          'n':
            begin
              LChar := LF;
              Inc(LI, 2);
            end;
          'r':
            begin
              LChar := CR;
              Inc(LI, 2);
            end;
          't':
            begin
              LChar := Tab;
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
{$IFDEF gtDelphi2009Up}
            if SysUtils.CharInSet(AEscapeString[LI + 1], ['0' .. '8']) then
{$ELSE}
            if AEscapeString[LI + 1] in ['0' .. '8'] then
{$ENDIF}
            begin
              Inc(LI);
              LJ := 1;
              LOctal := '';
{$IFDEF gtDelphi2009Up}
              while SysUtils.CharInSet(AEscapeString[LI], ['0' .. '8']) and
                (LJ <= 3) do
{$ELSE}
              while (AEscapeString[LI] in ['0' .. '8']) and (LJ <= 3) do
{$ENDIF}
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
                OctalToByteValue(String(LOctal), LByte);
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
      AByte[LIndex] := Ord(LChar[1]);
      Inc(LIndex);
    until (LI > LLength);
  end;

  (* ---------------------------------------------------------------------------- *)

  procedure EscapeStringToString(AEscapeString: String; var AString: String);

  var
    LI, LJ, LLength: Integer;
    LChar: String;
    LOctal: String;
    LByte: Byte;
  begin
    if AEscapeString = '' then
      exit;
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
              LChar := LF;
              Inc(LI, 2);
            end;
          'r':
            begin
              LChar := CR;
              Inc(LI, 2);
            end;
          't':
            begin
              LChar := Tab;
              Inc(LI, 2);
            end;
          'b':
            begin
              LChar := BS;
              Inc(LI, 2);
            end;
          'f':
            begin
              LChar := FF;
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
{$IFDEF gtDelphi2009Up}
            if SysUtils.CharInSet(AEscapeString[LI + 1], ['0' .. '8']) then
{$ELSE}
            if AEscapeString[LI + 1] in ['0' .. '8'] then
{$ENDIF}
            begin
              Inc(LI);
              LJ := 1;
              LOctal := '';
{$IFDEF gtDelphi2009Up}
              while SysUtils.CharInSet(AEscapeString[LI], ['0' .. '8']) and
{$ELSE}
              while (AEscapeString[LI] in ['0' .. '8']) and
{$ENDIF}
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
                LChar := Chr(LByte);
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

  (* ---------------------------------------------------------------------------- *)

  procedure OctalToByteValue(AOctal: String; out AByte: Byte);

  const
    Convert: array ['0' .. '8'] of SmallInt = (0, 1, 2, 3, 4, 5, 6, 7, 8);

  var
    LI, LJ: Integer;
  begin
    AByte := 0;
    LJ := 0;

    if not IsOctal(AOctal) then
      exit;

    for LI := Length(AOctal) downto 1 do
    begin
      AByte := AByte + Convert[AOctal[LI]] * Trunc(Power(8, LJ));
      Inc(LJ);
    end;
  end;

  (* ---------------------------------------------------------------------------- *)

  function IsOctal(AString: String): Boolean;

  var
    LI: Integer;
  begin
    Result := False;

    for LI := 1 to Length(AString) do
      if ((AString[LI] < '0') or (AString[LI] > '8')) then
        exit;

    Result := True;
  end;

  (* ---------------------------------------------------------------------------- *)

  function FloatToStrLocale(Value: Double): String;

  var
    LDesSep: Char;
  begin
    LDesSep := {$IFDEF gtDelphiXEUp} FormatSettings.
{$ENDIF} DecimalSeparator;
    if Assigned(LockDecimalSep) then
      LockDecimalSep.Acquire
    else
    begin
      LockDecimalSep := TCriticalSection.Create;
      LockDecimalSep.Acquire
    end;
    try
{$IFDEF gtDelphiXEUp} FormatSettings.{$ENDIF} DecimalSeparator := '.';
      Result := FloatToStr(Value);
{$IFDEF gtDelphiXEUp} FormatSettings.{$ENDIF} DecimalSeparator := LDesSep;
    finally
      LockDecimalSep.Release;
    end;
  end;
  { ------------------------------------------------------------------------------ }

  function CheckWin32Version(AMajor: Integer; AMinor: Integer = 0): Boolean;
  begin
    Result := (Win32MajorVersion > AMajor) or
      ((Win32MajorVersion = AMajor) and (Win32MinorVersion >= AMinor));
  end;
  { ------------------------------------------------------------------------------ }

  function FloatToStrFLocale(Value: Extended; Format: TFloatFormat;
    Precision, Digits: Integer): String;

  var
    LDesSep: Char;
  begin
    LDesSep := {$IFDEF gtDelphiXEUp} FormatSettings.
{$ENDIF} DecimalSeparator;
    if Assigned(LockDecimalSep) then
      LockDecimalSep.Acquire
    else
    begin
      LockDecimalSep := TCriticalSection.Create;
      LockDecimalSep.Acquire
    end;
    try
{$IFDEF gtDelphiXEUp} FormatSettings.{$ENDIF} DecimalSeparator := '.';
      Result := FloatToStrF(Value, Format, Precision, Digits);
{$IFDEF gtDelphiXEUp} FormatSettings.{$ENDIF} DecimalSeparator := LDesSep;
    finally
      LockDecimalSep.Release;
    end;
  end;
  { ------------------------------------------------------------------------------ }

  function StrToFloatLocale(AString: String): Double;

  var
    LDesSep: Char;
  begin
    LDesSep := {$IFDEF gtDelphiXEUp} FormatSettings.
{$ENDIF} DecimalSeparator;
    if Assigned(LockDecimalSep) then
      LockDecimalSep.Acquire
    else
    begin
      LockDecimalSep := TCriticalSection.Create;
      LockDecimalSep.Acquire
    end;
    try
{$IFDEF gtDelphiXEUp} FormatSettings.{$ENDIF} DecimalSeparator := '.';
      Result := StrToFloat(AString);
{$IFDEF gtDelphiXEUp} FormatSettings.{$ENDIF} DecimalSeparator := LDesSep;
    finally
      LockDecimalSep.Release;
    end;
  end;
  { ------------------------------------------------------------------------------ }

  { General Procedure }

  function gtRect(Left, Top, Right, Bottom: Double): TgtRect; overload;
  begin
    Result.Left := Left;
    Result.Top := Top;
    Result.Right := Right;
    Result.Bottom := Bottom;
  end;
  { ------------------------------------------------------------------------------ }

  function gtRect(ARect: TgtRect; AFactor: Double): TgtRect; overload;
  begin
    with ARect do
    begin
      Result.Left := Left * AFactor;
      Result.Top := Top * AFactor;
      Result.Right := Right * AFactor;
      Result.Bottom := Bottom * AFactor;
    end;
  end;
  { ------------------------------------------------------------------------------ }

  function gtRect(ARect: TgtRect; AXFactor, AYFactor: Double): TgtRect;
    overload;
  begin
    with ARect do
    begin
      Result.Left := Left * AXFactor;
      Result.Top := Top * AYFactor;
      Result.Right := Right * AXFactor;
      Result.Bottom := Bottom * AYFactor;
    end;
  end;

  (* ---------------------------------------------------------------------------- *)

  { ------------------------------------------------------------------------------ }
  { MD5 }
  { ------------------------------------------------------------------------------ }
  {
    var
    BufferPad: MD5Buffer = ($80, $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00);

    function F(AX, AY, AZ: DWORD): DWORD;
    begin
    Result := (AX and AY) or ((not AX) and AZ);
    end;

    function G(AX, AY, AZ: DWORD): DWORD;
    begin
    Result := (AX and AZ) or (AY and (not AZ));
    end;

    function H(AX, AY, AZ: DWORD): DWORD;
    begin
    Result := AX xor AY xor AZ;
    end;

    function I(AX, AY, AZ: DWORD): DWORD;
    begin
    Result := AY xor (AX or (not AZ));
    end;

    procedure Rot(var AX: DWORD; AN: Byte);
    begin
    AX := (AX shl AN) or (AX shr (32 - AN));
    end;

    procedure FF(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: Byte;
    ADWORD: DWORD);
    begin
    Inc(AA, F(AB, AC, AD) + AX + ADWORD);
    Rot(AA, AByte);
    Inc(AA, AB);
    end;

    procedure GG(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: Byte;
    ADWORD: DWORD);
    begin
    Inc(AA, G(AB, AC, AD) + AX + ADWORD);
    Rot(AA, AByte);
    Inc(AA, AB);
    end;

    procedure HH(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: Byte;
    ADWORD: DWORD);
    begin
    Inc(AA, H(AB, AC, AD) + AX + ADWORD);
    Rot(AA, AByte);
    Inc(AA, AB);
    end;

    procedure II(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: Byte;
    ADWORD: DWORD);
    begin
    Inc(AA, I(AB, AC, AD) + AX + ADWORD);
    Rot(AA, AByte);
    Inc(AA, AB);
    end;
  }
  { ------------------------------------------------------------------------------ }

  // Encode Count bytes at Source into (Count / 4) DWORDs at Target
  { procedure Encode(ASource, ATarget: Pointer; ACount: Longword);
    var
    S: PByte;
    T: PDWORD;
    I: Longword;
    begin
    S := ASource;
    T := ATarget;
    for I := 1 to ACount div 4 do
    begin
    T^ := S^;
    Inc(S);
    T^ := T^ or (S^ shl 8);
    Inc(S);
    T^ := T^ or (S^ shl 16);
    Inc(S);
    T^ := T^ or (S^ shl 24);
    Inc(S);
    Inc(T);
    end;
    end;

    { ------------------------------------------------------------------------------ }

  // Decode Count DWORDs at Source into (Count * 4) Bytes at Target
  { procedure Decode(ASource, ATarget: Pointer; ACount: Longword);
    var
    S: PDWORD;
    T: PByte;
    I: Longword;
    begin
    S := ASource;
    T := ATarget;
    for I := 1 to ACount do
    begin
    T^ := S^ and $FF;
    Inc(T);
    T^ := (S^ shr 8) and $FF;
    Inc(T);
    T^ := (S^ shr 16) and $FF;
    Inc(T);
    T^ := (S^ shr 24) and $FF;
    Inc(T);
    Inc(S);
    end;
    end;

    { ------------------------------------------------------------------------------ }

  { // Transform State according to first 64 bytes at Buffer
    procedure Transform(ABuffer: Pointer; var AState: MD5State);
    var
    A, B, C, D: DWORD;
    Block: MD5Block;
    begin
    Encode(ABuffer, @Block, 64);
    A := AState[0];
    B := AState[1];
    C := AState[2];
    D := AState[3];
    FF(A, B, C, D, Block[0], 7, $D76AA478);
    FF(D, A, B, C, Block[1], 12, $E8C7B756);
    FF(C, D, A, B, Block[2], 17, $242070DB);
    FF(B, C, D, A, Block[3], 22, $C1BDCEEE);
    FF(A, B, C, D, Block[4], 7, $F57C0FAF);
    FF(D, A, B, C, Block[5], 12, $4787C62A);
    FF(C, D, A, B, Block[6], 17, $A8304613);
    FF(B, C, D, A, Block[7], 22, $FD469501);
    FF(A, B, C, D, Block[8], 7, $698098D8);
    FF(D, A, B, C, Block[9], 12, $8B44F7AF);
    FF(C, D, A, B, Block[10], 17, $FFFF5BB1);
    FF(B, C, D, A, Block[11], 22, $895CD7BE);
    FF(A, B, C, D, Block[12], 7, $6B901122);
    FF(D, A, B, C, Block[13], 12, $FD987193);
    FF(C, D, A, B, Block[14], 17, $A679438E);
    FF(B, C, D, A, Block[15], 22, $49B40821);
    GG(A, B, C, D, Block[1], 5, $F61E2562);
    GG(D, A, B, C, Block[6], 9, $C040B340);
    GG(C, D, A, B, Block[11], 14, $265E5A51);
    GG(B, C, D, A, Block[0], 20, $E9B6C7AA);
    GG(A, B, C, D, Block[5], 5, $D62F105D);
    GG(D, A, B, C, Block[10], 9, $2441453);
    GG(C, D, A, B, Block[15], 14, $D8A1E681);
    GG(B, C, D, A, Block[4], 20, $E7D3FBC8);
    GG(A, B, C, D, Block[9], 5, $21E1CDE6);
    GG(D, A, B, C, Block[14], 9, $C33707D6);
    GG(C, D, A, B, Block[3], 14, $F4D50D87);
    GG(B, C, D, A, Block[8], 20, $455A14ED);
    GG(A, B, C, D, Block[13], 5, $A9E3E905);
    GG(D, A, B, C, Block[2], 9, $FCEFA3F8);
    GG(C, D, A, B, Block[7], 14, $676F02D9);
    GG(B, C, D, A, Block[12], 20, $8D2A4C8A);
    HH(A, B, C, D, Block[5], 4, $FFFA3942);
    HH(D, A, B, C, Block[8], 11, $8771F681);
    HH(C, D, A, B, Block[11], 16, $6D9D6122);
    HH(B, C, D, A, Block[14], 23, $FDE5380C);
    HH(A, B, C, D, Block[1], 4, $A4BEEA44);
    HH(D, A, B, C, Block[4], 11, $4BDECFA9);
    HH(C, D, A, B, Block[7], 16, $F6BB4B60);
    HH(B, C, D, A, Block[10], 23, $BEBFBC70);
    HH(A, B, C, D, Block[13], 4, $289B7EC6);
    HH(D, A, B, C, Block[0], 11, $EAA127FA);
    HH(C, D, A, B, Block[3], 16, $D4EF3085);
    HH(B, C, D, A, Block[6], 23, $4881D05);
    HH(A, B, C, D, Block[9], 4, $D9D4D039);
    HH(D, A, B, C, Block[12], 11, $E6DB99E5);
    HH(C, D, A, B, Block[15], 16, $1FA27CF8);
    HH(B, C, D, A, Block[2], 23, $C4AC5665);
    II(A, B, C, D, Block[0], 6, $F4292244);
    II(D, A, B, C, Block[7], 10, $432AFF97);
    II(C, D, A, B, Block[14], 15, $AB9423A7);
    II(B, C, D, A, Block[5], 21, $FC93A039);
    II(A, B, C, D, Block[12], 6, $655B59C3);
    II(D, A, B, C, Block[3], 10, $8F0CCC92);
    II(C, D, A, B, Block[10], 15, $FFEFF47D);
    II(B, C, D, A, Block[1], 21, $85845DD1);
    II(A, B, C, D, Block[8], 6, $6FA87E4F);
    II(D, A, B, C, Block[15], 10, $FE2CE6E0);
    II(C, D, A, B, Block[6], 15, $A3014314);
    II(B, C, D, A, Block[13], 21, $4E0811A1);
    II(A, B, C, D, Block[4], 6, $F7537E82);
    II(D, A, B, C, Block[11], 10, $BD3AF235);
    II(C, D, A, B, Block[2], 15, $2AD7D2BB);
    II(B, C, D, A, Block[9], 21, $EB86D391);
    Inc(AState[0], A);
    Inc(AState[1], B);
    Inc(AState[2], C);
    Inc(AState[3], D);
    end;
    { ------------------------------------------------------------------------------ }

  { // Initialize given Context
    procedure MD5Init(var AContext: MD5Context);
    begin
    with AContext do
    begin
    State[0] := $67452301;
    State[1] := $EFCDAB89;
    State[2] := $98BADCFE;
    State[3] := $10325476;
    Count[0] := 0;
    Count[1] := 0;
    ZeroMemory(@Buffer, SizeOf(MD5Buffer));
    end;
    end;

    { ------------------------------------------------------------------------------ }

  // Update given Context to include Length bytes of Input
  { procedure MD5Update(var AContext: MD5Context; AInput: array of Byte;
    ALength: Longword);
    var
    Index: Longword;
    PartLen: Longword;
    I: Longword;
    begin
    with AContext do
    begin
    Index := (Count[0] shr 3) and $3F;
    Inc(Count[0], ALength shl 3);
    if Count[0] < (ALength shl 3) then
    Inc(Count[1]);
    Inc(Count[1], ALength shr 29);
    end;
    PartLen := 64 - Index;
    if ALength >= PartLen then
    begin
    CopyMemory(@AContext.Buffer[Index], @AInput, PartLen);
    Transform(@AContext.Buffer, AContext.State);
    I := PartLen;
    while I + 63 < ALength do
    begin
    Transform(@AInput[I], AContext.State);
    Inc(I, 64);
    end;
    Index := 0;
    end
    else
    I := 0;
    CopyMemory(@AContext.Buffer[Index], @AInput[I], ALength - I);
    end;

    { ------------------------------------------------------------------------------ }

  // Finalize given Context, create Digest and zeroize Context
  { procedure MD5Final(var AContext: MD5Context; var ADigest: MD5Digest);
    var
    Bits: MD5CBits;
    Index: Longword;
    PadLen: Longword;
    begin
    Decode(@AContext.Count, @Bits, 2);
    Index := (AContext.Count[0] shr 3) and $3F;
    if Index < 56 then
    PadLen := 56 - Index
    else
    PadLen := 120 - Index;
    MD5Update(AContext, BufferPad, PadLen);
    MD5Update(AContext, Bits, 8);
    Decode(@AContext.State, @ADigest, 4);
    ZeroMemory(@AContext, SizeOf(MD5Context));
    end;

    {-------------------------------------------------------------------------------

    function GetHash(AInput: TgtByteArray; ALength: LongWord;
    var MD5Data: MD5Context): MD5Digest; overload;
    var
    LMD5Digest : MD5Digest;
    begin
    MD5Update(MD5Data, AInput, ALength);
    MD5Final(MD5Data, LMD5Digest);
    Result := LMD5Digest;
    end;

    ------------------------------------------------------------------------------- }

  { function GetHash(AInput: TStream): MD5Digest; overload;
    var
    LByteArray: array of Byte;
    LSize: Integer;
    LMD5Digest: MD5Digest;
    LI: Integer;
    begin
    MD5Init(MD5Data);
    LSize := Integer(AInput.Size);
    SetLength(LByteArray, LSize);
    AInput.Position := 0;
    AInput.Read(LByteArray[0], LSize);
    MD5Update(MD5Data, LByteArray, LSize);
    MD5Final(MD5Data, LMD5Digest);
    Result := LMD5Digest;
    end;

    {------------------------------------------------------------------------------- }

  { function CompareHash(const AHash1, AHash2: MD5Digest): Boolean;
    var
    LI: Integer;
    begin
    for LI := Low(AHash1) to High(AHash1) do
    begin
    Result := (AHash1[LI] = AHash2[LI]);
    if (not Result) then
    Break;
    end;
    end; }

  { TgtMD5Hash }

  constructor TgtMD5.Create;

  var
    LI: Integer;
  begin
    for LI := 0 to 63 do
      FBufferPad[LI] := $00;
    FBufferPad[0] := $80;
    Initilize;
  end;

  procedure TgtMD5.Encode(ASource, ATarget: Pointer; ACount: Longword);

  var
    S: PByte;
    T: PDWORD;
    I: Longword;
  begin
    S := ASource;
    T := ATarget;
    for I := 1 to ACount div 4 do
    begin
      T^ := S^;
      Inc(S);
      T^ := T^ or (S^ shl 8);
      Inc(S);
      T^ := T^ or (S^ shl 16);
      Inc(S);
      T^ := T^ or (S^ shl 24);
      Inc(S);
      Inc(T);
    end;
  end;

  { ------------------------------------------------------------------------------ }

  // Decode Count DWORDs at Source into (Count * 4) Bytes at Target
  procedure TgtMD5.Decode(ASource, ATarget: Pointer; ACount: Longword);

  var
    S: PDWORD;
    T: PByte;
    I: Longword;
  begin
    S := ASource;
    T := ATarget;
    for I := 1 to ACount do
    begin
      T^ := S^ and $FF;
      Inc(T);
      T^ := (S^ shr 8) and $FF;
      Inc(T);
      T^ := (S^ shr 16) and $FF;
      Inc(T);
      T^ := (S^ shr 24) and $FF;
      Inc(T);
      Inc(S);
    end;
  end;

  procedure TgtMD5.Finalize(var ADigest: MD5Digest);

  var
    Bits: MD5CBits;
    Index: Longword;
    PadLen: Longword;
  begin
    Decode(@FContext.Count, @Bits, 2);
    Index := (FContext.Count[0] shr 3) and $3F;
    if Index < 56 then
      PadLen := 56 - Index
    else
      PadLen := 120 - Index;
    Update(@FBufferPad[0], PadLen, True);
    Update(@Bits[0], 8, True);
    Decode(@FContext.State, @ADigest, 4);
    ZeroMemory(@FContext, SizeOf(MD5Context));
  end;

  procedure TgtMD5.GetHash(AInput: TgtByteArray1; ALength: Longword;
    var ADigest: MD5Digest);
  begin
    Update(AInput, ALength, True);
    Finalize(ADigest);
  end;

  function TgtMD5.F(AX, AY, AZ: DWORD): DWORD;
  begin
    Result := (AX and AY) or ((not AX) and AZ);
  end;

  function TgtMD5.G(AX, AY, AZ: DWORD): DWORD;
  begin
    Result := (AX and AZ) or (AY and (not AZ));
  end;

  function TgtMD5.H(AX, AY, AZ: DWORD): DWORD;
  begin
    Result := AX xor AY xor AZ;
  end;

  function TgtMD5.I(AX, AY, AZ: DWORD): DWORD;
  begin
    Result := AY xor (AX or (not AZ));
  end;

  procedure TgtMD5.Rot(var AX: DWORD; AN: Byte);
  begin
    AX := (AX shl AN) or (AX shr (32 - AN));
  end;

  procedure TgtMD5.FF(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: Byte;
    ADWORD: DWORD);
  begin
{$Q-,R-}
    Inc(AA, F(AB, AC, AD) + AX + ADWORD);
    Rot(AA, AByte);
    Inc(AA, AB);
  end;

  procedure TgtMD5.GG(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: Byte;
    ADWORD: DWORD);
  begin
    Inc(DWORD(AA), DWORD(G(AB, AC, AD)) + DWORD(AX) + ADWORD);
    Rot(AA, AByte);
    Inc(AA, AB);
  end;

  procedure TgtMD5.HH(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: Byte;
    ADWORD: DWORD);
  begin
    Inc(AA, H(AB, AC, AD) + AX + ADWORD);
    Rot(AA, AByte);
    Inc(AA, AB);
  end;

  procedure TgtMD5.II(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: Byte;
    ADWORD: DWORD);
  begin
    Inc(AA, I(AB, AC, AD) + AX + ADWORD);
    Rot(AA, AByte);
    Inc(AA, AB);
  end;

  procedure TgtMD5.Initilize;
  begin
    with FContext do
    begin
      State[0] := $67452301;
      State[1] := $EFCDAB89;
      State[2] := $98BADCFE;
      State[3] := $10325476;
      Count[0] := 0;
      Count[1] := 0;
      ZeroMemory(@Buffer, SizeOf(MD5Buffer));
    end;
  end;

  procedure TgtMD5.Transform(ABuffer: Pointer; var AState: MD5State);

  var
    A, B, C, D: DWORD;
    Block: MD5Block;
  begin
    Encode(ABuffer, @Block, 64);
    A := AState[0];
    B := AState[1];
    C := AState[2];
    D := AState[3];
    FF(A, B, C, D, Block[0], 7, $D76AA478);
    FF(D, A, B, C, Block[1], 12, $E8C7B756);
    FF(C, D, A, B, Block[2], 17, $242070DB);
    FF(B, C, D, A, Block[3], 22, $C1BDCEEE);
    FF(A, B, C, D, Block[4], 7, $F57C0FAF);
    FF(D, A, B, C, Block[5], 12, $4787C62A);
    FF(C, D, A, B, Block[6], 17, $A8304613);
    FF(B, C, D, A, Block[7], 22, $FD469501);
    FF(A, B, C, D, Block[8], 7, $698098D8);
    FF(D, A, B, C, Block[9], 12, $8B44F7AF);
    FF(C, D, A, B, Block[10], 17, $FFFF5BB1);
    FF(B, C, D, A, Block[11], 22, $895CD7BE);
    FF(A, B, C, D, Block[12], 7, $6B901122);
    FF(D, A, B, C, Block[13], 12, $FD987193);
    FF(C, D, A, B, Block[14], 17, $A679438E);
    FF(B, C, D, A, Block[15], 22, $49B40821);
    GG(A, B, C, D, Block[1], 5, $F61E2562);
    GG(D, A, B, C, Block[6], 9, $C040B340);
    GG(C, D, A, B, Block[11], 14, $265E5A51);
    GG(B, C, D, A, Block[0], 20, $E9B6C7AA);
    GG(A, B, C, D, Block[5], 5, $D62F105D);
    GG(D, A, B, C, Block[10], 9, $2441453);
    GG(C, D, A, B, Block[15], 14, $D8A1E681);
    GG(B, C, D, A, Block[4], 20, $E7D3FBC8);
    GG(A, B, C, D, Block[9], 5, $21E1CDE6);
    GG(D, A, B, C, Block[14], 9, $C33707D6);
    GG(C, D, A, B, Block[3], 14, $F4D50D87);
    GG(B, C, D, A, Block[8], 20, $455A14ED);
    GG(A, B, C, D, Block[13], 5, $A9E3E905);
    GG(D, A, B, C, Block[2], 9, $FCEFA3F8);
    GG(C, D, A, B, Block[7], 14, $676F02D9);
    GG(B, C, D, A, Block[12], 20, $8D2A4C8A);
    HH(A, B, C, D, Block[5], 4, $FFFA3942);
    HH(D, A, B, C, Block[8], 11, $8771F681);
    HH(C, D, A, B, Block[11], 16, $6D9D6122);
    HH(B, C, D, A, Block[14], 23, $FDE5380C);
    HH(A, B, C, D, Block[1], 4, $A4BEEA44);
    HH(D, A, B, C, Block[4], 11, $4BDECFA9);
    HH(C, D, A, B, Block[7], 16, $F6BB4B60);
    HH(B, C, D, A, Block[10], 23, $BEBFBC70);
    HH(A, B, C, D, Block[13], 4, $289B7EC6);
    HH(D, A, B, C, Block[0], 11, $EAA127FA);
    HH(C, D, A, B, Block[3], 16, $D4EF3085);
    HH(B, C, D, A, Block[6], 23, $4881D05);
    HH(A, B, C, D, Block[9], 4, $D9D4D039);
    HH(D, A, B, C, Block[12], 11, $E6DB99E5);
    HH(C, D, A, B, Block[15], 16, $1FA27CF8);
    HH(B, C, D, A, Block[2], 23, $C4AC5665);
    II(A, B, C, D, Block[0], 6, $F4292244);
    II(D, A, B, C, Block[7], 10, $432AFF97);
    II(C, D, A, B, Block[14], 15, $AB9423A7);
    II(B, C, D, A, Block[5], 21, $FC93A039);
    II(A, B, C, D, Block[12], 6, $655B59C3);
    II(D, A, B, C, Block[3], 10, $8F0CCC92);
    II(C, D, A, B, Block[10], 15, $FFEFF47D);
    II(B, C, D, A, Block[1], 21, $85845DD1);
    II(A, B, C, D, Block[8], 6, $6FA87E4F);
    II(D, A, B, C, Block[15], 10, $FE2CE6E0);
    II(C, D, A, B, Block[6], 15, $A3014314);
    II(B, C, D, A, Block[13], 21, $4E0811A1);
    II(A, B, C, D, Block[4], 6, $F7537E82);
    II(D, A, B, C, Block[11], 10, $BD3AF235);
    II(C, D, A, B, Block[2], 15, $2AD7D2BB);
    II(B, C, D, A, Block[9], 21, $EB86D391);
    Inc(AState[0], A);
    Inc(AState[1], B);
    Inc(AState[2], C);
    Inc(AState[3], D);
  end;
  procedure TgtMD5.Update(AInput: array of Byte; ALength: Longword);

  var
    Index: Longword;
    PartLen: Longword;
    I: Longword;
  begin
    with FContext do
    begin
      Index := (Count[0] shr 3) and $3F;
      Inc(Count[0], ALength shl 3);
      if Count[0] < (ALength shl 3) then
        Inc(Count[1]);
      Inc(Count[1], ALength shr 29);
    end;
    PartLen := 64 - Index;
    if ALength >= PartLen then
    begin
      CopyMemory(@FContext.Buffer[Index], @AInput, PartLen);
      Transform(@FContext.Buffer, FContext.State);
      I := PartLen;
      while I + 63 < ALength do
      begin
        Transform(@AInput[I], FContext.State);
        Inc(I, 64);
      end;
      Index := 0;
    end
    else
      I := 0;
    CopyMemory(@FContext.Buffer[Index], @AInput[I], ALength - I);
    { with FContext do
      begin
      Index := (Count[0] shr 3) and $3f;
      Inc(Count[0], ALength shl 3);
      if Count[0] < (ALength shl 3) then
      Inc(Count[1]);
      Inc(Count[1], ALength shr 29);
      end;
      PartLen := 64 - Index;
      if ALength >= PartLen then
      begin
      CopyMemory(@FContext.Buffer[Index], AInput, PartLen);
      Transform(@FContext.Buffer, FContext.State);
      I := PartLen;
      while I + 63 < ALength do
      begin
      LP := AInput;
      Inc(LP, I);
      Transform(LP, FContext.State);
      Inc(I, 64);
      end;
      Index := 0;
      end
      else
      I := 0;
      LP := AInput;
      Inc(LP, I);
      CopyMemory(@FContext.Buffer[Index], LP, ALength - I); }
  end;

  procedure TgtMD5.Update(AInput: Pointer; ALength: Longword; Flag: Boolean);

  var
    Index: Longword;
    PartLen: Longword;
    I: Longword;
    LP: ^Byte;
  begin
    with FContext do
    begin
      Index := (Count[0] shr 3) and $3F;
      Inc(Count[0], ALength shl 3);
      if Count[0] < (ALength shl 3) then
        Inc(Count[1]);
      Inc(Count[1], ALength shr 29);
    end;
    PartLen := 64 - Index;
    if ALength >= PartLen then
    begin
      CopyMemory(@FContext.Buffer[Index], AInput, PartLen);
      Transform(@FContext.Buffer, FContext.State);
      I := PartLen;
      while I + 63 < ALength do
      begin
        LP := AInput;
        Inc(LP, I);
        Transform(LP, FContext.State);
        Inc(I, 64);
      end;
      Index := 0;
    end
    else
      I := 0;
    LP := AInput;
    Inc(LP, I);
    if Flag then
      CopyMemory(@FContext.Buffer[Index], LP, ALength - I);
  end;

  destructor TgtMD5.Destroy;
  begin
    inherited;
  end;

  procedure TgtMD5.GetHash(AInput: TStream; var ADigest: MD5Digest);

  var
    LByteArray: array of Byte;
    LSize: Integer;
  begin
    LSize := Integer(AInput.Size);
    SetLength(LByteArray, LSize);
    AInput.Position := 0;
    AInput.Read(LByteArray[0], LSize);
    GetHash(@LByteArray[0], LSize, ADigest);
  end;

  function TgtMD5.CompareHash(const AHash1, AHash2: MD5Digest): Boolean;

  var
    LI: Integer;
  begin
    for LI := Low(AHash1) to High(AHash1) do
    begin
      Result := (AHash1[LI] = AHash2[LI]);
      if (not Result) then
        Break;
    end;
  end;

initialization

LockDecimalSep := TCriticalSection.Create;

finalization

LockDecimalSep.Free;

end.
