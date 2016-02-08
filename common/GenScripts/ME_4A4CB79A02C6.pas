unit l3CanvasPrim;

// Модуль: "w:\common\components\rtl\Garant\L3\l3CanvasPrim.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Interfaces
 , l3InternalInterfaces
 , l3PrinterInterfaces
 , l3Units
 , l3RectList
 , Windows
 , l3LongintList
 , Graphics
 , Classes
 , l3Region
 , l3Memory
 , l3Base
 , l3Defaults
 , l3Core
 , l3Types
 , l3CacheableBase
;

type
 Tl3OpenPageResult = (
  l3_oprNo
  , l3_oprYes
  , l3_oprEndDoc
 );//Tl3OpenPageResult

 Tl3DrawFlag = (
  ev_dfDrawCursor
  , ev_dfDrawRegion
  , ev_dfDrawSpecial
  , ev_dfPrinting
  , ev_dfSelfStarted
  , ev_dfPrinted
 );//Tl3DrawFlag

 TevDrawFlags = set of Tl3DrawFlag;

 TevDCFlag = (
  {* флаги способа получения Handle канвы }
  ev_dcfCanvas
  , ev_dcfGot
  , ev_dcfCreated
  , ev_dcfLinked
 );//TevDCFlag

 Tl3DeviceCaps = record
  {* Информация об устройстве вывода }
  rLOGPIXELSX: Integer;
  rLOGPIXELSY: Integer;
  rHORZRES: Integer;
  rVERTRES: Integer;
  rPHYSICALWIDTH: Integer;
  rPHYSICALHEIGHT: Integer;
  rPHYSICALOFFSETX: Integer;
  rPHYSICALOFFSETY: Integer;
  rIsAssigned: Boolean;
 end;//Tl3DeviceCaps

 Tl3TabInfo = class(Tl3CacheableBase, Il3TabInfo)
  private
   f_TabOffset: Integer;
   f_TabStops: Il3TabStops;
  protected
   function TabOffset: Integer;
   function TabStops: Il3TabStops;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aTabOffset: Integer;
    const aTabStops: Il3TabStops); reintroduce;
   class function Make(aTabOffset: Integer;
    const aTabStops: Il3TabStops): Il3TabInfo; reintroduce;
 end;//Tl3TabInfo

 Tl3MemoryPool_Bool = array [Boolean] of Tl3MemoryPool;

 Tl3CanvasPrim = class(Tl3ProtoObject, Il3Font, Il3InfoCanvas, Il3Canvas, Il3PageSetup, Il3EffectiveColors)
  private
   f_Margins: Tl3_Rect;
   f_ClipRectList: Tl3RectList;
    {* Стек прямоугольников отсечения }
   f_LineSpacingStack: Tl3LongintList;
   f_Drawing: Integer;
   f_Invert: Integer;
   f_Fore: Integer;
   f_DarkFore: Integer;
   f_CheckingDrawing: Integer;
   f_OldBrushChange: TNotifyEvent;
   f_OldFontChange: TNotifyEvent;
   f_AlienCanvas: Boolean;
   f_FontIndex: Tl3FontIndex;
   f_ClipRect: Tl3Rect;
   f_ClipSRect: Tl3SRect;
   f_ConvertBuf: PAnsiChar;
   f_BCs: Tl3LongintList;
   f_FCs: Tl3LongintList;
   f_TextMetrics: TTextMetric;
   f_WindowOrgInited: Boolean;
   f_WindowOrg: Tl3Point;
   f_RegionBottomRight: Tl3SPoint;
   f_Kerning: Tl3MemoryPool;
   f_FrameLines: Il3FrameLines;
   f_FontIndexSet: Tl3FontIndexes;
   f_Rgns: Tl3LongintList;
   f_WOs: Tl3LongintList;
   f_ConvertTable: Tl3MemoryPool_Bool;
   f_OutString: Tl3String;
   f_Flags: TevDrawFlags;
    {* Поле для свойства Flags }
   f_OnDrawSub: TevDrawSubEvent;
    {* Поле для свойства OnDrawSub }
   f_CanDrawSubs: Boolean;
    {* Поле для свойства CanDrawSubs }
   f_PixelsPerInchX: Integer;
    {* Поле для свойства PixelsPerInchX }
   f_PixelsPerInchY: Integer;
    {* Поле для свойства PixelsPerInchY }
   f_OverallPageNumber: Integer;
    {* Поле для свойства OverallPageNumber }
   f_BackColor: TColor;
    {* Поле для свойства BackColor }
   f_NotFocused: Boolean;
    {* Поле для свойства NotFocused }
   f_DCFlag: TevDCFlag;
    {* Поле для свойства DCFlag }
   f_Canvas: TCanvas;
    {* Поле для свойства Canvas }
   f_Owner: TObject;
    {* Поле для свойства Owner }
   f_Zoom: Integer;
    {* Поле для свойства Zoom }
   f_OnDrawSpecialChange: TNotifyEvent;
    {* Поле для свойства OnDrawSpecialChange }
   f_PageOrientation: Tl3PageOrientation;
    {* Поле для свойства PageOrientation }
   f_SectionExtent: Tl3Point;
    {* Поле для свойства SectionExtent }
   f_Painter: Il3HAFPainter;
    {* Поле для свойства Painter }
   f_AbortChecker: Il3AbortChecker;
    {* Поле для свойства AbortChecker }
   f_etoFlags: Word;
    {* Поле для свойства etoFlags }
  protected
   f_Printer: Il3Printer;
   f_DeviceCaps: Tl3DeviceCaps;
   f_PageWidthNumber: Integer;
   f_InitialDCOffset: Tl3Point;
   f_ClipRectInited: Boolean;
   f_LineSpacing: Integer;
   f_InitialDCOffsetStored: Tl3Point;
   f_CheckingColors: Integer;
   f_TextColor: TColor;
   f_DC: hDC;
   f_TextMetricsValid: Boolean;
   f_SuffixedFont: Boolean;
   f_AverageCharHeight: Integer;
   f_AverageCharWidth: Integer;
   f_pxAverageCharWidth: Integer;
   f_Font: Il3Font;
   f_TabOffset: Integer;
   f_Filled: Tl3Region;
   f_TabStops: Il3TabStops;
   f_PasswordChar: AnsiChar;
   f_Tabs: Integer;
   f_SaveOrientation: Tl3PageOrientation;
   f_VirtualCanvas: Il3Canvas;
   f_PageNumber: Integer;
  protected
   procedure pm_SetPrinting(aValue: Boolean);
   function pm_GetDrawing: Boolean;
   function pm_GetVCLFont: TFont;
   procedure pm_SetVCLFont(aValue: TFont);
   function pm_GetTextColor: TColor;
   procedure pm_SetTextColor(aValue: TColor);
   function pm_GetBrush: TBrush;
   procedure pm_SetBrush(aValue: TBrush);
   function pm_GetDCFlag: TevDCFlag;
   procedure pm_SetCanvas(aValue: TCanvas);
   function pm_GetPen: TPen;
   procedure pm_SetPen(aValue: TPen);
   procedure pm_SetDrawSpecial(aValue: Boolean);
   function pm_GetetoFlags: Word;
   function CalcPrintableArea: Tl3_Rect;
   procedure UpdatePixelsPerInch;
   function GetIsPagesCounter: Boolean; virtual;
   function GetGlobalClipRectWithZoom: Tl3Rect; virtual;
   function BeginDrawing: Integer;
   function EndDrawing: Integer;
   function DrawingIsValid: Boolean;
   function GetIsVirtual: Boolean; virtual;
   function CheckDrawing: Boolean;
   procedure BrushChanged(Sender: TObject);
   procedure FontChanged(Sender: TObject);
   procedure FreeDC;
   procedure FreeAlienDC(aDC: hDC); virtual;
   procedure FireDCSetToNull; virtual;
   function IsPreview: Boolean; virtual;
   procedure Invalidate; virtual;
   procedure DoFillEmptyRect(const R: Tl3Rect); overload; virtual;
   procedure DoFillEmptyRect(const R: Tl3SRect); overload; virtual;
   function GetGlobalClipRect: Tl3Rect; virtual;
   function GetTabWidth: Integer;
   procedure RestoreTabInfo(const aTabInfo: Il3TabInfo);
   function TabOffset: Integer;
   procedure RecordRegionBottomPrim(const aBottom: Tl3SPoint);
   procedure DoAddRect(const aRect: Tl3SRect); virtual;
   function xCheckFilled: Tl3Region;
   procedure AddRgn(const aRgn: Il3Region); virtual;
   function KerningTextExtent(const S: Tl3PCharLenPrim): Tl3Point; virtual;
   procedure KerningTextOut(const P: Tl3Point;
    const R: Tl3Rect;
    const S: Tl3PCharLenPrim); overload;
   procedure KerningTextOut(const P: Tl3SPoint;
    const R: Tl3SRect;
    const S: Tl3PCharLenPrim); overload;
   function CheckKerning(Size: Integer): Pointer;
   function GetCaret: Il3Caret; virtual;
   procedure CheckOrientation;
   function NeedOpenRealPage(aDoc: Boolean;
    ByWidth: Boolean = False): Tl3OpenPageResult; virtual;
   procedure StartPrinterPage(aDoc: Boolean); virtual;
   procedure StartPage; virtual;
   procedure DoStartObject(anObjectID: Integer); virtual;
   procedure DoSetPageTop; virtual;
   procedure DoEndPaint; virtual;
   procedure DoDrawLineTo(aX: Integer;
    aY: Integer);
   function CreateRectRgn(const aRect: Tl3SRect): Tl3Rgn;
   function DoGetClientRect: Tl3Rect; virtual;
   function CheckConvertTable(OEM: Boolean): PAnsiChar;
   function DoGetPageSetupWidth: Tl3Inch; virtual;
   function DoGetPageSetupHeight: Tl3Inch; virtual;
   function DoGetDrawEnabled: Boolean; virtual;
   function GetPrinting: Boolean; virtual;
   function AsIl3Canvas: Il3Canvas;
   procedure AssignDeviceCaps;
    {* Инициализировать информацию об устройстве }
   function DoGetPaperWidth: Tl3Inch; virtual;
   procedure DoFillForeRect(const R: Tl3SRect); virtual;
   function GetAlienDC: hDC; virtual;
   procedure FillRectPrim(const R: TRect); virtual;
   procedure DoStartDrawAAC(aType: TspBlockType); virtual;
   procedure DoEndDrawAAC(const R: Tl3Rect); virtual;
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
   function pm_GetPageNumber: Integer;
   function pm_GetPageWidthNumber: Integer;
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
   procedure CheckColors;
   function Get_FontColor: Tl3Color;
   function pm_GetPrinting: Boolean;
   function CheckConvertString(const aStr: Tl3PCharLen): Tl3PCharLen;
    {* преобразует строку для отображения форматирующей информации в режиме DrawSpecial. }
   function CheckOutString(const aStr: Tl3PCharLen): Tl3PCharLen;
   function pm_GetZoom: Integer;
   procedure pm_SetZoom(aValue: Integer);
   function Get_Width: Tl3Inch;
   function Get_Height: Tl3Inch;
   function pm_GetPaperWidth: Tl3Inch;
   function pm_GetPaperHeight: Tl3Inch;
   function pm_GetMargins: Tl3_Rect;
   procedure pm_SetMargins(const aValue: Tl3_Rect);
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
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure ClearFields; override;
  public
   constructor CreateOwned(anOwner: TObject); reintroduce;
   constructor CreateForPrinting(const aPrinter: Il3Printer); reintroduce;
   procedure SetCanvas(aValue: TCanvas;
    anAlien: Boolean); virtual;
   procedure SetDC(DC: hDC;
    Flag: TevDCFlag);
   procedure AddRect(const aRect: Tl3SRect);
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
  protected
   property Printing: Boolean
    read pm_GetPrinting
    write pm_SetPrinting;
   property Flags: TevDrawFlags
    read f_Flags
    write f_Flags;
   property CanDrawSubs: Boolean
    read pm_GetCanDrawSubs;
   property PageNumber: Integer
    read pm_GetPageNumber;
   property OverallPageNumber: Integer
    read f_OverallPageNumber;
   property GlobalClipRect: Tl3Rect
    read pm_GetGlobalClipRect;
   property ClipRect: Tl3Rect
    read pm_GetClipRect
    write pm_SetClipRect;
   property DC: hDC
    read pm_GetDC
    write pm_SetDC;
   property SWindowOrg: Tl3SPoint
    read pm_GetSWindowOrg
    write pm_SetSWindowOrg;
   property VCLFont: TFont
    read pm_GetVCLFont
    write pm_SetVCLFont;
  public
   property OnDrawSub: TevDrawSubEvent
    read f_OnDrawSub
    write f_OnDrawSub;
   property PixelsPerInchX: Integer
    read pm_GetPixelsPerInchX;
   property PixelsPerInchY: Integer
    read pm_GetPixelsPerInchY;
   property WindowOrg: Tl3Point
    read pm_GetWindowOrg
    write pm_SetWindowOrg;
   property BackColor: TColor
    read pm_GetBackColor
    write pm_SetBackColor;
   property DrawEnabled: Boolean
    read pm_GetDrawEnabled
    write pm_SetDrawEnabled;
   property Drawing: Boolean
    read pm_GetDrawing;
   property Invert: Boolean
    read pm_GetInvert;
   property TextColor: TColor
    read pm_GetTextColor
    write pm_SetTextColor;
   property Brush: TBrush
    read pm_GetBrush
    write pm_SetBrush;
   property NotFocused: Boolean
    read f_NotFocused
    write f_NotFocused;
   property DCFlag: TevDCFlag
    read pm_GetDCFlag
    write f_DCFlag;
   property Canvas: TCanvas
    read pm_GetCanvas
    write pm_SetCanvas;
   property Owner: TObject
    read f_Owner;
   property Zoom: Integer
    read pm_GetZoom
    write pm_SetZoom;
   property Pen: TPen
    read pm_GetPen
    write pm_SetPen;
   property ShowCursor: Boolean
    read pm_GetShowCursor
    write pm_SetShowCursor;
   property Printed: Boolean
    read pm_GetPrinted
    write pm_SetPrinted;
   property OnDrawSpecialChange: TNotifyEvent
    read f_OnDrawSpecialChange
    write f_OnDrawSpecialChange;
   property DrawSpecial: Boolean
    read pm_GetDrawSpecial
    write pm_SetDrawSpecial;
   property PageSetup: Il3PageSetup
    read pm_GetPageSetup;
   property PageOrientation: Tl3PageOrientation
    read pm_GetPageOrientation
    write pm_SetPageOrientation;
   property SectionExtent: Tl3Point
    read pm_GetSectionExtent
    write pm_SetSectionExtent;
   property Painter: Il3HAFPainter
    read f_Painter
    write f_Painter;
   property AbortChecker: Il3AbortChecker
    read Get_AbortChecker
    write Set_AbortChecker;
   property etoFlags: Word
    read pm_GetetoFlags
    write f_etoFlags;
 end;//Tl3CanvasPrim

{$If Defined(nsTest)}
var g_PrintingLineSpacing: Integer = def_PrintingLineSpacing;
{$IfEnd} // Defined(nsTest)

implementation

uses
 l3ImplUses
 , l3MinMax
 , l3Math
 , l3Const
 , SysUtils
 , l3CanvasUtils
 , StrUtils
 , l3Chars
 , l3LogFont
 , l3FontManager
 , l3FontTools
 , l3String
 , l3ScreenIC
 , l3StringEx
 , l3Utils
 , l3InterfacesMisc
 , l3FormattedLines
 , l3LineArray
 , l3VirtualCanvas
 , l3Bitmap
 , l3Canvas
 {$If Defined(l3Requires_m0)}
 , m2XLtLib
 {$IfEnd} // Defined(l3Requires_m0)
 , l3FrameLines
 , l3MemUtils
 , l3Interlocked
;

const
 cMaxTextLength = 3000;

constructor Tl3TabInfo.Create(aTabOffset: Integer;
 const aTabStops: Il3TabStops);
//#UC START# *56AB67BC0111_56AB66AA01C0_var*
//#UC END# *56AB67BC0111_56AB66AA01C0_var*
begin
//#UC START# *56AB67BC0111_56AB66AA01C0_impl*
 inherited Create;
 f_TabOffset := aTabOffset;
 if (aTabStops = nil) then
  f_TabStops := nil
 else
  f_TabStops := aTabStops.Clone;
//#UC END# *56AB67BC0111_56AB66AA01C0_impl*
end;//Tl3TabInfo.Create

class function Tl3TabInfo.Make(aTabOffset: Integer;
 const aTabStops: Il3TabStops): Il3TabInfo;
var
 l_Inst : Tl3TabInfo;
begin
 l_Inst := Create(aTabOffset, aTabStops);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//Tl3TabInfo.Make

function Tl3TabInfo.TabOffset: Integer;
//#UC START# *4728A3180093_56AB66AA01C0_var*
//#UC END# *4728A3180093_56AB66AA01C0_var*
begin
//#UC START# *4728A3180093_56AB66AA01C0_impl*
 Result := f_TabOffset;
//#UC END# *4728A3180093_56AB66AA01C0_impl*
end;//Tl3TabInfo.TabOffset

function Tl3TabInfo.TabStops: Il3TabStops;
//#UC START# *4728A4830294_56AB66AA01C0_var*
//#UC END# *4728A4830294_56AB66AA01C0_var*
begin
//#UC START# *4728A4830294_56AB66AA01C0_impl*
 Result := f_TabStops;
//#UC END# *4728A4830294_56AB66AA01C0_impl*
end;//Tl3TabInfo.TabStops

procedure Tl3TabInfo.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_56AB66AA01C0_var*
//#UC END# *479731C50290_56AB66AA01C0_var*
begin
//#UC START# *479731C50290_56AB66AA01C0_impl*
 f_TabStops := nil;
 inherited;
//#UC END# *479731C50290_56AB66AA01C0_impl*
end;//Tl3TabInfo.Cleanup

procedure Tl3CanvasPrim.pm_SetPrinting(aValue: Boolean);
//#UC START# *4A4CBF0003DF_4A4CB79A02C6set_var*
//#UC END# *4A4CBF0003DF_4A4CB79A02C6set_var*
begin
//#UC START# *4A4CBF0003DF_4A4CB79A02C6set_impl*
 if aValue then
 begin
  Include(f_Flags, ev_dfPrinting);
  Exclude(f_Flags, ev_dfDrawSpecial);
  OnDrawSub := nil;
 end//aValue 
 else
  Exclude(f_Flags, ev_dfPrinting);
//#UC END# *4A4CBF0003DF_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetPrinting

function Tl3CanvasPrim.pm_GetDrawing: Boolean;
//#UC START# *56ACD3C302A5_4A4CB79A02C6get_var*
//#UC END# *56ACD3C302A5_4A4CB79A02C6get_var*
begin
//#UC START# *56ACD3C302A5_4A4CB79A02C6get_impl*
 Result := (f_Drawing > 0);
//#UC END# *56ACD3C302A5_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetDrawing

function Tl3CanvasPrim.pm_GetVCLFont: TFont;
//#UC START# *56AD08DA011D_4A4CB79A02C6get_var*
//#UC END# *56AD08DA011D_4A4CB79A02C6get_var*
begin
//#UC START# *56AD08DA011D_4A4CB79A02C6get_impl*
 Result := Canvas.Font;
//#UC END# *56AD08DA011D_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetVCLFont

procedure Tl3CanvasPrim.pm_SetVCLFont(aValue: TFont);
//#UC START# *56AD08DA011D_4A4CB79A02C6set_var*
//#UC END# *56AD08DA011D_4A4CB79A02C6set_var*
begin
//#UC START# *56AD08DA011D_4A4CB79A02C6set_impl*
 Canvas.Font := aValue;
//#UC END# *56AD08DA011D_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetVCLFont

function Tl3CanvasPrim.pm_GetTextColor: TColor;
//#UC START# *56AD09460121_4A4CB79A02C6get_var*
//#UC END# *56AD09460121_4A4CB79A02C6get_var*
begin
//#UC START# *56AD09460121_4A4CB79A02C6get_impl*
 Result := f_TextColor;
//#UC END# *56AD09460121_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetTextColor

procedure Tl3CanvasPrim.pm_SetTextColor(aValue: TColor);
//#UC START# *56AD09460121_4A4CB79A02C6set_var*
//#UC END# *56AD09460121_4A4CB79A02C6set_var*
begin
//#UC START# *56AD09460121_4A4CB79A02C6set_impl*
 if (f_TextColor = aValue) then
 begin
  if DrawEnabled and Drawing then
   CheckColors;
 end//f_TextColor = Value
 else
 if (aValue <> clDefault) then
 begin
  f_TextColor := aValue;
  if DrawEnabled and Drawing then
   CheckColors;
 end;//f_TextColor <> Value
//#UC END# *56AD09460121_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetTextColor

function Tl3CanvasPrim.pm_GetBrush: TBrush;
//#UC START# *56AD0ACC0034_4A4CB79A02C6get_var*
//#UC END# *56AD0ACC0034_4A4CB79A02C6get_var*
begin
//#UC START# *56AD0ACC0034_4A4CB79A02C6get_impl*
 Result := Canvas.Brush;
//#UC END# *56AD0ACC0034_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetBrush

procedure Tl3CanvasPrim.pm_SetBrush(aValue: TBrush);
//#UC START# *56AD0ACC0034_4A4CB79A02C6set_var*
//#UC END# *56AD0ACC0034_4A4CB79A02C6set_var*
begin
//#UC START# *56AD0ACC0034_4A4CB79A02C6set_impl*
 Canvas.Brush := aValue;
//#UC END# *56AD0ACC0034_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetBrush

function Tl3CanvasPrim.pm_GetDCFlag: TevDCFlag;
//#UC START# *56AF20160331_4A4CB79A02C6get_var*
//#UC END# *56AF20160331_4A4CB79A02C6get_var*
begin
//#UC START# *56AF20160331_4A4CB79A02C6get_impl*
 Result := f_DCFlag;
//#UC END# *56AF20160331_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetDCFlag

procedure Tl3CanvasPrim.pm_SetCanvas(aValue: TCanvas);
//#UC START# *56AF20BB0209_4A4CB79A02C6set_var*
//#UC END# *56AF20BB0209_4A4CB79A02C6set_var*
begin
//#UC START# *56AF20BB0209_4A4CB79A02C6set_impl*
 SetCanvas(aValue, True);
//#UC END# *56AF20BB0209_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetCanvas

function Tl3CanvasPrim.pm_GetPen: TPen;
//#UC START# *56B09CE001DA_4A4CB79A02C6get_var*
//#UC END# *56B09CE001DA_4A4CB79A02C6get_var*
begin
//#UC START# *56B09CE001DA_4A4CB79A02C6get_impl*
 Result := Canvas.Pen;
//#UC END# *56B09CE001DA_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetPen

procedure Tl3CanvasPrim.pm_SetPen(aValue: TPen);
//#UC START# *56B09CE001DA_4A4CB79A02C6set_var*
//#UC END# *56B09CE001DA_4A4CB79A02C6set_var*
begin
//#UC START# *56B09CE001DA_4A4CB79A02C6set_impl*
 Canvas.Pen := aValue;
//#UC END# *56B09CE001DA_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetPen

procedure Tl3CanvasPrim.pm_SetDrawSpecial(aValue: Boolean);
//#UC START# *56B0ADCF0192_4A4CB79A02C6set_var*
var
 l_WindowFlags: Il3CaretOwner;
//#UC END# *56B0ADCF0192_4A4CB79A02C6set_var*
begin
//#UC START# *56B0ADCF0192_4A4CB79A02C6set_impl*
 if (DrawSpecial <> aValue) then
 begin
  if aValue and not Printing then
   Flags := Flags + [ev_dfDrawSpecial]
  else
   Flags := Flags - [ev_dfDrawSpecial];
  if Assigned(f_OnDrawSpecialChange) then
   f_OnDrawSpecialChange(Self);
  if Supports(Owner, Il3CaretOwner, l_WindowFlags) then
  try
   l_WindowFlags.RedrawCaret;
  finally
   l_WindowFlags := nil;
  end;//try..finally
  Invalidate;
 end;//DrawSpecial <> Value
//#UC END# *56B0ADCF0192_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetDrawSpecial

function Tl3CanvasPrim.pm_GetetoFlags: Word;
//#UC START# *56B4CED4000D_4A4CB79A02C6get_var*
//#UC END# *56B4CED4000D_4A4CB79A02C6get_var*
begin
//#UC START# *56B4CED4000D_4A4CB79A02C6get_impl*
 Result := f_etoFlags;
 if Printing then
  Result :=  Result AND not eto_Opaque;
//#UC END# *56B4CED4000D_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetetoFlags

function Tl3CanvasPrim.CalcPrintableArea: Tl3_Rect;
//#UC START# *4A4CBD130121_4A4CB79A02C6_var*
var
 l_Ofs  : Tl3Point;
 l_OfsB : Tl3Point;
//#UC END# *4A4CBD130121_4A4CB79A02C6_var*
begin
//#UC START# *4A4CBD130121_4A4CB79A02C6_impl*
 if Printing then
 begin
  l_Ofs := DP2LP(l3SPoint(DeviceCaps(PHYSICALOFFSETX),
                          DeviceCaps(PHYSICALOFFSETY)));
  l_Ofs.X := Max(l_Ofs.X, f_Margins.Left);
  l_Ofs.Y := Max(l_Ofs.Y, f_Margins.Top);
  l_OfsB := DP2LP(l3SPoint(DeviceCaps(PHYSICALWIDTH) - DeviceCaps(HORZRES),
                                  DeviceCaps(PHYSICALHEIGHT) - DeviceCaps(VERTRES))).Sub(l_Ofs);
  l_OfsB.X := Max(l_OfsB.X, f_Margins.Right);
  Result := l3Rect(l_Ofs, l_OfsB);
 end//Printing
 else
  Result := l3Rect(0, 0, 0, 0);
//#UC END# *4A4CBD130121_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.CalcPrintableArea

procedure Tl3CanvasPrim.UpdatePixelsPerInch;
//#UC START# *4A4CCE400004_4A4CB79A02C6_var*
//#UC END# *4A4CCE400004_4A4CB79A02C6_var*
begin
//#UC START# *4A4CCE400004_4A4CB79A02C6_impl*
 f_PixelsPerInchX := DeviceCaps(LOGPIXELSX);
 f_PixelsPerInchY := DeviceCaps(LOGPIXELSY);
 {-обновляем разрешение}
//#UC END# *4A4CCE400004_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.UpdatePixelsPerInch

function Tl3CanvasPrim.GetIsPagesCounter: Boolean;
//#UC START# *4CB32D4C030E_4A4CB79A02C6_var*
//#UC END# *4CB32D4C030E_4A4CB79A02C6_var*
begin
//#UC START# *4CB32D4C030E_4A4CB79A02C6_impl*
 Result := false;
//#UC END# *4CB32D4C030E_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.GetIsPagesCounter

function Tl3CanvasPrim.GetGlobalClipRectWithZoom: Tl3Rect;
//#UC START# *4E98521202B5_4A4CB79A02C6_var*
//#UC END# *4E98521202B5_4A4CB79A02C6_var*
begin
//#UC START# *4E98521202B5_4A4CB79A02C6_impl*
 Result := GlobalClipRect;
//#UC END# *4E98521202B5_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.GetGlobalClipRectWithZoom

function Tl3CanvasPrim.BeginDrawing: Integer;
//#UC START# *56ACD3DD0360_4A4CB79A02C6_var*
//#UC END# *56ACD3DD0360_4A4CB79A02C6_var*
begin
//#UC START# *56ACD3DD0360_4A4CB79A02C6_impl*
 Inc(f_Drawing);
 Result := f_Drawing;
//#UC END# *56ACD3DD0360_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.BeginDrawing

function Tl3CanvasPrim.EndDrawing: Integer;
//#UC START# *56ACD3F700FB_4A4CB79A02C6_var*
//#UC END# *56ACD3F700FB_4A4CB79A02C6_var*
begin
//#UC START# *56ACD3F700FB_4A4CB79A02C6_impl*
 Dec(f_Drawing);
 Result := f_Drawing;
//#UC END# *56ACD3F700FB_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.EndDrawing

function Tl3CanvasPrim.DrawingIsValid: Boolean;
//#UC START# *56AF1E2902D2_4A4CB79A02C6_var*
//#UC END# *56AF1E2902D2_4A4CB79A02C6_var*
begin
//#UC START# *56AF1E2902D2_4A4CB79A02C6_impl*
 Result := not IsVirtual and DrawEnabled and CheckDrawing;
//#UC END# *56AF1E2902D2_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DrawingIsValid

function Tl3CanvasPrim.GetIsVirtual: Boolean;
//#UC START# *56AF1E650037_4A4CB79A02C6_var*
//#UC END# *56AF1E650037_4A4CB79A02C6_var*
begin
//#UC START# *56AF1E650037_4A4CB79A02C6_impl*
 Result := False;
//#UC END# *56AF1E650037_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.GetIsVirtual

function Tl3CanvasPrim.CheckDrawing: Boolean;
//#UC START# *56AF1E9702A0_4A4CB79A02C6_var*
var
 CN: TCanvas;
 l_OldDC: hDC;
 l_Owner: TObject;
//#UC END# *56AF1E9702A0_4A4CB79A02C6_var*
begin
//#UC START# *56AF1E9702A0_4A4CB79A02C6_impl*
 Inc(f_CheckingDrawing);
 try
  l_OldDC := f_DC;
  Result := Drawing or (f_DCFlag in [ev_dcfLinked, ev_dcfCreated]) or Printing;
  if Result and (f_CheckingDrawing <= 1) then
  begin
   Lock;
   try
    l_Owner := Owner;
    CN := Canvas;
    case f_DCFlag of
     ev_dcfCanvas:
      if (CN Is TMetaFileCanvas) then
      begin
       f_DC := CN.Handle;
      end//CN Is TMetaFileCanvas
      else
      if (f_Printer <> nil) and not f_Printer.Printing then
      begin
       f_DC := f_Printer.DC;
       SelectObject(f_DC, VCLFont.Handle);
       {-обновляем шрифт принудительно}
      end//f_Printer <> nil..
      else
      if (l_Owner Is TMetaFile) and (f_DC = 0) then
      begin
       CN := TMetaFileCanvas.Create(TMetaFile(l_Owner), 0);
       SetCanvas(CN, False);
       f_DC := CN.Handle;
      end//l_Owner Is TMetaFile
      else
       f_DC := CN.Handle;
     ev_dcfGot:
     begin
      if (f_DC = 0) then
       f_DC := GetAlienDC;
      CN.Handle := f_DC;
      f_DC := CN.Handle;
      {-обновляем шрифт, перо, кисть etc}
     end;//ev_dcfGot
     ev_dcfCreated,
     ev_dcfLinked:
     begin
      if (CN <> nil) and (f_DC <> 0) then
       CN.Handle := f_DC;
      if (CN <> nil) then
       f_DC := CN.Handle;
      {-обновляем шрифт, перо, кисть etc}
     end;//ev_dcfCreated..}
    end;//case f_DCFlag
    if (l_OldDC <> f_DC) then
    begin
     UpdatePixelsPerInch;
     {-обновляем разрешение}
     VCLFont.PixelsPerInch := PixelsPerInchY; {-выставляем разрешение шрифту}
    end;//l_OldDC <> f_DC
    if (Zoom <> 100) then
    begin
     SetMapMode(f_DC, MM_ISOTROPIC);
     SetWindowExtEx(f_DC, 100, 100, nil);
     SetViewPortExtEx(f_DC, Abs(Zoom), Abs(Zoom), nil);
    end;//Zoom <> 100
   finally
    Unlock;
   end;//try..finally
  end;//Result
 finally
  Dec(f_CheckingDrawing);
 end;//try..finally
//#UC END# *56AF1E9702A0_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.CheckDrawing

constructor Tl3CanvasPrim.CreateOwned(anOwner: TObject);
//#UC START# *56AF3CC4020E_4A4CB79A02C6_var*
//#UC END# *56AF3CC4020E_4A4CB79A02C6_var*
begin
//#UC START# *56AF3CC4020E_4A4CB79A02C6_impl*
 f_Owner := anOwner;
 if (anOwner is Graphics.TBitmap) then
  Canvas := Graphics.TBitmap(anOwner).Canvas;
 Create;
//#UC END# *56AF3CC4020E_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.CreateOwned

constructor Tl3CanvasPrim.CreateForPrinting(const aPrinter: Il3Printer);
//#UC START# *56B08EB80255_4A4CB79A02C6_var*
//#UC END# *56B08EB80255_4A4CB79A02C6_var*
begin
//#UC START# *56B08EB80255_4A4CB79A02C6_impl*
 if (aPrinter <> nil) then
  f_Printer := aPrinter.Clone
 else
  f_Printer := nil;
 Printing := (f_Printer <> nil);
 Create;
//#UC END# *56B08EB80255_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.CreateForPrinting

procedure Tl3CanvasPrim.SetCanvas(aValue: TCanvas;
 anAlien: Boolean);
//#UC START# *56B0AE550267_4A4CB79A02C6_var*
var
 l_E: TNotifyEvent;
 l_M: TMethod absolute l_E;
//#UC END# *56B0AE550267_4A4CB79A02C6_var*
begin
//#UC START# *56B0AE550267_4A4CB79A02C6_impl*
 if (f_Canvas <> aValue) then
 begin
  if (f_Canvas <> nil) and f_AlienCanvas then
  begin
   if (f_Canvas.Font <> nil) then
    f_Canvas.Font.OnChange := f_OldFontChange;
   if (f_Canvas.Brush <> nil) then
    f_Canvas.Brush.OnChange := f_OldBrushChange;
  end;//f_Canvas <> nil
  if anAlien then
   FreeDC
  else
  if (f_DCFlag = ev_dcfCanvas) then
  begin
   f_DC := 0;
   FireDCSetToNull;
  end;//f_DCFlag = ev_dcfCanvas
  if not f_AlienCanvas then
   FreeAndNil(f_Canvas);
  f_Canvas := aValue;
  f_AlienCanvas := anAlien;
  if (f_Canvas = nil) then
  begin
   f_OldBrushChange := nil;
   f_OldFontChange := nil;
  end//f_Canvas = nil
  else
  begin
   if Assigned(f_Canvas.Font.OnChange) then
   begin
    l_E := f_Canvas.Font.OnChange;
    Assert(l_M.Data <> Self);
   end;//Assigned(f_Canvas.Font.OnChange)
   f_OldBrushChange := f_Canvas.Brush.OnChange;
   f_OldFontChange := f_Canvas.Font.OnChange;
   f_Canvas.Brush.OnChange := BrushChanged;
   f_Canvas.Font.OnChange := FontChanged;
  end;//f_Canvas = nil
 end//f_Canvas <> Value
 else
 if (f_AlienCanvas <> anAlien) then
  f_AlienCanvas := anAlien;
//#UC END# *56B0AE550267_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.SetCanvas

procedure Tl3CanvasPrim.BrushChanged(Sender: TObject);
//#UC START# *56B0AED5005B_4A4CB79A02C6_var*
//#UC END# *56B0AED5005B_4A4CB79A02C6_var*
begin
//#UC START# *56B0AED5005B_4A4CB79A02C6_impl*
 if Assigned(f_OldBrushChange) then
  f_OldBrushChange(Sender);
 if (f_CheckingColors <= 0) then
  BackColor := Brush.Color;
//#UC END# *56B0AED5005B_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.BrushChanged

procedure Tl3CanvasPrim.FontChanged(Sender: TObject);
//#UC START# *56B0AEF1020C_4A4CB79A02C6_var*
var
 l_E: TNotifyEvent;
 l_M: TMethod absolute l_E;
//#UC END# *56B0AEF1020C_4A4CB79A02C6_var*
begin
//#UC START# *56B0AEF1020C_4A4CB79A02C6_impl*
 if Assigned(f_OldFontChange) then
 begin
  l_E := f_OldFontChange;
  Assert(l_M.Data <> Self);
  l_E(Sender);
 end;//Assigned(f_OldFontChange) 
 f_TextMetricsValid := False;
 f_AverageCharHeight := 0;
 f_AverageCharWidth := 0;
 f_pxAverageCharWidth := 0;
 if (Win32Platform = VER_PLATFORM_WIN32_WINDOWS) then
  f_SuffixedFont := ANSIEndsText(fs_Cyr, VCLFont.Name)
 else
 if (Win32Platform = VER_PLATFORM_WIN32_NT) then
 begin
  if (Win32MajorVersion = 5) then
  begin
   if (Win32MinorVersion = 0) then
    f_SuffixedFont := False
   else
    f_SuffixedFont := True;
  end//Win32MajorVersion = 5
  else
  if (Win32MajorVersion > 5) then
   f_SuffixedFont := True
  else
   f_SuffixedFont := ANSIEndsText(fs_Cyr, VCLFont.Name);
 end//Win32Platform = VER_PLATFORM_WIN32_NT
 else
 begin
  Assert(False);
  f_SuffixedFont := ANSIEndsText(fs_Cyr, VCLFont.Name);
 end;//Win32Platform = VER_PLATFORM_WIN32_NT
 if (f_CheckingColors <= 0) then
 begin
  Inc(f_CheckingColors);
  try
   TextColor := VCLFont.Color;
  finally
   Dec(f_CheckingColors);
  end;//try..finally
 end;//
 CheckDrawing;
//#UC END# *56B0AEF1020C_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.FontChanged

procedure Tl3CanvasPrim.FreeDC;
//#UC START# *56B0B2430282_4A4CB79A02C6_var*
//#UC END# *56B0B2430282_4A4CB79A02C6_var*
begin
//#UC START# *56B0B2430282_4A4CB79A02C6_impl*
 if (f_DC <> 0) then
 begin
  case f_DCFlag of
   ev_dcfCanvas: 
    if (Owner is TMetaFile) then
     Canvas := nil;
   ev_dcfGot: 
   begin
    if (f_Canvas <> nil) then
     f_Canvas.Handle := 0;
    FreeAlienDC(f_DC); 
   end;//ev_dcfGot
   ev_dcfCreated:
   begin
    if (f_Canvas <> nil) then
     f_Canvas.Handle := 0;
    DeleteDC(f_DC);
    f_DCFlag := ev_dcfCanvas;
   end;//ev_dcfCreated
   else
    f_DCFlag := ev_dcfCanvas;
  end;//case f_DCFlag
  f_DC := 0;
 end;//f_DC <> 0
//#UC END# *56B0B2430282_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.FreeDC

procedure Tl3CanvasPrim.FreeAlienDC(aDC: hDC);
//#UC START# *56B0B2610026_4A4CB79A02C6_var*
//#UC END# *56B0B2610026_4A4CB79A02C6_var*
begin
//#UC START# *56B0B2610026_4A4CB79A02C6_impl*
//#UC END# *56B0B2610026_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.FreeAlienDC

procedure Tl3CanvasPrim.FireDCSetToNull;
//#UC START# *56B0B54F03CC_4A4CB79A02C6_var*
//#UC END# *56B0B54F03CC_4A4CB79A02C6_var*
begin
//#UC START# *56B0B54F03CC_4A4CB79A02C6_impl*
//#UC END# *56B0B54F03CC_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.FireDCSetToNull

function Tl3CanvasPrim.IsPreview: Boolean;
//#UC START# *56B0B9790320_4A4CB79A02C6_var*
//#UC END# *56B0B9790320_4A4CB79A02C6_var*
begin
//#UC START# *56B0B9790320_4A4CB79A02C6_impl*
 Result := False;
//#UC END# *56B0B9790320_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.IsPreview

procedure Tl3CanvasPrim.Invalidate;
//#UC START# *56B0BB0501B9_4A4CB79A02C6_var*
//#UC END# *56B0BB0501B9_4A4CB79A02C6_var*
begin
//#UC START# *56B0BB0501B9_4A4CB79A02C6_impl*
 
//#UC END# *56B0BB0501B9_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.Invalidate

procedure Tl3CanvasPrim.DoFillEmptyRect(const R: Tl3Rect);
//#UC START# *56B356D6039B_4A4CB79A02C6_var*
var
 Rgn2Fill : Tl3Region;
 l_Filled : Tl3Region;
//#UC END# *56B356D6039B_4A4CB79A02C6_var*
begin
//#UC START# *56B356D6039B_4A4CB79A02C6_impl*
 if DrawRgnOrBlock then
 begin
  Rgn2Fill := Tl3Region.Create;
  try
   Rgn2Fill.Rect := WO(l3IntersectRect(R, ClipRect));
   l_Filled := Tl3Region.Create;
   try
    l_Filled.Assign(f_Filled);
    OffsetRgn(l_Filled, WindowOrg);
    case Rgn2Fill.Combine(l_Filled, RGN_DIFF) of
     NULLREGION : ;
     SIMPLEREGION : FillRect(Rgn2Fill.Rect);
     else
      FillRgn(Rgn2Fill);
    end;//case Rgn2Fill.Combine(l_Filled, RGN_DIFF)
   finally
    FreeAndNil(l_Filled);
   end;//try..finally
  finally
   FreeAndNil(Rgn2Fill);
  end;//try..finally
 end;//DrawRgnOrBlock
//#UC END# *56B356D6039B_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DoFillEmptyRect

procedure Tl3CanvasPrim.DoFillEmptyRect(const R: Tl3SRect);
//#UC START# *56B356F20141_4A4CB79A02C6_var*
var
 Rgn2Fill : Tl3Region;
 l_Filled : Tl3Region;
 l_Clip   : Tl3SRect;
//#UC END# *56B356F20141_4A4CB79A02C6_var*
begin
//#UC START# *56B356F20141_4A4CB79A02C6_impl*
 if DrawRgnOrBlock then
 begin
  if f_ClipRectInited then
   l_Clip := f_ClipSRect
  else
   l_Clip.GetClip(DC);
  Rgn2Fill := Tl3Region.Create;
  try
   Rgn2Fill.Rect := l3IntersectRect(R, l_Clip);
   l_Filled := Tl3Region.Create;
   try
    l_Filled.Assign(f_Filled);
    OffsetRgn(l_Filled, WindowOrg);
    Case Rgn2Fill.Combine(l_Filled, RGN_DIFF) of
     NULLREGION : ;
     SIMPLEREGION : FillRect(Rgn2Fill.Rect);
     else
      FillRgn(Rgn2Fill);
    end;//Case Rgn2Fill.Combine(l_Filled, RGN_DIFF)
   finally
    FreeAndNil(l_Filled);
   end;//try..finally
  finally
   FreeAndNil(Rgn2Fill);
  end;//try..finally
 end;//DrawRgnOrBlock
//#UC END# *56B356F20141_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DoFillEmptyRect

function Tl3CanvasPrim.GetGlobalClipRect: Tl3Rect;
//#UC START# *56B359C302CB_4A4CB79A02C6_var*
//#UC END# *56B359C302CB_4A4CB79A02C6_var*
begin
//#UC START# *56B359C302CB_4A4CB79A02C6_impl*
 if DrawRgnOrBlock AND Drawing then
 begin
  if f_ClipRectInited then
   Result := f_ClipRect
  else
  if f_ClipSRect.GetClip(DC) then
  begin
   Result := DR2LR(f_ClipSRect.SubPt(LP2DP(WindowOrg)));
   f_ClipRect := Result;
   f_ClipRectInited := True;
  end//R.GetClip(DC)
  else
  begin
   Result.TopLeft := l3Point0;
   Result.BottomRight := l3Point0;
  end;//R.GetClip(DC)
 end//DrawRgnOrBlock AND Drawing
 else
  Result := GetClientRect;
//#UC END# *56B359C302CB_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.GetGlobalClipRect

function Tl3CanvasPrim.GetTabWidth: Integer;
//#UC START# *56B366BF017F_4A4CB79A02C6_var*
var
 l_Width : Long;
//#UC END# *56B366BF017F_4A4CB79A02C6_var*
begin
//#UC START# *56B366BF017F_4A4CB79A02C6_impl*
 if (f_TabStops = nil) then
 begin
  l_Width := LP2DP(l3PointX(l3Inch div 2)).X;
  Result := ((f_TabOffset + l_Width) div l_Width) * l_Width - f_TabOffset;
 end//f_TabStops = nil
 else
 begin
  repeat
   l_Width := LP2DP(l3PointX(f_TabStops.Next.rPosition)).X;
   Result := l_Width - f_TabOffset;
  until (Result > 0);
 end;//f_TabStops = nil
//#UC END# *56B366BF017F_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.GetTabWidth

procedure Tl3CanvasPrim.RestoreTabInfo(const aTabInfo: Il3TabInfo);
//#UC START# *56B381C10085_4A4CB79A02C6_var*
//#UC END# *56B381C10085_4A4CB79A02C6_var*
begin
//#UC START# *56B381C10085_4A4CB79A02C6_impl*
 if (aTabInfo <> nil) then
 begin
  f_TabOffset := LP2DP(l3PointX(aTabInfo.TabOffset)).X;
  f_TabStops := aTabInfo.TabStops;
 end//aTabInfo <> nil
 else
 begin
  f_TabOffset := 0;
  f_TabStops := nil;
 end;//aTabInfo <> nil
//#UC END# *56B381C10085_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.RestoreTabInfo

function Tl3CanvasPrim.TabOffset: Integer;
//#UC START# *56B383FA024A_4A4CB79A02C6_var*
//#UC END# *56B383FA024A_4A4CB79A02C6_var*
begin
//#UC START# *56B383FA024A_4A4CB79A02C6_impl*
 Result := DP2LP(PointX(f_TabOffset)).X;
//#UC END# *56B383FA024A_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.TabOffset

procedure Tl3CanvasPrim.SetDC(DC: hDC;
 Flag: TevDCFlag);
//#UC START# *56B386FC021B_4A4CB79A02C6_var*
//#UC END# *56B386FC021B_4A4CB79A02C6_var*
begin
//#UC START# *56B386FC021B_4A4CB79A02C6_impl*
 FreeDC;
 f_DC := DC;
 f_DCFlag := Flag;
 if (Canvas <> nil) then
  Canvas.Handle := f_DC;
//#UC END# *56B386FC021B_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.SetDC

procedure Tl3CanvasPrim.RecordRegionBottomPrim(const aBottom: Tl3SPoint);
//#UC START# *56B3978F02F7_4A4CB79A02C6_var*
//#UC END# *56B3978F02F7_4A4CB79A02C6_var*
begin
//#UC START# *56B3978F02F7_4A4CB79A02C6_impl*
 f_RegionBottomRight.X := Max(f_RegionBottomRight.X, aBottom.X);
 f_RegionBottomRight.Y := Max(f_RegionBottomRight.Y, aBottom.Y);
 if Printing then
  f_RegionBottomRight.Y := Min(f_RegionBottomRight.Y, LP2DP(GlobalClipRect.BottomRight).Y);
//#UC END# *56B3978F02F7_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.RecordRegionBottomPrim

procedure Tl3CanvasPrim.AddRect(const aRect: Tl3SRect);
//#UC START# *56B490C903C5_4A4CB79A02C6_var*
var
 l_Rect : Tl3SRect;
//#UC END# *56B490C903C5_4A4CB79A02C6_var*
begin
//#UC START# *56B490C903C5_4A4CB79A02C6_impl*
 l_Rect := aRect.SubPt(LP2DP(WindowOrg));
 if Drawing AND (aRect.Right - aRect.Left <> 0) AND
    (aRect.Bottom - aRect.Top <> 0) then
  DoAddRect(l_Rect);
 RecordRegionBottomPrim(l_Rect.BottomRight);
//#UC END# *56B490C903C5_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.AddRect

procedure Tl3CanvasPrim.DoAddRect(const aRect: Tl3SRect);
//#UC START# *56B491A30323_4A4CB79A02C6_var*
//#UC END# *56B491A30323_4A4CB79A02C6_var*
begin
//#UC START# *56B491A30323_4A4CB79A02C6_impl*
 if DrawEnabled then
  xCheckFilled.CombineRect(aRect, RGN_OR);
//#UC END# *56B491A30323_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DoAddRect

function Tl3CanvasPrim.xCheckFilled: Tl3Region;
//#UC START# *56B4942801F5_4A4CB79A02C6_var*
//#UC END# *56B4942801F5_4A4CB79A02C6_var*
begin
//#UC START# *56B4942801F5_4A4CB79A02C6_impl*
 if (f_Filled = nil) then
  f_Filled := Tl3Region.Create;
 Result := f_Filled;
//#UC END# *56B4942801F5_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.xCheckFilled

procedure Tl3CanvasPrim.AddRgn(const aRgn: Il3Region);
//#UC START# *56B496300318_4A4CB79A02C6_var*
var
 l_Rgn : Tl3Region;
//#UC END# *56B496300318_4A4CB79A02C6_var*
begin
//#UC START# *56B496300318_4A4CB79A02C6_impl*
 l_Rgn := Tl3Region.Create;
 try
  l_Rgn.Il3Region_Assign(aRgn);
  OffsetRgn(l_Rgn, WindowOrg.Neg);
  if Invert then
   xCheckFilled.Combine(l_Rgn, RGN_OR)
  else
  begin
   xCheckFilled.Combine(l_Rgn, RGN_OR);
  end;//Invert
  RecordRegionBottomPrim(l_Rgn.Rect.BottomRight);
 finally
  FreeAndNil(l_Rgn);
 end;//try..finally
//#UC END# *56B496300318_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.AddRgn

function Tl3CanvasPrim.KerningTextExtent(const S: Tl3PCharLenPrim): Tl3Point;
//#UC START# *56B499ED0217_4A4CB79A02C6_var*
var
 l_ICN     : Il3InfoCanvas;
 l_TabInfo : Il3TabInfo;
 l_PC      : AnsiChar;
//#UC END# *56B499ED0217_4A4CB79A02C6_var*
begin
//#UC START# *56B499ED0217_4A4CB79A02C6_impl*
 if not Printing then
 begin
  l_ICN := l3CrtIC;
  if l_ICN.EQ(Self) then
   Result := GetKerning(S, CheckKerning(S.SLen))
  else
  begin
   l_ICN.Lock;
   try
    l_ICN.PushLineSpacing;
    l_PC := l_ICN.PasswordChar;
    try
     l_ICN.LineSpacing := f_LineSpacing;
     l_ICN.PasswordChar := f_PasswordChar;
     l_ICN.Font := Self;
     if (f_Tabs > 0) then
     begin
      l_ICN.StartTabs(l_TabInfo, TabInfo);
      try
       Result := l_ICN.GetKerning(S, CheckKerning(S.SLen));
       RestoreTabInfo(l_ICN.TabInfo);
      finally
       l_ICN.FinishTabs(l_TabInfo);
      end;//try..finally
     end//f_Tabs > 0
     else
      Result := l_ICN.GetKerning(S, CheckKerning(S.SLen));
     finally
      l_ICN.PopLineSpacing;
      l_ICN.PasswordChar := l_PC;
     end;//try..finally
   finally
    l_ICN.Unlock;
   end;//try..finally
  end;//l3IEQ(l_ICN, Self)
 end//not Printing
 else
  Result := TextExtent(S);
//#UC END# *56B499ED0217_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.KerningTextExtent

procedure Tl3CanvasPrim.KerningTextOut(const P: Tl3Point;
 const R: Tl3Rect;
 const S: Tl3PCharLenPrim);
//#UC START# *56B49A1201C3_4A4CB79A02C6_var*
//#UC END# *56B49A1201C3_4A4CB79A02C6_var*
begin
//#UC START# *56B49A1201C3_4A4CB79A02C6_impl*
 if DrawEnabled AND not Printing AND (f_Kerning <> nil) then
  ExtTextOut(P, R, S, l3_tffLeft, PInteger(f_Kerning.AsPointer))
 else
  ExtTextOut(P, R, S, l3_tffLeft, nil);
//#UC END# *56B49A1201C3_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.KerningTextOut

procedure Tl3CanvasPrim.KerningTextOut(const P: Tl3SPoint;
 const R: Tl3SRect;
 const S: Tl3PCharLenPrim);
//#UC START# *56B49A32007A_4A4CB79A02C6_var*
//#UC END# *56B49A32007A_4A4CB79A02C6_var*
begin
//#UC START# *56B49A32007A_4A4CB79A02C6_impl*
 if DrawEnabled AND not Printing AND (f_Kerning <> nil) then
  ExtTextOut(P, R, S, l3_tffLeft, PInteger(f_Kerning.AsPointer))
 else
  ExtTextOut(P, R, S, l3_tffLeft, nil);
//#UC END# *56B49A32007A_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.KerningTextOut

function Tl3CanvasPrim.CheckKerning(Size: Integer): Pointer;
//#UC START# *56B49D1602E8_4A4CB79A02C6_var*
//#UC END# *56B49D1602E8_4A4CB79A02C6_var*
begin
//#UC START# *56B49D1602E8_4A4CB79A02C6_impl*
 if (f_Kerning = nil) then
  f_Kerning := Tl3MemoryPool.Create{(Self)};
 Size := Size * SizeOf(Integer);
 if (f_Kerning.Size < Size) then
  f_Kerning.Size := Size;
 Result := f_Kerning.AsPointer;
//#UC END# *56B49D1602E8_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.CheckKerning

function Tl3CanvasPrim.GetCaret: Il3Caret;
//#UC START# *56B49F030225_4A4CB79A02C6_var*
//#UC END# *56B49F030225_4A4CB79A02C6_var*
begin
//#UC START# *56B49F030225_4A4CB79A02C6_impl*
 Result := nil;
//#UC END# *56B49F030225_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.GetCaret

procedure Tl3CanvasPrim.CheckOrientation;
//#UC START# *56B4A15D03C2_4A4CB79A02C6_var*
 procedure CorrectDelta(var A, B: Long);
 var
  l_Div : Long;
  l_Mod : Long;
 begin//CorrectDelta
  if (A >= B) then
  begin
   l_Div := A div B;
   l_Mod := A mod B;
   if (l_Mod < l3Epsilon * l_Div) then
    A := l_Div * B
   else
   if (B - l_Mod < l3Epsilon) then
    A := Succ(l_Div) * B;
  end//A >= B
  else
   CorrectDelta(B, A);
 end;//CorrectDelta

var
 l_PaperWidth  : Long;
 l_PaperHeight : Long;
 l_Extent      : Tl3Point;
//#UC END# *56B4A15D03C2_4A4CB79A02C6_var*
begin
//#UC START# *56B4A15D03C2_4A4CB79A02C6_impl*
 if (f_PageWidthNumber <= 0) then
 begin
  // - Здесь подгоняем ориентацию
  with PageSetup do
  begin
   l_PaperWidth := PaperWidth;
   l_PaperHeight := PaperHeight;
  end;//with PageSetup
  l_Extent := f_SectionExtent;
  with l_Extent do
  begin
   CorrectDelta(l_PaperWidth, P.X);
   CorrectDelta(l_PaperWidth, P.Y);
   CorrectDelta(l_PaperHeight, P.X);
   CorrectDelta(l_PaperHeight, P.Y);
   if (X mod l_PaperWidth > X mod l_PaperHeight) {OR
      (Y mod l_PaperHeight > Y mod l_PaperWidth)} then
     PageOrientation := l3PageOrientationInvert[f_PageOrientation];
  end;//with l_Extent
 end;//f_PageWidthNumber <= 0
//#UC END# *56B4A15D03C2_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.CheckOrientation

function Tl3CanvasPrim.NeedOpenRealPage(aDoc: Boolean;
 ByWidth: Boolean = False): Tl3OpenPageResult;
//#UC START# *56B4A55202AB_4A4CB79A02C6_var*
//#UC END# *56B4A55202AB_4A4CB79A02C6_var*
begin
//#UC START# *56B4A55202AB_4A4CB79A02C6_impl*
 Result := l3_oprYes;
//#UC END# *56B4A55202AB_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.NeedOpenRealPage

procedure Tl3CanvasPrim.StartPrinterPage(aDoc: Boolean);
//#UC START# *56B4B2F50121_4A4CB79A02C6_var*
//#UC END# *56B4B2F50121_4A4CB79A02C6_var*
begin
//#UC START# *56B4B2F50121_4A4CB79A02C6_impl*
 if (ev_dfSelfStarted in Flags) then
  f_Printer.NewPage
 else
 begin
  Flags := Flags + [ev_dfSelfStarted];
  f_Printer.BeginDoc;
 end;//ev_dfSelfStarted in Flags
//#UC END# *56B4B2F50121_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.StartPrinterPage

procedure Tl3CanvasPrim.StartPage;
//#UC START# *56B4B5EF019F_4A4CB79A02C6_var*
var
 R    : Tl3Rect;
 l_WO : Tl3Point;
 l_Canvas: Il3Canvas;
 l_BottomHeight: Long;
 l_CR : Tl3Rect;
//#UC END# *56B4B5EF019F_4A4CB79A02C6_var*
begin
//#UC START# *56B4B5EF019F_4A4CB79A02C6_impl*
 WindowOrg := l3Point0;
 ClipRect := l3RectBnd(l3Point0,
                       DP2LP(l3SPoint(DeviceCaps(HORZRES),
                                      DeviceCaps(VERTRES))));
 Printed := true;
 l_WO := WindowOrg;
 if (Painter <> nil) then
 begin
  FreeAndNil(f_Filled);
  BeginInvert;
  try
   CheckDrawing;
   PushBC;
   try
    l_CR := ClipRect;
    if (f_VirtualCanvas <> nil) then
     with f_VirtualCanvas.PageSetup do
      if (Width <> l_CR.Right) OR (Height <> l_CR.Bottom) then
       f_VirtualCanvas := nil;
    if (f_VirtualCanvas = nil) then
     f_VirtualCanvas := Tl3VirtualCanvas.Make(l_CR.BottomRight);
    l_Canvas := f_VirtualCanvas;
    try
     l_Canvas.AbortChecker := Self.f_AbortChecker;
     try
      l_Canvas.PageSetup.Margins := pm_GetMargins{pm_GetPrintableMargins};
      l_BottomHeight := l_Canvas.PageSetup.Margins.Bottom;
      l_Canvas.WindowOrg := l3Point0;
      l_Canvas.MoveWindowOrg(PointX(DeviceCaps(PHYSICALOFFSETX)));
      Painter.StartPage(l_Canvas, false);
      l_BottomHeight := Max(-l_Canvas.WindowOrg.Y, l_BottomHeight);
     finally
      l_Canvas.AbortChecker := nil;
     end;//try..finally
    finally
     l_Canvas := nil;
    end;
    MoveWindowOrg(PointX(DeviceCaps(PHYSICALOFFSETX)));
    Painter.StartPage(Self, true);
    l_WO := WindowOrg;
    WindowOrg := l3Point0;
    WindowOrg := l3PointY(ClipRect.Bottom - l_BottomHeight).Neg;
    MoveWindowOrg(PointX(DeviceCaps(PHYSICALOFFSETX)));
    Painter.StartPage(Self, false);
   finally
    PopBC;
   end;//try..finally
  finally
   EndInvert;
  end;//try..finally
 end//Painter <> nil
 else
  l_BottomHeight := 0{pm_GetPrintableMargins.Bottom};
 WindowOrg := l_WO;
 MoveWindowOrg(l3PointX(-WindowOrg.X));
 MoveWindowOrg(PointX(DeviceCaps(PHYSICALOFFSETX)));
 R := ClipRect;
 if (R.Left < 0) then R.Left := 0;
 if (R.Top < 0) then R.Top := 0;
 R.BottomRight := R.BottomRight.Sub(l3PointY(l_BottomHeight));
 // - здесь уменьшаем размер области вывода на размер нижнего поля -
 //   чтобы текст не рисовал на колонтитуле.
 ClipRect := R;
//#UC END# *56B4B5EF019F_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.StartPage

procedure Tl3CanvasPrim.DoStartObject(anObjectID: Integer);
//#UC START# *56B4BABD03A2_4A4CB79A02C6_var*
//#UC END# *56B4BABD03A2_4A4CB79A02C6_var*
begin
//#UC START# *56B4BABD03A2_4A4CB79A02C6_impl*
//#UC END# *56B4BABD03A2_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DoStartObject

procedure Tl3CanvasPrim.DoSetPageTop;
//#UC START# *56B4BBCF00D5_4A4CB79A02C6_var*
//#UC END# *56B4BBCF00D5_4A4CB79A02C6_var*
begin
//#UC START# *56B4BBCF00D5_4A4CB79A02C6_impl*
//#UC END# *56B4BBCF00D5_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DoSetPageTop

procedure Tl3CanvasPrim.DoEndPaint;
//#UC START# *56B4BDA30301_4A4CB79A02C6_var*
//#UC END# *56B4BDA30301_4A4CB79A02C6_var*
begin
//#UC START# *56B4BDA30301_4A4CB79A02C6_impl*
 if (EndDrawing = 0) then
 begin
  if (ev_dfSelfStarted in Flags) and f_Printer.Printing then
   f_Printer.EndDoc;
  if Printing AND (f_Printer <> nil) and not f_Printer.Printing then
   f_Printer.Orientation := f_SaveOrientation;
  f_FrameLines := nil;
  FreeDC;
  FreeAndNil(f_Filled);
  f_VirtualCanvas := nil;
  f_PageWidthNumber := 0;
 end;//f_Drawing = 0
 Unlock;
//#UC END# *56B4BDA30301_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DoEndPaint

procedure Tl3CanvasPrim.DoDrawLineTo(aX: Integer;
 aY: Integer);
//#UC START# *56B4D32C038D_4A4CB79A02C6_var*
var
 l_PenColor: TColor;
//#UC END# *56B4D32C038D_4A4CB79A02C6_var*
begin
//#UC START# *56B4D32C038D_4A4CB79A02C6_impl*
 with Canvas do
 begin
  if Invert AND not Printing then
  begin
   l_PenColor := Pen.Color;
   try
    Pen.Color := InvertColor(l_PenColor);
    LineTo(aX, aY);
   finally
    Pen.Color := l_PenColor;
   end;//try..finally
  end//Invert..
  else
   LineTo(aX, aY);
 end;
//#UC END# *56B4D32C038D_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DoDrawLineTo

function Tl3CanvasPrim.CreateRectRgn(const aRect: Tl3SRect): Tl3Rgn;
//#UC START# *56B4D790021E_4A4CB79A02C6_var*
//#UC END# *56B4D790021E_4A4CB79A02C6_var*
begin
//#UC START# *56B4D790021E_4A4CB79A02C6_impl*
 Result := aRect.CreateRgn;
//#UC END# *56B4D790021E_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.CreateRectRgn

function Tl3CanvasPrim.DoGetClientRect: Tl3Rect;
//#UC START# *56B4D83B00EC_4A4CB79A02C6_var*
//#UC END# *56B4D83B00EC_4A4CB79A02C6_var*
begin
//#UC START# *56B4D83B00EC_4A4CB79A02C6_impl*
 Result.R.TopLeft := l3Point0;
 Result.R.BottomRight := l3Point0;
//#UC END# *56B4D83B00EC_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DoGetClientRect

function Tl3CanvasPrim.CheckConvertTable(OEM: Boolean): PAnsiChar;
//#UC START# *56B4DC3E0242_4A4CB79A02C6_var*
var
 i : AnsiChar;
 c : AnsiChar;
//#UC END# *56B4DC3E0242_4A4CB79A02C6_var*
begin
//#UC START# *56B4DC3E0242_4A4CB79A02C6_impl*
 if (f_ConvertTable[OEM] = nil) then
 begin
  f_ConvertTable[OEM] := Tl3MemoryPool.Create{(Self)};
  with f_ConvertTable[OEM] do
  begin
   Size := 256;
   if OEM then
   begin
    for i := #0 to #255 do
    begin
     c := i;
     case i of
      cc_HardSpace: c := cc_OEMHardSpaceSymbol;
      cc_OEMSoftSpace: c := cc_OEMSoftSpaceSymbol;
     else
      c := i;
     end;//case i
     Write(Ord(i), @c, 1);
    end;//for i
   end
   else
   begin
    for i := #0 to #255 do
    begin
     case i of
      cc_OEMParagraphSign : c := cc_ParagraphSign;
      #8 : c := #135;
      //cc_Tab: c := cc_TabSymbol;
      cc_SoftSpace: c := cc_SoftSpaceSymbol;
      cc_HardSpace: c := cc_HardSpaceSymbol;
     else
      c := i;
     end;//case i
     Write(Ord(i), @c, 1);
    end;//for i
   end;//OEM
  end;//with f_ConvertTable[OEM]..
 end;//f_ConvertTable = nil
 Result := f_ConvertTable[OEM].AsPointer;
//#UC END# *56B4DC3E0242_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.CheckConvertTable

function Tl3CanvasPrim.DoGetPageSetupWidth: Tl3Inch;
//#UC START# *4A4CBCD002EA_4A4CB79A02C6_var*
//#UC END# *4A4CBCD002EA_4A4CB79A02C6_var*
begin
//#UC START# *4A4CBCD002EA_4A4CB79A02C6_impl*
 if Printing AND (f_Printer <> nil) AND not f_Printer.HasPrinter then
  Result := DP2LP(PointX(DeviceCaps(PHYSICALWIDTH))).X
 else
  Result := DP2LP(PointX(DeviceCaps(HORZRES))).X;
//#UC END# *4A4CBCD002EA_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DoGetPageSetupWidth

function Tl3CanvasPrim.DoGetPageSetupHeight: Tl3Inch;
//#UC START# *4A4CBCDD0244_4A4CB79A02C6_var*
//#UC END# *4A4CBCDD0244_4A4CB79A02C6_var*
begin
//#UC START# *4A4CBCDD0244_4A4CB79A02C6_impl*
 if Printing AND (f_Printer <> nil) AND not f_Printer.HasPrinter then
  Result := DP2LP(PointY(DeviceCaps(PHYSICALHEIGHT))).Y
 else
  Result := DP2LP(PointY(DeviceCaps(VERTRES))).Y;
//#UC END# *4A4CBCDD0244_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DoGetPageSetupHeight

function Tl3CanvasPrim.DoGetDrawEnabled: Boolean;
//#UC START# *4A4CC195011E_4A4CB79A02C6_var*
//#UC END# *4A4CC195011E_4A4CB79A02C6_var*
begin
//#UC START# *4A4CC195011E_4A4CB79A02C6_impl*
 Result := (ev_dfDrawRegion In f_Flags);
//#UC END# *4A4CC195011E_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DoGetDrawEnabled

function Tl3CanvasPrim.GetPrinting: Boolean;
//#UC START# *4A4CCCE900E8_4A4CB79A02C6_var*
//#UC END# *4A4CCCE900E8_4A4CB79A02C6_var*
begin
//#UC START# *4A4CCCE900E8_4A4CB79A02C6_impl*
 Result := (ev_dfPrinting in f_Flags);
//#UC END# *4A4CCCE900E8_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.GetPrinting

function Tl3CanvasPrim.AsIl3Canvas: Il3Canvas;
//#UC START# *4A4CCF9202D9_4A4CB79A02C6_var*
//#UC END# *4A4CCF9202D9_4A4CB79A02C6_var*
begin
//#UC START# *4A4CCF9202D9_4A4CB79A02C6_impl*
 Result := Self;
//#UC END# *4A4CCF9202D9_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.AsIl3Canvas

procedure Tl3CanvasPrim.AssignDeviceCaps;
 {* Инициализировать информацию об устройстве }
//#UC START# *4A4CE6BE005A_4A4CB79A02C6_var*
var
 l_DC  : hDC;
 l_DCD : hDC;
//#UC END# *4A4CE6BE005A_4A4CB79A02C6_var*
begin
//#UC START# *4A4CE6BE005A_4A4CB79A02C6_impl*
  if f_DeviceCaps.rIsAssigned then
  Exit;
 Lock;
 try
  with f_DeviceCaps do
  begin
   l_DCD := 0;
   try
    l_DC := DC;
    rLOGPIXELSX := Windows.GetDeviceCaps(l_DC, LOGPIXELSX);
    rLOGPIXELSY := Windows.GetDeviceCaps(l_DC, LOGPIXELSY);
    if (rLOGPIXELSX = 0) OR (rLOGPIXELSY = 0) then
    begin
     l_DCD := GetDC(0);
     l_DC := l_DCD;
     rLOGPIXELSY := Windows.GetDeviceCaps(l_DC, LOGPIXELSY);
     rLOGPIXELSX := rLOGPIXELSY;
    end;//rLOGPIXELSX = 0..
    rHORZRES := Windows.GetDeviceCaps(l_DC, HORZRES);
    rVERTRES := Windows.GetDeviceCaps(l_DC, VERTRES);
    rPHYSICALWIDTH := Windows.GetDeviceCaps(l_DC, PHYSICALWIDTH);
    if (rPHYSICALWIDTH = 0) then
     rPHYSICALWIDTH := l3MulDiv(def_inchPaperWidth, rLOGPIXELSX, l3Inch); // A4
    rPHYSICALHEIGHT := Windows.GetDeviceCaps(l_DC, PHYSICALHEIGHT);
    if (rPHYSICALHEIGHT = 0) then
     rPHYSICALHEIGHT := l3MulDiv(def_inchPaperHeight, rLOGPIXELSY, l3Inch); // A4
    rPHYSICALOFFSETX := Windows.GetDeviceCaps(l_DC, PHYSICALOFFSETX);
    rPHYSICALOFFSETY := Windows.GetDeviceCaps(l_DC, PHYSICALOFFSETY);
    f_DeviceCaps.rIsAssigned := (l_DCD = 0) AND (rLOGPIXELSY <> 0);
   finally
    if (l_DCD <> 0) then
     ReleaseDC(0, l_DCD);
   end;//try..finally
  end;//l_DC = 0
 finally
  Unlock;
 end;//try..finally
//#UC END# *4A4CE6BE005A_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.AssignDeviceCaps

function Tl3CanvasPrim.DoGetPaperWidth: Tl3Inch;
//#UC START# *4D1B61130223_4A4CB79A02C6_var*
//#UC END# *4D1B61130223_4A4CB79A02C6_var*
begin
//#UC START# *4D1B61130223_4A4CB79A02C6_impl*
 Result := DP2LP(PointX(DeviceCaps(PHYSICALWIDTH))).X;
//#UC END# *4D1B61130223_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DoGetPaperWidth

procedure Tl3CanvasPrim.DoFillForeRect(const R: Tl3SRect);
//#UC START# *47DFCAEE0007_4A4CB79A02C6_var*
//#UC END# *47DFCAEE0007_4A4CB79A02C6_var*
begin
//#UC START# *47DFCAEE0007_4A4CB79A02C6_impl*
 if Invert then
 begin
  Inc(f_Fore);
  try
   FillRect(R);
  finally
   Dec(f_Fore);
  end;//try..
 end//Invert
 else
  FillRect(R);
//#UC END# *47DFCAEE0007_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DoFillForeRect

function Tl3CanvasPrim.GetAlienDC: hDC;
//#UC START# *4FAE533E035C_4A4CB79A02C6_var*
//#UC END# *4FAE533E035C_4A4CB79A02C6_var*
begin
//#UC START# *4FAE533E035C_4A4CB79A02C6_impl*
 Result := 0;
//#UC END# *4FAE533E035C_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.GetAlienDC

procedure Tl3CanvasPrim.FillRectPrim(const R: TRect);
//#UC START# *47DFCAAF0249_4A4CB79A02C6_var*
//#UC END# *47DFCAAF0249_4A4CB79A02C6_var*
begin
//#UC START# *47DFCAAF0249_4A4CB79A02C6_impl*
 Windows.ExtTextOut(DC, R.Left, R.Top, eto_Opaque, @R, nil, 0, nil);
//#UC END# *47DFCAAF0249_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.FillRectPrim

procedure Tl3CanvasPrim.DoStartDrawAAC(aType: TspBlockType);
//#UC START# *54B4DDF502DD_4A4CB79A02C6_var*
//#UC END# *54B4DDF502DD_4A4CB79A02C6_var*
begin
//#UC START# *54B4DDF502DD_4A4CB79A02C6_impl*
//#UC END# *54B4DDF502DD_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DoStartDrawAAC

procedure Tl3CanvasPrim.DoEndDrawAAC(const R: Tl3Rect);
//#UC START# *54B4DE1700CA_4A4CB79A02C6_var*
//#UC END# *54B4DE1700CA_4A4CB79A02C6_var*
begin
//#UC START# *54B4DE1700CA_4A4CB79A02C6_impl*
//#UC END# *54B4DE1700CA_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DoEndDrawAAC

function Tl3CanvasPrim.Get_ForeColor: Tl3Color;
//#UC START# *46A610780340_4A4CB79A02C6get_var*
//#UC END# *46A610780340_4A4CB79A02C6get_var*
begin
//#UC START# *46A610780340_4A4CB79A02C6get_impl*
 Result := TextColor;
//#UC END# *46A610780340_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_ForeColor

procedure Tl3CanvasPrim.Set_ForeColor(aValue: Tl3Color);
//#UC START# *46A610780340_4A4CB79A02C6set_var*
//#UC END# *46A610780340_4A4CB79A02C6set_var*
begin
//#UC START# *46A610780340_4A4CB79A02C6set_impl*
 TextColor := aValue;
//#UC END# *46A610780340_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.Set_ForeColor

function Tl3CanvasPrim.Get_BackColor: Tl3Color;
//#UC START# *46A6108E017F_4A4CB79A02C6get_var*
//#UC END# *46A6108E017F_4A4CB79A02C6get_var*
begin
//#UC START# *46A6108E017F_4A4CB79A02C6get_impl*
 Result := BackColor;
//#UC END# *46A6108E017F_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_BackColor

procedure Tl3CanvasPrim.Set_BackColor(aValue: Tl3Color);
//#UC START# *46A6108E017F_4A4CB79A02C6set_var*
//#UC END# *46A6108E017F_4A4CB79A02C6set_var*
begin
//#UC START# *46A6108E017F_4A4CB79A02C6set_impl*
 BackColor := aValue;
//#UC END# *46A6108E017F_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.Set_BackColor

function Tl3CanvasPrim.Get_Name: TFontName;
//#UC START# *46A610AF012C_4A4CB79A02C6get_var*
//#UC END# *46A610AF012C_4A4CB79A02C6get_var*
begin
//#UC START# *46A610AF012C_4A4CB79A02C6get_impl*
 Result := VCLFont.Name;
//#UC END# *46A610AF012C_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_Name

procedure Tl3CanvasPrim.Set_Name(const aValue: TFontName);
//#UC START# *46A610AF012C_4A4CB79A02C6set_var*
var
 l_LogFont: Tl3LogFont;
//#UC END# *46A610AF012C_4A4CB79A02C6set_var*
begin
//#UC START# *46A610AF012C_4A4CB79A02C6set_impl*
 if (f_Font <> nil) and (aValue <> l3GlyphFontName) then
  f_Font := nil; 
 l_LogFont := l3FontManager.Fonts.DRByName[aValue];
 VCLFont.Name := aValue;
 if (l_LogFont = nil) then
  VCLFont.CharSet := CS_Effective
 else
  VCLFont.CharSet := l_LogFont.LogFont.elfLogFont.lfCharSet;
//#UC END# *46A610AF012C_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.Set_Name

function Tl3CanvasPrim.Get_Pitch: TFontPitch;
//#UC START# *46A610E10084_4A4CB79A02C6get_var*
//#UC END# *46A610E10084_4A4CB79A02C6get_var*
begin
//#UC START# *46A610E10084_4A4CB79A02C6get_impl*
 Result := VCLFont.Pitch;
//#UC END# *46A610E10084_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_Pitch

procedure Tl3CanvasPrim.Set_Pitch(aValue: TFontPitch);
//#UC START# *46A610E10084_4A4CB79A02C6set_var*
//#UC END# *46A610E10084_4A4CB79A02C6set_var*
begin
//#UC START# *46A610E10084_4A4CB79A02C6set_impl*
 VCLFont.Pitch := aValue;
//#UC END# *46A610E10084_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.Set_Pitch

function Tl3CanvasPrim.Get_Size: Integer;
//#UC START# *46A6111000F9_4A4CB79A02C6get_var*
//#UC END# *46A6111000F9_4A4CB79A02C6get_var*
begin
//#UC START# *46A6111000F9_4A4CB79A02C6get_impl*
 Result := VCLFont.Size;
//#UC END# *46A6111000F9_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_Size

procedure Tl3CanvasPrim.Set_Size(aValue: Integer);
//#UC START# *46A6111000F9_4A4CB79A02C6set_var*
//#UC END# *46A6111000F9_4A4CB79A02C6set_var*
begin
//#UC START# *46A6111000F9_4A4CB79A02C6set_impl*
 VCLFont.Size := aValue;
//#UC END# *46A6111000F9_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.Set_Size

function Tl3CanvasPrim.Get_Index: Tl3FontIndex;
//#UC START# *46A61136020C_4A4CB79A02C6get_var*
//#UC END# *46A61136020C_4A4CB79A02C6get_var*
begin
//#UC START# *46A61136020C_4A4CB79A02C6get_impl*
 if (f_Font <> nil) then
  Result := f_Font.Index
 else
  Result := f_FontIndex;
//#UC END# *46A61136020C_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_Index

procedure Tl3CanvasPrim.Set_Index(aValue: Tl3FontIndex);
//#UC START# *46A61136020C_4A4CB79A02C6set_var*
//#UC END# *46A61136020C_4A4CB79A02C6set_var*
begin
//#UC START# *46A61136020C_4A4CB79A02C6set_impl*
 f_FontIndex := aValue;
//#UC END# *46A61136020C_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.Set_Index

function Tl3CanvasPrim.Get_Style: TFontStyles;
//#UC START# *46A6127B0282_4A4CB79A02C6get_var*
//#UC END# *46A6127B0282_4A4CB79A02C6get_var*
begin
//#UC START# *46A6127B0282_4A4CB79A02C6get_impl*
 Result := VCLFont.Style;
//#UC END# *46A6127B0282_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_Style

procedure Tl3CanvasPrim.Set_Style(aValue: TFontStyles);
//#UC START# *46A6127B0282_4A4CB79A02C6set_var*
//#UC END# *46A6127B0282_4A4CB79A02C6set_var*
begin
//#UC START# *46A6127B0282_4A4CB79A02C6set_impl*
 VCLFont.Style := aValue;
//#UC END# *46A6127B0282_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.Set_Style

function Tl3CanvasPrim.Get_Bold: Boolean;
//#UC START# *46A6129101E3_4A4CB79A02C6get_var*
//#UC END# *46A6129101E3_4A4CB79A02C6get_var*
begin
//#UC START# *46A6129101E3_4A4CB79A02C6get_impl*
 Result := fsBold in VCLFont.Style;
//#UC END# *46A6129101E3_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_Bold

procedure Tl3CanvasPrim.Set_Bold(aValue: Boolean);
//#UC START# *46A6129101E3_4A4CB79A02C6set_var*
//#UC END# *46A6129101E3_4A4CB79A02C6set_var*
begin
//#UC START# *46A6129101E3_4A4CB79A02C6set_impl*
 if aValue then
  VCLFont.Style := VCLFont.Style + [fsBold]
 else
  VCLFont.Style := VCLFont.Style - [fsBold];
//#UC END# *46A6129101E3_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.Set_Bold

function Tl3CanvasPrim.Get_Italic: Boolean;
//#UC START# *46A612AF0038_4A4CB79A02C6get_var*
//#UC END# *46A612AF0038_4A4CB79A02C6get_var*
begin
//#UC START# *46A612AF0038_4A4CB79A02C6get_impl*
 Result := fsItalic in VCLFont.Style;
//#UC END# *46A612AF0038_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_Italic

procedure Tl3CanvasPrim.Set_Italic(aValue: Boolean);
//#UC START# *46A612AF0038_4A4CB79A02C6set_var*
//#UC END# *46A612AF0038_4A4CB79A02C6set_var*
begin
//#UC START# *46A612AF0038_4A4CB79A02C6set_impl*
 if aValue then
  VCLFont.Style := VCLFont.Style + [fsItalic]
 else
  VCLFont.Style := VCLFont.Style - [fsItalic];
//#UC END# *46A612AF0038_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.Set_Italic

function Tl3CanvasPrim.Get_Underline: Boolean;
//#UC START# *46A612C302D6_4A4CB79A02C6get_var*
//#UC END# *46A612C302D6_4A4CB79A02C6get_var*
begin
//#UC START# *46A612C302D6_4A4CB79A02C6get_impl*
 Result := fsUnderline in VCLFont.Style;
//#UC END# *46A612C302D6_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_Underline

procedure Tl3CanvasPrim.Set_Underline(aValue: Boolean);
//#UC START# *46A612C302D6_4A4CB79A02C6set_var*
//#UC END# *46A612C302D6_4A4CB79A02C6set_var*
begin
//#UC START# *46A612C302D6_4A4CB79A02C6set_impl*
 if aValue then
  VCLFont.Style := VCLFont.Style + [fsUnderline]
 else
  VCLFont.Style := VCLFont.Style - [fsUnderline];
//#UC END# *46A612C302D6_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.Set_Underline

function Tl3CanvasPrim.Get_Strikeout: Boolean;
//#UC START# *46A612DC01F5_4A4CB79A02C6get_var*
//#UC END# *46A612DC01F5_4A4CB79A02C6get_var*
begin
//#UC START# *46A612DC01F5_4A4CB79A02C6get_impl*
 Result := fsStrikeout in VCLFont.Style;
//#UC END# *46A612DC01F5_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_Strikeout

procedure Tl3CanvasPrim.Set_Strikeout(aValue: Boolean);
//#UC START# *46A612DC01F5_4A4CB79A02C6set_var*
//#UC END# *46A612DC01F5_4A4CB79A02C6set_var*
begin
//#UC START# *46A612DC01F5_4A4CB79A02C6set_impl*
 if aValue then
  VCLFont.Style := VCLFont.Style + [fsStrikeout]
 else
  VCLFont.Style := VCLFont.Style - [fsStrikeout];
//#UC END# *46A612DC01F5_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.Set_Strikeout

function Tl3CanvasPrim.AssignFont(Font: TFont): Boolean;
//#UC START# *46A6154A01EE_4A4CB79A02C6_var*
var
 l_ForeColor: TColor;
 l_FontColor: TColor;
 l_LogFont: Tl3LogFont;
 l_Font: TFont;
//#UC END# *46A6154A01EE_4A4CB79A02C6_var*
begin
//#UC START# *46A6154A01EE_4A4CB79A02C6_impl*
 Result := true;
 l_Font := VCLFont;
 f_Font := nil;
 if (l_Font <> nil) and (Font <> nil) then
 begin
  l_ForeColor := TextColor;
  l_FontColor := l_Font.Color;
  f_TextColor := Font.Color;
  l_Font.Assign(Font);
  {$IfNDef Nemesis}
   f_TextMetricsValid := false;
  {$Else}
   //Assert(not f_TextMetricsValid);
  {$EndIf Nemesis}
  // ^ - http://mdp.garant.ru/pages/viewpage.action?pageId=185830296&focusedCommentId=199591219#comment-199591219
  if (l_Font.Color = clDefault) then
  begin
   Inc(f_CheckingColors);
   try
    l_Font.Color := l_FontColor;
    TextColor := l_ForeColor;
   finally
    Dec(f_CheckingColors);
   end;//try..finally
  end;//l_Font.Color = clDefault
  Inc(f_CheckingColors);
  try
   l_LogFont := l3FontManager.Fonts.DRByName[l_Font.Name];
   if (l_LogFont = nil) then
    l_Font.CharSet := CS_Effective
   else
    l_Font.CharSet := l_LogFont.LogFont.elfLogFont.lfCharSet;
  finally
   Dec(f_CheckingColors);
  end;//try..finally
  if l3IsDefaultCharset(l_Font.Charset) then
   if (l_Font.Charset <> CS_Effective) then
   begin
    Inc(f_CheckingColors);
    try
     l_Font.Charset := CS_Effective;
    finally
     Dec(f_CheckingColors);
    end;//try..finally
   end;//l_Font.Charset <> CS_Effective
 end;//l_Font <> nil
//#UC END# *46A6154A01EE_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.AssignFont

procedure Tl3CanvasPrim.Assign2Font(const aFont: Il3Font);
//#UC START# *46A6156000CD_4A4CB79A02C6_var*
var
 l_Font: TFont;
//#UC END# *46A6156000CD_4A4CB79A02C6_var*
begin
//#UC START# *46A6156000CD_4A4CB79A02C6_impl*
 Lock;
 try
  aFont.Lock;
  try
   l_Font := VCLFont;
   if aFont.AssignFont(l_Font) then
   begin
    aFont.BackColor := BackColor;
    aFont.Index := Get_Index;
   end else
   with l_Font do
   begin
    aFont.Name := Name;
    aFont.Size := Size;
    aFont.Style := Style;
    aFont.Pitch := Pitch;
    aFont.ForeColor := Color;
    aFont.BackColor := BackColor;
    aFont.Index := Get_Index;
   end;//with l_Font
  finally
   aFont.Unlock;
  end;//try..finally
 finally
  Unlock;
 end;//try..finally
//#UC END# *46A6156000CD_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.Assign2Font

function Tl3CanvasPrim.HF: hFont;
//#UC START# *46A615A10333_4A4CB79A02C6_var*
//#UC END# *46A615A10333_4A4CB79A02C6_var*
begin
//#UC START# *46A615A10333_4A4CB79A02C6_impl*
 Result := VCLFont.Handle;
//#UC END# *46A615A10333_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.HF

function Tl3CanvasPrim.pxAverageCharWidth: Integer;
 {* средняя ширина символов контекста в пикселях. }
//#UC START# *4727432E0121_4A4CB79A02C6_var*
//#UC END# *4727432E0121_4A4CB79A02C6_var*
begin
//#UC START# *4727432E0121_4A4CB79A02C6_impl*
 if (f_pxAverageCharWidth = 0) then
  f_pxAverageCharWidth := TextMetrics^.tmAveCharWidth;
 Result := f_pxAverageCharWidth;
//#UC END# *4727432E0121_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.pxAverageCharWidth

function Tl3CanvasPrim.AverageCharWidth: Integer;
 {* средняя ширина символов контекста в дюймах. }
//#UC START# *472743420382_4A4CB79A02C6_var*
//#UC END# *472743420382_4A4CB79A02C6_var*
begin
//#UC START# *472743420382_4A4CB79A02C6_impl*
 if (f_AverageCharWidth = 0) then
  f_AverageCharWidth := DP2LP(l3SPoint(pxAverageCharWidth, 0)).X;
 Result := f_AverageCharWidth;
//#UC END# *472743420382_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.AverageCharWidth

function Tl3CanvasPrim.TextExtent(const S: Tl3WString;
 aNoTabs: Boolean = False): Tl3Point;
 {* возвращает длину строки текста в дюймах. }
//#UC START# *472744E803E3_4A4CB79A02C6_var*
var  
 l_Extent : TSize;

 procedure _TextExtent(const aSt: Tl3PCharLenPrim);
 
 var
  l_DC : hDC;

  function TabbedTextExtent: Bool;
  var
   l_TabLen: Integer;
   l_TabPos: Integer;
   l_S     : Tl3PCharLenPrim; // кусок текста до табуляции
   l_NS    : Tl3PCharLen; // следующий кусок текста
   l_Last  : Bool;
   l_E     : TSize; // размеры кусочка до табуляции
   l_TabStops: Il3TabStops;
   l_CurTab: Integer;
  begin//TabbedTextExtent
   Result := true;
   l_Extent.cX := 0;
   l_Extent.cY := TextMetrics^.tmHeight;
   l_S := aSt;
   l_TabPos := 0;
   if (f_TabStops <> nil) and f_TabStops.NeedCutByTab then
    l_TabStops := f_TabStops.Clone;
   repeat
    l_NS := l3FindChar(cc_Tab, l_S);
    l_Last := Tl3PCharLen(l_S).IsLast(cc_Tab);
    if l_Last then
     Dec(l_S.SLen);

    // "Рисуем" текст:
    if (l_TabStops <> nil) then
    begin
     l_TabLen := LP2DP(l3PointX(l_TabStops.Next.rPosition)).X;
     l_CurTab := l_TabLen - l_TabPos;
     l_TabPos := l_TabLen;
     SystemTextExtent(l_DC, l_S, l_E, f_LineSpacing);
     l_E.cx := Min(l_CurTab, l_E.cx);
    end//l_TabStops <> nil
    else
     SystemTextExtent(l_DC, l_S, l_E, f_LineSpacing);
    Inc(l_Extent.cX, l_E.cX);
    Inc(f_TabOffset, l_E.cX);
    l_Extent.cY := Max(l_Extent.cY, l_E.cY);

    if l_Last then
    begin
     // Рисуем знак табуляции:
     l_E.cX := GetTabWidth;
     Inc(l_Extent.cX, l_E.cX);
     Inc(f_TabOffset, l_E.cX);
    end;//l_Last..

    l_S := l_NS;
   until l3IsNil(l_NS);
  end;//TabbedTextExtent

 begin//_TextExtent
  l_DC := DC;
  if not aNoTabs AND (f_Tabs > 0) AND l3HasChar(cc_Tab, aSt) AND
     TabbedTextExtent then
   Exit;
  SystemTextExtent(l_DC, aSt, l_Extent, f_LineSpacing);
  {$IFDEF Nemesis}
  // ^ - проблема с позиционированием в тексте комментариев в Арчи, в частности [$118982332].
  if Get_Italic AND (aSt.SLen > 0) then
  // - пытаемся учитывать наклон шрифта - чтобы буквы не обрезались
  // http://mdp.garant.ru/pages/viewpage.action?pageId=109904426
   if not l3IsWhiteSpaceS(aSt, Pred(aSt.SLen)) then
    Inc(l_Extent.cX);
  {$ENDIF Nemesis}
 end;//_TextExtent

var
 l_Str : Tl3Str;
 l_Convert  : Tl3Str;
 l_St       : Tl3PCharLenPrim;
//#UC END# *472744E803E3_4A4CB79A02C6_var*
begin
//#UC START# *472744E803E3_4A4CB79A02C6_impl*
 if (f_PasswordChar <> #0) then
 begin
  l_Convert.Init(Tl3WString(S), CP_ANSI);
  l3FillChar(l_Convert.S^, l_Convert.SLen, Ord(f_PasswordChar));
  l_St := l_Convert;
 end//f_PasswordChar <> #0
 else
 begin
  l_Convert.Init;
  l_St := S;
 end;//f_PasswordChar <> #0
 try
  if (f_Font <> nil) then
  begin
   Tl3_Point(Result) := f_Font.FM.TextExtent(l_St);
   Exit;
  end;//f_Font <> nil
  l3FillChar(Result, SizeOf(Result));
  if not l3IsNil(l_St) then
  begin
   if (VCLFont.Pitch = fpFixed) then
   begin
    with TextMetrics^ do
    begin
     f_pxAverageCharWidth := tmAveCharWidth;
     Result := DP2LP(l3SPoint(f_pxAverageCharWidth * l_St.SLen, tmHeight));
    end;//with TextMetrics^
   end//VCLFont.Pitch = fpFixed
   else
   begin
    if (f_SuffixedFont AND (l_St.SCodePage = CP_ANSI)) OR
       // - закомментировано, т.к. неправильно работало с 'Arial', а не 'Arial CYR'
       (S.SCodePage = CP_Unicode) then begin
     _TextExtent(l_St);
     Result := DP2LP(l3SPoint(l_Extent.cX, l_Extent.cY));
    end//f_SuffixedFont..
    else
    begin
     l_Str.Init(l_St, CP_Unicode, @f_ConvertBuf);
     _TextExtent(l_Str);
     Result := DP2LP(l3SPoint(l_Extent.cX, l_Extent.cY));
    end;//f_SuffixedFont..
   end;//VCLFont.Pitch = fpFixed
  end;//S <> nil
 finally
  l_Convert.Clear;
 end;//try..finally
//#UC END# *472744E803E3_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.TextExtent

function Tl3CanvasPrim.Pos2Index(W: Integer;
 const S: Tl3PCharLen): Integer;
 {* находит индекс символа на рассоянии W дюймов от начала строки S. }
//#UC START# *472894A001A6_4A4CB79A02C6_var*
var
 TW    : Integer;
 l_S   : Tl3PCharLen;
 l_ACW : Integer;
//#UC END# *472894A001A6_4A4CB79A02C6_var*
begin
//#UC START# *472894A001A6_4A4CB79A02C6_impl*
 if (f_Font <> nil) then
 begin
  Result := f_Font.FM.Pos2Index(W, S);
  Exit;
 end;//f_Font <> nil
 Result := S.SLen;
 l_ACW := AverageCharWidth;
 if (f_Tabs > 0) OR (W < l_ACW * Result * 2) then
 begin
  TW := 0;
  Inc(W, l_ACW div 2);
  l_S := l3PCharLen(S.S, 1, S.SCodePage);
  while (Result > 0) do
  begin
   Inc(TW, TextExtent(l_S).X);
   if (TW < W) then
   begin
    Dec(Result);
    l_S.MoveS;
   end//TW < W
   else
    Break;
  end;//Result > 0
  Result := S.SLen - Result;
 end;//f_Tabs > 0.. 
//#UC END# *472894A001A6_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.Pos2Index

function Tl3CanvasPrim.Pos2IndexQ(W: Integer;
 const S: Tl3PCharLen;
 var aNoTabs: Boolean): Integer;
 {* находит индекс символа на рассоянии W дюймов от начала строки S. }
//#UC START# *472894BA0258_4A4CB79A02C6_var*
var
 l_Diff          : Long;
 l_S             : Tl3PCharLen;
 l_L             : Long;
 l_H             : Long;
 l_NeedResetTabs : Boolean;
 l_NoTabs        : Boolean;
//#UC END# *472894BA0258_4A4CB79A02C6_var*
begin
//#UC START# *472894BA0258_4A4CB79A02C6_impl*
 if (f_Font <> nil) then
 begin
  Result := f_Font.FM.Pos2Index(W, S);
  Exit;
 end;//f_Font <> nil
 if l3IsNil(S) OR (W <= 0) then
  Result := 0
 else
 begin
  Result := S.SLen;
  if (Result > 1) then
  begin
   l_NoTabs := aNoTabs OR ((f_Tabs <= 0) OR not l3HasChar(cc_Tab, S));
   aNoTabs := l_NoTabs;
   l_L := 0;
   l_H := Result;
   l_S := l3PCharLen(S.S, Result, S.SCodePage);
   {if (TextExtent(l_S, l_NoTabs).X < W) then
    Exit;}
   l_NeedResetTabs := not l_NoTabs AND (f_Tabs > 0) AND (f_TabStops <> nil);
   while (l_L <= l_H) do
   begin
    Result := (l_L + l_H) div 2;
    l_S.SLen := Result;
    l_Diff := W - TextExtent(l_S, l_NoTabs).X;
    if (Abs(l_Diff) < l3Epsilon {* 3}) then
     // - примерно нашли то, что искали
     break
    else
    if (l_Diff < 0) then
    begin
     // - надо уменьшать длину измеряемой строки
     l_H := Pred(Result);
     if (l_L = Succ(l_H)) then
      // - округляем в меньшую сторону
      Result := l_H;
    end//l_Diff < 0
    else
    if (l_Diff > 0) then
    begin
     // - надо увеличивать длину измеряемой строки
(*     if (Result = S.SLen - 1) then
     begin
      // - предыдущий символ нас не удовлетворил, значит искомая позиция - длина строки
      Inc(Result);
      break;
     end//Result = S.SLen - 1
     else*)
      l_L := Succ(Result);
    end;//l_Diff > 0
    if l_NeedResetTabs then
     f_TabStops.Reset;
   end;//while Result > 1
  end;//Result > 1..
 end;//l3IsNil(S)
//#UC END# *472894BA0258_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.Pos2IndexQ

function Tl3CanvasPrim.AverageCharHeight: Integer;
 {* средняя высота символов контекста в дюймах. }
//#UC START# *472894EA0166_4A4CB79A02C6_var*
//#UC END# *472894EA0166_4A4CB79A02C6_var*
begin
//#UC START# *472894EA0166_4A4CB79A02C6_impl*
 if (f_AverageCharHeight = 0) then
  f_AverageCharHeight := DP2LP(l3SPoint(0, ApplyLineSpacing(TextMetrics^.tmHeight, f_LineSpacing))).Y;
 Result := f_AverageCharHeight;
//#UC END# *472894EA0166_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.AverageCharHeight

function Tl3CanvasPrim.LP2DP(const P: Tl3_Point;
 NeedZoom: Boolean = False): Tl3SPoint;
 {* преобразует точку в дюймах в точку в пикселях. }
//#UC START# *4728950502EC_4A4CB79A02C6_var*
//#UC END# *4728950502EC_4A4CB79A02C6_var*
begin
//#UC START# *4728950502EC_4A4CB79A02C6_impl*
 Result.X := l3MulDiv(P.X, PixelsPerInchX, l3Inch);
 Result.Y := l3MulDiv(P.Y, PixelsPerInchY, l3Inch);
 if NeedZoom then
 begin
  BeginPaint;
  try
   LPtoDP(DC, Result, 1);
  finally
   EndPaint;
  end;//try..finally
 end;//NeedZoom
//#UC END# *4728950502EC_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.LP2DP

function Tl3CanvasPrim.LR2DR(const R: Tl3Rect): Tl3SRect;
 {* преобразует прямоугольник в дюймах в прямоугольник в пикселях. }
//#UC START# *472897C30237_4A4CB79A02C6_var*
//#UC END# *472897C30237_4A4CB79A02C6_var*
begin
//#UC START# *472897C30237_4A4CB79A02C6_impl*
 Result.TopLeft := LP2DP(R.TopLeft);
 Result.BottomRight := LP2DP(R.BottomRight);
//#UC END# *472897C30237_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.LR2DR

function Tl3CanvasPrim.DR2LR(const R: Tl3SRect): Tl3Rect;
 {* преобразует прямоугольник в пикселях в прямоугольник в дюймах. }
//#UC START# *472898020151_4A4CB79A02C6_var*
//#UC END# *472898020151_4A4CB79A02C6_var*
begin
//#UC START# *472898020151_4A4CB79A02C6_impl*
 Result.TopLeft := DP2LP(R.TopLeft);
 Result.BottomRight := DP2LP(R.BottomRight);
//#UC END# *472898020151_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DR2LR

procedure Tl3CanvasPrim.Lock;
 {* начать работу с канвой. }
//#UC START# *4728980E02AD_4A4CB79A02C6_var*
//#UC END# *4728980E02AD_4A4CB79A02C6_var*
begin
//#UC START# *4728980E02AD_4A4CB79A02C6_impl*
//#UC END# *4728980E02AD_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.Lock

procedure Tl3CanvasPrim.Unlock;
 {* закончить работу с канвой. }
//#UC START# *4728981C0054_4A4CB79A02C6_var*
//#UC END# *4728981C0054_4A4CB79A02C6_var*
begin
//#UC START# *4728981C0054_4A4CB79A02C6_impl*
//#UC END# *4728981C0054_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.Unlock

function Tl3CanvasPrim.GetKerning(const aSt: Tl3WString;
 Kerning: PLong): Tl3Point;
 {* получить размеры строки и таблицу кернинга. }
//#UC START# *47289B000379_4A4CB79A02C6_var*
 procedure _GetKerning(aDC: HDC; aBuff: PAnsiChar; aSize: Longint; aKerning: PLong; aSWidth: PLong); register;
 var
  Sz : TSize;
 asm
        push  esi
        push  edi
        push  ebx

        mov   ebx, eax

        mov   esi, aSWidth
        xor   eax, eax
        mov   [esi], eax

        jcxz  @@03

        mov   esi, edx
        mov   edi, aKerning

        lea   edx, Sz
        cld
       
  @@01: push  ecx
        push  edx

        push  edx
        xor   eax, eax
        inc   eax
        push  eax
        push  esi
        push  ebx
        call  GetTextExtentPoint32A

        pop   edx
        pop   ecx

        or    eax, eax
        jz    @@02

        mov   eax, [edx]

  @@02: stosd

        push  esi
        mov   esi, aSWidth

        add   [esi], eax

        pop   esi
        inc   esi

        loop  @@01

  @@03:
        pop   ebx
        pop   edi
        pop   esi
 end;//_GetKerning

 procedure _GetKerningW(aDC: HDC; aBuff: pWideChar; aSize: Longint; aKerning: PLong; aSWidth: PLong); register;
 var
  Sz : TSize;
 asm
        push  esi
        push  edi
        push  ebx

        mov   ebx, eax

        mov   esi, aSWidth
        xor   eax, eax
        mov   [esi], eax

        jcxz  @@03

        mov   esi, edx
        mov   edi, aKerning

        lea   edx, Sz
        cld
       
  @@01: push  ecx
        push  edx

        push  edx
        xor   eax, eax
        inc   eax
        push  eax
        push  esi
        push  ebx
        call  GetTextExtentPoint32W

        pop   edx
        pop   ecx

        or    eax, eax
        jz    @@02

        mov   eax, [edx]

  @@02: stosd

        push  esi
        mov   esi, aSWidth

        add   [esi], eax

        pop   esi
        add   esi, 2 // увеличиваем на два байта так как это Unicode

        loop  @@01

  @@03:
        pop   ebx
        pop   edi
        pop   esi
 end;//_GetKerningW

var
 l_DC : hDC;
 theExtent : Tl3Point absolute Result;

 procedure __GetKerning(const aSt: Tl3PCharLenPrim);

  function TabbedKerning: Bool;
  var
   l_TabLen: Integer;
   l_TabPos: Integer;
   I: Integer;
   l_S     : Tl3PCharLenPrim;
   l_NS    : Tl3PCharLen;
   l_Last  : Bool;
   l_Width : Long;
   l_TabStops: Il3TabStops;
   l_CurTab, l_TabField: Integer;
   l_TabKerning : PLong;
  begin//TabbedKerning
   Result := true;
   l_S := aSt;
   l_TabPos := 0;
   l_TabStops := nil;
   if (f_TabStops <> nil) and (f_TabStops.NeedCutByTab) then
    l_TabStops := f_TabStops.Clone;
   repeat
    l_NS := l3FindChar(cc_Tab, l_S);
    l_Last := Tl3PCharLen(l_S).IsLast(cc_Tab);
    if l_Last then
     Dec(l_S.SLen);

    // "Рисуем" текст:
    if (l_S.SCodePage = CP_Unicode) then
     _GetKerningW(l_DC, PWideChar(l_S.S), l_S.SLen, Kerning, @l_Width)
    else
     _GetKerning(l_DC, l_S.S, l_S.SLen, Kerning, @l_Width);
    if l_TabStops <> nil then
    begin
     l_TabLen := LP2DP(l3PointX(l_TabStops.Next.rPosition)).X;
     l_CurTab := l_TabLen - l_TabPos;
     l_TabPos := l_TabLen;
     if l_CurTab < l_Width then
     begin
      l_TabKerning := Kerning;
      l_TabField := l_CurTab;
      for I := 1 to l_S.SLen do
      begin
       if l_TabField > l_TabKerning^ then
        Dec(l_TabField, l_TabKerning^)
       else
       begin
        l_TabKerning^ := l_TabField;
        l_TabField := 0;
       end;
       Inc(l_TabKerning);
      end;
      l_Width := l_CurTab;
     end;
     
    end;
    Inc(theExtent.P.X, l_Width);
    Inc(f_TabOffset, l_Width);
    Inc(Kerning, l_S.SLen);

    if (l_TabStops = nil) and l_Last then
    begin
     // Рисуем знак табуляции:
     l_Width := GetTabWidth;
     Kerning^ := l_Width;
     Inc(theExtent.P.X, l_Width);
     Inc(f_TabOffset, l_Width);
     Inc(Kerning);
    end;//l_Last

    l_S := l_NS;
   until l3IsNil(l_NS);
  end;//TabbedKerning

 begin//__GetKerning
  if l3IsNil(aSt) then
   Exit;
  if (f_Tabs > 0) AND l3HasChar(cc_Tab, aSt) AND
     TabbedKerning then
   Exit;
  if (aSt.SCodePage = CP_ANSI) then
   _GetKerning(l_DC, aSt.S, aSt.SLen, Kerning, @theExtent.X)
  else
   _GetKerningW(l_DC, PWideChar(aSt.S), aSt.SLen, Kerning, @theExtent.X);
  if Get_Italic AND (aSt.SLen > 0) then
  // - пытаемся учитывать наклон шрифта - чтобы буквы не обрезались
  begin
   if not l3IsWhiteSpaceS(aSt, Pred(aSt.SLen)) then
   begin
    if ((Win32Platform <> VER_PLATFORM_WIN32_NT) OR (Win32MajorVersion < 6)) then
     // - для тех кто меньше Vista правим массив кернинга
     Inc(PLong(PAnsiChar(Kerning) + Pred(aSt.SLen) * SizeOf(Long))^);
    Inc(theExtent.P.X);
   end;//not l3IsWhiteSpaceS
  end;//Get_Italic
 end;//__GetKerning

var
 ACW   : Long;
 l_Str : Tl3Str;
 l_St  : Tl3PCharLenPrim;
 l_Convert  : Tl3Str;
 l_Fixed    : Boolean;
//#UC END# *47289B000379_4A4CB79A02C6_var*
begin
//#UC START# *47289B000379_4A4CB79A02C6_impl*
 l_St := aSt;
 if (f_PasswordChar <> #0) then
 begin
  l_Convert.Init(Tl3WString(l_St), CP_ANSI);
  l3FillChar(l_Convert.S^, l_Convert.SLen, Ord(f_PasswordChar));
  l_St := l_Convert;
 end//f_PasswordChar <> #0
 else
  l_Convert.Init;
 try
  if (f_Font <> nil) then
  begin
   Tl3_Point(theExtent) := f_Font.FM.TextExtent(l_St);
   ACW := LP2DP(l3PointX(theExtent.X)).X;
   l3FillStruct(Kerning^, l_St.SLen, ACW, SizeOf(ACW));
   Exit;
  end;//f_Font <> nil
  l_DC := DC;
  with TextMetrics^ do
  begin
   f_pxAverageCharWidth := tmAveCharWidth;
   theExtent.X := 0;
   theExtent.Y := tmHeight;
   l_Fixed := not
              // http://mdp.garant.ru/pages/viewpage.action?pageId=296632270&focusedCommentId=296633958#comment-296633958
              Bool(tmPitchAndFamily AND TMPF_FIXED_PITCH) OR
              (VCLFont.Pitch = fpFixed)
              // - оказывается, что "бывает" Arial и Fixed - для Preformatted-параграфов
              // http://mdp.garant.ru/pages/viewpage.action?pageId=296632270
              ;
   if not l_Fixed then
    theExtent.Y := ApplyLineSpacing(theExtent.Y, f_LineSpacing);
   if (f_Tabs > 0) OR not l_Fixed then
   begin
    if (f_SuffixedFont AND (l_St.SCodePage = CP_ANSI)) OR
       // - закомментировано, т.к. неправильно работало с 'Arial', а не 'Arial CYR'
       (l_St.SCodePage = CP_Unicode) then
     __GetKerning(l_St)
    else
    begin
     l_Str.Init(l_St, CP_Unicode, @f_ConvertBuf);
     __GetKerning(l_Str);
    end;//f_SuffixedFont..
   end//f_Tabs > 0
   else
   begin
    ACW := tmAveCharWidth;
    l3FillStruct(Kerning^, l_St.SLen, ACW, SizeOf(ACW));
    theExtent.X := ACW * l_St.SLen;
   end;//f_Tabs > 0
  end;//with TextMetrics^
  theExtent := DP2LP(Tl3SPoint(theExtent));
 finally
  l_Convert.Clear;
 end;//try..finally
//#UC END# *47289B000379_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.GetKerning

function Tl3CanvasPrim.OffsetRgn(const Rgn: Il3Region;
 const Pt: Tl3Point): Integer;
 {* сдвинуть регион. }
//#UC START# *4728A0840026_4A4CB79A02C6_var*
//#UC END# *4728A0840026_4A4CB79A02C6_var*
begin
//#UC START# *4728A0840026_4A4CB79A02C6_impl*
 if (Rgn = nil) then
  Result := Windows.NULLREGION
 else
  Result := Rgn.Offset(LP2DP(Pt));
//#UC END# *4728A0840026_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.OffsetRgn

function Tl3CanvasPrim.CaretExtent: Tl3Point;
 {* размеры курсора. }
//#UC START# *4728A0C40082_4A4CB79A02C6_var*
//#UC END# *4728A0C40082_4A4CB79A02C6_var*
begin
//#UC START# *4728A0C40082_4A4CB79A02C6_impl*
 with TextMetrics^ do
 begin
  f_pxAverageCharWidth := tmAveCharWidth;
  Result := DP2LP(l3SPoint(f_pxAverageCharWidth, tmHeight));
 end;//with TextMetrics^
//#UC END# *4728A0C40082_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.CaretExtent

procedure Tl3CanvasPrim.StartTabs(out theTabInfo: Il3TabInfo;
 const aTabStops: Il3TabStops;
 aTabOffset: Integer = 0);
//#UC START# *4728A4A703CC_4A4CB79A02C6_var*
//#UC END# *4728A4A703CC_4A4CB79A02C6_var*
begin
//#UC START# *4728A4A703CC_4A4CB79A02C6_impl*
 theTabInfo := TabInfo;
 {$IfDef l3NeedTabbedText}
 Inc(f_Tabs);
 {$EndIf l3NeedTabbedText}
 f_TabOffset := LP2DP(l3PointX(aTabOffset)).X;
 f_TabStops := aTabStops;
//#UC END# *4728A4A703CC_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.StartTabs

procedure Tl3CanvasPrim.StartTabs(out theTabInfo: Il3TabInfo;
 const aTabInfo: Il3TabInfo);
//#UC START# *4728A4D00013_4A4CB79A02C6_var*
//#UC END# *4728A4D00013_4A4CB79A02C6_var*
begin
//#UC START# *4728A4D00013_4A4CB79A02C6_impl*
 theTabInfo := TabInfo;
 {$IfDef l3NeedTabbedText}
 Inc(f_Tabs);
 {$EndIf l3NeedTabbedText}
 RestoreTabInfo(aTabInfo);
//#UC END# *4728A4D00013_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.StartTabs

procedure Tl3CanvasPrim.FinishTabs(var aTabInfo: Il3TabInfo);
//#UC START# *4728A4DF0065_4A4CB79A02C6_var*
//#UC END# *4728A4DF0065_4A4CB79A02C6_var*
begin
//#UC START# *4728A4DF0065_4A4CB79A02C6_impl*
 {$IfDef l3NeedTabbedText}
 Dec(f_Tabs);
 {$EndIf l3NeedTabbedText}
 RestoreTabInfo(aTabInfo);
 aTabInfo := nil; // - чтобы никто больше не воспользовался
//#UC END# *4728A4DF0065_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.FinishTabs

function Tl3CanvasPrim.TabInfo: Il3TabInfo;
//#UC START# *4728A4F602FD_4A4CB79A02C6_var*
//#UC END# *4728A4F602FD_4A4CB79A02C6_var*
begin
//#UC START# *4728A4F602FD_4A4CB79A02C6_impl*
 if (f_Tabs > 0) then
  Result := Tl3TabInfo.Make(TabOffset, f_TabStops)
 else
  Result := nil;
//#UC END# *4728A4F602FD_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.TabInfo

function Tl3CanvasPrim.EQ(const aCanvas: Il3InfoCanvas): Boolean;
//#UC START# *4728A509016A_4A4CB79A02C6_var*
const
 cInchPoint : Tl3Point = (P : (X: l3Inch; Y: l3Inch));
//#UC END# *4728A509016A_4A4CB79A02C6_var*
begin
//#UC START# *4728A509016A_4A4CB79A02C6_impl*
 Result := l3IEQ(Self, aCanvas) OR ((Zoom = aCanvas.Zoom) AND LP2DP(cInchPoint).EQ(aCanvas.LP2DP(cInchPoint)));
//#UC END# *4728A509016A_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.EQ

function Tl3CanvasPrim.NearestColor(C: Tl3Color): Tl3Color;
//#UC START# *4728A52B0385_4A4CB79A02C6_var*
var
 l_ICN: Il3InfoCanvas;
//#UC END# *4728A52B0385_4A4CB79A02C6_var*
begin
//#UC START# *4728A52B0385_4A4CB79A02C6_impl*
 l_ICN := l3CrtIC;
 l_ICN.Lock;
 try
  Result := Windows.GetNearestColor(l_ICN.DC, ColorToRGB(C));
 finally
  l_ICN.Unlock;
 end;//try..finally
//#UC END# *4728A52B0385_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.NearestColor

function Tl3CanvasPrim.DrawText(const aSt: Tl3WString;
 var R: TRect;
 aFormat: Cardinal;
 AFl: TObject = nil): Il3MultiLines;
 {* как ни глупо звучит, но это нужно на информационной канве, т.к. она вычисляет прямоугольник вывода. }
//#UC START# *4728A74F03A2_4A4CB79A02C6_var*
 procedure _DrawText(const aSt: Tl3PCharLenPrim);

  procedure _CalcRect;
  var
   l_SingleLine : Boolean;

   procedure SetResult(const aPoint : Tl3Point);
   begin//SetResult
    with LP2DP(aPoint) do
    begin
     //if l_SingleLine then
      R.Right := R.Left + X;
     R.Bottom := R.Top + Y;
    end;
   end;//SetResult

  var
   l_FL    : Tl3FormattedLines;
   l_R     : Tl3Rect;
   l_Point : Tl3Point;
   l_Max   : Integer;
   l_Index : Integer;
   l_StrArr : TevBaseLineArray;
   l_OldFont: HFONT;
  begin//_CalcRect
   l_OldFont := SelectObject(DC, VCLFont.Handle); // http://mdp.garant.ru/pages/viewpage.action?pageId=344135978
   try
    l_SingleLine := (aFormat and DT_SINGLELINE = DT_SINGLELINE) or
     (R.Right - R.Left = 0) or not (aFormat and DT_WORDBREAK = DT_WORDBREAK);
    // Посчитаем для однострочного
    if l_SingleLine then
    begin
     if (AFl = nil) then
     begin
      l_FL := Tl3FormattedLines.Create;
      try
       Result := l_FL;
      finally
       l3Free(l_FL);
      end;//try..finally
     end//AFl = nil
     else
      Result := AFl as Tl3FormattedLines;
     SetResult(TextExtent(aSt));
     // K-109086173
     if (aFormat and DT_END_ELLIPSIS = DT_END_ELLIPSIS) and (fsBold in Get_Style) then
      Inc(R.Right, 3);
    end//l_SingleLine
    // Посчитаем для многострочного
    else
    begin
     if AFl = nil then
      l_FL := Tl3FormattedLines.Create
     else
      l_FL := AFl as Tl3FormattedLines;
     try
      // Переведем в дюймы
      l_R := DR2LR(l3SRect(R));
      // Разбиваем
      l_Point.Y := l_FL.FormatLine(Self, 0, aSt, l_R.R.Right - l_R.R.Left);
      l_SingleLine := l_FL.IsSingle;
      if l_SingleLine then
       l_Point.X := TextExtent(aSt).X
      else
      begin
       l_Max := 0; l_StrArr := TevBaseLineArray(l_FL.First);
       for l_Index := 1 to l_StrArr.Count do
        l_Max := Max(l_Max, l_StrArr.LineWidth[l_Index]);
       l_Point.X := l_Max; //Если просто сделать l_R.Right - l_R.Left, то
       //может получиться hint с запасом.
      end;
      SetResult(l_Point);
      Inc(R.Right, 3);
      Result := l_FL;
     finally
      if AFl = nil then
       l3Free(l_FL);
     end;//try..finally
    end;//l_SingleLine
   finally
    SelectObject(DC, l_OldFont);
   end;
  end;//_CalcRect

  procedure _DrawWordBreak;
  var
   l_FL     : Tl3FormattedLines;
   l_Index  : Integer;
   l_R      : Tl3Rect;
   l_StrArr : TevBaseLineArray;
   l_H      : Integer;
  begin//_DrawWordBreak
   if AFl = nil then
     l_FL := Tl3FormattedLines.Create
   else
     l_FL := AFl as Tl3FormattedLines;
   try
    // Пересчитаем в дюймы
    l_R := DR2LR(l3SRect(R));
    // Разобъем на строки
    if (AFl = nil) then
     l_H := l_FL.FormatLine(Self, 0, aSt, l_R.R.Right - l_R.R.Left)
    else
     l_H := 0;
    if (aFormat and DT_VCENTER = DT_VCENTER) then
     l_R.Top := (l_R.Bottom + l_R.Top - l_H) div 2;
    l_StrArr := TevBaseLineArray(l_FL.First);
    // Текст многострочный
    if (l_StrArr <> nil) then
    begin
     for l_Index := 1 to l_StrArr.Count do
     begin
      // Нижняя граница
      l_R.R.Bottom := l_R.R.Top + l_StrArr.LineHeight[l_Index];
      // Покажем
      if (aFormat and DT_RIGHT) > 0 then
       ExtTextOut(l_R.TopLeft, l_R, l_StrArr.GetLine(aSt, l_Index), l3_tffRight)
      else
      if (aFormat and DT_CENTER) > 0 then
       ExtTextOut(l_R.TopLeft, l_R, l_StrArr.GetLine(aSt, l_Index), l3_tffCenter)
      else
       ExtTextOut(l_R.TopLeft, l_R, l_StrArr.GetLine(aSt, l_Index), l3_tffLeft);
      // Следущая строка
      Inc(l_R.R.Top, l_StrArr.LineHeight[l_Index]);
     end//for l_Index
    end//l_StrArr <> nil
    // Текст однострочный, просто выводим
    else
    begin
     if (aFormat and DT_RIGHT) > 0 then
      ExtTextOut(l_R.TopLeft, l_R, aSt, l3_tffRight)
     else
     if (aFormat and DT_CENTER) > 0 then
      ExtTextOut(l_R.TopLeft, l_R, aSt, l3_tffCenter)
     else
      ExtTextOut(l_R.TopLeft, l_R, aSt, l3_tffLeft);
    end;//l_StrArr <> nil
    Result := l_FL;
   finally
    if AFl = nil then
      l3Free(l_FL);
   end;//try..finally
  end;//_DrawWordBreak

 var
  l_S  : Tl3Str;
  l_Pt : Tl3SPoint;
 begin//_DrawText
  // Вычислить область вывода
  if (aFormat and DT_CALCRECT = DT_CALCRECT) then
  begin
   _CalcRect;
   Exit;
  end;//DT_CALCRECT
  // Вывести многострочный
  if (aFormat and DT_WORDBREAK = DT_WORDBREAK) and
   not (aFormat and DT_CALCRECT = DT_CALCRECT) then
  begin
   _DrawWordBreak;
   Exit;
  end;//DT_WORDBREAK
  if not ((aFormat and DT_END_ELLIPSIS = DT_END_ELLIPSIS) OR
     (aFormat and DT_PATH_ELLIPSIS = DT_PATH_ELLIPSIS)) then
   // - не надо рисовать многоточия - обойдемся без помощи Windows
  begin
   l_Pt := l3SPoint0;
   if (aFormat and DT_VCENTER = DT_VCENTER) AND not l3IsNil(aSt) then
   begin
    l_Pt := LP2DP(TextExtent(aSt), true);
    l_Pt.X := R.Left;
    l_Pt.Y := ((R.Bottom + R.Top - l_Pt.Y) div 2); 
   end//DT_CALCRECT
   else
    l_Pt := Tl3SPoint(R.TopLeft);
   if (aFormat and DT_RIGHT) > 0 then
    ExtTextOut(l_Pt, l3SRect(R), aSt, l3_tffRight)
   else
   if (aFormat and DT_CENTER) > 0 then
    ExtTextOut(l_Pt, l3SRect(R), aSt, l3_tffCenter)
   else
    ExtTextOut(l_Pt, l3SRect(R), aSt, l3_tffLeft);
   Exit;
  end;//DT_END_ELLIPSIS..
  if (aSt.SCodePage = CP_ANSI) then
   {Result := }Windows.DrawTextA(DC, aSt.S, aSt.SLen, R, aFormat)
  else
  if (Win32Platform = VER_PLATFORM_WIN32_NT) then
   {Result := }Windows.DrawTextW(DC, PWideChar(aSt.S), aSt.SLen, R, aFormat)
  else
  begin
   l_S.Init(aSt, CP_ANSI);
   try
    {Result := }Windows.DrawTextA(DC, l_S.S, l_S.SLen, R, aFormat);
   finally
    l_S.Clear;
   end;//try..finally
  end;//Win32Platform = VER_PLATFORM_WIN32_NT
 end;//_DrawText

var
 l_Str : Tl3Str;
//#UC END# *4728A74F03A2_4A4CB79A02C6_var*
begin
//#UC START# *4728A74F03A2_4A4CB79A02C6_impl*
 if (f_SuffixedFont AND (aSt.SCodePage = CP_ANSI)) OR
    // - закомментировано, т.к. неправильно работало с 'Arial', а не 'Arial CYR'
    (aSt.SCodePage = CP_Unicode) then
  _DrawText(aSt)
 else
 begin
  l_Str.Init(aSt, CP_Unicode, @f_ConvertBuf);
  _DrawText(l_Str);
 end;//f_SuffixedFont
//#UC END# *4728A74F03A2_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DrawText

procedure Tl3CanvasPrim.TabbedMultilineTextOut(const aSt: Tl3WString;
 const Tabs: Il3TabStops;
 var Rect: Tl3Rect;
 Precalculate: Boolean;
 aGap: Integer);
 {* как ни глупо звучит, но это нужно на информационной канве, т.к. она вычисляет прямоугольник вывода. }
//#UC START# *4728A7BC0330_4A4CB79A02C6_var*
var
 l_Right    : Integer;
 l_HalfGap  : Integer;
 l_IsFirst  : Boolean;
 MaxH       : Integer;
 lTabs      : Il3TabStops;
 CR         : Tl3SRect;
 RT         : TRect;
 lFlags     : Cardinal;
 l_NS       : Tl3PCharLen;
 l_S        : Tl3PCharLen;
 l_Last     : Boolean;
 l_FirstPos : Integer;
//#UC END# *4728A7BC0330_4A4CB79A02C6_var*
begin
//#UC START# *4728A7BC0330_4A4CB79A02C6_impl*
 CR := WO(Rect);
 RT := CR.R.WR;

 // Это заплатка. Дело в том, что в Rect сюда передается MaxInt, который после
 // преобразований становится совсем не MaxInt, в результате чего он не обнуляется
 // в Tl3Canvas.DP2LP и все с грохотом валится в l3MulDiv с переполнением целого.
 // Наверное, надо это сделать как-нибудь поизящней, но не придумалось как.
 if Rect.BottomRight.Y = MaxInt then
  RT.BottomRight.Y := MaxInt;

 lTabs := Tabs.Clone;
 RT.Right := RT.Left;
 lFlags := DT_LEFT or DT_WORDBREAK or DT_NOPREFIX;
 if Precalculate then
  lFlags := lFlags or DT_CALCRECT;
 MaxH := 0;
 Tl3PCharLenPrim(l_S) := aSt;
 l_IsFirst := True;
 l_FirstPos := RT.Left;
 l_HalfGap := aGap div 2;
 repeat
  l_NS := l3FindChar(cc_Tab, l_S);
  l_Last := l_S.IsLast(cc_Tab);
  if l_Last then
   Dec(l_S.SLen);
  RT.Left := RT.Right;
  if not l_IsFirst then
  begin
   RT.Left := RT.Left + aGap;
   RT.Right := l_FirstPos + LP2DP(l3PointX(lTabs.Next.rPosition)).X - l_HalfGap;
  end
  else
  begin
   l_IsFirst := False;
   RT.Right := RT.Right + LP2DP(l3PointX(lTabs.Next.rPosition)).X - l_HalfGap;
  end;//not l_IsFirst
  if Precalculate then
  begin
   RT.Bottom := MaxInt;
   l_Right := RT.Right;
   DrawText(l_S, RT, lFlags);
   RT.Right := l_Right; // правую сторону при подсчете мы не считаем
  end//Precalculate
  else
   DrawText(l_S, RT, lFlags);
  if MaxH < RT.Bottom-RT.Top then
   MaxH := RT.Bottom-RT.Top;
  l_S := l_NS;
 until l3IsNil(l_NS);
 CR.R.Bottom := CR.R.Top + MaxH;
 Rect := DR2LR(CR);
//#UC END# *4728A7BC0330_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.TabbedMultilineTextOut

procedure Tl3CanvasPrim.PushBC;
//#UC START# *4728AD37017F_4A4CB79A02C6_var*
//#UC END# *4728AD37017F_4A4CB79A02C6_var*
begin
//#UC START# *4728AD37017F_4A4CB79A02C6_impl*
 if (f_BCs = nil) then
  f_BCs := Tl3LongintList.Make;
 f_BCs.Add(BackColor);
//#UC END# *4728AD37017F_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.PushBC

function Tl3CanvasPrim.TopBC: Tl3Color;
//#UC START# *4728AD43021C_4A4CB79A02C6_var*
//#UC END# *4728AD43021C_4A4CB79A02C6_var*
begin
//#UC START# *4728AD43021C_4A4CB79A02C6_impl*
 if (f_BCs = nil) OR f_BCs.Empty then
  Result := BackColor
 else
  Result := f_BCs.Last;
//#UC END# *4728AD43021C_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.TopBC

procedure Tl3CanvasPrim.PopBC;
//#UC START# *4728AD580263_4A4CB79A02C6_var*
//#UC END# *4728AD580263_4A4CB79A02C6_var*
begin
//#UC START# *4728AD580263_4A4CB79A02C6_impl*
 with f_BCs do
  BackColor := TColor(Delete(Hi));
//#UC END# *4728AD580263_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.PopBC

procedure Tl3CanvasPrim.PushFC;
//#UC START# *4728AD680067_4A4CB79A02C6_var*
//#UC END# *4728AD680067_4A4CB79A02C6_var*
begin
//#UC START# *4728AD680067_4A4CB79A02C6_impl*
 if (f_FCs = nil) then
  f_FCs := Tl3LongintList.Make;
 f_FCs.Add(TextColor);
//#UC END# *4728AD680067_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.PushFC

procedure Tl3CanvasPrim.PopFC;
//#UC START# *4728AD760338_4A4CB79A02C6_var*
//#UC END# *4728AD760338_4A4CB79A02C6_var*
begin
//#UC START# *4728AD760338_4A4CB79A02C6_impl*
 with f_FCs do
  TextColor := TColor(Delete(Hi));
//#UC END# *4728AD760338_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.PopFC

function Tl3CanvasPrim.TextMetrics: PTextMetric;
//#UC START# *4728ADF50313_4A4CB79A02C6_var*
//#UC END# *4728ADF50313_4A4CB79A02C6_var*
begin
//#UC START# *4728ADF50313_4A4CB79A02C6_impl*
 Result := @f_TextMetrics;
 if f_TextMetricsValid then
  Exit;
 GetTextMetrics(DC, f_TextMetrics);
 f_TextMetricsValid := true;
//#UC END# *4728ADF50313_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.TextMetrics

function Tl3CanvasPrim.Get_Font: Il3Font;
//#UC START# *4728AE20030A_4A4CB79A02C6get_var*
//#UC END# *4728AE20030A_4A4CB79A02C6get_var*
begin
//#UC START# *4728AE20030A_4A4CB79A02C6get_impl*
 Result := Self;
//#UC END# *4728AE20030A_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_Font

procedure Tl3CanvasPrim.Set_Font(const aValue: Il3Font);
//#UC START# *4728AE20030A_4A4CB79A02C6set_var*
//#UC END# *4728AE20030A_4A4CB79A02C6set_var*
begin
//#UC START# *4728AE20030A_4A4CB79A02C6set_impl*
 Assert(aValue <> nil);
 if aValue.IsAtomic then
  f_Font := aValue
 else
 begin
  f_Font := nil;
  Lock;
  try
   aValue.Lock;
   try
    aValue.Assign2Font(Self);
   finally
    aValue.Unlock;
   end;//try..finally
  finally
   Unlock;
  end;//try..finally
 end;//Value.IsAtomic
//#UC END# *4728AE20030A_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.Set_Font

function Tl3CanvasPrim.pm_GetDC: hDC;
//#UC START# *4728AE3E03B8_4A4CB79A02C6get_var*
//#UC END# *4728AE3E03B8_4A4CB79A02C6get_var*
begin
//#UC START# *4728AE3E03B8_4A4CB79A02C6get_impl*
 CheckDrawing;
 Result := HDC(f_DC);
//#UC END# *4728AE3E03B8_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetDC

procedure Tl3CanvasPrim.pm_SetDC(aValue: hDC);
//#UC START# *4728AE3E03B8_4A4CB79A02C6set_var*
//#UC END# *4728AE3E03B8_4A4CB79A02C6set_var*
begin
//#UC START# *4728AE3E03B8_4A4CB79A02C6set_impl*
 if (aValue = 0) then
  SetDC(0, ev_dcfGot)
 else
 begin
  f_WindowOrgInited := false;
  SetDC(aValue, ev_dcfLinked);
  f_InitialDCOffset := WindowOrg;
  if (f_InitialDCOffset.X <> 0) or (f_InitialDCOffset.Y <> 0) then
   f_InitialDCOffsetStored := f_InitialDCOffset;
 end;//aValue = 0
 { TODO -oЛюлин А. В. -cНедоделка : Это заточка для WinControl - другие не должны пользоваться этим методом. } 
//#UC END# *4728AE3E03B8_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetDC

function Tl3CanvasPrim.pm_GetPixelsPerInchX: Integer;
//#UC START# *4728AE5D020E_4A4CB79A02C6get_var*
//#UC END# *4728AE5D020E_4A4CB79A02C6get_var*
begin
//#UC START# *4728AE5D020E_4A4CB79A02C6get_impl*
 Result := f_PixelsPerInchX;
 if (Result = 0) then 
 begin
  f_PixelsPerInchX := DeviceCaps(LOGPIXELSX);
  Result := f_PixelsPerInchX;
 end;
//#UC END# *4728AE5D020E_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetPixelsPerInchX

function Tl3CanvasPrim.pm_GetPixelsPerInchY: Integer;
//#UC START# *4728AE6A01EE_4A4CB79A02C6get_var*
//#UC END# *4728AE6A01EE_4A4CB79A02C6get_var*
begin
//#UC START# *4728AE6A01EE_4A4CB79A02C6get_impl*
 Result := f_PixelsPerInchY;
 if (Result = 0) then
 begin
  f_PixelsPerInchY := DeviceCaps(LOGPIXELSY);
  Result := f_PixelsPerInchY;
 end;//Result = 0
//#UC END# *4728AE6A01EE_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetPixelsPerInchY

procedure Tl3CanvasPrim.MoveWindowOrg(const Delta: Tl3Point);
//#UC START# *4728AEC301D8_4A4CB79A02C6_var*
var
 l_Pt : Tl3SPoint;
 l_DC : hDC;
//#UC END# *4728AEC301D8_4A4CB79A02C6_var*
begin
//#UC START# *4728AEC301D8_4A4CB79A02C6_impl*
 if not Delta.EQ(l3Point0) then
 begin
  l_DC := DC;
  if (l_DC = 0) then
  begin
   f_WindowOrg := f_WindowOrg.Add(Delta);
   f_WindowOrgInited := true;
  end//l_DC = 0
  else
  begin
   GetWindowOrgEx(l_DC, TPoint(l_Pt));
   l_Pt.Inc(LP2DP(Delta));
   SetWindowOrgEx(l_DC, l_Pt.X, l_Pt.Y, nil);
   f_WindowOrg := DP2LP(l_Pt);
   f_WindowOrgInited := true;
  end;//l_DC = 0
  RecordRegionBottomPrim(LP2DP(f_WindowOrg).Neg);
 end;//not Delta.EQ(l3Point0)
//#UC END# *4728AEC301D8_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.MoveWindowOrg

procedure Tl3CanvasPrim.MoveWindowOrg(const Delta: Tl3SPoint);
//#UC START# *4728AECD010B_4A4CB79A02C6_var*
var
 l_Pt : Tl3SPoint;
 l_DC : hDC;
//#UC END# *4728AECD010B_4A4CB79A02C6_var*
begin
//#UC START# *4728AECD010B_4A4CB79A02C6_impl*
 if not Delta.EQ(l3SPoint0) then
 begin
  l_DC := DC;
  if (l_DC = 0) then
  begin
   f_WindowOrg := f_WindowOrg.Add(DP2LP(Delta));
   f_WindowOrgInited := true;
   RecordRegionBottomPrim(LP2DP(f_WindowOrg).Neg);
  end//l_DC = 0
  else
  begin
   GetWindowOrgEx(l_DC, TPoint(l_Pt));
   l_Pt.Inc(Delta);
   SetWindowOrgEx(l_DC, l_Pt.X, l_Pt.Y, nil);
   f_WindowOrg := DP2LP(l_Pt);
   f_WindowOrgInited := true;
   RecordRegionBottomPrim(l_Pt.Neg);
  end;//l_DC = 0
 end;//not Delta.EQ(l3SPoint0)
//#UC END# *4728AECD010B_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.MoveWindowOrg

procedure Tl3CanvasPrim.FillForeRect(const R: Tl3SRect);
//#UC START# *4728AED70336_4A4CB79A02C6_var*
//#UC END# *4728AED70336_4A4CB79A02C6_var*
begin
//#UC START# *4728AED70336_4A4CB79A02C6_impl*
 DoFillForeRect(R);
//#UC END# *4728AED70336_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.FillForeRect

procedure Tl3CanvasPrim.FillRect(const R: Tl3SRect);
//#UC START# *4728AF3E03AC_4A4CB79A02C6_var*
//#UC END# *4728AF3E03AC_4A4CB79A02C6_var*
begin
//#UC START# *4728AF3E03AC_4A4CB79A02C6_impl*
 if DrawingIsValid then
 begin
  CheckColors;
  FillRectPrim(l3IntersectRect(R, LR2DR(ClipRect)).R.WR);
 end;//DrawingIsValid
 AddRect(R);
//#UC END# *4728AF3E03AC_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.FillRect

procedure Tl3CanvasPrim.FillRect(const R: Tl3Rect);
//#UC START# *4728AF5103A9_4A4CB79A02C6_var*
//#UC END# *4728AF5103A9_4A4CB79A02C6_var*
begin
//#UC START# *4728AF5103A9_4A4CB79A02C6_impl*
 if DrawingIsValid then
 begin
  CheckColors;
  FillRectPrim(WO(l3IntersectRect(R, ClipRect)).R.WR);
 end;//DrawingIsValid
 AddRect(WO(R));
//#UC END# *4728AF5103A9_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.FillRect

procedure Tl3CanvasPrim.FillEmptyRect(const R: Tl3Rect);
//#UC START# *4728B590009B_4A4CB79A02C6_var*
//#UC END# *4728B590009B_4A4CB79A02C6_var*
begin
//#UC START# *4728B590009B_4A4CB79A02C6_impl*
 DoFillEmptyRect(R);
//#UC END# *4728B590009B_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.FillEmptyRect

procedure Tl3CanvasPrim.FillEmptyRect(const R: Tl3SRect);
//#UC START# *4728B59A000A_4A4CB79A02C6_var*
//#UC END# *4728B59A000A_4A4CB79A02C6_var*
begin
//#UC START# *4728B59A000A_4A4CB79A02C6_impl*
 DoFillEmptyRect(R);
//#UC END# *4728B59A000A_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.FillEmptyRect

function Tl3CanvasPrim.FillRgn(const Region: Il3Region): Boolean;
//#UC START# *4728B5A50041_4A4CB79A02C6_var*
//#UC END# *4728B5A50041_4A4CB79A02C6_var*
begin
//#UC START# *4728B5A50041_4A4CB79A02C6_impl*
 if Drawing AND (Region <> nil) AND not Region.Empty then
 begin
  if DrawEnabled then
  begin
   CheckColors;
   AddRgn(Region);
   Result := Windows.FillRgn(DC, Region.Rgn, Brush.Handle);
  end//DrawEnabled
  else
   Result := false;
 end//Drawing AND not Region.Empty
 else
  Result := false;
//#UC END# *4728B5A50041_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.FillRgn

function Tl3CanvasPrim.TextOut(const P: Tl3Point;
 const S: Tl3PCharLen;
 FC: Tl3Color = clDefault;
 BC: Tl3Color = clDefault): Tl3Point;
//#UC START# *4728B5B5026B_4A4CB79A02C6_var*
//#UC END# *4728B5B5026B_4A4CB79A02C6_var*
begin
//#UC START# *4728B5B5026B_4A4CB79A02C6_impl*
 PushFC;
 try
  PushBC;
  try
   if (FC <> clDefault) then
    TextColor := FC;
   if (BC <> clDefault) then
    BackColor := BC;
   Result := KerningTextExtent(S);
   KerningTextOut(P, l3RectBnd(P, Result), S);
  finally
   PopBC;
  end;//try..finally
 finally
  PopFC;
 end;//try..finally
//#UC END# *4728B5B5026B_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.TextOut

procedure Tl3CanvasPrim.SetCaret(const Origin: Tl3Point;
 const Extent: Tl3Point;
 Hidden: Boolean = False);
//#UC START# *4728B5EB01A1_4A4CB79A02C6_var*
var
 Pt      : array [0..1] of Tl3SPoint;
 l_Caret : Il3Caret;
//#UC END# *4728B5EB01A1_4A4CB79A02C6_var*
begin
//#UC START# *4728B5EB01A1_4A4CB79A02C6_impl*
 l_Caret := GetCaret;
 if (l_Caret <> nil) then
 try
  l_Caret.Hidden := true;
  if Hidden AND l_Caret.CanHide then
   l_Caret.Position := Point1(MaxInt)
  else
  if l_Caret.Visible then
  begin
   {необходимо учесть Zoom}
   Pt[0] := LP2DP(Extent);
   Pt[1] := WO(Origin);
   Pt[0] := Pt[0].Zoom(Zoom);
   LPtoDP(DC, Pt[1], 1);
   l_Caret.Extent := TPoint(Pt[0]);
   l_Caret.Position := Pt[1];
  end;//l_Caret.Visible
 finally
  l_Caret := nil;
 end;//try..finally
//#UC END# *4728B5EB01A1_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.SetCaret

procedure Tl3CanvasPrim.IncCaret(aDeltaX: Integer);
//#UC START# *4728B60F0211_4A4CB79A02C6_var*
var
 l_Caret : Il3Caret;
//#UC END# *4728B60F0211_4A4CB79A02C6_var*
begin
//#UC START# *4728B60F0211_4A4CB79A02C6_impl*
 l_Caret := GetCaret;
 if (l_Caret <> nil) then
 try
  l_Caret.Hidden := true;
  if l_Caret.Visible then
  begin
   {необходимо учесть Zoom?}
   l_Caret.Position := Tl3SPoint(l_Caret.Position).Add(PointX(aDeltaX));
  end;//l_Caret.Visible
 finally
  l_Caret := nil;
 end;//try..finally
//#UC END# *4728B60F0211_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.IncCaret

procedure Tl3CanvasPrim.BeginPaint;
//#UC START# *4728B61D0058_4A4CB79A02C6_var*
//#UC END# *4728B61D0058_4A4CB79A02C6_var*
begin
//#UC START# *4728B61D0058_4A4CB79A02C6_impl*
 Lock;
 if (BeginDrawing = 1) then
 begin
  l3FillChar(f_InitialDCOffset, SizeOf(f_InitialDCOffset));
  f_ClipRectInited := false;
  if Printing AND (f_Printer <> nil) then
  begin
   with LP2DP(f_WindowOrg) do
    SetWindowOrgEx(DC, X, Y, nil);
   if not f_Printer.Printing then
   begin
    f_PageNumber := 1;
    f_OverallPageNumber := 1;
    f_PageWidthNumber := 0;
    CheckOrientation;
    f_SaveOrientation := f_Printer.Orientation;
    f_Printer.Orientation := f_PageOrientation;
    {$IfNDef l3UsePrinterForPreview}
    if not IsPreview then
    {$EndIf  l3UsePrinterForPreview}
     if (NeedOpenRealPage(true) = l3_oprYes) then
      StartPrinterPage(true);
    StartPage;
   end;//not f_Printer.Printing
  end;//Printing..
 end;//f_Drawing = 1..
//#UC END# *4728B61D0058_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.BeginPaint

procedure Tl3CanvasPrim.StartObject(anObjectID: Integer);
//#UC START# *4728B62702C9_4A4CB79A02C6_var*
//#UC END# *4728B62702C9_4A4CB79A02C6_var*
begin
//#UC START# *4728B62702C9_4A4CB79A02C6_impl*
 DoStartObject(anObjectID);
//#UC END# *4728B62702C9_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.StartObject

procedure Tl3CanvasPrim.SetPageTop;
//#UC START# *4728B637025E_4A4CB79A02C6_var*
//#UC END# *4728B637025E_4A4CB79A02C6_var*
begin
//#UC START# *4728B637025E_4A4CB79A02C6_impl*
 DoSetPageTop;
//#UC END# *4728B637025E_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.SetPageTop

procedure Tl3CanvasPrim.EndPaint;
//#UC START# *4728B67C0037_4A4CB79A02C6_var*
//#UC END# *4728B67C0037_4A4CB79A02C6_var*
begin
//#UC START# *4728B67C0037_4A4CB79A02C6_impl*
 DoEndPaint;
//#UC END# *4728B67C0037_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.EndPaint

procedure Tl3CanvasPrim.BeginInvert;
//#UC START# *4728B68502C5_4A4CB79A02C6_var*
//#UC END# *4728B68502C5_4A4CB79A02C6_var*
begin
//#UC START# *4728B68502C5_4A4CB79A02C6_impl*
 Inc(f_Invert);
 if DrawEnabled and Drawing then 
  CheckColors;
//#UC END# *4728B68502C5_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.BeginInvert

procedure Tl3CanvasPrim.EndInvert;
//#UC START# *4728B68C0329_4A4CB79A02C6_var*
//#UC END# *4728B68C0329_4A4CB79A02C6_var*
begin
//#UC START# *4728B68C0329_4A4CB79A02C6_impl*
 Dec(f_Invert);
 if DrawEnabled and Drawing then
  CheckColors;
//#UC END# *4728B68C0329_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.EndInvert

function Tl3CanvasPrim.DrawRgnOrBlock: Boolean;
//#UC START# *4728B6B501C9_4A4CB79A02C6_var*
//#UC END# *4728B6B501C9_4A4CB79A02C6_var*
begin
//#UC START# *4728B6B501C9_4A4CB79A02C6_impl*
 Result := ([ev_dfDrawregion] * Flags <> []);
//#UC END# *4728B6B501C9_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DrawRgnOrBlock

function Tl3CanvasPrim.HasToDraw: Boolean;
//#UC START# *4728B6DD013A_4A4CB79A02C6_var*
//#UC END# *4728B6DD013A_4A4CB79A02C6_var*
begin
//#UC START# *4728B6DD013A_4A4CB79A02C6_impl*
 Result := ([ev_dfDrawCursor, ev_dfDrawRegion] * Flags <> []);
//#UC END# *4728B6DD013A_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.HasToDraw

procedure Tl3CanvasPrim.StretchDraw(const R: Tl3Rect;
 Graphic: VCLGraphic);
//#UC START# *4728B6ED0101_4A4CB79A02C6_var*
var
 l_R       : Tl3SRect;
 l_OldMode : TCopyMode;
//#UC END# *4728B6ED0101_4A4CB79A02C6_var*
begin
//#UC START# *4728B6ED0101_4A4CB79A02C6_impl*
 l_R := WO(R);
 if DrawingIsValid then
 begin
  l_OldMode := Canvas.CopyMode;
  try
   if Invert AND not Printing then
    Canvas.CopyMode := cmNotSrcCopy
   else
    Canvas.CopyMode := cmSrcCopy;
   {$IfDef l3DrawBitmapsTransparent}
   if (Graphic Is Graphics.TBitmap) then
   begin
    Graphics.TBitmap(Graphic).IgnorePalette := true;
    //CheckColors;
    //TBitmap(Graphic).TransparentColor := Brush.Color;
    Graphics.TBitmap(Graphic).TransparentColor := clWhite;
    // - т.к. обычно подложка белая
   end;//Graphic Is TBitmap
   Graphic.Transparent := true;
   {$EndIf l3DrawBitmapsTransparent}
   if Graphic.Transparent then
    FillRect(l_R)
   else
    AddRect(l_R);
   Canvas.StretchDraw(l_R.R.WR, Graphic);
  finally
   Canvas.CopyMode := l_OldMode;
  end;
 end//DrawingIsValid
 else
  AddRect(l_R);
//#UC END# *4728B6ED0101_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.StretchDraw

procedure Tl3CanvasPrim.DrawSub(aSubTarget: TObject;
 const R: Tl3Rect;
 LayerHandle: Integer;
 aSub: TObject);
//#UC START# *4728B97800C0_4A4CB79A02C6_var*
//#UC END# *4728B97800C0_4A4CB79A02C6_var*
begin
//#UC START# *4728B97800C0_4A4CB79A02C6_impl*
 if CanDrawSubs then
  f_OnDrawSub(aSubTarget, AsIl3Canvas, R, LayerHandle, aSub);
//#UC END# *4728B97800C0_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DrawSub

procedure Tl3CanvasPrim.ExtTextOut(const P: Tl3Point;
 const R: Tl3Rect;
 const S: Tl3WString;
 F: Tl3TextFormatFlag = l3_tffLeft;
 Dx: PInteger = nil);
//#UC START# *4728B9F10060_4A4CB79A02C6_var*
var
 l_SOffset : Tl3SPoint;
 R1        : Tl3SRect;
 l_DC      : HDC;

 procedure TextOut(const aSt: Tl3PCharLenPrim);


  function DrawTabbed(const aSt: Tl3PCharLenPrim): Bool;

  var
   l_TabbedRect : TRect;
   l_TabPos     : Integer;
   l_Width      : Long;
   l_OutRect    : TRect;
   l_Style      : Tl3TabStopStyle;

   procedure DrawTabSymbol(WasFiller: Bool);
   const
    cTabSymbol : array [Tl3TabStopStyle] of Tl3PCharLenConst =
     (
      (S         : #$E8;
       SLen      : 1;
       SCodePage : CP_ANSI;
       ),
      (S         : #$E8;
       SLen      : 1;
       SCodePage : CP_ANSI;
       ),
      (S         : #$E7;
       SLen      : 1;
       SCodePage : CP_ANSI;
       ),
      (S         : #$E8;
       SLen      : 1;
       SCodePage : CP_ANSI;
       ),
      (S         : #$E7;
       SLen      : 1;
       SCodePage : CP_ANSI;
       )
     );

   var
    l_OName     : String;
    l_OSize     : Long;
    l_OFColor   : TColor;
    l_E         : TSize;
    l_TabSymbol : Tl3PCharLenPrim;
    l_Flags     : Long;
   begin//DrawTabSymbol
    if DrawSpecial then
     l_TabSymbol := cTabSymbol[l_Style]
    else
     l_TabSymbol := cc_EmptyTabSymbol;
    if DrawSpecial OR not WasFiller then
    begin
     // Рисуем знак табуляции:
     with Il3Font(Self) do
     begin
      l_OName := Name;
      l_OSize := Size;
      l_OFColor := TextColor;
      try
       Name := def_WingdingsFontName;
       Size := 4;
       if WasFiller then
        l_Flags := eto_Clipped
       else
        l_Flags := etoFlags + eto_Clipped;
       with l_TabSymbol do
       begin
        SystemTextExtent(l_DC, l_TabSymbol, l_E, f_LineSpacing);
(*        Case l_Style of
         l3_tssRight :
          Windows.ExtTextOut(l_DC,
                             l_SOffset.X,
                             (l_OutRect.Top + l_OutRect.Bottom - l_E.cY) div 2,
                             l_Flags, @l_OutRect,
                             S, SLen,
                             Dx);
         else*)
          Windows.ExtTextOut(l_DC,
                             l_SOffset.X + ((l_Width - l_E.cX){ div 2}),
                             (l_OutRect.Top + l_OutRect.Bottom - l_E.cY) div 2,//l_SOffset.Y,
                             l_Flags, @l_OutRect,
                             S, SLen,
                             Dx);
(*        end;//Case l_Style*)
       end;//with l_TabSymbol
      finally
       Name := l_OName;
       Size := l_OSize;
       TextColor := l_OFColor;
      end;//try..finally
     end;//with Il3Font(Self)
    end;//DrawSpecial
    l_OutRect.Left := l_OutRect.Right;
    Inc(l_SOffset.P.X, l_Width);
    Inc(Dx, l_TabSymbol.SLen);
   end;//DrawTabSymbol

  var
   l_Filler : Tl3PCharLen;

   procedure DrawFiller;
   var
    l_Rect : TRect;
    l_E    : TSize;
    l_X    : Long;
   begin//DrawFiller
    l_Rect := l_OutRect;
    l_X    := l_SOffset.X;
    while (l_Rect.Left - l_OutRect.Left < l_Width) do
    begin
     with l_Filler do
     begin
      SystemTextExtent(l_DC, l_Filler, l_E, f_LineSpacing);
      l_Rect.Right := l_Rect.Left + l_E.cX;
      Windows.ExtTextOut(l_DC,
                         l_X,
                         l_SOffset.Y,
                         etoFlags, @l_Rect,
                         S, SLen,
                         Dx);
     end;//with l_Filler
     Inc(l_X, l_E.cX);
     l_Rect.Left := l_Rect.Right;
    end;//while (l_Rect.Left - l_OutRect.Left < l_Width)
   end;//DrawFiller

  var
   l_S  : Tl3PCharLenPrim;

   function CalcWidth: Long;
   var
    l_Index : Long;
   begin//CalcWidth
    Result := 0;
    for l_Index := 0 to Pred(l_S.SLen) do
     Inc(Result, PLong(PAnsiChar(Dx) + l_Index * SizeOf(Long))^);
   end;//CalcWidth

  var
   l_NS       : Tl3PCharLen;
   l_Last     : Bool;
   l_TabStops : Il3TabStops;
   l_CurTab   : Integer;
   l_Str      : Tl3Str;
  begin//DrawTabbed
   Result := true;
   l_S := aSt;
   l_OutRect := R1.R.WR;
   l_TabStops := nil;
   if (f_TabStops <> nil) and (f_TabStops.NeedCutByTab) then
    l_TabStops := f_TabStops.Clone;
   l_CurTab := 0;
   repeat
    l_NS := l3FindChar(cc_Tab, l_S);
    l_Last := Tl3PCharLen(l_S).IsLast(cc_Tab);
    if l_Last then
     Dec(l_S.SLen);

    // Рисуем текст:
    if l_TabStops <> nil then
    begin
     l_TabPos := LP2DP(l3PointX(l_TabStops.Next.rPosition)).X;
     l_Width :=  l_tabPos - l_CurTab;
     l_CurTab := l_TabPos;
    end
    else
     l_Width := CalcWidth;
    l_OutRect.Right := l_OutRect.Left + l_Width;
    if (l_TabStops <> nil) then
    begin
     l_TabbedRect := l_OutRect;
     Windows.InflateRect(l_TabbedRect, -4, 0);
     if (l_S.SCodePage = CP_Unicode) then
     begin
      if (Win32Platform = VER_PLATFORM_WIN32_NT) then
       Windows.DrawTextExW(l_DC, PWideChar(l_S.S), l_S.SLen, l_TabbedRect, DT_END_ELLIPSIS, nil)
      else
      begin
       l_Str.Init(l_S, CP_ANSI);
       try
        Windows.DrawTextExA(l_DC, l_Str.S, l_Str.SLen, l_TabbedRect, DT_END_ELLIPSIS, nil);
       finally
        l_Str.Clear;
       end;//try..finally
      end;//Win32Platform = VER_PLATFORM_WIN32_NT
     end
     else
      Windows.DrawTextExA(l_DC, l_S.S, l_S.SLen, l_TabbedRect, DT_END_ELLIPSIS, nil);
    end//l_TabStops <> nil
    else
    begin
     if (l_S.SCodePage = CP_Unicode) then
      Windows.ExtTextOutW(l_DC, l_SOffset.X, l_SOffset.Y, etoFlags, @l_OutRect,
                          PWideChar(l_S.S), Min(l_S.SLen, cMaxTextLength), Dx)
     else
      Windows.ExtTextOut(l_DC, l_SOffset.X, l_SOffset.Y, etoFlags, @l_OutRect,
                         l_S.S, Min(l_S.SLen, cMaxTextLength), Dx);
    end;//l_TabStops <> nil
    l_OutRect.Left := l_OutRect.Right;
    Inc(l_SOffset.P.X, l_Width);
    Inc(Dx, l_S.SLen);

    if (l_TabStops = nil) and l_Last then
    begin
     l_Width := Dx^;
     l_OutRect.Right := l_OutRect.Left + l_Width;
     if (f_TabStops = nil) then
     begin
      l_Style := l3_tssLeft;
      DrawTabSymbol(false);
     end//f_TabStops = nil
     else
     begin
      Tl3WString(l_Filler) := f_TabStops.Filler;
      l_Style := f_TabStops.Style;
      if l3IsNil(l_Filler) then
       DrawTabSymbol(false)
      else
      begin
       DrawFiller;
       DrawTabSymbol(true);
      end;//l3IsNil
     end;//f_TabStops = nil
    end;//l_Last..

    l_S := l_NS;
   until l3IsNil(l_NS);
  end;//DrawTabbed

 var
  l_S : Tl3PCharLenPrim;  
 begin//TextOut
  if Printing then
   Assert(Dx = nil, 'aKerning <> 0 во время печати!!!');
  l_S := aSt;
  with l_S do
   if (SLen > 0) then
   begin
    if (SCodePage = CP_Unicode) then
    begin
     while (SLen > 0) and (l3WideToChar(PWideChar(S)[Pred(SLen)]) in [cc_SoftEnter, cc_HardEnter]) do
      Dec(SLen);
    end//SCodePage = CP_Unicode
    else
    begin
     while (SLen > 0) and (S[Pred(SLen)] in [cc_SoftEnter, cc_HardEnter]) do
      Dec(SLen);
    end;//SCodePage = CP_Unicode
   end;//SLen > 0
  SetBkColor(l_DC, ColorToRGB(Brush.Color));
  if (f_Tabs > 0) AND
     (Dx <> nil) AND
     DrawTabbed(l_S) then
   Exit;
  if (l_S.SCodePage = CP_ANSI) then
   Windows.ExtTextOut(l_DC, l_SOffset.X, l_SOffset.Y, etoFlags, @R1, l_S.S, Min(l_S.SLen, cMaxTextLength), Dx)
  else
   Win32Check(Windows.ExtTextOutW(l_DC, l_SOffset.X, l_SOffset.Y, etoFlags, @R1, PWideChar(l_S.S), Min(l_S.SLen, cMaxTextLength), Dx));
 end;//TextOut

var
 D          : Long;
 l_Str      : Tl3Str;
 l_W        : Integer;
 l_FontSize : Integer;
 l_Pt       : Tl3Point;
 l_R        : Tl3Rect;
 l_St       : Tl3PCharLenPrim;
 l_Convert  : Tl3Str;
 l_Bmp      : Graphics.TBitmap;
 l_Canvas   : Tl3Canvas;
 l_TmpPt    : Tl3Point;
 l_TmpRect  : Tl3Rect;
//#UC END# *4728B9F10060_4A4CB79A02C6_var*
begin
//#UC START# *4728B9F10060_4A4CB79A02C6_impl*
 l_R := R;
 l_R.Right := Min(ClipRect.Right, l_R.Right);
 R1 := WO(l_R);
 if DrawingIsValid then
 begin
  l_St := S;
  if (f_PasswordChar <> #0) then
  begin
   l_Convert.Init(Tl3WString(l_St), CP_ANSI);
   l3FillChar(l_Convert.S^, l_Convert.SLen, Ord(f_PasswordChar));
   l_St := l_Convert;
  end//f_PasswordChar <> #0
  else
   l_Convert.Init;
  try
   l_Pt := P;
   if (F <> l3_tffLeft) then
   begin
    l_W := TextExtent(l_St).X;
    if F = l3_tffRight then
     l_Pt.X := R.Right - l_W - (P.X - R.Left)
    else
     l_Pt.X := R.Left + ((R.Right - R.Left) - l_W) div 2;
   end;//aFl <> l3_tffLeft
   l_DC := DC;
   if (l3_fiSub in f_FontIndexSet) then
    D := l3FontIndexDelta
   else
    D := 0;
   case Get_Index of {FontIndex}
    l3_fiNone:
     ;
    l3_fiSub:
     D := 0;
    l3_fiSuper:
     Inc(D, l3FontIndexDelta);
   end;//Case FontIndex
   l_SOffset := WO(l_Pt.Sub(l3PointY(D)));
   CheckColors;
   CheckDrawing; // http://mdp.garant.ru/pages/viewpage.action?pageId=200902555&focusedCommentId=205357164#comment-205357164
   if (f_SuffixedFont AND (l_St.SCodePage = CP_ANSI)) OR
      // - закомментировано, т.к. неправильно работало с 'Arial', а не 'Arial CYR'
      (l_St.SCodePage = CP_Unicode) then
    TextOut(l_St)
   else
   begin
    if IsPreview AND (Win32Platform <> VER_PLATFORM_WIN32_NT) then
    begin
     // Для Windows 98 делаем так: создаем битмап, рисуем текст на него, а потом
     // выводим на канву. Сделано для обхода проблемы с метафайлом и юникодом на Win98.
     l_Bmp := Tl3Bitmap.Create;
     l_Bmp.Handle := CreateCompatibleBitmap(Self.DC, R1.Right - R1.Left, R1.Bottom - R1.Top);
     l_Canvas := Tl3Canvas.CreateOwned(l_Bmp);
     try
      with l_TmpRect do
      begin
       Left := 0;
       Right := R.Right - R.Left;
       Top := 0;
       Bottom := R.Bottom - R.Top;
      end;

      with l_TmpPt do
      begin
       X := l_Pt.X - R.Left;
       Y := l_Pt.Y - R.Top;
      end;

      with l_Canvas do
      begin
       with Canvas do
       begin
        Font := Self.VCLFont;
        l_FontSize := Font.Size;
        Font.PixelsPerInch := Self.PixelsPerInchX;
        Font.Size := l_FontSize;
       end;//with Canvas
       f_DCFlag := ev_dcfLinked;
       BeginPaint;
       DrawEnabled := true;
       ExtTextOut(l_TmpPt, l_TmpRect, l_St, F, Dx);
       EndPaint;
      end;//with..

      Self.StretchDraw(R, l_Bmp);
     finally
      l3Free(l_Canvas);
      FreeAndNil(l_Bmp);
     end;//try..finally
    end//IsPreview AND (Win32Platform <> VER_PLATFORM_WIN32_NT)
    else
    begin
     l_Str.Init(l_St, CP_Unicode, @f_ConvertBuf);
     TextOut(l_Str);
    end;//IsPreview AND (Win32Platform <> VER_PLATFORM_WIN32_NT)
   end;//l_St.SCodePage = CP_ANSI
  finally
   l_Convert.Clear;
  end;//try..finally
 end;//DrawingIsValid
 AddRect(R1);
//#UC END# *4728B9F10060_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.ExtTextOut

procedure Tl3CanvasPrim.ExtTextOut(const P: Tl3SPoint;
 const R: Tl3SRect;
 const S: Tl3WString;
 F: Tl3TextFormatFlag = l3_tffLeft;
 Dx: PInteger = nil);
//#UC START# *4728BAAC0127_4A4CB79A02C6_var*
//#UC END# *4728BAAC0127_4A4CB79A02C6_var*
begin
//#UC START# *4728BAAC0127_4A4CB79A02C6_impl*
 ExtTextOut(DP2LP(P), DR2LR(R), S, F, Dx);
//#UC END# *4728BAAC0127_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.ExtTextOut

function Tl3CanvasPrim.CaretLineOut(const aSt: Tl3WString;
 LineHeight: Integer;
 aHidden: Boolean;
 var CaretPos: Integer): Tl3Point;
 {* выводит строку текста высотой LineHeight, со сдвигом курсора отрисовки. устанавливает курсор в CaretPos. возвращает размеры выведенной строки. }
//#UC START# *4728BAD601DC_4A4CB79A02C6_var*
var
 l_YOfs        : Long;
 l_OTabInfo    : Il3TabInfo;
 l_TabInfo     : Il3TabInfo;
 l_CaretOffset : Long;
 l_D           : Integer;
//#UC END# *4728BAD601DC_4A4CB79A02C6_var*
begin
//#UC START# *4728BAD601DC_4A4CB79A02C6_impl*
 if (CaretPos >= 0) then
  l_OTabInfo := TabInfo;
 l_D := 0; 
 if l3IsNil(aSt) then
  Result.Init(0, LineHeight)
 else
 begin
  with ClipRect do
   if (Top >= LineHeight) OR (Bottom < 0) then
   begin
    if (CaretPos >= 0) then
     Result := KerningTextExtent(aSt)
    else
     Result.Init(0, LineHeight);
   end//(Top >= LineHeight) OR (Bottom < 0)
   else
   begin
    Result := KerningTextExtent(aSt);
    if (l3_fiObject in f_FontIndexSet) then
     l_D := (LineHeight - Result.Y) div 2
    else
    if (l3_fiBaseLined in f_FontIndexSet) then
     l_D := 0;
    KerningTextOut(l3Point(0, (LineHeight - Result.Y) - l_D),
                   l3Rect(0, 0, Result.X, LineHeight), aSt);
   end;//ClipRect.Bottom < LineHeight
 end;//l3IsNil(aSt)
 MoveWindowOrg(Result.e_X);
 //-сдвигаем курсор отрисовки на ширину текста
 l_YOfs := (LineHeight - Result.Y) - l_D;
 if (CaretPos >= 0) then
 begin
  if (CaretPos <= aSt.SLen) then
  begin
   if (l_YOfs < 0) then
    l_YOfs := 0;
   if (CaretPos = aSt.SLen) then
    SetCaret(l3Point(0, l_YOfs),
             l3Point(AverageCharWidth, Result.Y), aHidden)
   else
   begin
    if (f_Tabs > 0) then
    begin
     Assert(l_OTabInfo <> nil);
     StartTabs(l_TabInfo, l_OTabInfo);
     // - восстанавливаем смещение, которое было до рисования строки текста
     try
      l_CaretOffset := KerningTextExtent(l3PCharLen(aSt.S, CaretPos, aSt.SCodePage)).X;
     finally
      FinishTabs(l_TabInfo);
     end;//try..finally
    end
    else
     l_CaretOffset := KerningTextExtent(l3PCharLen(aSt.S, CaretPos, aSt.SCodePage)).X;
    SetCaret(l3Point(l_CaretOffset - Result.X, l_YOfs),
             l3Point(AverageCharWidth, Result.Y), aHidden);
   end;//CaretPos = aSt.SLen
   CaretPos := -1;
   ShowCursor := false;
  end//CaretPos <= aSt.SLen
  else
   Dec(CaretPos, aSt.SLen);
 end;//CaretPos >= 0
//#UC END# *4728BAD601DC_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.CaretLineOut

function Tl3CanvasPrim.StringOut(const P: Tl3Point;
 const Text: Tl3WString): Tl3Point;
//#UC START# *4728BB120156_4A4CB79A02C6_var*
//#UC END# *4728BB120156_4A4CB79A02C6_var*
begin
//#UC START# *4728BB120156_4A4CB79A02C6_impl*
 Result := TextOut(P, Tl3PCharLen(Text));
//#UC END# *4728BB120156_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.StringOut

procedure Tl3CanvasPrim.TabbedTextOut(const P: Tl3Point;
 const R: Tl3Rect;
 const S: Tl3WString;
 const aTabStops: Il3TabStops);
//#UC START# *4728BB2D0173_4A4CB79A02C6_var*
var
 lTempTabInfo : Il3TabInfo;
 St           : string;
 CL           : Tl3PCharLen;
//#UC END# *4728BB2D0173_4A4CB79A02C6_var*
begin
//#UC START# *4728BB2D0173_4A4CB79A02C6_impl*
 StartTabs(lTempTabInfo, aTabStops);
 St := l3PCharLen2String(S);
 CL := l3PCharLen(St+cc_Tab, S.SCodePage);
 try
  KerningTextExtent(CL);
  KerningTextOut(P, R, CL);
 finally
  FinishTabs(lTempTabInfo);
 end;
//#UC END# *4728BB2D0173_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.TabbedTextOut

procedure Tl3CanvasPrim.TabbedTextOut(const P: Tl3SPoint;
 const R: Tl3SRect;
 const S: Tl3WString;
 const aTabStops: Il3TabStops);
//#UC START# *4728BB8F03CD_4A4CB79A02C6_var*
var
 lTempTabInfo : Il3TabInfo;
 St           : string;
 CL           : Tl3PCharLen;
//#UC END# *4728BB8F03CD_4A4CB79A02C6_var*
begin
//#UC START# *4728BB8F03CD_4A4CB79A02C6_impl*
 StartTabs(lTempTabInfo, aTabStops);
 St := l3PCharLen2String(S);
 CL := l3PCharLen(St+cc_Tab, S.SCodePage);
 try
  KerningTextExtent(CL);
  KerningTextOut(P, R, CL);
 finally
  FinishTabs(lTempTabInfo);
 end;
//#UC END# *4728BB8F03CD_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.TabbedTextOut

function Tl3CanvasPrim.NewPage(ByWidth: Boolean = False): Boolean;
 {* начать новую страницу. }
//#UC START# *4728BBAF00BB_4A4CB79A02C6_var*
var
 l_PrinterOrientation : Tl3PageOrientation;
//#UC END# *4728BBAF00BB_4A4CB79A02C6_var*
begin
//#UC START# *4728BBAF00BB_4A4CB79A02C6_impl*
 Result := true;
 if (f_Printer <> nil) then
 begin
  Inc(f_OverallPageNumber);
  if ByWidth then
   Inc(f_PageWidthNumber)
  else
  begin
   f_PageWidthNumber := 0;
   Inc(f_PageNumber);
  end;//ByWidth
  l_PrinterOrientation := f_Printer.Orientation;
  CheckOrientation;
  {$IfNDef l3UsePrinterForPreview}
  if IsPreview then
  begin
   if (f_PageWidthNumber > 0) OR (l_PrinterOrientation = f_PageOrientation) then
   begin
   end
   else
   begin
    f_Printer.Orientation := f_PageOrientation;
   end;//f_PageWidthNumber > 0
  end//IsPreview
  else
  {$EndIf  l3UsePrinterForPreview}
  begin
   if not f_Printer.Printing then
    f_Printer.Orientation := f_PageOrientation;
   Case NeedOpenRealPage(false, ByWidth) of
    l3_oprNo: ; 
    l3_oprYes:
    begin
     if (f_PageWidthNumber > 0) OR (l_PrinterOrientation = f_PageOrientation) then
      StartPrinterPage(false)
     else
     begin
      f_Printer.Orientation := f_PageOrientation;
      if not f_Printer.Printing then
       StartPrinterPage(true);
     end;//f_PageWidthNumber > 0
    end;//l3_oprYes
    l3_oprEndDoc:
     Result := false;
   end;//Case NeedOpenRealPage(false)  
  end;//not IsPreview
  AssignDeviceCaps;
  StartPage;
 end//f_Printer <> nil
 else
  AssignDeviceCaps;
//#UC END# *4728BBAF00BB_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.NewPage

procedure Tl3CanvasPrim.Line(const A: Tl3Point;
 const B: Tl3Point);
 {* нарисовать линию. }
//#UC START# *4728BBC80252_4A4CB79A02C6_var*
//#UC END# *4728BBC80252_4A4CB79A02C6_var*
begin
//#UC START# *4728BBC80252_4A4CB79A02C6_impl*
 if DrawEnabled then
 begin
  MoveTo(A);
  LineTo(B);
 end;//DrawEnabled
//#UC END# *4728BBC80252_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.Line

procedure Tl3CanvasPrim.Line(const A: Tl3SPoint;
 const B: Tl3SPoint);
 {* нарисовать линию. }
//#UC START# *4728BBE702D9_4A4CB79A02C6_var*
//#UC END# *4728BBE702D9_4A4CB79A02C6_var*
begin
//#UC START# *4728BBE702D9_4A4CB79A02C6_impl*
 if DrawEnabled then
 begin
  MoveTo(A);
  LineTo(B);
 end;//DrawEnabled
//#UC END# *4728BBE702D9_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.Line

procedure Tl3CanvasPrim.MoveTo(const Pt: Tl3Point);
//#UC START# *4728BC06000C_4A4CB79A02C6_var*
//#UC END# *4728BC06000C_4A4CB79A02C6_var*
begin
//#UC START# *4728BC06000C_4A4CB79A02C6_impl*
 with WO(Pt) do
  Canvas.MoveTo(X, Y);
//#UC END# *4728BC06000C_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.MoveTo

procedure Tl3CanvasPrim.LineTo(const Pt: Tl3Point);
//#UC START# *4728BC0E0249_4A4CB79A02C6_var*
//#UC END# *4728BC0E0249_4A4CB79A02C6_var*
begin
//#UC START# *4728BC0E0249_4A4CB79A02C6_impl*
 if DrawEnabled then
  with WO(Pt) do
   DoDrawLineTo(X, Y);
//#UC END# *4728BC0E0249_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.LineTo

procedure Tl3CanvasPrim.MoveTo(const Pt: Tl3SPoint);
//#UC START# *4728BC18022F_4A4CB79A02C6_var*
//#UC END# *4728BC18022F_4A4CB79A02C6_var*
begin
//#UC START# *4728BC18022F_4A4CB79A02C6_impl*
 with WO(Pt) do
  Canvas.MoveTo(X, Y);
//#UC END# *4728BC18022F_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.MoveTo

procedure Tl3CanvasPrim.LineTo(const Pt: Tl3SPoint);
//#UC START# *4728BC2103A4_4A4CB79A02C6_var*
//#UC END# *4728BC2103A4_4A4CB79A02C6_var*
begin
//#UC START# *4728BC2103A4_4A4CB79A02C6_impl*
 if DrawEnabled then
  with WO(Pt) do
   DoDrawLineTo(X, Y);
//#UC END# *4728BC2103A4_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.LineTo

function Tl3CanvasPrim.WO(const aRect: Tl3Rect): Tl3SRect;
//#UC START# *4728BC4B02FB_4A4CB79A02C6_var*
//#UC END# *4728BC4B02FB_4A4CB79A02C6_var*
begin
//#UC START# *4728BC4B02FB_4A4CB79A02C6_impl*
 Result := LR2DR(aRect);
//#UC END# *4728BC4B02FB_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.WO

function Tl3CanvasPrim.WO(const aPt: Tl3Point): Tl3SPoint;
//#UC START# *4728BC54039E_4A4CB79A02C6_var*
//#UC END# *4728BC54039E_4A4CB79A02C6_var*
begin
//#UC START# *4728BC54039E_4A4CB79A02C6_impl*
 Result := LP2DP(aPt);
//#UC END# *4728BC54039E_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.WO

function Tl3CanvasPrim.WO(const aPt: Tl3SPoint): Tl3SPoint;
//#UC START# *4728BC61002B_4A4CB79A02C6_var*
//#UC END# *4728BC61002B_4A4CB79A02C6_var*
begin
//#UC START# *4728BC61002B_4A4CB79A02C6_impl*
 Result := aPt;
//#UC END# *4728BC61002B_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.WO

procedure Tl3CanvasPrim.DrawFocusRect(const aRect: Tl3SRect);
//#UC START# *4728BC6A0088_4A4CB79A02C6_var*
//#UC END# *4728BC6A0088_4A4CB79A02C6_var*
begin
//#UC START# *4728BC6A0088_4A4CB79A02C6_impl*
 Canvas.DrawFocusRect(aRect.R.WR);
//#UC END# *4728BC6A0088_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DrawFocusRect

function Tl3CanvasPrim.IsVirtual: Boolean;
//#UC START# *4728BC74029F_4A4CB79A02C6_var*
//#UC END# *4728BC74029F_4A4CB79A02C6_var*
begin
//#UC START# *4728BC74029F_4A4CB79A02C6_impl*
 Result := GetIsVirtual;
//#UC END# *4728BC74029F_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.IsVirtual

procedure Tl3CanvasPrim.StartRegion;
//#UC START# *4728BC81028A_4A4CB79A02C6_var*
//#UC END# *4728BC81028A_4A4CB79A02C6_var*
begin
//#UC START# *4728BC81028A_4A4CB79A02C6_impl*
 if (f_Rgns = nil) then
  f_Rgns := Tl3LongintList.Make;
 with f_RegionBottomRight do
 begin
  f_Rgns.Add(X);
  f_Rgns.Add(Y);
 end;//with f_RegionBottomRight
 f_RegionBottomRight := WO(l3Point0).Sub(LP2DP(WindowOrg));
//#UC END# *4728BC81028A_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.StartRegion

procedure Tl3CanvasPrim.FinishRegion;
//#UC START# *4728BC890119_4A4CB79A02C6_var*
//#UC END# *4728BC890119_4A4CB79A02C6_var*
begin
//#UC START# *4728BC890119_4A4CB79A02C6_impl*
 with f_Rgns do
 begin
  f_RegionBottomRight.Y := Integer(Delete(Hi));
  f_RegionBottomRight.X := Integer(Delete(Hi));
 end;//with f_Rgns
//#UC END# *4728BC890119_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.FinishRegion

procedure Tl3CanvasPrim.PushWO;
//#UC START# *4728BC9A022C_4A4CB79A02C6_var*
//#UC END# *4728BC9A022C_4A4CB79A02C6_var*
begin
//#UC START# *4728BC9A022C_4A4CB79A02C6_impl*
 if (f_WOs = nil) then
  f_WOs := Tl3LongintList.Make;
 with WindowOrg do
 begin
  f_WOs.Add(X);
  f_WOs.Add(Y);
 end;//with WindowOrg
//#UC END# *4728BC9A022C_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.PushWO

procedure Tl3CanvasPrim.PopWO;
//#UC START# *4728BCB60128_4A4CB79A02C6_var*
var
 l_WO : Tl3Point;
//#UC END# *4728BCB60128_4A4CB79A02C6_var*
begin
//#UC START# *4728BCB60128_4A4CB79A02C6_impl*
 with f_WOs do
 begin
  l_WO.Y := Integer(Delete(Hi));
  l_WO.X := Integer(Delete(Hi));
 end;//with f_WOs
 WindowOrg := l_WO;
//#UC END# *4728BCB60128_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.PopWO

function Tl3CanvasPrim.pm_GetWindowOrg: Tl3Point;
//#UC START# *4728BCF0038E_4A4CB79A02C6get_var*
var
 l_Pt : Tl3SPoint;
 l_DC : hDC;
//#UC END# *4728BCF0038E_4A4CB79A02C6get_var*
begin
//#UC START# *4728BCF0038E_4A4CB79A02C6get_impl*
 if f_WindowOrgInited then
  Result := f_WindowOrg
 else
 begin
  l_DC := DC;
  if (l_DC = 0) then
   Result := f_WindowOrg
  else
  begin
   if GetWindowOrgEx(l_DC, TPoint(l_Pt)) then
   begin
    Result := DP2LP(l_Pt);
    f_WindowOrgInited := true;
    f_WindowOrg := Result;
   end//GetWindowOrgEx
   else
    Result := f_WindowOrg;
  end;//l_DC = 0
 end;//f_WindowOrgInited
//#UC END# *4728BCF0038E_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetWindowOrg

procedure Tl3CanvasPrim.pm_SetWindowOrg(const aValue: Tl3Point);
//#UC START# *4728BCF0038E_4A4CB79A02C6set_var*
var
 l_DC : hDC;
//#UC END# *4728BCF0038E_4A4CB79A02C6set_var*
begin
//#UC START# *4728BCF0038E_4A4CB79A02C6set_impl*
 if not f_WindowOrg.EQ(aValue) then
 begin
   l_DC := DC;
   f_WindowOrg := aValue;
   f_WindowOrgInited := false;
   if (l_DC <> 0) then
    with LP2DP(aValue) do
     SetWindowOrgEx(l_DC, X, Y, nil);
  RecordRegionBottomPrim(LP2DP(f_WindowOrg).Neg);
 end;//not f_WindowOrg.EQ(Value)
//#UC END# *4728BCF0038E_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetWindowOrg

function Tl3CanvasPrim.pm_GetSWindowOrg: Tl3SPoint;
//#UC START# *4728BCFF03D6_4A4CB79A02C6get_var*
var
 l_Pt : Tl3SPoint;
 l_DC : hDC;
//#UC END# *4728BCFF03D6_4A4CB79A02C6get_var*
begin
//#UC START# *4728BCFF03D6_4A4CB79A02C6get_impl*
 l_DC := DC;
 if (l_DC = 0) then
  Result := LP2DP(f_WindowOrg)
 else
 begin
  GetWindowOrgEx(l_DC, TPoint(l_Pt));
  Result := l_Pt;
 end;//l_DC
//#UC END# *4728BCFF03D6_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetSWindowOrg

procedure Tl3CanvasPrim.pm_SetSWindowOrg(const aValue: Tl3SPoint);
//#UC START# *4728BCFF03D6_4A4CB79A02C6set_var*
var
 l_DC : hDC;
 l_Pt : Tl3SPoint;
//#UC END# *4728BCFF03D6_4A4CB79A02C6set_var*
begin
//#UC START# *4728BCFF03D6_4A4CB79A02C6set_impl*
 l_DC := DC;
 if (l_DC = 0) then
 begin
  f_WindowOrg := DP2LP(aValue);
  f_WindowOrgInited := false;
 end//l_DC = 0
 else
 begin
  GetWindowOrgEx(l_DC, TPoint(l_Pt));
  if not l_Pt.EQ(aValue) then
  begin
   SetWindowOrgEx(DC, aValue.X, aValue.Y, nil);
   f_WindowOrg := DP2LP(aValue);
   f_WindowOrgInited := true;
  end;//not l_Pt.EQ(Value)
 end;//l_DC <> 0
 RecordRegionBottomPrim(aValue.Neg);
//#UC END# *4728BCFF03D6_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetSWindowOrg

function Tl3CanvasPrim.pm_GetClipRect: Tl3Rect;
//#UC START# *4728BD12038D_4A4CB79A02C6get_var*
//#UC END# *4728BD12038D_4A4CB79A02C6get_var*
begin
//#UC START# *4728BD12038D_4A4CB79A02C6get_impl*
 Result := GlobalClipRect.AddPt(WindowOrg);
//#UC END# *4728BD12038D_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetClipRect

procedure Tl3CanvasPrim.pm_SetClipRect(const aValue: Tl3Rect);
//#UC START# *4728BD12038D_4A4CB79A02C6set_var*
var
 Rgn : Tl3Rgn;
//#UC END# *4728BD12038D_4A4CB79A02C6set_var*
begin
//#UC START# *4728BD12038D_4A4CB79A02C6set_impl*
 Rgn := CreateRectRgn(WO(aValue).SubPt(SWindowOrg));
 try
  SelectClipRgn(DC, Rgn);
  f_ClipRectInited := false;
 finally
  l3FreeRgn(Rgn);
 end;//try..finally
//#UC END# *4728BD12038D_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetClipRect

function Tl3CanvasPrim.pm_GetGlobalClipRect: Tl3Rect;
//#UC START# *4728BD2703E7_4A4CB79A02C6get_var*
//#UC END# *4728BD2703E7_4A4CB79A02C6get_var*
begin
//#UC START# *4728BD2703E7_4A4CB79A02C6get_impl*
 Result := GetGlobalClipRect;
//#UC END# *4728BD2703E7_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetGlobalClipRect

function Tl3CanvasPrim.pm_GetBackColor: Tl3Color;
//#UC START# *4728BD3800A2_4A4CB79A02C6get_var*
//#UC END# *4728BD3800A2_4A4CB79A02C6get_var*
begin
//#UC START# *4728BD3800A2_4A4CB79A02C6get_impl*
 Result := f_BackColor;
//#UC END# *4728BD3800A2_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetBackColor

procedure Tl3CanvasPrim.pm_SetBackColor(aValue: Tl3Color);
//#UC START# *4728BD3800A2_4A4CB79A02C6set_var*
//#UC END# *4728BD3800A2_4A4CB79A02C6set_var*
begin
//#UC START# *4728BD3800A2_4A4CB79A02C6set_impl*
 if (f_BackColor <> aValue) and (aValue <> clDefault) then
 begin
  f_BackColor := aValue;
  if DrawEnabled and Drawing then
   CheckColors;
 end;//f_BackColor <> Value
//#UC END# *4728BD3800A2_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetBackColor

function Tl3CanvasPrim.pm_GetDrawEnabled: Boolean;
//#UC START# *4728BD560290_4A4CB79A02C6get_var*
//#UC END# *4728BD560290_4A4CB79A02C6get_var*
begin
//#UC START# *4728BD560290_4A4CB79A02C6get_impl*
 Result := DoGetDrawEnabled;
//#UC END# *4728BD560290_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetDrawEnabled

procedure Tl3CanvasPrim.pm_SetDrawEnabled(aValue: Boolean);
//#UC START# *4728BD560290_4A4CB79A02C6set_var*
//#UC END# *4728BD560290_4A4CB79A02C6set_var*
begin
//#UC START# *4728BD560290_4A4CB79A02C6set_impl*
 if aValue then
  Flags := Flags + [ev_dfDrawRegion]
 else
  Flags := Flags - [ev_dfDrawRegion];
//#UC END# *4728BD560290_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetDrawEnabled

function Tl3CanvasPrim.pm_GetDrawSpecial: Boolean;
//#UC START# *4728BD890258_4A4CB79A02C6get_var*
//#UC END# *4728BD890258_4A4CB79A02C6get_var*
begin
//#UC START# *4728BD890258_4A4CB79A02C6get_impl*
 Result := (ev_dfDrawSpecial in Flags);
 Assert(not Result or not Printing, 'http://mdp.garant.ru/pages/viewpage.action?pageId=174295160&focusedCommentId=266409368#comment-266409368');
//#UC END# *4728BD890258_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetDrawSpecial

function Tl3CanvasPrim.pm_GetCanDrawSubs: Boolean;
//#UC START# *4728BD9F0227_4A4CB79A02C6get_var*
//#UC END# *4728BD9F0227_4A4CB79A02C6get_var*
begin
//#UC START# *4728BD9F0227_4A4CB79A02C6get_impl*
 Result := DoGetDrawEnabled and Assigned(f_OnDrawSub);
//#UC END# *4728BD9F0227_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetCanDrawSubs

function Tl3CanvasPrim.pm_GetShowCursor: Boolean;
//#UC START# *4728BDB301F4_4A4CB79A02C6get_var*
//#UC END# *4728BDB301F4_4A4CB79A02C6get_var*
begin
//#UC START# *4728BDB301F4_4A4CB79A02C6get_impl*
 Result := (ev_dfDrawCursor in Flags);
//#UC END# *4728BDB301F4_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetShowCursor

procedure Tl3CanvasPrim.pm_SetShowCursor(aValue: Boolean);
//#UC START# *4728BDB301F4_4A4CB79A02C6set_var*
//#UC END# *4728BDB301F4_4A4CB79A02C6set_var*
begin
//#UC START# *4728BDB301F4_4A4CB79A02C6set_impl*
 if aValue then
  Flags := Flags + [ev_dfDrawCursor]
 else
  Flags := Flags - [ev_dfDrawCursor];
//#UC END# *4728BDB301F4_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetShowCursor

function Tl3CanvasPrim.pm_GetFontIndexSet: Tl3FontIndexes;
//#UC START# *4728BE1500AA_4A4CB79A02C6get_var*
//#UC END# *4728BE1500AA_4A4CB79A02C6get_var*
begin
//#UC START# *4728BE1500AA_4A4CB79A02C6get_impl*
 Result := f_FontIndexSet;
//#UC END# *4728BE1500AA_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetFontIndexSet

procedure Tl3CanvasPrim.pm_SetFontIndexSet(aValue: Tl3FontIndexes);
//#UC START# *4728BE1500AA_4A4CB79A02C6set_var*
//#UC END# *4728BE1500AA_4A4CB79A02C6set_var*
begin
//#UC START# *4728BE1500AA_4A4CB79A02C6set_impl*
 f_FontIndexSet := aValue;
//#UC END# *4728BE1500AA_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetFontIndexSet

function Tl3CanvasPrim.pm_GetPrinted: Boolean;
//#UC START# *4728BE460354_4A4CB79A02C6get_var*
//#UC END# *4728BE460354_4A4CB79A02C6get_var*
begin
//#UC START# *4728BE460354_4A4CB79A02C6get_impl*
 Result := not Printing or (ev_dfPrinted in Flags);
//#UC END# *4728BE460354_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetPrinted

procedure Tl3CanvasPrim.pm_SetPrinted(aValue: Boolean);
//#UC START# *4728BE460354_4A4CB79A02C6set_var*
//#UC END# *4728BE460354_4A4CB79A02C6set_var*
begin
//#UC START# *4728BE460354_4A4CB79A02C6set_impl*
 if aValue then
  Flags := Flags + [ev_dfPrinted]
 else
  Flags := Flags - [ev_dfPrinted];
//#UC END# *4728BE460354_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetPrinted

function Tl3CanvasPrim.pm_GetPageNumber: Integer;
//#UC START# *4728BE6A0392_4A4CB79A02C6get_var*
//#UC END# *4728BE6A0392_4A4CB79A02C6get_var*
begin
//#UC START# *4728BE6A0392_4A4CB79A02C6get_impl*
 if Printing then
  Result := f_PageNumber
 else
  Result := -1;
//#UC END# *4728BE6A0392_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetPageNumber

function Tl3CanvasPrim.pm_GetPageWidthNumber: Integer;
//#UC START# *4728BE830080_4A4CB79A02C6get_var*
//#UC END# *4728BE830080_4A4CB79A02C6get_var*
begin
//#UC START# *4728BE830080_4A4CB79A02C6get_impl*
 if Printing then
  Result := f_PageWidthNumber
 else
  Result := 0;
//#UC END# *4728BE830080_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetPageWidthNumber

function Tl3CanvasPrim.pm_GetPenWidth: Integer;
//#UC START# *4728C0510003_4A4CB79A02C6get_var*
//#UC END# *4728C0510003_4A4CB79A02C6get_var*
begin
//#UC START# *4728C0510003_4A4CB79A02C6get_impl*
 Result := Canvas.Pen.Width;
//#UC END# *4728C0510003_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetPenWidth

function Tl3CanvasPrim.pm_GetPageOrientation: Tl3PageOrientation;
//#UC START# *4728C06D0306_4A4CB79A02C6get_var*
//#UC END# *4728C06D0306_4A4CB79A02C6get_var*
begin
//#UC START# *4728C06D0306_4A4CB79A02C6get_impl*
 Result := f_PageOrientation;
//#UC END# *4728C06D0306_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetPageOrientation

procedure Tl3CanvasPrim.pm_SetPageOrientation(aValue: Tl3PageOrientation);
//#UC START# *4728C06D0306_4A4CB79A02C6set_var*
//#UC END# *4728C06D0306_4A4CB79A02C6set_var*
begin
//#UC START# *4728C06D0306_4A4CB79A02C6set_impl*
 if (f_PageOrientation <> aValue) then
 begin
  f_PageOrientation := aValue;
  f_DeviceCaps.rIsAssigned := false;
 end;//f_PageOrientation <> Value
//#UC END# *4728C06D0306_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetPageOrientation

function Tl3CanvasPrim.pm_GetSectionExtent: Tl3Point;
//#UC START# *4728C0890017_4A4CB79A02C6get_var*
//#UC END# *4728C0890017_4A4CB79A02C6get_var*
begin
//#UC START# *4728C0890017_4A4CB79A02C6get_impl*
 Result := f_SectionExtent;
//#UC END# *4728C0890017_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetSectionExtent

procedure Tl3CanvasPrim.pm_SetSectionExtent(const aValue: Tl3Point);
//#UC START# *4728C0890017_4A4CB79A02C6set_var*
//#UC END# *4728C0890017_4A4CB79A02C6set_var*
begin
//#UC START# *4728C0890017_4A4CB79A02C6set_impl*
 f_SectionExtent := aValue;
//#UC END# *4728C0890017_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetSectionExtent

procedure Tl3CanvasPrim.pm_SetNotFocused(aValue: Boolean);
//#UC START# *4728C0BB013B_4A4CB79A02C6set_var*
//#UC END# *4728C0BB013B_4A4CB79A02C6set_var*
begin
//#UC START# *4728C0BB013B_4A4CB79A02C6set_impl*
 f_NotFocused := aValue;
//#UC END# *4728C0BB013B_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetNotFocused

function Tl3CanvasPrim.pm_GetRegionBottomRight: Tl3Point;
//#UC START# *4728C0C90182_4A4CB79A02C6get_var*
//#UC END# *4728C0C90182_4A4CB79A02C6get_var*
begin
//#UC START# *4728C0C90182_4A4CB79A02C6get_impl*
 Result := DP2LP(f_RegionBottomRight);
//#UC END# *4728C0C90182_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetRegionBottomRight

function Tl3CanvasPrim.IsAtomic: Boolean;
 {* Строка для нанного шрифта представляет собой единый объект? }
//#UC START# *475E5BAD0198_4A4CB79A02C6_var*
//#UC END# *475E5BAD0198_4A4CB79A02C6_var*
begin
//#UC START# *475E5BAD0198_4A4CB79A02C6_impl*
 Result := (f_Font <> nil) and f_Font.IsAtomic;
//#UC END# *475E5BAD0198_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.IsAtomic

function Tl3CanvasPrim.FM: Il3FontMetrics;
 {* Метрики шрифта. }
//#UC START# *475E5BED0118_4A4CB79A02C6_var*
//#UC END# *475E5BED0118_4A4CB79A02C6_var*
begin
//#UC START# *475E5BED0118_4A4CB79A02C6_impl*
 if (f_Font = nil) then
  Result := nil
 else
  Result := f_Font.FM;
//#UC END# *475E5BED0118_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.FM

function Tl3CanvasPrim.GetClientRect: Tl3Rect;
//#UC START# *476FA1140319_4A4CB79A02C6_var*
//#UC END# *476FA1140319_4A4CB79A02C6_var*
begin
//#UC START# *476FA1140319_4A4CB79A02C6_impl*
 Result := DoGetClientRect;
//#UC END# *476FA1140319_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.GetClientRect

function Tl3CanvasPrim.AdjustMarginsByPrintableArea(const aMargins: Tl3_Rect): Tl3_Rect;
 {* Откорректировать поля с учетом непечатаемой области }
//#UC START# *4776171C037B_4A4CB79A02C6_var*
var
 l_PrintableArea: Tl3_Rect;
//#UC END# *4776171C037B_4A4CB79A02C6_var*
begin
//#UC START# *4776171C037B_4A4CB79A02C6_impl*
 if Printing then
 begin
  l_PrintableArea := CalcPrintableArea;
  Result.Left := Max(aMargins.Left, l_PrintableArea.Left);
  Result.Top := Max(aMargins.Top, l_PrintableArea.Top);
  Result.Right := Max(aMargins.Right, l_PrintableArea.Right);
  Result.Bottom := Max(aMargins.Bottom, l_PrintableArea.Bottom);
 end
 else
  Result := aMargins;
//#UC END# *4776171C037B_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.AdjustMarginsByPrintableArea

function Tl3CanvasPrim.Get_PasswordChar: AnsiChar;
//#UC START# *483D1BCA0045_4A4CB79A02C6get_var*
//#UC END# *483D1BCA0045_4A4CB79A02C6get_var*
begin
//#UC START# *483D1BCA0045_4A4CB79A02C6get_impl*
 Result := f_PasswordChar;
//#UC END# *483D1BCA0045_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_PasswordChar

procedure Tl3CanvasPrim.Set_PasswordChar(aValue: AnsiChar);
//#UC START# *483D1BCA0045_4A4CB79A02C6set_var*
//#UC END# *483D1BCA0045_4A4CB79A02C6set_var*
begin
//#UC START# *483D1BCA0045_4A4CB79A02C6set_impl*
 f_PasswordChar := aValue;
//#UC END# *483D1BCA0045_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.Set_PasswordChar

function Tl3CanvasPrim.Get_EffectiveColors: Il3EffectiveColors;
//#UC START# *487CFBE202B1_4A4CB79A02C6get_var*
//#UC END# *487CFBE202B1_4A4CB79A02C6get_var*
begin
//#UC START# *487CFBE202B1_4A4CB79A02C6get_impl*
 Result := Self;
//#UC END# *487CFBE202B1_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_EffectiveColors

procedure Tl3CanvasPrim.CheckColors;
//#UC START# *487CFE91037C_4A4CB79A02C6_var*
var
 l_Back: TColor;
 l_Fore: TColor;
 l_BC: TColor;
//#UC END# *487CFE91037C_4A4CB79A02C6_var*
begin
//#UC START# *487CFE91037C_4A4CB79A02C6_impl*
 Inc(f_CheckingColors);
 try
  if (f_CheckingColors = 1) then
  begin
   if Printing then
   begin
    l_BC := BackColor;
    if Invert then
    begin
     VCLFont.Color := TextColor;
     Brush.Color := l_BC;
    end//Invert
    else
    begin
     VCLFont.Color := clWhite;
     Brush.Color := clWhite;
    end;//Invert
   end//Printing
   else
   begin
    l_BC := BackColor;
    if Invert then
    begin
     if NotFocused then
     begin
      l_Fore := TextColor;
      l_Back := clBtnFace
     end//NotFocused
     else
     begin
      l_Fore := InvertColor(TextColor);
      l_Back := clHighlight;
     end;//NotFocused
     if (f_Fore > 0) then
      l_Back := InvertColor(l_BC)
     else
      if f_DarkFore > 0 then
       l_Back := clHighlightText;
     //{$IfDef Nemesis}
     CheckColorsYIQ(l_Fore, l_Back);
     //{$Else Nemesis}
     //evGraph.CheckColors(l_Fore, l_Back);
     //{$EndIf Nemesis}
    end//Invert
    else
    begin
     l_Fore := TextColor;
     l_Back := l_BC;
    end;//Invert
    VCLFont.Color := l_Fore;
    Brush.Color := l_Back;
   end;//Printing
  end;//f_CheckingColors = 1
 finally
  Dec(f_CheckingColors);
 end;//try..finally
//#UC END# *487CFE91037C_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.CheckColors

function Tl3CanvasPrim.Get_FontColor: Tl3Color;
//#UC START# *487D0BDA03C6_4A4CB79A02C6get_var*
//#UC END# *487D0BDA03C6_4A4CB79A02C6get_var*
begin
//#UC START# *487D0BDA03C6_4A4CB79A02C6get_impl*
 Result := VCLFont.Color;
//#UC END# *487D0BDA03C6_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_FontColor

function Tl3CanvasPrim.pm_GetPrinting: Boolean;
//#UC START# *4897E01001E7_4A4CB79A02C6get_var*
//#UC END# *4897E01001E7_4A4CB79A02C6get_var*
begin
//#UC START# *4897E01001E7_4A4CB79A02C6get_impl*
 Result := GetPrinting;
//#UC END# *4897E01001E7_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetPrinting

function Tl3CanvasPrim.CheckConvertString(const aStr: Tl3PCharLen): Tl3PCharLen;
 {* преобразует строку для отображения форматирующей информации в режиме DrawSpecial. }
//#UC START# *4A0BD46901A0_4A4CB79A02C6_var*
var
 l_Index : Integer;   
//#UC END# *4A0BD46901A0_4A4CB79A02C6_var*
begin
//#UC START# *4A0BD46901A0_4A4CB79A02C6_impl*
 {$IfDef l3Requires_m0}
 Result := CheckOutString(aStr);
 case Result.SCodePage of
  CP_Unicode:
  begin
   for l_Index := 0 to Pred(Result.SLen) do
    case PWideChar(Result.S)[l_Index] of
     cc_HardSpace:
      PWideChar(Result.S)[l_Index] := cc_HardSpaceSymbol;
     cc_SoftSpace:
      PWideChar(Result.S)[l_Index] := cc_SoftSpaceSymbol;
    end;//case PWideChar(aStr.S)[l_Index]
  end;//CP_Unicode
  CP_OEM,
  CP_OEMLite,
  CP_TatarOEM,
  CP_RussianDOS:
   m2xltConvertBuffEx(Result.S, aStr.SLen, Pm2XLTTable08(CheckConvertTable(true))^);
  else
   m2xltConvertBuffEx(Result.S, aStr.SLen, Pm2XLTTable08(CheckConvertTable(false))^);
  // - другие кодировки никуда пока не переводим
 end;//Case Result.SCodePage
 {$Else  l3Requires_m0}
 Result := aStr;
 {$EndIf  l3Requires_m0}
//#UC END# *4A0BD46901A0_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.CheckConvertString

function Tl3CanvasPrim.CheckOutString(const aStr: Tl3PCharLen): Tl3PCharLen;
//#UC START# *4A0BD4D4007E_4A4CB79A02C6_var*
//#UC END# *4A0BD4D4007E_4A4CB79A02C6_var*
begin
//#UC START# *4A0BD4D4007E_4A4CB79A02C6_impl*
 if (f_OutString = nil) then
  f_OutString := Tl3String.Make(aStr)
 else
  f_OutString.AsPCharLen := aStr;
 Result := f_OutString.AsPCharLen;
//#UC END# *4A0BD4D4007E_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.CheckOutString

function Tl3CanvasPrim.pm_GetZoom: Integer;
//#UC START# *4A4B894303D5_4A4CB79A02C6get_var*
//#UC END# *4A4B894303D5_4A4CB79A02C6get_var*
begin
//#UC START# *4A4B894303D5_4A4CB79A02C6get_impl*
 Result := f_Zoom;
//#UC END# *4A4B894303D5_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetZoom

procedure Tl3CanvasPrim.pm_SetZoom(aValue: Integer);
//#UC START# *4A4B894303D5_4A4CB79A02C6set_var*
//#UC END# *4A4B894303D5_4A4CB79A02C6set_var*
begin
//#UC START# *4A4B894303D5_4A4CB79A02C6set_impl*
 f_Zoom := aValue;
//#UC END# *4A4B894303D5_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetZoom

function Tl3CanvasPrim.Get_Width: Tl3Inch;
//#UC START# *4A4CD82A0310_4A4CB79A02C6get_var*
//#UC END# *4A4CD82A0310_4A4CB79A02C6get_var*
begin
//#UC START# *4A4CD82A0310_4A4CB79A02C6get_impl*
 Result := DoGetPageSetupWidth;
//#UC END# *4A4CD82A0310_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_Width

function Tl3CanvasPrim.Get_Height: Tl3Inch;
//#UC START# *4A4CD82E025B_4A4CB79A02C6get_var*
//#UC END# *4A4CD82E025B_4A4CB79A02C6get_var*
begin
//#UC START# *4A4CD82E025B_4A4CB79A02C6get_impl*
 Result := DoGetPageSetupHeight;
//#UC END# *4A4CD82E025B_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_Height

function Tl3CanvasPrim.pm_GetPaperWidth: Tl3Inch;
//#UC START# *4A4CD8320146_4A4CB79A02C6get_var*
//#UC END# *4A4CD8320146_4A4CB79A02C6get_var*
begin
//#UC START# *4A4CD8320146_4A4CB79A02C6get_impl*
 Result := DoGetPaperWidth;
//#UC END# *4A4CD8320146_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetPaperWidth

function Tl3CanvasPrim.pm_GetPaperHeight: Tl3Inch;
//#UC START# *4A4CD8350157_4A4CB79A02C6get_var*
//#UC END# *4A4CD8350157_4A4CB79A02C6get_var*
begin
//#UC START# *4A4CD8350157_4A4CB79A02C6get_impl*
 Result := DP2LP(PointY(DeviceCaps(PHYSICALHEIGHT))).Y;
//#UC END# *4A4CD8350157_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetPaperHeight

function Tl3CanvasPrim.pm_GetMargins: Tl3_Rect;
//#UC START# *4A4CD83F0022_4A4CB79A02C6get_var*
var
 l_Ofs : Tl3Point;
//#UC END# *4A4CD83F0022_4A4CB79A02C6get_var*
begin
//#UC START# *4A4CD83F0022_4A4CB79A02C6get_impl*
 l_Ofs := DP2LP(l3SPoint(DeviceCaps(PHYSICALOFFSETX),
                         DeviceCaps(PHYSICALOFFSETY)));
 Result := f_Margins;
 Result.Left := Max(l_Ofs.X, Result.Left);
 Result.Top := Max(l_Ofs.Y, Result.Top);
 l_Ofs := DP2LP(l3SPoint(DeviceCaps(PHYSICALWIDTH) - DeviceCaps(HORZRES),
                         DeviceCaps(PHYSICALHEIGHT) - DeviceCaps(VERTRES))).Sub(l_Ofs);
 Result.Right := Max(l_Ofs.X, Result.Right);
//#UC END# *4A4CD83F0022_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetMargins

procedure Tl3CanvasPrim.pm_SetMargins(const aValue: Tl3_Rect);
//#UC START# *4A4CD83F0022_4A4CB79A02C6set_var*
//#UC END# *4A4CD83F0022_4A4CB79A02C6set_var*
begin
//#UC START# *4A4CD83F0022_4A4CB79A02C6set_impl*
 f_Margins := aValue;
//#UC END# *4A4CD83F0022_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetMargins

function Tl3CanvasPrim.pm_GetPageSetup: Il3PageSetup;
//#UC START# *4A4CD86601B2_4A4CB79A02C6get_var*
//#UC END# *4A4CD86601B2_4A4CB79A02C6get_var*
begin
//#UC START# *4A4CD86601B2_4A4CB79A02C6get_impl*
 Result := Self;
//#UC END# *4A4CD86601B2_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetPageSetup

procedure Tl3CanvasPrim.pm_SetPainter(const aValue: Il3HAFPainter);
//#UC START# *4A4CD8BC027E_4A4CB79A02C6set_var*
//#UC END# *4A4CD8BC027E_4A4CB79A02C6set_var*
begin
//#UC START# *4A4CD8BC027E_4A4CB79A02C6set_impl*
 Painter := aValue;
//#UC END# *4A4CD8BC027E_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetPainter

function Tl3CanvasPrim.pm_GetCanvas: TCanvas;
//#UC START# *4A4CD9100133_4A4CB79A02C6get_var*
//#UC END# *4A4CD9100133_4A4CB79A02C6get_var*
begin
//#UC START# *4A4CD9100133_4A4CB79A02C6get_impl*
 if (f_Canvas = nil) then
 begin
  if (f_Printer <> nil) and not IsPreview then
   Canvas := f_Printer.Canvas
  else
   SetCanvas(TCanvas.Create, False);
 end;//f_Canvas = nil
 Result := f_Canvas;
 if (f_Printer <> nil) and f_Printer.Printing and (Result <> f_Printer.Canvas) then
 begin
  if (Result <> nil) then
   try
    Result.Handle;
   except
    on EInvalidOperation do
     Result := f_Printer.Canvas;
     // так хитро, чтобы починить http://mdp.garant.ru/pages/viewpage.action?pageId=112722934, но не сломать http://mdp.garant.ru/pages/viewpage.action?pageId=109085576
     // видимо по уму надо использовать полиморфизм в TafwCanvasEx
   end;//try..except
 end;//f_Printer <> nil..
//#UC END# *4A4CD9100133_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetCanvas

function Tl3CanvasPrim.DP2LP(const aP: Tl3_SPoint): Tl3Point;
 {* Преобразует точку в пикселях в точку в дюймах }
//#UC START# *4A4CE0990013_4A4CB79A02C6_var*
//#UC END# *4A4CE0990013_4A4CB79A02C6_var*
begin
//#UC START# *4A4CE0990013_4A4CB79A02C6_impl*
 if (aP.X = MaxInt) then
  Result.X := aP.X
 else
  Result.X := l3MulDiv(aP.X, l3Inch, PixelsPerInchX);
 if (aP.Y = MaxInt) then
  Result.Y := aP.Y
 else
  Result.Y := l3MulDiv(aP.Y, l3Inch, PixelsPerInchY);
//#UC END# *4A4CE0990013_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DP2LP

function Tl3CanvasPrim.DeviceCaps(anIndex: Integer): Integer;
 {* возвращает свойства устройства рисования. }
//#UC START# *4A4CEC6202C3_4A4CB79A02C6_var*
//#UC END# *4A4CEC6202C3_4A4CB79A02C6_var*
begin
//#UC START# *4A4CEC6202C3_4A4CB79A02C6_impl*
 with f_DeviceCaps do
 begin
  if not rIsAssigned then
   AssignDeviceCaps;
  case anIndex of
   LOGPIXELSX:
    Result := rLOGPIXELSX;
   LOGPIXELSY:
    Result := rLOGPIXELSY;
   HORZRES:
    Result := rHORZRES;
   VERTRES:
    Result := rVERTRES;
   PHYSICALWIDTH:
    if (f_Printer = nil) OR (f_Printer.Orientation = f_PageOrientation) then
     Result := rPHYSICALWIDTH
    else
     Result := rPHYSICALHEIGHT;
   PHYSICALHEIGHT:
    if (f_Printer = nil) OR (f_Printer.Orientation = f_PageOrientation) then
     Result := rPHYSICALHEIGHT
    else
     Result := rPHYSICALWIDTH;
   PHYSICALOFFSETX:
    if (f_Printer = nil) OR (f_Printer.Orientation = f_PageOrientation) {OR
       (f_PageOrientation = l3_poPortrait)} then
     Result := rPHYSICALOFFSETX
    else
     Result := rPHYSICALOFFSETY;
   PHYSICALOFFSETY:
    if (f_Printer = nil) OR (f_Printer.Orientation = f_PageOrientation) {OR
       (f_PageOrientation = l3_poPortrait)} then
     Result := rPHYSICALOFFSETY
    else
     Result := rPHYSICALOFFSETX;
   else
   begin
    Lock;
    try
     Result := Windows.GetDeviceCaps(DC, anIndex);
    finally
     Unlock;
    end;//try..finally
   end;//else
  end;//case anIndex
 end;//with f_DeviceCaps
//#UC END# *4A4CEC6202C3_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DeviceCaps

function Tl3CanvasPrim.Get_IsPagesCounter: Boolean;
//#UC START# *4CB32CEA01FE_4A4CB79A02C6get_var*
//#UC END# *4CB32CEA01FE_4A4CB79A02C6get_var*
begin
//#UC START# *4CB32CEA01FE_4A4CB79A02C6get_impl*
 Result := GetIsPagesCounter;
//#UC END# *4CB32CEA01FE_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_IsPagesCounter

function Tl3CanvasPrim.Get_OverallPageNumber: Integer;
//#UC START# *4CC68B5D00CA_4A4CB79A02C6get_var*
//#UC END# *4CC68B5D00CA_4A4CB79A02C6get_var*
begin
//#UC START# *4CC68B5D00CA_4A4CB79A02C6get_impl*
 if Printing then
  Result := f_OverallPageNumber
 else
  Result := -1;
//#UC END# *4CC68B5D00CA_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_OverallPageNumber

function Tl3CanvasPrim.Get_InitialDCOffset: Tl3Point;
//#UC START# *4E007CC302AE_4A4CB79A02C6get_var*
//#UC END# *4E007CC302AE_4A4CB79A02C6get_var*
begin
//#UC START# *4E007CC302AE_4A4CB79A02C6get_impl*
 Result := f_InitialDCOffset;
//#UC END# *4E007CC302AE_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_InitialDCOffset

function Tl3CanvasPrim.PushClipRect: Tl3Rect;
//#UC START# *4E26F481005B_4A4CB79A02C6_var*
//#UC END# *4E26F481005B_4A4CB79A02C6_var*
begin
//#UC START# *4E26F481005B_4A4CB79A02C6_impl*
 if (f_ClipRects = nil) then
  f_ClipRects := Tl3RectList.Create;
 Result := GetGlobalClipRectWithZoom;
 f_ClipRects.Add(Result);
 Result := Result.AddPt(WindowOrg);
//#UC END# *4E26F481005B_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.PushClipRect

procedure Tl3CanvasPrim.PopClipRect;
//#UC START# *4E26F4920228_4A4CB79A02C6_var*
var
 l_ClipRect: Tl3Rect;
//#UC END# *4E26F4920228_4A4CB79A02C6_var*
begin
//#UC START# *4E26F4920228_4A4CB79A02C6_impl*
 ClipRect := f_ClipRects.Last.AddPt(WindowOrg);
 f_ClipRects.Delete(f_ClipRects.Hi);
//#UC END# *4E26F4920228_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.PopClipRect

procedure Tl3CanvasPrim.Set_ClipRegion(const aValue: Il3Region);
//#UC START# *4E27061B0140_4A4CB79A02C6set_var*
var
 l_R : Il3Region;
//#UC END# *4E27061B0140_4A4CB79A02C6set_var*
begin
//#UC START# *4E27061B0140_4A4CB79A02C6set_impl*
 l_R := aValue.Clone;
 l_R.Offset(SWindowOrg.Neg);
 SelectClipRgn(DC, l_R.Rgn);
 f_ClipRectInited := false;
//#UC END# *4E27061B0140_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.Set_ClipRegion

function Tl3CanvasPrim.Get_LineSpacing: Integer;
//#UC START# *4E57A9F10230_4A4CB79A02C6get_var*
//#UC END# *4E57A9F10230_4A4CB79A02C6get_var*
begin
//#UC START# *4E57A9F10230_4A4CB79A02C6get_impl*
 Result := f_LineSpacing;
//#UC END# *4E57A9F10230_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_LineSpacing

procedure Tl3CanvasPrim.Set_LineSpacing(aValue: Integer);
//#UC START# *4E57A9F10230_4A4CB79A02C6set_var*
//#UC END# *4E57A9F10230_4A4CB79A02C6set_var*
begin
//#UC START# *4E57A9F10230_4A4CB79A02C6set_impl*
 if (aValue <= 0) OR (aValue >= Pred(High(Integer))) then
  Exit; 
 f_LineSpacing := aValue;
//#UC END# *4E57A9F10230_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.Set_LineSpacing

procedure Tl3CanvasPrim.PushLineSpacing;
//#UC START# *4E6894860139_4A4CB79A02C6_var*
//#UC END# *4E6894860139_4A4CB79A02C6_var*
begin
//#UC START# *4E6894860139_4A4CB79A02C6_impl*
 if (f_LineSpacingStack = nil) then
  f_LineSpacingStack := Tl3LongintList.Create;
 f_LineSpacingStack.Add(f_LineSpacing); 
//#UC END# *4E6894860139_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.PushLineSpacing

procedure Tl3CanvasPrim.PopLineSpacing;
//#UC START# *4E68949A0121_4A4CB79A02C6_var*
//#UC END# *4E68949A0121_4A4CB79A02C6_var*
begin
//#UC START# *4E68949A0121_4A4CB79A02C6_impl*
 Assert(f_LineSpacingStack <> nil);
 Set_LineSpacing(f_LineSpacingStack.Last);
 f_LineSpacingStack.Delete(f_LineSpacingStack.Hi);
//#UC END# *4E68949A0121_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.PopLineSpacing

function Tl3CanvasPrim.pm_GetInvert: Boolean;
//#UC START# *4ED5066F036B_4A4CB79A02C6get_var*
//#UC END# *4ED5066F036B_4A4CB79A02C6get_var*
begin
//#UC START# *4ED5066F036B_4A4CB79A02C6get_impl*
 Result := (f_Invert > 0);
//#UC END# *4ED5066F036B_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetInvert

function Tl3CanvasPrim.Get_InitialDCOffsetStored: Tl3Point;
//#UC START# *4F2AC2020377_4A4CB79A02C6get_var*
//#UC END# *4F2AC2020377_4A4CB79A02C6get_var*
begin
//#UC START# *4F2AC2020377_4A4CB79A02C6get_impl*
 Result := f_InitialDCOffsetStored;
//#UC END# *4F2AC2020377_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_InitialDCOffsetStored

function Tl3CanvasPrim.pm_GetFrameLines: Il3FrameLines;
//#UC START# *5077CF6501AE_4A4CB79A02C6get_var*
//#UC END# *5077CF6501AE_4A4CB79A02C6get_var*
begin
//#UC START# *5077CF6501AE_4A4CB79A02C6get_impl*
 if f_FrameLines = nil then
  f_FrameLines := Tl3FrameLines.Make;
 Result := f_FrameLines;
//#UC END# *5077CF6501AE_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetFrameLines

function Tl3CanvasPrim.Get_AbortChecker: Il3AbortChecker;
//#UC START# *5229D7EF00DE_4A4CB79A02C6get_var*
//#UC END# *5229D7EF00DE_4A4CB79A02C6get_var*
begin
//#UC START# *5229D7EF00DE_4A4CB79A02C6get_impl*
 Result := f_AbortChecker;
//#UC END# *5229D7EF00DE_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_AbortChecker

procedure Tl3CanvasPrim.Set_AbortChecker(const aValue: Il3AbortChecker);
//#UC START# *5229D7EF00DE_4A4CB79A02C6set_var*
//#UC END# *5229D7EF00DE_4A4CB79A02C6set_var*
begin
//#UC START# *5229D7EF00DE_4A4CB79A02C6set_impl*
 f_AbortChecker := aValue;
//#UC END# *5229D7EF00DE_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.Set_AbortChecker

procedure Tl3CanvasPrim.StartDrawAAC(aType: TspBlockType);
//#UC START# *54B4D8E90117_4A4CB79A02C6_var*
//#UC END# *54B4D8E90117_4A4CB79A02C6_var*
begin
//#UC START# *54B4D8E90117_4A4CB79A02C6_impl*
 DoStartDrawAAC(aType);
//#UC END# *54B4D8E90117_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.StartDrawAAC

procedure Tl3CanvasPrim.EndDrawAAC(const R: Tl3Rect);
//#UC START# *54B4D9020149_4A4CB79A02C6_var*
//#UC END# *54B4D9020149_4A4CB79A02C6_var*
begin
//#UC START# *54B4D9020149_4A4CB79A02C6_impl*
 DoEndDrawAAC(R);
//#UC END# *54B4D9020149_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.EndDrawAAC

procedure Tl3CanvasPrim.BeginDarkColor;
//#UC START# *55CC51AD0273_4A4CB79A02C6_var*
//#UC END# *55CC51AD0273_4A4CB79A02C6_var*
begin
//#UC START# *55CC51AD0273_4A4CB79A02C6_impl*
 Inc(f_DarkFore);
//#UC END# *55CC51AD0273_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.BeginDarkColor

procedure Tl3CanvasPrim.EndDarkColor;
//#UC START# *55CC51CE0059_4A4CB79A02C6_var*
//#UC END# *55CC51CE0059_4A4CB79A02C6_var*
begin
//#UC START# *55CC51CE0059_4A4CB79A02C6_impl*
 Dec(f_DarkFore);
//#UC END# *55CC51CE0059_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.EndDarkColor

procedure Tl3CanvasPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A4CB79A02C6_var*
//#UC END# *479731C50290_4A4CB79A02C6_var*
begin
//#UC START# *479731C50290_4A4CB79A02C6_impl*
 f_Printer := nil;
 FreeAndNil(f_ClipRects);
 FreeAndNil(f_LineSpacingStack);
 inherited;
//#UC END# *479731C50290_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.Cleanup

procedure Tl3CanvasPrim.InitFields;
//#UC START# *47A042E100E2_4A4CB79A02C6_var*
//#UC END# *47A042E100E2_4A4CB79A02C6_var*
begin
//#UC START# *47A042E100E2_4A4CB79A02C6_impl*
 inherited;
 f_Margins := l3Rect(0, 0, 0, def_inchPaperBottom);
 f_DeviceCaps.rIsAssigned := false;
 f_LineSpacing := def_LineSpacing;
//#UC END# *47A042E100E2_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.InitFields

procedure Tl3CanvasPrim.ClearFields;
begin
 Finalize(SectionExtent);
 Painter := nil;
 AbortChecker := nil;
 inherited;
end;//Tl3CanvasPrim.ClearFields

end.
