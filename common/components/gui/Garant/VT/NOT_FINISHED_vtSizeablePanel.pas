unit NOT_FINISHED_vtSizeablePanel;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtSizeablePanel.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvtSizeablePanel" MUID: (4A7961300264)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , vtPanel
;

type
 TvtSizeablePanel = class(TvtCustomPanel)
 end;//TvtSizeablePanel

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4A7961300264impl_uses*
 //#UC END# *4A7961300264impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtSizeablePanel);
 {* Регистрация TvtSizeablePanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
