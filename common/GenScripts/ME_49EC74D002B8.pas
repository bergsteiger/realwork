unit InternetAgent_Form;
 {* ������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\Forms\InternetAgent_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "InternetAgent" MUID: (49EC74D002B8)
// ��� ����: "TInternetAgentForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimInternetAgent_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_InternetAgentForm: TvcmFormDescriptor = (rFormID : (rName : 'InternetAgentForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TInternetAgentForm }

type
 TInternetAgentForm = class;

 InternetAgentFormDef = interface
  {* ������������� ����� InternetAgent$F }
  ['{4953CF3C-7760-41BE-BBC7-7CA06BAE484D}']
 end;//InternetAgentFormDef

 TInternetAgentForm = {final} class(TPrimInternetAgentForm, InternetAgentFormDef)
  {* ������� ������ }
 end;//TInternetAgentForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , InternetAgentKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TInternetAgentForm);
 {* ����������� InternetAgent$F }
{$IfEnd} // NOT Defined(NoScripts)
 fm_InternetAgentForm.SetFactory(TInternetAgentForm.Make);
 {* ����������� ������� ����� InternetAgent$F }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
