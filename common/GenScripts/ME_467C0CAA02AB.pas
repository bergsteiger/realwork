unit l3InternalInterfaces;
 {* Внутренние интерфейсы библиотеки L3. }

// Модуль: "w:\common\components\rtl\Garant\L3\l3InternalInterfaces.pas"
// Стереотип: "Interfaces"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3Types
 , l3Units
 , Classes
 , l3PrinterInterfaces
 , l3Core
;

type
 Il3Base = l3Interfaces.Il3Base;

 PIl3KeyDataListener = ^Il3KeyDataListener;

 Il3ObjectWrap = interface(Il3Base)
  {* Обертка вокруг объекта. Шаманство. Надо избавляться. }
  ['{691F62FE-0591-496A-AE9B-E36CE787B014}']
  function GetObject: TObject;
   {* получить объект из обертки. }
 end;//Il3ObjectWrap

 Il3CommandTarget = interface(Il3Base)
  {* Устройство для выполнения команд пользовательского ввода. }
  ['{C86F6C05-5FD3-46A8-B93C-7F941E64306C}']
  function ProcessCommand(Cmd: Tl3OperationCode;
   aForce: Boolean;
   aCount: Integer): Boolean;
 end;//Il3CommandTarget

 Il3Region = interface(Il3Base)
  {* Регион. }
  ['{A41D0FB9-7718-474F-8838-0F89E31E497D}']
  function pm_GetRgn: Tl3Rgn;
  procedure pm_SetRgn(aValue: Tl3Rgn);
  function pm_GetRect: Tl3SRect;
  procedure pm_SetRect(const aValue: Tl3SRect);
  function pm_GetEmpty: Boolean;
  function Clone: Il3Region;
   {* Создает копию региона. }
  function CombineRect(const Rect: Tl3SRect;
   CombineMode: Integer): Integer;
   {* комбинирует регион с прямоугольником Rect. }
  function Combine(const Source: Il3Region;
   CombineMode: Integer): Integer;
   {* комбинирует регион с регионом Source. }
  function Offset(const P: Tl3SPoint): Integer;
   {* осуществляет сдвиг региона. }
  function ContainsRect(const aRect: Tl3SRect): Boolean;
   {* определяет находится ли aRect в данном регионе. }
  procedure Assign(const Source: Il3Region);
   {* присваивает региону Source. }
  property Rgn: Tl3Rgn
   read pm_GetRgn
   write pm_SetRgn;
   {* Windows handle региона. }
  property Rect: Tl3SRect
   read pm_GetRect
   write pm_SetRect;
   {* прямоугольник в который вписан регион. }
  property Empty: Boolean
   read pm_GetEmpty;
   {* пустой регион? }
 end;//Il3Region

 Tl3TextFormatFlag = (
  {* Выравнивание текста. }
  l3_tffLeft
  , l3_tffCenter
  , l3_tffRight
 );//Tl3TextFormatFlag

 Il3EffectiveColors = interface(Il3Base)
  ['{2ED99AA8-FE25-4CA4-AA56-D24EDFA91DBB}']
  function Get_FontColor: Tl3Color;
  function Get_Font: Il3Font;
  procedure CheckColors;
  property FontColor: Tl3Color
   read Get_FontColor;
  property Font: Il3Font
   read Get_Font;
 end;//Il3EffectiveColors

 Il3HAFMacroReplacer = interface(Il3Base)
  ['{D3D0DD5B-1F2F-445D-9C3F-0E0A99F71B97}']
  function Get_Parent: Il3HAFMacroReplacer;
  procedure Set_Parent(const aValue: Il3HAFMacroReplacer);
  function Replace(const aText: Il3CString): Il3CString;
  function UnfoldOne(const aMacroName: Il3CString): Il3CString;
  property Parent: Il3HAFMacroReplacer
   read Get_Parent
   write Set_Parent;
 end;//Il3HAFMacroReplacer

 (*
 Ml3UnitsConverter = interface
  {* Методы для конвертации различных единиц измерения }
  function DP2LP(const aP: Tl3_SPoint): Tl3Point;
   {* Преобразует точку в пикселях в точку в дюймах }
 end;//Ml3UnitsConverter
 *)

 (*
 Ml3OutputDevice = interface
  {* Устройство вывода }
  function DeviceCaps(anIndex: Integer): Integer;
   {* возвращает свойства устройства рисования. }
 end;//Ml3OutputDevice
 *)

 Tl3DrawingStyle = (
  l3_dsFocus
  , l3_dsSelected
  , l3_dsNormal
  , l3_dsTransparent
 );//Tl3DrawingStyle

 Tl3ImageType = (
  l3_itImage
  , l3_itMask
 );//Tl3ImageType

 (*
 Ml3PageInfo = interface
  {* Информация о странице }
  function Get_IsPagesCounter: Boolean;
  property IsPagesCounter: Boolean
   read Get_IsPagesCounter;
 end;//Ml3PageInfo
 *)

 (*
 Ml3PageNumberInfo = interface
  {* Информация о номерах страницы }
  function pm_GetPageNumber: Integer;
  function pm_GetPageWidthNumber: Integer;
  function Get_OverallPageNumber: Integer;
  property PageNumber: Integer
   read pm_GetPageNumber;
   {* номер страницы в высоту. }
  property PageWidthNumber: Integer
   read pm_GetPageWidthNumber;
   {* номер страницы в ширину. }
  property OverallPageNumber: Integer
   read Get_OverallPageNumber;
 end;//Ml3PageNumberInfo
 *)

 Tl3MouseResult = (
  {* результат обработки события мыши. }
  l3_mrNotHandled
  , l3_mrHandled
  , l3_mrHandledAndMoveLoopNeed
 );//Tl3MouseResult

 Il3MouseHandler = interface(Il3Base)
  {* Интерфейс для части объекта, обрабатывающей действия мышью. }
  ['{A07E25E8-8BC2-4380-AD10-56797D6E72A9}']
  function DoAction(const aClickContext: IUnknown;
   const aPt: Tl3Point;
   aButton: Tl3MouseButton;
   anAction: Tl3MouseAction;
   Keys: TShiftState): Tl3MouseResult;
   {* обрабатывает событие от мыши. }
 end;//Il3MouseHandler

 (*
 Ml3CanvasInfo = interface
  function IsVirtual: Boolean;
 end;//Ml3CanvasInfo
 *)

 Il3KeyDataListener = interface(Il3Base)
  ['{1F8789EB-2BD7-45B1-9D32-AC7166B3C971}']
  function ProcessKeyData(aKey: Byte;
   aShiftFlags: Byte): Boolean;
 end;//Il3KeyDataListener

 Il3CommandPublisherInfo = interface(Il3Base)
  ['{A76B5904-5A7D-4604-8685-6EEAC802130B}']
  function IsCommandPublished(Cmd: Tl3OperationCode): Boolean;
 end;//Il3CommandPublisherInfo

 Il3Flush = interface(Il3Base)
  ['{A8A55A25-815C-43BA-A462-2AFA7DA0D93D}']
  function Flush: Boolean;
 end;//Il3Flush

 (*
 Ml3WindowOrg = interface
  function Get_InitialDCOffset: Tl3Point;
  function Get_InitialDCOffsetStored: Tl3Point;
  property InitialDCOffset: Tl3Point
   read Get_InitialDCOffset;
  property InitialDCOffsetStored: Tl3Point
   read Get_InitialDCOffsetStored;
 end;//Ml3WindowOrg
 *)

 (*
 Ml3CanvasState = interface
  procedure Set_ClipRegion(const aValue: Il3Region);
  function PushClipRect: Tl3Rect;
  procedure PopClipRect;
  property ClipRegion: Il3Region
   write Set_ClipRegion;
 end;//Ml3CanvasState
 *)

 Il3ActionControl = interface(Il3Base)
  ['{37288C7F-2AAB-4DC0-B676-9C74EDA7EF65}']
  function Get_ActionData(Action: Integer): Integer;
  procedure Set_ActionData(Action: Integer;
   aValue: Integer);
  property ActionData[Action: Integer]: Integer
   read Get_ActionData
   write Set_ActionData;
 end;//Il3ActionControl

 Il3Control = interface(Il3Base)
  ['{7F25486F-544E-4CD1-B058-C3EA068969F7}']
  function Get_Enabled: Boolean;
  procedure Set_Enabled(aValue: Boolean);
  property Enabled: Boolean
   read Get_Enabled
   write Set_Enabled;
 end;//Il3Control

 Il3StringList = interface(Il3List)
  ['{8B53FD66-D56F-4913-8945-2BD2D645DC70}']
  function pm_GetItems(anIndex: Integer): Tl3PCharLen;
  procedure pm_SetItems(anIndex: Integer;
   const aValue: Tl3PCharLen);
  property Items[anIndex: Integer]: Tl3PCharLen
   read pm_GetItems
   write pm_SetItems;
   default;
 end;//Il3StringList

 (*
 Ml3TextProperties = interface
  function Get_LineSpacing: Integer;
  procedure Set_LineSpacing(aValue: Integer);
  procedure PushLineSpacing;
  procedure PopLineSpacing;
  property LineSpacing: Integer
   read Get_LineSpacing
   write Set_LineSpacing;
   {* Интерлиньяж в процентах от размера строки }
 end;//Ml3TextProperties
 *)

 Tl3PageOrientationArray = array [Tl3PageOrientation] of Tl3PageOrientation;

 Il3HandledStringList = interface(Il3StringList)
  ['{CFC585AD-D7E7-4325-BF6B-E928E68165D7}']
  function pm_GetHandle(anIndex: Integer): Integer;
  procedure pm_SetHandle(anIndex: Integer;
   aValue: Integer);
  property Handle[anIndex: Integer]: Integer
   read pm_GetHandle
   write pm_SetHandle;
 end;//Il3HandledStringList

 Il3CharSkipper = interface(Il3Base)
  ['{DB25BBA5-10B9-4F2D-93EC-16351A7DFE81}']
  procedure Init(aString: TObject);
  function GetChar: AnsiChar;
  function Index: Integer;
 end;//Il3CharSkipper

 Il3StringFormatter = interface(Il3Base)
  ['{26768C5D-F8B0-44AE-AB15-1D2DFC8A3B63}']
  procedure FixWidth(aString: TObject;
   aDelta: Integer;
   var aSpacesCount: Integer);
   {* Форматирует строку по ширине, добавляя в ней aSpacesCount пробелов.
             Количество неиспользованных пробелов возвращается в aSpacesCount.
             Если возвращается 0, то строка не была изменена. 
             aDelta - количество символов в конце строки, которые можно 
             игнорировать при подсчете пробелов. }
 end;//Il3StringFormatter

 Il3FontInfo2 = interface(Il3Font)
  ['{3B86A55A-5E98-40CB-B2B4-212387320131}']
 end;//Il3FontInfo2

 Il3ViewStringList = interface(Il3Base)
  ['{96740AF4-AF0E-4024-BC7D-A16A1A028915}']
  function pm_GetCount: Integer;
  function pm_GetViewString(anIndex: Integer): Il3CString;
  property Count: Integer
   read pm_GetCount;
   {* число элементов в хранилище. }
  property ViewString[anIndex: Integer]: Il3CString
   read pm_GetViewString;
   default;
 end;//Il3ViewStringList

 Il3StorageSource = interface(Il3Base)
  ['{5164CBED-D742-4695-98DA-180B7CC128EE}']
  function pm_GetStorage: IStorage;
  property Storage: IStorage
   read pm_GetStorage;
 end;//Il3StorageSource

 Il3ActionProcessor = interface(Il3Base)
  {* Объект обработчик операций. }
  ['{4A710C7C-37ED-4FE1-9D71-DAE3600BA633}']
  function Process(Sender: TObject;
   Target: TObject;
   Action: Integer;
   Down: Boolean): Boolean;
   {* функция обработки операции. }
 end;//Il3ActionProcessor

 Il3Renderer = interface(Il3Base)
  {* Объект, рисующий картинку }
  ['{7AD269DC-BA07-488A-94D6-351661997993}']
  procedure Render(aCanvas: TCanvas;
   const aColors: Il3EffectiveColors);
   {* Отрисовать картинку }
  function CalcExtent(const aFont: Il3Font): Tl3_SPoint;
  procedure SetForWMF(aValue: Boolean);
 end;//Il3Renderer

 (*
 Ml3CanvasInvert = interface
  function pm_GetInvert: Boolean;
  procedure BeginInvert;
  procedure EndInvert;
  property Invert: Boolean
   read pm_GetInvert;
 end;//Ml3CanvasInvert
 *)

 Tl3FrameObjectBehaviour = (
  l3_fobNone
  , l3_fobPrinting
  , l3_fobIgnore
 );//Tl3FrameObjectBehaviour

 Il3AbortChecker = interface(Il3Base)
  ['{449D2C36-4C38-4A05-95ED-96C56BD43B81}']
  function IsAborted: Boolean;
 end;//Il3AbortChecker

 TspBlockType = (
  sp_btNone
  , sp_btText
  , sp_btBlock
 );//TspBlockType

 (*
 Ml3CanvasPaint = interface
  procedure BeginPaint;
  procedure EndPaint;
 end;//Ml3CanvasPaint
 *)

 (*
 Ml3InfoCanvas = interface
  function DR2LR(const R: Tl3SRect): Tl3Rect;
   {* преобразует прямоугольник в пикселях в прямоугольник в дюймах. }
  function LP2DP(const P: Tl3_Point;
   NeedZoom: Boolean = False): Tl3SPoint;
   {* преобразует точку в дюймах в точку в пикселях. }
  function LR2DR(const R: Tl3Rect): Tl3SRect;
   {* преобразует прямоугольник в дюймах в прямоугольник в пикселях. }
  function TextExtent(const S: Tl3WString;
   aNoTabs: Boolean = False): Tl3Point;
   {* возвращает длину строки текста в дюймах. }
  function DrawText(const aSt: Tl3WString;
   var R: TRect;
   aFormat: Cardinal;
   AFl: TObject = nil): Il3MultiLines;
   {* как ни глупо звучит, но это нужно на информационной канве, т.к. она вычисляет прямоугольник вывода. }
 end;//Ml3InfoCanvas
 *)

 Il3CStringList = interface(Il3List)
  ['{F7BD6D08-43A8-4C7B-AF1B-BA0233E5CA55}']
  function pm_GetItems(anIndex: Integer): Il3CString;
  property Items[anIndex: Integer]: Il3CString
   read pm_GetItems;
   default;
 end;//Il3CStringList

 Tl3AskClearClipboardProc = procedure(var aResult: Integer) of object;

 Il3FrameLines = interface;

 Il3InfoCanvas = interface(Il3Base)
  {* Информационная канва - только для получения метрик }
  ['{B5288390-13E8-4522-8C74-6CE46266FBA2}']
  function pm_GetDC: hDC;
  procedure pm_SetDC(aValue: hDC);
  function pm_GetPixelsPerInchX: Integer;
  function pm_GetPixelsPerInchY: Integer;
  function Get_PasswordChar: AnsiChar;
  procedure Set_PasswordChar(aValue: AnsiChar);
  function pm_GetPrinting: Boolean;
  function pm_GetZoom: Integer;
  procedure pm_SetZoom(aValue: Integer);
  function Get_Font: Il3Font;
  procedure Set_Font(const aValue: Il3Font);
  function pm_GetFrameLines: Il3FrameLines;
  function Get_IsPagesCounter: Boolean;
  function pm_GetPageNumber: Integer;
  function pm_GetPageWidthNumber: Integer;
  function Get_OverallPageNumber: Integer;
  function Get_LineSpacing: Integer;
  procedure Set_LineSpacing(aValue: Integer);
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
  function AdjustMarginsByPrintableArea(const aMargins: Tl3_Rect): Tl3_Rect;
   {* Откорректировать поля с учетом непечатаемой области }
  function CheckConvertString(const aStr: Tl3PCharLen): Tl3PCharLen;
   {* преобразует строку для отображения форматирующей информации в режиме DrawSpecial. }
  function CheckOutString(const aStr: Tl3PCharLen): Tl3PCharLen;
  function DP2LP(const aP: Tl3_SPoint): Tl3Point;
   {* Преобразует точку в пикселях в точку в дюймах }
  function DeviceCaps(anIndex: Integer): Integer;
   {* возвращает свойства устройства рисования. }
  function IsVirtual: Boolean;
  procedure PushLineSpacing;
  procedure PopLineSpacing;
  function DR2LR(const R: Tl3SRect): Tl3Rect;
   {* преобразует прямоугольник в пикселях в прямоугольник в дюймах. }
  function LP2DP(const P: Tl3_Point;
   NeedZoom: Boolean = False): Tl3SPoint;
   {* преобразует точку в дюймах в точку в пикселях. }
  function LR2DR(const R: Tl3Rect): Tl3SRect;
   {* преобразует прямоугольник в дюймах в прямоугольник в пикселях. }
  function TextExtent(const S: Tl3WString;
   aNoTabs: Boolean = False): Tl3Point;
   {* возвращает длину строки текста в дюймах. }
  function DrawText(const aSt: Tl3WString;
   var R: TRect;
   aFormat: Cardinal;
   AFl: TObject = nil): Il3MultiLines;
   {* как ни глупо звучит, но это нужно на информационной канве, т.к. она вычисляет прямоугольник вывода. }
  property DC: hDC
   read pm_GetDC
   write pm_SetDC;
   {* Handle контекста. }
  property PixelsPerInchX: Integer
   read pm_GetPixelsPerInchX;
  property PixelsPerInchY: Integer
   read pm_GetPixelsPerInchY;
  property PasswordChar: AnsiChar
   read Get_PasswordChar
   write Set_PasswordChar;
  property Printing: Boolean
   read pm_GetPrinting;
   {* печать? }
  property Zoom: Integer
   read pm_GetZoom
   write pm_SetZoom;
   {* масштаб. }
  property Font: Il3Font
   read Get_Font
   write Set_Font;
   {* текущий шрифт. }
  property FrameLines: Il3FrameLines
   read pm_GetFrameLines;
  property IsPagesCounter: Boolean
   read Get_IsPagesCounter;
  property PageNumber: Integer
   read pm_GetPageNumber;
   {* номер страницы в высоту. }
  property PageWidthNumber: Integer
   read pm_GetPageWidthNumber;
   {* номер страницы в ширину. }
  property OverallPageNumber: Integer
   read Get_OverallPageNumber;
  property LineSpacing: Integer
   read Get_LineSpacing
   write Set_LineSpacing;
   {* Интерлиньяж в процентах от размера строки }
 end;//Il3InfoCanvas

 Il3HAFPainter = interface;

 Il3Canvas = interface(Il3InfoCanvas)
  {* Канва для рисования }
  ['{F14964DA-11A9-490F-8D5C-A02BEAF85B84}']
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
  function Get_EffectiveColors: Il3EffectiveColors;
  function pm_GetPageSetup: Il3PageSetup;
  procedure pm_SetPainter(const aValue: Il3HAFPainter);
  function pm_GetCanvas: TCanvas;
  function Get_AbortChecker: Il3AbortChecker;
  procedure Set_AbortChecker(const aValue: Il3AbortChecker);
  function Get_InitialDCOffset: Tl3Point;
  function Get_InitialDCOffsetStored: Tl3Point;
  procedure Set_ClipRegion(const aValue: Il3Region);
  function pm_GetInvert: Boolean;
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
  function GetClientRect: Tl3Rect;
  procedure StartDrawAAC(aType: TspBlockType);
  procedure EndDrawAAC(const R: Tl3Rect);
  procedure BeginDarkColor;
  procedure EndDarkColor;
  function PushClipRect: Tl3Rect;
  procedure PopClipRect;
  procedure BeginInvert;
  procedure EndInvert;
  procedure BeginPaint;
  procedure EndPaint;
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
  property EffectiveColors: Il3EffectiveColors
   read Get_EffectiveColors;
  property PageSetup: Il3PageSetup
   read pm_GetPageSetup;
  property Painter: Il3HAFPainter
   write pm_SetPainter;
  property Canvas: TCanvas
   read pm_GetCanvas;
  property AbortChecker: Il3AbortChecker
   read Get_AbortChecker
   write Set_AbortChecker;
  property InitialDCOffset: Tl3Point
   read Get_InitialDCOffset;
  property InitialDCOffsetStored: Tl3Point
   read Get_InitialDCOffsetStored;
  property ClipRegion: Il3Region
   write Set_ClipRegion;
  property Invert: Boolean
   read pm_GetInvert;
 end;//Il3Canvas

 Il3HAFPainter = interface(Il3Base)
  ['{5237593E-C8A3-4298-A62C-7AC17464D22C}']
  function Get_MacroReplacer: Il3HAFMacroReplacer;
  function DocumentName: Il3CString;
  function NeedPagesCount: Boolean;
  procedure SetPagesCount(aValue: Integer);
  procedure StartPage(const CN: Il3Canvas;
   aTop: Boolean);
  property MacroReplacer: Il3HAFMacroReplacer
   read Get_MacroReplacer;
 end;//Il3HAFPainter

 Tl3FrameAnalizeType = (
  laAddOnly
  , laDoNothing
  , laDelayAlignLowLine
  , laCheckOnly
 );//Tl3FrameAnalizeType

 (*
 Ml3FrameLines = interface
  {* Интерфейс выравнивателя линий для объектов с рамками. Линии располагаются в двух массивах (вертикальных и горизонтальных линий) }
  function Get_FinishedFO(aFrameObjID: Integer): Boolean;
  procedure Set_FinishedFO(aFrameObjID: Integer;
   aValue: Boolean);
  procedure StartFrameObject(anBehaviour: Tl3FrameObjectBehaviour;
   aFrameObjID: Integer;
   const aColorArray: Tl3LinesColorArray);
   {* Скобки для отрисовки "сложных" объектов с рамками - таблиц. }
  procedure FinishFrameObject(anObjectID: Integer;
   aAlignValue: Integer);
   {* Скобки для отрисовки "сложных" объектов с рамками - таблиц. }
  procedure AddFrame(const aCanvas: Il3Canvas;
   anObjectID: Integer;
   const aFrame: Tl3Frame;
   anAnalizeType: Tl3FrameAnalizeType);
   {* Учесть рамку (продлить одну или несколько линий или создать новую). }
  procedure AlignBoundary(anObjectID: Integer;
   const aFrame: Tl3Frame;
   anIsSingle: Boolean);
   {* Применить выравнивающие ограничения. }
  procedure DrawAllLines(const aCanvas: Il3Canvas;
   anObjectID: Integer);
   {* Нарисовать выровненные рамки. anObjectID = -1 выводить все линии, 
          если anObjectID > -1, то выводим линии только для одного объекта. 
          Пока в качестве anObjectID передается PID параграфа (таблицы и т.п.) }
  procedure DrawFrame(const aCanvas: Il3Canvas;
   const aFrame: Tl3Frame;
   const aText: Il3FrameTextPainter);
   {* Отрисовывает рамку. }
  function GetLineWidth(aFrameObjID: Integer): Integer;
   {* Возвращает ширину линии для указанного объекта. }
  function ReadAlignData(anObjectID: Integer): Il3IntegerList;
   {* Прочитать массив данных для сохранения }
  procedure WriteAlignData(anObjectID: Integer;
   const aData: Il3IntegerList);
   {* Записать данные о выравнивании }
  {$If Defined(nsTest)}
  procedure SetNeedLogging(anObjectID: Integer;
   aNeedLog: Boolean);
   {* Метод для тестов. Выставляет флаг объекту о необходимости записи в лог. }
  {$IfEnd} // Defined(nsTest)
  {$If Defined(nsTest)}
  procedure ClearFrameObject(aFrameObjID: Integer);
  {$IfEnd} // Defined(nsTest)
  property FinishedFO[aFrameObjID: Integer]: Boolean
   read Get_FinishedFO
   write Set_FinishedFO;
   {* Флаг окончания отрисовки объекта. }
 end;//Ml3FrameLines
 *)

 Tl3Range = record
  rStart: Integer;
  rLength: Integer;
 end;//Tl3Range

 Il3RangeTool = interface(Il3Base)
  ['{6D668689-FA10-4F02-AAC3-F7F6067D951B}']
  function pm_GetRangeCount: Integer;
  function Get_Ranges(Index: Integer): Tl3Range;
  property RangeCount: Integer
   read pm_GetRangeCount;
  property Ranges[Index: Integer]: Tl3Range
   read Get_Ranges;
 end;//Il3RangeTool

 Il3FrameLines = interface(Il3Base)
  {* Интерфейс выравнивателя линий для объектов с рамками. Линии располагаются в двух массивах (вертикальных и горизонтальных линий) }
  ['{7A267AFC-D1FE-405D-8753-51C286B632EB}']
  function Get_FinishedFO(aFrameObjID: Integer): Boolean;
  procedure Set_FinishedFO(aFrameObjID: Integer;
   aValue: Boolean);
  procedure StartFrameObject(anBehaviour: Tl3FrameObjectBehaviour;
   aFrameObjID: Integer;
   const aColorArray: Tl3LinesColorArray);
   {* Скобки для отрисовки "сложных" объектов с рамками - таблиц. }
  procedure FinishFrameObject(anObjectID: Integer;
   aAlignValue: Integer);
   {* Скобки для отрисовки "сложных" объектов с рамками - таблиц. }
  procedure AddFrame(const aCanvas: Il3Canvas;
   anObjectID: Integer;
   const aFrame: Tl3Frame;
   anAnalizeType: Tl3FrameAnalizeType);
   {* Учесть рамку (продлить одну или несколько линий или создать новую). }
  procedure AlignBoundary(anObjectID: Integer;
   const aFrame: Tl3Frame;
   anIsSingle: Boolean);
   {* Применить выравнивающие ограничения. }
  procedure DrawAllLines(const aCanvas: Il3Canvas;
   anObjectID: Integer);
   {* Нарисовать выровненные рамки. anObjectID = -1 выводить все линии, 
          если anObjectID > -1, то выводим линии только для одного объекта. 
          Пока в качестве anObjectID передается PID параграфа (таблицы и т.п.) }
  procedure DrawFrame(const aCanvas: Il3Canvas;
   const aFrame: Tl3Frame;
   const aText: Il3FrameTextPainter);
   {* Отрисовывает рамку. }
  function GetLineWidth(aFrameObjID: Integer): Integer;
   {* Возвращает ширину линии для указанного объекта. }
  function ReadAlignData(anObjectID: Integer): Il3IntegerList;
   {* Прочитать массив данных для сохранения }
  procedure WriteAlignData(anObjectID: Integer;
   const aData: Il3IntegerList);
   {* Записать данные о выравнивании }
  {$If Defined(nsTest)}
  procedure SetNeedLogging(anObjectID: Integer;
   aNeedLog: Boolean);
   {* Метод для тестов. Выставляет флаг объекту о необходимости записи в лог. }
  {$IfEnd} // Defined(nsTest)
  {$If Defined(nsTest)}
  procedure ClearFrameObject(aFrameObjID: Integer);
  {$IfEnd} // Defined(nsTest)
  property FinishedFO[aFrameObjID: Integer]: Boolean
   read Get_FinishedFO
   write Set_FinishedFO;
   {* Флаг окончания отрисовки объекта. }
 end;//Il3FrameLines

 Il3ImageList = interface(Il3Base)
  {* Список картинок. }
  ['{2E49878A-3EF5-42BF-BE6C-C5F8FB56F554}']
  function pm_GetWidth: Integer;
  function pm_GetHeight: Integer;
  function pm_GetCount: Integer;
  function pm_GetHandle: THandle;
  function pm_GetBigSize: Boolean;
  procedure pm_SetBigSize(aValue: Boolean);
  procedure Draw(const aCanvas: Il3Canvas;
   const aRect: Tl3SRect;
   aFillColor: Tl3Color;
   Index: Integer;
   Enabled: Boolean = True); overload;
  procedure Draw(const aCanvas: Il3Canvas;
   X: Integer;
   Y: Integer;
   Index: Integer;
   Enabled: Boolean = True); overload;
  procedure Draw(const aCanvas: Il3Canvas;
   X: Integer;
   Y: Integer;
   Index: Integer;
   ADrawingStyle: Tl3DrawingStyle;
   AImageType: Tl3ImageType;
   Enabled: Boolean = True); overload;
  function Hack: pointer;
  property Width: Integer
   read pm_GetWidth;
  property Height: Integer
   read pm_GetHeight;
  property Count: Integer
   read pm_GetCount;
  property Handle: THandle
   read pm_GetHandle;
  property BigSize: Boolean
   read pm_GetBigSize
   write pm_SetBigSize;
 end;//Il3ImageList

 Il3Bitmap = interface(Il3Base)
  {* Картинка. }
  ['{35C6D55E-4EC5-41B3-9336-6BE9C95F4790}']
  function pm_GetWidth: Integer;
  function pm_GetHeight: Integer;
  function pm_GetInchWidth: Integer;
  function pm_GetInchHeight: Integer;
  procedure StretchDraw(const R: Tl3Rect;
   const aCanvas: Il3Canvas);
  procedure SaveToClipboardFormat(var AFormat: Word;
   var AData: THandle;
   var APalette: HPALETTE);
  procedure AssignTo(P: TObject);
  procedure Assign(P: TPersistent);
  function IsMF: Boolean;
  property Width: Integer
   read pm_GetWidth;
  property Height: Integer
   read pm_GetHeight;
  property InchWidth: Integer
   read pm_GetInchWidth;
  property InchHeight: Integer
   read pm_GetInchHeight;
 end;//Il3Bitmap

 Hl3Canvas = object
  {* Обёртка для Il3Canvas }
  private
   f_Il3Canvas: Il3Canvas;
    {* Ссылка на интерфейс Il3Canvas }
  private
   procedure Fake; virtual;
    {* это нужно чтобы правильно генерировались вызовы методов доступа к свойствам }
  protected
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

 Il3DragImageSource = interface(Il3Base)
  {* Источник картинки, представляющей данные. }
  ['{9EFC3540-323C-4C4B-9DBA-DC76C14DF440}']
  function Image: Il3Bitmap;
 end;//Il3DragImageSource

 Il3CanvasConstants = interface(Il3Canvas)
  {* Хак для упорядочивания элементов при генерации }
  ['{8BAB9888-3F5B-4563-A848-997627BF6757}']
 end;//Il3CanvasConstants

 Il3CommandProcessor = interface(Il3Base)
  {* Процессор команд. }
  ['{E5E0F6F4-2947-40E5-9911-9F6266EB3906}']
  function TranslateUsing(const Tables: array of AnsiString;
   var Msg: TMessage;
   aTime: Cardinal;
   const aTarget: Il3CommandTarget = nil): Word;
   {* translate a message into a command using the given tables. }
  procedure SubscribeGlobalKeyDataListener(const aListener: Il3KeyDataListener);
  procedure UnsubscribeGlobalKeyDataListener(const aListener: Il3KeyDataListener);
 end;//Il3CommandProcessor

 TevDrawSubEvent = procedure(aSubTarget: TObject;
  const Canvas: Il3Canvas;
  const R: Tl3Rect;
  SubType: Tl3Handle;
  aSub: TObject) of object;

 Il3SmartCanvas = interface(Il3Base)
  {* Канва для рисования примитивов контролов. }
  ['{AF479CB2-7EAE-49C8-BCFE-E05A2805CE38}']
  procedure DrawEdit(const R: Tl3SRect;
   aEnabled: Boolean;
   aFocused: Boolean;
   aReadOnly: Boolean;
   anIs3D: Boolean;
   aPartDraw: Boolean;
   var aBorderWidth: Integer);
  procedure DrawCheckOrRadio(aDrawCheck: Boolean;
   const R: Tl3SRect;
   aState: Tl3CheckBoxState;
   aEnabled: Boolean;
   aFlat: Boolean);
  procedure DrawComboBox(const R: Tl3SRect;
   aBtnWidth: Integer;
   anEnabled: Boolean;
   aFocused: Boolean;
   aReadOnly: Boolean;
   anIs3D: Boolean;
   aPartDraw: Boolean;
   aDown: Boolean);
  procedure DrawSpinEditBox(const R: Tl3SRect;
   aBtnWidth: Integer;
   aEnabled: Boolean;
   aFocused: Boolean;
   aReadOnly: Boolean;
   aPartDraw: Boolean;
   anIs3D: Boolean);
  procedure DrawButton(const aCaption: Tl3PCharLen;
   const R: Tl3SRect;
   aEnabled: Boolean;
   aFlat: Boolean;
   aTransparent: Boolean;
   aMouseInControl: Boolean;
   aState: Tl3ButtonState;
   aColor: Tl3Color;
   const aImgList: Il3ImageList;
   aIndex: Integer);
  procedure DrawHelpControl(const aRect: Tl3SRect;
   aColor: Tl3Color;
   const aImgList: Il3ImageList;
   aIndex: Integer);
  procedure DrawPictureButton(const aRect: Tl3SRect;
   aMouseInControl: Boolean;
   anEnabled: Boolean;
   aState: Tl3ButtonState;
   aColor: Tl3Color;
   const aImgList: Il3ImageList;
   aIndex: Integer);
  procedure DrawSpinButtons(const R: Tl3SRect;
   aEnabled: Boolean;
   aFlat: Boolean);
  procedure DrawElipsisEdit(const R: Tl3SRect;
   aBtnWidth: Integer;
   aEnabled: Boolean;
   aFocused: Boolean;
   aReadOnly: Boolean;
   anIs3D: Boolean;
   aPartDraw: Boolean;
   const aImgList: Il3ImageList;
   aImageIndex: Integer);
  procedure DrawCollapsedPanel(const aCaption: Tl3PCharLen;
   var R: Tl3SRect;
   aEnabled: Boolean;
   aCollapsed: Boolean;
   aUpper: Boolean;
   aDown: Boolean;
   aBtnVisible: Boolean;
   aColor: Tl3Color;
   anAlignment: Tl3Alignment;
   const aImgList: Il3ImageList;
   aNeedFrame: Boolean);
 end;//Il3SmartCanvas

 Il3NodePainter = interface(Il3Base)
  {* Интерфейс для отрисовки ноды. }
  ['{26FC09D4-160F-45A0-BBB2-908CC44A010B}']
  procedure PaintNode(const aCanvas: Il3Canvas;
   const aRect: Tl3Rect;
   aSelStart: Integer;
   aSelEnd: Integer;
   DoInverse: Boolean = False);
   {* Рисует ноду }
  function CalcHeight(const aCanvas: Il3InfoCanvas;
   aWidth: Integer): Integer;
   {* Считает высоту по ширине. }
  function HintSupported: Boolean;
   {* Надо выводить хинт }
  function GetItemTextIndent(const aCanvas: Il3InfoCanvas;
   aTextHeight: Integer): Integer;
 end;//Il3NodePainter

const
 l3PageOrientationInvert: Tl3PageOrientationArray = (l3_poLandscape, l3_poPortrait);
  {* Константа для инверсии ориентации страницы. }

implementation

uses
 l3ImplUses
;

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

procedure Hl3Canvas.Fake;
 {* это нужно чтобы правильно генерировались вызовы методов доступа к свойствам }
begin
 Assert(false);
end;//Hl3Canvas.Fake

constructor Hl3Canvas.Init(const aIl3Canvas: Il3Canvas);
begin
 f_Il3Canvas := aIl3Canvas;
end;//Hl3Canvas.Init

end.
