unit Parent_Form;

// ������: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\Parent_Form.pas"
// ���������: "VCMFinalContainer"

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 , PrimParent_Form
 , F1Like_FormDefinitions_Controls
;

type
 TParentForm = {final} class(TPrimParentForm, ParentFormDef)
 end;//TParentForm

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ParentKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TParentForm);
 {* ����������� Parent }
{$IfEnd} // NOT Defined(NoScripts)
 fm_ParentForm.SetFactory(TParentForm.Make);
 {* ����������� ������� ����� Parent }

end.
