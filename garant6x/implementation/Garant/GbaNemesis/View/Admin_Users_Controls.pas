unit Admin_Users_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin_Users_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Администратор::Admin::View::Users
//
// Операции для работ с учётными записями пользователей
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  vcmExternalInterfaces {a}
  ;

(* Users = operations
  {* Пользователи }
   ['{0B5DD01F-00EA-4EBA-83B9-539EAEFC687F}']
   operation LogoutUser; has states;
     {* Отключить пользователя }
      SingleUser = state
      end;//SingleUser
      MultiUsers = state
       { Отключить выделенных пользователей }
      end;//MultiUsers
   query ConsultingStateForNewbie; has states;
     {* Разрешить/Запретить вновь созданным пользователям использование услуги Правового консалтинга }
      Enabled = state
       { Запретить вновь созданным пользователям использование услуги Правового консалтинга }
      end;//Enabled
      Disabled = state
       { Разрешить вновь созданным пользователям использование услуги Правового консалтинга }
      end;//Disabled
   query Autoregistration; has states;
     {* Разрешить/Запретить авторегистрацию новых пользователей }
      Enabled = state
       { Запретить авторегистрацию новых пользователей }
      end;//Enabled
      Disabled = state
       { Разрешить авторегистрацию новых пользователей }
      end;//Disabled
   operation AddPrivelegedRight; has states;
     {* Сделать выделенных пользователей привилегированными }
      MultiUsers = state
      end;//MultiUsers
      SingleUser = state
       { Сделать привилегированным }
      end;//SingleUser
   operation RemovePrivelegedRight; has states;
     {* Отменить для выделенных пользователей режим привилегий }
      MultiUsers = state
      end;//MultiUsers
      SingleUser = state
       { Отменить режим привилегий }
      end;//SingleUser
   operation UserFilter;
   operation DisableConsulting;
   operation EnableConsulting;
   operation MakeFiltersShared;
     {* Сделать фильтры данного пользователя общими }
   operation DenyDeleteIdle;
     {* Не удалять при бездействии }
   operation Add;
     {* Добавить }
 end;//Users*)

(* Groups = operations
  {* Группы }
   ['{8E4CE498-63B9-40FF-8F38-9206BEECDD02}']
   operation Add;
     {* Добавить }
   operation ChangeBaseAccess;
   operation Rename;
     {* Переименовать группу }
 end;//Groups*)

(* Result = operations
   ['{41A48F4D-7C40-4F47-BF30-91E4FF0E3B80}']
   operation Save; has states;
     {* Сохранить }
      Create = state
       { Создать }
      end;//Create
   operation Save;
 end;//Result*)
{$IfEnd} //Admin

{$If defined(Admin)}
const
 en_Users = 'Users';
 en_capUsers = 'Пользователи';
 op_LogoutUser = 'LogoutUser';
 op_capLogoutUser = 'Отключить пользователя';
 op_ConsultingStateForNewbie = 'ConsultingStateForNewbie';
 op_capConsultingStateForNewbie = 'Разрешить/Запретить вновь созданным пользователям использование услуги Правового консалтинга';
 op_Autoregistration = 'Autoregistration';
 op_capAutoregistration = 'Разрешить/Запретить авторегистрацию новых пользователей';
 op_AddPrivelegedRight = 'AddPrivelegedRight';
 op_capAddPrivelegedRight = 'Сделать выделенных пользователей привилегированными';
 op_RemovePrivelegedRight = 'RemovePrivelegedRight';
 op_capRemovePrivelegedRight = 'Отменить для выделенных пользователей режим привилегий';
 op_UserFilter = 'UserFilter';
 op_capUserFilter = '';
 op_DisableConsulting = 'DisableConsulting';
 op_capDisableConsulting = '';
 op_EnableConsulting = 'EnableConsulting';
 op_capEnableConsulting = '';
 op_MakeFiltersShared = 'MakeFiltersShared';
 op_capMakeFiltersShared = 'Сделать фильтры данного пользователя общими';
 op_DenyDeleteIdle = 'DenyDeleteIdle';
 op_capDenyDeleteIdle = 'Не удалять при бездействии';
 op_Add = 'Add';
 op_capAdd = 'Добавить';
 en_Groups = 'Groups';
 en_capGroups = 'Группы';
 op_ChangeBaseAccess = 'ChangeBaseAccess';
 op_capChangeBaseAccess = '';
 op_Rename = 'Rename';
 op_capRename = 'Переименовать группу';
 en_Result = 'Result';
 en_capResult = '';
 op_Save = 'Save';
 op_capSave = 'Сохранить';

// Состояния операций:
var st_user_Users_LogoutUser_SingleUser : TvcmOperationStateIndex = (rID : -1);
  // Пользователи -> Отключить пользователя <-> SingleUser
var st_user_Users_LogoutUser_MultiUsers : TvcmOperationStateIndex = (rID : -1);
  // Пользователи -> Отключить пользователя <-> Отключить выделенных пользователей
var st_user_Users_ConsultingStateForNewbie_Enabled : TvcmOperationStateIndex = (rID : -1);
  // Пользователи -> Разрешить/Запретить вновь созданным пользователям использование услуги Правового консалтинга <-> Запретить вновь созданным пользователям использование услуги Правового консалтинга
var st_user_Users_ConsultingStateForNewbie_Disabled : TvcmOperationStateIndex = (rID : -1);
  // Пользователи -> Разрешить/Запретить вновь созданным пользователям использование услуги Правового консалтинга <-> Разрешить вновь созданным пользователям использование услуги Правового консалтинга
var st_user_Users_Autoregistration_Enabled : TvcmOperationStateIndex = (rID : -1);
  // Пользователи -> Разрешить/Запретить авторегистрацию новых пользователей <-> Запретить авторегистрацию новых пользователей
var st_user_Users_Autoregistration_Disabled : TvcmOperationStateIndex = (rID : -1);
  // Пользователи -> Разрешить/Запретить авторегистрацию новых пользователей <-> Разрешить авторегистрацию новых пользователей
var st_user_Users_AddPrivelegedRight_MultiUsers : TvcmOperationStateIndex = (rID : -1);
  // Пользователи -> Сделать выделенных пользователей привилегированными <-> MultiUsers
var st_user_Users_AddPrivelegedRight_SingleUser : TvcmOperationStateIndex = (rID : -1);
  // Пользователи -> Сделать выделенных пользователей привилегированными <-> Сделать привилегированным
var st_user_Users_RemovePrivelegedRight_MultiUsers : TvcmOperationStateIndex = (rID : -1);
  // Пользователи -> Отменить для выделенных пользователей режим привилегий <-> MultiUsers
var st_user_Users_RemovePrivelegedRight_SingleUser : TvcmOperationStateIndex = (rID : -1);
  // Пользователи -> Отменить для выделенных пользователей режим привилегий <-> Отменить режим привилегий
var st_user_Result_Save_Create : TvcmOperationStateIndex = (rID : -1);
  // Result -> Сохранить <-> Создать
{$IfEnd} //Admin

implementation

end.