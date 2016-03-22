unit EditionsContainer_Form;
 {* ��������� �������� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\EditionsContainer_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "EditionsContainer" MUID: (4A6EC095039C)
// ��� ����: "TEditionsContainerForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimEditionsContainer_Form
 , CompareEditions_FormDefinitions_Controls
;

type
 TEditionsContainerForm = {final} class(TPrimEditionsContainerForm, EditionsContainerFormDef)
  {* ��������� �������� ��������� }
 end;//TEditionsContainerForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , EditionsContainerKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TEditionsContainerForm);
 {* ����������� EditionsContainer }
{$IfEnd} // NOT Defined(NoScripts)
 fm_EditionsContainerForm.SetFactory(TEditionsContainerForm.Make);
 {* ����������� ������� ����� EditionsContainer }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
