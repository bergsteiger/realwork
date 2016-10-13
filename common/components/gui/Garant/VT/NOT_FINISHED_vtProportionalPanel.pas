unit NOT_FINISHED_vtProportionalPanel;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtProportionalPanel.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvtProportionalPanel" MUID: (4A7AD11C028B)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , vtPanel
;

type
 TvtProportionalCustomPanel = class;

 TvtProportionalPanel = class(TvtCustomPanel)
 end;//TvtProportionalPanel

 TvtProportionalCustomPanel = class(TvtProportionalPanel)
 end;//TvtProportionalCustomPanel

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4A7AD11C028Bimpl_uses*
 //#UC END# *4A7AD11C028Bimpl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtProportionalPanel);
 {* Регистрация TvtProportionalPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtProportionalCustomPanel);
 {* Регистрация TvtProportionalCustomPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
