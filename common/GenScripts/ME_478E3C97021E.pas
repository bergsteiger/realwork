unit NOT_FINISHED_l3Canvas;
 {* попытка реализации своего уровня абстракции над DeviceContext. }

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3Canvas.pas"
// Стереотип: "UtilityPack"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3CanvasPrim
 , l3Interfaces
 , l3InternalInterfaces
 , l3Units
 , Windows
 , l3Core
 , l3Types
 , l3PrinterInterfaces
;

type
 Tl3Canvas = class(Tl3CanvasPrim, Il3Font, Il3InfoCanvas, Il3Canvas)
  {* Объект реализующий свой уровень абстракции над TCanvas и Device Context (hDC) }
  private
   f_AbortChecker: Il3AbortChecker;
  protected
   function NeedOpenRealPage(aDoc: Boolean;
    ByWidth: Boolean = False): Tl3OpenPageResult; virtual;
   function IsPreview: Boolean; virtual;
   procedure DoEndPaint; virtual;
    {* Реализация окончания рисования. }
   function GetCaret: Il3Caret; virtual;
   function DoGetDrawEnabled: Boolean; virtual;
   procedure DoStartPage; virtual;
   procedure DoStartObject(anObjectID: Integer); virtual;
   procedure DoSetPageTop; virtual;
   procedure Invalidate; virtual;
   procedure FireDCSetToNull; virtual;
   procedure FreeAlienDC(aDC: hDC); virtual;
   procedure DoStartDrawAAC(aType: TspBlockType); virtual;
   procedure DoEndDrawAAC(const R: Tl3Rect); virtual;
   function Get_Size: Integer;
   function Get_Name: TFontName;
   function Get_Bold: Boolean;
   function Get_Italic: Boolean;
   function Get_Underline: Boolean;
   function Get_Strikeout: Boolean;
   function Get_ForeColor: Tl3Color;
   function Get_BackColor: Tl3Color;
   function Get_Pitch: TFontPitch;
   function Get_Index: Tl3FontIndex;
   function Get_ForeColor: Tl3Color;
   procedure Set_ForeColor(aValue: Tl3Color);
   function Get_BackColor: Tl3Color;
   procedure Set_BackColor(aValue: Tl3Color);
   function Get_Name: TFontName;
   procedure Set_Name(const aValue: TFontName);
   function Get_Pitch: TFontPitch;
   procedure Set_Pitch(aValue: TFontPitch);
   function Get_Size: Integer;
   procedure Set_Size(aValue: Integer);
   function Get_Index: Tl3FontIndex;
   procedure Set_Index(aValue: Tl3FontIndex);
   function Get_Style: TFontStyles;
   procedure Set_Style(aValue: TFontStyles);
   function Get_Bold: Boolean;
   procedure Set_Bold(aValue: Boolean);
   function Get_Italic: Boolean;
   procedure Set_Italic(aValue: Boolean);
   function Get_Underline: Boolean;
   procedure Set_Underline(aValue: Boolean);
   function Get_Strikeout: Boolean;
   procedure Set_Strikeout(aValue: Boolean);
   function AssignFont(Font: TFont): Boolean;
   procedure Assign2Font(const aFont: Il3Font);
   procedure Lock; overload;
   procedure Unlock; overload;
   function HF: hFont;
   function pxAverageCharWidth: Integer;
    {* средняя ширина символов контекста в пикселях. }
   function AverageCharWidth: Integer;
    {* средняя ширина символов контекста в дюймах. }
   function TextExtent(const S: Tl3WString;
    aNoTabs: Boolean = False): Tl3Point;
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
    NeedZoom: Boolean = False): Tl3SPoint;
    {* преобразует точку в дюймах в точку в пикселях. }
   function LR2DR(const R: Tl3Rect): Tl3SRect;
    {* преобразует прямоугольник в дюймах в прямоугольник в пикселях. }
   function DR2LR(const R: Tl3SRect): Tl3Rect;
    {* преобразует прямоугольник в пикселях в прямоугольник в дюймах. }
   procedure Lock; overload;
    {* начать работу с канвой. }
   procedure Unlock; overload;
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
   function Get_Font: Il3Font;
   procedure Set_Font(const aValue: Il3Font);
   function pm_GetDC: hDC;
   procedure pm_SetDC(aValue: hDC);
   function pm_GetPixelsPerInchX: Integer;
   function pm_GetPixelsPerInchY: Integer;
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
    Hidden: Boolean = False);
   procedure IncCaret(aDeltaX: Integer);
   procedure BeginPaint;
   procedure StartObject(anObjectID: Integer);
   procedure SetPageTop;
   procedure EndPaint;
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
   function NewPage(ByWidth: Boolean = False): Boolean;
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
   procedure StartRegion;
   procedure FinishRegion;
   procedure PushWO;
   procedure PopWO;
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
   function pm_GetPenWidth: Integer;
   function pm_GetPageOrientation: Tl3PageOrientation;
   procedure pm_SetPageOrientation(aValue: Tl3PageOrientation);
   function pm_GetSectionExtent: Tl3Point;
   procedure pm_SetSectionExtent(const aValue: Tl3Point);
   procedure pm_SetNotFocused(aValue: Boolean);
   function pm_GetRegionBottomRight: Tl3Point;
   function IsAtomic: Boolean;
    {* Строка для нанного шрифта представляет собой единый объект? }
   function FM: Il3FontMetrics;
    {* Метрики шрифта. }
   function GetClientRect: Tl3Rect;
   function AdjustMarginsByPrintableArea(const aMargins: Tl3_Rect): Tl3_Rect;
    {* Откорректировать поля с учетом непечатаемой области }
   function Get_PasswordChar: AnsiChar;
   procedure Set_PasswordChar(aValue: AnsiChar);
   function Get_EffectiveColors: Il3EffectiveColors;
   function pm_GetPrinting: Boolean;
   function CheckConvertString(const aStr: Tl3PCharLen): Tl3PCharLen;
    {* преобразует строку для отображения форматирующей информации в режиме DrawSpecial. }
   function CheckOutString(const aStr: Tl3PCharLen): Tl3PCharLen;
   function pm_GetZoom: Integer;
   procedure pm_SetZoom(aValue: Integer);
   function DeviceCaps(anIndex: Integer): Integer; override;
   function AsIl3Canvas: Il3Canvas; override;
   function pm_GetPageSetup: Il3PageSetup;
   procedure pm_SetPainter(const aValue: Il3HAFPainter);
   function pm_GetCanvas: TCanvas;
   procedure AssignDeviceCaps; override;
    {* Инициализировать информацию об устройстве }
   function pm_GetWindowOrg: Tl3Point; override;
   procedure pm_SetWindowOrg(const aValue: Tl3Point); override;
   function pm_GetGlobalClipRect: Tl3Rect; override;
   function pm_GetClipRect: Tl3Rect; override;
   procedure pm_SetClipRect(const aValue: Tl3Rect); override;
   function pm_GetSWindowOrg: Tl3SPoint; override;
   procedure pm_SetSWindowOrg(const aValue: Tl3SPoint); override;
   function pm_GetInvert: Boolean;
   function pm_GetFrameLines: Il3FrameLines;
   function Get_AbortChecker: Il3AbortChecker;
   procedure Set_AbortChecker(const aValue: Il3AbortChecker);
   procedure StartDrawAAC(aType: TspBlockType);
   procedure EndDrawAAC(const R: Tl3Rect);
   procedure BeginDarkColor;
   procedure EndDarkColor;
   function GetGlobalClipRectWithZoom: Tl3Rect; override;
  public
   function DoGetClientRect: Tl3Rect; virtual;
   procedure BeginInvert;
   procedure EndInvert;
   function IsVirtual: Boolean;
   function DeviceCaps(anIndex: Integer): Integer; overload;
    {* возвращает свойства устройства рисования. }
   procedure FillRect(const R: Tl3SRect); override;
   procedure FillRect(const R: Tl3Rect); override;
 end;//Tl3Canvas

 Tl3OldMFCanvas = class(Tl3Canvas)
  {* Канва для старого мета-файла. }
 end;//Tl3OldMFCanvas

implementation

uses
 l3ImplUses
 , l3CanvasUtils
 , l3LineArray
 , l3Region
;

function Tl3Canvas.NeedOpenRealPage(aDoc: Boolean;
 ByWidth: Boolean = False): Tl3OpenPageResult;
//#UC START# *478E406D004B_473C3D830066_var*
//#UC END# *478E406D004B_473C3D830066_var*
begin
//#UC START# *478E406D004B_473C3D830066_impl*
 assert(false, 'Tl3Canvas.NeedOpenRealPage not implemented');
//#UC END# *478E406D004B_473C3D830066_impl*
end;//Tl3Canvas.NeedOpenRealPage

function Tl3Canvas.IsPreview: Boolean;
//#UC START# *478E40D30089_473C3D830066_var*
//#UC END# *478E40D30089_473C3D830066_var*
begin
//#UC START# *478E40D30089_473C3D830066_impl*
 assert(false, 'Tl3Canvas.IsPreview not implemented');
//#UC END# *478E40D30089_473C3D830066_impl*
end;//Tl3Canvas.IsPreview

procedure Tl3Canvas.DoEndPaint;
 {* Реализация окончания рисования. }
//#UC START# *4797837E0112_473C3D830066_var*
//#UC END# *4797837E0112_473C3D830066_var*
begin
//#UC START# *4797837E0112_473C3D830066_impl*
 assert(false, 'Tl3Canvas.DoEndPaint not implemented');
//#UC END# *4797837E0112_473C3D830066_impl*
end;//Tl3Canvas.DoEndPaint

function Tl3Canvas.GetCaret: Il3Caret;
//#UC START# *47DFB3CE02C5_473C3D830066_var*
//#UC END# *47DFB3CE02C5_473C3D830066_var*
begin
//#UC START# *47DFB3CE02C5_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *47DFB3CE02C5_473C3D830066_impl*
end;//Tl3Canvas.GetCaret

function Tl3Canvas.DoGetDrawEnabled: Boolean;
//#UC START# *47DFBDDA03CC_473C3D830066_var*
//#UC END# *47DFBDDA03CC_473C3D830066_var*
begin
//#UC START# *47DFBDDA03CC_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *47DFBDDA03CC_473C3D830066_impl*
end;//Tl3Canvas.DoGetDrawEnabled

procedure Tl3Canvas.DoStartPage;
//#UC START# *47DFBEC80085_473C3D830066_var*
//#UC END# *47DFBEC80085_473C3D830066_var*
begin
//#UC START# *47DFBEC80085_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *47DFBEC80085_473C3D830066_impl*
end;//Tl3Canvas.DoStartPage

procedure Tl3Canvas.DoStartObject(anObjectID: Integer);
//#UC START# *47DFC90A0366_473C3D830066_var*
//#UC END# *47DFC90A0366_473C3D830066_var*
begin
//#UC START# *47DFC90A0366_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *47DFC90A0366_473C3D830066_impl*
end;//Tl3Canvas.DoStartObject

procedure Tl3Canvas.DoSetPageTop;
//#UC START# *47DFCA030114_473C3D830066_var*
//#UC END# *47DFCA030114_473C3D830066_var*
begin
//#UC START# *47DFCA030114_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *47DFCA030114_473C3D830066_impl*
end;//Tl3Canvas.DoSetPageTop

procedure Tl3Canvas.Invalidate;
//#UC START# *4FAE47320103_473C3D830066_var*
//#UC END# *4FAE47320103_473C3D830066_var*
begin
//#UC START# *4FAE47320103_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FAE47320103_473C3D830066_impl*
end;//Tl3Canvas.Invalidate

function Tl3Canvas.DoGetClientRect: Tl3Rect;
//#UC START# *4FAE4C740135_473C3D830066_var*
//#UC END# *4FAE4C740135_473C3D830066_var*
begin
//#UC START# *4FAE4C740135_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FAE4C740135_473C3D830066_impl*
end;//Tl3Canvas.DoGetClientRect

procedure Tl3Canvas.FireDCSetToNull;
//#UC START# *4FAE530D02C3_473C3D830066_var*
//#UC END# *4FAE530D02C3_473C3D830066_var*
begin
//#UC START# *4FAE530D02C3_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FAE530D02C3_473C3D830066_impl*
end;//Tl3Canvas.FireDCSetToNull

procedure Tl3Canvas.FreeAlienDC(aDC: hDC);
//#UC START# *4FAE532B0348_473C3D830066_var*
//#UC END# *4FAE532B0348_473C3D830066_var*
begin
//#UC START# *4FAE532B0348_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FAE532B0348_473C3D830066_impl*
end;//Tl3Canvas.FreeAlienDC

procedure Tl3Canvas.DoStartDrawAAC(aType: TspBlockType);
//#UC START# *54B4DDF502DD_473C3D830066_var*
//#UC END# *54B4DDF502DD_473C3D830066_var*
begin
//#UC START# *54B4DDF502DD_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *54B4DDF502DD_473C3D830066_impl*
end;//Tl3Canvas.DoStartDrawAAC

procedure Tl3Canvas.DoEndDrawAAC(const R: Tl3Rect);
//#UC START# *54B4DE1700CA_473C3D830066_var*
//#UC END# *54B4DE1700CA_473C3D830066_var*
begin
//#UC START# *54B4DE1700CA_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *54B4DE1700CA_473C3D830066_impl*
end;//Tl3Canvas.DoEndDrawAAC

function Tl3Canvas.Get_Size: Integer;
//#UC START# *46A60D7A02E4_473C3D830066get_var*
//#UC END# *46A60D7A02E4_473C3D830066get_var*
begin
//#UC START# *46A60D7A02E4_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Size not implemented');
//#UC END# *46A60D7A02E4_473C3D830066get_impl*
end;//Tl3Canvas.Get_Size

function Tl3Canvas.Get_Name: TFontName;
//#UC START# *46A60E2802E4_473C3D830066get_var*
//#UC END# *46A60E2802E4_473C3D830066get_var*
begin
//#UC START# *46A60E2802E4_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Name not implemented');
//#UC END# *46A60E2802E4_473C3D830066get_impl*
end;//Tl3Canvas.Get_Name

function Tl3Canvas.Get_Bold: Boolean;
//#UC START# *46A60E58013F_473C3D830066get_var*
//#UC END# *46A60E58013F_473C3D830066get_var*
begin
//#UC START# *46A60E58013F_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Bold not implemented');
//#UC END# *46A60E58013F_473C3D830066get_impl*
end;//Tl3Canvas.Get_Bold

function Tl3Canvas.Get_Italic: Boolean;
//#UC START# *46A60E740045_473C3D830066get_var*
//#UC END# *46A60E740045_473C3D830066get_var*
begin
//#UC START# *46A60E740045_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Italic not implemented');
//#UC END# *46A60E740045_473C3D830066get_impl*
end;//Tl3Canvas.Get_Italic

function Tl3Canvas.Get_Underline: Boolean;
//#UC START# *46A60EA6032C_473C3D830066get_var*
//#UC END# *46A60EA6032C_473C3D830066get_var*
begin
//#UC START# *46A60EA6032C_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Underline not implemented');
//#UC END# *46A60EA6032C_473C3D830066get_impl*
end;//Tl3Canvas.Get_Underline

function Tl3Canvas.Get_Strikeout: Boolean;
//#UC START# *46A60EBF03BE_473C3D830066get_var*
//#UC END# *46A60EBF03BE_473C3D830066get_var*
begin
//#UC START# *46A60EBF03BE_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Strikeout not implemented');
//#UC END# *46A60EBF03BE_473C3D830066get_impl*
end;//Tl3Canvas.Get_Strikeout

function Tl3Canvas.Get_ForeColor: Tl3Color;
//#UC START# *46A60ED90325_473C3D830066get_var*
//#UC END# *46A60ED90325_473C3D830066get_var*
begin
//#UC START# *46A60ED90325_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_ForeColor not implemented');
//#UC END# *46A60ED90325_473C3D830066get_impl*
end;//Tl3Canvas.Get_ForeColor

function Tl3Canvas.Get_BackColor: Tl3Color;
//#UC START# *46A60EF300C9_473C3D830066get_var*
//#UC END# *46A60EF300C9_473C3D830066get_var*
begin
//#UC START# *46A60EF300C9_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_BackColor not implemented');
//#UC END# *46A60EF300C9_473C3D830066get_impl*
end;//Tl3Canvas.Get_BackColor

function Tl3Canvas.Get_Pitch: TFontPitch;
//#UC START# *46A60F63035F_473C3D830066get_var*
//#UC END# *46A60F63035F_473C3D830066get_var*
begin
//#UC START# *46A60F63035F_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Pitch not implemented');
//#UC END# *46A60F63035F_473C3D830066get_impl*
end;//Tl3Canvas.Get_Pitch

function Tl3Canvas.Get_Index: Tl3FontIndex;
//#UC START# *46A60F89031E_473C3D830066get_var*
//#UC END# *46A60F89031E_473C3D830066get_var*
begin
//#UC START# *46A60F89031E_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Index not implemented');
//#UC END# *46A60F89031E_473C3D830066get_impl*
end;//Tl3Canvas.Get_Index

function Tl3Canvas.Get_ForeColor: Tl3Color;
//#UC START# *46A610780340_473C3D830066get_var*
//#UC END# *46A610780340_473C3D830066get_var*
begin
//#UC START# *46A610780340_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_ForeColor not implemented');
//#UC END# *46A610780340_473C3D830066get_impl*
end;//Tl3Canvas.Get_ForeColor

procedure Tl3Canvas.Set_ForeColor(aValue: Tl3Color);
//#UC START# *46A610780340_473C3D830066set_var*
//#UC END# *46A610780340_473C3D830066set_var*
begin
//#UC START# *46A610780340_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.Set_ForeColor not implemented');
//#UC END# *46A610780340_473C3D830066set_impl*
end;//Tl3Canvas.Set_ForeColor

function Tl3Canvas.Get_BackColor: Tl3Color;
//#UC START# *46A6108E017F_473C3D830066get_var*
//#UC END# *46A6108E017F_473C3D830066get_var*
begin
//#UC START# *46A6108E017F_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_BackColor not implemented');
//#UC END# *46A6108E017F_473C3D830066get_impl*
end;//Tl3Canvas.Get_BackColor

procedure Tl3Canvas.Set_BackColor(aValue: Tl3Color);
//#UC START# *46A6108E017F_473C3D830066set_var*
//#UC END# *46A6108E017F_473C3D830066set_var*
begin
//#UC START# *46A6108E017F_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.Set_BackColor not implemented');
//#UC END# *46A6108E017F_473C3D830066set_impl*
end;//Tl3Canvas.Set_BackColor

function Tl3Canvas.Get_Name: TFontName;
//#UC START# *46A610AF012C_473C3D830066get_var*
//#UC END# *46A610AF012C_473C3D830066get_var*
begin
//#UC START# *46A610AF012C_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Name not implemented');
//#UC END# *46A610AF012C_473C3D830066get_impl*
end;//Tl3Canvas.Get_Name

procedure Tl3Canvas.Set_Name(const aValue: TFontName);
//#UC START# *46A610AF012C_473C3D830066set_var*
//#UC END# *46A610AF012C_473C3D830066set_var*
begin
//#UC START# *46A610AF012C_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.Set_Name not implemented');
//#UC END# *46A610AF012C_473C3D830066set_impl*
end;//Tl3Canvas.Set_Name

function Tl3Canvas.Get_Pitch: TFontPitch;
//#UC START# *46A610E10084_473C3D830066get_var*
//#UC END# *46A610E10084_473C3D830066get_var*
begin
//#UC START# *46A610E10084_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Pitch not implemented');
//#UC END# *46A610E10084_473C3D830066get_impl*
end;//Tl3Canvas.Get_Pitch

procedure Tl3Canvas.Set_Pitch(aValue: TFontPitch);
//#UC START# *46A610E10084_473C3D830066set_var*
//#UC END# *46A610E10084_473C3D830066set_var*
begin
//#UC START# *46A610E10084_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.Set_Pitch not implemented');
//#UC END# *46A610E10084_473C3D830066set_impl*
end;//Tl3Canvas.Set_Pitch

function Tl3Canvas.Get_Size: Integer;
//#UC START# *46A6111000F9_473C3D830066get_var*
//#UC END# *46A6111000F9_473C3D830066get_var*
begin
//#UC START# *46A6111000F9_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Size not implemented');
//#UC END# *46A6111000F9_473C3D830066get_impl*
end;//Tl3Canvas.Get_Size

procedure Tl3Canvas.Set_Size(aValue: Integer);
//#UC START# *46A6111000F9_473C3D830066set_var*
//#UC END# *46A6111000F9_473C3D830066set_var*
begin
//#UC START# *46A6111000F9_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.Set_Size not implemented');
//#UC END# *46A6111000F9_473C3D830066set_impl*
end;//Tl3Canvas.Set_Size

function Tl3Canvas.Get_Index: Tl3FontIndex;
//#UC START# *46A61136020C_473C3D830066get_var*
//#UC END# *46A61136020C_473C3D830066get_var*
begin
//#UC START# *46A61136020C_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Index not implemented');
//#UC END# *46A61136020C_473C3D830066get_impl*
end;//Tl3Canvas.Get_Index

procedure Tl3Canvas.Set_Index(aValue: Tl3FontIndex);
//#UC START# *46A61136020C_473C3D830066set_var*
//#UC END# *46A61136020C_473C3D830066set_var*
begin
//#UC START# *46A61136020C_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.Set_Index not implemented');
//#UC END# *46A61136020C_473C3D830066set_impl*
end;//Tl3Canvas.Set_Index

function Tl3Canvas.Get_Style: TFontStyles;
//#UC START# *46A6127B0282_473C3D830066get_var*
//#UC END# *46A6127B0282_473C3D830066get_var*
begin
//#UC START# *46A6127B0282_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Style not implemented');
//#UC END# *46A6127B0282_473C3D830066get_impl*
end;//Tl3Canvas.Get_Style

procedure Tl3Canvas.Set_Style(aValue: TFontStyles);
//#UC START# *46A6127B0282_473C3D830066set_var*
//#UC END# *46A6127B0282_473C3D830066set_var*
begin
//#UC START# *46A6127B0282_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.Set_Style not implemented');
//#UC END# *46A6127B0282_473C3D830066set_impl*
end;//Tl3Canvas.Set_Style

function Tl3Canvas.Get_Bold: Boolean;
//#UC START# *46A6129101E3_473C3D830066get_var*
//#UC END# *46A6129101E3_473C3D830066get_var*
begin
//#UC START# *46A6129101E3_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Bold not implemented');
//#UC END# *46A6129101E3_473C3D830066get_impl*
end;//Tl3Canvas.Get_Bold

procedure Tl3Canvas.Set_Bold(aValue: Boolean);
//#UC START# *46A6129101E3_473C3D830066set_var*
//#UC END# *46A6129101E3_473C3D830066set_var*
begin
//#UC START# *46A6129101E3_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.Set_Bold not implemented');
//#UC END# *46A6129101E3_473C3D830066set_impl*
end;//Tl3Canvas.Set_Bold

function Tl3Canvas.Get_Italic: Boolean;
//#UC START# *46A612AF0038_473C3D830066get_var*
//#UC END# *46A612AF0038_473C3D830066get_var*
begin
//#UC START# *46A612AF0038_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Italic not implemented');
//#UC END# *46A612AF0038_473C3D830066get_impl*
end;//Tl3Canvas.Get_Italic

procedure Tl3Canvas.Set_Italic(aValue: Boolean);
//#UC START# *46A612AF0038_473C3D830066set_var*
//#UC END# *46A612AF0038_473C3D830066set_var*
begin
//#UC START# *46A612AF0038_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.Set_Italic not implemented');
//#UC END# *46A612AF0038_473C3D830066set_impl*
end;//Tl3Canvas.Set_Italic

function Tl3Canvas.Get_Underline: Boolean;
//#UC START# *46A612C302D6_473C3D830066get_var*
//#UC END# *46A612C302D6_473C3D830066get_var*
begin
//#UC START# *46A612C302D6_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Underline not implemented');
//#UC END# *46A612C302D6_473C3D830066get_impl*
end;//Tl3Canvas.Get_Underline

procedure Tl3Canvas.Set_Underline(aValue: Boolean);
//#UC START# *46A612C302D6_473C3D830066set_var*
//#UC END# *46A612C302D6_473C3D830066set_var*
begin
//#UC START# *46A612C302D6_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.Set_Underline not implemented');
//#UC END# *46A612C302D6_473C3D830066set_impl*
end;//Tl3Canvas.Set_Underline

function Tl3Canvas.Get_Strikeout: Boolean;
//#UC START# *46A612DC01F5_473C3D830066get_var*
//#UC END# *46A612DC01F5_473C3D830066get_var*
begin
//#UC START# *46A612DC01F5_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Strikeout not implemented');
//#UC END# *46A612DC01F5_473C3D830066get_impl*
end;//Tl3Canvas.Get_Strikeout

procedure Tl3Canvas.Set_Strikeout(aValue: Boolean);
//#UC START# *46A612DC01F5_473C3D830066set_var*
//#UC END# *46A612DC01F5_473C3D830066set_var*
begin
//#UC START# *46A612DC01F5_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.Set_Strikeout not implemented');
//#UC END# *46A612DC01F5_473C3D830066set_impl*
end;//Tl3Canvas.Set_Strikeout

function Tl3Canvas.AssignFont(Font: TFont): Boolean;
//#UC START# *46A6154A01EE_473C3D830066_var*
//#UC END# *46A6154A01EE_473C3D830066_var*
begin
//#UC START# *46A6154A01EE_473C3D830066_impl*
 assert(false, 'Tl3Canvas.AssignFont not implemented');
//#UC END# *46A6154A01EE_473C3D830066_impl*
end;//Tl3Canvas.AssignFont

procedure Tl3Canvas.Assign2Font(const aFont: Il3Font);
//#UC START# *46A6156000CD_473C3D830066_var*
//#UC END# *46A6156000CD_473C3D830066_var*
begin
//#UC START# *46A6156000CD_473C3D830066_impl*
 assert(false, 'Tl3Canvas.Assign2Font not implemented');
//#UC END# *46A6156000CD_473C3D830066_impl*
end;//Tl3Canvas.Assign2Font

procedure Tl3Canvas.Lock;
//#UC START# *46A6157B0361_473C3D830066_var*
//#UC END# *46A6157B0361_473C3D830066_var*
begin
//#UC START# *46A6157B0361_473C3D830066_impl*
 assert(false, 'Tl3Canvas.Lock not implemented');
//#UC END# *46A6157B0361_473C3D830066_impl*
end;//Tl3Canvas.Lock

procedure Tl3Canvas.Unlock;
//#UC START# *46A6158C0275_473C3D830066_var*
//#UC END# *46A6158C0275_473C3D830066_var*
begin
//#UC START# *46A6158C0275_473C3D830066_impl*
 assert(false, 'Tl3Canvas.Unlock not implemented');
//#UC END# *46A6158C0275_473C3D830066_impl*
end;//Tl3Canvas.Unlock

function Tl3Canvas.HF: hFont;
//#UC START# *46A615A10333_473C3D830066_var*
//#UC END# *46A615A10333_473C3D830066_var*
begin
//#UC START# *46A615A10333_473C3D830066_impl*
 assert(false, 'Tl3Canvas.HF not implemented');
//#UC END# *46A615A10333_473C3D830066_impl*
end;//Tl3Canvas.HF

function Tl3Canvas.pxAverageCharWidth: Integer;
 {* средняя ширина символов контекста в пикселях. }
//#UC START# *4727432E0121_473C3D830066_var*
//#UC END# *4727432E0121_473C3D830066_var*
begin
//#UC START# *4727432E0121_473C3D830066_impl*
 assert(false, 'Tl3Canvas.PxAverageCharWidth not implemented');
//#UC END# *4727432E0121_473C3D830066_impl*
end;//Tl3Canvas.pxAverageCharWidth

function Tl3Canvas.AverageCharWidth: Integer;
 {* средняя ширина символов контекста в дюймах. }
//#UC START# *472743420382_473C3D830066_var*
//#UC END# *472743420382_473C3D830066_var*
begin
//#UC START# *472743420382_473C3D830066_impl*
 assert(false, 'Tl3Canvas.AverageCharWidth not implemented');
//#UC END# *472743420382_473C3D830066_impl*
end;//Tl3Canvas.AverageCharWidth

function Tl3Canvas.TextExtent(const S: Tl3WString;
 aNoTabs: Boolean = False): Tl3Point;
 {* возвращает длину строки текста в дюймах. }
//#UC START# *472744E803E3_473C3D830066_var*
//#UC END# *472744E803E3_473C3D830066_var*
begin
//#UC START# *472744E803E3_473C3D830066_impl*
 assert(false, 'Tl3Canvas.TextExtent not implemented');
//#UC END# *472744E803E3_473C3D830066_impl*
end;//Tl3Canvas.TextExtent

function Tl3Canvas.Pos2Index(W: Integer;
 const S: Tl3PCharLen): Integer;
 {* находит индекс символа на рассоянии W дюймов от начала строки S. }
//#UC START# *472894A001A6_473C3D830066_var*
//#UC END# *472894A001A6_473C3D830066_var*
begin
//#UC START# *472894A001A6_473C3D830066_impl*
 assert(false, 'Tl3Canvas.Pos2Index not implemented');
//#UC END# *472894A001A6_473C3D830066_impl*
end;//Tl3Canvas.Pos2Index

function Tl3Canvas.Pos2IndexQ(W: Integer;
 const S: Tl3PCharLen;
 var aNoTabs: Boolean): Integer;
 {* находит индекс символа на рассоянии W дюймов от начала строки S. }
//#UC START# *472894BA0258_473C3D830066_var*
//#UC END# *472894BA0258_473C3D830066_var*
begin
//#UC START# *472894BA0258_473C3D830066_impl*
 assert(false, 'Tl3Canvas.Pos2IndexQ not implemented');
//#UC END# *472894BA0258_473C3D830066_impl*
end;//Tl3Canvas.Pos2IndexQ

function Tl3Canvas.AverageCharHeight: Integer;
 {* средняя высота символов контекста в дюймах. }
//#UC START# *472894EA0166_473C3D830066_var*
//#UC END# *472894EA0166_473C3D830066_var*
begin
//#UC START# *472894EA0166_473C3D830066_impl*
 assert(false, 'Tl3Canvas.AverageCharHeight not implemented');
//#UC END# *472894EA0166_473C3D830066_impl*
end;//Tl3Canvas.AverageCharHeight

function Tl3Canvas.LP2DP(const P: Tl3_Point;
 NeedZoom: Boolean = False): Tl3SPoint;
 {* преобразует точку в дюймах в точку в пикселях. }
//#UC START# *4728950502EC_473C3D830066_var*
//#UC END# *4728950502EC_473C3D830066_var*
begin
//#UC START# *4728950502EC_473C3D830066_impl*
 assert(false, 'Tl3Canvas.LP2DP not implemented');
//#UC END# *4728950502EC_473C3D830066_impl*
end;//Tl3Canvas.LP2DP

function Tl3Canvas.LR2DR(const R: Tl3Rect): Tl3SRect;
 {* преобразует прямоугольник в дюймах в прямоугольник в пикселях. }
//#UC START# *472897C30237_473C3D830066_var*
//#UC END# *472897C30237_473C3D830066_var*
begin
//#UC START# *472897C30237_473C3D830066_impl*
 assert(false, 'Tl3Canvas.LR2DR not implemented');
//#UC END# *472897C30237_473C3D830066_impl*
end;//Tl3Canvas.LR2DR

function Tl3Canvas.DR2LR(const R: Tl3SRect): Tl3Rect;
 {* преобразует прямоугольник в пикселях в прямоугольник в дюймах. }
//#UC START# *472898020151_473C3D830066_var*
//#UC END# *472898020151_473C3D830066_var*
begin
//#UC START# *472898020151_473C3D830066_impl*
 assert(false, 'Tl3Canvas.DR2LR not implemented');
//#UC END# *472898020151_473C3D830066_impl*
end;//Tl3Canvas.DR2LR

procedure Tl3Canvas.Lock;
 {* начать работу с канвой. }
//#UC START# *4728980E02AD_473C3D830066_var*
//#UC END# *4728980E02AD_473C3D830066_var*
begin
//#UC START# *4728980E02AD_473C3D830066_impl*
 assert(false, 'Tl3Canvas.Lock not implemented');
//#UC END# *4728980E02AD_473C3D830066_impl*
end;//Tl3Canvas.Lock

procedure Tl3Canvas.Unlock;
 {* закончить работу с канвой. }
//#UC START# *4728981C0054_473C3D830066_var*
//#UC END# *4728981C0054_473C3D830066_var*
begin
//#UC START# *4728981C0054_473C3D830066_impl*
 assert(false, 'Tl3Canvas.Unlock not implemented');
//#UC END# *4728981C0054_473C3D830066_impl*
end;//Tl3Canvas.Unlock

function Tl3Canvas.GetKerning(const aSt: Tl3WString;
 Kerning: PLong): Tl3Point;
 {* получить размеры строки и таблицу кернинга. }
//#UC START# *47289B000379_473C3D830066_var*
//#UC END# *47289B000379_473C3D830066_var*
begin
//#UC START# *47289B000379_473C3D830066_impl*
 assert(false, 'Tl3Canvas.GetKerning not implemented');
//#UC END# *47289B000379_473C3D830066_impl*
end;//Tl3Canvas.GetKerning

function Tl3Canvas.OffsetRgn(const Rgn: Il3Region;
 const Pt: Tl3Point): Integer;
 {* сдвинуть регион. }
//#UC START# *4728A0840026_473C3D830066_var*
//#UC END# *4728A0840026_473C3D830066_var*
begin
//#UC START# *4728A0840026_473C3D830066_impl*
 assert(false, 'Tl3Canvas.OffsetRgn not implemented');
//#UC END# *4728A0840026_473C3D830066_impl*
end;//Tl3Canvas.OffsetRgn

function Tl3Canvas.CaretExtent: Tl3Point;
 {* размеры курсора. }
//#UC START# *4728A0C40082_473C3D830066_var*
//#UC END# *4728A0C40082_473C3D830066_var*
begin
//#UC START# *4728A0C40082_473C3D830066_impl*
 assert(false, 'Tl3Canvas.CaretExtent not implemented');
//#UC END# *4728A0C40082_473C3D830066_impl*
end;//Tl3Canvas.CaretExtent

procedure Tl3Canvas.StartTabs(out theTabInfo: Il3TabInfo;
 const aTabStops: Il3TabStops;
 aTabOffset: Integer = 0);
//#UC START# *4728A4A703CC_473C3D830066_var*
//#UC END# *4728A4A703CC_473C3D830066_var*
begin
//#UC START# *4728A4A703CC_473C3D830066_impl*
 assert(false, 'Tl3Canvas.StartTabs not implemented');
//#UC END# *4728A4A703CC_473C3D830066_impl*
end;//Tl3Canvas.StartTabs

procedure Tl3Canvas.StartTabs(out theTabInfo: Il3TabInfo;
 const aTabInfo: Il3TabInfo);
//#UC START# *4728A4D00013_473C3D830066_var*
//#UC END# *4728A4D00013_473C3D830066_var*
begin
//#UC START# *4728A4D00013_473C3D830066_impl*
 assert(false, 'Tl3Canvas.StartTabs not implemented');
//#UC END# *4728A4D00013_473C3D830066_impl*
end;//Tl3Canvas.StartTabs

procedure Tl3Canvas.FinishTabs(var aTabInfo: Il3TabInfo);
//#UC START# *4728A4DF0065_473C3D830066_var*
//#UC END# *4728A4DF0065_473C3D830066_var*
begin
//#UC START# *4728A4DF0065_473C3D830066_impl*
 assert(false, 'Tl3Canvas.FinishTabs not implemented');
//#UC END# *4728A4DF0065_473C3D830066_impl*
end;//Tl3Canvas.FinishTabs

function Tl3Canvas.TabInfo: Il3TabInfo;
//#UC START# *4728A4F602FD_473C3D830066_var*
//#UC END# *4728A4F602FD_473C3D830066_var*
begin
//#UC START# *4728A4F602FD_473C3D830066_impl*
 assert(false, 'Tl3Canvas.TabInfo not implemented');
//#UC END# *4728A4F602FD_473C3D830066_impl*
end;//Tl3Canvas.TabInfo

function Tl3Canvas.EQ(const aCanvas: Il3InfoCanvas): Boolean;
//#UC START# *4728A509016A_473C3D830066_var*
//#UC END# *4728A509016A_473C3D830066_var*
begin
//#UC START# *4728A509016A_473C3D830066_impl*
 assert(false, 'Tl3Canvas.EQ not implemented');
//#UC END# *4728A509016A_473C3D830066_impl*
end;//Tl3Canvas.EQ

function Tl3Canvas.NearestColor(C: Tl3Color): Tl3Color;
//#UC START# *4728A52B0385_473C3D830066_var*
//#UC END# *4728A52B0385_473C3D830066_var*
begin
//#UC START# *4728A52B0385_473C3D830066_impl*
 assert(false, 'Tl3Canvas.NearestColor not implemented');
//#UC END# *4728A52B0385_473C3D830066_impl*
end;//Tl3Canvas.NearestColor

function Tl3Canvas.DrawText(const aSt: Tl3WString;
 var R: TRect;
 aFormat: Cardinal;
 AFl: TObject = nil): Il3MultiLines;
 {* как ни глупо звучит, но это нужно на информационной канве, т.к. она вычисляет прямоугольник вывода. }
//#UC START# *4728A74F03A2_473C3D830066_var*
//#UC END# *4728A74F03A2_473C3D830066_var*
begin
//#UC START# *4728A74F03A2_473C3D830066_impl*
 assert(false, 'Tl3Canvas.DrawText not implemented');
//#UC END# *4728A74F03A2_473C3D830066_impl*
end;//Tl3Canvas.DrawText

procedure Tl3Canvas.TabbedMultilineTextOut(const aSt: Tl3WString;
 const Tabs: Il3TabStops;
 var Rect: Tl3Rect;
 Precalculate: Boolean;
 aGap: Integer);
 {* как ни глупо звучит, но это нужно на информационной канве, т.к. она вычисляет прямоугольник вывода. }
//#UC START# *4728A7BC0330_473C3D830066_var*
//#UC END# *4728A7BC0330_473C3D830066_var*
begin
//#UC START# *4728A7BC0330_473C3D830066_impl*
 assert(false, 'Tl3Canvas.TabbedMultilineTextOut not implemented');
//#UC END# *4728A7BC0330_473C3D830066_impl*
end;//Tl3Canvas.TabbedMultilineTextOut

procedure Tl3Canvas.PushBC;
//#UC START# *4728AD37017F_473C3D830066_var*
//#UC END# *4728AD37017F_473C3D830066_var*
begin
//#UC START# *4728AD37017F_473C3D830066_impl*
 assert(false, 'Tl3Canvas.PushBC not implemented');
//#UC END# *4728AD37017F_473C3D830066_impl*
end;//Tl3Canvas.PushBC

function Tl3Canvas.TopBC: Tl3Color;
//#UC START# *4728AD43021C_473C3D830066_var*
//#UC END# *4728AD43021C_473C3D830066_var*
begin
//#UC START# *4728AD43021C_473C3D830066_impl*
 assert(false, 'Tl3Canvas.TopBC not implemented');
//#UC END# *4728AD43021C_473C3D830066_impl*
end;//Tl3Canvas.TopBC

procedure Tl3Canvas.PopBC;
//#UC START# *4728AD580263_473C3D830066_var*
//#UC END# *4728AD580263_473C3D830066_var*
begin
//#UC START# *4728AD580263_473C3D830066_impl*
 assert(false, 'Tl3Canvas.PopBC not implemented');
//#UC END# *4728AD580263_473C3D830066_impl*
end;//Tl3Canvas.PopBC

procedure Tl3Canvas.PushFC;
//#UC START# *4728AD680067_473C3D830066_var*
//#UC END# *4728AD680067_473C3D830066_var*
begin
//#UC START# *4728AD680067_473C3D830066_impl*
 assert(false, 'Tl3Canvas.PushFC not implemented');
//#UC END# *4728AD680067_473C3D830066_impl*
end;//Tl3Canvas.PushFC

procedure Tl3Canvas.PopFC;
//#UC START# *4728AD760338_473C3D830066_var*
//#UC END# *4728AD760338_473C3D830066_var*
begin
//#UC START# *4728AD760338_473C3D830066_impl*
 assert(false, 'Tl3Canvas.PopFC not implemented');
//#UC END# *4728AD760338_473C3D830066_impl*
end;//Tl3Canvas.PopFC

function Tl3Canvas.TextMetrics: PTextMetric;
//#UC START# *4728ADF50313_473C3D830066_var*
//#UC END# *4728ADF50313_473C3D830066_var*
begin
//#UC START# *4728ADF50313_473C3D830066_impl*
 assert(false, 'Tl3Canvas.TextMetrics not implemented');
//#UC END# *4728ADF50313_473C3D830066_impl*
end;//Tl3Canvas.TextMetrics

function Tl3Canvas.Get_Font: Il3Font;
//#UC START# *4728AE20030A_473C3D830066get_var*
//#UC END# *4728AE20030A_473C3D830066get_var*
begin
//#UC START# *4728AE20030A_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Font not implemented');
//#UC END# *4728AE20030A_473C3D830066get_impl*
end;//Tl3Canvas.Get_Font

procedure Tl3Canvas.Set_Font(const aValue: Il3Font);
//#UC START# *4728AE20030A_473C3D830066set_var*
//#UC END# *4728AE20030A_473C3D830066set_var*
begin
//#UC START# *4728AE20030A_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.Set_Font not implemented');
//#UC END# *4728AE20030A_473C3D830066set_impl*
end;//Tl3Canvas.Set_Font

function Tl3Canvas.pm_GetDC: hDC;
//#UC START# *4728AE3E03B8_473C3D830066get_var*
//#UC END# *4728AE3E03B8_473C3D830066get_var*
begin
//#UC START# *4728AE3E03B8_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.pm_GetDC not implemented');
//#UC END# *4728AE3E03B8_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetDC

procedure Tl3Canvas.pm_SetDC(aValue: hDC);
//#UC START# *4728AE3E03B8_473C3D830066set_var*
//#UC END# *4728AE3E03B8_473C3D830066set_var*
begin
//#UC START# *4728AE3E03B8_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.pm_SetDC not implemented');
//#UC END# *4728AE3E03B8_473C3D830066set_impl*
end;//Tl3Canvas.pm_SetDC

function Tl3Canvas.pm_GetPixelsPerInchX: Integer;
//#UC START# *4728AE5D020E_473C3D830066get_var*
//#UC END# *4728AE5D020E_473C3D830066get_var*
begin
//#UC START# *4728AE5D020E_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.pm_GetPixelsPerInchX not implemented');
//#UC END# *4728AE5D020E_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetPixelsPerInchX

function Tl3Canvas.pm_GetPixelsPerInchY: Integer;
//#UC START# *4728AE6A01EE_473C3D830066get_var*
//#UC END# *4728AE6A01EE_473C3D830066get_var*
begin
//#UC START# *4728AE6A01EE_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.pm_GetPixelsPerInchY not implemented');
//#UC END# *4728AE6A01EE_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetPixelsPerInchY

procedure Tl3Canvas.MoveWindowOrg(const Delta: Tl3Point);
//#UC START# *4728AEC301D8_473C3D830066_var*
//#UC END# *4728AEC301D8_473C3D830066_var*
begin
//#UC START# *4728AEC301D8_473C3D830066_impl*
 assert(false, 'Tl3Canvas.MoveWindowOrg not implemented');
//#UC END# *4728AEC301D8_473C3D830066_impl*
end;//Tl3Canvas.MoveWindowOrg

procedure Tl3Canvas.MoveWindowOrg(const Delta: Tl3SPoint);
//#UC START# *4728AECD010B_473C3D830066_var*
//#UC END# *4728AECD010B_473C3D830066_var*
begin
//#UC START# *4728AECD010B_473C3D830066_impl*
 assert(false, 'Tl3Canvas.MoveWindowOrg not implemented');
//#UC END# *4728AECD010B_473C3D830066_impl*
end;//Tl3Canvas.MoveWindowOrg

procedure Tl3Canvas.FillForeRect(const R: Tl3SRect);
//#UC START# *4728AED70336_473C3D830066_var*
//#UC END# *4728AED70336_473C3D830066_var*
begin
//#UC START# *4728AED70336_473C3D830066_impl*
 assert(false, 'Tl3Canvas.FillForeRect not implemented');
//#UC END# *4728AED70336_473C3D830066_impl*
end;//Tl3Canvas.FillForeRect

procedure Tl3Canvas.FillRect(const R: Tl3SRect);
//#UC START# *4728AF3E03AC_473C3D830066_var*
//#UC END# *4728AF3E03AC_473C3D830066_var*
begin
//#UC START# *4728AF3E03AC_473C3D830066_impl*
 assert(false, 'Tl3Canvas.FillRect not implemented');
//#UC END# *4728AF3E03AC_473C3D830066_impl*
end;//Tl3Canvas.FillRect

procedure Tl3Canvas.FillRect(const R: Tl3Rect);
//#UC START# *4728AF5103A9_473C3D830066_var*
//#UC END# *4728AF5103A9_473C3D830066_var*
begin
//#UC START# *4728AF5103A9_473C3D830066_impl*
 assert(false, 'Tl3Canvas.FillRect not implemented');
//#UC END# *4728AF5103A9_473C3D830066_impl*
end;//Tl3Canvas.FillRect

procedure Tl3Canvas.FillEmptyRect(const R: Tl3Rect);
//#UC START# *4728B590009B_473C3D830066_var*
//#UC END# *4728B590009B_473C3D830066_var*
begin
//#UC START# *4728B590009B_473C3D830066_impl*
 assert(false, 'Tl3Canvas.FillEmptyRect not implemented');
//#UC END# *4728B590009B_473C3D830066_impl*
end;//Tl3Canvas.FillEmptyRect

procedure Tl3Canvas.FillEmptyRect(const R: Tl3SRect);
//#UC START# *4728B59A000A_473C3D830066_var*
//#UC END# *4728B59A000A_473C3D830066_var*
begin
//#UC START# *4728B59A000A_473C3D830066_impl*
 assert(false, 'Tl3Canvas.FillEmptyRect not implemented');
//#UC END# *4728B59A000A_473C3D830066_impl*
end;//Tl3Canvas.FillEmptyRect

function Tl3Canvas.FillRgn(const Region: Il3Region): Boolean;
//#UC START# *4728B5A50041_473C3D830066_var*
//#UC END# *4728B5A50041_473C3D830066_var*
begin
//#UC START# *4728B5A50041_473C3D830066_impl*
 assert(false, 'Tl3Canvas.FillRgn not implemented');
//#UC END# *4728B5A50041_473C3D830066_impl*
end;//Tl3Canvas.FillRgn

function Tl3Canvas.TextOut(const P: Tl3Point;
 const S: Tl3PCharLen;
 FC: Tl3Color = clDefault;
 BC: Tl3Color = clDefault): Tl3Point;
//#UC START# *4728B5B5026B_473C3D830066_var*
//#UC END# *4728B5B5026B_473C3D830066_var*
begin
//#UC START# *4728B5B5026B_473C3D830066_impl*
 assert(false, 'Tl3Canvas.TextOut not implemented');
//#UC END# *4728B5B5026B_473C3D830066_impl*
end;//Tl3Canvas.TextOut

procedure Tl3Canvas.SetCaret(const Origin: Tl3Point;
 const Extent: Tl3Point;
 Hidden: Boolean = False);
//#UC START# *4728B5EB01A1_473C3D830066_var*
//#UC END# *4728B5EB01A1_473C3D830066_var*
begin
//#UC START# *4728B5EB01A1_473C3D830066_impl*
 assert(false, 'Tl3Canvas.SetCaret not implemented');
//#UC END# *4728B5EB01A1_473C3D830066_impl*
end;//Tl3Canvas.SetCaret

procedure Tl3Canvas.IncCaret(aDeltaX: Integer);
//#UC START# *4728B60F0211_473C3D830066_var*
//#UC END# *4728B60F0211_473C3D830066_var*
begin
//#UC START# *4728B60F0211_473C3D830066_impl*
 assert(false, 'Tl3Canvas.IncCaret not implemented');
//#UC END# *4728B60F0211_473C3D830066_impl*
end;//Tl3Canvas.IncCaret

procedure Tl3Canvas.BeginPaint;
//#UC START# *4728B61D0058_473C3D830066_var*
//#UC END# *4728B61D0058_473C3D830066_var*
begin
//#UC START# *4728B61D0058_473C3D830066_impl*
 assert(false, 'Tl3Canvas.BeginPaint not implemented');
//#UC END# *4728B61D0058_473C3D830066_impl*
end;//Tl3Canvas.BeginPaint

procedure Tl3Canvas.StartObject(anObjectID: Integer);
//#UC START# *4728B62702C9_473C3D830066_var*
//#UC END# *4728B62702C9_473C3D830066_var*
begin
//#UC START# *4728B62702C9_473C3D830066_impl*
 assert(false, 'Tl3Canvas.StartObject not implemented');
//#UC END# *4728B62702C9_473C3D830066_impl*
end;//Tl3Canvas.StartObject

procedure Tl3Canvas.SetPageTop;
//#UC START# *4728B637025E_473C3D830066_var*
//#UC END# *4728B637025E_473C3D830066_var*
begin
//#UC START# *4728B637025E_473C3D830066_impl*
 assert(false, 'Tl3Canvas.SetPageTop not implemented');
//#UC END# *4728B637025E_473C3D830066_impl*
end;//Tl3Canvas.SetPageTop

procedure Tl3Canvas.EndPaint;
//#UC START# *4728B67C0037_473C3D830066_var*
//#UC END# *4728B67C0037_473C3D830066_var*
begin
//#UC START# *4728B67C0037_473C3D830066_impl*
 assert(false, 'Tl3Canvas.EndPaint not implemented');
//#UC END# *4728B67C0037_473C3D830066_impl*
end;//Tl3Canvas.EndPaint

procedure Tl3Canvas.BeginInvert;
//#UC START# *4728B68502C5_473C3D830066_var*
//#UC END# *4728B68502C5_473C3D830066_var*
begin
//#UC START# *4728B68502C5_473C3D830066_impl*
 assert(false, 'Tl3Canvas.BeginInvert not implemented');
//#UC END# *4728B68502C5_473C3D830066_impl*
end;//Tl3Canvas.BeginInvert

procedure Tl3Canvas.EndInvert;
//#UC START# *4728B68C0329_473C3D830066_var*
//#UC END# *4728B68C0329_473C3D830066_var*
begin
//#UC START# *4728B68C0329_473C3D830066_impl*
 assert(false, 'Tl3Canvas.EndInvert not implemented');
//#UC END# *4728B68C0329_473C3D830066_impl*
end;//Tl3Canvas.EndInvert

function Tl3Canvas.DrawRgnOrBlock: Boolean;
//#UC START# *4728B6B501C9_473C3D830066_var*
//#UC END# *4728B6B501C9_473C3D830066_var*
begin
//#UC START# *4728B6B501C9_473C3D830066_impl*
 assert(false, 'Tl3Canvas.DrawRgnOrBlock not implemented');
//#UC END# *4728B6B501C9_473C3D830066_impl*
end;//Tl3Canvas.DrawRgnOrBlock

function Tl3Canvas.HasToDraw: Boolean;
//#UC START# *4728B6DD013A_473C3D830066_var*
//#UC END# *4728B6DD013A_473C3D830066_var*
begin
//#UC START# *4728B6DD013A_473C3D830066_impl*
 assert(false, 'Tl3Canvas.HasToDraw not implemented');
//#UC END# *4728B6DD013A_473C3D830066_impl*
end;//Tl3Canvas.HasToDraw

procedure Tl3Canvas.StretchDraw(const R: Tl3Rect;
 Graphic: VCLGraphic);
//#UC START# *4728B6ED0101_473C3D830066_var*
//#UC END# *4728B6ED0101_473C3D830066_var*
begin
//#UC START# *4728B6ED0101_473C3D830066_impl*
 assert(false, 'Tl3Canvas.StretchDraw not implemented');
//#UC END# *4728B6ED0101_473C3D830066_impl*
end;//Tl3Canvas.StretchDraw

procedure Tl3Canvas.DrawSub(aSubTarget: TObject;
 const R: Tl3Rect;
 LayerHandle: Integer;
 aSub: TObject);
//#UC START# *4728B97800C0_473C3D830066_var*
//#UC END# *4728B97800C0_473C3D830066_var*
begin
//#UC START# *4728B97800C0_473C3D830066_impl*
 assert(false, 'Tl3Canvas.DrawSub not implemented');
//#UC END# *4728B97800C0_473C3D830066_impl*
end;//Tl3Canvas.DrawSub

procedure Tl3Canvas.ExtTextOut(const P: Tl3Point;
 const R: Tl3Rect;
 const S: Tl3WString;
 F: Tl3TextFormatFlag = l3_tffLeft;
 Dx: PInteger = nil);
//#UC START# *4728B9F10060_473C3D830066_var*
//#UC END# *4728B9F10060_473C3D830066_var*
begin
//#UC START# *4728B9F10060_473C3D830066_impl*
 assert(false, 'Tl3Canvas.ExtTextOut not implemented');
//#UC END# *4728B9F10060_473C3D830066_impl*
end;//Tl3Canvas.ExtTextOut

procedure Tl3Canvas.ExtTextOut(const P: Tl3SPoint;
 const R: Tl3SRect;
 const S: Tl3WString;
 F: Tl3TextFormatFlag = l3_tffLeft;
 Dx: PInteger = nil);
//#UC START# *4728BAAC0127_473C3D830066_var*
//#UC END# *4728BAAC0127_473C3D830066_var*
begin
//#UC START# *4728BAAC0127_473C3D830066_impl*
 assert(false, 'Tl3Canvas.ExtTextOut not implemented');
//#UC END# *4728BAAC0127_473C3D830066_impl*
end;//Tl3Canvas.ExtTextOut

function Tl3Canvas.CaretLineOut(const aSt: Tl3WString;
 LineHeight: Integer;
 aHidden: Boolean;
 var CaretPos: Integer): Tl3Point;
 {* выводит строку текста высотой LineHeight, со сдвигом курсора отрисовки. устанавливает курсор в CaretPos. возвращает размеры выведенной строки. }
//#UC START# *4728BAD601DC_473C3D830066_var*
//#UC END# *4728BAD601DC_473C3D830066_var*
begin
//#UC START# *4728BAD601DC_473C3D830066_impl*
 assert(false, 'Tl3Canvas.CaretLineOut not implemented');
//#UC END# *4728BAD601DC_473C3D830066_impl*
end;//Tl3Canvas.CaretLineOut

function Tl3Canvas.StringOut(const P: Tl3Point;
 const Text: Tl3WString): Tl3Point;
//#UC START# *4728BB120156_473C3D830066_var*
//#UC END# *4728BB120156_473C3D830066_var*
begin
//#UC START# *4728BB120156_473C3D830066_impl*
 assert(false, 'Tl3Canvas.StringOut not implemented');
//#UC END# *4728BB120156_473C3D830066_impl*
end;//Tl3Canvas.StringOut

procedure Tl3Canvas.TabbedTextOut(const P: Tl3Point;
 const R: Tl3Rect;
 const S: Tl3WString;
 const aTabStops: Il3TabStops);
//#UC START# *4728BB2D0173_473C3D830066_var*
//#UC END# *4728BB2D0173_473C3D830066_var*
begin
//#UC START# *4728BB2D0173_473C3D830066_impl*
 assert(false, 'Tl3Canvas.TabbedTextOut not implemented');
//#UC END# *4728BB2D0173_473C3D830066_impl*
end;//Tl3Canvas.TabbedTextOut

procedure Tl3Canvas.TabbedTextOut(const P: Tl3SPoint;
 const R: Tl3SRect;
 const S: Tl3WString;
 const aTabStops: Il3TabStops);
//#UC START# *4728BB8F03CD_473C3D830066_var*
//#UC END# *4728BB8F03CD_473C3D830066_var*
begin
//#UC START# *4728BB8F03CD_473C3D830066_impl*
 assert(false, 'Tl3Canvas.TabbedTextOut not implemented');
//#UC END# *4728BB8F03CD_473C3D830066_impl*
end;//Tl3Canvas.TabbedTextOut

function Tl3Canvas.NewPage(ByWidth: Boolean = False): Boolean;
 {* начать новую страницу. }
//#UC START# *4728BBAF00BB_473C3D830066_var*
//#UC END# *4728BBAF00BB_473C3D830066_var*
begin
//#UC START# *4728BBAF00BB_473C3D830066_impl*
 assert(false, 'Tl3Canvas.NewPage not implemented');
//#UC END# *4728BBAF00BB_473C3D830066_impl*
end;//Tl3Canvas.NewPage

procedure Tl3Canvas.Line(const A: Tl3Point;
 const B: Tl3Point);
 {* нарисовать линию. }
//#UC START# *4728BBC80252_473C3D830066_var*
//#UC END# *4728BBC80252_473C3D830066_var*
begin
//#UC START# *4728BBC80252_473C3D830066_impl*
 assert(false, 'Tl3Canvas.Line not implemented');
//#UC END# *4728BBC80252_473C3D830066_impl*
end;//Tl3Canvas.Line

procedure Tl3Canvas.Line(const A: Tl3SPoint;
 const B: Tl3SPoint);
 {* нарисовать линию. }
//#UC START# *4728BBE702D9_473C3D830066_var*
//#UC END# *4728BBE702D9_473C3D830066_var*
begin
//#UC START# *4728BBE702D9_473C3D830066_impl*
 assert(false, 'Tl3Canvas.Line not implemented');
//#UC END# *4728BBE702D9_473C3D830066_impl*
end;//Tl3Canvas.Line

procedure Tl3Canvas.MoveTo(const Pt: Tl3Point);
//#UC START# *4728BC06000C_473C3D830066_var*
//#UC END# *4728BC06000C_473C3D830066_var*
begin
//#UC START# *4728BC06000C_473C3D830066_impl*
 assert(false, 'Tl3Canvas.MoveTo not implemented');
//#UC END# *4728BC06000C_473C3D830066_impl*
end;//Tl3Canvas.MoveTo

procedure Tl3Canvas.LineTo(const Pt: Tl3Point);
//#UC START# *4728BC0E0249_473C3D830066_var*
//#UC END# *4728BC0E0249_473C3D830066_var*
begin
//#UC START# *4728BC0E0249_473C3D830066_impl*
 assert(false, 'Tl3Canvas.LineTo not implemented');
//#UC END# *4728BC0E0249_473C3D830066_impl*
end;//Tl3Canvas.LineTo

procedure Tl3Canvas.MoveTo(const Pt: Tl3SPoint);
//#UC START# *4728BC18022F_473C3D830066_var*
//#UC END# *4728BC18022F_473C3D830066_var*
begin
//#UC START# *4728BC18022F_473C3D830066_impl*
 assert(false, 'Tl3Canvas.MoveTo not implemented');
//#UC END# *4728BC18022F_473C3D830066_impl*
end;//Tl3Canvas.MoveTo

procedure Tl3Canvas.LineTo(const Pt: Tl3SPoint);
//#UC START# *4728BC2103A4_473C3D830066_var*
//#UC END# *4728BC2103A4_473C3D830066_var*
begin
//#UC START# *4728BC2103A4_473C3D830066_impl*
 assert(false, 'Tl3Canvas.LineTo not implemented');
//#UC END# *4728BC2103A4_473C3D830066_impl*
end;//Tl3Canvas.LineTo

function Tl3Canvas.WO(const aRect: Tl3Rect): Tl3SRect;
//#UC START# *4728BC4B02FB_473C3D830066_var*
//#UC END# *4728BC4B02FB_473C3D830066_var*
begin
//#UC START# *4728BC4B02FB_473C3D830066_impl*
 assert(false, 'Tl3Canvas.WO not implemented');
//#UC END# *4728BC4B02FB_473C3D830066_impl*
end;//Tl3Canvas.WO

function Tl3Canvas.WO(const aPt: Tl3Point): Tl3SPoint;
//#UC START# *4728BC54039E_473C3D830066_var*
//#UC END# *4728BC54039E_473C3D830066_var*
begin
//#UC START# *4728BC54039E_473C3D830066_impl*
 assert(false, 'Tl3Canvas.WO not implemented');
//#UC END# *4728BC54039E_473C3D830066_impl*
end;//Tl3Canvas.WO

function Tl3Canvas.WO(const aPt: Tl3SPoint): Tl3SPoint;
//#UC START# *4728BC61002B_473C3D830066_var*
//#UC END# *4728BC61002B_473C3D830066_var*
begin
//#UC START# *4728BC61002B_473C3D830066_impl*
 assert(false, 'Tl3Canvas.WO not implemented');
//#UC END# *4728BC61002B_473C3D830066_impl*
end;//Tl3Canvas.WO

procedure Tl3Canvas.DrawFocusRect(const aRect: Tl3SRect);
//#UC START# *4728BC6A0088_473C3D830066_var*
//#UC END# *4728BC6A0088_473C3D830066_var*
begin
//#UC START# *4728BC6A0088_473C3D830066_impl*
 assert(false, 'Tl3Canvas.DrawFocusRect not implemented');
//#UC END# *4728BC6A0088_473C3D830066_impl*
end;//Tl3Canvas.DrawFocusRect

function Tl3Canvas.IsVirtual: Boolean;
//#UC START# *4728BC74029F_473C3D830066_var*
//#UC END# *4728BC74029F_473C3D830066_var*
begin
//#UC START# *4728BC74029F_473C3D830066_impl*
 assert(false, 'Tl3Canvas.IsVirtual not implemented');
//#UC END# *4728BC74029F_473C3D830066_impl*
end;//Tl3Canvas.IsVirtual

procedure Tl3Canvas.StartRegion;
//#UC START# *4728BC81028A_473C3D830066_var*
//#UC END# *4728BC81028A_473C3D830066_var*
begin
//#UC START# *4728BC81028A_473C3D830066_impl*
 assert(false, 'Tl3Canvas.StartRegion not implemented');
//#UC END# *4728BC81028A_473C3D830066_impl*
end;//Tl3Canvas.StartRegion

procedure Tl3Canvas.FinishRegion;
//#UC START# *4728BC890119_473C3D830066_var*
//#UC END# *4728BC890119_473C3D830066_var*
begin
//#UC START# *4728BC890119_473C3D830066_impl*
 assert(false, 'Tl3Canvas.FinishRegion not implemented');
//#UC END# *4728BC890119_473C3D830066_impl*
end;//Tl3Canvas.FinishRegion

procedure Tl3Canvas.PushWO;
//#UC START# *4728BC9A022C_473C3D830066_var*
//#UC END# *4728BC9A022C_473C3D830066_var*
begin
//#UC START# *4728BC9A022C_473C3D830066_impl*
 assert(false, 'Tl3Canvas.PushWO not implemented');
//#UC END# *4728BC9A022C_473C3D830066_impl*
end;//Tl3Canvas.PushWO

procedure Tl3Canvas.PopWO;
//#UC START# *4728BCB60128_473C3D830066_var*
//#UC END# *4728BCB60128_473C3D830066_var*
begin
//#UC START# *4728BCB60128_473C3D830066_impl*
 assert(false, 'Tl3Canvas.PopWO not implemented');
//#UC END# *4728BCB60128_473C3D830066_impl*
end;//Tl3Canvas.PopWO

function Tl3Canvas.pm_GetWindowOrg: Tl3Point;
//#UC START# *4728BCF0038E_473C3D830066get_var*
//#UC END# *4728BCF0038E_473C3D830066get_var*
begin
//#UC START# *4728BCF0038E_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.pm_GetWindowOrg not implemented');
//#UC END# *4728BCF0038E_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetWindowOrg

procedure Tl3Canvas.pm_SetWindowOrg(const aValue: Tl3Point);
//#UC START# *4728BCF0038E_473C3D830066set_var*
//#UC END# *4728BCF0038E_473C3D830066set_var*
begin
//#UC START# *4728BCF0038E_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.pm_SetWindowOrg not implemented');
//#UC END# *4728BCF0038E_473C3D830066set_impl*
end;//Tl3Canvas.pm_SetWindowOrg

function Tl3Canvas.pm_GetSWindowOrg: Tl3SPoint;
//#UC START# *4728BCFF03D6_473C3D830066get_var*
//#UC END# *4728BCFF03D6_473C3D830066get_var*
begin
//#UC START# *4728BCFF03D6_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.pm_GetSWindowOrg not implemented');
//#UC END# *4728BCFF03D6_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetSWindowOrg

procedure Tl3Canvas.pm_SetSWindowOrg(const aValue: Tl3SPoint);
//#UC START# *4728BCFF03D6_473C3D830066set_var*
//#UC END# *4728BCFF03D6_473C3D830066set_var*
begin
//#UC START# *4728BCFF03D6_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.pm_SetSWindowOrg not implemented');
//#UC END# *4728BCFF03D6_473C3D830066set_impl*
end;//Tl3Canvas.pm_SetSWindowOrg

function Tl3Canvas.pm_GetClipRect: Tl3Rect;
//#UC START# *4728BD12038D_473C3D830066get_var*
//#UC END# *4728BD12038D_473C3D830066get_var*
begin
//#UC START# *4728BD12038D_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.pm_GetClipRect not implemented');
//#UC END# *4728BD12038D_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetClipRect

procedure Tl3Canvas.pm_SetClipRect(const aValue: Tl3Rect);
//#UC START# *4728BD12038D_473C3D830066set_var*
//#UC END# *4728BD12038D_473C3D830066set_var*
begin
//#UC START# *4728BD12038D_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.pm_SetClipRect not implemented');
//#UC END# *4728BD12038D_473C3D830066set_impl*
end;//Tl3Canvas.pm_SetClipRect

function Tl3Canvas.pm_GetGlobalClipRect: Tl3Rect;
//#UC START# *4728BD2703E7_473C3D830066get_var*
//#UC END# *4728BD2703E7_473C3D830066get_var*
begin
//#UC START# *4728BD2703E7_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.pm_GetGlobalClipRect not implemented');
//#UC END# *4728BD2703E7_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetGlobalClipRect

function Tl3Canvas.pm_GetBackColor: Tl3Color;
//#UC START# *4728BD3800A2_473C3D830066get_var*
//#UC END# *4728BD3800A2_473C3D830066get_var*
begin
//#UC START# *4728BD3800A2_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.pm_GetBackColor not implemented');
//#UC END# *4728BD3800A2_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetBackColor

procedure Tl3Canvas.pm_SetBackColor(aValue: Tl3Color);
//#UC START# *4728BD3800A2_473C3D830066set_var*
//#UC END# *4728BD3800A2_473C3D830066set_var*
begin
//#UC START# *4728BD3800A2_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.pm_SetBackColor not implemented');
//#UC END# *4728BD3800A2_473C3D830066set_impl*
end;//Tl3Canvas.pm_SetBackColor

function Tl3Canvas.pm_GetDrawEnabled: Boolean;
//#UC START# *4728BD560290_473C3D830066get_var*
//#UC END# *4728BD560290_473C3D830066get_var*
begin
//#UC START# *4728BD560290_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.pm_GetDrawEnabled not implemented');
//#UC END# *4728BD560290_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetDrawEnabled

procedure Tl3Canvas.pm_SetDrawEnabled(aValue: Boolean);
//#UC START# *4728BD560290_473C3D830066set_var*
//#UC END# *4728BD560290_473C3D830066set_var*
begin
//#UC START# *4728BD560290_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.pm_SetDrawEnabled not implemented');
//#UC END# *4728BD560290_473C3D830066set_impl*
end;//Tl3Canvas.pm_SetDrawEnabled

function Tl3Canvas.pm_GetDrawSpecial: Boolean;
//#UC START# *4728BD890258_473C3D830066get_var*
//#UC END# *4728BD890258_473C3D830066get_var*
begin
//#UC START# *4728BD890258_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.pm_GetDrawSpecial not implemented');
//#UC END# *4728BD890258_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetDrawSpecial

function Tl3Canvas.pm_GetCanDrawSubs: Boolean;
//#UC START# *4728BD9F0227_473C3D830066get_var*
//#UC END# *4728BD9F0227_473C3D830066get_var*
begin
//#UC START# *4728BD9F0227_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.pm_GetCanDrawSubs not implemented');
//#UC END# *4728BD9F0227_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetCanDrawSubs

function Tl3Canvas.pm_GetShowCursor: Boolean;
//#UC START# *4728BDB301F4_473C3D830066get_var*
//#UC END# *4728BDB301F4_473C3D830066get_var*
begin
//#UC START# *4728BDB301F4_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.pm_GetShowCursor not implemented');
//#UC END# *4728BDB301F4_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetShowCursor

procedure Tl3Canvas.pm_SetShowCursor(aValue: Boolean);
//#UC START# *4728BDB301F4_473C3D830066set_var*
//#UC END# *4728BDB301F4_473C3D830066set_var*
begin
//#UC START# *4728BDB301F4_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.pm_SetShowCursor not implemented');
//#UC END# *4728BDB301F4_473C3D830066set_impl*
end;//Tl3Canvas.pm_SetShowCursor

function Tl3Canvas.pm_GetFontIndexSet: Tl3FontIndexes;
//#UC START# *4728BE1500AA_473C3D830066get_var*
//#UC END# *4728BE1500AA_473C3D830066get_var*
begin
//#UC START# *4728BE1500AA_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.pm_GetFontIndexSet not implemented');
//#UC END# *4728BE1500AA_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetFontIndexSet

procedure Tl3Canvas.pm_SetFontIndexSet(aValue: Tl3FontIndexes);
//#UC START# *4728BE1500AA_473C3D830066set_var*
//#UC END# *4728BE1500AA_473C3D830066set_var*
begin
//#UC START# *4728BE1500AA_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.pm_SetFontIndexSet not implemented');
//#UC END# *4728BE1500AA_473C3D830066set_impl*
end;//Tl3Canvas.pm_SetFontIndexSet

function Tl3Canvas.pm_GetPrinted: Boolean;
//#UC START# *4728BE460354_473C3D830066get_var*
//#UC END# *4728BE460354_473C3D830066get_var*
begin
//#UC START# *4728BE460354_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.pm_GetPrinted not implemented');
//#UC END# *4728BE460354_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetPrinted

procedure Tl3Canvas.pm_SetPrinted(aValue: Boolean);
//#UC START# *4728BE460354_473C3D830066set_var*
//#UC END# *4728BE460354_473C3D830066set_var*
begin
//#UC START# *4728BE460354_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.pm_SetPrinted not implemented');
//#UC END# *4728BE460354_473C3D830066set_impl*
end;//Tl3Canvas.pm_SetPrinted

function Tl3Canvas.pm_GetPenWidth: Integer;
//#UC START# *4728C0510003_473C3D830066get_var*
//#UC END# *4728C0510003_473C3D830066get_var*
begin
//#UC START# *4728C0510003_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.pm_GetPenWidth not implemented');
//#UC END# *4728C0510003_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetPenWidth

function Tl3Canvas.pm_GetPageOrientation: Tl3PageOrientation;
//#UC START# *4728C06D0306_473C3D830066get_var*
//#UC END# *4728C06D0306_473C3D830066get_var*
begin
//#UC START# *4728C06D0306_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.pm_GetPageOrientation not implemented');
//#UC END# *4728C06D0306_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetPageOrientation

procedure Tl3Canvas.pm_SetPageOrientation(aValue: Tl3PageOrientation);
//#UC START# *4728C06D0306_473C3D830066set_var*
//#UC END# *4728C06D0306_473C3D830066set_var*
begin
//#UC START# *4728C06D0306_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.pm_SetPageOrientation not implemented');
//#UC END# *4728C06D0306_473C3D830066set_impl*
end;//Tl3Canvas.pm_SetPageOrientation

function Tl3Canvas.pm_GetSectionExtent: Tl3Point;
//#UC START# *4728C0890017_473C3D830066get_var*
//#UC END# *4728C0890017_473C3D830066get_var*
begin
//#UC START# *4728C0890017_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.pm_GetSectionExtent not implemented');
//#UC END# *4728C0890017_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetSectionExtent

procedure Tl3Canvas.pm_SetSectionExtent(const aValue: Tl3Point);
//#UC START# *4728C0890017_473C3D830066set_var*
//#UC END# *4728C0890017_473C3D830066set_var*
begin
//#UC START# *4728C0890017_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.pm_SetSectionExtent not implemented');
//#UC END# *4728C0890017_473C3D830066set_impl*
end;//Tl3Canvas.pm_SetSectionExtent

procedure Tl3Canvas.pm_SetNotFocused(aValue: Boolean);
//#UC START# *4728C0BB013B_473C3D830066set_var*
//#UC END# *4728C0BB013B_473C3D830066set_var*
begin
//#UC START# *4728C0BB013B_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.pm_SetNotFocused not implemented');
//#UC END# *4728C0BB013B_473C3D830066set_impl*
end;//Tl3Canvas.pm_SetNotFocused

function Tl3Canvas.pm_GetRegionBottomRight: Tl3Point;
//#UC START# *4728C0C90182_473C3D830066get_var*
//#UC END# *4728C0C90182_473C3D830066get_var*
begin
//#UC START# *4728C0C90182_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.pm_GetRegionBottomRight not implemented');
//#UC END# *4728C0C90182_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetRegionBottomRight

function Tl3Canvas.IsAtomic: Boolean;
 {* Строка для нанного шрифта представляет собой единый объект? }
//#UC START# *475E5BAD0198_473C3D830066_var*
//#UC END# *475E5BAD0198_473C3D830066_var*
begin
//#UC START# *475E5BAD0198_473C3D830066_impl*
 assert(false, 'Tl3Canvas.IsAtomic not implemented');
//#UC END# *475E5BAD0198_473C3D830066_impl*
end;//Tl3Canvas.IsAtomic

function Tl3Canvas.FM: Il3FontMetrics;
 {* Метрики шрифта. }
//#UC START# *475E5BED0118_473C3D830066_var*
//#UC END# *475E5BED0118_473C3D830066_var*
begin
//#UC START# *475E5BED0118_473C3D830066_impl*
 assert(false, 'Tl3Canvas.FM not implemented');
//#UC END# *475E5BED0118_473C3D830066_impl*
end;//Tl3Canvas.FM

function Tl3Canvas.GetClientRect: Tl3Rect;
//#UC START# *476FA1140319_473C3D830066_var*
//#UC END# *476FA1140319_473C3D830066_var*
begin
//#UC START# *476FA1140319_473C3D830066_impl*
 assert(false, 'Tl3Canvas.GetClientRect not implemented');
//#UC END# *476FA1140319_473C3D830066_impl*
end;//Tl3Canvas.GetClientRect

function Tl3Canvas.AdjustMarginsByPrintableArea(const aMargins: Tl3_Rect): Tl3_Rect;
 {* Откорректировать поля с учетом непечатаемой области }
//#UC START# *4776171C037B_473C3D830066_var*
//#UC END# *4776171C037B_473C3D830066_var*
begin
//#UC START# *4776171C037B_473C3D830066_impl*
 assert(false, 'Tl3Canvas.AdjustMarginsByPrintableArea not implemented');
//#UC END# *4776171C037B_473C3D830066_impl*
end;//Tl3Canvas.AdjustMarginsByPrintableArea

function Tl3Canvas.Get_PasswordChar: AnsiChar;
//#UC START# *483D1BCA0045_473C3D830066get_var*
//#UC END# *483D1BCA0045_473C3D830066get_var*
begin
//#UC START# *483D1BCA0045_473C3D830066get_impl*
 !!! Needs to be implemented !!!
//#UC END# *483D1BCA0045_473C3D830066get_impl*
end;//Tl3Canvas.Get_PasswordChar

procedure Tl3Canvas.Set_PasswordChar(aValue: AnsiChar);
//#UC START# *483D1BCA0045_473C3D830066set_var*
//#UC END# *483D1BCA0045_473C3D830066set_var*
begin
//#UC START# *483D1BCA0045_473C3D830066set_impl*
 !!! Needs to be implemented !!!
//#UC END# *483D1BCA0045_473C3D830066set_impl*
end;//Tl3Canvas.Set_PasswordChar

function Tl3Canvas.Get_EffectiveColors: Il3EffectiveColors;
//#UC START# *487CFBE202B1_473C3D830066get_var*
//#UC END# *487CFBE202B1_473C3D830066get_var*
begin
//#UC START# *487CFBE202B1_473C3D830066get_impl*
 !!! Needs to be implemented !!!
//#UC END# *487CFBE202B1_473C3D830066get_impl*
end;//Tl3Canvas.Get_EffectiveColors

function Tl3Canvas.pm_GetPrinting: Boolean;
//#UC START# *4897E01001E7_473C3D830066get_var*
//#UC END# *4897E01001E7_473C3D830066get_var*
begin
//#UC START# *4897E01001E7_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.pm_GetPrinting not implemented');
//#UC END# *4897E01001E7_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetPrinting

function Tl3Canvas.CheckConvertString(const aStr: Tl3PCharLen): Tl3PCharLen;
 {* преобразует строку для отображения форматирующей информации в режиме DrawSpecial. }
//#UC START# *4A0BD46901A0_473C3D830066_var*
//#UC END# *4A0BD46901A0_473C3D830066_var*
begin
//#UC START# *4A0BD46901A0_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A0BD46901A0_473C3D830066_impl*
end;//Tl3Canvas.CheckConvertString

function Tl3Canvas.CheckOutString(const aStr: Tl3PCharLen): Tl3PCharLen;
//#UC START# *4A0BD4D4007E_473C3D830066_var*
//#UC END# *4A0BD4D4007E_473C3D830066_var*
begin
//#UC START# *4A0BD4D4007E_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A0BD4D4007E_473C3D830066_impl*
end;//Tl3Canvas.CheckOutString

function Tl3Canvas.pm_GetZoom: Integer;
//#UC START# *4A4B894303D5_473C3D830066get_var*
//#UC END# *4A4B894303D5_473C3D830066get_var*
begin
//#UC START# *4A4B894303D5_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.pm_GetZoom not implemented');
//#UC END# *4A4B894303D5_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetZoom

procedure Tl3Canvas.pm_SetZoom(aValue: Integer);
//#UC START# *4A4B894303D5_473C3D830066set_var*
//#UC END# *4A4B894303D5_473C3D830066set_var*
begin
//#UC START# *4A4B894303D5_473C3D830066set_impl*
 assert(false, 'Tl3Canvas.pm_SetZoom not implemented');
//#UC END# *4A4B894303D5_473C3D830066set_impl*
end;//Tl3Canvas.pm_SetZoom

function Tl3Canvas.DeviceCaps(anIndex: Integer): Integer;
//#UC START# *4A4CC70C03D2_473C3D830066_var*
//#UC END# *4A4CC70C03D2_473C3D830066_var*
begin
//#UC START# *4A4CC70C03D2_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A4CC70C03D2_473C3D830066_impl*
end;//Tl3Canvas.DeviceCaps

function Tl3Canvas.AsIl3Canvas: Il3Canvas;
//#UC START# *4A4CCF9202D9_473C3D830066_var*
//#UC END# *4A4CCF9202D9_473C3D830066_var*
begin
//#UC START# *4A4CCF9202D9_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A4CCF9202D9_473C3D830066_impl*
end;//Tl3Canvas.AsIl3Canvas

function Tl3Canvas.pm_GetPageSetup: Il3PageSetup;
//#UC START# *4A4CD86601B2_473C3D830066get_var*
//#UC END# *4A4CD86601B2_473C3D830066get_var*
begin
//#UC START# *4A4CD86601B2_473C3D830066get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A4CD86601B2_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetPageSetup

procedure Tl3Canvas.pm_SetPainter(const aValue: Il3HAFPainter);
//#UC START# *4A4CD8BC027E_473C3D830066set_var*
//#UC END# *4A4CD8BC027E_473C3D830066set_var*
begin
//#UC START# *4A4CD8BC027E_473C3D830066set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A4CD8BC027E_473C3D830066set_impl*
end;//Tl3Canvas.pm_SetPainter

function Tl3Canvas.pm_GetCanvas: TCanvas;
//#UC START# *4A4CD9100133_473C3D830066get_var*
//#UC END# *4A4CD9100133_473C3D830066get_var*
begin
//#UC START# *4A4CD9100133_473C3D830066get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A4CD9100133_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetCanvas

procedure Tl3Canvas.AssignDeviceCaps;
 {* Инициализировать информацию об устройстве }
//#UC START# *4A4CE6BE005A_473C3D830066_var*
//#UC END# *4A4CE6BE005A_473C3D830066_var*
begin
//#UC START# *4A4CE6BE005A_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A4CE6BE005A_473C3D830066_impl*
end;//Tl3Canvas.AssignDeviceCaps

function Tl3Canvas.DeviceCaps(anIndex: Integer): Integer;
 {* возвращает свойства устройства рисования. }
//#UC START# *4A4CEC6202C3_473C3D830066_var*
//#UC END# *4A4CEC6202C3_473C3D830066_var*
begin
//#UC START# *4A4CEC6202C3_473C3D830066_impl*
 assert(false, 'Tl3Canvas.DeviceCaps not implemented');
//#UC END# *4A4CEC6202C3_473C3D830066_impl*
end;//Tl3Canvas.DeviceCaps

function Tl3Canvas.pm_GetWindowOrg: Tl3Point;
//#UC START# *4E26F863020C_473C3D830066get_var*
//#UC END# *4E26F863020C_473C3D830066get_var*
begin
//#UC START# *4E26F863020C_473C3D830066get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E26F863020C_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetWindowOrg

procedure Tl3Canvas.pm_SetWindowOrg(const aValue: Tl3Point);
//#UC START# *4E26F863020C_473C3D830066set_var*
//#UC END# *4E26F863020C_473C3D830066set_var*
begin
//#UC START# *4E26F863020C_473C3D830066set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E26F863020C_473C3D830066set_impl*
end;//Tl3Canvas.pm_SetWindowOrg

function Tl3Canvas.pm_GetGlobalClipRect: Tl3Rect;
//#UC START# *4E26F88701E8_473C3D830066get_var*
//#UC END# *4E26F88701E8_473C3D830066get_var*
begin
//#UC START# *4E26F88701E8_473C3D830066get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E26F88701E8_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetGlobalClipRect

function Tl3Canvas.pm_GetClipRect: Tl3Rect;
//#UC START# *4E26F8A7034D_473C3D830066get_var*
//#UC END# *4E26F8A7034D_473C3D830066get_var*
begin
//#UC START# *4E26F8A7034D_473C3D830066get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E26F8A7034D_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetClipRect

procedure Tl3Canvas.pm_SetClipRect(const aValue: Tl3Rect);
//#UC START# *4E26F8A7034D_473C3D830066set_var*
//#UC END# *4E26F8A7034D_473C3D830066set_var*
begin
//#UC START# *4E26F8A7034D_473C3D830066set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E26F8A7034D_473C3D830066set_impl*
end;//Tl3Canvas.pm_SetClipRect

function Tl3Canvas.pm_GetSWindowOrg: Tl3SPoint;
//#UC START# *4E27082D0051_473C3D830066get_var*
//#UC END# *4E27082D0051_473C3D830066get_var*
begin
//#UC START# *4E27082D0051_473C3D830066get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E27082D0051_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetSWindowOrg

procedure Tl3Canvas.pm_SetSWindowOrg(const aValue: Tl3SPoint);
//#UC START# *4E27082D0051_473C3D830066set_var*
//#UC END# *4E27082D0051_473C3D830066set_var*
begin
//#UC START# *4E27082D0051_473C3D830066set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E27082D0051_473C3D830066set_impl*
end;//Tl3Canvas.pm_SetSWindowOrg

function Tl3Canvas.pm_GetInvert: Boolean;
//#UC START# *4ED5066F036B_473C3D830066get_var*
//#UC END# *4ED5066F036B_473C3D830066get_var*
begin
//#UC START# *4ED5066F036B_473C3D830066get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ED5066F036B_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetInvert

function Tl3Canvas.pm_GetFrameLines: Il3FrameLines;
//#UC START# *5077CF6501AE_473C3D830066get_var*
//#UC END# *5077CF6501AE_473C3D830066get_var*
begin
//#UC START# *5077CF6501AE_473C3D830066get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5077CF6501AE_473C3D830066get_impl*
end;//Tl3Canvas.pm_GetFrameLines

function Tl3Canvas.Get_AbortChecker: Il3AbortChecker;
//#UC START# *5229D7EF00DE_473C3D830066get_var*
//#UC END# *5229D7EF00DE_473C3D830066get_var*
begin
//#UC START# *5229D7EF00DE_473C3D830066get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5229D7EF00DE_473C3D830066get_impl*
end;//Tl3Canvas.Get_AbortChecker

procedure Tl3Canvas.Set_AbortChecker(const aValue: Il3AbortChecker);
//#UC START# *5229D7EF00DE_473C3D830066set_var*
//#UC END# *5229D7EF00DE_473C3D830066set_var*
begin
//#UC START# *5229D7EF00DE_473C3D830066set_impl*
 !!! Needs to be implemented !!!
//#UC END# *5229D7EF00DE_473C3D830066set_impl*
end;//Tl3Canvas.Set_AbortChecker

procedure Tl3Canvas.StartDrawAAC(aType: TspBlockType);
//#UC START# *54B4D8E90117_473C3D830066_var*
//#UC END# *54B4D8E90117_473C3D830066_var*
begin
//#UC START# *54B4D8E90117_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *54B4D8E90117_473C3D830066_impl*
end;//Tl3Canvas.StartDrawAAC

procedure Tl3Canvas.EndDrawAAC(const R: Tl3Rect);
//#UC START# *54B4D9020149_473C3D830066_var*
//#UC END# *54B4D9020149_473C3D830066_var*
begin
//#UC START# *54B4D9020149_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *54B4D9020149_473C3D830066_impl*
end;//Tl3Canvas.EndDrawAAC

procedure Tl3Canvas.BeginDarkColor;
//#UC START# *55CC51AD0273_473C3D830066_var*
//#UC END# *55CC51AD0273_473C3D830066_var*
begin
//#UC START# *55CC51AD0273_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *55CC51AD0273_473C3D830066_impl*
end;//Tl3Canvas.BeginDarkColor

procedure Tl3Canvas.EndDarkColor;
//#UC START# *55CC51CE0059_473C3D830066_var*
//#UC END# *55CC51CE0059_473C3D830066_var*
begin
//#UC START# *55CC51CE0059_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *55CC51CE0059_473C3D830066_impl*
end;//Tl3Canvas.EndDarkColor

procedure Tl3Canvas.FillRect(const R: Tl3SRect);
//#UC START# *56AF1D990070_473C3D830066_var*
//#UC END# *56AF1D990070_473C3D830066_var*
begin
//#UC START# *56AF1D990070_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *56AF1D990070_473C3D830066_impl*
end;//Tl3Canvas.FillRect

procedure Tl3Canvas.FillRect(const R: Tl3Rect);
//#UC START# *56AF1DDC024A_473C3D830066_var*
//#UC END# *56AF1DDC024A_473C3D830066_var*
begin
//#UC START# *56AF1DDC024A_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *56AF1DDC024A_473C3D830066_impl*
end;//Tl3Canvas.FillRect

function Tl3Canvas.GetGlobalClipRectWithZoom: Tl3Rect;
//#UC START# *4E98521202B5_473C3D830066_var*
//#UC END# *4E98521202B5_473C3D830066_var*
begin
//#UC START# *4E98521202B5_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E98521202B5_473C3D830066_impl*
end;//Tl3Canvas.GetGlobalClipRectWithZoom

end.
