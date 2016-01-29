unit l3Core;

interface

uses
 l3IntfUses
 , Classes
 , Graphics
 , Windows
 , Types
 , Messages
;

type
 HPALETTE = Windows.HPALETTE;
 
 HMETAFILE = Windows.HMETAFILE;
 
 HGLOBAL = Windows.HGLOBAL;
 
 TFontName = Graphics.TFontName;
  {* Гарнитура шрифта. }
 
 TFontPitch = Graphics.TFontPitch;
 
 TFontStyles = Graphics.TFontStyles;
 
 hFont = HFONT;
 
 TFont = Graphics.TFont;
 
 VCLBitmap = TBitmap;
  {* Картинка. }
 
 TPoint = Types.TPoint;
  {* Точка. }
 
 TRect = Types.TRect;
 
 TMessage = Messages.TMessage;
 
 Tl3Position = type Integer;
  {* Позиция. }
 
 Tl3Inch = type Integer;
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
 
implementation

uses
 l3ImplUses
;

end.
