unit fcCommon;
{$T-}  { Disable Typed@ Operator}
{
//
// Components : Common routines
//
// Copyright (c) 1995, 1996, 1997 by Woll2Woll Software
//
// 3/10/99 - PYW - Changed TStringList to TStrings.
// 6/28/99 - Support any TCustomGrid for future support in IP 5
}
interface

{$i fcIfDef.pas}

uses Classes, SysUtils, Dialogs, Forms, Controls, Printers, Buttons,
  Windows, Graphics, Menus, StdCtrls, TypInfo, Math, Messages, ExtCtrls,{ JPEG,}
  {$ifdef fcDelphi4Up}
  ImgList,
  {$endif}
  Registry, CommCtrl, fcBitmap, ComCtrls;

const
  clNullColor = $0FFFFFFF;

type
  TfcPointSet = (psGlyph, psText, psOffset);
  TfcPointSets = set of TfcPointSet;

  TfcProcMeth = procedure of object;
  TfcBoolFunc = function: Boolean of object;
  TfcSetBoundsProc = procedure(Control: TWinControl; Rect: TRect) of object;

  TfcLayout = (loVertical, loHorizontal);

  TfcFontType = (ftPrinter, ftTrueType, ftOther);
  PfcFontType = ^TfcFontType;

  PfcPolyGonPoints = ^TFCPolyGonPoints;
  TfcPolyGonPoints = array[0..20] of TPoint;

  TwwDBGridOption = (dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator,
    dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect,
    dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit,
    dgWordWrap, dgPerfectRowFit, dgMultiSelect);

  TwwDBGridOptions = set of TwwDBGridOption;

  TwwListSortCompare = function (Item1, Item2: String): Integer;
  TwwGetCompareString = function (SList:TStrings; Index: Integer): String;

  TfcOrientation = (fcTopLeft, fcTopRight, fcBottomLeft, fcBottomRight,
    fcTop, fcRight, fcLeft, fcBottom);

  TfcDiagonals = fcTopLeft..fcBottomRight;
  TfcStraights = fcTop..fcBottom;

//const
//  OFFSETCOORD: array[TfcOrientation] of TPoint = (
//    (x: 1; y: 1) {TopLeft}, (x: -1; y: 1) {TopRight},
//    (x: 1; y: -1) {BottomLeft}, (x: -1; y: -1) {BottomRight},
//    (x: 0; y: 1) {Top}, (x: -1; y: 0) {Right},
//    (x: 1; y: 0) {Left}, (x: 0; y: -1) {Bottom}
//  );
//}
procedure fcHelp(Handle: HWND; HelpTopic: PChar);
procedure fcCalcButtonLayout(TopLeft: TPoint; TextRect, GlyphRect: PRect;
  TextSize, GlyphSize: TSize; Layout: TButtonLayout;
  Spacing: Integer);
function fcGetComCtlVersion: Integer;
procedure fcStripWhiteSpace(var s: string);
procedure fcStripTrailing(var s: string);
function fcComponentFromString(Root: TComponent; Value: string): TComponent;
function fcStringFromComponent(Root: TComponent; Value: TComponent): string;
function fcGetRegionData(Rgn: HRGN): string;

// Color related functions
procedure fcColorToByteValues(AColor: TColor; var Reserved, Blue, Green, Red: Byte);
function fcRGBToHexString(R,G,B: Byte): string;
function fcColorToRGBString(AColor: TColor): string;
function fcGetColorFromList(AList: TStrings; Index: Integer): TColor;
function fcSetColorDialogCustomColors(AList: TStrings): TStrings;
function fcModifyColor(Color: TColor; Amount: Integer; Percent: Boolean): TColor;
function fcRGBToBGR(Color: TColor): TColor;
function fcHighestRGBVal(Color: TColor): BYTE;

// Stringlist related functions
function fcGetValuesFromStringList(AList: TStrings; Index: Integer): string;
function fcGetNamesFromStringList(AList: TStrings; Index: Integer): string;
function fcGetItemsFromStringList(SList:TStrings;Index:integer): String;
function fcValueInList(Value: string; List: TStrings): integer;
function fcNameInList(Name: string; List: TStrings): integer;

// Runtime Type Info Functions (RTTI)
function fcGetPropInfo(Component: TPersistent; PropName: string): PPropInfo;
function fcIsClass(ClassType: TClass; const Name: string): Boolean;
function fcGetStrProp(Component: TPersistent; PropName: string): string;
function fcGetOrdProp(Component: TPersistent; PropName: string): Integer;
procedure fcSetStrProp(Component: TPersistent; PropName: string; Value: string);
procedure fcSetOrdProp(Component: TPersistent; PropName: string; Value: Integer);
procedure fcGetBooleanProps(Component: TPersistent; List: TStrings);

// InfoPower Grid Functions
function fcIsInwwGrid(AControl:TControl):boolean;
{$ifdef fcDelphi4Up}
function fcIsInwwObjectView(control: TWinControl):boolean;
function fcIsInwwObjectViewPaint(control: TWinControl):boolean;
{$endif}
function fcGetGridOptions(AControl:TControl): TwwDBGridOptions;
function fcParentGridFocused(AControl:TControl): boolean;

// Miscellaneous
procedure fcPatternFill(Pattern: Pointer; SizeOfPat: Integer; Dst: Pointer; SizeOfDst: Integer);
function fcGetShiftState:TShiftState;
procedure fcParentInvalidate(Control: TControl; Erase: Boolean);
procedure fcPlayKeystroke(Handle: HWND; VKChar: word; VKShift: Word);
procedure fcQuickSort(SList: TStrings; L, R: Integer;
  SCompare: TwwListSortCompare; SGetString:TwwGetCompareString);
function fcGetHintWindow: THintWindow;
function fcGenerateName(Component: TComponent; const Base: string): string;
procedure fcAdjustFlag(Condition: Boolean; var Flag: UINT; FlagVal: UINT);
function fcGetCursorPos: TPoint;
function fcCombineRect(r1, r2: TRect): TRect;
procedure fcShowHint(Hint: string; Coord: TPoint);
procedure fcInvalidateChildren(Control: HWND);
procedure fcInvalidateOverlappedWindows(ParentHwnd: HWND; FirstChild: HWND);
function fcProportionalRect(OrigRect: TRect; Width, Height: Integer): TRect;
function fcRectEmpty(r: TRect): Boolean;
function fcLineHeight(Canvas: TCanvas; Flags: Integer; MaxWidth: Integer; Line: string): Integer;
function fcUnionRect(R1, R2: TRect): TRect;

function fcUpdatedComCtlVersion: boolean;
procedure fcMakePagesResourceFriendly(PageControl: TPageControl);
function fcRegionFromBitmap(ABitmap: TfcBitmap; TransColor: TColor): HRgn;
procedure fcDrawEllipsis(Canvas: TCanvas; R: TRect; State: TButtonState;
    Enabled: Boolean; ControlState: TControlState);
procedure fcDrawDropDownArrow(Canvas: TCanvas; R: TRect;
    State: TButtonState; Enabled: Boolean; ControlState: TControlState);
function fcExecuteColorDialog(AColor: TColor): TColor;
procedure fcGetChildRegions(Control: TWinControl; Transparent: Boolean; Rgn: HRGN; Offset: TPoint; Flags: Integer);

function fcFindGlobalComponent(const Name: string): TComponent;

type
  TfcInteger = record
    Value: Integer;
  end;
  function fcWithInteger(Value: Integer): TfcInteger;

// Animation
type
  TfcAnimateListItem = class
    Control: TWinControl;
    Bitmap: TBitmap;
    OrigRect: TRect;
    CurRect: TRect;
    FinalRect: TRect;
  end;

  TfcGroupAnimateItem = class
    MainItem: TfcAnimateListItem;
    SecondItem: TfcAnimateListItem;
  end;

procedure fcAnimateControls(Control: TWinControl; ControlCanvas: TCanvas; AnimateList: TList; Interval: Integer; Steps: Integer; SetBoundsProc: TfcSetBoundsProc);
procedure fcBufferredAnimation(ControlCanvas: TCanvas; AnimateList: TList; Interval: Integer; Steps: Integer);

//Graphic Functions...
procedure fcTileDraw(Source: TGraphic; Dest: TCanvas; DstRect: TRect);
procedure fcDrawMask(Canvas: TCanvas; ARect: TRect; Bitmap, Mask: TBitmap; Buffer: Boolean);
procedure fcPaintTo(Control: TWinControl; Canvas: TCanvas; X, Y: Integer);
function fcBytesPerScanline(PixelsPerScanline, BitsPerPixel, Alignment: Longint): Longint;
Function fcIsTrueColorBitmap(Bitmap: TBitmap): boolean;
function fcCreateRegionFromBitmap(ABitmap:TBitmap;TransColor: TColor) : HRgn;
function fcGetDIBBitsFromBitmap(aBitmap: TBITMAP; var BitmapInfo:TBitmapInfo; var pixbuf:Pointer; var bytespscanline:Integer; var Hb:HBitmap): Boolean;
procedure fcSetDitherBitmap(DitherBitmap: TBitmap;
  Color1, Color2: TColor);
procedure fcDither(ACanvas: TCanvas; Rect: TRect; Color1, Color2: TColor);
procedure fcOffsetBitmap(Bitmap: TfcBitmap; Transparent: TColor; Offset: TPoint);
procedure fcDottedLine(Canvas: TCanvas; p1, p2: TPoint);
procedure fcTransparentDraw(Canvas: TCanvas; ARect: TRect; Bitmap: TfcBitmap; TransparentColor: TColor);
procedure fcImageListDraw(ImageList: TCustomImageList; Index: Integer; Canvas: TCanvas;
  X, Y: Integer; Style: Cardinal; Enabled: Boolean);
procedure fcPaintRegion(Rgn: HRGN; DoOffset: Boolean; ShowModal: Boolean);
procedure fcPaintCanvas(ACanvas: TCanvas; Modal: Boolean);
procedure fcPaintGraphic(AGraphic: TGraphic; Modal: Boolean);
procedure fcPaintDC(DC: HDC; Modal: Boolean);
procedure fcClipBitmapToRegion(Bitmap: TfcBitmap; Rgn: HRGN);
function fcGetDitherBrush: HBRUSH;

// Value Functions
function fcMin(Int1, Int2: Integer): Integer;
function fcMax(Int1, Int2: Integer): Integer;
function fcLimit(Val: integer; Int1, Int2: Integer): integer;
function fcThisThat(const Clause: Boolean; TrueVal, FalseVal: Integer): Integer;

// Windows Structure Functions
function fcRectWidth(Rect: TRect): Integer;
function fcRectHeight(Rect: TRect): Integer;
function fcSize(cx, cy: Integer): TSize;
function fcSizeEqual(Size1, Size2: TSize): Boolean;
procedure fcIncSize(var Size: TSize; Amount: Integer);
function fcMessage(Msg: Cardinal; wParam: WPARAM; lParam: LPARAM; MsgRslt: Cardinal): TMessage;

// String Functions
function fcSubstring(s: string; Start, Stop: integer): string;
function fcReplace(s, Find, Replace: string): string;
function fcIndexOf(Substr, s: string; Index: integer): integer;
function fcLastIndexOf(Substr, s: string; Index: integer): integer;
function fcNthIndexOf(Substr, s: string; Index: integer): integer;
function fcCountTokens(s, Delimiter: string): integer;
function fcGetToken(s, Delimiter: string; Index: integer): string;
function fcSetToken(s, Delimiter, Token: string; Index: integer): string;
function fcFindToken(s, Delimiter, Token: string): Integer;
function fcMultiLineTextSize(Canvas: TCanvas; Text: string; LineSpacing: Integer;
  MaxWidth: Integer; DrawFlags: Integer): TSize;
function fcStripAmpersands(Value: string): string;

// Integer Functions
function fcSign(Value: Extended): Integer;
procedure fcCreateDisabledBitmap(SrcBm, DstBm: TBitmap);

// Font Functions
function fcGetFontIcon(FaceName: string): TfcFontType;
function fcGetFontType(AFontType: Integer): TfcFontType;
function fcLogFont: TLogFont;

var fcVersion1stClass: string;

{$r-}

const
  BitMask: array[0..7] of byte = (128, 64, 32, 16, 8, 4, 2, 1);
  fcComCtlVersionIE3 = $00040046;
  fcComCtlVersionIE4 = $00040047;
  fcComCtlVersionIE401 = $00040048;
  fcComCtlDllName = 'comctl32.dll';

implementation

var fcComCtlVersion: Integer;

{$r fcBrushes.res}
{$r fcCmbBtn.res}

function fcGetComCtlVersion: Integer;
var
  FileName: string;
  InfoSize, Wnd: DWORD;
  VerBuf: Pointer;
  FI: PVSFixedFileInfo;
  VerSize: DWORD;
begin
  if fcComCtlVersion = 0 then
  begin
    FileName := fcComCtlDllName;
    InfoSize := GetFileVersionInfoSize(PChar(FileName), Wnd);
    if InfoSize <> 0 then
    begin
      GetMem(VerBuf, InfoSize);
      try
        if GetFileVersionInfo(PChar(FileName), Wnd, InfoSize, VerBuf) then
          if VerQueryValue(VerBuf, '\', Pointer(FI), VerSize) then
            fcComCtlVersion := FI.dwFileVersionMS;
      finally
        FreeMem(VerBuf);
      end;
    end;
  end;
  Result := fcComCtlVersion;
end;

// Function for determining the current shiftstate

function fcGetShiftState: TShiftState;
begin
  Result := [];
  if GetKeyState(VK_SHIFT) < 0 then Include(Result, ssShift);
  if GetKeyState(VK_CONTROL) < 0 then Include(Result, ssCtrl);
  if GetKeyState(VK_MENU) < 0 then Include(Result, ssAlt);
end;

{ Return true if class is derived from 'Name' }
{ This code is more code efficient than InheritsFrom or 'Is'
  as it does not require that the compiler link in the class }
function fcIsClass(ClassType: TClass; const Name: string): Boolean;
begin
  Result := True;
  while ClassType <> nil do
  begin
{    if ClassType.ClassNameIs(Name) then Exit;}
    if uppercase(ClassType.ClassName)=uppercase(Name) then Exit;
    ClassType := ClassType.ClassParent;
  end;
  Result := False;
end;

function fcParentGridFocused(AControl:TControl): boolean;
begin
   result:= False;
   if fcIsClass(AControl.Parent.ClassType, 'TwwDBGrid') then
      if AControl.Parent.Focused then result:= True
end;

function fcIsInwwGrid(AControl: TControl): Boolean;
begin
  result := False;
  if AControl.Parent = nil then Exit;

  if fcIsClass(AControl.Parent.ClassType, 'TCustomGrid') then { 6/28/99 - Support any TCustomGrid }
    result := True;
end;

{$ifdef fcDelphi4Up}
function fcIsInwwObjectView(control: TWinControl):boolean;
begin
  result := False;
  if fcisClass(control.Parent.classType, 'TwwDataInspector') then
     result := True;
end;

function fcIsInwwObjectViewPaint(control: TWinControl):boolean;
begin
  result := False;
  if fcisClass(control.Parent.classType, 'TwwDataInspector') then
     if csPaintCopy in control.ControlState then
        result := True;
end;
{$endif}

function fcGetGridOptions(AControl:TControl): TwwDBGridOptions;
begin
  Result := [];
  if fcIsClass(AControl.Parent.ClassType, 'TwwDBGrid') then
    PChar(@result)^ := Char(fcGetOrdProp(AControl.Parent, 'Options'));
end;

// String Functions for stripping out spaces
procedure fcStripPreceding(var s: string);
  var i,len: integer;
begin
  i:= 1;
  len:= length(s);
  while (i<=length(s)) and (s[i] in [' ',#9]) do i:= i+1;
  if ((len<>0) and (i<=len)) then
     s:= copy(s,i,len-i+1)
  else if (len<>0) then s:='';
end;

procedure fcStripTrailing(var s: string);
  var len: integer;
begin
  len := length(s);
  while (len > 0) and (s[len] in [' ', #9]) do len := len - 1;
  SetLength(s, len);
end;

Procedure fcStripWhiteSpace(var s: string);
  var tempstr: string;
begin
  tempstr := s;
  fcStripPreceding(tempstr);
  fcStripTrailing(tempstr);
  s := tempstr;
end;

{Gets the Byte Values for a color independent of order of Color}
procedure fcColorToByteValues(AColor: TColor; var Reserved, Blue, Green, Red: Byte);
var WinColor: COLORREF;
begin
  WinColor := ColorToRGB(AColor);
  Reserved := ($FF000000 and WinColor) Shr 24;
  Blue := ($00FF0000 and WinColor) Shr 16;
  Green := ($0000FF00 and WinColor) Shr 8;
  Red := ($000000FF and WinColor);
end;

function fcRGBToHexString(R,G,B:Byte):String;
begin
  result := Format('%2.2x%2.2x%2.2x',[R,G,B]);
end;

function fcColorToRGBString(AColor: TColor): string;
var red1,blue1,green1,reserved:byte;
begin
  fcColorToByteValues(AColor,reserved,blue1,green1,red1);
  result := 'RGB: '+IntToStr(red1)+', '
                   +IntToStr(green1) + ', '
                   +IntToStr(blue1);
end;

function fcGetItemsFromStringList(SList:TStrings;Index:integer): String;
begin
   result := SList.Strings[Index];
end;

function fcGetNamesFromStringList(AList:TStrings;Index:integer): String;
begin
   result := '';
   if (Index <> -1) then  result := AList.Names[Index];
end;

function fcGetValuesFromStringList(AList:TStrings;Index: Integer): string;
var temps:string;
begin
  temps:=AList.Strings[Index];   //List is in RGB already...
  temps := Copy(temps,pos('=',temps)+1,length(temps));
  fcStripWhiteSpace(temps);
  result :=Temps;
end;

function fcGetColorFromList(AList:TStrings;Index: Integer): TColor;
var temps:string;
begin
   temps := fcGetValuesFromStringList(AList,Index);
   result := StringToColor('$'+temps);
end;

{Returns -1 if ColorValue is not found in the list;
 otherwise returns the index position in the list}
function fcValueInList(Value: string; List: TStrings): integer;
var i: integer;
begin
  result := -1;
  for i := 0 to List.Count - 1 do
    if fcGetValuesFromStringList(List,i) = Value then begin result := i; break; end;
end;

function fcNameInList(Name: string; List: TStrings): integer;
var i: integer;
begin
  result := -1;
  for i := 0 to List.Count - 1 do
    if AnsiUppercase(List.Names[i]) = AnsiUppercase(Name) then { RSW }
    begin
      result := i;
      break;
    end;
end;

function fcSetColorDialogCustomColors(AList:TStrings):TStrings;
var sList:TStringList;
    i:Integer;
begin
  sList := TStringList.Create;
  for i:= ord('A') to ord('P') do
     sList.Add('Color'+Char(i)+'='+AList.Values[AList.Names[i-ord('A')]]);
  result := sList;
end;

procedure fcQuickSort(SList: TStrings; L, R: Integer;
  SCompare: TwwListSortCompare; SGetString:TwwGetCompareString);
  var
    I, J: Integer;
    P, T: String;
begin
    repeat
      I := L;
      J := R;
      P := SGetString(SList,((L + R) shr 1));
      repeat
        while (i<=SList.count-1) and(SCompare(SGetString(SList,I), P) < 0) do
           Inc(I);
        while (j>=0) and (SCompare(SGetString(SList,J), P) > 0) do Dec(J);
        if I <= J then
        begin
          T := SList[I];
          SList[I] := SList[J];
          SList[J] := T;
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if L < J then fcQuickSort(SList, L, J, SCompare, SGetString);
      L := I;
    until I >= R;
end;

function fcIsTrueColorBitmap(Bitmap: TBitmap): boolean;
begin
  result:= Bitmap.PixelFormat = Graphics.pf24bit;
end;

function fcBytesPerScanline(PixelsPerScanline, BitsPerPixel, Alignment: Longint): Longint;
begin
  Dec(Alignment);
  Result := ((PixelsPerScanline * BitsPerPixel) + Alignment) and not Alignment;
  Result := Result div 8;
end;

// This function creates a HBitmap that must be deleted using DeleteObject by the caller
function fcGetDIBBitsFromBitmap(aBitmap: TBITMAP; var BitmapInfo:TBitmapInfo; var pixbuf:Pointer; var bytespscanline:Integer; var Hb:HBitmap): Boolean;
begin
  FillChar(BitmapInfo, SizeOf(TBitmapInfo), 0);
  with BitmapInfo.bmiheader do
  begin
    biSize := sizeof(TBitmapInfoHeader);
    biWidth := ABitmap.Width;
    biHeight := -ABitmap.Height;   //DIBs are Bottom up
    biPlanes :=1;
    biBitCount := 24;
    biCompression := BI_RGB;
    bytespscanline := fcBytesPerScanline(LongInt(biwidth),biBitCount, 32);
  end;

  hb := CreateDIBSection(ABitmap.Canvas.Handle, BitmapInfo, DIB_RGB_COLORS, pixbuf, 0, 0);

  if (pixbuf = nil) or (hb = 0) then
  begin
    raise EInvalidOperation.Create('Could Not Create DIB Section');
    Exit;
  end;

  GetDIBits(ABitmap.Canvas.Handle, aBitmap.handle, 0, ABitmap.height, pixbuf, BitmapInfo, DIB_RGB_COLORS);
  result := True;
end;

type TNewImageList = class(TImageList);

function fcCreateRegionFromBitmap(ABitmap: TBitmap; TransColor: TColor): HRgn;
var
  TempBitmap: TBitmap;
  Rgn1, Rgn2: HRgn;
  Col, StartCol, Row: integer;
  Line: PByteArray;

  function ColToColor(Col: integer): TColor;
  begin
    if fcIsTrueColorBitmap(TempBitmap) then
      result:= Line[Col * 3] * 256 * 256 + Line[Col * 3 + 1] * 256 + Line[Col * 3 + 2]
    else result := TColor(fcThisThat((Line[Col div 8] and BitMask[Col mod 8]) <> 0, clBlack, clWhite));
  end;
begin
  result := 0;
  if (ABitmap <> nil) and (ABitmap.Width = 0) or (ABitmap.Height = 0) then Exit;
  Rgn1 := 0;

  TempBitmap := TBitmap.Create;

  TempBitmap.Assign(ABitmap);
  if not fcIsTrueColorBitmap(TempBitmap) then
  begin
    TempBitmap.Mask(TransColor);
    TransColor := clBlack;
  end;

  with TempBitmap do
  begin
    for Row := 0 to TempBitmap.height-1 do
    begin
      Line:= scanLine[row];

      Col := 0;
      while Col < TempBitmap.Width do
      begin
        while (Col < TempBitmap.Width) and (ColToColor(Col) = TransColor) do inc(Col);
        if Col >= TempBitmap.Width then Continue;

        StartCol := Col;
        while (Col < TempBitmap.Width) and (ColToColor(Col) <> TransColor) do inc(Col);
        if Col >= TempBitmap.Width then Col := TempBitmap.Width;

        if Rgn1 = 0 then Rgn1 := CreateRectRgn(StartCol, Row, Col, Row + 1)
        else begin
          Rgn2 := CreateRectRgn(StartCol, Row, Col, Row + 1);
          if (Rgn2 <> 0) then CombineRgn(Rgn1,Rgn1,Rgn2,RGN_OR);
            Deleteobject(Rgn2);
        end;
      end;
    end;
  end;
  result := Rgn1;
  TempBitmap.Free;
end;

function fcRegionFromBitmap(ABitmap: TfcBitmap; TransColor: TColor): HRgn;
type PCOLORREF = ^COLORREF;
var
  Rgn1, Rgn2: HRgn;
  Col, StartCol, Row: integer;
begin
  result := 0;
  if (ABitmap <> nil) and (ABitmap.Width = 0) or (ABitmap.Height = 0) then Exit;
  Rgn1 := 0;

  if TransColor = -1 then TransColor := fcGetStdColor(ABitmap.Pixels[0, 0]);

  with ABitmap do
  begin
    for Row := 0 to Height - 1 do
    begin
      Col := 0;
      while Col < Width do
      begin
        while (Col < Width) and (fcGetStdColor(Pixels[Row, Col]) = TransColor) do
          inc(Col);
        if Col >= Width then Continue;

        StartCol := Col;
        while (Col < Width) and (fcGetStdColor(Pixels[Row, Col]) <> TransColor) do inc(Col);
        if Col >= Width then Col := Width;

        if Rgn1 = 0 then Rgn1 := CreateRectRgn(StartCol, Row, Col, Row + 1)
        else begin
          Rgn2 := CreateRectRgn(StartCol, Row, Col, Row + 1);
          if (Rgn2 <> 0) then CombineRgn(Rgn1,Rgn1,Rgn2,RGN_OR);
            Deleteobject(Rgn2);
        end;
      end;
    end;
  end;
  result := Rgn1;
end;

procedure fcSetDitherBitmap(DitherBitmap: TBitmap;
  Color1, Color2: TColor);
var i, j: Integer;
begin
{  if (Screen.ActiveForm<>nil) and (Screen.ActiveForm.Canvas.Handle<>0) then
  begin
     if GetDeviceCaps(Screen.ActiveForm.canvas.handle, BITSPIXEL)<=4 then
        DitherBitmap.LoadFromResourceName(HINSTANCE, 'SELECTIONBRUSH')
     else DitherBitmap.LoadFromResourceName(HINSTANCE, 'SELECTIONBRUSH256');
  end
  else}
  DitherBitmap.LoadFromResourceName(HINSTANCE, 'SELECTIONBRUSH');

  for i := 0 to DitherBitmap.Width - 1 do
    for j := 0 to DitherBitmap.Height - 1 do
      if (i + j) mod 2 = 0 then DitherBitmap.Canvas.Pixels[i, j] := clWhite
      else DitherBitmap.Canvas.Pixels[i, j] := clBlack;
  DitherBitmap.Monochrome := True;
end;

function fcMin(Int1, Int2: Integer): Integer;
begin
  if Int1 < Int2 then result := Int1 else result := Int2;
end;

function fcMax(Int1, Int2: Integer): Integer;
begin
  if Int1 > Int2 then result := Int1 else result := Int2;
end;

function fcLimit(Val: integer; Int1, Int2: Integer): Integer;
begin
   val:= fcMax(val, int1);
   val:= fcMin(val, int2);
   result:= val;
end;

procedure fcPlayKeystroke(Handle: HWND; VKChar: word; VKShift: Word);
var
  KeyState: TKeyboardState;
  NewKeyState: TKeyboardState;
begin
   GetKeyboardState(KeyState);
   NewKeyState:= KeyState;
   NewKeyState [VKShift] := $81;
   NewKeyState [VKChar] := $81;
   SetKeyboardState(NewKeyState);
   PostMessage(Handle, WM_KEYDOWN, VKChar, 1);
   PostMessage(Handle, WM_KEYUP, VKChar, 1);
   SetKeyboardState(KeyState);
end;

function fcRectWidth(Rect: TRect): Integer;
begin
  result := Rect.Right - Rect.Left;
end;

function fcRectHeight(Rect: TRect): Integer;
begin
  result := Rect.Bottom - Rect.Top;
end;

function fcSubstring(s: string; Start, Stop: integer): string;
begin
  if Stop = 0 then result := Copy(s, Start, length(s) - Start + 1)
  else result := Copy(s, Start, Stop - Start);
end;

function fcIndexOf(Substr, s: string; Index: integer): integer;
begin
  result := pos(Substr, fcSubstring(s, Index, 0));
  if result <> 0 then result := result + Index - 1;
end;

function fcLastIndexOf(Substr, s: string; Index: integer): integer;
begin
  if Index = 0 then Index := Length(s);
  for result := Index - Length(Substr) downto 1 do
    if Copy(s, result, Length(Substr)) = Substr then break;
end;

// Returns the position of Index'th (zero-based) occurance of Substring

function fcNthIndexOf(Substr, s: string; Index: integer): integer;
var Counter: integer;
begin
  Counter := -1;
  result := 0;
  while Counter < Index do
  begin
    inc(Counter);
    result := fcIndexOf(Substr, s, result + 1);
  end;
end;

// Index is zero based.  eg.

function fcCountTokens(s, Delimiter: string): integer;
var i: integer;
begin
  result := 0;
  if length(s) > 0 then result := 1;
  for i := 1 to Length(s) do
    if Copy(s, i, Length(Delimiter)) = Delimiter then inc(result);
end;

// fcGetToken('RichEdit's are great!', ' ', 1) will return 'are'

function fcGetToken(s, Delimiter: string; Index: integer): string;
var Temp: integer;
begin
  if (Index >= fcCountTokens(s, Delimiter)) then result := ''
  else begin
    Temp := fcNthIndexOf(Delimiter, s, Index - 1);
    if Temp <> 0 then inc(Temp, Length(Delimiter))
    else Temp := 1;
    result := fcSubstring(s, Temp, fcNthIndexOf(Delimiter, s, Index));
  end;
end;

// Set's a given token to the given value and returns the updated string.

function fcSetToken(s, Delimiter, Token: string; Index: integer): string;
var Temp: integer;
begin
  Temp := fcNthIndexOf(Delimiter, s, Index - 1);
  if Temp <> 0 then inc(Temp, Length(Delimiter));
  if Temp = 0 then
  begin
    Temp := Length(s) + Length(Delimiter) + 1;
    s := s + Delimiter;
  end;
  if fcNthIndexOf(Delimiter, s, Index) <> 0 then
    result :=
      fcSubstring(s, 1, Temp) +
      Token +
      fcSubstring(s, fcNthIndexOf(Delimiter, s, Index), 0)
  else
    result :=
      fcSubstring(s, 1, Temp) +
      Token;
end;

function fcFindToken(s, Delimiter, Token: string): Integer;
var i: Integer;
begin
  result := -1;
  for i := 0 to fcCountTokens(s, Delimiter) - 1 do
    if fcGetToken(s, Delimiter, i) = Token then
    begin
      result := i;
      Break;
    end;
end;

function fcGetPropInfo(Component: TPersistent; PropName: string): PPropInfo;
begin
  result := GetPropInfo(Component.ClassInfo, PropName);
  if result = nil then raise EInvalidOperation.Create(Format('Property %s does not exist.', [Propname]));
end;

function fcGenerateName(Component: TComponent; const Base: string): string;
var i, j: Integer;
    Accept: Boolean;
begin
  i := 1;
  while True do
  begin
    result := Base + InttoStr(i);
    Accept := True;
    for j := 0 to Component.ComponentCount - 1 do
      if Component.Components[j].Name = result then
      begin
        Accept := False;
        Break;
      end;
    if Accept then Break;
    inc(i);
  end;
end;

function fcGetCursorPos: TPoint;
begin
  GetCursorPos(result);
end;

function fcThisThat(const Clause: Boolean; TrueVal, FalseVal: Integer): Integer;
begin
  if Clause then result := TrueVal else Result := FalseVal;
end;

function fcSize(cx, cy: Integer): TSize;
begin
  result.cx := cx;
  result.cy := cy;
end;

function fcSizeEqual(Size1, Size2: TSize): Boolean;
begin
  result := (Size1.cx = Size2.cx) and (Size1.cy = Size2.cy);
end;

function fcStripAmpersands(Value: string): string;
begin
  result := fcReplace(Value, '&&', #0);
  result := fcReplace(result, '&', '');
  result := fcReplace(result, #0, '&');
end;

function fcReplace(s, Find, Replace: string): string;
var i: integer;
begin
  i := 1;
  result := '';
  while i <> 0 do
  begin
    result := result + fcSubstring(s, i, fcIndexOf(Find, s, i));
    if fcIndexOf(Find, s, i) = 0 then Break;
    result := result + Replace;
    i := fcIndexOf(Find, s, i);
    if i <> 0 then inc(i, Length(Find));
  end;
end;

function fcLineHeight(Canvas: TCanvas; Flags: Integer; MaxWidth: Integer; Line: string): Integer;
var r: TRect;
begin
  r := Rect(0, 0, MaxWidth, 0);
  DrawTextEx(Canvas.Handle, PChar(Line), Length(Line), r, Flags or DT_CALCRECT, nil);
  result := fcRectHeight(r);
end;

function fcMultiLineTextSize(Canvas: TCanvas; Text: string; LineSpacing: Integer;
  MaxWidth: Integer; DrawFlags: Integer): TSize;
var i: Integer;
    s: string;
    TokenCount: Integer;
    r: TRect;
begin
  TokenCount := fcCountTokens(Text, #13#10);
  result := fcSize(0, 0);

  for i := 0 to TokenCount - 1 do
  begin
    s := fcGetToken(Text, #13#10, i);
    if MaxWidth = 0 then
    begin
      inc(result.cy, Canvas.TextHeight(s));
      if Canvas.TextWidth(s) > result.cx then result.cx := Canvas.TextWidth(s);
    end else begin
      r := Rect(0, 0, MaxWidth, 0);
      DrawTextEx(Canvas.Handle, PChar(s), Length(s), r, DrawFlags or DT_CALCRECT, nil);
      inc(result.cy, fcRectHeight(r));
      if fcRectWidth(r) > result.cx then result.cx := fcRectWidth(r);
    end;
    if i < TokenCount - 1 then inc(result.cy, LineSpacing);
  end;
end;

procedure fcAdjustFlag(Condition: Boolean; var Flag: UINT; FlagVal: UINT);
begin
  if Condition then Flag := Flag or FlagVal
  else Flag := Flag and not FlagVal;
end;

function fcSign(Value: Extended): Integer;
begin
  if Value > 0 then result := 1 else if Value < 0 then result := -1 else result := 0;
end;

procedure fcOffsetBitmap(Bitmap: TfcBitmap; Transparent: TColor; Offset: TPoint);
var TempBitmap: TBitmap;
begin
  TempBitmap := TBitmap.Create;
  TempBitmap.Assign(Bitmap);
  TempBitmap.Width := TempBitmap.Width + Abs(Offset.x) * 2;
  TempBitmap.Height := TempBitmap.Height + Abs(Offset.y) * 2;
  TempBitmap.Canvas.Brush.Color := Transparent;
  TempBitmap.Canvas.FillRect(Rect(0, 0, TempBitmap.Width, TempBitmap.Height));
  TempBitmap.Canvas.Draw(Offset.x, Offset.y, Bitmap);
  Bitmap.Assign(TempBitmap);
  TempBitmap.Free;
end;

procedure fcDottedLine(Canvas: TCanvas; p1, p2: TPoint);
var i: integer;
    x, y: integer;
    tot: integer;
begin
{var ABrush: HBRUSH;
begin
  ABrush := fcGetDitherBrush;
  SelectObject(Canvas.Handle, ABrush);
  SetTextColor(Canvas.Handle, clBlack);
  SetBkColor(Canvas.Handle, clWhite);
  SetBkMode(Canvas.Handle, TRANSPARENT);
  PatBlt(Canvas.Handle, 0, 0, 1, 20, $A000C9);
  DeleteObject(ABrush);}

  Canvas.Refresh;
  x := p1.x;
  y := p1.y;
  tot := fcMax(Abs(p2.y - p1.y), Abs(p2.x - p1.x));
  for i := 0 to tot do if i mod 2 = 0 then
  begin
    Canvas.Polyline([Point(x,y), Point(x+1,y+1)]);
    inc(x, (p2.x - p1.x) div fcMax(1, (tot div 2)));
    inc(y, (p2.y - p1.y) div fcMax(1, (tot div 2)));
  end;
end;

procedure fcTransparentDraw(Canvas: TCanvas; ARect: TRect; Bitmap: TfcBitmap; TransparentColor: TColor);
var MaskBm: TfcBitmap;
    Mask: TBitmap;
    TmpBitmap: TBitmap;
begin
  if TransparentColor = -1 then TransparentColor := fcGetStdColor(Bitmap.Pixels[0, 0]);
  MaskBm := TfcBitmap.Create;
  MaskBm.Assign(Bitmap);
  MaskBm.Mask(fcGetColor(TransparentColor));

  Mask := TBitmap.Create;
  Mask.Assign(MaskBm);
  Mask.Monochrome := True;

  MaskBm.Free;

  TmpBitmap := TBitmap.Create;
  TmpBitmap.Assign(Bitmap);
  fcDrawMask(Canvas, ARect, TmpBitmap, Mask, True);
  TmpBitmap.Free;

  Mask.Free;
end;

function fcModifyColor(Color: TColor; Amount: Integer; Percent: Boolean): TColor;
var Colors: TRGBQuad;
  function HighestOthers(Value: PByte): Byte;
  begin
    with Colors do
    begin
      result := 0;
      if Value = @rgbBlue then result := fcMax(rgbRed, rgbGreen)
      else if Value = @rgbRed then result := fcMax(rgbBlue, rgbGreen)
      else if Value = @rgbGreen then result := fcMax(rgbRed, rgbBlue);
    end;
  end;
  function Check(Value: Integer): Byte;
  begin
    result := Value;
    if Value < 0 then result := 0;
    if Value > 255 then result := 255;
  end;
  procedure DoChange(Value: PByte);
  begin
    if (Value^ = 0) and (HighestOthers(Value) = 255) and (Amount > 0) then
    begin
      if Percent then Value^ := Check(255 * Amount div 100)
      else Value^ := Check(Amount);
    end else begin
      if Percent then
      begin
        if Amount > 0 then Value^ := Check(Value^ + (255 - Value^) * Amount div 100)
        else Value^ := Check(Value^ + Value^ * Amount div 100);
      end else Value^ := Check(Value^ + Amount);
    end;
  end;
begin
  with Colors do
  begin
    fcColorToByteValues(Color, rgbReserved, rgbBlue, rgbGreen, rgbRed);
    DoChange(@rgbRed);
    DoChange(@rgbBlue);
    DoChange(@rgbGreen);
    result := RGB(rgbRed, rgbGreen, rgbBlue);
  end;
end;

procedure fcImageListDraw(ImageList: TCustomImageList; Index: Integer; Canvas: TCanvas;
  X, Y: Integer; Style: Cardinal; Enabled: Boolean);
const
  ROP_DSPDxax = $00E20746;
var
  R: TRect;
  DestDC, SrcDC: HDC;
  function GetRGBColor(Value: TColor): DWORD;
  begin
    Result := ColorToRGB(Value);
    case Result of
      clNone: Result := CLR_NONE;
      clDefault: Result := CLR_DEFAULT;
    end;
  end;
var AMonoBitmap: TBitmap;
begin
  with ImageList do
  begin
    if HandleAllocated then
    begin
      if Enabled then
        ImageList_DrawEx(Handle, Index, Canvas.Handle, X, Y, 0, 0,
          GetRGBColor(TImageList(ImageList).BkColor), GetRGBColor(TImageList(ImageList).BlendColor), Style)
      else
      begin
        AMonoBitmap := TBitmap.Create;
        with AMonoBitmap do
        begin
          Monochrome := True;
          Width := TImageList(ImageList).Width;
          Height := TImageList(ImageList).Height;
        end;

        { Store masked version of image temporarily in FBitmap }
        ImageList_DrawEx(Handle, Index, AMonoBitmap.Canvas.Handle, 0,0,0,0, 0,0,
          ILD_MASK);
        R := Rect(X, Y, X+TImageList(ImageList).Width, Y+TImageList(ImageList).Height);
        SrcDC := AMonoBitmap.Canvas.Handle;
        { Convert Black to clBtnHighlight }
        Canvas.Brush.Color := clBtnHighlight;
        DestDC := Canvas.Handle;
        Windows.SetTextColor(DestDC, clWhite);
        Windows.SetBkColor(DestDC, clBlack);
        BitBlt(DestDC, X+1, Y+1, TImageList(ImageList).Width, TImageList(ImageList).Height, SrcDC, 0, 0, ROP_DSPDxax);
        { Convert Black to clBtnShadow }
        Canvas.Brush.Color := clBtnShadow;
        DestDC := Canvas.Handle;
        Windows.SetTextColor(DestDC, clWhite);
        Windows.SetBkColor(DestDC, clBlack);
        BitBlt(DestDC, X, Y, TImageList(ImageList).Width, TImageList(ImageList).Height, SrcDC, 0, 0, ROP_DSPDxax);
        AMonoBitmap.Free;
      end;
    end;
  end;
end;

procedure fcIncSize(var Size: TSize; Amount: Integer);
begin
  inc(Size.cx, Amount);
  inc(Size.cy, Amount); 
end;

function fcGetHintWindow: THintWindow;
var i: Integer;
begin
  result := nil;
  for i := 0 to Application.ComponentCount - 1 do
    if Application.Components[i] is THintWindow then
    begin
      result := Application.Components[i] as THintWindow;
      Break;
    end;
end;

function fcMessage(Msg: Cardinal; wParam: WPARAM; lParam: LPARAM; MsgRslt: Cardinal): TMessage;
begin
  result.Msg := Msg;
  result.wParam := wParam;
  result.lParam := lParam;
  result.Result := MsgRslt;
end;

function fcGetFontType(AFontType: Integer): TfcFontType;
begin
  if AFontType = DEVICE_FONTTYPE then result := ftPrinter
  else if AFontType and TRUETYPE_FONTTYPE <> 0 then result := ftTrueType
  else result := ftOther;
end;

function fcFontCallBack(lpelf: PEnumLogFontEx; lpntm: PNewTextMetricEx; FontType: Integer;
  FontIcon: PfcFontType): Integer; stdcall;
begin
  result := 0;
  FontIcon^ := fcGetFontType(FontType);
end;

function fcGetFontIcon(FaceName: string): TfcFontType;
var lf: TLogFont;
begin
  FillChar(lf, SizeOf(lf), 0);
  StrLCopy(lf.lfFaceName, PChar(FaceName), 32);
  EnumFontFamiliesEx(Printers.Printer.Handle, lf, @fcFontCallback, Integer(@result), 0);
end;

function fcGetStrProp(Component: TPersistent; PropName: string): string;
var PropInfo: PPropInfo;
begin
  result := '';
  PropInfo := GetPropInfo(Component.ClassInfo, PropName);
  if PropInfo <> nil then result := GetStrProp(Component, PropInfo);
end;

function fcGetOrdProp(Component: TPersistent; PropName: string): Integer;
var PropInfo: PPropInfo;
begin
  result := 0;
  PropInfo := GetPropInfo(Component.ClassInfo, PropName);
  if PropInfo <> nil then result := GetOrdProp(Component, PropInfo);
end;

procedure fcSetStrProp(Component: TPersistent; PropName: string; Value: string);
var PropInfo: PPropInfo;
begin
  PropInfo := GetPropInfo(Component.ClassInfo, PropName);
  if PropInfo <> nil then SetStrProp(Component, PropInfo, Value);
end;

procedure fcSetOrdProp(Component: TPersistent; PropName: string; Value: Integer);
var PropInfo: PPropInfo;
begin
  PropInfo := GetPropInfo(Component.ClassInfo, PropName);
  if PropInfo <> nil then SetOrdProp(Component, PropInfo, Value);
end;

procedure fcGetBooleanProps(Component: TPersistent; List: TStrings);
var PropList: PPropList;
    i: Integer;
    PropCount: Integer;
begin
  PropCount := GetTypeData(Component.ClassInfo).PropCount;
  GetMem(PropList, PropCount * Sizeof(Pointer));
  try
    GetPropInfos(Component.ClassInfo, PropList);
    for i := 0 to PropCount - 1 do
      if (PropList[i]^.PropType^.Kind = tkEnumeration) and
         (PropList[i]^.PropType^.Name = 'Boolean') then
        List.Add(PropList[i].Name);
  finally
    FreeMem(PropList);
  end;
end;

function fcLogFont: TLogFont;
begin
  with result do
  begin
    FillChar(result, SizeOf(result), 0);
    lfCharSet := DEFAULT_CHARSET;
    lfFaceName := '';
    lfPitchAndFamily := 0;
  end;
end;

procedure fcShowHint(Hint: string; Coord: TPoint);
var r: TRect;
begin
  with fcGetHintWindow do
  begin
    r := CalcHintRect(Screen.Width - Coord.x, Hint, nil);
    OffsetRect(r, Coord.x, Coord.y + 20);
    ActivateHint(r, Hint);
  end;
end;

procedure fcPaintGraphic(AGraphic: TGraphic; Modal: Boolean);
var ASize: TSize;
    Form: TForm;
begin
  ASize := fcSize(AGraphic.Width, AGraphic.Height);
  Form := TForm.Create(Application);
  with Form do
  begin
    Width := ASize.cx;
    Height := ASize.cy;
    Left := (Screen.Width - Width) div 2;
    Top := (Screen.Height - Height) div 2;
    with TImage.Create(Form) do
    begin
      Parent := Form;
      Align := alClient;
      Picture.Bitmap.Width := Width;
      Picture.Bitmap.Height := Height;
      Picture.Bitmap.Canvas.Draw(0, 0, AGraphic);
    end;
    if Modal then ShowModal else Show;
  end;
end;

// The following three functions are handy debugging functions to
// display a Canvas or Region.  Great for bitmaps and stuff. -ksw

procedure fcPaintCanvas(ACanvas: TCanvas; Modal: Boolean);
const SCALE = 2;
var ASize: TSize;
    Form: TForm;
begin
  ASize := fcSize(fcRectWidth(ACanvas.ClipRect), fcRectHeight(ACanvas.ClipRect));
  Form := TForm.Create(Application);
  with Form do
  begin
    Width := ASize.cx * SCALE;
    Height := ASize.cy * SCALE;
    Left := (Screen.Width - Width) div 2;
    Top := (Screen.Height - Height) div 2;
    with TImage.Create(Form) do
    begin
      Parent := Form;
      Align := alClient;
      Picture.Bitmap.Width := Width;
      Picture.Bitmap.Height := Height;
      Picture.Bitmap.Canvas.CopyRect(Rect(0, 0, ASize.cx, ASize.cy),
        ACanvas, Rect(0, 0, ASize.cx, ASize.cy));
    end;
    if Modal then ShowModal else Show;
  end;
end;

procedure fcPaintDC(DC: HDC; Modal: Boolean);
var ACanvas: TCanvas;
begin
  ACanvas := TCanvas.Create;
  ACanvas.Handle := DC;
  fcPaintCanvas(ACanvas, Modal);
  ACanvas.Handle := 0;
  ACanvas.Free;
end;

procedure fcPaintRegion(Rgn: HRGN; DoOffset: Boolean; ShowModal: Boolean);
const SCALE = 2;
var RgnData: PRgnData;
    Size: Integer;
    Offset: TPoint;
    RgnSize: TSize;
    i: Integer;
    ACanvas: TCanvas;
    r: TRect;
    Form: TForm;
begin
  Size := GetRegionData(Rgn, 0, nil);
  if Size = 0 then Exit;
  GetMem(RgnData, Size);
  try
    GetRegionData(Rgn, Size, RgnData);
    Offset := Point(0, 0);
    if DoOffset then Offset := RgnData^.rdh.rcBound.TopLeft;
    with RgnData^.rdh.rcBound.BottomRight do
    RgnSize := fcSize(x - Offset.x, y - Offset.y);

    Form := TForm.Create(Application);
    with Form do
    begin
      Width := RgnSize.cx * SCALE;
      Height := RgnSize.cy * SCALE;
      Left := (Screen.Width - Width) div 2;
      Top := (Screen.Height - Height) div 2;
      with TImage.Create(Form) do
      begin
        Parent := Form;
        Align := alClient;
        Picture.Bitmap.Width := Width;
        Picture.Bitmap.Height := Height;
        ACanvas := Picture.Bitmap.Canvas;
        ACanvas.Brush.Color := clRed;
      end;
    end;

    for i := 0 to RgnData^.rdh.nCount - 1 do
    begin
      r := PRect(Integer(@RgnData^.Buffer) + i * SizeOf(TRect))^;
      OffsetRect(r, -Offset.x, -Offset.y);
      ACanvas.FillRect(r);
    end;
    Form.ShowModal;
    Form.Free;
  finally
    FreeMem(RgnData);
  end;
end;

procedure fcGetChildRegions(Control: TWinControl; Transparent: Boolean; Rgn: HRGN; Offset: TPoint;
  Flags: Integer);
var TmpRgn: HRGN;
    i: Integer;
    r: TRect;
begin
  for i := 0 to Control.ControlCount - 1 do
  begin
    if Boolean(fcGetOrdProp(Control.Controls[i], 'Transparent')) then Continue;
//    RgnFlag := RGN_OR;
    if (Control.Controls[i] is TWinControl) then
    begin
      GetWindowRect(TWinControl(Control.Controls[i]).Handle, r);
      with Control.ClientToScreen(Point(0, 0)) do OffsetRect(r, -x, -y);
    end else begin
       r := Control.Controls[i].BoundsRect;
       if r.Right>Control.Width then r.Right:= Control.Width; { 5/2/99 - Limit to parent's boundaries }
       if r.Bottom>Control.Height then r.Bottom:= Control.Height
    end;

    OffsetRect(r, Offset.x, Offset.y);
    with r do TmpRgn := CreateRectRgn(Left, Top, Right, Bottom);
    CombineRgn(Rgn, Rgn, TmpRgn, Flags);
    DeleteObject(TmpRgn);

//    fcGetChildRegions(TWinControl(Control.Controls[i]), True, Rgn);
  end;
end;

// Changes the size and position of an array of controls from a
// beginning rect to an ending rect and animates the resizing/positioning.
//
// AnimateList - A TList of TAnimateListItem of each control to be
//               resized.  Each item contains an item consisting of
//               Control, OrigRect, and FinalRect; all of which must
//               be initialized to proper values.
//
// Interval    - The amount of time (in milliseconds) to pause between
//               each step of the resizing (length of each frame).
//
// Steps:      - The number of individual frames that the animation
//               will take.
//
// - ksw (12/10/98)

procedure fcAnimateControls(Control: TWinControl; ControlCanvas: TCanvas; AnimateList: TList; Interval: Integer; Steps: Integer; SetBoundsProc: TfcSetBoundsProc);
var FStep: Integer;
    Percent: Double;

{  procedure UpdateControls;
  var i: Integer;
      Rgn, TmpRgn: HRGN;
  begin
    Rgn := CreateRectRgn(0,0,0,0);
    for i := 0 to AnimateList.Count - 1 do with TfcGroupAnimateItem(AnimateList[i]), MainItem do
      begin
        Control.Update;
        with fcUnionRect(CurRect, Control.BoundsRect) do TmpRgn := CreateRectRgn(Left, Top, Right, Bottom);
        CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
        DeleteObject(TmpRgn);
      end;
    for i := 0 to AnimateList.Count - 1 do with TfcGroupAnimateItem(AnimateList[i]), MainItem do
    begin
      with Control.BoundsRect do TmpRgn := CreateRectRgn(Left, Top, Right, Bottom);
      CombineRgn(Rgn, Rgn, TmpRgn, RGN_DIFF);
      DeleteObject(TmpRgn);
    end;


    ValidateRect(Control.Handle, nil);
    InvalidateRgn(Control.Handle, Rgn, True);
    Control.Update;
    DeleteObject(Rgn);

    for i := 0 to AnimateList.Count - 1 do with TfcGroupAnimateItem(AnimateList[i]) do if SecondItem <> nil then with SecondItem do
      Control.Update;
  end;}

  procedure UpdateControls;
  var i: Integer;
      r: TRect;
  begin
    for i := 0 to AnimateList.Count - 1 do with TfcGroupAnimateItem(AnimateList[i]) do
      if SecondItem <> nil then
      begin
        r := SecondItem.Control.BoundsRect;
        ValidateRect(SecondItem.Control.Parent.Handle, @r);
      end;
    for i := 0 to AnimateList.Count - 1 do with TfcGroupAnimateItem(AnimateList[i]) do
    begin
      MainItem.Control.Invalidate;
      MainItem.Control.Update;
      if SecondItem <> nil then
      begin
        InvalidateRect(SecondItem.Control.Handle, nil, True);
        { RSW - 4/15/99 - Only invalidate portion of rectangle }
        if (SecondItem.Control.Top = SecondItem.CurRect.Top) and
           (SecondItem.Control.Left = SecondItem.CurRect.Left) {and
           ((SecondItem.Control.Height <= SecondItem.Currect.Bottom-SecondItem.Currect.Top) or
            (SecondItem.Control.Width <= SecondItem.Currect.Right-SecondItem.Currect.Left))}
           then
        begin
           r:= SecondItem.Currect;
           ValidateRect(SecondItem.Control.Parent.Handle, @r);
           SecondItem.Control.Update;
        end;
      end;
    end;
  end;

  procedure SetBounds(Item: TfcAnimateListItem);
  var R: TRect;
  begin
    with Item do
    begin
      CurRect := Control.BoundsRect;
      R := Rect(
        OrigRect.Left + Trunc((FinalRect.Left - OrigRect.Left) * Percent),
        OrigRect.Top + Trunc((FinalRect.Top - OrigRect.Top) * Percent),
        OrigRect.Right + Trunc((FinalRect.Right - OrigRect.Right) * Percent),
        OrigRect.Bottom + Trunc((FinalRect.Bottom - OrigRect.Bottom) * Percent)
      );
      if Assigned(SetBoundsProc) then SetBoundsProc(Control, R) else Control.BoundsRect := R;
    end;
  end;

  procedure Animate;
  var i: Integer;
  begin
    Percent := FStep / Steps;
    for i := 0 to AnimateList.Count - 1 do with TfcGroupAnimateItem(AnimateList[i]) do
    begin
      SetBounds(MainItem);
      if SecondItem <> nil then SetBounds(SecondItem);
    end;
  end;
begin
  if AnimateList.Count > 0 then for FStep := 1 to Steps do
  begin
    Animate;
//    if FStep=Steps then break; { 4/10/99 - RSW, let caller invalidate last time }
//                           { to take care of problem with non-rectangular regions being painted correctly }
    UpdateControls;
    Application.ProcessMessages;
    Sleep(Interval);
    Application.ProcessMessages;
  end;
end;
{
procedure fcAnimateControls(Control: TWinControl; ControlCanvas: TCanvas; AnimateList: TList; Interval: Integer; Steps: Integer; SetBoundsProc: TfcSetBoundsProc);
var FStep: Integer;
    Percent: Double;

  procedure UpdateControls;
  var i: Integer;
      Rgn, TmpRgn: HRGN;
      FirstRect, LastRect: TRect;
  begin
    with TfcGroupAnimateItem(AnimateList[0]).MainItem do FirstRect := fcUnionRect(CurRect, Control.BoundsRect);
    with TfcGroupAnimateItem(AnimateList[AnimateList.Count - 1]).MainItem do LastRect := fcUnionRect(CurRect, Control.BoundsRect);
    with fcUnionRect(FirstRect, LastRect) do Rgn := CreateRectRgn(Left, Top, Right, Bottom);

    for i := 0 to AnimateList.Count - 1 do with TfcGroupAnimateItem(AnimateList[i]), MainItem do
      begin
        Control.Update;
        with Control.BoundsRect do TmpRgn := CreateRectRgn(Left, Top, Right, Bottom);
        CombineRgn(Rgn, Rgn, TmpRgn, RGN_DIFF);
        DeleteObject(TmpRgn);
      end;

    ValidateRect(Control.Handle, nil);
    InvalidateRgn(Control.Handle, Rgn, True);
    Control.Update;
    DeleteObject(Rgn);

    for i := 0 to AnimateList.Count - 1 do with TfcGroupAnimateItem(AnimateList[i]) do if SecondItem <> nil then with SecondItem do
      Control.Update;
  end;

  procedure SetBounds(Item: TfcAnimateListItem);
  var R: TRect;
  begin
    with Item do
    begin
      CurRect := Control.BoundsRect;
      R := Rect(
        OrigRect.Left + Trunc((FinalRect.Left - OrigRect.Left) * Percent),
        OrigRect.Top + Trunc((FinalRect.Top - OrigRect.Top) * Percent),
        OrigRect.Right + Trunc((FinalRect.Right - OrigRect.Right) * Percent),
        OrigRect.Bottom + Trunc((FinalRect.Bottom - OrigRect.Bottom) * Percent)
      );
      if Assigned(SetBoundsProc) then SetBoundsProc(Control, R) else Control.BoundsRect := R;
    end;
  end;

  procedure Animate;
  var i: Integer;
  begin
    Percent := FStep / Steps;
    for i := 0 to AnimateList.Count - 1 do with TfcGroupAnimateItem(AnimateList[i]) do
    begin
      SetBounds(MainItem);
      if SecondItem <> nil then SetBounds(SecondItem);
    end;
  end;
begin
  if AnimateList.Count > 0 then for FStep := 1 to Steps do
  begin
    Animate;
    UpdateControls;
    Application.ProcessMessages;
    Sleep(Interval);
    Application.ProcessMessages;
  end;
end;
}
function fcWithInteger(Value: Integer): TfcInteger;
begin
  result.Value := Value;
end;

function fcCombineRect(r1, r2: TRect): TRect;
begin
  result := Rect(
    fcMin(r1.Left, r2.Left),
    fcMin(r1.Top, r2.Top),
    fcMax(r1.Right, r2.Right),
    fcMax(r1.Bottom, r2.Bottom)
  );
end;

procedure fcClipBitmapToRegion(Bitmap: TfcBitmap; Rgn: HRGN);
var RectRgn: HRGN;
begin
  RectRgn := CreateRectRgn(0, 0, Bitmap.Width, Bitmap.Height);
  try
    if CombineRgn(RectRgn, RectRgn, Rgn, RGN_DIFF) <> ERROR then
    begin
      Bitmap.Canvas.Brush.Color := Bitmap.TransparentColor;
      FillRgn(Bitmap.Canvas.Handle, RectRgn, Bitmap.Canvas.Brush.Handle);
    end;
  finally
    DeleteObject(RectRgn);
  end;
end;

function fcRGBToBGR(Color: TColor): TColor;
begin
  result := 0;
  result := result or ((Color and $00FF0000) shr 16);
  result := result or (Color and $0000FF00);
  result := result or ((Color and $000000FF) shl 16);
end;

function EnumChildProc(hwnd: HWND; lParam: LPARAM): Boolean; stdcall;
begin
  fcInvalidateChildren(hwnd);
  result := True;
end;

procedure fcInvalidateChildren(Control: HWND);
begin
  InvalidateRect(Control, nil, False);
  EnumChildWindows(Control, @EnumChildProc, 0);
end;

function fcGetWindowRect(Wnd: HWND): TRect;
begin
  GetWindowRect(Wnd, result);
end;

function fcUnionRect(R1, R2: TRect): TRect;
begin
  UnionRect(result, R1, R2);
end;

function fcIntersectRect(R1, R2: TRect): TRect;
begin
  IntersectRect(result, r1, r2);
end;

function fcRectEmpty(r: TRect): Boolean;
begin
  result := EqualRect(r, Rect(0, 0, 0, 0));
end;

function InvalidateOverlappedProc(Child: HWND; ARect: PRect): Boolean; stdcall;
begin
  if not fcRectEmpty(fcIntersectRect(ARect^, fcGetWindowRect(Child))) then
    fcInvalidateChildren(Child);
  result := True;
end;

procedure fcInvalidateOverlappedWindows(ParentHwnd: HWND; FirstChild: HWND);
var ControlRect: TRect;
begin
  GetWindowRect(FirstChild, ControlRect);
  EnumChildWindows(ParentHWND, @InvalidateOverlappedProc, Integer(@ControlRect));
end;

procedure fcParentInvalidate(Control: TControl; Erase: Boolean);
var r: TRect;
begin
  r := Control.BoundsRect;
  if Control.Parent <> nil then
    InvalidateRect(Control.Parent.Handle, @r, Erase);
end;

procedure fcPaintTo(Control: TWinControl; Canvas: TCanvas; X, Y: Integer);
{var OldTop: UINT;
    DC: HDC;}
var i: Integer;
begin
  SendMessage(Control.Handle, WM_ERASEBKGND, Canvas.Handle, 0);
  SendMessage(Control.Handle, WM_PAINT, Canvas.Handle, 0);

  for i := 0 to Control.ControlCount - 1 do if Control.Controls[i] is TWinControl then
    fcPaintTo(Control.Controls[i] as TWinControl, Canvas, Control.Controls[i].Left, Control.Controls[i].Top);  
{  OldTop := $FFFFFFFF;
  if not Control.Visible then
  begin
    OldTop := Control.Top;
    Control.Top := -Control.Height;
    Control.Visible := True;
  end;

  DC := GetWindowDC(Control.Handle);
  BitBlt(Canvas.Handle, 0, 0, Control.Width, Control.Height,
    DC, 0, 0, SRCCOPY);
  ReleaseDC(Control.Handle, DC);

  if OldTop <> $FFFFFFFF then
  begin
    Control.Top := OldTop;
    Control.Visible := False;
  end;}
end;

procedure fcBufferredAnimation(ControlCanvas: TCanvas; AnimateList: TList; Interval: Integer; Steps: Integer);
var FStep: Integer;
  procedure Animate;
  var i: Integer;
      Percent: Double;
  begin
    Percent := FStep / Steps;
    for i := 0 to AnimateList.Count - 1 do with TfcAnimateListItem(AnimateList[i]) do
    begin
      CurRect := Rect(
        OrigRect.Left + Trunc((FinalRect.Left - OrigRect.Left) * Percent),
        OrigRect.Top + Trunc((FinalRect.Top - OrigRect.Top) * Percent),
        OrigRect.Right + Trunc((FinalRect.Right - OrigRect.Right) * Percent),
        OrigRect.Bottom + Trunc((FinalRect.Bottom - OrigRect.Bottom) * Percent)
      );
      ControlCanvas.StretchDraw(CurRect, Bitmap);
    end;
  end;
var i: Integer;
begin
  for i := 0 to AnimateList.Count - 1 do
    with TfcAnimateListItem(AnimateList[i]) do
    begin
      Bitmap := TBitmap.Create;
      Bitmap.Width := Control.Width;
      Bitmap.Height := Control.Height;
      fcPaintTo(Control, Bitmap.Canvas, 0, 0);
//      SendMessage(Control.Handle, WM_PAINT, Bitmap.Canvas.Handle, 0);
//      fcPaintCanvas(Bitmap.Canvas, True);
    end;
  if AnimateList.Count > 0 then for FStep := 1 to Steps do
  begin
    Animate;
    Application.ProcessMessages;
    Sleep(Interval);
    Application.ProcessMessages;
  end;
  for i := 0 to AnimateList.Count - 1 do
    with TfcAnimateListItem(AnimateList[i]) do
      Bitmap.Free;
end;

function fcHighestRGBVal(Color: TColor): BYTE;
var Colors: TRGBQuad;
begin
  with Colors do
  begin
    fcColorToByteValues(Color, rgbReserved, rgbBlue, rgbGreen, rgbRed);
    result := rgbRed;
    if rgbBlue > result then result := rgbBlue;
    if rgbGreen > result then result := rgbGreen;
  end;
end;

const
  DSx =     $00660046;
  DSna =    $00220326;

procedure fcDrawMask(Canvas: TCanvas; ARect: TRect; Bitmap, Mask: TBitmap;
  Buffer: Boolean);
var oldBkColor, oldTextColor: COLORREF;
    dcCompat: HDC;
    pbmpSave: HBITMAP;
    ABitmap: TBitmap;
    UseCanvas: TCanvas;
    Offset: TPoint;
begin
  oldBkColor := SetBkColor(Canvas.Handle, RGB(255, 255, 255));
  oldTextColor := SetTextColor(Canvas.Handle, RGB(0, 0, 0));

  ABitmap := nil;

  if Buffer then
  begin
    ABitmap := TBitmap.Create;
    ABitmap.Width := fcRectWidth(ARect);
    ABitmap.Height := fcRectHeight(ARect);
    ABitmap.Canvas.CopyRect(Rect(0, 0, ABitmap.Width, ABitmap.Height), Canvas, ARect);
    UseCanvas := ABitmap.Canvas;
    Offset := Point(0, 0);
  end else begin
    UseCanvas := Canvas;
    Offset := ARect.TopLeft;
  end;

  dcCompat := CreateCompatibleDC(Canvas.Handle);
  pbmpSave := SelectObject(dcCompat, Bitmap.Handle);
  BitBlt(UseCanvas.Handle, Offset.x, Offset.y, fcRectWidth(ARect), fcRectHeight(ARect), dcCompat, 0, 0, DSx);
  SelectObject(dcCompat, Mask.Handle);
  BitBlt(UseCanvas.Handle, Offset.x, Offset.y, fcRectWidth(ARect), fcRectHeight(ARect), dcCompat, 0, 0, DSna);
  SelectObject(dcCompat, Bitmap.Handle);
  BitBlt(UseCanvas.Handle, Offset.x, Offset.y, fcRectWidth(ARect), fcRectHeight(ARect), dcCompat, 0, 0, DSx);
  SelectObject(dcCompat, pbmpSave);
  DeleteDC(dcCompat);

  if Buffer then
  begin
    Canvas.CopyRect(ARect, ABitmap.Canvas, Rect(0, 0, ABitmap.Width, ABitmap.Height));
    ABitmap.Free;
  end;

  SetBkColor(Canvas.Handle, oldBkColor);
  SetTextColor(Canvas.Handle, oldTextColor);
end;

function fcProportionalRect(OrigRect: TRect; Width, Height: Integer): TRect;
begin
  with OrigRect do
    if (Width / (Right - Left)) > (Height / (Bottom - Top)) then
      result := Rect(Left, Top, Left + fcRectWidth(OrigRect),
        Top + (Height * fcRectWidth(OrigRect) div Width))
    else result := Rect(Left, Top, Left + (Width *
      fcRectHeight(OrigRect) div Height), fcRectHeight(OrigRect));
end;

{ Return true if ComCtl is later than 4.70 }
function fcUpdatedComCtlVersion: boolean;
var dummy: DWORD;
    verInfoSize, verValueSize: DWORD;
    verInfo: Pointer;
    verValue: PVSFixedFileInfo;
    V1,V2: WORD;
begin
   verInfoSize:= GetFileVersionInfoSize('comctl32.dll', Dummy);
   if VerInfoSize = 0 then
   begin
      Dummy:= GetLastError;
      result:= True;
      exit;
   end;

   GetMem(VerInfo, VerInfoSize);
   GetFileVersionInfo('comctl32.dll', 0, VerInfoSize, VerInfo);
   VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
   with VerValue^ do begin
      V1:= dwFileVersionMS shr 16;
      V2:= dwFileVersionMS and $FFFF;
   end;
   result:= (v1>=4) and (v2>70);
   FreeMem(VerInfo, VerInfoSize);

end;

procedure fcPatternFill(Pattern: Pointer; SizeOfPat: Integer; Dst: Pointer; SizeOfDst: Integer);
var i: Integer;
begin
  for i := 0 to SizeOfDst div SizeOfPat do
    CopyMemory(Dst, Pattern, SizeOfPat);
  if SizeOfDst mod SizeOfPat > 0 then
    CopyMemory(Dst, Pattern, SizeOfDst mod SizeOfPat);
end;

type TMyControl = class(TWinControl);

procedure fcMakePagesResourceFriendly(PageControl: TPageControl);
var i, j: Integer;
begin
  with PageControl do
    for i := 0 to PageCount - 1 do
    begin
      if not Pages[i].Visible then
      begin
        for j := 0 to Pages[i].ControlCount - 1 do
          if Pages[i].Controls[j] is TWinControl then
            TMyControl(Pages[i].Controls[j]).DestroyHandle;
      end;
    end;
end;

procedure fcCreateDisabledBitmap(SrcBm, DstBm: TBitmap);
const ROP_DSPDxax = $00E20746;
var AMonoBitmap: TBitmap;
    ARect: TRect;
    AWidth, AHeight: Integer;
begin
  AMonoBitmap := TBitmap.Create;
  with AMonoBitmap do
  begin
    Monochrome := True;
    Width := SrcBm.Width;
    Height := SrcBm.Height;
  end;
  AWidth := SrcBm.Width;
  AHeight := SrcBm.Height;
  ARect := Rect(0, 0, AWidth, AHeight);

  if DstBm.Width <> SrcBm.Width then DstBm.Width := SrcBm.Width;
  if DstBm.Height <> SrcBm.Height then DstBm.Height := SrcBm.Height;

  try
    with AMonoBitmap do
    begin
      Assign(SrcBm);
      HandleType := bmDDB;
      Canvas.Brush.Color := clBlack;
      Width := SrcBm.Width;
      if Monochrome then
      begin
        Canvas.Font.Color := clWhite;
        Monochrome := False;
        Canvas.Brush.Color := clWhite;
      end;
      Monochrome := True;
    end;
    with DstBm.Canvas do
    begin
      Brush.Color := clBtnFace;
      FillRect(ARect);
      Brush.Color := clBtnHighlight;
      SetTextColor(Handle, clBlack);
      SetBkColor(Handle, clWhite);
      BitBlt(Handle, 1, 1, AWidth, AHeight, AMonoBitmap.Canvas.Handle, 0, 0, ROP_DSPDxax);
      Brush.Color := clBtnShadow;
      SetTextColor(Handle, clBlack);
      SetBkColor(Handle, clWhite);
      BitBlt(Handle, 0, 0, AWidth, AHeight, AMonoBitmap.Canvas.Handle, 0, 0, ROP_DSPDxax);
    end;
  finally
    AMonoBitmap.Free;
  end;
end;

procedure fcDrawEllipsis(Canvas: TCanvas; R: TRect; State: TButtonState;
    Enabled: Boolean; ControlState: TControlState);
var Flags: Integer;
    DC: HDC;
    w: integer;
    LeftIndent, TopIndent: integer;
begin
  Flags:= 0;
  if (State = bsDown) and not (csPaintCopy in ControlState) then
    Flags := BF_FLAT;
  DC:= Canvas.Handle;
  DrawEdge(DC, R, EDGE_RAISED, BF_RECT or BF_MIDDLE or Flags);
  LeftIndent:= ((R.Right - R.Left) shr 1) - 1 + Ord(State=bsDown);
  TopIndent:= ((R.Bottom+1-R.Top) shr 1) - 1 + Ord(State=bsDown);
  W := (R.Right+1 - R.Left) shr 3;
  if W = 0 then W := 1;
  PatBlt(DC, R.Left + LeftIndent, R.Top + TopIndent, W, W, BLACKNESS);
  PatBlt(DC, R.Left + LeftIndent - (W * 2), R.Top + TopIndent, W, W, BLACKNESS);
  PatBlt(DC, R.Left + LeftIndent + (W * 2), R.Top + TopIndent, W, W, BLACKNESS);
end;

procedure fcDrawDropDownArrow(Canvas: TCanvas; R: TRect;
    State: TButtonState; Enabled: Boolean; ControlState: TControlState);
var Flags: Integer;
begin
  if not Enabled then Flags := DFCS_SCROLLCOMBOBOX or DFCS_INACTIVE
  else if (State=bsUp) or (csPaintCopy in ControlState) then
    Flags := DFCS_SCROLLCOMBOBOX
  else Flags := DFCS_SCROLLCOMBOBOX or DFCS_FLAT or DFCS_PUSHED;
  DrawFrameControl(Canvas.Handle, R, DFC_SCROLL, Flags);
end;

function fcExecuteColorDialog(AColor: TColor): TColor;
begin
  with TColorDialog.Create(Application) do
  begin
    Color := AColor;
    Execute;
    result := Color;
    Free;
  end;
end;

function fcComponentFromString(Root: TComponent; Value: string): TComponent;
var i: Integer;
begin
  result := Root;

  for i := 0 to fcCountTokens(Value, '.') - 1 do
  begin
    result := result.FindComponent(fcGetToken(Value, '.', i));
    if result = nil then Break;
  end;
  if result = Root then result := nil;
end;

function fcStringFromComponent(Root: TComponent; Value: TComponent): string;
begin
  result := '';
  while not (Value = Root) do
  begin
    if result <> '' then result := '.' + result;
    result := Value.Name + result;
    Value := Value.Owner;
  end;
end;

procedure fcCalcButtonLayout(TopLeft: TPoint; TextRect, GlyphRect: PRect;
  TextSize, GlyphSize: TSize; Layout: TButtonLayout;
  Spacing: Integer);

  function GetPoint(OffsetX: TfcPointSets; OffsetY: TfcPointSets;
    OffsetSize: TSize): TPoint;
  begin
    result := Point(
      TopLeft.x - (GlyphSize.cx * ord(psGlyph in OffsetX) +
        TextSize.cx * ord(psText in OffsetX) +
        Spacing * ord([psGlyph, psText] * OffsetX = [psGlyph, psText])) div 2 +
        ord(psOffset in OffsetX) * (OffsetSize.cx + Spacing),
      TopLeft.y - ((GlyphSize.cy + 1) * ord(psGlyph in OffsetY) +
        TextSize.cy * ord(psText in OffsetY) +
        Spacing * ord([psGlyph, psText] * OffsetY = [psGlyph, psText])) div 2 +
        ord(psOffset in OffsetY) * (OffsetSize.cy + Spacing)
    );
  end;
  procedure SetPoints(OffsetTX: TfcPointSets; OffsetTY: TfcPointSets;
    OffsetGX: TfcPointSets; OffsetGY: TfcPointSets);
  begin
    if TextRect <> nil then with GetPoint(OffsetTX, OffsetTY, GlyphSize) do
      TextRect^ := Rect(x, y, x + TextSize.cx, y + TextSize.cy);
    if GlyphRect <> nil then with GetPoint(OffsetGX, OffsetGY, TextSize) do
      GlyphRect^ := Rect(x, y, x + GlyphSize.cx, y + GlyphSize.cy);
  end;
begin
  if (GlyphSize.cy=0) or (GlyphSize.cx=0) then Spacing := (Spacing-6) div 2; { 4/14/99 - RSW - Center text if no image } {??? why "6"? -ksw}

  case Layout of
    blGlyphLeft: SetPoints([psGlyph, psText, psOffset], [psText], [psGlyph, psText], [psGlyph]);
    blGlyphTop: SetPoints([psText], [psGlyph, psText, psOffset], [psGlyph], [psGlyph, psText]);
    blGlyphRight: SetPoints([psGlyph, psText], [psText], [psGlyph, psText, psOffset], [psGlyph]);
    blGlyphBottom: SetPoints([psText], [psGlyph, psText], [psGlyph], [psGlyph, psText, psOffset]);
  end;
end;

function fcGetRegionData(Rgn: HRGN): string;
var RgnData: PRgnData;
    Size: Integer;
    i: Integer;
begin
  result := '';
  Size := GetRegionData(Rgn, 0, nil);
  if Size = 0 then Exit;
  GetMem(RgnData, Size);
  try
    GetRegionData(Rgn, Size, RgnData);

    for i := 0 to RgnData^.rdh.nCount - 1 do
      with PRect(Integer(@RgnData^.Buffer) + i * SizeOf(TRect))^ do
        result := result + InttoStr(i + 1) + ': (' + InttoStr(Left) + ', ' + InttoStr(Top) + ', ' + InttoStr(Right) + ', ' + InttoStr(Bottom) + '), ';
  finally
    FreeMem(RgnData);
  end;
end;

function fcGetDitherBrush: HBRUSH;
var hatchPattern: array[0..7] of WORD;
    i: Integer;
    hatchBitmap: HBITMAP;
begin
  for i := 0 to 7 do if i mod 2 = 0 then hatchPattern[i] := $AAAA else hatchPattern[i] := $5555;
  hatchBitmap := CreateBitmap(8, 8, 1, 1, @hatchPattern);
  result := CreatePatternBrush(hatchBitmap);
  DeleteObject(hatchBitmap);
end;

procedure fcDither(ACanvas: TCanvas; Rect: TRect; Color1, Color2: TColor);
var TempBitmap: TfcBitmap;
    ABrush, OldBrush: HBRUSH;
begin
  if Color2 = clNone then raise EInvalidOperation.Create('Color2 cannot be clNone');

  if (Color1 <> clNone) then
  begin
    ABrush := fcGetDitherBrush;
    SetTextColor(ACanvas.Handle, ColorToRGB(Color2));
    SetBkColor(ACanvas.Handle, ColorToRGB(Color1));
    OldBrush := SelectObject(ACanvas.Handle, ABrush);
    FillRect(ACanvas.Handle, Rect, ABrush);
    SelectObject(ACanvas.Handle, OldBrush);
    DeleteObject(ABrush);
  end else begin
    TempBitmap := TfcBitmap.Create;
    try
      TempBitmap.SetSize(fcRectWidth(Rect), fcRectHeight(Rect));
      Color1 := GetNearestColor(TempBitmap.Canvas.Handle, $00FFFFFF and (not Color2));
      fcDither(TempBitmap.Canvas, Rect, Color1, Color2);
      fcTransparentDraw(ACanvas, Rect, TempBitmap, TempBitmap.Canvas.Pixels[0, 0]);
    finally
      TempBitmap.Free;
    end;
  end;
end;

procedure fcTileDraw(Source: TGraphic; Dest: TCanvas; DstRect: TRect);
var x, y: Integer;
begin
  x := 0; 
  while x < fcRectWidth(DstRect) do
  begin
    y := 0;
    while y < fcRectHeight(dstRect) do
    begin
      Dest.Draw(x, y, Source);
      inc(y, Source.Height);
    end;
    inc(x, Source.Width);
  end;
end;

function fcFindGlobalComponent(const Name: string): TComponent;
var
  I: Integer;
begin
  for I := 0 to Screen.FormCount - 1 do
  begin
    Result := Screen.Forms[I];
    if CompareText(Name, Result.Name) = 0 then Exit;
  end;
  for I := 0 to Screen.DataModuleCount - 1 do
  begin
    Result := Screen.DataModules[I];
    if CompareText(Name, Result.Name) = 0 then Exit;
  end;
  Result := nil;
end;

procedure fcHelp(Handle: HWND; HelpTopic: PChar);
var HelpFile: string;
    Context: array[0..127] of Char;
begin
  HelpFile := '1stClass';
  {$ifdef ver100}HelpFile := '1stClass_D3.hlp';{$endif}
  {$ifdef ver110}HelpFile := '1stClass_C3.hlp';{$endif}
  {$ifdef ver120}HelpFile := '1stClass_D4.hlp';{$endif}
  {$ifdef ver125}HelpFile := '1stClass_C4.hlp';{$endif}
  StrCopy(Context, HelpTopic);
  WinHelp(Handle, PChar(HelpFile), HELP_KEY, LPARAM(@Context));
end;

{$r+}
begin
  fcVersion1stClass:= '1.01C';
end.
