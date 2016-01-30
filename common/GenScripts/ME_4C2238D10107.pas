unit NOT_FINISHED_vtCustomPreviewPanel;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtCustomPreviewPanel.pas"
// Стереотип: "GuiControl"

{$Include vtDefine.inc}

interface

uses
 l3IntfUses
 , afwCustomCommonControl
;

type
 TvtCustomPreviewPanel = class(TafwCustomCommonControl)
 end;//TvtCustomPreviewPanel

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtCustomPreviewPanel);
 {* Регистрация TvtCustomPreviewPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
