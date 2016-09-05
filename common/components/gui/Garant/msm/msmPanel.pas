unit msmPanel;

// Модуль: "w:\common\components\gui\Garant\msm\msmPanel.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmPanel" MUID: (57B42D7C0217)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , vtPanel
;

type
 TmsmPanel = class(TvtPanel)
 end;//TmsmPanel

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57B42D7C0217impl_uses*
 //#UC END# *57B42D7C0217impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmPanel);
 {* Регистрация TmsmPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
