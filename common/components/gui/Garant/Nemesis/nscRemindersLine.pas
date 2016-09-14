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
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *535E3A7703B5impl_uses*
 //#UC END# *535E3A7703B5impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscRemindersLine));
 {* Регистрация типа TnscRemindersLine }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
