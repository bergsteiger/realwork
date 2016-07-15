unit OfficeLike_Result_Controls;
 {* Результат диалога }

// Модуль: "w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_Result_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Result" MUID: (4A8AD3C70195)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmExternalInterfaces
;

const
 en_Result = 'Result';
 en_capResult = 'Результат диалога';
 op_Cancel = 'Cancel';
 op_capCancel = 'Отмена';
 op_Ok = 'Ok';
 op_capOk = 'OK';

var opcode_Result_Cancel: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Result_Ok: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_Result_Ok_Search: TvcmOperationStateIndex = (rID : -1);
 {* Результат диалога -> OK <-> Искать }
var st_user_Result_Ok_Print: TvcmOperationStateIndex = (rID : -1);
 {* Результат диалога -> OK <-> Печать }
var st_user_Result_Ok_AttributesSelect: TvcmOperationStateIndex = (rID : -1);
 {* Результат диалога -> OK <-> Подтвердить выбор элементов }
var st_user_Result_Ok_ConsultationMark: TvcmOperationStateIndex = (rID : -1);
 {* Результат диалога -> OK <-> Оценить }
var st_user_Result_Ok_Analize: TvcmOperationStateIndex = (rID : -1);
 {* Результат диалога -> OK <-> Построить }
var st_user_Result_Cancel_Close: TvcmOperationStateIndex = (rID : -1);
 {* Результат диалога -> Отмена <-> Закрыть }
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmOperationsForRegister
 , vcmOperationStatesForRegister
;

initialization
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Result, op_Cancel, en_capResult, op_capCancel, False, False, opcode_Result_Cancel)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Result, op_Cancel, en_capResult, op_capCancel, False, False, opcode_Result_Cancel)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Result, op_Ok, en_capResult, op_capOk, False, False, opcode_Result_Ok)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Search', st_user_Result_Ok_Search))^ do
  begin
   rCaption := 'Искать';
   rHint := 'Провести поиск по выбранным параметрам';
  end;
  with AddState(TvcmOperationStateForRegister_C('Print', st_user_Result_Ok_Print))^ do
  begin
   rCaption := 'Печать';
   rImageIndex := 3;
  end;
  with AddState(TvcmOperationStateForRegister_C('AttributesSelect', st_user_Result_Ok_AttributesSelect))^ do
  begin
   rCaption := 'Подтвердить выбор элементов';
  end;
  with AddState(TvcmOperationStateForRegister_C('ConsultationMark', st_user_Result_Ok_ConsultationMark))^ do
  begin
   rCaption := 'Оценить';
  end;
  with AddState(TvcmOperationStateForRegister_C('Analize', st_user_Result_Ok_Analize))^ do
  begin
   rCaption := 'Построить';
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Result, op_Ok, en_capResult, op_capOk, False, False, opcode_Result_Ok)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Result, op_Cancel, en_capResult, op_capCancel, False, False, opcode_Result_Cancel)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Close', st_user_Result_Cancel_Close))^ do
  begin
   rCaption := 'Закрыть';
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Result, op_Cancel, en_capResult, op_capCancel, False, False, opcode_Result_Cancel)) do
 begin
 end;

{$IfEnd} // NOT Defined(NoVCM)

end.
