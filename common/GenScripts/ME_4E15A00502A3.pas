unit NOT_FINISHED_vtStatusBar;

// ������: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtStatusBar.pas"
// ���������: "GuiControl"

{$Include vtDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , ComCtrls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TvtCustomStatusBar = class(TCustomStatusBar)
 end;//TvtCustomStatusBar

 TvtStatusPanel = class
 end;//TvtStatusPanel

 TvtStatusBar = class(TvtCustomStatusBar)
 end;//TvtStatusBar

implementation

uses
 l3ImplUses
 , afwDrawing
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , StatusBarWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , StatusPanelWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtCustomStatusBar);
 {* ����������� TvtCustomStatusBar }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtStatusPanel);
 {* ����������� TvtStatusPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtStatusBar);
 {* ����������� TvtStatusBar }
{$IfEnd} // NOT Defined(NoScripts)

end.
