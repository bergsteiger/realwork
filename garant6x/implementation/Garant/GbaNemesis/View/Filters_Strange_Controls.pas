unit Filters_Strange_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters_Strange_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Strange" MUID: (4CCAAA9D00D6)

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
 en_Filter = 'Filter';
 en_capFilter = '';
 op_Activate = 'Activate';
 op_capActivate = '';
 op_Edit = 'Edit';
 op_capEdit = '';
 op_PersistentFilter = 'PersistentFilter';
 op_capPersistentFilter = '';
 op_RenameFilter = 'RenameFilter';
 op_capRenameFilter = 'Переименовать';
 en_Filters = 'Filters';
 en_capFilters = '';
 op_New = 'New';
 op_capNew = '';
 op_Refresh = 'Refresh';
 op_capRefresh = '';
 op_CreateFilter = 'CreateFilter';
 op_capCreateFilter = 'Добавить фильтр из сохраненных запросов';

var opcode_Filter_Activate: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Filter_Edit: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Filter_PersistentFilter: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Filter_RenameFilter: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Filters_New: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Filters_Refresh: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Filter_CreateFilter: TvcmOPID = (rEnID : -1; rOpID : -1);
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
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Filter, op_Activate, en_capFilter, op_capActivate, False, False, opcode_Filter_Activate)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Filter, op_Edit, en_capFilter, op_capEdit, False, False, opcode_Filter_Edit)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Filter, op_PersistentFilter, en_capFilter, op_capPersistentFilter, False, False, opcode_Filter_PersistentFilter)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Filter, op_RenameFilter, en_capFilter, op_capRenameFilter, False, False, opcode_Filter_RenameFilter)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Filters, op_New, en_capFilters, op_capNew, False, False, opcode_Filters_New)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Filters, op_Refresh, en_capFilters, op_capRefresh, False, False, opcode_Filters_Refresh)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Filter, op_CreateFilter, en_capFilter, op_capCreateFilter, False, False, opcode_Filter_CreateFilter)) do
 begin
 end;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
