unit msmProportionalPanel;

// Модуль: "w:\common\components\gui\Garant\msm\msmProportionalPanel.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmProportionalPanel" MUID: (57DA8745012E)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , vtProportionalPanel
;

type
 TmsmProportionalPanel = class(TvtProportionalPanel)
 end;//TmsmProportionalPanel

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57DA8745012Eimpl_uses*
 //#UC END# *57DA8745012Eimpl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmProportionalPanel);
 {* Регистрация TmsmProportionalPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
