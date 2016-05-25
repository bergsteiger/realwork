unit ListInfo_Form;
 {* ������� � ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\ListInfo_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "ListInfo" MUID: (4A9BF56C0166)
// ��� ����: "TefListInfo"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimListInfoOptions_Form
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TefListInfo = {final} class(TPrimListInfoOptionsForm, ListInfoFormDef)
  {* ������� � ������ }
   Entities : TvcmEntities;
 end;//TefListInfo
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ListInfoKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
 fm_efListInfo.SetFactory(TefListInfo.Make);
 {* ����������� ������� ����� ListInfo }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefListInfo);
 {* ����������� ListInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
