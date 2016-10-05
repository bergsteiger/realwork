unit NOT_COMPLETED_nevViewInterfaces;

// Модуль: "w:\common\components\gui\Garant\Everest\new\NOT_COMPLETED_nevViewInterfaces.pas"
// Стереотип: "Interfaces"
// Элемент модели: "nevViewInterfaces" MUID: (578F8F6C0050)

{$Include w:\common\components\gui\Garant\Everest\new\nevDefine.inc}

interface

uses
 l3IntfUses
 , l3InternalInterfaces
 , nevTools
 , nevBase
 , l3Units
 , l3Interfaces
 , l3Core
 , l3Types
 , l3PrinterInterfaces
;

type
 HnevView = {$IfDef XE4}record{$Else}object{$EndIf}
  {* Обёртка над InevView }
  private
   f_InevView: InevView;
    {* Ссылка на интерфейс InevView }
  private
   {$If NOT Defined(XE4)}
   procedure Fake; virtual;
    {* это нужно чтобы правильно генерировались вызовы методов доступа к свойствам }
   {$IfEnd} // NOT Defined(XE4)
  {$IfDef XE4}private{$Else}protected{$EndIf}
   function pm_GetMetrics: InevViewMetrics;
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
   function Get_ActiveElement: InevActiveElement;
   function Get_ForceDrawFocusRect: Boolean;
   function Get_IsObjectCollapsed(const anObject: InevObject): Boolean;
   procedure Set_IsObjectCollapsed(const anObject: InevObject;
    aValue: Boolean);
   {$If Defined(evNeedCollapsedVersionComments)}
   procedure VersionInfoVisabilityChanged(aValue: Boolean);
   {$IfEnd} // Defined(evNeedCollapsedVersionComments)
   function FormatInfoByPara(const aPara: InevObject): TnevFormatInfoPrim; overload;
   function FormatInfoByObj(const anObj: InevObjectPrim): TnevFormatInfoPrim;
   function FormatInfoByPara(aPara: PInevObject): TnevFormatInfoPrim; overload;
  public
   procedure InvalidateShape(const aShape: InevObject;
    aParts: TnevShapeParts);
   constructor Init(const aInevView: InevView); reintroduce;
 end;//HnevView

 Hl3Canvas = {$IfDef XE4}record{$Else}object{$EndIf}
  {* Обёртка для Il3Canvas }
  private
   f_Il3Canvas: Il3Canvas;
    {* Ссылка на интерфейс Il3Canvas }
  private
   {$If NOT Defined(XE4)}
   procedure Fake; virtual;
    {* это нужно чтобы правильно генерировались вызовы методов доступа к свойствам }
   {$IfEnd} // NOT Defined(XE4)
  {$IfDef XE4}private{$Else}protected{$EndIf}
   function pxAverageCharWidth: Integer;
    {* средняя ширина символов контекста в пикселях. }
   function AverageCharWidth: Integer;
    {* средняя ширина символов контекста в дюймах. }
   function Pos2Index(W: Integer;
    const S: Tl3PCharLen): Integer;
    {* находит индекс символа на рассоянии W дюймов от начала строки S. }
   function Pos2IndexQ(W: Integer;
    const S: Tl3PCharLen;
    var aNoTabs: Boolean): Integer;
    {* находит индекс символа на рассоянии W дюймов от начала строки S. }
   function AverageCharHeight: Integer;
    {* средняя высота символов контекста в дюймах. }
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
   procedure StartObject(anObjectID: Integer);
   procedure SetPageTop;
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
   function pm_GetPageNumber: Integer;
   function pm_GetPageWidthNumber: Integer;
   function pm_GetPenWidth: Integer;
   function pm_GetPageOrientation: Tl3PageOrientation;
   procedure pm_SetPageOrientation(aValue: Tl3PageOrientation);
   function pm_GetSectionExtent: Tl3Point;
   procedure pm_SetSectionExtent(const aValue: Tl3Point);
   procedure pm_SetNotFocused(aValue: Boolean);
   function pm_GetRegionBottomRight: Tl3Point;
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
   procedure StartDrawAAC(aType: TspBlockType);
   procedure EndDrawAAC(const R: Tl3Rect);
   procedure BeginDarkColor;
   procedure EndDarkColor;
   function Get_etoFlags: Cardinal;
   procedure Set_etoFlags(aValue: Cardinal);
  public
   function TextExtent(const S: Tl3WString;
    aNoTabs: Boolean = False): Tl3Point;
    {* возвращает длину строки текста в дюймах. }
   function LP2DP(const P: Tl3_Point;
    NeedZoom: Boolean = False): Tl3SPoint;
    {* преобразует точку в дюймах в точку в пикселях. }
   function LR2DR(const R: Tl3Rect): Tl3SRect;
    {* преобразует прямоугольник в дюймах в прямоугольник в пикселях. }
   function DR2LR(const R: Tl3SRect): Tl3Rect;
    {* преобразует прямоугольник в пикселях в прямоугольник в дюймах. }
   function DrawText(const aSt: Tl3WString;
    var R: TRect;
    aFormat: Cardinal;
    AFl: TObject = nil): Il3MultiLines;
    {* как ни глупо звучит, но это нужно на информационной канве, т.к. она вычисляет прямоугольник вывода. }
   procedure BeginPaint;
   procedure EndPaint;
   procedure BeginInvert;
   procedure EndInvert;
   function IsVirtual: Boolean;
   function DP2LP(const aP: Tl3_SPoint): Tl3Point;
    {* Преобразует точку в пикселях в точку в дюймах }
   function DeviceCaps(anIndex: Integer): Integer;
    {* возвращает свойства устройства рисования. }
   function PushClipRect: Tl3Rect;
   procedure PopClipRect;
   procedure PushLineSpacing;
   procedure PopLineSpacing;
   constructor Init(const aIl3Canvas: Il3Canvas); reintroduce;
 end;//Hl3Canvas

implementation

uses
 l3ImplUses
;

function HnevView.pm_GetMetrics: InevViewMetrics;
//#UC START# *47C5B99001C4_4A4B231403B6get_var*
//#UC END# *47C5B99001C4_4A4B231403B6get_var*
begin
//#UC START# *47C5B99001C4_4A4B231403B6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B99001C4_4A4B231403B6get_impl*
end;//HnevView.pm_GetMetrics

function HnevView.Data: InevObject;
//#UC START# *47C5B9A30018_4A4B231403B6_var*
//#UC END# *47C5B9A30018_4A4B231403B6_var*
begin
//#UC START# *47C5B9A30018_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B9A30018_4A4B231403B6_impl*
end;//HnevView.Data

function HnevView.RootMap: InevMap;
//#UC START# *47C5B9AA03E1_4A4B231403B6_var*
//#UC END# *47C5B9AA03E1_4A4B231403B6_var*
begin
//#UC START# *47C5B9AA03E1_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B9AA03E1_4A4B231403B6_impl*
end;//HnevView.RootMap

function HnevView.Processor: InevProcessor;
//#UC START# *47C5B9B202F0_4A4B231403B6_var*
//#UC END# *47C5B9B202F0_4A4B231403B6_var*
begin
//#UC START# *47C5B9B202F0_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B9B202F0_4A4B231403B6_impl*
end;//HnevView.Processor

procedure HnevView.ClearShapes;
//#UC START# *47C5B9C301B9_4A4B231403B6_var*
//#UC END# *47C5B9C301B9_4A4B231403B6_var*
begin
//#UC START# *47C5B9C301B9_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B9C301B9_4A4B231403B6_impl*
end;//HnevView.ClearShapes

procedure HnevView.BeginDrawShape(const aShape: InevObject;
 const anAnchor: InevBasePoint;
 const anOrg: TnevPoint;
 var theMap: InevMap;
 aFake: Boolean;
 const aHacker: InevK235870994Hacker);
 {* Начинает добавление формы в список. }
//#UC START# *47C5B9DB0136_4A4B231403B6_var*
//#UC END# *47C5B9DB0136_4A4B231403B6_var*
begin
//#UC START# *47C5B9DB0136_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B9DB0136_4A4B231403B6_impl*
end;//HnevView.BeginDrawShape

procedure HnevView.EndDrawShape;
 {* Заканчивает добавление формы в список. }
//#UC START# *47C5B9FB03D1_4A4B231403B6_var*
//#UC END# *47C5B9FB03D1_4A4B231403B6_var*
begin
//#UC START# *47C5B9FB03D1_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B9FB03D1_4A4B231403B6_impl*
end;//HnevView.EndDrawShape

function HnevView.MapByPoint(const aPoint: InevBasePoint;
 aCheckTopVisible: Boolean = False): InevMap;
//#UC START# *47C5BA240004_4A4B231403B6_var*
//#UC END# *47C5BA240004_4A4B231403B6_var*
begin
//#UC START# *47C5BA240004_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5BA240004_4A4B231403B6_impl*
end;//HnevView.MapByPoint

function HnevView.FormatInfoByPoint(const aPoint: InevBasePoint): TnevFormatInfoPrim;
//#UC START# *481078F302DD_4A4B231403B6_var*
//#UC END# *481078F302DD_4A4B231403B6_var*
begin
//#UC START# *481078F302DD_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *481078F302DD_4A4B231403B6_impl*
end;//HnevView.FormatInfoByPoint

function HnevView.RootFormatInfo: TnevFormatInfoPrim;
//#UC START# *4811BA6C005A_4A4B231403B6_var*
//#UC END# *4811BA6C005A_4A4B231403B6_var*
begin
//#UC START# *4811BA6C005A_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4811BA6C005A_4A4B231403B6_impl*
end;//HnevView.RootFormatInfo

procedure HnevView.InvalidateShape(const aShape: InevObject;
 aParts: TnevShapeParts);
//#UC START# *4816E2B2004E_4A4B231403B6_var*
//#UC END# *4816E2B2004E_4A4B231403B6_var*
begin
//#UC START# *4816E2B2004E_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4816E2B2004E_4A4B231403B6_impl*
end;//HnevView.InvalidateShape

function HnevView.Get_ActiveElement: InevActiveElement;
//#UC START# *4A27CEB10364_4A4B231403B6get_var*
//#UC END# *4A27CEB10364_4A4B231403B6get_var*
begin
//#UC START# *4A27CEB10364_4A4B231403B6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A27CEB10364_4A4B231403B6get_impl*
end;//HnevView.Get_ActiveElement

function HnevView.Get_ForceDrawFocusRect: Boolean;
//#UC START# *4B59A96702D9_4A4B231403B6get_var*
//#UC END# *4B59A96702D9_4A4B231403B6get_var*
begin
//#UC START# *4B59A96702D9_4A4B231403B6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B59A96702D9_4A4B231403B6get_impl*
end;//HnevView.Get_ForceDrawFocusRect

function HnevView.Get_IsObjectCollapsed(const anObject: InevObject): Boolean;
//#UC START# *4D5A3DD60219_4A4B231403B6get_var*
//#UC END# *4D5A3DD60219_4A4B231403B6get_var*
begin
//#UC START# *4D5A3DD60219_4A4B231403B6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5A3DD60219_4A4B231403B6get_impl*
end;//HnevView.Get_IsObjectCollapsed

procedure HnevView.Set_IsObjectCollapsed(const anObject: InevObject;
 aValue: Boolean);
//#UC START# *4D5A3DD60219_4A4B231403B6set_var*
//#UC END# *4D5A3DD60219_4A4B231403B6set_var*
begin
//#UC START# *4D5A3DD60219_4A4B231403B6set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5A3DD60219_4A4B231403B6set_impl*
end;//HnevView.Set_IsObjectCollapsed

{$If Defined(evNeedCollapsedVersionComments)}
procedure HnevView.VersionInfoVisabilityChanged(aValue: Boolean);
//#UC START# *4D5A3E3E01B7_4A4B231403B6_var*
//#UC END# *4D5A3E3E01B7_4A4B231403B6_var*
begin
//#UC START# *4D5A3E3E01B7_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5A3E3E01B7_4A4B231403B6_impl*
end;//HnevView.VersionInfoVisabilityChanged
{$IfEnd} // Defined(evNeedCollapsedVersionComments)

function HnevView.FormatInfoByPara(const aPara: InevObject): TnevFormatInfoPrim;
//#UC START# *4E6F8ED402EF_4A4B231403B6_var*
//#UC END# *4E6F8ED402EF_4A4B231403B6_var*
begin
//#UC START# *4E6F8ED402EF_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E6F8ED402EF_4A4B231403B6_impl*
end;//HnevView.FormatInfoByPara

function HnevView.FormatInfoByObj(const anObj: InevObjectPrim): TnevFormatInfoPrim;
//#UC START# *4E6F8EF302A4_4A4B231403B6_var*
//#UC END# *4E6F8EF302A4_4A4B231403B6_var*
begin
//#UC START# *4E6F8EF302A4_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E6F8EF302A4_4A4B231403B6_impl*
end;//HnevView.FormatInfoByObj

function HnevView.FormatInfoByPara(aPara: PInevObject): TnevFormatInfoPrim;
//#UC START# *4E6F98080175_4A4B231403B6_var*
//#UC END# *4E6F98080175_4A4B231403B6_var*
begin
//#UC START# *4E6F98080175_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E6F98080175_4A4B231403B6_impl*
end;//HnevView.FormatInfoByPara

{$If NOT Defined(XE4)}
procedure HnevView.Fake;
 {* это нужно чтобы правильно генерировались вызовы методов доступа к свойствам }
begin
 Assert(false);
end;//HnevView.Fake
{$IfEnd} // NOT Defined(XE4)

constructor HnevView.Init(const aInevView: InevView);
begin
 f_InevView := aInevView;
end;//HnevView.Init

function Hl3Canvas.pxAverageCharWidth: Integer;
 {* средняя ширина символов контекста в пикселях. }
//#UC START# *4727432E0121_4A4479E503D5_var*
//#UC END# *4727432E0121_4A4479E503D5_var*
begin
//#UC START# *4727432E0121_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4727432E0121_4A4479E503D5_impl*
end;//Hl3Canvas.pxAverageCharWidth

function Hl3Canvas.AverageCharWidth: Integer;
 {* средняя ширина символов контекста в дюймах. }
//#UC START# *472743420382_4A4479E503D5_var*
//#UC END# *472743420382_4A4479E503D5_var*
begin
//#UC START# *472743420382_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *472743420382_4A4479E503D5_impl*
end;//Hl3Canvas.AverageCharWidth

function Hl3Canvas.TextExtent(const S: Tl3WString;
 aNoTabs: Boolean = False): Tl3Point;
 {* возвращает длину строки текста в дюймах. }
//#UC START# *472744E803E3_4A4479E503D5_var*
//#UC END# *472744E803E3_4A4479E503D5_var*
begin
//#UC START# *472744E803E3_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *472744E803E3_4A4479E503D5_impl*
end;//Hl3Canvas.TextExtent

function Hl3Canvas.Pos2Index(W: Integer;
 const S: Tl3PCharLen): Integer;
 {* находит индекс символа на рассоянии W дюймов от начала строки S. }
//#UC START# *472894A001A6_4A4479E503D5_var*
//#UC END# *472894A001A6_4A4479E503D5_var*
begin
//#UC START# *472894A001A6_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *472894A001A6_4A4479E503D5_impl*
end;//Hl3Canvas.Pos2Index

function Hl3Canvas.Pos2IndexQ(W: Integer;
 const S: Tl3PCharLen;
 var aNoTabs: Boolean): Integer;
 {* находит индекс символа на рассоянии W дюймов от начала строки S. }
//#UC START# *472894BA0258_4A4479E503D5_var*
//#UC END# *472894BA0258_4A4479E503D5_var*
begin
//#UC START# *472894BA0258_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *472894BA0258_4A4479E503D5_impl*
end;//Hl3Canvas.Pos2IndexQ

function Hl3Canvas.AverageCharHeight: Integer;
 {* средняя высота символов контекста в дюймах. }
//#UC START# *472894EA0166_4A4479E503D5_var*
//#UC END# *472894EA0166_4A4479E503D5_var*
begin
//#UC START# *472894EA0166_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *472894EA0166_4A4479E503D5_impl*
end;//Hl3Canvas.AverageCharHeight

function Hl3Canvas.LP2DP(const P: Tl3_Point;
 NeedZoom: Boolean = False): Tl3SPoint;
 {* преобразует точку в дюймах в точку в пикселях. }
//#UC START# *4728950502EC_4A4479E503D5_var*
//#UC END# *4728950502EC_4A4479E503D5_var*
begin
//#UC START# *4728950502EC_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728950502EC_4A4479E503D5_impl*
end;//Hl3Canvas.LP2DP

function Hl3Canvas.LR2DR(const R: Tl3Rect): Tl3SRect;
 {* преобразует прямоугольник в дюймах в прямоугольник в пикселях. }
//#UC START# *472897C30237_4A4479E503D5_var*
//#UC END# *472897C30237_4A4479E503D5_var*
begin
//#UC START# *472897C30237_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *472897C30237_4A4479E503D5_impl*
end;//Hl3Canvas.LR2DR

function Hl3Canvas.DR2LR(const R: Tl3SRect): Tl3Rect;
 {* преобразует прямоугольник в пикселях в прямоугольник в дюймах. }
//#UC START# *472898020151_4A4479E503D5_var*
//#UC END# *472898020151_4A4479E503D5_var*
begin
//#UC START# *472898020151_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *472898020151_4A4479E503D5_impl*
end;//Hl3Canvas.DR2LR

procedure Hl3Canvas.Lock;
 {* начать работу с канвой. }
//#UC START# *4728980E02AD_4A4479E503D5_var*
//#UC END# *4728980E02AD_4A4479E503D5_var*
begin
//#UC START# *4728980E02AD_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728980E02AD_4A4479E503D5_impl*
end;//Hl3Canvas.Lock

procedure Hl3Canvas.Unlock;
 {* закончить работу с канвой. }
//#UC START# *4728981C0054_4A4479E503D5_var*
//#UC END# *4728981C0054_4A4479E503D5_var*
begin
//#UC START# *4728981C0054_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728981C0054_4A4479E503D5_impl*
end;//Hl3Canvas.Unlock

function Hl3Canvas.GetKerning(const aSt: Tl3WString;
 Kerning: PLong): Tl3Point;
 {* получить размеры строки и таблицу кернинга. }
//#UC START# *47289B000379_4A4479E503D5_var*
//#UC END# *47289B000379_4A4479E503D5_var*
begin
//#UC START# *47289B000379_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *47289B000379_4A4479E503D5_impl*
end;//Hl3Canvas.GetKerning

function Hl3Canvas.OffsetRgn(const Rgn: Il3Region;
 const Pt: Tl3Point): Integer;
 {* сдвинуть регион. }
//#UC START# *4728A0840026_4A4479E503D5_var*
//#UC END# *4728A0840026_4A4479E503D5_var*
begin
//#UC START# *4728A0840026_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728A0840026_4A4479E503D5_impl*
end;//Hl3Canvas.OffsetRgn

function Hl3Canvas.CaretExtent: Tl3Point;
 {* размеры курсора. }
//#UC START# *4728A0C40082_4A4479E503D5_var*
//#UC END# *4728A0C40082_4A4479E503D5_var*
begin
//#UC START# *4728A0C40082_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728A0C40082_4A4479E503D5_impl*
end;//Hl3Canvas.CaretExtent

procedure Hl3Canvas.StartTabs(out theTabInfo: Il3TabInfo;
 const aTabStops: Il3TabStops;
 aTabOffset: Integer = 0);
//#UC START# *4728A4A703CC_4A4479E503D5_var*
//#UC END# *4728A4A703CC_4A4479E503D5_var*
begin
//#UC START# *4728A4A703CC_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728A4A703CC_4A4479E503D5_impl*
end;//Hl3Canvas.StartTabs

procedure Hl3Canvas.StartTabs(out theTabInfo: Il3TabInfo;
 const aTabInfo: Il3TabInfo);
//#UC START# *4728A4D00013_4A4479E503D5_var*
//#UC END# *4728A4D00013_4A4479E503D5_var*
begin
//#UC START# *4728A4D00013_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728A4D00013_4A4479E503D5_impl*
end;//Hl3Canvas.StartTabs

procedure Hl3Canvas.FinishTabs(var aTabInfo: Il3TabInfo);
//#UC START# *4728A4DF0065_4A4479E503D5_var*
//#UC END# *4728A4DF0065_4A4479E503D5_var*
begin
//#UC START# *4728A4DF0065_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728A4DF0065_4A4479E503D5_impl*
end;//Hl3Canvas.FinishTabs

function Hl3Canvas.TabInfo: Il3TabInfo;
//#UC START# *4728A4F602FD_4A4479E503D5_var*
//#UC END# *4728A4F602FD_4A4479E503D5_var*
begin
//#UC START# *4728A4F602FD_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728A4F602FD_4A4479E503D5_impl*
end;//Hl3Canvas.TabInfo

function Hl3Canvas.EQ(const aCanvas: Il3InfoCanvas): Boolean;
//#UC START# *4728A509016A_4A4479E503D5_var*
//#UC END# *4728A509016A_4A4479E503D5_var*
begin
//#UC START# *4728A509016A_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728A509016A_4A4479E503D5_impl*
end;//Hl3Canvas.EQ

function Hl3Canvas.NearestColor(C: Tl3Color): Tl3Color;
//#UC START# *4728A52B0385_4A4479E503D5_var*
//#UC END# *4728A52B0385_4A4479E503D5_var*
begin
//#UC START# *4728A52B0385_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728A52B0385_4A4479E503D5_impl*
end;//Hl3Canvas.NearestColor

function Hl3Canvas.DrawText(const aSt: Tl3WString;
 var R: TRect;
 aFormat: Cardinal;
 AFl: TObject = nil): Il3MultiLines;
 {* как ни глупо звучит, но это нужно на информационной канве, т.к. она вычисляет прямоугольник вывода. }
//#UC START# *4728A74F03A2_4A4479E503D5_var*
//#UC END# *4728A74F03A2_4A4479E503D5_var*
begin
//#UC START# *4728A74F03A2_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728A74F03A2_4A4479E503D5_impl*
end;//Hl3Canvas.DrawText

procedure Hl3Canvas.TabbedMultilineTextOut(const aSt: Tl3WString;
 const Tabs: Il3TabStops;
 var Rect: Tl3Rect;
 Precalculate: Boolean;
 aGap: Integer);
 {* как ни глупо звучит, но это нужно на информационной канве, т.к. она вычисляет прямоугольник вывода. }
//#UC START# *4728A7BC0330_4A4479E503D5_var*
//#UC END# *4728A7BC0330_4A4479E503D5_var*
begin
//#UC START# *4728A7BC0330_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728A7BC0330_4A4479E503D5_impl*
end;//Hl3Canvas.TabbedMultilineTextOut

procedure Hl3Canvas.PushBC;
//#UC START# *4728AD37017F_4A4479E503D5_var*
//#UC END# *4728AD37017F_4A4479E503D5_var*
begin
//#UC START# *4728AD37017F_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728AD37017F_4A4479E503D5_impl*
end;//Hl3Canvas.PushBC

function Hl3Canvas.TopBC: Tl3Color;
//#UC START# *4728AD43021C_4A4479E503D5_var*
//#UC END# *4728AD43021C_4A4479E503D5_var*
begin
//#UC START# *4728AD43021C_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728AD43021C_4A4479E503D5_impl*
end;//Hl3Canvas.TopBC

procedure Hl3Canvas.PopBC;
//#UC START# *4728AD580263_4A4479E503D5_var*
//#UC END# *4728AD580263_4A4479E503D5_var*
begin
//#UC START# *4728AD580263_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728AD580263_4A4479E503D5_impl*
end;//Hl3Canvas.PopBC

procedure Hl3Canvas.PushFC;
//#UC START# *4728AD680067_4A4479E503D5_var*
//#UC END# *4728AD680067_4A4479E503D5_var*
begin
//#UC START# *4728AD680067_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728AD680067_4A4479E503D5_impl*
end;//Hl3Canvas.PushFC

procedure Hl3Canvas.PopFC;
//#UC START# *4728AD760338_4A4479E503D5_var*
//#UC END# *4728AD760338_4A4479E503D5_var*
begin
//#UC START# *4728AD760338_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728AD760338_4A4479E503D5_impl*
end;//Hl3Canvas.PopFC

function Hl3Canvas.TextMetrics: PTextMetric;
//#UC START# *4728ADF50313_4A4479E503D5_var*
//#UC END# *4728ADF50313_4A4479E503D5_var*
begin
//#UC START# *4728ADF50313_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728ADF50313_4A4479E503D5_impl*
end;//Hl3Canvas.TextMetrics

function Hl3Canvas.Get_Font: Il3Font;
//#UC START# *4728AE20030A_4A4479E503D5get_var*
//#UC END# *4728AE20030A_4A4479E503D5get_var*
begin
//#UC START# *4728AE20030A_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728AE20030A_4A4479E503D5get_impl*
end;//Hl3Canvas.Get_Font

procedure Hl3Canvas.Set_Font(const aValue: Il3Font);
//#UC START# *4728AE20030A_4A4479E503D5set_var*
//#UC END# *4728AE20030A_4A4479E503D5set_var*
begin
//#UC START# *4728AE20030A_4A4479E503D5set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728AE20030A_4A4479E503D5set_impl*
end;//Hl3Canvas.Set_Font

function Hl3Canvas.pm_GetDC: hDC;
//#UC START# *4728AE3E03B8_4A4479E503D5get_var*
//#UC END# *4728AE3E03B8_4A4479E503D5get_var*
begin
//#UC START# *4728AE3E03B8_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728AE3E03B8_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetDC

procedure Hl3Canvas.pm_SetDC(aValue: hDC);
//#UC START# *4728AE3E03B8_4A4479E503D5set_var*
//#UC END# *4728AE3E03B8_4A4479E503D5set_var*
begin
//#UC START# *4728AE3E03B8_4A4479E503D5set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728AE3E03B8_4A4479E503D5set_impl*
end;//Hl3Canvas.pm_SetDC

function Hl3Canvas.pm_GetPixelsPerInchX: Integer;
//#UC START# *4728AE5D020E_4A4479E503D5get_var*
//#UC END# *4728AE5D020E_4A4479E503D5get_var*
begin
//#UC START# *4728AE5D020E_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728AE5D020E_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetPixelsPerInchX

function Hl3Canvas.pm_GetPixelsPerInchY: Integer;
//#UC START# *4728AE6A01EE_4A4479E503D5get_var*
//#UC END# *4728AE6A01EE_4A4479E503D5get_var*
begin
//#UC START# *4728AE6A01EE_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728AE6A01EE_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetPixelsPerInchY

procedure Hl3Canvas.MoveWindowOrg(const Delta: Tl3Point);
//#UC START# *4728AEC301D8_4A4479E503D5_var*
//#UC END# *4728AEC301D8_4A4479E503D5_var*
begin
//#UC START# *4728AEC301D8_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728AEC301D8_4A4479E503D5_impl*
end;//Hl3Canvas.MoveWindowOrg

procedure Hl3Canvas.MoveWindowOrg(const Delta: Tl3SPoint);
//#UC START# *4728AECD010B_4A4479E503D5_var*
//#UC END# *4728AECD010B_4A4479E503D5_var*
begin
//#UC START# *4728AECD010B_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728AECD010B_4A4479E503D5_impl*
end;//Hl3Canvas.MoveWindowOrg

procedure Hl3Canvas.FillForeRect(const R: Tl3SRect);
//#UC START# *4728AED70336_4A4479E503D5_var*
//#UC END# *4728AED70336_4A4479E503D5_var*
begin
//#UC START# *4728AED70336_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728AED70336_4A4479E503D5_impl*
end;//Hl3Canvas.FillForeRect

procedure Hl3Canvas.FillRect(const R: Tl3SRect);
//#UC START# *4728AF3E03AC_4A4479E503D5_var*
//#UC END# *4728AF3E03AC_4A4479E503D5_var*
begin
//#UC START# *4728AF3E03AC_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728AF3E03AC_4A4479E503D5_impl*
end;//Hl3Canvas.FillRect

procedure Hl3Canvas.FillRect(const R: Tl3Rect);
//#UC START# *4728AF5103A9_4A4479E503D5_var*
//#UC END# *4728AF5103A9_4A4479E503D5_var*
begin
//#UC START# *4728AF5103A9_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728AF5103A9_4A4479E503D5_impl*
end;//Hl3Canvas.FillRect

procedure Hl3Canvas.FillEmptyRect(const R: Tl3Rect);
//#UC START# *4728B590009B_4A4479E503D5_var*
//#UC END# *4728B590009B_4A4479E503D5_var*
begin
//#UC START# *4728B590009B_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728B590009B_4A4479E503D5_impl*
end;//Hl3Canvas.FillEmptyRect

procedure Hl3Canvas.FillEmptyRect(const R: Tl3SRect);
//#UC START# *4728B59A000A_4A4479E503D5_var*
//#UC END# *4728B59A000A_4A4479E503D5_var*
begin
//#UC START# *4728B59A000A_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728B59A000A_4A4479E503D5_impl*
end;//Hl3Canvas.FillEmptyRect

function Hl3Canvas.FillRgn(const Region: Il3Region): Boolean;
//#UC START# *4728B5A50041_4A4479E503D5_var*
//#UC END# *4728B5A50041_4A4479E503D5_var*
begin
//#UC START# *4728B5A50041_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728B5A50041_4A4479E503D5_impl*
end;//Hl3Canvas.FillRgn

function Hl3Canvas.TextOut(const P: Tl3Point;
 const S: Tl3PCharLen;
 FC: Tl3Color = clDefault;
 BC: Tl3Color = clDefault): Tl3Point;
//#UC START# *4728B5B5026B_4A4479E503D5_var*
//#UC END# *4728B5B5026B_4A4479E503D5_var*
begin
//#UC START# *4728B5B5026B_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728B5B5026B_4A4479E503D5_impl*
end;//Hl3Canvas.TextOut

procedure Hl3Canvas.SetCaret(const Origin: Tl3Point;
 const Extent: Tl3Point;
 Hidden: Boolean = False);
//#UC START# *4728B5EB01A1_4A4479E503D5_var*
//#UC END# *4728B5EB01A1_4A4479E503D5_var*
begin
//#UC START# *4728B5EB01A1_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728B5EB01A1_4A4479E503D5_impl*
end;//Hl3Canvas.SetCaret

procedure Hl3Canvas.IncCaret(aDeltaX: Integer);
//#UC START# *4728B60F0211_4A4479E503D5_var*
//#UC END# *4728B60F0211_4A4479E503D5_var*
begin
//#UC START# *4728B60F0211_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728B60F0211_4A4479E503D5_impl*
end;//Hl3Canvas.IncCaret

procedure Hl3Canvas.BeginPaint;
//#UC START# *4728B61D0058_4A4479E503D5_var*
//#UC END# *4728B61D0058_4A4479E503D5_var*
begin
//#UC START# *4728B61D0058_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728B61D0058_4A4479E503D5_impl*
end;//Hl3Canvas.BeginPaint

procedure Hl3Canvas.StartObject(anObjectID: Integer);
//#UC START# *4728B62702C9_4A4479E503D5_var*
//#UC END# *4728B62702C9_4A4479E503D5_var*
begin
//#UC START# *4728B62702C9_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728B62702C9_4A4479E503D5_impl*
end;//Hl3Canvas.StartObject

procedure Hl3Canvas.SetPageTop;
//#UC START# *4728B637025E_4A4479E503D5_var*
//#UC END# *4728B637025E_4A4479E503D5_var*
begin
//#UC START# *4728B637025E_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728B637025E_4A4479E503D5_impl*
end;//Hl3Canvas.SetPageTop

procedure Hl3Canvas.EndPaint;
//#UC START# *4728B67C0037_4A4479E503D5_var*
//#UC END# *4728B67C0037_4A4479E503D5_var*
begin
//#UC START# *4728B67C0037_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728B67C0037_4A4479E503D5_impl*
end;//Hl3Canvas.EndPaint

procedure Hl3Canvas.BeginInvert;
//#UC START# *4728B68502C5_4A4479E503D5_var*
//#UC END# *4728B68502C5_4A4479E503D5_var*
begin
//#UC START# *4728B68502C5_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728B68502C5_4A4479E503D5_impl*
end;//Hl3Canvas.BeginInvert

procedure Hl3Canvas.EndInvert;
//#UC START# *4728B68C0329_4A4479E503D5_var*
//#UC END# *4728B68C0329_4A4479E503D5_var*
begin
//#UC START# *4728B68C0329_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728B68C0329_4A4479E503D5_impl*
end;//Hl3Canvas.EndInvert

function Hl3Canvas.DrawRgnOrBlock: Boolean;
//#UC START# *4728B6B501C9_4A4479E503D5_var*
//#UC END# *4728B6B501C9_4A4479E503D5_var*
begin
//#UC START# *4728B6B501C9_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728B6B501C9_4A4479E503D5_impl*
end;//Hl3Canvas.DrawRgnOrBlock

function Hl3Canvas.HasToDraw: Boolean;
//#UC START# *4728B6DD013A_4A4479E503D5_var*
//#UC END# *4728B6DD013A_4A4479E503D5_var*
begin
//#UC START# *4728B6DD013A_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728B6DD013A_4A4479E503D5_impl*
end;//Hl3Canvas.HasToDraw

procedure Hl3Canvas.StretchDraw(const R: Tl3Rect;
 Graphic: VCLGraphic);
//#UC START# *4728B6ED0101_4A4479E503D5_var*
//#UC END# *4728B6ED0101_4A4479E503D5_var*
begin
//#UC START# *4728B6ED0101_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728B6ED0101_4A4479E503D5_impl*
end;//Hl3Canvas.StretchDraw

procedure Hl3Canvas.DrawSub(aSubTarget: TObject;
 const R: Tl3Rect;
 LayerHandle: Integer;
 aSub: TObject);
//#UC START# *4728B97800C0_4A4479E503D5_var*
//#UC END# *4728B97800C0_4A4479E503D5_var*
begin
//#UC START# *4728B97800C0_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728B97800C0_4A4479E503D5_impl*
end;//Hl3Canvas.DrawSub

procedure Hl3Canvas.ExtTextOut(const P: Tl3Point;
 const R: Tl3Rect;
 const S: Tl3WString;
 F: Tl3TextFormatFlag = l3_tffLeft;
 Dx: PInteger = nil);
//#UC START# *4728B9F10060_4A4479E503D5_var*
//#UC END# *4728B9F10060_4A4479E503D5_var*
begin
//#UC START# *4728B9F10060_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728B9F10060_4A4479E503D5_impl*
end;//Hl3Canvas.ExtTextOut

procedure Hl3Canvas.ExtTextOut(const P: Tl3SPoint;
 const R: Tl3SRect;
 const S: Tl3WString;
 F: Tl3TextFormatFlag = l3_tffLeft;
 Dx: PInteger = nil);
//#UC START# *4728BAAC0127_4A4479E503D5_var*
//#UC END# *4728BAAC0127_4A4479E503D5_var*
begin
//#UC START# *4728BAAC0127_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BAAC0127_4A4479E503D5_impl*
end;//Hl3Canvas.ExtTextOut

function Hl3Canvas.CaretLineOut(const aSt: Tl3WString;
 LineHeight: Integer;
 aHidden: Boolean;
 var CaretPos: Integer): Tl3Point;
 {* выводит строку текста высотой LineHeight, со сдвигом курсора отрисовки. устанавливает курсор в CaretPos. возвращает размеры выведенной строки. }
//#UC START# *4728BAD601DC_4A4479E503D5_var*
//#UC END# *4728BAD601DC_4A4479E503D5_var*
begin
//#UC START# *4728BAD601DC_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BAD601DC_4A4479E503D5_impl*
end;//Hl3Canvas.CaretLineOut

function Hl3Canvas.StringOut(const P: Tl3Point;
 const Text: Tl3WString): Tl3Point;
//#UC START# *4728BB120156_4A4479E503D5_var*
//#UC END# *4728BB120156_4A4479E503D5_var*
begin
//#UC START# *4728BB120156_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BB120156_4A4479E503D5_impl*
end;//Hl3Canvas.StringOut

procedure Hl3Canvas.TabbedTextOut(const P: Tl3Point;
 const R: Tl3Rect;
 const S: Tl3WString;
 const aTabStops: Il3TabStops);
//#UC START# *4728BB2D0173_4A4479E503D5_var*
//#UC END# *4728BB2D0173_4A4479E503D5_var*
begin
//#UC START# *4728BB2D0173_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BB2D0173_4A4479E503D5_impl*
end;//Hl3Canvas.TabbedTextOut

procedure Hl3Canvas.TabbedTextOut(const P: Tl3SPoint;
 const R: Tl3SRect;
 const S: Tl3WString;
 const aTabStops: Il3TabStops);
//#UC START# *4728BB8F03CD_4A4479E503D5_var*
//#UC END# *4728BB8F03CD_4A4479E503D5_var*
begin
//#UC START# *4728BB8F03CD_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BB8F03CD_4A4479E503D5_impl*
end;//Hl3Canvas.TabbedTextOut

function Hl3Canvas.NewPage(ByWidth: Boolean = False): Boolean;
 {* начать новую страницу. }
//#UC START# *4728BBAF00BB_4A4479E503D5_var*
//#UC END# *4728BBAF00BB_4A4479E503D5_var*
begin
//#UC START# *4728BBAF00BB_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BBAF00BB_4A4479E503D5_impl*
end;//Hl3Canvas.NewPage

procedure Hl3Canvas.Line(const A: Tl3Point;
 const B: Tl3Point);
 {* нарисовать линию. }
//#UC START# *4728BBC80252_4A4479E503D5_var*
//#UC END# *4728BBC80252_4A4479E503D5_var*
begin
//#UC START# *4728BBC80252_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BBC80252_4A4479E503D5_impl*
end;//Hl3Canvas.Line

procedure Hl3Canvas.Line(const A: Tl3SPoint;
 const B: Tl3SPoint);
 {* нарисовать линию. }
//#UC START# *4728BBE702D9_4A4479E503D5_var*
//#UC END# *4728BBE702D9_4A4479E503D5_var*
begin
//#UC START# *4728BBE702D9_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BBE702D9_4A4479E503D5_impl*
end;//Hl3Canvas.Line

procedure Hl3Canvas.MoveTo(const Pt: Tl3Point);
//#UC START# *4728BC06000C_4A4479E503D5_var*
//#UC END# *4728BC06000C_4A4479E503D5_var*
begin
//#UC START# *4728BC06000C_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BC06000C_4A4479E503D5_impl*
end;//Hl3Canvas.MoveTo

procedure Hl3Canvas.LineTo(const Pt: Tl3Point);
//#UC START# *4728BC0E0249_4A4479E503D5_var*
//#UC END# *4728BC0E0249_4A4479E503D5_var*
begin
//#UC START# *4728BC0E0249_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BC0E0249_4A4479E503D5_impl*
end;//Hl3Canvas.LineTo

procedure Hl3Canvas.MoveTo(const Pt: Tl3SPoint);
//#UC START# *4728BC18022F_4A4479E503D5_var*
//#UC END# *4728BC18022F_4A4479E503D5_var*
begin
//#UC START# *4728BC18022F_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BC18022F_4A4479E503D5_impl*
end;//Hl3Canvas.MoveTo

procedure Hl3Canvas.LineTo(const Pt: Tl3SPoint);
//#UC START# *4728BC2103A4_4A4479E503D5_var*
//#UC END# *4728BC2103A4_4A4479E503D5_var*
begin
//#UC START# *4728BC2103A4_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BC2103A4_4A4479E503D5_impl*
end;//Hl3Canvas.LineTo

function Hl3Canvas.WO(const aRect: Tl3Rect): Tl3SRect;
//#UC START# *4728BC4B02FB_4A4479E503D5_var*
//#UC END# *4728BC4B02FB_4A4479E503D5_var*
begin
//#UC START# *4728BC4B02FB_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BC4B02FB_4A4479E503D5_impl*
end;//Hl3Canvas.WO

function Hl3Canvas.WO(const aPt: Tl3Point): Tl3SPoint;
//#UC START# *4728BC54039E_4A4479E503D5_var*
//#UC END# *4728BC54039E_4A4479E503D5_var*
begin
//#UC START# *4728BC54039E_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BC54039E_4A4479E503D5_impl*
end;//Hl3Canvas.WO

function Hl3Canvas.WO(const aPt: Tl3SPoint): Tl3SPoint;
//#UC START# *4728BC61002B_4A4479E503D5_var*
//#UC END# *4728BC61002B_4A4479E503D5_var*
begin
//#UC START# *4728BC61002B_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BC61002B_4A4479E503D5_impl*
end;//Hl3Canvas.WO

procedure Hl3Canvas.DrawFocusRect(const aRect: Tl3SRect);
//#UC START# *4728BC6A0088_4A4479E503D5_var*
//#UC END# *4728BC6A0088_4A4479E503D5_var*
begin
//#UC START# *4728BC6A0088_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BC6A0088_4A4479E503D5_impl*
end;//Hl3Canvas.DrawFocusRect

function Hl3Canvas.IsVirtual: Boolean;
//#UC START# *4728BC74029F_4A4479E503D5_var*
//#UC END# *4728BC74029F_4A4479E503D5_var*
begin
//#UC START# *4728BC74029F_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BC74029F_4A4479E503D5_impl*
end;//Hl3Canvas.IsVirtual

procedure Hl3Canvas.StartRegion;
//#UC START# *4728BC81028A_4A4479E503D5_var*
//#UC END# *4728BC81028A_4A4479E503D5_var*
begin
//#UC START# *4728BC81028A_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BC81028A_4A4479E503D5_impl*
end;//Hl3Canvas.StartRegion

procedure Hl3Canvas.FinishRegion;
//#UC START# *4728BC890119_4A4479E503D5_var*
//#UC END# *4728BC890119_4A4479E503D5_var*
begin
//#UC START# *4728BC890119_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BC890119_4A4479E503D5_impl*
end;//Hl3Canvas.FinishRegion

procedure Hl3Canvas.PushWO;
//#UC START# *4728BC9A022C_4A4479E503D5_var*
//#UC END# *4728BC9A022C_4A4479E503D5_var*
begin
//#UC START# *4728BC9A022C_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BC9A022C_4A4479E503D5_impl*
end;//Hl3Canvas.PushWO

procedure Hl3Canvas.PopWO;
//#UC START# *4728BCB60128_4A4479E503D5_var*
//#UC END# *4728BCB60128_4A4479E503D5_var*
begin
//#UC START# *4728BCB60128_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BCB60128_4A4479E503D5_impl*
end;//Hl3Canvas.PopWO

function Hl3Canvas.pm_GetWindowOrg: Tl3Point;
//#UC START# *4728BCF0038E_4A4479E503D5get_var*
//#UC END# *4728BCF0038E_4A4479E503D5get_var*
begin
//#UC START# *4728BCF0038E_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BCF0038E_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetWindowOrg

procedure Hl3Canvas.pm_SetWindowOrg(const aValue: Tl3Point);
//#UC START# *4728BCF0038E_4A4479E503D5set_var*
//#UC END# *4728BCF0038E_4A4479E503D5set_var*
begin
//#UC START# *4728BCF0038E_4A4479E503D5set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BCF0038E_4A4479E503D5set_impl*
end;//Hl3Canvas.pm_SetWindowOrg

function Hl3Canvas.pm_GetSWindowOrg: Tl3SPoint;
//#UC START# *4728BCFF03D6_4A4479E503D5get_var*
//#UC END# *4728BCFF03D6_4A4479E503D5get_var*
begin
//#UC START# *4728BCFF03D6_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BCFF03D6_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetSWindowOrg

procedure Hl3Canvas.pm_SetSWindowOrg(const aValue: Tl3SPoint);
//#UC START# *4728BCFF03D6_4A4479E503D5set_var*
//#UC END# *4728BCFF03D6_4A4479E503D5set_var*
begin
//#UC START# *4728BCFF03D6_4A4479E503D5set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BCFF03D6_4A4479E503D5set_impl*
end;//Hl3Canvas.pm_SetSWindowOrg

function Hl3Canvas.pm_GetClipRect: Tl3Rect;
//#UC START# *4728BD12038D_4A4479E503D5get_var*
//#UC END# *4728BD12038D_4A4479E503D5get_var*
begin
//#UC START# *4728BD12038D_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BD12038D_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetClipRect

procedure Hl3Canvas.pm_SetClipRect(const aValue: Tl3Rect);
//#UC START# *4728BD12038D_4A4479E503D5set_var*
//#UC END# *4728BD12038D_4A4479E503D5set_var*
begin
//#UC START# *4728BD12038D_4A4479E503D5set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BD12038D_4A4479E503D5set_impl*
end;//Hl3Canvas.pm_SetClipRect

function Hl3Canvas.pm_GetGlobalClipRect: Tl3Rect;
//#UC START# *4728BD2703E7_4A4479E503D5get_var*
//#UC END# *4728BD2703E7_4A4479E503D5get_var*
begin
//#UC START# *4728BD2703E7_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BD2703E7_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetGlobalClipRect

function Hl3Canvas.pm_GetBackColor: Tl3Color;
//#UC START# *4728BD3800A2_4A4479E503D5get_var*
//#UC END# *4728BD3800A2_4A4479E503D5get_var*
begin
//#UC START# *4728BD3800A2_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BD3800A2_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetBackColor

procedure Hl3Canvas.pm_SetBackColor(aValue: Tl3Color);
//#UC START# *4728BD3800A2_4A4479E503D5set_var*
//#UC END# *4728BD3800A2_4A4479E503D5set_var*
begin
//#UC START# *4728BD3800A2_4A4479E503D5set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BD3800A2_4A4479E503D5set_impl*
end;//Hl3Canvas.pm_SetBackColor

function Hl3Canvas.pm_GetDrawEnabled: Boolean;
//#UC START# *4728BD560290_4A4479E503D5get_var*
//#UC END# *4728BD560290_4A4479E503D5get_var*
begin
//#UC START# *4728BD560290_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BD560290_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetDrawEnabled

procedure Hl3Canvas.pm_SetDrawEnabled(aValue: Boolean);
//#UC START# *4728BD560290_4A4479E503D5set_var*
//#UC END# *4728BD560290_4A4479E503D5set_var*
begin
//#UC START# *4728BD560290_4A4479E503D5set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BD560290_4A4479E503D5set_impl*
end;//Hl3Canvas.pm_SetDrawEnabled

function Hl3Canvas.pm_GetDrawSpecial: Boolean;
//#UC START# *4728BD890258_4A4479E503D5get_var*
//#UC END# *4728BD890258_4A4479E503D5get_var*
begin
//#UC START# *4728BD890258_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BD890258_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetDrawSpecial

function Hl3Canvas.pm_GetCanDrawSubs: Boolean;
//#UC START# *4728BD9F0227_4A4479E503D5get_var*
//#UC END# *4728BD9F0227_4A4479E503D5get_var*
begin
//#UC START# *4728BD9F0227_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BD9F0227_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetCanDrawSubs

function Hl3Canvas.pm_GetShowCursor: Boolean;
//#UC START# *4728BDB301F4_4A4479E503D5get_var*
//#UC END# *4728BDB301F4_4A4479E503D5get_var*
begin
//#UC START# *4728BDB301F4_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BDB301F4_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetShowCursor

procedure Hl3Canvas.pm_SetShowCursor(aValue: Boolean);
//#UC START# *4728BDB301F4_4A4479E503D5set_var*
//#UC END# *4728BDB301F4_4A4479E503D5set_var*
begin
//#UC START# *4728BDB301F4_4A4479E503D5set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BDB301F4_4A4479E503D5set_impl*
end;//Hl3Canvas.pm_SetShowCursor

function Hl3Canvas.pm_GetFontIndexSet: Tl3FontIndexes;
//#UC START# *4728BE1500AA_4A4479E503D5get_var*
//#UC END# *4728BE1500AA_4A4479E503D5get_var*
begin
//#UC START# *4728BE1500AA_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BE1500AA_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetFontIndexSet

procedure Hl3Canvas.pm_SetFontIndexSet(aValue: Tl3FontIndexes);
//#UC START# *4728BE1500AA_4A4479E503D5set_var*
//#UC END# *4728BE1500AA_4A4479E503D5set_var*
begin
//#UC START# *4728BE1500AA_4A4479E503D5set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BE1500AA_4A4479E503D5set_impl*
end;//Hl3Canvas.pm_SetFontIndexSet

function Hl3Canvas.pm_GetPrinted: Boolean;
//#UC START# *4728BE460354_4A4479E503D5get_var*
//#UC END# *4728BE460354_4A4479E503D5get_var*
begin
//#UC START# *4728BE460354_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BE460354_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetPrinted

procedure Hl3Canvas.pm_SetPrinted(aValue: Boolean);
//#UC START# *4728BE460354_4A4479E503D5set_var*
//#UC END# *4728BE460354_4A4479E503D5set_var*
begin
//#UC START# *4728BE460354_4A4479E503D5set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BE460354_4A4479E503D5set_impl*
end;//Hl3Canvas.pm_SetPrinted

function Hl3Canvas.pm_GetPageNumber: Integer;
//#UC START# *4728BE6A0392_4A4479E503D5get_var*
//#UC END# *4728BE6A0392_4A4479E503D5get_var*
begin
//#UC START# *4728BE6A0392_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BE6A0392_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetPageNumber

function Hl3Canvas.pm_GetPageWidthNumber: Integer;
//#UC START# *4728BE830080_4A4479E503D5get_var*
//#UC END# *4728BE830080_4A4479E503D5get_var*
begin
//#UC START# *4728BE830080_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728BE830080_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetPageWidthNumber

function Hl3Canvas.pm_GetPenWidth: Integer;
//#UC START# *4728C0510003_4A4479E503D5get_var*
//#UC END# *4728C0510003_4A4479E503D5get_var*
begin
//#UC START# *4728C0510003_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728C0510003_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetPenWidth

function Hl3Canvas.pm_GetPageOrientation: Tl3PageOrientation;
//#UC START# *4728C06D0306_4A4479E503D5get_var*
//#UC END# *4728C06D0306_4A4479E503D5get_var*
begin
//#UC START# *4728C06D0306_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728C06D0306_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetPageOrientation

procedure Hl3Canvas.pm_SetPageOrientation(aValue: Tl3PageOrientation);
//#UC START# *4728C06D0306_4A4479E503D5set_var*
//#UC END# *4728C06D0306_4A4479E503D5set_var*
begin
//#UC START# *4728C06D0306_4A4479E503D5set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728C06D0306_4A4479E503D5set_impl*
end;//Hl3Canvas.pm_SetPageOrientation

function Hl3Canvas.pm_GetSectionExtent: Tl3Point;
//#UC START# *4728C0890017_4A4479E503D5get_var*
//#UC END# *4728C0890017_4A4479E503D5get_var*
begin
//#UC START# *4728C0890017_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728C0890017_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetSectionExtent

procedure Hl3Canvas.pm_SetSectionExtent(const aValue: Tl3Point);
//#UC START# *4728C0890017_4A4479E503D5set_var*
//#UC END# *4728C0890017_4A4479E503D5set_var*
begin
//#UC START# *4728C0890017_4A4479E503D5set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728C0890017_4A4479E503D5set_impl*
end;//Hl3Canvas.pm_SetSectionExtent

procedure Hl3Canvas.pm_SetNotFocused(aValue: Boolean);
//#UC START# *4728C0BB013B_4A4479E503D5set_var*
//#UC END# *4728C0BB013B_4A4479E503D5set_var*
begin
//#UC START# *4728C0BB013B_4A4479E503D5set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728C0BB013B_4A4479E503D5set_impl*
end;//Hl3Canvas.pm_SetNotFocused

function Hl3Canvas.pm_GetRegionBottomRight: Tl3Point;
//#UC START# *4728C0C90182_4A4479E503D5get_var*
//#UC END# *4728C0C90182_4A4479E503D5get_var*
begin
//#UC START# *4728C0C90182_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4728C0C90182_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetRegionBottomRight

function Hl3Canvas.GetClientRect: Tl3Rect;
//#UC START# *476FA1140319_4A4479E503D5_var*
//#UC END# *476FA1140319_4A4479E503D5_var*
begin
//#UC START# *476FA1140319_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *476FA1140319_4A4479E503D5_impl*
end;//Hl3Canvas.GetClientRect

function Hl3Canvas.AdjustMarginsByPrintableArea(const aMargins: Tl3_Rect): Tl3_Rect;
 {* Откорректировать поля с учетом непечатаемой области }
//#UC START# *4776171C037B_4A4479E503D5_var*
//#UC END# *4776171C037B_4A4479E503D5_var*
begin
//#UC START# *4776171C037B_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4776171C037B_4A4479E503D5_impl*
end;//Hl3Canvas.AdjustMarginsByPrintableArea

function Hl3Canvas.Get_PasswordChar: AnsiChar;
//#UC START# *483D1BCA0045_4A4479E503D5get_var*
//#UC END# *483D1BCA0045_4A4479E503D5get_var*
begin
//#UC START# *483D1BCA0045_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *483D1BCA0045_4A4479E503D5get_impl*
end;//Hl3Canvas.Get_PasswordChar

procedure Hl3Canvas.Set_PasswordChar(aValue: AnsiChar);
//#UC START# *483D1BCA0045_4A4479E503D5set_var*
//#UC END# *483D1BCA0045_4A4479E503D5set_var*
begin
//#UC START# *483D1BCA0045_4A4479E503D5set_impl*
 !!! Needs to be implemented !!!
//#UC END# *483D1BCA0045_4A4479E503D5set_impl*
end;//Hl3Canvas.Set_PasswordChar

function Hl3Canvas.Get_EffectiveColors: Il3EffectiveColors;
//#UC START# *487CFBE202B1_4A4479E503D5get_var*
//#UC END# *487CFBE202B1_4A4479E503D5get_var*
begin
//#UC START# *487CFBE202B1_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *487CFBE202B1_4A4479E503D5get_impl*
end;//Hl3Canvas.Get_EffectiveColors

function Hl3Canvas.pm_GetPrinting: Boolean;
//#UC START# *4897E01001E7_4A4479E503D5get_var*
//#UC END# *4897E01001E7_4A4479E503D5get_var*
begin
//#UC START# *4897E01001E7_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4897E01001E7_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetPrinting

function Hl3Canvas.CheckConvertString(const aStr: Tl3PCharLen): Tl3PCharLen;
 {* преобразует строку для отображения форматирующей информации в режиме DrawSpecial. }
//#UC START# *4A0BD46901A0_4A4479E503D5_var*
//#UC END# *4A0BD46901A0_4A4479E503D5_var*
begin
//#UC START# *4A0BD46901A0_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A0BD46901A0_4A4479E503D5_impl*
end;//Hl3Canvas.CheckConvertString

function Hl3Canvas.CheckOutString(const aStr: Tl3PCharLen): Tl3PCharLen;
//#UC START# *4A0BD4D4007E_4A4479E503D5_var*
//#UC END# *4A0BD4D4007E_4A4479E503D5_var*
begin
//#UC START# *4A0BD4D4007E_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A0BD4D4007E_4A4479E503D5_impl*
end;//Hl3Canvas.CheckOutString

function Hl3Canvas.pm_GetZoom: Integer;
//#UC START# *4A4B894303D5_4A4479E503D5get_var*
//#UC END# *4A4B894303D5_4A4479E503D5get_var*
begin
//#UC START# *4A4B894303D5_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A4B894303D5_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetZoom

procedure Hl3Canvas.pm_SetZoom(aValue: Integer);
//#UC START# *4A4B894303D5_4A4479E503D5set_var*
//#UC END# *4A4B894303D5_4A4479E503D5set_var*
begin
//#UC START# *4A4B894303D5_4A4479E503D5set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A4B894303D5_4A4479E503D5set_impl*
end;//Hl3Canvas.pm_SetZoom

function Hl3Canvas.pm_GetPageSetup: Il3PageSetup;
//#UC START# *4A4CD86601B2_4A4479E503D5get_var*
//#UC END# *4A4CD86601B2_4A4479E503D5get_var*
begin
//#UC START# *4A4CD86601B2_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A4CD86601B2_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetPageSetup

procedure Hl3Canvas.pm_SetPainter(const aValue: Il3HAFPainter);
//#UC START# *4A4CD8BC027E_4A4479E503D5set_var*
//#UC END# *4A4CD8BC027E_4A4479E503D5set_var*
begin
//#UC START# *4A4CD8BC027E_4A4479E503D5set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A4CD8BC027E_4A4479E503D5set_impl*
end;//Hl3Canvas.pm_SetPainter

function Hl3Canvas.pm_GetCanvas: TCanvas;
//#UC START# *4A4CD9100133_4A4479E503D5get_var*
//#UC END# *4A4CD9100133_4A4479E503D5get_var*
begin
//#UC START# *4A4CD9100133_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A4CD9100133_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetCanvas

function Hl3Canvas.DP2LP(const aP: Tl3_SPoint): Tl3Point;
 {* Преобразует точку в пикселях в точку в дюймах }
//#UC START# *4A4CE0990013_4A4479E503D5_var*
//#UC END# *4A4CE0990013_4A4479E503D5_var*
begin
//#UC START# *4A4CE0990013_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A4CE0990013_4A4479E503D5_impl*
end;//Hl3Canvas.DP2LP

function Hl3Canvas.DeviceCaps(anIndex: Integer): Integer;
 {* возвращает свойства устройства рисования. }
//#UC START# *4A4CEC6202C3_4A4479E503D5_var*
//#UC END# *4A4CEC6202C3_4A4479E503D5_var*
begin
//#UC START# *4A4CEC6202C3_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A4CEC6202C3_4A4479E503D5_impl*
end;//Hl3Canvas.DeviceCaps

function Hl3Canvas.Get_IsPagesCounter: Boolean;
//#UC START# *4CB32CEA01FE_4A4479E503D5get_var*
//#UC END# *4CB32CEA01FE_4A4479E503D5get_var*
begin
//#UC START# *4CB32CEA01FE_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CB32CEA01FE_4A4479E503D5get_impl*
end;//Hl3Canvas.Get_IsPagesCounter

function Hl3Canvas.Get_OverallPageNumber: Integer;
//#UC START# *4CC68B5D00CA_4A4479E503D5get_var*
//#UC END# *4CC68B5D00CA_4A4479E503D5get_var*
begin
//#UC START# *4CC68B5D00CA_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CC68B5D00CA_4A4479E503D5get_impl*
end;//Hl3Canvas.Get_OverallPageNumber

function Hl3Canvas.Get_InitialDCOffset: Tl3Point;
//#UC START# *4E007CC302AE_4A4479E503D5get_var*
//#UC END# *4E007CC302AE_4A4479E503D5get_var*
begin
//#UC START# *4E007CC302AE_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E007CC302AE_4A4479E503D5get_impl*
end;//Hl3Canvas.Get_InitialDCOffset

function Hl3Canvas.PushClipRect: Tl3Rect;
//#UC START# *4E26F481005B_4A4479E503D5_var*
//#UC END# *4E26F481005B_4A4479E503D5_var*
begin
//#UC START# *4E26F481005B_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E26F481005B_4A4479E503D5_impl*
end;//Hl3Canvas.PushClipRect

procedure Hl3Canvas.PopClipRect;
//#UC START# *4E26F4920228_4A4479E503D5_var*
//#UC END# *4E26F4920228_4A4479E503D5_var*
begin
//#UC START# *4E26F4920228_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E26F4920228_4A4479E503D5_impl*
end;//Hl3Canvas.PopClipRect

procedure Hl3Canvas.Set_ClipRegion(const aValue: Il3Region);
//#UC START# *4E27061B0140_4A4479E503D5set_var*
//#UC END# *4E27061B0140_4A4479E503D5set_var*
begin
//#UC START# *4E27061B0140_4A4479E503D5set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E27061B0140_4A4479E503D5set_impl*
end;//Hl3Canvas.Set_ClipRegion

function Hl3Canvas.Get_LineSpacing: Integer;
//#UC START# *4E57A9F10230_4A4479E503D5get_var*
//#UC END# *4E57A9F10230_4A4479E503D5get_var*
begin
//#UC START# *4E57A9F10230_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E57A9F10230_4A4479E503D5get_impl*
end;//Hl3Canvas.Get_LineSpacing

procedure Hl3Canvas.Set_LineSpacing(aValue: Integer);
//#UC START# *4E57A9F10230_4A4479E503D5set_var*
//#UC END# *4E57A9F10230_4A4479E503D5set_var*
begin
//#UC START# *4E57A9F10230_4A4479E503D5set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E57A9F10230_4A4479E503D5set_impl*
end;//Hl3Canvas.Set_LineSpacing

procedure Hl3Canvas.PushLineSpacing;
//#UC START# *4E6894860139_4A4479E503D5_var*
//#UC END# *4E6894860139_4A4479E503D5_var*
begin
//#UC START# *4E6894860139_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E6894860139_4A4479E503D5_impl*
end;//Hl3Canvas.PushLineSpacing

procedure Hl3Canvas.PopLineSpacing;
//#UC START# *4E68949A0121_4A4479E503D5_var*
//#UC END# *4E68949A0121_4A4479E503D5_var*
begin
//#UC START# *4E68949A0121_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E68949A0121_4A4479E503D5_impl*
end;//Hl3Canvas.PopLineSpacing

function Hl3Canvas.pm_GetInvert: Boolean;
//#UC START# *4ED5066F036B_4A4479E503D5get_var*
//#UC END# *4ED5066F036B_4A4479E503D5get_var*
begin
//#UC START# *4ED5066F036B_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ED5066F036B_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetInvert

function Hl3Canvas.Get_InitialDCOffsetStored: Tl3Point;
//#UC START# *4F2AC2020377_4A4479E503D5get_var*
//#UC END# *4F2AC2020377_4A4479E503D5get_var*
begin
//#UC START# *4F2AC2020377_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F2AC2020377_4A4479E503D5get_impl*
end;//Hl3Canvas.Get_InitialDCOffsetStored

function Hl3Canvas.pm_GetFrameLines: Il3FrameLines;
//#UC START# *5077CF6501AE_4A4479E503D5get_var*
//#UC END# *5077CF6501AE_4A4479E503D5get_var*
begin
//#UC START# *5077CF6501AE_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5077CF6501AE_4A4479E503D5get_impl*
end;//Hl3Canvas.pm_GetFrameLines

function Hl3Canvas.Get_AbortChecker: Il3AbortChecker;
//#UC START# *5229D7EF00DE_4A4479E503D5get_var*
//#UC END# *5229D7EF00DE_4A4479E503D5get_var*
begin
//#UC START# *5229D7EF00DE_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5229D7EF00DE_4A4479E503D5get_impl*
end;//Hl3Canvas.Get_AbortChecker

procedure Hl3Canvas.Set_AbortChecker(const aValue: Il3AbortChecker);
//#UC START# *5229D7EF00DE_4A4479E503D5set_var*
//#UC END# *5229D7EF00DE_4A4479E503D5set_var*
begin
//#UC START# *5229D7EF00DE_4A4479E503D5set_impl*
 !!! Needs to be implemented !!!
//#UC END# *5229D7EF00DE_4A4479E503D5set_impl*
end;//Hl3Canvas.Set_AbortChecker

procedure Hl3Canvas.StartDrawAAC(aType: TspBlockType);
//#UC START# *54B4D8E90117_4A4479E503D5_var*
//#UC END# *54B4D8E90117_4A4479E503D5_var*
begin
//#UC START# *54B4D8E90117_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *54B4D8E90117_4A4479E503D5_impl*
end;//Hl3Canvas.StartDrawAAC

procedure Hl3Canvas.EndDrawAAC(const R: Tl3Rect);
//#UC START# *54B4D9020149_4A4479E503D5_var*
//#UC END# *54B4D9020149_4A4479E503D5_var*
begin
//#UC START# *54B4D9020149_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *54B4D9020149_4A4479E503D5_impl*
end;//Hl3Canvas.EndDrawAAC

procedure Hl3Canvas.BeginDarkColor;
//#UC START# *55CC51AD0273_4A4479E503D5_var*
//#UC END# *55CC51AD0273_4A4479E503D5_var*
begin
//#UC START# *55CC51AD0273_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *55CC51AD0273_4A4479E503D5_impl*
end;//Hl3Canvas.BeginDarkColor

procedure Hl3Canvas.EndDarkColor;
//#UC START# *55CC51CE0059_4A4479E503D5_var*
//#UC END# *55CC51CE0059_4A4479E503D5_var*
begin
//#UC START# *55CC51CE0059_4A4479E503D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *55CC51CE0059_4A4479E503D5_impl*
end;//Hl3Canvas.EndDarkColor

function Hl3Canvas.Get_etoFlags: Cardinal;
//#UC START# *57D6D54102F4_4A4479E503D5get_var*
//#UC END# *57D6D54102F4_4A4479E503D5get_var*
begin
//#UC START# *57D6D54102F4_4A4479E503D5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *57D6D54102F4_4A4479E503D5get_impl*
end;//Hl3Canvas.Get_etoFlags

procedure Hl3Canvas.Set_etoFlags(aValue: Cardinal);
//#UC START# *57D6D54102F4_4A4479E503D5set_var*
//#UC END# *57D6D54102F4_4A4479E503D5set_var*
begin
//#UC START# *57D6D54102F4_4A4479E503D5set_impl*
 !!! Needs to be implemented !!!
//#UC END# *57D6D54102F4_4A4479E503D5set_impl*
end;//Hl3Canvas.Set_etoFlags

{$If NOT Defined(XE4)}
procedure Hl3Canvas.Fake;
 {* это нужно чтобы правильно генерировались вызовы методов доступа к свойствам }
begin
 Assert(false);
end;//Hl3Canvas.Fake
{$IfEnd} // NOT Defined(XE4)

constructor Hl3Canvas.Init(const aIl3Canvas: Il3Canvas);
begin
 f_Il3Canvas := aIl3Canvas;
end;//Hl3Canvas.Init

end.
