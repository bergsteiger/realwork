unit vtSpeedButton;

// ������: "w:\common\components\gui\Garant\VT\vtSpeedButton.pas"
// ���������: "GuiControl"

{$Include vtDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoTB97)}
 , tb97Ctls
 {$IfEnd} // NOT Defined(NoTB97)
;

type
 TvtSpeedButton = class(TToolbarButton97)
 end;//TvtSpeedButton

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtSpeedButton);
 {* ����������� TvtSpeedButton }
{$IfEnd} // NOT Defined(NoScripts)

end.
