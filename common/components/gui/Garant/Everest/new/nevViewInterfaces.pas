unit nevViewInterfaces;

{$Include ..\new\nevDefine.inc}

interface

uses
  Types,
  Graphics,
  l3Interfaces,
  l3Types,
  l3Core,
  l3Units,
  l3InternalInterfaces,
  nevBase,
  nevTools
  ;

type
 HnevView = {$IfDef XE4}record{$Else}object{$EndIf}
  {* Обёртка над InevView }
 private
  f_InevView : InevView;
 {$IfDef XE4}private{$Else}protected{$EndIf}
 // realized methods
   function pm_GetMetrics: InevViewMetrics;
   function Get_ActiveElement: InevActiveElement;
   function Get_ForceDrawFocusRect: Boolean;
   function Get_IsObjectCollapsed(const anObject: InevObject): Boolean;
   procedure Set_IsObjectCollapsed(const anObject: InevObject; aValue: Boolean);
 public
 // realized methods
   function Data: InevObject;
   function RootMap: InevMap;
   function Processor: InevProcessor;
   procedure ClearShapes;
   procedure BeginDrawShape(const aShape: InevObject;
    const anAnchor: InevBasePoint;
    const anOrg: TnevPoint;
    var theMap: InevMap;
    aFake: Boolean;
    const aHacker: InevK235870994Hacker);
     {* Начинает добавление формы в список. }
   procedure EndDrawShape;
     {* Заканчивает добавление формы в список. }
   function MapByPoint(const aPoint: InevBasePoint;
    aCheckTopVisible: Boolean = False): InevMap;
   function FormatInfoByPoint(const aPoint: InevBasePoint): TnevFormatInfoPrim;
   function RootFormatInfo: TnevFormatInfoPrim;
   procedure InvalidateShape(const aShape: InevObject;
    aParts: TnevShapeParts);
   {$If defined(evNeedCollapsedVersionComments)}
   procedure VersionInfoVisabilityChanged(aValue: Boolean);
   {$IfEnd} //evNeedCollapsedVersionComments
   function FormatInfoByPara(const aPara: InevObject): TnevFormatInfoPrim; overload; 
   function FormatInfoByObj(const anObj: InevObjectPrim): TnevFormatInfoPrim;
   function FormatInfoByPara(aPara: PInevObject): TnevFormatInfoPrim; overload; 
 public
   property Metrics: InevViewMetrics
     read pm_GetMetrics;
   property ActiveElement: InevActiveElement
     read Get_ActiveElement;
     {* Активный элемент (тот в котором находится мышь) }
   property ForceDrawFocusRect: Boolean
     read Get_ForceDrawFocusRect;
     {* Форсировать ли рисование рамки у текущего параграфа редактора }
   property IsObjectCollapsed[const anObject: InevObject]: Boolean
     read Get_IsObjectCollapsed
     write Set_IsObjectCollapsed;
 {$IfNDef XE4}
 private
   procedure Fake; virtual; // - это нужно чтобы правильно генерировались вызовы методов доступа к свойствам
 {$EndIf XE4}
 public
   constructor Init(const anIntf: InevView);
 public
   function IsValid: Boolean;
   procedure Free;
   property As_InevView: InevView read f_InevView;
 end;//HnevView

 Hl3Canvas = {$IfDef XE4}record{$Else}object{$EndIf}
  {* Обёртка для Il3Canvas }
 private
  f_Il3Canvas : Il3Canvas;
 {$IfDef XE4}private{$Else}protected{$EndIf}
 // realized methods
   function Get_Font: Il3Font;
   procedure Set_Font(const aValue: Il3Font);
   function pm_GetDC: hDC;
   procedure pm_SetDC(aValue: hDC);
   function pm_GetPixelsPerInchX: Integer;
   function pm_GetPixelsPerInchY: Integer;
   function pm_GetWindowOrg: Tl3Point;
   procedure pm_SetWindowOrg(const aValue: Tl3Point);
   function pm_GetSWindowOrg: Tl3SPoint;
   procedure pm_SetSWindowOrg(const aValue: Tl3SPoint);
   function pm_GetClipRect: Tl3Rect;
   procedure pm_SetClipRect(const aValue: Tl3Rect);
   function pm_GetGlobalClipRect: Tl3Rect;
   function pm_GetBackColor: Tl3Color;
   procedure pm_SetBackColor(aValue: Tl3Color);
   function pm_GetDrawEnabled: Boolean;
   procedure pm_SetDrawEnabled(aValue: Boolean);
   function pm_GetDrawSpecial: Boolean;
   function pm_GetCanDrawSubs: Boolean;
   function pm_GetShowCursor: Boolean;
   procedure pm_SetShowCursor(aValue: Boolean);
   function pm_GetFontIndexSet: Tl3FontIndexes;
   procedure pm_SetFontIndexSet(aValue: Tl3FontIndexes);
   function pm_GetPrinted: Boolean;
   procedure pm_SetPrinted(aValue: Boolean);
   function pm_GetPageNumber: Integer;
   function pm_GetPageWidthNumber: Integer;
   function pm_GetPenWidth: Integer;
   function pm_GetPageOrientation: Tl3PageOrientation;
   procedure pm_SetPageOrientation(aValue: Tl3PageOrientation);
   function pm_GetSectionExtent: Tl3Point;
   procedure pm_SetSectionExtent(const aValue: Tl3Point);
   procedure pm_SetNotFocused(aValue: Boolean);
   function pm_GetRegionBottomRight: Tl3Point;
   function Get_PasswordChar: AnsiChar;
   procedure Set_PasswordChar(aValue: AnsiChar);
   function Get_EffectiveColors: Il3EffectiveColors;
   function pm_GetPrinting: Boolean;
   function pm_GetZoom: Integer;
   procedure pm_SetZoom(aValue: Integer);
   function pm_GetPageSetup: Il3PageSetup;
   procedure pm_SetPainter(const aValue: Il3HAFPainter);
   function pm_GetCanvas: TCanvas;
   function Get_IsPagesCounter: Boolean;
   function Get_OverallPageNumber: Integer;
   function Get_InitialDCOffset: Tl3Point;
   procedure Set_ClipRegion(const aValue: Il3Region);
   function Get_LineSpacing: Integer;
   procedure Set_LineSpacing(aValue: Integer);
   function pm_GetInvert: Boolean;
   function Get_InitialDCOffsetStored: Tl3Point;
   function pm_GetFrameLines: Il3FrameLines;
   function Get_AbortChecker: Il3AbortChecker;
   procedure Set_AbortChecker(const aValue: Il3AbortChecker);
 public
 // realized methods
   function PxAverageCharWidth: Integer;
     {* средняя ширина символов контекста в пикселях. }
   function AverageCharWidth: Integer;
     {* средняя ширина символов контекста в дюймах. }
   function TextExtent(const S: Tl3WString;
    aNoTabs: Boolean = false): Tl3Point;
     {* возвращает длину строки текста в дюймах. }
   function Pos2Index(W: Integer;
    const S: Tl3PCharLen): Integer;
     {* находит индекс символа на рассоянии W дюймов от начала строки S. }
   function Pos2IndexQ(W: Integer;
    const S: Tl3PCharLen;
    var aNoTabs: Boolean): Integer;
     {* находит индекс символа на рассоянии W дюймов от начала строки S. }
   function AverageCharHeight: Integer;
     {* средняя высота символов контекста в дюймах. }
   function LP2DP(const P: Tl3_Point;
    NeedZoom: Boolean = false): Tl3SPoint;
     {* преобразует точку в дюймах в точку в пикселях. }
   function LR2DR(const R: Tl3Rect): Tl3SRect;
     {* преобразует прямоугольник в дюймах в прямоугольник в пикселях. }
   function DR2LR(const R: Tl3SRect): Tl3Rect;
     {* преобразует прямоугольник в пикселях в прямоугольник в дюймах. }
   procedure Lock;
     {* начать работу с канвой. }
   procedure Unlock;
     {* закончить работу с канвой. }
   function GetKerning(const aSt: Tl3WString;
    Kerning: PLong): Tl3Point;
     {* получить размеры строки и таблицу кернинга. }
   function OffsetRgn(const Rgn: Il3Region;
    const Pt: Tl3Point): Integer;
     {* сдвинуть регион. }
   function CaretExtent: Tl3Point;
     {* размеры курсора. }
   procedure StartTabs(out theTabInfo: Il3TabInfo;
    const aTabStops: Il3TabStops;
    aTabOffset: Integer = 0); overload; 
   procedure StartTabs(out theTabInfo: Il3TabInfo;
    const aTabInfo: Il3TabInfo); overload; 
   procedure FinishTabs(var aTabInfo: Il3TabInfo);
   function TabInfo: Il3TabInfo;
   function EQ(const aCanvas: Il3InfoCanvas): Boolean;
   function NearestColor(C: Tl3Color): Tl3Color;
   function DrawText(const aSt: Tl3WString;
    var R: TRect;
    aFormat: Cardinal;
    AFl: TObject = nil): Il3MultiLines;
     {* как ни глупо звучит, но это нужно на информационной канве, т.к. она вычисляет прямоугольник вывода. }
   procedure TabbedMultilineTextOut(const aSt: Tl3WString;
    const Tabs: Il3TabStops;
    var Rect: Tl3Rect;
    Precalculate: Boolean;
    aGap: Integer);
     {* как ни глупо звучит, но это нужно на информационной канве, т.к. она вычисляет прямоугольник вывода. }
   procedure PushBC;
   function TopBC: Tl3Color;
   procedure PopBC;
   procedure PushFC;
   procedure PopFC;
   function TextMetrics: PTextMetric;
   procedure MoveWindowOrg(const Delta: Tl3Point); overload; 
   procedure MoveWindowOrg(const Delta: Tl3SPoint); overload; 
   procedure FillForeRect(const R: Tl3SRect);
   procedure FillRect(const R: Tl3SRect); overload; 
   procedure FillRect(const R: Tl3Rect); overload; 
   procedure FillEmptyRect(const R: Tl3Rect); overload; 
   procedure FillEmptyRect(const R: Tl3SRect); overload; 
   function FillRgn(const Region: Il3Region): Boolean;
   function TextOut(const P: Tl3Point;
    const S: Tl3PCharLen;
    FC: Tl3Color = clDefault;
    BC: Tl3Color = clDefault): Tl3Point;
   procedure SetCaret(const Origin: Tl3Point;
    const Extent: Tl3Point;
    Hidden: Boolean = false);
   procedure IncCaret(aDeltaX: Integer);
   procedure BeginPaint;
   procedure StartObject(anObjectID: Integer);
   procedure SetPageTop;
   procedure EndPaint;
   procedure BeginInvert;
   procedure EndInvert;
   function DrawRgnOrBlock: Boolean;
   function HasToDraw: Boolean;
   procedure StretchDraw(const R: Tl3Rect;
    Graphic: VCLGraphic);
   procedure DrawSub(aSubTarget: TObject;
    const R: Tl3Rect;
    LayerHandle: Integer;
    aSub: TObject);
   procedure ExtTextOut(const P: Tl3Point;
    const R: Tl3Rect;
    const S: Tl3WString;
    F: Tl3TextFormatFlag = l3_tffLeft;
    Dx: PInteger = nil); overload; 
   procedure ExtTextOut(const P: Tl3SPoint;
    const R: Tl3SRect;
    const S: Tl3WString;
    F: Tl3TextFormatFlag = l3_tffLeft;
    Dx: PInteger = nil); overload; 
   function CaretLineOut(const aSt: Tl3WString;
    LineHeight: Integer;
    aHidden: Boolean;
    var CaretPos: Integer): Tl3Point;
     {* выводит строку текста высотой LineHeight, со сдвигом курсора отрисовки. устанавливает курсор в CaretPos. возвращает размеры выведенной строки. }
   function StringOut(const P: Tl3Point;
    const Text: Tl3WString): Tl3Point;
   procedure TabbedTextOut(const P: Tl3Point;
    const R: Tl3Rect;
    const S: Tl3WString;
    const aTabStops: Il3TabStops); overload; 
   procedure TabbedTextOut(const P: Tl3SPoint;
    const R: Tl3SRect;
    const S: Tl3WString;
    const aTabStops: Il3TabStops); overload; 
   function NewPage(ByWidth: Boolean = false): Boolean;
     {* начать новую страницу. }
   procedure Line(const A: Tl3Point;
    const B: Tl3Point); overload; 
     {* нарисовать линию. }
   procedure Line(const A: Tl3SPoint;
    const B: Tl3SPoint); overload; 
     {* нарисовать линию. }
   procedure MoveTo(const Pt: Tl3Point); overload; 
   procedure LineTo(const Pt: Tl3Point); overload; 
   procedure MoveTo(const Pt: Tl3SPoint); overload; 
   procedure LineTo(const Pt: Tl3SPoint); overload; 
   function WO(const aRect: Tl3Rect): Tl3SRect; overload; 
   function WO(const aPt: Tl3Point): Tl3SPoint; overload; 
   function WO(const aPt: Tl3SPoint): Tl3SPoint; overload; 
   procedure DrawFocusRect(const aRect: Tl3SRect);
   function IsVirtual: Boolean;
   procedure StartRegion;
   procedure FinishRegion;
   procedure PushWO;
   procedure PopWO;
   function GetClientRect: Tl3Rect;
   function AdjustMarginsByPrintableArea(const aMargins: Tl3_Rect): Tl3_Rect;
     {* Откорректировать поля с учетом непечатаемой области }
   function CheckConvertString(const aStr: Tl3PCharLen): Tl3PCharLen;
     {* преобразует строку для отображения форматирующей информации в режиме DrawSpecial. }
   function CheckOutString(const aStr: Tl3PCharLen): Tl3PCharLen;
   function DP2LP(const aP: Tl3_SPoint): Tl3Point;
     {* Преобразует точку в пикселях в точку в дюймах }
   function DeviceCaps(anIndex: Integer): Integer;
     {* возвращает свойства устройства рисования. }
   function PushClipRect: Tl3Rect;
   procedure PopClipRect;
   procedure PushLineSpacing;
   procedure PopLineSpacing;
   procedure StartDrawAAC(aType: TspBlockType);
   procedure EndDrawAAC(const R: Tl3Rect);
   procedure BeginDarkColor;
   procedure EndDarkColor;
 public
   property Font: Il3Font
     read Get_Font
     write Set_Font;
     {* текущий шрифт. }
   property DC: hDC
     read pm_GetDC
     write pm_SetDC;
     {* Handle контекста. }
   property PixelsPerInchX: Integer
     read pm_GetPixelsPerInchX;
   property PixelsPerInchY: Integer
     read pm_GetPixelsPerInchY;
   property WindowOrg: Tl3Point
     read pm_GetWindowOrg
     write pm_SetWindowOrg;
     {* смещение начала координат в дюймах. }
   property SWindowOrg: Tl3SPoint
     read pm_GetSWindowOrg
     write pm_SetSWindowOrg;
     {* смещение начала координат в пикселях. }
   property ClipRect: Tl3Rect
     read pm_GetClipRect
     write pm_SetClipRect;
     {* прямоугольник отсечения. }
   property GlobalClipRect: Tl3Rect
     read pm_GetGlobalClipRect;
   property BackColor: Tl3Color
     read pm_GetBackColor
     write pm_SetBackColor;
   property DrawEnabled: Boolean
     read pm_GetDrawEnabled
     write pm_SetDrawEnabled;
     {* разрешено рисование? }
   property DrawSpecial: Boolean
     read pm_GetDrawSpecial;
     {* рисовать спецсимволы? }
   property CanDrawSubs: Boolean
     read pm_GetCanDrawSubs;
     {* можем рисовать Sub'ы? }
   property ShowCursor: Boolean
     read pm_GetShowCursor
     write pm_SetShowCursor;
     {* отображать курсор? }
   property FontIndexSet: Tl3FontIndexes
     read pm_GetFontIndexSet
     write pm_SetFontIndexSet;
     {* текущий набор индексов шрифта. }
   property Printed: Boolean
     read pm_GetPrinted
     write pm_SetPrinted;
     {* все напечатано? }
   property PageNumber: Integer
     read pm_GetPageNumber;
     {* номер страницы в высоту. }
   property PageWidthNumber: Integer
     read pm_GetPageWidthNumber;
     {* номер страницы в ширину. }
   property PenWidth: Integer
     read pm_GetPenWidth;
     {* ширина пера. }
   property PageOrientation: Tl3PageOrientation
     read pm_GetPageOrientation
     write pm_SetPageOrientation;
     {* ориентация страницы. }
   property SectionExtent: Tl3Point
     read pm_GetSectionExtent
     write pm_SetSectionExtent;
     {* размеры текущего раздела с дюймах. }
   property NotFocused: Boolean
     write pm_SetNotFocused;
   property RegionBottomRight: Tl3Point
     read pm_GetRegionBottomRight;
   property PasswordChar: AnsiChar
     read Get_PasswordChar
     write Set_PasswordChar;
   property EffectiveColors: Il3EffectiveColors
     read Get_EffectiveColors;
   property Printing: Boolean
     read pm_GetPrinting;
     {* печать? }
   property Zoom: Integer
     read pm_GetZoom
     write pm_SetZoom;
     {* масштаб. }
   property PageSetup: Il3PageSetup
     read pm_GetPageSetup;
   property Painter: Il3HAFPainter
     write pm_SetPainter;
   property Canvas: TCanvas
     read pm_GetCanvas;
   property IsPagesCounter: Boolean
     read Get_IsPagesCounter;
   property OverallPageNumber: Integer
     read Get_OverallPageNumber;
   property InitialDCOffset: Tl3Point
     read Get_InitialDCOffset;
   property ClipRegion: Il3Region
     write Set_ClipRegion;
   property LineSpacing: Integer
     read Get_LineSpacing
     write Set_LineSpacing;
     {* Интерлиньяж в процентах от размера строки }
   property Invert: Boolean
     read pm_GetInvert;
   property InitialDCOffsetStored: Tl3Point
     read Get_InitialDCOffsetStored;
   property FrameLines: Il3FrameLines
     read pm_GetFrameLines;
   property AbortChecker: Il3AbortChecker
     read Get_AbortChecker
     write Set_AbortChecker;
 {$IfNDef XE4}
 private
   procedure Fake; virtual; // - это нужно чтобы правильно генерировались вызовы методов доступа к свойствам
 {$EndIf XE4}
 public
   constructor Init(const anIntf: Il3Canvas);
 public
   function IsValid: Boolean;
   procedure Free;
   property As_Il3Canvas: Il3Canvas read f_Il3Canvas;
 end;//Hl3Canvas

implementation

// start class HnevView

function HnevView.pm_GetMetrics: InevViewMetrics;
begin
 Result := f_InevView.Metrics;
end;

function HnevView.Data: InevObject;
begin
 Result := f_InevView.Data;
end;

function HnevView.RootMap: InevMap;
begin
 Result := f_InevView.RootMap;
end;

function HnevView.Processor: InevProcessor;
begin
 Result := f_InevView.Processor;
end;

procedure HnevView.ClearShapes;
begin
 f_InevView.ClearShapes;
end;

procedure HnevView.BeginDrawShape(const aShape: InevObject;
  const anAnchor: InevBasePoint;
  const anOrg: TnevPoint;
  var theMap: InevMap;
  aFake: Boolean;
  const aHacker: InevK235870994Hacker);
begin
 f_InevView.BeginDrawShape(aShape, anAnchor, anOrg, theMap, aFake, aHacker);
end;

procedure HnevView.EndDrawShape;
begin
 f_InevView.EndDrawShape;
end;

function HnevView.MapByPoint(const aPoint: InevBasePoint;
  aCheckTopVisible: Boolean = False): InevMap;
begin
 Result := f_InevView.MapByPoint(aPoint, aCheckTopVisible);
end;

function HnevView.FormatInfoByPoint(const aPoint: InevBasePoint): TnevFormatInfoPrim;
begin
 Result := f_InevView.FormatInfoByPoint(aPoint);
end;

function HnevView.RootFormatInfo: TnevFormatInfoPrim;
begin
 Result := f_InevView.RootFormatInfo;
end;

procedure HnevView.InvalidateShape(const aShape: InevObject;
  aParts: TnevShapeParts);
begin
 f_InevView.InvalidateShape(aShape, aParts);
end;

function HnevView.Get_ActiveElement: InevActiveElement;
begin
 Result := f_InevView.ActiveElement;
end;

function HnevView.Get_ForceDrawFocusRect: Boolean;
begin
 Result := f_InevView.ForceDrawFocusRect;
end;

function HnevView.Get_IsObjectCollapsed(const anObject: InevObject): Boolean;
begin
 Result := f_InevView.IsObjectCollapsed[anObject];
end;

procedure HnevView.Set_IsObjectCollapsed(const anObject: InevObject; aValue: Boolean);
begin
 f_InevView.IsObjectCollapsed[anObject] := aValue;
end;

{$If defined(evNeedCollapsedVersionComments)}
procedure HnevView.VersionInfoVisabilityChanged(aValue: Boolean);
begin
 f_InevView.VersionInfoVisabilityChanged(aValue);
end;
{$IfEnd} //evNeedCollapsedVersionComments

function HnevView.FormatInfoByPara(const aPara: InevObject): TnevFormatInfoPrim;
begin
 Result := f_InevView.FormatInfoByPara(aPara);
end;

function HnevView.FormatInfoByObj(const anObj: InevObjectPrim): TnevFormatInfoPrim;
begin
 Result := f_InevView.FormatInfoByObj(anObj);
end;

function HnevView.FormatInfoByPara(aPara: PInevObject): TnevFormatInfoPrim;
begin
 Result := f_InevView.FormatInfoByPara(aPara);
end;

{$IfNDef XE4}
procedure HnevView.Fake;
begin
 Assert(false);
end;
{$EndIf XE4}

constructor HnevView.Init(const anIntf: InevView);
begin
 f_InevView := anIntf;
end;

function HnevView.IsValid: Boolean;
begin
 Result := (f_InevView <> nil);
end;

procedure HnevView.Free;
begin
 f_InevView := nil;
 inherited;
end;

// start class Hl3Canvas

function Hl3Canvas.PxAverageCharWidth: Integer;
begin
 Result := f_Il3Canvas.pxAverageCharWidth;
end;

function Hl3Canvas.AverageCharWidth: Integer;
begin
 Result := f_Il3Canvas.AverageCharWidth;
end;

function Hl3Canvas.TextExtent(const S: Tl3WString;
  aNoTabs: Boolean = false): Tl3Point;
begin
 Result := f_Il3Canvas.TextExtent(S, aNoTabs);
end;

function Hl3Canvas.Pos2Index(W: Integer;
  const S: Tl3PCharLen): Integer;
begin
 Result := f_Il3Canvas.Pos2Index(W, S);
end;

function Hl3Canvas.Pos2IndexQ(W: Integer;
  const S: Tl3PCharLen;
  var aNoTabs: Boolean): Integer;
begin
 Result := f_Il3Canvas.Pos2IndexQ(W, S, aNoTabs);
end;

function Hl3Canvas.AverageCharHeight: Integer;
begin
 Result := f_Il3Canvas.AverageCharHeight;
end;

function Hl3Canvas.LP2DP(const P: Tl3_Point;
  NeedZoom: Boolean = false): Tl3SPoint;
begin
 Result := f_Il3Canvas.LP2DP(P, NeedZoom);
end;

function Hl3Canvas.LR2DR(const R: Tl3Rect): Tl3SRect;
begin
 Result := f_Il3Canvas.LR2DR(R);
end;

function Hl3Canvas.DR2LR(const R: Tl3SRect): Tl3Rect;
begin
 Result := f_Il3Canvas.DR2LR(R);
end;

procedure Hl3Canvas.Lock;
begin
 f_Il3Canvas.Lock;
end;

procedure Hl3Canvas.Unlock;
begin
 f_Il3Canvas.Unlock;
end;

function Hl3Canvas.GetKerning(const aSt: Tl3WString;
  Kerning: PLong): Tl3Point;
begin
 Result := f_Il3Canvas.GetKerning(aSt, Kerning);
end;

function Hl3Canvas.OffsetRgn(const Rgn: Il3Region;
  const Pt: Tl3Point): Integer;
begin
 Result := f_Il3Canvas.OffsetRgn(Rgn, Pt);
end;

function Hl3Canvas.CaretExtent: Tl3Point;
begin
 Result := f_Il3Canvas.CaretExtent;
end;

procedure Hl3Canvas.StartTabs(out theTabInfo: Il3TabInfo;
  const aTabStops: Il3TabStops;
  aTabOffset: Integer = 0);
begin
 f_Il3Canvas.StartTabs(theTabInfo, aTabStops, aTabOffset);
end;

procedure Hl3Canvas.StartTabs(out theTabInfo: Il3TabInfo;
  const aTabInfo: Il3TabInfo);
begin
 f_Il3Canvas.StartTabs(theTabInfo, aTabInfo);
end;

procedure Hl3Canvas.FinishTabs(var aTabInfo: Il3TabInfo);
begin
 f_Il3Canvas.FinishTabs(aTabInfo);
end;

function Hl3Canvas.TabInfo: Il3TabInfo;
begin
 Result := f_Il3Canvas.TabInfo;
end;

function Hl3Canvas.EQ(const aCanvas: Il3InfoCanvas): Boolean;
begin
 Result := f_Il3Canvas.EQ(aCanvas);
end;

function Hl3Canvas.NearestColor(C: Tl3Color): Tl3Color;
begin
 Result := f_Il3Canvas.NearestColor(C);
end;

function Hl3Canvas.DrawText(const aSt: Tl3WString;
  var R: TRect;
  aFormat: Cardinal;
  AFl: TObject = nil): Il3MultiLines;
begin
 Result := f_Il3Canvas.DrawText(aSt, R, aFormat, AFl);
end;

procedure Hl3Canvas.TabbedMultilineTextOut(const aSt: Tl3WString;
  const Tabs: Il3TabStops;
  var Rect: Tl3Rect;
  Precalculate: Boolean;
  aGap: Integer);
begin
 f_Il3Canvas.TabbedMultilineTextOut(aSt, Tabs, Rect, Precalculate, aGap);
end;

procedure Hl3Canvas.PushBC;
begin
 f_Il3Canvas.PushBC;
end;

function Hl3Canvas.TopBC: Tl3Color;
begin
 Result := f_Il3Canvas.TopBC;
end;

procedure Hl3Canvas.PopBC;
begin
 f_Il3Canvas.PopBC;
end;

procedure Hl3Canvas.PushFC;
begin
 f_Il3Canvas.PushFC;
end;

procedure Hl3Canvas.PopFC;
begin
 f_Il3Canvas.PopFC;
end;

function Hl3Canvas.TextMetrics: PTextMetric;
begin
 Result := f_Il3Canvas.TextMetrics;
end;

function Hl3Canvas.Get_Font: Il3Font;
begin
 Result := f_Il3Canvas.Font;
end;

procedure Hl3Canvas.Set_Font(const aValue: Il3Font);
begin
 f_Il3Canvas.Font := aValue;
end;

function Hl3Canvas.pm_GetDC: hDC;
begin
 Result := f_Il3Canvas.DC;
end;

procedure Hl3Canvas.pm_SetDC(aValue: hDC);
begin
 f_Il3Canvas.DC := aValue;
end;

function Hl3Canvas.pm_GetPixelsPerInchX: Integer;
begin
 Result := f_Il3Canvas.PixelsPerInchX;
end;

function Hl3Canvas.pm_GetPixelsPerInchY: Integer;
begin
 Result := f_Il3Canvas.PixelsPerInchY;
end;

procedure Hl3Canvas.MoveWindowOrg(const Delta: Tl3Point);
begin
 f_Il3Canvas.MoveWindowOrg(Delta);
end;

procedure Hl3Canvas.MoveWindowOrg(const Delta: Tl3SPoint);
begin
 f_Il3Canvas.MoveWindowOrg(Delta);
end;

procedure Hl3Canvas.FillForeRect(const R: Tl3SRect);
begin
 f_Il3Canvas.FillForeRect(R);
end;

procedure Hl3Canvas.FillRect(const R: Tl3SRect);
begin
 f_Il3Canvas.FillRect(R);
end;

procedure Hl3Canvas.FillRect(const R: Tl3Rect);
begin
 f_Il3Canvas.FillRect(R);
end;

procedure Hl3Canvas.FillEmptyRect(const R: Tl3Rect);
begin
 f_Il3Canvas.FillEmptyRect(R);
end;

procedure Hl3Canvas.FillEmptyRect(const R: Tl3SRect);
begin
 f_Il3Canvas.FillEmptyRect(R);
end;

function Hl3Canvas.FillRgn(const Region: Il3Region): Boolean;
begin
 Result := f_Il3Canvas.FillRgn(Region);
end;

function Hl3Canvas.TextOut(const P: Tl3Point;
  const S: Tl3PCharLen;
  FC: Tl3Color = clDefault;
  BC: Tl3Color = clDefault): Tl3Point;
begin
 Result := f_Il3Canvas.TextOut(P, S, FC, BC);
end;

procedure Hl3Canvas.SetCaret(const Origin: Tl3Point;
  const Extent: Tl3Point;
  Hidden: Boolean = false);
begin
 f_Il3Canvas.SetCaret(Origin, Extent, Hidden);
end;

procedure Hl3Canvas.IncCaret(aDeltaX: Integer);
begin
 f_Il3Canvas.IncCaret(aDeltaX);
end;

procedure Hl3Canvas.BeginPaint;
begin
 f_Il3Canvas.BeginPaint;
end;

procedure Hl3Canvas.StartObject(anObjectID: Integer);
begin
 f_Il3Canvas.StartObject(anObjectID);
end;

procedure Hl3Canvas.SetPageTop;
begin
 f_Il3Canvas.SetPageTop;
end;

procedure Hl3Canvas.EndPaint;
begin
 f_Il3Canvas.EndPaint;
end;

procedure Hl3Canvas.BeginInvert;
begin
 f_Il3Canvas.BeginInvert;
end;

procedure Hl3Canvas.EndInvert;
begin
 f_Il3Canvas.EndInvert;
end;

function Hl3Canvas.DrawRgnOrBlock: Boolean;
begin
 Result := f_Il3Canvas.DrawRgnOrBlock;
end;

function Hl3Canvas.HasToDraw: Boolean;
begin
 Result := f_Il3Canvas.HasToDraw;
end;

procedure Hl3Canvas.StretchDraw(const R: Tl3Rect;
  Graphic: VCLGraphic);
begin
 f_Il3Canvas.StretchDraw(R, Graphic);
end;

procedure Hl3Canvas.DrawSub(aSubTarget: TObject;
  const R: Tl3Rect;
  LayerHandle: Integer;
  aSub: TObject);
begin
 f_Il3Canvas.DrawSub(aSubTarget, R, LayerHandle, aSub);
end;

procedure Hl3Canvas.ExtTextOut(const P: Tl3Point;
  const R: Tl3Rect;
  const S: Tl3WString;
  F: Tl3TextFormatFlag = l3_tffLeft;
  Dx: PInteger = nil);
begin
 f_Il3Canvas.ExtTextOut(P, R, S, F, Dx);
end;

procedure Hl3Canvas.ExtTextOut(const P: Tl3SPoint;
  const R: Tl3SRect;
  const S: Tl3WString;
  F: Tl3TextFormatFlag = l3_tffLeft;
  Dx: PInteger = nil);
begin
 f_Il3Canvas.ExtTextOut(P, R, S, F, Dx);
end;

function Hl3Canvas.CaretLineOut(const aSt: Tl3WString;
  LineHeight: Integer;
  aHidden: Boolean;
  var CaretPos: Integer): Tl3Point;
begin
 Result := f_Il3Canvas.CaretLineOut(aSt, LineHeight, aHidden, CaretPos);
end;

function Hl3Canvas.StringOut(const P: Tl3Point;
  const Text: Tl3WString): Tl3Point;
begin
 Result := f_Il3Canvas.StringOut(P, Text);
end;

procedure Hl3Canvas.TabbedTextOut(const P: Tl3Point;
  const R: Tl3Rect;
  const S: Tl3WString;
  const aTabStops: Il3TabStops);
begin
 f_Il3Canvas.TabbedTextOut(P, R, S, aTabStops);
end;

procedure Hl3Canvas.TabbedTextOut(const P: Tl3SPoint;
  const R: Tl3SRect;
  const S: Tl3WString;
  const aTabStops: Il3TabStops);
begin
 f_Il3Canvas.TabbedTextOut(P, R, S, aTabStops);
end;

function Hl3Canvas.NewPage(ByWidth: Boolean = false): Boolean;
begin
 Result := f_Il3Canvas.NewPage(ByWidth);
end;

procedure Hl3Canvas.Line(const A: Tl3Point;
  const B: Tl3Point);
begin
 f_Il3Canvas.Line(A, B);
end;

procedure Hl3Canvas.Line(const A: Tl3SPoint;
  const B: Tl3SPoint);
begin
 f_Il3Canvas.Line(A, B);
end;

procedure Hl3Canvas.MoveTo(const Pt: Tl3Point);
begin
 f_Il3Canvas.MoveTo(Pt);
end;

procedure Hl3Canvas.LineTo(const Pt: Tl3Point);
begin
 f_Il3Canvas.LineTo(Pt);
end;

procedure Hl3Canvas.MoveTo(const Pt: Tl3SPoint);
begin
 f_Il3Canvas.MoveTo(Pt);
end;

procedure Hl3Canvas.LineTo(const Pt: Tl3SPoint);
begin
 f_Il3Canvas.LineTo(Pt);
end;

function Hl3Canvas.WO(const aRect: Tl3Rect): Tl3SRect;
begin
 Result := f_Il3Canvas.WO(aRect);
end;

function Hl3Canvas.WO(const aPt: Tl3Point): Tl3SPoint;
begin
 Result := f_Il3Canvas.WO(aPt);
end;

function Hl3Canvas.WO(const aPt: Tl3SPoint): Tl3SPoint;
begin
 Result := f_Il3Canvas.WO(aPt);
end;

procedure Hl3Canvas.DrawFocusRect(const aRect: Tl3SRect);
begin
 f_Il3Canvas.DrawFocusRect(aRect);
end;

function Hl3Canvas.IsVirtual: Boolean;
begin
 Result := f_Il3Canvas.IsVirtual;
end;

procedure Hl3Canvas.StartRegion;
begin
 f_Il3Canvas.StartRegion;
end;

procedure Hl3Canvas.FinishRegion;
begin
 f_Il3Canvas.FinishRegion;
end;

procedure Hl3Canvas.PushWO;
begin
 f_Il3Canvas.PushWO;
end;

procedure Hl3Canvas.PopWO;
begin
 f_Il3Canvas.PopWO;
end;

function Hl3Canvas.pm_GetWindowOrg: Tl3Point;
begin
 Result := f_Il3Canvas.WindowOrg;
end;

procedure Hl3Canvas.pm_SetWindowOrg(const aValue: Tl3Point);
begin
 f_Il3Canvas.WindowOrg := aValue;
end;

function Hl3Canvas.pm_GetSWindowOrg: Tl3SPoint;
begin
 Result := f_Il3Canvas.SWindowOrg;
end;

procedure Hl3Canvas.pm_SetSWindowOrg(const aValue: Tl3SPoint);
begin
 f_Il3Canvas.SWindowOrg := aValue;
end;

function Hl3Canvas.pm_GetClipRect: Tl3Rect;
begin
 Result := f_Il3Canvas.ClipRect;
end;

procedure Hl3Canvas.pm_SetClipRect(const aValue: Tl3Rect);
begin
 f_Il3Canvas.ClipRect := aValue;
end;

function Hl3Canvas.pm_GetGlobalClipRect: Tl3Rect;
begin
 Result := f_Il3Canvas.GlobalClipRect;
end;

function Hl3Canvas.pm_GetBackColor: Tl3Color;
begin
 Result := f_Il3Canvas.BackColor;
end;

procedure Hl3Canvas.pm_SetBackColor(aValue: Tl3Color);
begin
 f_Il3Canvas.BackColor := aValue;
end;

function Hl3Canvas.pm_GetDrawEnabled: Boolean;
begin
 Result := f_Il3Canvas.DrawEnabled;
end;

procedure Hl3Canvas.pm_SetDrawEnabled(aValue: Boolean);
begin
 f_Il3Canvas.DrawEnabled := aValue;
end;

function Hl3Canvas.pm_GetDrawSpecial: Boolean;
begin
 Result := f_Il3Canvas.DrawSpecial;
end;

function Hl3Canvas.pm_GetCanDrawSubs: Boolean;
begin
 Result := f_Il3Canvas.CanDrawSubs;
end;

function Hl3Canvas.pm_GetShowCursor: Boolean;
begin
 Result := f_Il3Canvas.ShowCursor;
end;

procedure Hl3Canvas.pm_SetShowCursor(aValue: Boolean);
begin
 f_Il3Canvas.ShowCursor := aValue;
end;

function Hl3Canvas.pm_GetFontIndexSet: Tl3FontIndexes;
begin
 Result := f_Il3Canvas.FontIndexSet;
end;

procedure Hl3Canvas.pm_SetFontIndexSet(aValue: Tl3FontIndexes);
begin
 f_Il3Canvas.FontIndexSet := aValue;
end;

function Hl3Canvas.pm_GetPrinted: Boolean;
begin
 Result := f_Il3Canvas.Printed;
end;

procedure Hl3Canvas.pm_SetPrinted(aValue: Boolean);
begin
 f_Il3Canvas.Printed := aValue;
end;

function Hl3Canvas.pm_GetPageNumber: Integer;
begin
 Result := f_Il3Canvas.PageNumber;
end;

function Hl3Canvas.pm_GetPageWidthNumber: Integer;
begin
 Result := f_Il3Canvas.PageWidthNumber;
end;

function Hl3Canvas.pm_GetPenWidth: Integer;
begin
 Result := f_Il3Canvas.PenWidth;
end;

function Hl3Canvas.pm_GetPageOrientation: Tl3PageOrientation;
begin
 Result := f_Il3Canvas.PageOrientation;
end;

procedure Hl3Canvas.pm_SetPageOrientation(aValue: Tl3PageOrientation);
begin
 f_Il3Canvas.PageOrientation := aValue;
end;

function Hl3Canvas.pm_GetSectionExtent: Tl3Point;
begin
 Result := f_Il3Canvas.SectionExtent;
end;

procedure Hl3Canvas.pm_SetSectionExtent(const aValue: Tl3Point);
begin
 f_Il3Canvas.SectionExtent := aValue;
end;

procedure Hl3Canvas.pm_SetNotFocused(aValue: Boolean);
begin
 f_Il3Canvas.NotFocused := aValue;
end;

function Hl3Canvas.pm_GetRegionBottomRight: Tl3Point;
begin
 Result := f_Il3Canvas.RegionBottomRight;
end;

function Hl3Canvas.GetClientRect: Tl3Rect;
begin
 Result := f_Il3Canvas.GetClientRect;
end;

function Hl3Canvas.AdjustMarginsByPrintableArea(const aMargins: Tl3_Rect): Tl3_Rect;
begin
 Result := f_Il3Canvas.AdjustMarginsByPrintableArea(aMargins);
end;

function Hl3Canvas.Get_PasswordChar: AnsiChar;
begin
 Result := f_Il3Canvas.PasswordChar;
end;

procedure Hl3Canvas.Set_PasswordChar(aValue: AnsiChar);
begin
 f_Il3Canvas.PasswordChar := aValue;
end;

function Hl3Canvas.Get_EffectiveColors: Il3EffectiveColors;
begin
 Result := f_Il3Canvas.EffectiveColors;
end;

function Hl3Canvas.pm_GetPrinting: Boolean;
begin
 Result := f_Il3Canvas.Printing;
end;

function Hl3Canvas.CheckConvertString(const aStr: Tl3PCharLen): Tl3PCharLen;
begin
 Result := f_Il3Canvas.CheckConvertString(aStr);
end;

function Hl3Canvas.CheckOutString(const aStr: Tl3PCharLen): Tl3PCharLen;
begin
 Result := f_Il3Canvas.CheckOutString(aStr);
end;

function Hl3Canvas.pm_GetZoom: Integer;
begin
 Result := f_Il3Canvas.Zoom;
end;

procedure Hl3Canvas.pm_SetZoom(aValue: Integer);
begin
 f_Il3Canvas.Zoom := aValue;
end;

function Hl3Canvas.pm_GetPageSetup: Il3PageSetup;
begin
 Result := f_Il3Canvas.PageSetup;
end;

procedure Hl3Canvas.pm_SetPainter(const aValue: Il3HAFPainter);
begin
 f_Il3Canvas.Painter := aValue;
end;

function Hl3Canvas.pm_GetCanvas: TCanvas;
begin
 Result := f_Il3Canvas.Canvas;
end;

function Hl3Canvas.DP2LP(const aP: Tl3_SPoint): Tl3Point;
begin
 Result := f_Il3Canvas.DP2LP(aP);
end;

function Hl3Canvas.DeviceCaps(anIndex: Integer): Integer;
begin
 Result := f_Il3Canvas.DeviceCaps(anIndex);
end;

function Hl3Canvas.Get_IsPagesCounter: Boolean;
begin
 Result := f_Il3Canvas.IsPagesCounter;
end;

function Hl3Canvas.Get_OverallPageNumber: Integer;
begin
 Result := f_Il3Canvas.OverallPageNumber;
end;

function Hl3Canvas.Get_InitialDCOffset: Tl3Point;
begin
 Result := f_Il3Canvas.InitialDCOffset;
end;

function Hl3Canvas.PushClipRect: Tl3Rect;
begin
 Result := f_Il3Canvas.PushClipRect;
end;

procedure Hl3Canvas.PopClipRect;
begin
 f_Il3Canvas.PopClipRect;
end;

procedure Hl3Canvas.Set_ClipRegion(const aValue: Il3Region);
begin
 f_Il3Canvas.ClipRegion := aValue;
end;

function Hl3Canvas.Get_LineSpacing: Integer;
begin
 Result := f_Il3Canvas.LineSpacing;
end;

procedure Hl3Canvas.Set_LineSpacing(aValue: Integer);
begin
 f_Il3Canvas.LineSpacing := aValue;
end;

procedure Hl3Canvas.PushLineSpacing;
begin
 f_Il3Canvas.PushLineSpacing;
end;

procedure Hl3Canvas.PopLineSpacing;
begin
 f_Il3Canvas.PopLineSpacing;
end;

function Hl3Canvas.pm_GetInvert: Boolean;
begin
 Result := f_Il3Canvas.Invert;
end;

function Hl3Canvas.Get_InitialDCOffsetStored: Tl3Point;
begin
 Result := f_Il3Canvas.InitialDCOffsetStored;
end;

function Hl3Canvas.pm_GetFrameLines: Il3FrameLines;
begin
 Result := f_Il3Canvas.FrameLines;
end;

function Hl3Canvas.Get_AbortChecker: Il3AbortChecker;
begin
 Result := f_Il3Canvas.AbortChecker;
end;

procedure Hl3Canvas.Set_AbortChecker(const aValue: Il3AbortChecker);
begin
 f_Il3Canvas.AbortChecker := aValue;
end;

procedure Hl3Canvas.StartDrawAAC(aType: TspBlockType);
begin
 f_Il3Canvas.StartDrawAAC(aType);
end;

procedure Hl3Canvas.EndDrawAAC(const R: Tl3Rect);
begin
 f_Il3Canvas.EndDrawAAC(R);
end;

procedure Hl3Canvas.BeginDarkColor;
begin
 f_Il3Canvas.BeginDarkColor;
end;

procedure Hl3Canvas.EndDarkColor;
begin
 f_Il3Canvas.EndDarkColor;
end;

{$IfNDef XE4}
procedure Hl3Canvas.Fake;
begin
 Assert(false);
end;
{$EndIf XE4}

constructor Hl3Canvas.Init(const anIntf: Il3Canvas);
begin
 f_Il3Canvas := anIntf;
end;

function Hl3Canvas.IsValid: Boolean;
begin
 Result := (f_Il3Canvas <> nil);
end;

procedure Hl3Canvas.Free;
begin
 f_Il3Canvas := nil;
 inherited;
end;

end.