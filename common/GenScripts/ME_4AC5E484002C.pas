unit NOT_FINISHED_eeCheckBox;

// ������: "w:\common\components\gui\Garant\VT\NOT_FINISHED_eeCheckBox.pas"
// ���������: "GuiControl"
// ������� ������: "TeeCheckBox" MUID: (4AC5E484002C)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
;

type
 TeeCheckBox = class
 end;//TeeCheckBox

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TeeCheckBox);
 {* ����������� TeeCheckBox }
{$IfEnd} // NOT Defined(NoScripts)

end.
