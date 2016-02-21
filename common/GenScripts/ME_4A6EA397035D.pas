unit ChatHistory_Form;
 {* ������� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\ChatHistory_Form.pas"
// ���������: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseHistoryWindow_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_ChatHistoryForm: TvcmFormDescriptor = (rFormID : (rName : 'ChatHistoryForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TChatHistoryForm }

type
 ChatHistoryFormDef = interface
  {* ������������� ����� ChatHistory }
  ['{5B6E40C6-04D1-47E4-B97A-0C7AB1B3D1F9}']
 end;//ChatHistoryFormDef

 TChatHistoryForm = {final} class(TBaseHistoryWindowForm, ChatHistoryFormDef)
  {* ������� ��������� }
 end;//TChatHistoryForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ChatHistoryKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TChatHistoryForm);
 {* ����������� ChatHistory }
{$IfEnd} // NOT Defined(NoScripts)
 fm_ChatHistoryForm.SetFactory(TChatHistoryForm.Make);
 {* ����������� ������� ����� ChatHistory }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
