unit NOT_FINISHED_vtCustomPreviewPanel;

// ������: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtCustomPreviewPanel.pas"
// ���������: "GuiControl"

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
 {* ����������� TvtCustomPreviewPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
