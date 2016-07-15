unit OfficeLike_System_Controls;

// Модуль: "w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_System_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "System" MUID: (4F6B439D0095)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmExternalInterfaces
;

const
 en_Common = 'Common';
 en_capCommon = '';
 op_OpenNewWindowByUser = 'OpenNewWindowByUser';
 op_capOpenNewWindowByUser = '';
 op_GetWindowList = 'GetWindowList';
 op_capGetWindowList = '';
 op_CascadeWindows = 'CascadeWindows';
 op_capCascadeWindows = '';
 op_TileWindowsHorizontal = 'TileWindowsHorizontal';
 op_capTileWindowsHorizontal = '';
 op_TileWindowsVertical = 'TileWindowsVertical';
 op_capTileWindowsVertical = '';
 op_CloseAllWindows = 'CloseAllWindows';
 op_capCloseAllWindows = '';

var opcode_Common_OpenNewWindowByUser: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Common_GetWindowList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Common_CascadeWindows: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Common_TileWindowsHorizontal: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Common_TileWindowsVertical: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Common_CloseAllWindows: TvcmOPID = (rEnID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmOperationsForRegister
 , vcmOperationStatesForRegister
;

initialization
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Common, op_OpenNewWindowByUser, en_capCommon, op_capOpenNewWindowByUser, False, False, opcode_Common_OpenNewWindowByUser)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Common, op_GetWindowList, en_capCommon, op_capGetWindowList, False, False, opcode_Common_GetWindowList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Common, op_CascadeWindows, en_capCommon, op_capCascadeWindows, False, False, opcode_Common_CascadeWindows)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Common, op_TileWindowsHorizontal, en_capCommon, op_capTileWindowsHorizontal, False, False, opcode_Common_TileWindowsHorizontal)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Common, op_TileWindowsVertical, en_capCommon, op_capTileWindowsVertical, False, False, opcode_Common_TileWindowsVertical)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Common, op_CloseAllWindows, en_capCommon, op_capCloseAllWindows, False, False, opcode_Common_CloseAllWindows)) do
 begin
 end;

{$IfEnd} // NOT Defined(NoVCM)

end.
