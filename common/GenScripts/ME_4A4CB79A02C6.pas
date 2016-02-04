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
 , l3Defaults
 , l3Core
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

 Tl3CanvasPrim = class(Tl3ProtoObject, Il3Font, Il3PageSetup, Il3EffectiveColors)
  private
   f_Margins: Tl3_Rect;
   f_ClipRects: Tl3RectList;
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
   f_BackColor: TColor;
    {* Поле для свойства BackColor }
   f_NotFocused: Boolean;
    {* Поле для свойства NotFocused }
   f_Canvas: TCanvas;
    {* Поле для свойства Canvas }
   f_Owner: TObject;
    {* Поле для свойства Owner }
   f_Zoom: Integer;
    {* Поле для свойства Zoom }
   f_OnDrawSpecialChange: TNotifyEvent;
    {* Поле для свойства OnDrawSpecialChange }
  protected
   f_Printer: Il3Printer;
   f_DeviceCaps: Tl3DeviceCaps;
   f_PageNumber: Integer;
   f_PageWidthNumber: Integer;
   f_OverallPageNumber: Integer;
   f_InitialDCOffset: Tl3Point;
   f_ClipRectInited: Boolean;
   f_LineSpacing: Integer;
   f_InitialDCOffsetStored: Tl3Point;
   f_CheckingColors: Integer;
   f_TextColor: TColor;
   f_DC: hDC;
   f_DCFlag: TevDCFlag;
   f_TextMetricsValid: Boolean;
   f_SuffixedFont: Boolean;
   f_AverageCharHeight: Integer;
   f_AverageCharWidth: Integer;
   f_pxAverageCharWidth: Integer;
   f_Font: Il3Font;
  protected
   function pm_GetPrinting: Boolean;
   procedure pm_SetPrinting(aValue: Boolean);
   function pm_GetCanDrawSubs: Boolean;
   function pm_GetPixelsPerInchX: Integer;
   function pm_GetPixelsPerInchY: Integer;
   function pm_GetWindowOrg: Tl3Point; virtual; abstract;
   procedure pm_SetWindowOrg(const aValue: Tl3Point); virtual; abstract;
   function pm_GetGlobalClipRect: Tl3Rect; virtual; abstract;
   function pm_GetClipRect: Tl3Rect; virtual; abstract;
   procedure pm_SetClipRect(const aValue: Tl3Rect); virtual; abstract;
   function pm_GetDC: hDC;
   function pm_GetSWindowOrg: Tl3SPoint; virtual; abstract;
   procedure pm_SetSWindowOrg(const aValue: Tl3SPoint); virtual; abstract;
   function pm_GetBackColor: TColor;
   procedure pm_SetBackColor(aValue: TColor);
   function pm_GetDrawEnabled: Boolean;
   procedure pm_SetDrawEnabled(aValue: Boolean);
   function pm_GetDrawing: Boolean;
   function pm_GetInvert: Boolean;
   function pm_GetVCLFont: TFont;
   procedure pm_SetVCLFont(aValue: TFont);
   function pm_GetTextColor: TColor;
   procedure pm_SetTextColor(aValue: TColor);
   function pm_GetBrush: TBrush;
   procedure pm_SetBrush(aValue: TBrush);
   function pm_GetDCFlag: TevDCFlag;
   function pm_GetCanvas: TCanvas;
   procedure pm_SetCanvas(aValue: TCanvas);
   function pm_GetZoom: Integer;
   procedure pm_SetZoom(aValue: Integer);
   function pm_GetPen: TPen;
   procedure pm_SetPen(aValue: TPen);
   function pm_GetShowCursor: Boolean;
   procedure pm_SetShowCursor(aValue: Boolean);
   function pm_GetPrinted: Boolean;
   procedure pm_SetPrinted(aValue: Boolean);
   function pm_GetDrawSpecial: Boolean;
   procedure pm_SetDrawSpecial(aValue: Boolean);
   function CalcPrintableArea: Tl3_Rect;
   procedure DrawSub(aSubTarget: TObject;
    const R: Tl3Rect;
    LayerHandle: Integer;
    aSub: TObject);
   procedure UpdatePixelsPerInch;
   function GetIsPagesCounter: Boolean; virtual;
   function GetGlobalClipRectWithZoom: Tl3Rect; virtual;
   function BeginDrawing: Integer;
   function EndDrawing: Integer;
   procedure BeginInvert;
   procedure EndInvert;
   procedure BeginDarkColor;
   procedure EndDarkColor;
   function DrawingIsValid: Boolean;
   function IsVirtual: Boolean; virtual;
   function CheckDrawing: Boolean;
   procedure BrushChanged(Sender: TObject);
   procedure FontChanged(Sender: TObject);
   procedure FreeDC;
   procedure FreeAlienDC(aDC: hDC); virtual;
   procedure FireDCSetToNull; virtual;
   function IsPreview: Boolean; virtual;
   procedure Invalidate; virtual;
   function DoGetPageSetupWidth: Tl3Inch; virtual;
   function DoGetPageSetupHeight: Tl3Inch; virtual;
   function DoGetDrawEnabled: Boolean; virtual;
   function DeviceCaps(anIndex: Integer): Integer; virtual; abstract;
   function GetPrinting: Boolean; virtual;
   function AsIl3Canvas: Il3Canvas; virtual; abstract;
   procedure AssignDeviceCaps; virtual; abstract;
    {* Инициализировать информацию об устройстве }
   function DoGetPaperWidth: Tl3Inch; virtual;
   procedure DoFillForeRect(const R: Tl3SRect); virtual;
   function GetAlienDC: hDC; virtual;
   procedure FillRectPrim(const R: TRect); virtual;
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
   procedure Lock;
   procedure Unlock;
   function HF: hFont;
   function pm_GetPageNumber: Integer;
   function pm_GetPageWidthNumber: Integer;
   function IsAtomic: Boolean;
    {* Строка для нанного шрифта представляет собой единый объект? }
   function FM: Il3FontMetrics;
    {* Метрики шрифта. }
   procedure CheckColors;
   function Get_Font: Il3Font;
   function Get_FontColor: Tl3Color;
   function Get_Width: Tl3Inch;
   function Get_Height: Tl3Inch;
   function pm_GetPaperWidth: Tl3Inch;
   function pm_GetPaperHeight: Tl3Inch;
   function pm_GetMargins: Tl3_Rect;
   procedure pm_SetMargins(const aValue: Tl3_Rect);
   function Get_IsPagesCounter: Boolean;
   function Get_OverallPageNumber: Integer;
   function Get_InitialDCOffset: Tl3Point;
   procedure Set_ClipRegion(const aValue: Il3Region);
   function Get_LineSpacing: Integer;
   procedure Set_LineSpacing(aValue: Integer);
   function Get_InitialDCOffsetStored: Tl3Point;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   procedure FillRect(const R: Tl3SRect); overload; virtual; abstract;
   procedure FillRect(const R: Tl3Rect); overload; virtual; abstract;
   constructor CreateOwned(anOwner: TObject); reintroduce;
   constructor CreateForPrinting(const aPrinter: Il3Printer); reintroduce;
   procedure SetCanvas(aValue: TCanvas;
    anAlien: Boolean); virtual;
   function DP2LP(const aP: Tl3_SPoint): Tl3Point;
    {* Преобразует точку в пикселях в точку в дюймах }
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
   property GlobalClipRect: Tl3Rect
    read pm_GetGlobalClipRect;
   property ClipRect: Tl3Rect
    read pm_GetClipRect
    write pm_SetClipRect;
   property DC: hDC
    read pm_GetDC;
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
    read pm_GetDCFlag;
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
 , l3Types
 , l3FontManager
 , l3FontTools
;

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

function Tl3CanvasPrim.pm_GetPrinting: Boolean;
//#UC START# *4A4CBF0003DF_4A4CB79A02C6get_var*
//#UC END# *4A4CBF0003DF_4A4CB79A02C6get_var*
begin
//#UC START# *4A4CBF0003DF_4A4CB79A02C6get_impl*
 Result := GetPrinting;
//#UC END# *4A4CBF0003DF_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetPrinting

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

function Tl3CanvasPrim.pm_GetCanDrawSubs: Boolean;
//#UC START# *4A4CC10D01A1_4A4CB79A02C6get_var*
//#UC END# *4A4CC10D01A1_4A4CB79A02C6get_var*
begin
//#UC START# *4A4CC10D01A1_4A4CB79A02C6get_impl*
 Result := DoGetDrawEnabled AND Assigned(f_OnDrawSub);
//#UC END# *4A4CC10D01A1_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetCanDrawSubs

function Tl3CanvasPrim.pm_GetPixelsPerInchX: Integer;
//#UC START# *4A4CC95D0147_4A4CB79A02C6get_var*
//#UC END# *4A4CC95D0147_4A4CB79A02C6get_var*
begin
//#UC START# *4A4CC95D0147_4A4CB79A02C6get_impl*
 Result := f_PixelsPerInchX;
 if (Result = 0) then 
 begin
  f_PixelsPerInchX := DeviceCaps(LOGPIXELSX);
  Result := f_PixelsPerInchX;
 end;
//#UC END# *4A4CC95D0147_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetPixelsPerInchX

function Tl3CanvasPrim.pm_GetPixelsPerInchY: Integer;
//#UC START# *4A4CC9830334_4A4CB79A02C6get_var*
//#UC END# *4A4CC9830334_4A4CB79A02C6get_var*
begin
//#UC START# *4A4CC9830334_4A4CB79A02C6get_impl*
 Result := f_PixelsPerInchY;
 if (Result = 0) then
 begin
  f_PixelsPerInchY := DeviceCaps(LOGPIXELSY);
  Result := f_PixelsPerInchY;
 end;//Result = 0
//#UC END# *4A4CC9830334_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetPixelsPerInchY

function Tl3CanvasPrim.pm_GetDC: hDC;
//#UC START# *4E2706890370_4A4CB79A02C6get_var*
//#UC END# *4E2706890370_4A4CB79A02C6get_var*
begin
//#UC START# *4E2706890370_4A4CB79A02C6get_impl*
 CheckDrawing;
 Result := HDC(f_DC);
//#UC END# *4E2706890370_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetDC

function Tl3CanvasPrim.pm_GetBackColor: TColor;
//#UC START# *56ACD2F50038_4A4CB79A02C6get_var*
//#UC END# *56ACD2F50038_4A4CB79A02C6get_var*
begin
//#UC START# *56ACD2F50038_4A4CB79A02C6get_impl*
 Result := f_BackColor;
//#UC END# *56ACD2F50038_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetBackColor

procedure Tl3CanvasPrim.pm_SetBackColor(aValue: TColor);
//#UC START# *56ACD2F50038_4A4CB79A02C6set_var*
//#UC END# *56ACD2F50038_4A4CB79A02C6set_var*
begin
//#UC START# *56ACD2F50038_4A4CB79A02C6set_impl*
 if (f_BackColor <> aValue) and (aValue <> clDefault) then
 begin
  f_BackColor := aValue;
  if DrawEnabled and Drawing then
   CheckColors;
 end;//f_BackColor <> Value
//#UC END# *56ACD2F50038_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetBackColor

function Tl3CanvasPrim.pm_GetDrawEnabled: Boolean;
//#UC START# *56ACD37202DE_4A4CB79A02C6get_var*
//#UC END# *56ACD37202DE_4A4CB79A02C6get_var*
begin
//#UC START# *56ACD37202DE_4A4CB79A02C6get_impl*
 Result := DoGetDrawEnabled;
//#UC END# *56ACD37202DE_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetDrawEnabled

procedure Tl3CanvasPrim.pm_SetDrawEnabled(aValue: Boolean);
//#UC START# *56ACD37202DE_4A4CB79A02C6set_var*
//#UC END# *56ACD37202DE_4A4CB79A02C6set_var*
begin
//#UC START# *56ACD37202DE_4A4CB79A02C6set_impl*
 if aValue then
  Flags := Flags + [ev_dfDrawRegion]
 else
  Flags := Flags - [ev_dfDrawRegion];
//#UC END# *56ACD37202DE_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetDrawEnabled

function Tl3CanvasPrim.pm_GetDrawing: Boolean;
//#UC START# *56ACD3C302A5_4A4CB79A02C6get_var*
//#UC END# *56ACD3C302A5_4A4CB79A02C6get_var*
begin
//#UC START# *56ACD3C302A5_4A4CB79A02C6get_impl*
 Result := (f_Drawing > 0);
//#UC END# *56ACD3C302A5_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetDrawing

function Tl3CanvasPrim.pm_GetInvert: Boolean;
//#UC START# *56ACDB3A0069_4A4CB79A02C6get_var*
//#UC END# *56ACDB3A0069_4A4CB79A02C6get_var*
begin
//#UC START# *56ACDB3A0069_4A4CB79A02C6get_impl*
 Result := (f_Invert > 0);
//#UC END# *56ACDB3A0069_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetInvert

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

function Tl3CanvasPrim.pm_GetCanvas: TCanvas;
//#UC START# *56AF20BB0209_4A4CB79A02C6get_var*
//#UC END# *56AF20BB0209_4A4CB79A02C6get_var*
begin
//#UC START# *56AF20BB0209_4A4CB79A02C6get_impl*
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
//#UC END# *56AF20BB0209_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetCanvas

procedure Tl3CanvasPrim.pm_SetCanvas(aValue: TCanvas);
//#UC START# *56AF20BB0209_4A4CB79A02C6set_var*
//#UC END# *56AF20BB0209_4A4CB79A02C6set_var*
begin
//#UC START# *56AF20BB0209_4A4CB79A02C6set_impl*
 SetCanvas(aValue, True);
//#UC END# *56AF20BB0209_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetCanvas

function Tl3CanvasPrim.pm_GetZoom: Integer;
//#UC START# *56AF4E2C005D_4A4CB79A02C6get_var*
//#UC END# *56AF4E2C005D_4A4CB79A02C6get_var*
begin
//#UC START# *56AF4E2C005D_4A4CB79A02C6get_impl*
 Result := f_Zoom;
//#UC END# *56AF4E2C005D_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetZoom

procedure Tl3CanvasPrim.pm_SetZoom(aValue: Integer);
//#UC START# *56AF4E2C005D_4A4CB79A02C6set_var*
//#UC END# *56AF4E2C005D_4A4CB79A02C6set_var*
begin
//#UC START# *56AF4E2C005D_4A4CB79A02C6set_impl*
 f_Zoom := aValue;
//#UC END# *56AF4E2C005D_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetZoom

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

function Tl3CanvasPrim.pm_GetShowCursor: Boolean;
//#UC START# *56B09EF400CB_4A4CB79A02C6get_var*
//#UC END# *56B09EF400CB_4A4CB79A02C6get_var*
begin
//#UC START# *56B09EF400CB_4A4CB79A02C6get_impl*
 Result := (ev_dfDrawCursor in Flags);
//#UC END# *56B09EF400CB_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetShowCursor

procedure Tl3CanvasPrim.pm_SetShowCursor(aValue: Boolean);
//#UC START# *56B09EF400CB_4A4CB79A02C6set_var*
//#UC END# *56B09EF400CB_4A4CB79A02C6set_var*
begin
//#UC START# *56B09EF400CB_4A4CB79A02C6set_impl*
 if aValue then
  Flags := Flags + [ev_dfDrawCursor]
 else
  Flags := Flags - [ev_dfDrawCursor];
//#UC END# *56B09EF400CB_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetShowCursor

function Tl3CanvasPrim.pm_GetPrinted: Boolean;
//#UC START# *56B09F1B0198_4A4CB79A02C6get_var*
//#UC END# *56B09F1B0198_4A4CB79A02C6get_var*
begin
//#UC START# *56B09F1B0198_4A4CB79A02C6get_impl*
 Result := not Printing or (ev_dfPrinted in Flags);
//#UC END# *56B09F1B0198_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetPrinted

procedure Tl3CanvasPrim.pm_SetPrinted(aValue: Boolean);
//#UC START# *56B09F1B0198_4A4CB79A02C6set_var*
//#UC END# *56B09F1B0198_4A4CB79A02C6set_var*
begin
//#UC START# *56B09F1B0198_4A4CB79A02C6set_impl*
 if aValue then
  Flags := Flags + [ev_dfPrinted]
 else
  Flags := Flags - [ev_dfPrinted];
//#UC END# *56B09F1B0198_4A4CB79A02C6set_impl*
end;//Tl3CanvasPrim.pm_SetPrinted

function Tl3CanvasPrim.pm_GetDrawSpecial: Boolean;
//#UC START# *56B0ADCF0192_4A4CB79A02C6get_var*
//#UC END# *56B0ADCF0192_4A4CB79A02C6get_var*
begin
//#UC START# *56B0ADCF0192_4A4CB79A02C6get_impl*
 Result := (ev_dfDrawSpecial in Flags);
 Assert(not Result or not Printing, 'http://mdp.garant.ru/pages/viewpage.action?pageId=174295160&focusedCommentId=266409368#comment-266409368');
//#UC END# *56B0ADCF0192_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.pm_GetDrawSpecial

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

procedure Tl3CanvasPrim.DrawSub(aSubTarget: TObject;
 const R: Tl3Rect;
 LayerHandle: Integer;
 aSub: TObject);
//#UC START# *4A4CC1410062_4A4CB79A02C6_var*
//#UC END# *4A4CC1410062_4A4CB79A02C6_var*
begin
//#UC START# *4A4CC1410062_4A4CB79A02C6_impl*
 if CanDrawSubs then
  f_OnDrawSub(aSubTarget, AsIl3Canvas, R, LayerHandle, aSub);
//#UC END# *4A4CC1410062_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DrawSub

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

procedure Tl3CanvasPrim.BeginInvert;
//#UC START# *56ACDB8F020C_4A4CB79A02C6_var*
//#UC END# *56ACDB8F020C_4A4CB79A02C6_var*
begin
//#UC START# *56ACDB8F020C_4A4CB79A02C6_impl*
 Inc(f_Invert);
 if DrawEnabled and Drawing then 
  CheckColors;
//#UC END# *56ACDB8F020C_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.BeginInvert

procedure Tl3CanvasPrim.EndInvert;
//#UC START# *56ACDB9903C9_4A4CB79A02C6_var*
//#UC END# *56ACDB9903C9_4A4CB79A02C6_var*
begin
//#UC START# *56ACDB9903C9_4A4CB79A02C6_impl*
 Dec(f_Invert);
 if DrawEnabled and Drawing then 
  CheckColors;
//#UC END# *56ACDB9903C9_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.EndInvert

procedure Tl3CanvasPrim.BeginDarkColor;
//#UC START# *56AF1B540191_4A4CB79A02C6_var*
//#UC END# *56AF1B540191_4A4CB79A02C6_var*
begin
//#UC START# *56AF1B540191_4A4CB79A02C6_impl*
 Inc(f_DarkFore);
//#UC END# *56AF1B540191_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.BeginDarkColor

procedure Tl3CanvasPrim.EndDarkColor;
//#UC START# *56AF1B6900DF_4A4CB79A02C6_var*
//#UC END# *56AF1B6900DF_4A4CB79A02C6_var*
begin
//#UC START# *56AF1B6900DF_4A4CB79A02C6_impl*
 Dec(f_DarkFore);
//#UC END# *56AF1B6900DF_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.EndDarkColor

function Tl3CanvasPrim.DrawingIsValid: Boolean;
//#UC START# *56AF1E2902D2_4A4CB79A02C6_var*
//#UC END# *56AF1E2902D2_4A4CB79A02C6_var*
begin
//#UC START# *56AF1E2902D2_4A4CB79A02C6_impl*
 Result := not IsVirtual and DrawEnabled and CheckDrawing;
//#UC END# *56AF1E2902D2_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.DrawingIsValid

function Tl3CanvasPrim.IsVirtual: Boolean;
//#UC START# *56AF1E650037_4A4CB79A02C6_var*
//#UC END# *56AF1E650037_4A4CB79A02C6_var*
begin
//#UC START# *56AF1E650037_4A4CB79A02C6_impl*
 Result := False;
//#UC END# *56AF1E650037_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.IsVirtual

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

procedure Tl3CanvasPrim.Lock;
//#UC START# *46A6157B0361_4A4CB79A02C6_var*
//#UC END# *46A6157B0361_4A4CB79A02C6_var*
begin
//#UC START# *46A6157B0361_4A4CB79A02C6_impl*
//#UC END# *46A6157B0361_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.Lock

procedure Tl3CanvasPrim.Unlock;
//#UC START# *46A6158C0275_4A4CB79A02C6_var*
//#UC END# *46A6158C0275_4A4CB79A02C6_var*
begin
//#UC START# *46A6158C0275_4A4CB79A02C6_impl*
//#UC END# *46A6158C0275_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.Unlock

function Tl3CanvasPrim.HF: hFont;
//#UC START# *46A615A10333_4A4CB79A02C6_var*
//#UC END# *46A615A10333_4A4CB79A02C6_var*
begin
//#UC START# *46A615A10333_4A4CB79A02C6_impl*
 Result := VCLFont.Handle;
//#UC END# *46A615A10333_4A4CB79A02C6_impl*
end;//Tl3CanvasPrim.HF

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

function Tl3CanvasPrim.Get_Font: Il3Font;
//#UC START# *487D000802A4_4A4CB79A02C6get_var*
//#UC END# *487D000802A4_4A4CB79A02C6get_var*
begin
//#UC START# *487D000802A4_4A4CB79A02C6get_impl*
 //Result := Self;
 Supports(Self, Il3Font, Result);
//#UC END# *487D000802A4_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_Font

function Tl3CanvasPrim.Get_FontColor: Tl3Color;
//#UC START# *487D0BDA03C6_4A4CB79A02C6get_var*
//#UC END# *487D0BDA03C6_4A4CB79A02C6get_var*
begin
//#UC START# *487D0BDA03C6_4A4CB79A02C6get_impl*
 Result := VCLFont.Color;
//#UC END# *487D0BDA03C6_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_FontColor

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

function Tl3CanvasPrim.Get_InitialDCOffsetStored: Tl3Point;
//#UC START# *4F2AC2020377_4A4CB79A02C6get_var*
//#UC END# *4F2AC2020377_4A4CB79A02C6get_var*
begin
//#UC START# *4F2AC2020377_4A4CB79A02C6get_impl*
 Result := f_InitialDCOffsetStored;
//#UC END# *4F2AC2020377_4A4CB79A02C6get_impl*
end;//Tl3CanvasPrim.Get_InitialDCOffsetStored

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

end.
