unit vtDateEditRes;

// ������: "w:\common\components\gui\Garant\VT\vtDateEditRes.pas"
// ���������: "UtilityPack"
// ������� ������: "vtDateEditRes" MUID: (4B8E4B58034D)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , Graphics
 , l3StringIDEx
 , l3Date
;

const
 sBtnGlyphs: array [0 .. 3] of PAnsiChar = ('VTPREV2'
 , 'VTPREV1'
 , 'VTNEXT1'
 , 'VTNEXT2'
 );
 {* ������������ ������ TvtDateEditHints }
 str_vtStrPrevYear: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtStrPrevYear'; rValue : '���������� ���');
  {* '���������� ���' }
 str_vtStrPrevMonth: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtStrPrevMonth'; rValue : '���������� �����');
  {* '���������� �����' }
 str_vtStrNextMonth: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtStrNextMonth'; rValue : '��������� �����');
  {* '��������� �����' }
 str_vtStrNextYear: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtStrNextYear'; rValue : '��������� ���');
  {* '��������� ���' }
 {* ������������ ������ TvtMiscMessages }
 str_vtTodayLongLabel: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtTodayLongLabel'; rValue : '������� %s');
  {* '������� %s' }
 str_vtTodayHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtTodayHint'; rValue : '������� ��� ��������� ����������� ����');
  {* '������� ��� ��������� ����������� ����' }
 str_vtCancel: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtCancel'; rValue : '������');
  {* '������' }
 str_vtTodayShortLabel: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtTodayShortLabel'; rValue : '�������');
  {* '�������' }
 str_vtChoose: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtChoose'; rValue : '�������');
  {* '�������' }
 {* ������������ ������ Months }
 str_vtJanuary: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtJanuary'; rValue : '������');
  {* '������' }
 str_vtFebruary: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtFebruary'; rValue : '�������');
  {* '�������' }
 str_vtMarch: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMarch'; rValue : '����');
  {* '����' }
 str_vtApril: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtApril'; rValue : '������');
  {* '������' }
 str_vtMay: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMay'; rValue : '���');
  {* '���' }
 str_vtJune: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtJune'; rValue : '����');
  {* '����' }
 str_vtJuly: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtJuly'; rValue : '����');
  {* '����' }
 str_vtAugust: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtAugust'; rValue : '������');
  {* '������' }
 str_vtSeptember: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtSeptember'; rValue : '��������');
  {* '��������' }
 str_vtOctober: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtOctober'; rValue : '�������');
  {* '�������' }
 str_vtNovember: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtNovember'; rValue : '������');
  {* '������' }
 str_vtDecember: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtDecember'; rValue : '�������');
  {* '�������' }
 {* ������������ ������ TStDayType const }
 str_vtSunday: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtSunday'; rValue : '��');
  {* '��' }
 str_vtMonday: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMonday'; rValue : '��');
  {* '��' }
 str_vtTuesday: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtTuesday'; rValue : '��');
  {* '��' }
 str_vtWednesday: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtWednesday'; rValue : '��');
  {* '��' }
 str_vtThursday: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtThursday'; rValue : '��');
  {* '��' }
 str_vtFriday: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtFriday'; rValue : '��');
  {* '��' }
 str_vtSaturday: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtSaturday'; rValue : '��');
  {* '��' }

type
 TvtBeforeCorrectDate = procedure(const aDate: AnsiString) of object;

 TvtMonths = 1 .. 12;
  {* ������ }

procedure FontSetDefault(aFont: TFont);
function vtMonthsCaptions(aMonth: TvtMonths): Pl3StringIDEx;
function vtWeekDaysCaptions(aDay: TStDayType): Pl3StringIDEx;

var g_vtBeforeCorrectDate: TvtBeforeCorrectDate = nil;

implementation

uses
 l3ImplUses
 , l3MessageID
 , Windows
;

procedure FontSetDefault(aFont: TFont);
//#UC START# *5562E2F802BD_4B8E4B58034D_var*
var
  NonClientMetrics: TNonClientMetrics;
//#UC END# *5562E2F802BD_4B8E4B58034D_var*
begin
//#UC START# *5562E2F802BD_4B8E4B58034D_impl*
 NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
 if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
  AFont.Handle := CreateFontIndirect(NonClientMetrics.lfMessageFont)
 else
 with AFont do
 begin
  Color := clWindowText;
  Name := 'MS Sans Serif';
  Size := 8;
  Style := [];
 end;//with AFont
 AFont.Size := 10;
//#UC END# *5562E2F802BD_4B8E4B58034D_impl*
end;//FontSetDefault

function vtMonthsCaptions(aMonth: TvtMonths): Pl3StringIDEx;
//#UC START# *55647167004A_4B8E4B58034D_var*
const
 imap_vt_MonthsCaptions : array[TvtMonths] of Pl3StringIDEx = (
  @str_vtJanuary,
  @str_vtFebruary,
  @str_vtMarch, 
  @str_vtApril, 
  @str_vtMay, 
  @str_vtJune, 
  @str_vtJuly, 
  @str_vtAugust, 
  @str_vtSeptember, 
  @str_vtOctober, 
  @str_vtNovember, 
  @str_vtDecember);
//#UC END# *55647167004A_4B8E4B58034D_var*
begin
//#UC START# *55647167004A_4B8E4B58034D_impl*
 Result := imap_vt_MonthsCaptions[aMonth];
//#UC END# *55647167004A_4B8E4B58034D_impl*
end;//vtMonthsCaptions

function vtWeekDaysCaptions(aDay: TStDayType): Pl3StringIDEx;
//#UC START# *5567136300AE_4B8E4B58034D_var*
const
  imap_vt_WeekDaysCaptions: array[TStDayType] of Pl3StringIDEx = (
   @str_vtSunday,
   @str_vtMonday,
   @str_vtTuesday,
   @str_vtWednesday,
   @str_vtThursday,
   @str_vtFriday,
   @str_vtSaturday
  );
//#UC END# *5567136300AE_4B8E4B58034D_var*
begin
//#UC START# *5567136300AE_4B8E4B58034D_impl*
 Result := imap_vt_WeekDaysCaptions[aDay];
//#UC END# *5567136300AE_4B8E4B58034D_impl*
end;//vtWeekDaysCaptions

initialization
 str_vtStrPrevYear.Init;
 {* ������������� str_vtStrPrevYear }
 str_vtStrPrevMonth.Init;
 {* ������������� str_vtStrPrevMonth }
 str_vtStrNextMonth.Init;
 {* ������������� str_vtStrNextMonth }
 str_vtStrNextYear.Init;
 {* ������������� str_vtStrNextYear }
 str_vtTodayLongLabel.Init;
 {* ������������� str_vtTodayLongLabel }
 str_vtTodayHint.Init;
 {* ������������� str_vtTodayHint }
 str_vtCancel.Init;
 {* ������������� str_vtCancel }
 str_vtTodayShortLabel.Init;
 {* ������������� str_vtTodayShortLabel }
 str_vtChoose.Init;
 {* ������������� str_vtChoose }
 str_vtJanuary.Init;
 {* ������������� str_vtJanuary }
 str_vtFebruary.Init;
 {* ������������� str_vtFebruary }
 str_vtMarch.Init;
 {* ������������� str_vtMarch }
 str_vtApril.Init;
 {* ������������� str_vtApril }
 str_vtMay.Init;
 {* ������������� str_vtMay }
 str_vtJune.Init;
 {* ������������� str_vtJune }
 str_vtJuly.Init;
 {* ������������� str_vtJuly }
 str_vtAugust.Init;
 {* ������������� str_vtAugust }
 str_vtSeptember.Init;
 {* ������������� str_vtSeptember }
 str_vtOctober.Init;
 {* ������������� str_vtOctober }
 str_vtNovember.Init;
 {* ������������� str_vtNovember }
 str_vtDecember.Init;
 {* ������������� str_vtDecember }
 str_vtSunday.Init;
 {* ������������� str_vtSunday }
 str_vtMonday.Init;
 {* ������������� str_vtMonday }
 str_vtTuesday.Init;
 {* ������������� str_vtTuesday }
 str_vtWednesday.Init;
 {* ������������� str_vtWednesday }
 str_vtThursday.Init;
 {* ������������� str_vtThursday }
 str_vtFriday.Init;
 {* ������������� str_vtFriday }
 str_vtSaturday.Init;
 {* ������������� str_vtSaturday }

end.
