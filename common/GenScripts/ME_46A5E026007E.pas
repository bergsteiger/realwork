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
  {* ��������� ������. }
 
 TFontPitch = Graphics.TFontPitch;
 
 TFontStyles = Graphics.TFontStyles;
 
 hFont = HFONT;
 
 TFont = Graphics.TFont;
 
 VCLBitmap = TBitmap;
  {* ��������. }
 
 TPoint = Types.TPoint;
  {* �����. }
 
 TRect = Types.TRect;
 
 TMessage = Messages.TMessage;
 
 Tl3Position = type Integer;
  {* �������. }
 
 Tl3Inch = type Integer;
  {* ����. }
 
 Tl3Color = TColor;
  {* ����. }
 
 VCLCanvas = TCanvas;
 
 VCLGraphic = TGraphic;
  {* ��������. }
 
 PTextMetric = Windows.PTextMetric;
 
 THandle = Windows.THandle;
 
 hRgn = Windows.hRgn;
  {* ����� �������. }
 
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
