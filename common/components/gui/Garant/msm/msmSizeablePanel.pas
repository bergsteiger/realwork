unit msmSizeablePanel;

// Модуль: "w:\common\components\gui\Garant\msm\msmSizeablePanel.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmSizeablePanel" MUID: (57B42A370031)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , vtSizeablePanel
;

type
 TmsmSizeablePanel = class(TvtSizeablePanel)
 end;//TmsmSizeablePanel

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57B42A370031impl_uses*
 //#UC END# *57B42A370031impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmSizeablePanel);
 {* Регистрация TmsmSizeablePanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
