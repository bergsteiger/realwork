unit ConfigurationList_Form;
 {* ������������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\ConfigurationList_Form.pas"
// ���������: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimConfigurationList_Form
 , Common_FormDefinitions_Controls
;

type
 Ten_ConfigurationList = {final} class(TPrimConfigurationListForm, ConfigurationListFormDef)
  {* ������������ }
 end;//Ten_ConfigurationList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ConfigurationListKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_ConfigurationList);
 {* ����������� ConfigurationList }
{$IfEnd} // NOT Defined(NoScripts)
 fm_en_ConfigurationList.SetFactory(Ten_ConfigurationList.Make);
 {* ����������� ������� ����� ConfigurationList }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
