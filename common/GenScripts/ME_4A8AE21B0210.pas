unit Base_Operations_Chat_Controls;
 {* Чат }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Base_Operations_Chat_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Chat" MUID: (4A8AE21B0210)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 en_Chat = 'Chat';
 en_capChat = 'Чат';
 op_ClearHistory = 'ClearHistory';
 op_capClearHistory = 'Очистить историю';
 op_History = 'History';
 op_capHistory = '';
 op_UserFilter = 'UserFilter';
 op_capUserFilter = '';
 op_OpenChatWindow = 'OpenChatWindow';
 op_capOpenChatWindow = '';
 op_Add = 'Add';
 op_capAdd = '';

var opcode_Chat_ClearHistory: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Chat_History: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Chat_UserFilter: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Chat_OpenChatWindow: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Chat_Add: TvcmOPID = (rEnID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationStatesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
;

initialization
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Chat, op_ClearHistory, en_capChat, op_capClearHistory, False, False, opcode_Chat_ClearHistory)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Chat, op_History, en_capChat, op_capHistory, False, False, opcode_Chat_History)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Chat, op_UserFilter, en_capChat, op_capUserFilter, False, False, opcode_Chat_UserFilter)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Chat, op_OpenChatWindow, en_capChat, op_capOpenChatWindow, False, False, opcode_Chat_OpenChatWindow)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Chat, op_Add, en_capChat, op_capAdd, False, False, opcode_Chat_Add)) do
 begin
 end;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
