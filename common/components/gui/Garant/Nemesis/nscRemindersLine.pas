unit nscRemindersLine;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscRemindersLine.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nscRemindersLine" MUID: (535E3A7703B5)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

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
