{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit FontMan;

interface
{$I dc.inc}

uses
  {$IFNDEF CLX}
  Windows
  {$ELSE}
  Qt
  {$ENDIF}
  ;

type
  {$IFNDEF CLX}
  _HFONT = HFONT;
  {$ELSE}
  _HFONT = QFontH;
  {$ENDIF}
  PFontInfo = ^TFontInfo;
  TFontInfo = record
    OverHang: integer;
    Ascent  : integer;
    Descent : integer;
    AveCharWidth : integer;
    FontHeight : Integer;
  end;
  TIntegerArray = array[0..1] of integer;
  PIntegerArray = ^TIntegerArray;


function GetWidth(const AFontHandle: _HFONT; AStr: PChar; ALen: integer): integer;
function GetWidthAndInfo(const AFontHandle: _HFONT;  AStr: PChar; ALen: integer;
  APFontInfo: PFontInfo; POutBuff : PIntegerArray): integer;
function GetWidths(const AFontHandle: _HFONT;  AStr: PChar; MaxChars:Integer;POutBuff : PIntegerArray): integer;
function GetCharsInWidth(const AFontHandle: _HFONT; AStr: PChar; ALen: integer;
  AInWidth: integer; AReverseCalc, AExact :boolean; var ARealWidth: integer): integer;
function GetFontInfo(const AFontHandle: _HFONT): PFontInfo;

implementation

uses SysUtils, Classes, Graphics;
{$IFNDEF CLX}
function GetTextExtentExPoint(DC: HDC; p2: PAnsiChar; p3, p4: Integer; p5, p6: PInteger;
  var p7: TSize): BOOL; stdcall; external gdi32 name 'GetTextExtentExPointA';
{$ENDIF}
const
  cCharCount = 256;
  cMaxCachedFont = 32;
  {$IFDEF DCMBCS}
  MBCSTestStr : string = '';
  {$ENDIF}
type
  TIntArray = array [#0..#255] of integer;
  PIntArray = ^TIntArray;


type
  PFontItem = ^TFontItem;
  TFontItem = record
    FontHandle: HFONT;
    FontInfo  : TFontInfo;
    BuffWidths: TIntArray;
  end;

  TArrayOfPFontItem = array [0..cMaxCachedFont -1] of PFontItem;
  TCachedFontArray = array [0..cMaxCachedFont -1] of TFontItem;
  PCachedFontArray = ^TCachedFontArray;

type
  TFontManager = class
  private
    FCachedFont : TCachedFontArray;
    FArrOfPFontItem: TArrayOfPFontItem;
    {$IFNDEF CLX}
    FTmpDC: HDC;
    {$ENDIF}
    FSAllChars: array[0..256] of char;
    function FillBuffAndInfo(const AFontHandle: _HFONT; const APBuffRes: PIntArray; const APFontInfo: PFontInfo): boolean;
    function GetWidthFromBuff(AStr: PChar; ALen, DefWidth : integer; const  APBuffWidths: PIntArray; POutBuff : PIntegerArray): integer;
    function GetWidthsFromBuff(AStr: PChar; MaxChars:Integer;DefWidth : integer; const APBuffWidths: PIntArray; POutBuff : PIntegerArray): integer;
    function GetCharCountFromBuff(AStr: PChar; ALen, DefWidth : integer; const APBuffWidths: PIntArray; AInWidth: integer; AReverseCalc, AExact:boolean; var ARealWidth: integer): integer;
    function AddNewFont(AFontHandle: _HFONT): PFontItem;
    function MoveToTop(AIndex: integer): PFontItem;
    function FindFontItem(AFontHandle: _HFONT): PFontItem;
  public
    constructor Create;
    destructor Destroy; override;
    function GetWidthAndInfo(const AFontHandle: _HFONT;  AStr: PChar; ALen: integer; APFontInfo: PFontInfo; POutBuff : PIntegerArray): integer;
    function GetWidths(const AFontHandle: _HFONT;  AStr: PChar; MaxChars:Integer;POutBuff : PIntegerArray): integer;
    function GetCharsInWidth(const AFontHandle: _HFONT; AStr: PChar; ALen: integer; AInWidth: integer; AReverseCalc, AExact :boolean; var ARealWidth: integer): integer;
    function GetFontInfo(const AFontHandle: _HFONT): PFontInfo;
  end;

var
  FontManager: TFontManager;

function GetWidth(const AFontHandle: _HFONT; AStr: PChar; ALen: integer): integer;
begin
  if ALen = 0 then
    Result := 0
  else
    Result := GetWidthAndInfo(AFontHandle, AStr, ALen, nil, nil);
end;

function GetWidthAndInfo(const AFontHandle: _HFONT;  AStr: PChar; ALen: integer; APFontInfo: PFontInfo; POutBuff : PIntegerArray): integer;
begin
  Result := FontManager.GetWidthAndInfo (AFontHandle, AStr, ALen, APFontInfo, POutBuff);
end;

function GetWidths(const AFontHandle: _HFONT;  AStr: PChar;MaxChars:Integer;POutBuff : PIntegerArray): integer;
Begin
  Result := FontManager.GetWidths(AFontHandle, AStr, MaxChars, POutBuff);
End;

function GetCharsInWidth(const AFontHandle: _HFONT; AStr: PChar; ALen: integer; AInWidth: integer; AReverseCalc, AExact :boolean; var ARealWidth: integer): integer;
begin
  if ALen = 0 then
  begin
    Result := 0;
    ARealWidth := 0;
  end
  else
    Result := FontManager.GetCharsInWidth(AFontHandle, AStr, ALen, AInWidth, AReverseCalc, AExact, ARealWidth);
end;

function  GetFontInfo(const AFontHandle: _HFONT): PFontInfo;
begin
  Result := FontManager.GetFontInfo(AFontHandle);
end;

{$IFNDEF CLX}
procedure Win32Error;
begin
  raise Exception.Create(SysErrorMessage(GetLastError));
end;

function UnderWindowsNT : boolean;
begin
  Result := Win32Platform = VER_PLATFORM_WIN32_NT;
end;
{$ENDIF}

{ TFontManager }

constructor TFontManager.Create;
var
  i : integer;
begin
  inherited;
  FillChar(FCachedFont, sizeOf(TCachedFontArray), 0);
  for i := 0 to cMaxCachedFont -1 do
    FArrOfPFontItem[i] := @FCachedFont[i];
  for i := 0 to cCharCount - 1 do
    FSAllChars[i] := Char(i);
  FSAllChars[cCharCount]:=#0;
  {$IFNDEF CLX}
  FTmpDC := GetDC(0);
  {$ENDIF}
end;

destructor TFontManager.Destroy;
begin
  {$IFNDEF CLX}
  ReleaseDC(0, FTmpDC);
  {$ENDIF}
  inherited;
end;

function TFontManager.FillBuffAndInfo(const AFontHandle: _HFONT; const APBuffRes: PIntArray; const APFontInfo: PFontInfo): boolean;
{$IFNDEF CLX}
var
  _TM: TTextMetric;
  FPrevHandle : THandle;
  _Sz: TSize;
  i: char;
  {$IFDEF DCMBCS}
  size : TSize;
  {$ENDIF}
begin
  FPrevHandle := SelectObject(FTmpDC, AFontHandle);
  try
    if UnderWindowsNT then
      Result := GetCharWidth32(FTmpDC, 0, cCharCount - 1, APBuffRes^)
    else
    begin
      Result := GetTextExtentExPoint(FTmpDC, @FSAllChars, cCharCount, 0, nil, Pointer(APBuffRes), _Sz);
      if not Result then
        Win32Error;
      for i := Char(cCharCount - 1) downto #1 do
        Dec(APBuffRes^[i], APBuffRes^[Pred(i)]);
    end;
    if APFontInfo <> nil then
    begin
      Result := Result and GetTextMetrics(FTmpDC, _TM);
      if not Result then
        Win32Error;
      with APFontInfo^, _TM do
      begin
        OverHang := tmOverhang;
        Ascent := tmAscent;
        Descent := tmDescent;
        FontHeight := tmHeight;
        {$IFDEF DCMBCS}
        if MBCSTestStr <> '' then
          GetTextExtentPoint32(FTmpDC, Pchar(MBCSTestStr), length(MBCSTestStr), Size);
        AveCharWidth := Size.cX;
        {$ELSE}
        AveCharWidth := tmAveCharWidth * 2;
        {$ENDIF}
      end;
    end;
  finally
    SelectObject(FTmpDC, FPrevHandle);
  end;
end;
{$ELSE}
var
  Handle : QFontMetricsH;
  i      : integer;
begin
  Handle := QFontMetrics_create(AFontHandle);
  with APFontInfo^ do
  begin
    OverHang := 0;
    Ascent := QFontMetrics_ascent(Handle);
    Descent := QFontMetrics_descent(Handle);
    AveCharWidth := QFontMetrics_width(Handle, 'x') * 2;
  end;
  for i := 0 to cCharCount - 1 do
    APBuffRes[char(i)] := Byte(QFontMetrics_width(Handle, FSAllChars[i]));
  QFontMetrics_destroy(Handle);
  result := true;
end;
{$ENDIF}

function TFontManager.GetWidthFromBuff(AStr: PChar; ALen, DefWidth : integer; const APBuffWidths: PIntArray; POutBuff : PIntegerArray): integer;
var
  i    : integer;
  pb   : PIntArray;
  Res  : integer;
  Last : integer;
begin
  pb := APBuffWidths;
  Res := 0;
  i := 0;
  {$IFDEF DCMBCS}
  Last := 0;
  {$ENDIF}
  while i < ALen do
  begin
    {$IFDEF DCMBCS}
    if SysLocale.FarEast and (AStr^ in LeadBytes) then
    begin
      inc(Res, DefWidth);
      if POutBuff <> nil then
      begin
        POutBuff^[i]:= DefWidth div 2 + DefWidth mod 2;
        if i + 1 < ALen then
          POutBuff^[i + 1]:= DefWidth div 2
      end;
      inc(AStr, 2);
      inc(i, 2);
      continue;
    end
    else
      Last := pb^[AStr^];
    {$ELSE}
    Last := pb^[AStr^];
    {$ENDIF}
    inc(Res, Last);
    if POutBuff <> nil then
      POutBuff^[i] := Last;
    inc(AStr);
    inc(i);
  end;
  Result := Res;
end;

function TFontManager.GetWidthsFromBuff(AStr: PChar; MaxChars:Integer;DefWidth : integer; const APBuffWidths: PIntArray; POutBuff : PIntegerArray): integer;
var
  i    : integer;
  pb   : PIntArray;
  Res  : integer;
  Last : integer;
begin
  pb := APBuffWidths;
  Res := 0;
  i := 0;
  {$IFDEF DCMBCS}
  Last := 0;
  {$ENDIF}
  while i<MaxChars do
  begin
    {$IFDEF DCMBCS}
    if SysLocale.FarEast and (AStr^ in LeadBytes) then
    begin
      inc(Res, DefWidth);
      if POutBuff <> nil then
      begin
        POutBuff^[i]:= DefWidth div 2 + DefWidth mod 2;
        if AStr[i + 1]<>#0 then
          POutBuff^[i + 1]:= DefWidth div 2
      end;
      inc(AStr, 2);
      inc(i, 2);
      continue;
    end
    else
    Begin
      If AStr^=#0 Then
        Break;
      Last := pb^[AStr^];
    End;
    {$ELSE}
    If AStr^=#0 Then
      Break;
    Last := pb^[AStr^];
    {$ENDIF}
    inc(Res, Last);
    if POutBuff <> nil then
      POutBuff^[i] := Last;
    inc(AStr);
    inc(i);
  end;
  Result := Res;
end;

function  TFontManager.GetCharCountFromBuff(AStr: PChar; ALen, DefWidth : integer; const APBuffWidths: PIntArray; AInWidth: integer; AReverseCalc, AExact:boolean; var ARealWidth: integer): integer;
var
  i: integer;
  pb : PIntArray;
  Res : integer;
  d: integer;
  _Last: integer;
  {$IFDEF DCMBCS}
  s : string;
  {$ENDIF}
begin
  pb := APBuffWidths;
  Res := 0;
  {$IFDEF DCMBCS}
    s := '';
    if SysLocale.FarEast and AReverseCalc then
      SetString(S, AStr, ALen);
  {$ENDIF}
  if not AReverseCalc then
    d := 1
  else
  begin
    inc(AStr, ALen - 1);
    d := -1;
  end;
  i := 0;
  Result := 0;
  while i < ALen  do
  begin

    {$IFDEF DCMBCS}
    if SysLocale.FarEast and ((not AReverseCalc and (AStr^ in LeadBytes)) or (AReverseCalc and (ByteType(s, ALen - i - 1) = mbTrailByte))) then
    begin
      inc(AStr, d);
      inc(i);
      _Last := DefWidth;
    end
    else
      _Last := pb^[AStr^];
    {$ELSE}
    _Last := pb^[AStr^];
    {$ENDIF}

    inc(Res, _Last);

    if Res > AInWidth then
    begin
      ARealWidth := Res - _Last;
      if (not AExact) and ((AInWidth - ARealWidth) > (_Last div 2)) then
      begin
        inc(Result);
        ARealWidth := Res;
      end;
      exit;
    end;
    inc(AStr, d);
    inc(i);
    Result := i;
  end;
  ARealWidth := Res;
  Result := ALen;
end;

function TFontManager.AddNewFont(AFontHandle: _HFONT): PFontItem;
begin
  Result := FArrOfPFontItem[cMaxCachedFont -1];
  with Result^ do
  begin
    {$IFNDEF CLX}
    FontHandle := AFontHandle;
    {$ELSE}
    FontHandle := QFont_handle(AFontHandle);
    {$ENDIF}
    FillBuffAndInfo(AFontHandle, @BuffWidths, @FontInfo);
  end;
end;

function TFontManager.MoveToTop(AIndex: integer): PFontItem;
var
  PItem: PFontItem;
begin
  if AIndex > 0 then
  begin
    PItem := FArrOfPFontItem[AIndex];
    Move(Integer(FArrOfPFontItem[0]), Integer(FArrOfPFontItem[1]), AIndex * sizeof(PFontItem));
    FArrOfPFontItem[0] := PItem;
  end;
  Result := FArrOfPFontItem[0];
end;

function  TFontManager.FindFontItem(AFontHandle: _HFONT): PFontItem;
var
  i : Integer;
  idx: integer;
begin
  idx := -1;
  for i := 0 to cMaxCachedFont -1 do
  begin
    Result := FArrOfPFontItem[i];
    with Result^ do
    begin
      if integer(FontHandle) = 0 then
        break
      else
      {$IFNDEF CLX}
      if FontHandle = AFontHandle then
      {$ELSE}
      if FontHandle = QFont_handle(AFontHandle) then
      {$ENDIF}
        begin
          idx := i;
          break;
        end;
    end;
  end;
  if idx = -1 then
  begin
    AddNewFont(AFontHandle);
    idx := cMaxCachedFont -1;
  end;
  Result := MoveToTop(idx);
end;

function  TFontManager.GetWidthAndInfo(const AFontHandle: _HFONT;  AStr: PChar; ALen: integer; APFontInfo: PFontInfo; POutBuff : PIntegerArray): integer;
begin
  with FindFontItem(AFontHandle)^ do
  begin
    Result := GetWidthFromBuff(AStr, ALen, FontInfo.AveCharWidth, @BuffWidths, POutBuff);
    if APFontInfo <> nil then
      with FontInfo do
      begin
        APFontInfo.OverHang := OverHang;
        APFontInfo.Ascent := Ascent;
        APFontInfo.Descent := Descent;
        APFontInfo.AveCharWidth := AveCharWidth;
      end;
  end;
end;

function  TFontManager.GetWidths(const AFontHandle: _HFONT;  AStr: PChar; MaxChars:Integer;POutBuff : PIntegerArray): integer;
begin
  with FindFontItem(AFontHandle)^ do
    Result := GetWidthsFromBuff(AStr, MaxChars, FontInfo.AveCharWidth, @BuffWidths, POutBuff);
end;

function TFontManager.GetCharsInWidth(const AFontHandle: _HFONT; AStr: PChar; ALen: integer; AInWidth: integer; AReverseCalc, AExact :boolean; var ARealWidth: integer): integer;
begin
  with FindFontItem(AFontHandle)^ do
    Result := GetCharCountFromBuff(AStr, ALen, FontInfo.AveCharWidth, @BuffWidths, AInWidth, AReverseCalc, AExact, ARealWidth);
end;

function  TFontManager.GetFontInfo(const AFontHandle: _HFONT): PFontInfo;
begin
  Result := @(FindFontItem(AFontHandle)^.FontInfo);
end;

{$IFDEF DCMBCS}
procedure  InitMbcs;
var
  i : char;
begin

  if SysLocale.FarEast and (LeadBytes <> []) then
    for i := #128 to #255 do
      if i in LeadBytes then
      begin
        MBCSTestStr := i + char($7C);
        break;
      end;
end;
{$ENDIF}

initialization
  FontManager := TFontManager.Create;
  {$IFDEF DCMBCS}
  InitMbcs;
  {$ENDIF}
finalization
  FontManager.Free;

end.
