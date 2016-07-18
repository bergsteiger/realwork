unit UnderControl_Strange_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\UnderControl_Strange_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Strange" MUID: (4CCACDDC0101)

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
 en_ControlCenter = 'ControlCenter';
 en_capControlCenter = '';
 op_Add = 'Add';
 op_capAdd = '';
 op_CreateList = 'CreateList';
 op_capCreateList = '';
 op_Sort = 'Sort';
 op_capSort = '';
 op_ClearAllStatus = 'ClearAllStatus';
 op_capClearAllStatus = '';
 en_ControledObject = 'ControledObject';
 en_capControledObject = '';
 op_Open = 'Open';
 op_capOpen = '';
 op_ClearStatus = 'ClearStatus';
 op_capClearStatus = '';

var opcode_ControlCenter_Add: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_ControlCenter_CreateList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_ControlCenter_Sort: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_ControlCenter_ClearAllStatus: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_ControledObject_Open: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_ControledObject_ClearStatus: TvcmOPID = (rEnID : -1; rOpID : -1);
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
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_ControlCenter, op_Add, en_capControlCenter, op_capAdd, False, False, opcode_ControlCenter_Add)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_ControlCenter, op_CreateList, en_capControlCenter, op_capCreateList, False, False, opcode_ControlCenter_CreateList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_ControlCenter, op_Sort, en_capControlCenter, op_capSort, False, False, opcode_ControlCenter_Sort)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_ControlCenter, op_ClearAllStatus, en_capControlCenter, op_capClearAllStatus, False, False, opcode_ControlCenter_ClearAllStatus)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_ControledObject, op_Open, en_capControledObject, op_capOpen, False, False, opcode_ControledObject_Open)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_ControledObject, op_ClearStatus, en_capControledObject, op_capClearStatus, False, False, opcode_ControledObject_ClearStatus)) do
 begin
 end;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
