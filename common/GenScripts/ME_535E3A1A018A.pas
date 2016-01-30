unit nscReminder;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscReminder.pas"
// Стереотип: "UtilityPack"

{$Include nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 {$If NOT Defined(NoVGScene)}
 , vgReminderWithAction
 {$IfEnd} // NOT Defined(NoVGScene)
;

type
 TnscReminder = TvgReminderWithAction;
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(Nemesis)

end.
