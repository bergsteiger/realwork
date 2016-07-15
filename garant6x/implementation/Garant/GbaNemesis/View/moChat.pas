unit moChat;
 {* ��� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moChat.pas"
// ���������: "VCMUseCaseRealization"
// ������� ������: "Chat" MUID: (4A697E4303C9)
// ��� ����: "Tmo_Chat"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseChat_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_Chat = {final} class(TBaseChatModule)
  {* ��� }
 end;//Tmo_Chat

var g_module_opcode_Chat_OpenContactList: TvcmMOPID = (rMoID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModulesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModuleOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
;

initialization
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Chat, '���'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Chat, 'OpenContactList', '', False, g_module_opcode_Chat_OpenContactList));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
