unit Document_F1Lite_Controls;
 {* Урезанные "сущности" для таких форм как документ-схема }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document_F1Lite_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "F1Lite" MUID: (49885BF10395)

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
 en_Edit = 'Edit';
 en_capEdit = 'Правка';
 op_ToggleFoundWords = 'ToggleFoundWords';
 op_capToggleFoundWords = 'Подсвечивать найденный контекст';
 en_Text = 'Text';
 en_capText = '';
 op_AddToControl = 'AddToControl';
 op_capAddToControl = 'Поставить на контроль';
 en_Selection = 'Selection';
 en_capSelection = '';
 op_ShowCorrespondentListToPart = 'ShowCorrespondentListToPart';
 op_capShowCorrespondentListToPart = '';
 op_ShowRespondentListToPart = 'ShowRespondentListToPart';
 op_capShowRespondentListToPart = '';

var opcode_Edit_ToggleFoundWords: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Text_AddToControl: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_Text_AddToControl_RemoveFromControl: TvcmOperationStateIndex = (rID : -1);
 {*  -> Поставить на контроль <-> Снять с контроля }
var opcode_Selection_ShowCorrespondentListToPart: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Selection_ShowRespondentListToPart: TvcmOPID = (rEnID : -1; rOpID : -1);
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
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Edit, op_ToggleFoundWords, en_capEdit, op_capToggleFoundWords, False, False, opcode_Edit_ToggleFoundWords)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Text, op_AddToControl, en_capText, op_capAddToControl, False, False, opcode_Text_AddToControl)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('RemoveFromControl', st_user_Text_AddToControl_RemoveFromControl))^ do
  begin
   rCaption := 'Снять с контроля';
   rChecked := vcm_osfTrue;
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Text, op_AddToControl, en_capText, op_capAddToControl, False, False, opcode_Text_AddToControl)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Selection, op_ShowCorrespondentListToPart, en_capSelection, op_capShowCorrespondentListToPart, False, False, opcode_Selection_ShowCorrespondentListToPart)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Selection, op_ShowRespondentListToPart, en_capSelection, op_capShowRespondentListToPart, False, False, opcode_Selection_ShowRespondentListToPart)) do
 begin
 end;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
