unit NewGenMainPrim_Form;

// ������: "w:\MDProcess\NewGen\NewGenMainPrim_Form.pas"
// ���������: "VCMMainForm"
// ������� ������: "NewGenMainPrim" MUID: (4F6B6E380367)
// ��� ����: "TNewGenMainPrimForm"

{$Include w:\MDProcess\NewGen\ngDefine.inc}

interface

{$If Defined(NewGen)}
uses
 l3IntfUses
 , MainPrim_Form
;

type
 TNewGenMainPrimForm = class(TMainPrimForm)
 end;//TNewGenMainPrimForm
{$IfEnd} // Defined(NewGen)

implementation

{$If Defined(NewGen)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TNewGenMainPrimForm);
 {* ����������� NewGenMainPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(NewGen)

end.
