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
;

type
 TefListInfo = {final} class(TPrimListInfoOptionsForm, ListInfoFormDef)
  {* ������� � ������ }
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

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefListInfo);
 {* ����������� ListInfo }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efListInfo.SetFactory(TefListInfo.Make);
 {* ����������� ������� ����� ListInfo }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
