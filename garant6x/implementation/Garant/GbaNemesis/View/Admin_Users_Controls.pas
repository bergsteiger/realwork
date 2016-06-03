unit Admin_Users_Controls;
 {* Операции для работ с учётными записями пользователей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin_Users_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Users" MUID: (494FD61000CC)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

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

var st_user_Users_LogoutUser_SingleUser: TvcmOperationStateIndex = (rID : -1);
 {* Пользователи -> Отключить пользователя <->  }
var st_user_Users_LogoutUser_MultiUsers: TvcmOperationStateIndex = (rID : -1);
 {* Пользователи -> Отключить пользователя <-> Отключить выделенных пользователей }
var st_user_Users_ConsultingStateForNewbie_Enabled: TvcmOperationStateIndex = (rID : -1);
 {* Пользователи -> Разрешить/Запретить вновь созданным пользователям использование услуги Правового консалтинга <-> Запретить вновь созданным пользователям использование услуги Правового консалтинга }
var st_user_Users_ConsultingStateForNewbie_Disabled: TvcmOperationStateIndex = (rID : -1);
 {* Пользователи -> Разрешить/Запретить вновь созданным пользователям использование услуги Правового консалтинга <-> Разрешить вновь созданным пользователям использование услуги Правового консалтинга }
var st_user_Users_Autoregistration_Enabled: TvcmOperationStateIndex = (rID : -1);
 {* Пользователи -> Разрешить/Запретить авторегистрацию новых пользователей <-> Запретить авторегистрацию новых пользователей }
var st_user_Users_Autoregistration_Disabled: TvcmOperationStateIndex = (rID : -1);
 {* Пользователи -> Разрешить/Запретить авторегистрацию новых пользователей <-> Разрешить авторегистрацию новых пользователей }
var st_user_Users_AddPrivelegedRight_MultiUsers: TvcmOperationStateIndex = (rID : -1);
 {* Пользователи -> Сделать выделенных пользователей привилегированными <->  }
var st_user_Users_AddPrivelegedRight_SingleUser: TvcmOperationStateIndex = (rID : -1);
 {* Пользователи -> Сделать выделенных пользователей привилегированными <-> Сделать привилегированным }
var st_user_Users_RemovePrivelegedRight_MultiUsers: TvcmOperationStateIndex = (rID : -1);
 {* Пользователи -> Отменить для выделенных пользователей режим привилегий <->  }
var st_user_Users_RemovePrivelegedRight_SingleUser: TvcmOperationStateIndex = (rID : -1);
 {* Пользователи -> Отменить для выделенных пользователей режим привилегий <-> Отменить режим привилегий }
var st_user_Result_Save_Create: TvcmOperationStateIndex = (rID : -1);
 {*  -> Сохранить <-> Создать }
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(Admin)

end.
