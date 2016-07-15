unit WorkWithList_StatusBar_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkWithList_StatusBar_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "StatusBar" MUID: (4B20DE9B0154)

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
 en_Selection = 'Selection';
 en_capSelection = 'Выделенные элементы';
 op_Analize = 'Analize';
 op_capAnalize = 'Анализ списка...';
 op_CopyToNewList = 'CopyToNewList';
 op_capCopyToNewList = '';

var opcode_Selection_Analize: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Selection_CopyToNewList: TvcmOPID = (rEnID : -1; rOpID : -1);
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
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Selection, op_Analize, en_capSelection, op_capAnalize, False, False, opcode_Selection_Analize)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Selection, op_CopyToNewList, en_capSelection, op_capCopyToNewList, False, False, opcode_Selection_CopyToNewList)) do
 begin
 end;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
