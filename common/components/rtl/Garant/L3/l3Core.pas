unit l3Core;

{$IfDef DesignTimeLibrary}
{.$WEAKPACKAGEUNIT ON}
{$EndIf DesignTimeLibrary}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3$Domain"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3Core.pas"
// �����: 24.07.2007 15:19
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi ���������� � �������������� �����������::L3$Domain::l3Core
//
// ������� ����������� ���� � ����������, �������������� �����. ��� ���������� ��������� � ��������
// ��������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  Types,
  Messages,
  Classes,
  Graphics,
  Windows
  ;

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

 VCLBitmap = Graphics.TBitmap;
  {* ��������. }

 TPoint = Types.TPoint;
  {* �����. }

 TRect = Types.TRect;

 TMessage = Messages.TMessage;

 Tl3Position = type System.Integer;
  {* �������. }

 Tl3Inch = type System.Integer;
  {* ����. }

 Tl3Color = Graphics.TColor;
  {* ����. }

 VCLCanvas = Graphics.TCanvas;

 VCLGraphic = Graphics.TGraphic;
  {* ��������. }

const
  { ����� }
 clDefault = Graphics.clDefault;
  { ���� ��-���������. }

type
 PTextMetric = Windows.PTextMetric;

 THandle = Windows.THandle;

 hRgn = Windows.hRgn;
  {* ����� �������. }

 WinBool = Windows.BOOL;

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

 DWORD = System.Cardinal;

 PInteger = Windows.PInteger;

 RtlDateTime = System.TDateTime;

const
  { ������ ��� �������� Classes.TShiftState }
 ssShift = Classes.ssShift;
 ssAlt = Classes.ssAlt;
 ssCtrl = Classes.ssCtrl;
 ssLeft = Classes.ssLeft;
 ssRight = Classes.ssRight;
 ssMiddle = Classes.ssMiddle;
 ssDouble = Classes.ssDouble;
  { ������ ��� �������� Graphics.TFontPitch }
 fpDefault = Graphics.fpDefault;
  { The font pitch is set to the default value, which depends on the font specified in the font object's Name property. }
 fpVariable = Graphics.fpVariable;
  { The font pitch is set to variable. The characters in the font have different widths. }
 fpFixed = Graphics.fpFixed;
  { The font pitch is set to fixed. All characters in the font have the same width. }

implementation

end.