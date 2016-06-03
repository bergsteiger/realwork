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
;
{$IfEnd} // NOT Defined(NoVCM)

end.
