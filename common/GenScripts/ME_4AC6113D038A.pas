unit NOT_FINISHED_nscPreviewPanel;

// ������: "w:\common\components\gui\Garant\Nemesis\NOT_FINISHED_nscPreviewPanel.pas"
// ���������: "GuiControl"

{$Include nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , eePreviewPanel
;

type
 TnscCustomPreviewPanel = class(TeeCustomPreviewPanel)
 end;//TnscCustomPreviewPanel

 TnscPreviewPanel = class
 end;//TnscPreviewPanel
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscCustomPreviewPanel);
 {* ����������� TnscCustomPreviewPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
