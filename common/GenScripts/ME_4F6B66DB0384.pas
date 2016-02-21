unit Child_Form;

// ������: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\Child_Form.pas"
// ���������: "VCMFinalContainer"

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 , PrimChild_Form
 , F1Like_FormDefinitions_Controls
;

type
 TChildForm = {final} class(TPrimChildForm, ChildFormDef)
 end;//TChildForm

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ChildKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TChildForm);
 {* ����������� Child }
{$IfEnd} // NOT Defined(NoScripts)
 fm_ChildForm.SetFactory(TChildForm.Make);
 {* ����������� ������� ����� Child }

end.
