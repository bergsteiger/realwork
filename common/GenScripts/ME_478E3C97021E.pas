unit l3Canvas;

interface

uses
 l3IntfUses
 , l3CanvasPrim
 , l3Interfaces
 , l3InternalInterfaces
 , l3Units
 , Windows
 , l3PrinterInterfaces
 , l3Core
 , l3Types
;

type
 Tl3Canvas = class(Tl3CanvasPrim, Il3Font, Il3InfoCanvas, Il3Canvas)
  {* ������ ����������� ���� ������� ���������� ��� TCanvas � Device Context (hDC) }
  function NeedOpenRealPage(aDoc: Boolean;
   ByWidth: Boolean): Tl3OpenPageResult;
  function IsPreview: Boolean;
  procedure SetCanvas(Value: TCanvas;
   Alien: Boolean);
  procedure DoEndPaint;
   {* ���������� ��������� ���������. }
  function GetCaret: Il3Caret;
  function DoGetDrawEnabled: Boolean;
  procedure DoStartPage;
  procedure DoStartObject(anObjectID: Integer);
  procedure DoSetPageTop;
  procedure FillRectPrim(const R: TRect);
  procedure DoFillForeRect(const R: Tl3SRect);
  procedure Invalidate;
  function DoGetClientRect: Tl3Rect;
  procedure FireDCSetToNull;
  procedure FreeAlienDC(aDC: hDC);
  function GetAlienDC: hDC;
  procedure DoStartDrawAAC(aType: TspBlockType);
  procedure DoEndDrawAAC(const R: Tl3Rect);
  function Size: Integer; overload;
   {* �����. }
  function Name: TFontName; overload;
   {* ����������. }
  function Bold: Boolean; overload;
   {* ������? }
  function Italic: Boolean; overload;
   {* ������? }
  function Underline: Boolean; overload;
   {* ������������? }
  function Strikeout: Boolean; overload;
   {* �����������. }
  function ForeColor: Tl3Color; overload;
   {* ���� ������. }
  function BackColor: Tl3Color; overload;
   {* ���� ����. }
  function Pitch: TFontPitch; overload;
   {* �������. }
  function Index: Tl3FontIndex; overload;
   {* ������. }
  function ForeColor: Tl3Color; overload;
   {* ���� ������. }
  function BackColor: Tl3Color; overload;
   {* ���� ����. }
  function Name: TFontName; overload;
   {* ��� ������. }
  function Pitch: TFontPitch; overload;
   {* �������. }
  function Size: Integer; overload;
   {* ������ �����. }
  function Index: Tl3FontIndex; overload;
   {* ������ ������. }
  function Style: TFontStyles;
  function Bold: Boolean; overload;
   {* ������. }
  function Italic: Boolean; overload;
   {* ������. }
  function Underline: Boolean; overload;
   {* �������������. }
  function Strikeout: Boolean; overload;
   {* ������������. }
  function AssignFont(Font: TFont): Boolean;
  procedure Assign2Font(const aFont: Il3Font);
  procedure Lock; overload;
  procedure Unlock; overload;
  function HF: hFont;
  function pxAverageCharWidth: Integer;
   {* ������� ������ �������� ��������� � ��������. }
  function AverageCharWidth: Integer;
   {* ������� ������ �������� ��������� � ������. }
  function TextExtent(const S: Tl3WString;
   aNoTabs: Boolean): Tl3Point;
   {* ���������� ����� ������ ������ � ������. }
  function Pos2Index(W: Integer;
   const S: Tl3PCharLen): Integer;
   {* ������� ������ ������� �� ��������� W ������ �� ������ ������ S. }
  function Pos2IndexQ(W: Integer;
   const S: Tl3PCharLen;
   var aNoTabs: Boolean): Integer;
   {* ������� ������ ������� �� ��������� W ������ �� ������ ������ S. }
  function AverageCharHeight: Integer;
   {* ������� ������ �������� ��������� � ������. }
  function LP2DP(const P: Tl3_Point;
   NeedZoom: Boolean): Tl3SPoint;
   {* ����������� ����� � ������ � ����� � ��������. }
  function LR2DR(const R: Tl3Rect): Tl3SRect;
   {* ����������� ������������� � ������ � ������������� � ��������. }
  function DR2LR(const R: Tl3SRect): Tl3Rect;
   {* ����������� ������������� � �������� � ������������� � ������. }
  procedure Lock; overload;
   {* ������ ������ � ������. }
  procedure Unlock; overload;
   {* ��������� ������ � ������. }
  function GetKerning(const aSt: Tl3WString;
   Kerning: PLong): Tl3Point;
   {* �������� ������� ������ � ������� ��������. }
  function OffsetRgn(const Rgn: Il3Region;
   const Pt: Tl3Point): Integer;
   {* �������� ������. }
  function CaretExtent: Tl3Point;
   {* ������� �������. }
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
   {* ��� �� ����� ������, �� ��� ����� �� �������������� �����, �.�. ��� ��������� ������������� ������. }
  procedure TabbedMultilineTextOut(const aSt: Tl3WString;
   const Tabs: Il3TabStops;
   var Rect: Tl3Rect;
   Precalculate: Boolean;
   aGap: Integer);
   {* ��� �� ����� ������, �� ��� ����� �� �������������� �����, �.�. ��� ��������� ������������� ������. }
  procedure PushBC;
  function TopBC: Tl3Color;
  procedure PopBC;
  procedure PushFC;
  procedure PopFC;
  function TextMetrics: PTextMetric;
  function Font: Il3Font;
   {* ������� �����. }
  function DC: hDC; overload;
   {* Handle ���������. }
  function PixelsPerInchX: Integer;
  function PixelsPerInchY: Integer;
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
   {* ������� ������ ������ ������� LineHeight, �� ������� ������� ���������. ������������� ������ � CaretPos. ���������� ������� ���������� ������. }
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
   {* ������ ����� ��������. }
  procedure Line(const A: Tl3Point;
   const B: Tl3Point); overload;
   {* ���������� �����. }
  procedure Line(const A: Tl3SPoint;
   const B: Tl3SPoint); overload;
   {* ���������� �����. }
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
  function WindowOrg: Tl3Point; overload;
   {* �������� ������ ��������� � ������. }
  function SWindowOrg: Tl3SPoint; overload;
   {* �������� ������ ��������� � ��������. }
  function ClipRect: Tl3Rect; overload;
   {* ������������� ���������. }
  function GlobalClipRect: Tl3Rect; overload;
  function BackColor: Tl3Color; overload;
  function DrawEnabled: Boolean;
   {* ��������� ���������? }
  function DrawSpecial: Boolean;
   {* �������� �����������? }
  function CanDrawSubs: Boolean;
   {* ����� �������� Sub'�? }
  function ShowCursor: Boolean;
   {* ���������� ������? }
  function FontIndexSet: Tl3FontIndexes;
   {* ������� ����� �������� ������. }
  function Printed: Boolean;
   {* ��� ����������? }
  function PenWidth: Integer;
   {* ������ ����. }
  function PageOrientation: Tl3PageOrientation;
   {* ���������� ��������. }
  function SectionExtent: Tl3Point;
   {* ������� �������� ������� � ������. }
  function NotFocused: Boolean;
  function RegionBottomRight: Tl3Point;
  function IsAtomic: Boolean;
   {* ������ ��� ������� ������ ������������ ����� ������ ������? }
  function FM: Il3FontMetrics;
   {* ������� ������. }
  function GetClientRect: Tl3Rect;
  function AdjustMarginsByPrintableArea(const aMargins: Tl3_Rect): Tl3_Rect;
   {* ���������������� ���� � ������ ������������ ������� }
  function PasswordChar: AnsiChar;
  function EffectiveColors: Il3EffectiveColors;
  function Printing: Boolean;
   {* ������? }
  function CheckConvertString(const aStr: Tl3PCharLen): Tl3PCharLen;
   {* ����������� ������ ��� ����������� ������������� ���������� � ������ DrawSpecial. }
  function CheckOutString(const aStr: Tl3PCharLen): Tl3PCharLen;
  function Zoom: Integer;
   {* �������. }
  function DeviceCaps(anIndex: Integer): Integer; overload;
  function AsIl3Canvas: Il3Canvas;
  function PageSetup: Il3PageSetup;
  function Painter: Il3HAFPainter;
  function Canvas: TCanvas;
  procedure AssignDeviceCaps;
   {* ���������������� ���������� �� ���������� }
  function DeviceCaps(anIndex: Integer): Integer; overload;
   {* ���������� �������� ���������� ���������. }
  function WindowOrg: Tl3Point; overload;
  function GlobalClipRect: Tl3Rect; overload;
  function ClipRect: Tl3Rect; overload;
  function DC: hDC; overload;
  function SWindowOrg: Tl3SPoint; overload;
  function Invert: Boolean;
  function FrameLines: Il3FrameLines;
  function AbortChecker: Il3AbortChecker;
  procedure StartDrawAAC(aType: TspBlockType);
  procedure EndDrawAAC(const R: Tl3Rect);
  procedure BeginDarkColor;
  procedure EndDarkColor;
 end;//Tl3Canvas
 
 Tl3OldMFCanvas = class(Tl3Canvas)
  {* ����� ��� ������� ����-�����. }
 end;//Tl3OldMFCanvas
 
implementation

uses
 l3ImplUses
 , l3LineArray
 , l3Region
;

end.
