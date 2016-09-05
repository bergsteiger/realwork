unit NOT_FINISHED_vtPreviewPanel;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtPreviewPanel.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvtPreviewPanel" MUID: (4C2238BC037D)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , vtCustomPreviewPanel
;

type
 TvtPreviewPanel = class(TvtCustomPreviewPanel)
 end;//TvtPreviewPanel

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4C2238BC037Dimpl_uses*
 //#UC END# *4C2238BC037Dimpl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtPreviewPanel);
 {* Регистрация TvtPreviewPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
