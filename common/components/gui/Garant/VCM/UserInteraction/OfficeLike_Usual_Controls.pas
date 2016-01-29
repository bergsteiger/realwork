unit OfficeLike_Usual_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "UserInteraction"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/UserInteraction/OfficeLike_Usual_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> Shared Delphi Operations::OfficeLike::UserInteraction::Usual
//
// "Обычные" операции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmExternalInterfaces {a}
  ;

(* Edit = operations
  {* Правка }
   ['{8C4E8A26-EE53-4DB5-860C-6DD344A4CD3C}']
   operation Delete; has states;
     {* Удалить }
      Controlled = state
       { Снять с контроля }
      end;//Controlled
      User = state
       { Удалить пользователя }
      end;//User
      MultiUsers = state
       { Удалить выделенных пользователей }
      end;//MultiUsers
      Group = state
       { Удалить группу }
      end;//Group
      Contact = state
       { Удалить пользователя }
      end;//Contact
   operation Delete; has states;
     {* Удалить }
 end;//Edit*)

(* File = operations
  {* Файл }
   ['{573ECB0F-AA41-4D60-8771-E56B0E314D4D}']
   operation Print;
     {* Печать }
   operation PrintDialog;
     {* Печать... }
   operation PrintPreview;
     {* Предварительный просмотр }
   operation Save;
     {* Сохранить }
 end;//File*)

(* Common = operations
  {* Файл }
   ['{7A22D5E9-1A0D-4D6A-9C78-D4DE151D47C6}']
   operation Exit;
 end;//Common*)

(* History = operations
  {* История }
   ['{3DD86EB3-4C41-4431-9F5B-B12D18423A9B}']
   operation Back;
     {* Назад }
   operation Forward;
     {* Вперёд }
 end;//History*)
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
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

// Состояния операций:
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoVCM)}
var st_user_Edit_Delete_Controlled : TvcmOperationStateIndex = (rID : -1);
  // Правка -> Удалить <-> Снять с контроля
{$IfEnd} //not Admin AND not Monitorings AND not NoVCM
{$If defined(Admin) AND not defined(NoVCM)}
var st_user_Edit_Delete_User : TvcmOperationStateIndex = (rID : -1);
  // Правка -> Удалить <-> Удалить пользователя
{$IfEnd} //Admin AND not NoVCM
{$If defined(Admin) AND not defined(NoVCM)}
var st_user_Edit_Delete_MultiUsers : TvcmOperationStateIndex = (rID : -1);
  // Правка -> Удалить <-> Удалить выделенных пользователей
{$IfEnd} //Admin AND not NoVCM
{$If defined(Admin) AND not defined(NoVCM)}
var st_user_Edit_Delete_Group : TvcmOperationStateIndex = (rID : -1);
  // Правка -> Удалить <-> Удалить группу
{$IfEnd} //Admin AND not NoVCM
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoVCM)}
var st_user_Edit_Delete_Contact : TvcmOperationStateIndex = (rID : -1);
  // Правка -> Удалить <-> Удалить пользователя
{$IfEnd} //not Admin AND not Monitorings AND not NoVCM
{$IfEnd} //not NoVCM

implementation

end.