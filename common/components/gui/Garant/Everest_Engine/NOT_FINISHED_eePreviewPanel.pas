unit NOT_FINISHED_eePreviewPanel;

// ������: "w:\common\components\gui\Garant\Everest_Engine\NOT_FINISHED_eePreviewPanel.pas"
// ���������: "GuiControl"

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
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TeeCustomPreviewPanel);
 {* ����������� TeeCustomPreviewPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
