unit vtDateEditRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VT/vtDateEditRes.pas"
// Начат: 03.03.2010 14:43
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VT::DateEdit::vtDateEditRes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  l3Date,
  Graphics,
  l3StringIDEx
  ;

const
  { sBtnGlyphs }
 sBtnGlyphs : array [0..3] of PAnsiChar = (
  'VTPREV2'
  , 'VTPREV1'
  , 'VTNEXT1'
  , 'VTNEXT2'
 );//sBtnGlyphs

type
 TvtBeforeCorrectDate = procedure (const aDate: AnsiString) of object;

 TvtMonths = 1..12;
  {* Месяцы }

var g_vtBeforeCorrectDate : TvtBeforeCorrectDate = nil;

var
  { Локализуемые строки TvtDateEditHints }
 str_vtStrPrevYear : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtStrPrevYear'; rValue : 'Предыдущий год');
  { 'Предыдущий год' }
 str_vtStrPrevMonth : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtStrPrevMonth'; rValue : 'Предыдущий месяц');
  { 'Предыдущий месяц' }
 str_vtStrNextMonth : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtStrNextMonth'; rValue : 'Следующий месяц');
  { 'Следующий месяц' }
 str_vtStrNextYear : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtStrNextYear'; rValue : 'Следующий год');
  { 'Следующий год' }

var
  { Локализуемые строки TvtMiscMessages }
 str_vtTodayLongLabel : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtTodayLongLabel'; rValue : 'Сегодня %s');
  { 'Сегодня %s' }
 str_vtTodayHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtTodayHint'; rValue : 'Нажмите для установки сегодняшней даты');
  { 'Нажмите для установки сегодняшней даты' }
 str_vtCancel : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtCancel'; rValue : 'Отмена');
  { 'Отмена' }
 str_vtTodayShortLabel : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtTodayShortLabel'; rValue : 'Сегодня');
  { 'Сегодня' }
 str_vtChoose : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtChoose'; rValue : 'Выбрать');
  { 'Выбрать' }

var
  { Локализуемые строки Months }
 str_vtJanuary : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtJanuary'; rValue : 'Январь');
  { 'Январь' }
 str_vtFebruary : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtFebruary'; rValue : 'Февраль');
  { 'Февраль' }
 str_vtMarch : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMarch'; rValue : 'Март');
  { 'Март' }
 str_vtApril : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtApril'; rValue : 'Апрель');
  { 'Апрель' }
 str_vtMay : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMay'; rValue : 'Май');
  { 'Май' }
 str_vtJune : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtJune'; rValue : 'Июнь');
  { 'Июнь' }
 str_vtJuly : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtJuly'; rValue : 'Июль');
  { 'Июль' }
 str_vtAugust : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtAugust'; rValue : 'Август');
  { 'Август' }
 str_vtSeptember : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtSeptember'; rValue : 'Сентябрь');
  { 'Сентябрь' }
 str_vtOctober : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtOctober'; rValue : 'Октябрь');
  { 'Октябрь' }
 str_vtNovember : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtNovember'; rValue : 'Ноябрь');
  { 'Ноябрь' }
 str_vtDecember : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtDecember'; rValue : 'Декабрь');
  { 'Декабрь' }

var
  { Локализуемые строки TStDayType const }
 str_vtSunday : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtSunday'; rValue : 'Вс');
  { 'Вс' }
 str_vtMonday : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMonday'; rValue : 'Пн');
  { 'Пн' }
 str_vtTuesday : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtTuesday'; rValue : 'Вт');
  { 'Вт' }
 str_vtWednesday : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtWednesday'; rValue : 'Ср');
  { 'Ср' }
 str_vtThursday : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtThursday'; rValue : 'Чт');
  { 'Чт' }
 str_vtFriday : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtFriday'; rValue : 'Пт');
  { 'Пт' }
 str_vtSaturday : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtSaturday'; rValue : 'Сб');
  { 'Сб' }
procedure FontSetDefault(aFont: TFont);
function VtMonthsCaptions(aMonth: TvtMonths): Pl3StringIDEx;
function VtWeekDaysCaptions(aDay: TStDayType): Pl3StringIDEx;

implementation

uses
  Windows,
  l3MessageID
  ;

// unit methods

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

function VtMonthsCaptions(aMonth: TvtMonths): Pl3StringIDEx;
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
end;//VtMonthsCaptions

function VtWeekDaysCaptions(aDay: TStDayType): Pl3StringIDEx;
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
end;//VtWeekDaysCaptions

initialization
// Инициализация str_vtStrPrevYear
 str_vtStrPrevYear.Init;
// Инициализация str_vtStrPrevMonth
 str_vtStrPrevMonth.Init;
// Инициализация str_vtStrNextMonth
 str_vtStrNextMonth.Init;
// Инициализация str_vtStrNextYear
 str_vtStrNextYear.Init;
// Инициализация str_vtTodayLongLabel
 str_vtTodayLongLabel.Init;
// Инициализация str_vtTodayHint
 str_vtTodayHint.Init;
// Инициализация str_vtCancel
 str_vtCancel.Init;
// Инициализация str_vtTodayShortLabel
 str_vtTodayShortLabel.Init;
// Инициализация str_vtChoose
 str_vtChoose.Init;
// Инициализация str_vtJanuary
 str_vtJanuary.Init;
// Инициализация str_vtFebruary
 str_vtFebruary.Init;
// Инициализация str_vtMarch
 str_vtMarch.Init;
// Инициализация str_vtApril
 str_vtApril.Init;
// Инициализация str_vtMay
 str_vtMay.Init;
// Инициализация str_vtJune
 str_vtJune.Init;
// Инициализация str_vtJuly
 str_vtJuly.Init;
// Инициализация str_vtAugust
 str_vtAugust.Init;
// Инициализация str_vtSeptember
 str_vtSeptember.Init;
// Инициализация str_vtOctober
 str_vtOctober.Init;
// Инициализация str_vtNovember
 str_vtNovember.Init;
// Инициализация str_vtDecember
 str_vtDecember.Init;
// Инициализация str_vtSunday
 str_vtSunday.Init;
// Инициализация str_vtMonday
 str_vtMonday.Init;
// Инициализация str_vtTuesday
 str_vtTuesday.Init;
// Инициализация str_vtWednesday
 str_vtWednesday.Init;
// Инициализация str_vtThursday
 str_vtThursday.Init;
// Инициализация str_vtFriday
 str_vtFriday.Init;
// Инициализация str_vtSaturday
 str_vtSaturday.Init;

end.