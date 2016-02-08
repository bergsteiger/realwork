unit l3Core;
 {* Базовые примитивные типы и интерфейсы, унаследованные извне. Для уменьшения связности с внешними модулями. }

// Модуль: "w:\common\components\rtl\Garant\L3\l3Core.pas"
// Стереотип: "Interfaces"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , Classes
 , Graphics
 , Windows
 , Types
 , Messages
;

const
 {* Цвета }
 clDefault = Graphics.clDefault;
  {* Цвет по-умолчанию. }
 {* Алиасы для значений Classes.TShiftState }
 ssShift = Classes.ssShift;
 ssAlt = Classes.ssAlt;
 ssCtrl = Classes.ssCtrl;
 ssLeft = Classes.ssLeft;
 ssRight = Classes.ssRight;
 ssMiddle = Classes.ssMiddle;
 ssDouble = Classes.ssDouble;
 {* Алиасы для значений Graphics.TFontPitch }
 fpDefault = fpDefault;
  {* The font pitch is set to the default value, which depends on the font specified in the font object's Name property. }
 fpVariable = fpVariable;
  {* The font pitch is set to variable. The characters in the font have different widths. }
 fpFixed = fpFixed;
  {* The font pitch is set to fixed. All characters in the font have the same width. }

type
 HPALETTE = Windows.HPALETTE;

 HMETAFILE = Windows.HMETAFILE;

 HGLOBAL = Windows.HGLOBAL;

 TFontName = Graphics.TFontName;
  {* Гарнитура шрифта. }

 TFontPitch = Graphics.TFontPitch;

 TFontStyles = Graphics.TFontStyles;

 hFont = Windows.HFONT;

 TFont = Graphics.TFont;

 TBitmap = Graphics.TBitmap;

 TPoint = Types.TPoint;
  {* Точка. }

 TRect = Types.TRect;

 TMessage = Messages.TMessage;

 Tl3Position = type Integer;
  {* Позиция. }

 Tl3Inch = Integer;
  {* Дюйм. }

 Tl3Color = TColor;
  {* Цвет. }

 VCLCanvas = TCanvas;

 VCLGraphic = TGraphic;
  {* Картинка. }

 PTextMetric = Windows.PTextMetric;

 THandle = Windows.THandle;

 hRgn = Windows.hRgn;
  {* Хэндл региона. }

 WinBool = BOOL;

 LCID = Windows.LCID;

 PMsg = Windows.PMsg;

 hDC = Windows.hDC;

 hWnd = Windows.hWnd;

 WPARAM = Windows.WPARAM;

 LPARAM = Windows.LPARAM;

 TComponent = Classes.TComponent;

 TStrings = Classes.TStrings;

 TShiftState = Classes.TShiftState;

 TPersistent = Classes.TPersistent;

 DWORD = Cardinal;

 PInteger = Windows.PInteger;

 RtlDateTime = TDateTime;

 VCLBitmap = TBitmap;
  {* Картинка. }

implementation

uses
 l3ImplUses
;

end.
