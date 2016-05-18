unit TreeAttributeFirstLevel_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\TreeAttributeFirstLevel_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "TreeAttributeFirstLevel" MUID: (4AB8D5F8025F)
// ��� ����: "TefTreeAttributeFirstLevel"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimTreeAttributeFirstLevel_Form
 , Common_FormDefinitions_Controls
;

type
 TefTreeAttributeFirstLevel = {final} class(TPrimTreeAttributeFirstLevelForm, TreeAttributeFirstLevelFormDef)
 end;//TefTreeAttributeFirstLevel
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , TreeAttributeFirstLevelKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefTreeAttributeFirstLevel);
 {* ����������� TreeAttributeFirstLevel }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efTreeAttributeFirstLevel.SetFactory(TefTreeAttributeFirstLevel.Make);
 {* ����������� ������� ����� TreeAttributeFirstLevel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
