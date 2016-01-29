unit vtDateEditStuff;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VT"
// ������: "w:/common/components/gui/Garant/VT/vtDateEditStuff.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VT::DateEdit::vtDateEditStuff
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  Graphics
  ;

type
 TvtBeforeCorrectDate = procedure (const aDate: AnsiString) of object;

 T0_3Range = 0..3;

 T0_3PChar = array [T0_3Range] of PAnsiChar;

const
  { sBtnGlyphs }
 sBtnGlyphs : array [0..3] of PAnsiChar = (
  'VTPREV2'
  , 'VTPREV1'
  , 'VTNEXT1'
  , 'VTNEXT2'
 );//sBtnGlyphs

var g_BeforeCorrectDate : TvtBeforeCorrectDate = nil;
procedure FontSetDefault(aFont: TFont);

implementation

uses
  Windows
  ;

// unit methods

procedure FontSetDefault(aFont: TFont);
//#UC START# *5562E2F802BD_5562DFD903B2_var*
var
 NonClientMetrics: TNonClientMetrics;
//#UC END# *5562E2F802BD_5562DFD903B2_var*
begin
//#UC START# *5562E2F802BD_5562DFD903B2_impl*
 NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
 if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
  AFont.Handle := CreateFontIndirect(NonClientMetrics.lfMessageFont)
 else
 with aFont do
 begin
  Color := clWindowText;
  Name := 'MS Sans Serif';
  Size := 8;
  Style := [];
 end;//with AFont
 AFont.Size := 10;
//#UC END# *5562E2F802BD_5562DFD903B2_impl*
end;//FontSetDefault

end.