unit NOT_FINISHED_eeButton;

// ������: "w:\common\components\gui\Garant\VT\NOT_FINISHED_eeButton.pas"
// ���������: "GuiControl"
// ������� ������: "TeeButton" MUID: (4DD0F321010A)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
;

type
 TeeRadioButton = class
 end;//TeeRadioButton

 TeeButton = class
 end;//TeeButton

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4DD0F321010Aimpl_uses*
 //#UC END# *4DD0F321010Aimpl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TeeRadioButton);
 {* ����������� TeeRadioButton }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TeeButton);
 {* ����������� TeeButton }
{$IfEnd} // NOT Defined(NoScripts)

end.
