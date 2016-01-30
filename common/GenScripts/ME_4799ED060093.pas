unit NOT_FINISHED_l3Defaults;
 {* Значения по умолчанию библиотеки L3. }

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3Defaults.pas"
// Стереотип: "UtilityPack"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
;

const
 def_PaperColor = clWhite;
  {* цвет бумаги. }
 def_Zoom = 100;
 def_cmPaperWidth = 2100;
 def_cmPaperHeight = 2970;
 def_cmPaperLeft = 150;
 def_cmPaperRight = 150;
 def_cmPaperTop = 200;
 def_cmPaperBottom = 200;
 def_cmMinPrintArea = 300;
 def_cmPrintableWidth = def_cmPaperWidth - def_cmPaperLeft - def_cmPaperRight;
 cGarant2011GradientStartColor = $CF9560;
 cGarant2011GradientEndColor = $E1B484;
 cGarant2011SelectionColor = $B87040;
 cGarant2011LinkColor = $00800000;
 cGarant2011BackColor = $00F9F8FA;
 def_PrintingLineSpacing = def_BigLineSpacing;

type
 Tl3DefaultsFakeType = integer;
  {* для того, чтоб модуль l3Defaults добавлялся в interface-часть }

var def_inchPrintableWidth: Integer = 0;
var def_inchPaperWidth: Integer = 0;
var def_inchPaperHeight: Integer = 0;
var def_inchPaperBottom: Integer = 0;
var def_inchMinPrintArea: Integer = 0;

implementation

uses
 l3ImplUses
;

end.
