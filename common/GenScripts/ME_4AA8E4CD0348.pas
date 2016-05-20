unit GroupList_Form;
 {* ������ ������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\GroupList_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "GroupList" MUID: (4AA8E4CD0348)
// ��� ����: "TefGroupList"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimGroupListOptions_Form
 , Admin_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TefGroupList = {final} class(TPrimGroupListOptionsForm, GroupListFormDef)
  {* ������ ������������� }
   Entities : TvcmEntities;
 end;//TefGroupList
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , GroupListKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefGroupList);
 {* ����������� GroupList }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efGroupList.SetFactory(TefGroupList.Make);
 {* ����������� ������� ����� GroupList }
{$IfEnd} // Defined(Admin)

end.
