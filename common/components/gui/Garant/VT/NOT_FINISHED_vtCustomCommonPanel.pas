unit NOT_FINISHED_vtCustomCommonPanel;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtCustomCommonPanel.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvtCustomCommonPanel" MUID: (52B99162037C)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , vtPanel
;

type
 TvtCustomCommonPanel = class(TvtPanel)
 end;//TvtCustomCommonPanel

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *52B99162037Cimpl_uses*
 //#UC END# *52B99162037Cimpl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtCustomCommonPanel);
 {* Регистрация TvtCustomCommonPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
