unit Rubricator_Form;
 {* �������� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Rubricator\Forms\Rubricator_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "Rubricator" MUID: (4AA68CCA0001)
// ��� ����: "TefRubricator"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimRubricator_Form
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TefRubricator = {final} class(TPrimRubricatorForm, RubricatorFormDef)
  {* �������� ��������� }
   Entities : TvcmEntities;
 end;//TefRubricator
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , RubricatorKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefRubricator);
 {* ����������� Rubricator }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efRubricator.SetFactory(TefRubricator.Make);
 {* ����������� ������� ����� Rubricator }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
