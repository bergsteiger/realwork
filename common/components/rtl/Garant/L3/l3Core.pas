unit l3Core;
 {* ������� ����������� ���� � ����������, �������������� �����. ��� ���������� ��������� � �������� ��������. }

// ������: "w:\common\components\rtl\Garant\L3\l3Core.pas"
// ���������: "Interfaces"

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
 {* ����� }
 clDefault = Graphics.clDefault;
  {* ���� ��-���������. }
 {* ������ ��� �������� Classes.TShiftState }
 ssShift = Classes.ssShift;
 ssAlt = Classes.ssAlt;
 ssCtrl = Classes.ssCtrl;
 ssLeft = Classes.ssLeft;
 ssRight = Classes.ssRight;
 ssMiddle = Classes.ssMiddle;
 ssDouble = Classes.ssDouble;
 {* ������ ��� �������� Graphics.TFontPitch }
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
  {* ��������� ������. }

 TFontPitch = Graphics.TFontPitch;

 TFontStyles = Graphics.TFontStyles;

 hFont = Windows.HFONT;

 TFont = Graphics.TFont;

 TBitmap = Graphics.TBitmap;

 TPoint = Types.TPoint;
  {* �����. }

 TRect = Types.TRect;

 TMessage = Messages.TMessage;

 Tl3Position = type Integer;
  {* �������. }

 Tl3Inch = Integer;
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

 VCLBitmap = TBitmap;
  {* ��������. }

implementation

uses
 l3ImplUses
;

end.
