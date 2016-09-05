unit NOT_FINISHED_eePreviewPanel;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\NOT_FINISHED_eePreviewPanel.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TeePreviewPanel" MUID: (4CFFD97801C0)

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

uses
 l3IntfUses
 , vtCustomPreviewPanel
;

type
 TeeCustomPreviewPanel = class(TvtCustomPreviewPanel)
 end;//TeeCustomPreviewPanel

 TeePreviewPanel = class
 end;//TeePreviewPanel

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4CFFD97801C0impl_uses*
 //#UC END# *4CFFD97801C0impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TeeCustomPreviewPanel);
 {* Регистрация TeeCustomPreviewPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TeePreviewPanel);
 {* Регистрация TeePreviewPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
