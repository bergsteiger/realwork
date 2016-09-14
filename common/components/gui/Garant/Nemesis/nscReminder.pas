unit nscReminder;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscReminder.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nscReminder" MUID: (535E3A1A018A)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

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
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *535E3A1A018Aimpl_uses*
 //#UC END# *535E3A1A018Aimpl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscReminder));
 {* Регистрация типа TnscReminder }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
