unit moChat;
 {* Чат }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moChat.pas"
// Стереотип: "VCMUseCaseRealization"
// Элемент модели: "Chat" MUID: (4A697E4303C9)
// Имя типа: "Tmo_Chat"

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
  {* Чат }
 end;//Tmo_Chat
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
 , Base_Operations_F1Services_Contracts
;

initialization
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_Chat, 'Чат'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_Chat, 'OpenContactList', '', False, mod_opcode_ChatService_OpenContactList));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
