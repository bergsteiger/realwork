unit NOT_FINISHED_vtPreviewPanel;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtPreviewPanel.pas"
// Стереотип: "GuiControl"

{$Include vtDefine.inc}

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
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtPreviewPanel);
 {* Регистрация TvtPreviewPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
