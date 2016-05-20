unit ListAnalize_Form;
 {* ������ ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\ListAnalize_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "ListAnalize" MUID: (4E36959002CA)
// ��� ����: "TListAnalizeForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimListAnalize_Form
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TListAnalizeForm = {final} class(TPrimListAnalizeForm, ListAnalizeFormDef)
  {* ������ ������ }
   Entities : TvcmEntities;
 end;//TListAnalizeForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ListAnalizeKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TListAnalizeForm);
 {* ����������� ListAnalize }
{$IfEnd} // NOT Defined(NoScripts)
 fm_ListAnalizeForm.SetFactory(TListAnalizeForm.Make);
 {* ����������� ������� ����� ListAnalize }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
