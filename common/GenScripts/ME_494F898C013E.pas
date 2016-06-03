unit OfficeLike_Usual_Controls;
 {* "Обычные" операции }

// Модуль: "w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_Usual_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Usual" MUID: (494F898C013E)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmExternalInterfaces
;

const
 en_Edit = 'Edit';
 en_capEdit = 'Правка';
 op_Delete = 'Delete';
 op_capDelete = 'Удалить';
 en_File = 'File';
 en_capFile = 'Файл';
 op_Print = 'Print';
 op_capPrint = 'Печать';
 op_PrintDialog = 'PrintDialog';
 op_capPrintDialog = 'Печать...';
 op_PrintPreview = 'PrintPreview';
 op_capPrintPreview = 'Предварительный просмотр';
 op_Save = 'Save';
 op_capSave = 'Сохранить';
 en_Common = 'Common';
 en_capCommon = 'Файл';
 op_Exit = 'Exit';
 op_capExit = '';
 en_History = 'History';
 en_capHistory = 'История';
 op_Back = 'Back';
 op_capBack = 'Назад';
 op_Forward = 'Forward';
 op_capForward = 'Вперёд';

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
var st_user_Edit_Delete_Controlled: TvcmOperationStateIndex = (rID : -1);
 {* Правка -> Удалить <-> Снять с контроля }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$If Defined(Admin)}
var st_user_Edit_Delete_User: TvcmOperationStateIndex = (rID : -1);
 {* Правка -> Удалить <-> Удалить пользователя }
{$IfEnd} // Defined(Admin)
{$If Defined(Admin)}
var st_user_Edit_Delete_MultiUsers: TvcmOperationStateIndex = (rID : -1);
 {* Правка -> Удалить <-> Удалить выделенных пользователей }
{$IfEnd} // Defined(Admin)
{$If Defined(Admin)}
var st_user_Edit_Delete_Group: TvcmOperationStateIndex = (rID : -1);
 {* Правка -> Удалить <-> Удалить группу }
{$IfEnd} // Defined(Admin)
{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
var st_user_Edit_Delete_Contact: TvcmOperationStateIndex = (rID : -1);
 {* Правка -> Удалить <-> Удалить пользователя }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
