unit Contents_Form;
 {* ��������� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\Contents_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "Contents" MUID: (4A9D51C4026F)
// ��� ����: "TContentsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimContentsOptions_Form
 , Common_FormDefinitions_Controls
;

type
 TContentsForm = {final} class(TPrimContentsOptionsForm, ContentsFormDef)
  {* ��������� ��������� }
 end;//TContentsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ContentsKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TContentsForm);
 {* ����������� Contents }
{$IfEnd} // NOT Defined(NoScripts)
 fm_ContentsForm.SetFactory(TContentsForm.Make);
 {* ����������� ������� ����� Contents }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
