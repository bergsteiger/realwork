unit F1_Without_Usecases_DocumentsCacheOperations_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\F1_Without_Usecases_DocumentsCacheOperations_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "DocumentsCacheOperations" MUID: (5391D16303CD)

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
 en_DocumentsCache = 'DocumentsCache';
 en_capDocumentsCache = '';
 op_Clear = 'Clear';
 op_capClear = 'Очистить кэш документов';
 op_Disable = 'Disable';
 op_capDisable = 'Запретить кэш документов';

var opcode_DocumentsCache_Clear: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_DocumentsCache_Disable: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_DocumentsCache_Disable_Disable: TvcmOperationStateIndex = (rID : -1);
 {*  -> Запретить кэш документов <->  }
var st_user_DocumentsCache_Disable_Enable: TvcmOperationStateIndex = (rID : -1);
 {*  -> Запретить кэш документов <->  }
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
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentsCache, op_Clear, en_capDocumentsCache, op_capClear, False, False, opcode_DocumentsCache_Clear)) do
 begin
  SetImageIndex(5);
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentsCache, op_Disable, en_capDocumentsCache, op_capDisable, False, False, opcode_DocumentsCache_Disable)) do
 begin
  SetImageIndex(26);
  with AddState(TvcmOperationStateForRegister_C('Disable', st_user_DocumentsCache_Disable_Disable))^ do
  begin
  end;
  with AddState(TvcmOperationStateForRegister_C('Enable', st_user_DocumentsCache_Disable_Enable))^ do
  begin
   rChecked := vcm_osfTrue;
  end;
 end;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
