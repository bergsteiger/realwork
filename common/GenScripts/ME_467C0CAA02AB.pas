unit l3InternalInterfaces;

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
 Il3ObjectWrap = interface
  {* Обертка вокруг объекта. Шаманство. Надо избавляться. }
  function GetObject: TObject;
   {* получить объект из обертки. }
 end;//Il3ObjectWrap
 
 Il3CommandTarget = interface
  {* Устройство для выполнения команд пользовательского ввода. }
  function ProcessCommand(Cmd: Tl3OperationCode;
   aForce: Boolean;
   aCount: Integer): Boolean;
 end;//Il3CommandTarget
 
 Il3Region = interface
  {* Регион. }
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
 end;//Il3Region
 
 Il3Base = l3Interfaces.Il3Base;
 
 Tl3TextFormatFlag = (
  {* Выравнивание текста. }
  l3_tffLeft
  , l3_tffCenter
  , l3_tffRight
 );//Tl3TextFormatFlag
 
 Il3EffectiveColors = interface
  procedure CheckColors;
 end;//Il3EffectiveColors
 
 Il3HAFMacroReplacer = interface
  function Replace(const aText: Il3CString): Il3CString;
  function UnfoldOne(const aMacroName: Il3CString): Il3CString;
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
 end;//Ml3PageInfo
 *)
 
 (*
 Ml3PageNumberInfo = interface
  {* Информация о номерах страницы }
 end;//Ml3PageNumberInfo
 *)
 
 Tl3MouseResult = (
  {* результат обработки события мыши. }
  l3_mrNotHandled
  , l3_mrHandled
  , l3_mrHandledAndMoveLoopNeed
 );//Tl3MouseResult
 
 Il3MouseHandler = interface
  {* Интерфейс для части объекта, обрабатывающей действия мышью. }
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
 
 Il3KeyDataListener = interface
  function ProcessKeyData(aKey: Byte;
   aShiftFlags: Byte): Boolean;
 end;//Il3KeyDataListener
 
 Il3CommandPublisherInfo = interface
  function IsCommandPublished(Cmd: Tl3OperationCode): Boolean;
 end;//Il3CommandPublisherInfo
 
 Il3Flush = interface
  function Flush: Boolean;
 end;//Il3Flush
 
 (*
 Ml3WindowOrg = interface
 end;//Ml3WindowOrg
 *)
 
 (*
 Ml3CanvasState = interface
  function PushClipRect: Tl3Rect;
  procedure PopClipRect;
 end;//Ml3CanvasState
 *)
 
 Il3ActionControl = interface
 end;//Il3ActionControl
 
 Il3Control = interface
 end;//Il3Control
 
 Il3StringList = interface(Il3List)
 end;//Il3StringList
 
 (*
 Ml3TextProperties = interface
  procedure PushLineSpacing;
  procedure PopLineSpacing;
 end;//Ml3TextProperties
 *)
 
 Tl3PageOrientationArray = array [Tl3PageOrientation] of Tl3PageOrientation;
 
 Il3HandledStringList = interface(Il3StringList)
 end;//Il3HandledStringList
 
 Il3CharSkipper = interface
  procedure Init(aString: TObject);
  function GetChar: AnsiChar;
  function Index: Integer;
 end;//Il3CharSkipper
 
 Il3StringFormatter = interface
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
 end;//Il3FontInfo2
 
 Il3ViewStringList = interface
 end;//Il3ViewStringList
 
 Il3StorageSource = interface
 end;//Il3StorageSource
 
 Il3ActionProcessor = interface
  {* Объект обработчик операций. }
  function Process(Sender: TObject;
   Target: TObject;
   Action: Integer;
   Down: Boolean): Boolean;
   {* функция обработки операции. }
 end;//Il3ActionProcessor
 
 Il3Renderer = interface
  {* Объект, рисующий картинку }
  procedure Render(aCanvas: TCanvas;
   const aColors: Il3EffectiveColors);
   {* Отрисовать картинку }
  function CalcExtent(const aFont: Il3Font): Tl3_SPoint;
  procedure SetForWMF(aValue: Boolean);
 end;//Il3Renderer
 
 (*
 Ml3CanvasInvert = interface
  procedure BeginInvert;
  procedure EndInvert;
 end;//Ml3CanvasInvert
 *)
 
 Tl3FrameObjectBehaviour = (
  l3_fobNone
  , l3_fobPrinting
  , l3_fobIgnore
 );//Tl3FrameObjectBehaviour
 
 Il3AbortChecker = interface
  function IsAborted: Boolean;
 end;//Il3AbortChecker
 
 TspBlockType = (
  sp_btNone
  , sp_btText
  , sp_btBlock
 );//TspBlockType
 
 Il3FrameLines = interface;
 
 Il3InfoCanvas = interface
  {* Информационная канва - только для получения метрик }
  function pxAverageCharWidth: Integer;
   {* средняя ширина символов контекста в пикселях. }
  function AverageCharWidth: Integer;
   {* средняя ширина символов контекста в дюймах. }
  function TextExtent(const S: Tl3WString;
   aNoTabs: Boolean): Tl3Point;
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
   NeedZoom: Boolean): Tl3SPoint;
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
   aTabOffset: Integer); overload;
  procedure StartTabs(out theTabInfo: Il3TabInfo;
   const aTabInfo: Il3TabInfo); overload;
  procedure FinishTabs(var aTabInfo: Il3TabInfo);
  function TabInfo: Il3TabInfo;
  function EQ(const aCanvas: Il3InfoCanvas): Boolean;
  function NearestColor(C: Tl3Color): Tl3Color;
  function DrawText(const aSt: Tl3WString;
   var R: TRect;
   aFormat: Cardinal;
   AFl: TObject): Il3MultiLines;
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
 end;//Il3InfoCanvas
 
 Il3HAFPainter = interface;
 
 Il3Canvas = interface(Il3InfoCanvas)
  {* Канва для рисования }
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
   FC: Tl3Color;
   BC: Tl3Color): Tl3Point;
  procedure SetCaret(const Origin: Tl3Point;
   const Extent: Tl3Point;
   Hidden: Boolean);
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
   F: Tl3TextFormatFlag;
   Dx: PInteger); overload;
  procedure ExtTextOut(const P: Tl3SPoint;
   const R: Tl3SRect;
   const S: Tl3WString;
   F: Tl3TextFormatFlag;
   Dx: PInteger); overload;
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
  function NewPage(ByWidth: Boolean): Boolean;
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
 end;//Il3Canvas
 
 Il3CStringList = interface(Il3List)
 end;//Il3CStringList
 
 Tl3AskClearClipboardProc = procedure(var aResult: Integer) of object;
 
 Il3HAFPainter = interface
  function DocumentName: Il3CString;
  function NeedPagesCount: Boolean;
  procedure SetPagesCount(aValue: Integer);
  procedure StartPage(const CN: Il3Canvas;
   aTop: Boolean);
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
  procedure SetNeedLogging(anObjectID: Integer;
   aNeedLog: Boolean);
   {* Метод для тестов. Выставляет флаг объекту о необходимости записи в лог. }
  procedure ClearFrameObject(aFrameObjID: Integer);
 end;//Ml3FrameLines
 *)
 
 Il3FrameLines = interface
  {* Интерфейс выравнивателя линий для объектов с рамками. Линии располагаются в двух массивах (вертикальных и горизонтальных линий) }
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
  procedure SetNeedLogging(anObjectID: Integer;
   aNeedLog: Boolean);
   {* Метод для тестов. Выставляет флаг объекту о необходимости записи в лог. }
  procedure ClearFrameObject(aFrameObjID: Integer);
 end;//Il3FrameLines
 
 Il3ImageList = interface
  {* Список картинок. }
  procedure Draw(const aCanvas: Il3Canvas;
   const aRect: Tl3SRect;
   aFillColor: Tl3Color;
   Index: Integer;
   Enabled: Boolean); overload;
  procedure Draw(const aCanvas: Il3Canvas;
   X: Integer;
   Y: Integer;
   Index: Integer;
   Enabled: Boolean); overload;
  procedure Draw(const aCanvas: Il3Canvas;
   X: Integer;
   Y: Integer;
   Index: Integer;
   ADrawingStyle: Tl3DrawingStyle;
   AImageType: Tl3ImageType;
   Enabled: Boolean); overload;
  function Hack: pointer;
 end;//Il3ImageList
 
 Tl3Range = record
 end;//Tl3Range
 
 Il3RangeTool = interface
 end;//Il3RangeTool
 
 Il3Bitmap = interface
  {* Картинка. }
  procedure StretchDraw(const R: Tl3Rect;
   const aCanvas: Il3Canvas);
  procedure SaveToClipboardFormat(var AFormat: Word;
   var AData: THandle;
   var APalette: HPALETTE);
  procedure AssignTo(P: TObject);
  procedure Assign(P: TPersistent);
  function IsMF: Boolean;
 end;//Il3Bitmap
 
 Il3SmartCanvas = interface
  {* Канва для рисования примитивов контролов. }
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
 
 Il3NodePainter = interface
  {* Интерфейс для отрисовки ноды. }
  procedure PaintNode(const aCanvas: Il3Canvas;
   const aRect: Tl3Rect;
   aSelStart: Integer;
   aSelEnd: Integer;
   DoInverse: Boolean);
   {* Рисует ноду }
  function CalcHeight(const aCanvas: Il3InfoCanvas;
   aWidth: Integer): Integer;
   {* Считает высоту по ширине. }
  function HintSupported: Boolean;
   {* Надо выводить хинт }
  function GetItemTextIndent(const aCanvas: Il3InfoCanvas;
   aTextHeight: Integer): Integer;
 end;//Il3NodePainter
 
 Hl3Canvas = object
  {* Обёртка для Il3Canvas }
 end;//Hl3Canvas
 
 Il3DragImageSource = interface
  {* Источник картинки, представляющей данные. }
  function Image: Il3Bitmap;
 end;//Il3DragImageSource
 
 Il3CanvasConstants = interface(Il3Canvas)
  {* Хак для упорядочивания элементов при генерации }
 end;//Il3CanvasConstants
 
 Il3CommandProcessor = interface
  {* Процессор команд. }
  function TranslateUsing(const Tables: TOpenStringArray;
   var Msg: TMessage;
   aTime: Cardinal;
   const aTarget: Il3CommandTarget): Word;
   {* translate a message into a command using the given tables. }
  procedure SubscribeGlobalKeyDataListener(const aListener: Il3KeyDataListener);
  procedure UnsubscribeGlobalKeyDataListener(const aListener: Il3KeyDataListener);
 end;//Il3CommandProcessor
 
 PIl3KeyDataListener = ^Il3KeyDataListener;
 
 TevDrawSubEvent = procedure(aSubTarget: TObject;
  const Canvas: Il3Canvas;
  const R: Tl3Rect;
  SubType: Tl3Handle;
  aSub: TObject) of object;
 
implementation

uses
 l3ImplUses
;

end.
