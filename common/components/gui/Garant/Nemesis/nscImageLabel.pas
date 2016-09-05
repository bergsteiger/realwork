unit nscImageLabel;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscImageLabel.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TnscImageLabel" MUID: (5704F87C02B4)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , vtLabel
;

type
 TnscImageLabel = class(TvtImageLabel)
 end;//TnscImageLabel
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *5704F87C02B4impl_uses*
 //#UC END# *5704F87C02B4impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscImageLabel);
 {* Регистрация TnscImageLabel }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
