unit NOT_FINISHED_vtGroupBox;

// ������: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtGroupBox.pas"
// ���������: "GuiControl"
// ������� ������: "TvtGroupBox" MUID: (4AC608E40294)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
;

type
 TvtGroupBox = class
 end;//TvtGroupBox

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4AC608E40294impl_uses*
 //#UC END# *4AC608E40294impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtGroupBox);
 {* ����������� TvtGroupBox }
{$IfEnd} // NOT Defined(NoScripts)

end.
