unit List_Form;
 {* ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\List_Form.pas"
// ���������: "VCMFinalContainer"
// ������� ������: "List" MUID: (4A8921960298)
// ��� ����: "TefList"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimListOptions_Form
 , Common_FormDefinitions_Controls
;

type
 TefList = {final} class(TPrimListOptionsForm, ListFormDef)
  {* ������ }
 end;//TefList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , PresentationInterfaces
 , resWarnImages
 , Base_Operations_Strange_Controls
 , Search_Strange_Controls
 , WorkWithList_ListOperations_Controls
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ListKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefList);
 {* ����������� List }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efList.SetFactory(TefList.Make);
 {* ����������� ������� ����� List }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
