unit NOT_FINISHED_vtSpinEdit;

// ������: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtSpinEdit.pas"
// ���������: "GuiControl"

{$Include vtDefine.inc}

interface

uses
 l3IntfUses
;

type
 TvtSpinEdit = class
 end;//TvtSpinEdit

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , SpinEditWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtSpinEdit);
 {* ����������� TvtSpinEdit }
{$IfEnd} // NOT Defined(NoScripts)

end.
