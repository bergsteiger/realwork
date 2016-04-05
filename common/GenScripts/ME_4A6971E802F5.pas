unit ChatWindow_Form;
 {* ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\ChatWindow_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "ChatWindow" MUID: (4A6971E802F5)
// ��� ����: "TChatWindowForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseChatWindowOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_ChatWindowForm: TvcmFormDescriptor = (rFormID : (rName : 'ChatWindowForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TChatWindowForm }

type
 TChatWindowForm = class;

 ChatWindowFormDef = interface
  {* ������������� ����� ChatWindow }
  ['{BD39AB6D-74A5-4A07-80BA-F529342D3B8A}']
 end;//ChatWindowFormDef

 TChatWindowForm = {final} class(TBaseChatWindowOptionsForm, ChatWindowFormDef)
  {* ��������� }
 end;//TChatWindowForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ChatWindowKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TChatWindowForm);
 {* ����������� ChatWindow }
{$IfEnd} // NOT Defined(NoScripts)
 fm_ChatWindowForm.SetFactory(TChatWindowForm.Make);
 {* ����������� ������� ����� ChatWindow }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
