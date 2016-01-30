unit nscRemindersLine;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscRemindersLine.pas"
// Стереотип: "UtilityPack"

{$Include nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 {$If NOT Defined(NoVGScene)}
 , vgRemindersLineWithState
 {$IfEnd} // NOT Defined(NoVGScene)
;

type
 TnscRemindersLine = TvgRemindersLineWithState;
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(Nemesis)

end.
