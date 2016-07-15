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

var opcode_Users_LogoutUser: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_Users_LogoutUser_SingleUser: TvcmOperationStateIndex = (rID : -1);
 {* Пользователи -> Отключить пользователя <->  }
var st_user_Users_LogoutUser_MultiUsers: TvcmOperationStateIndex = (rID : -1);
 {* Пользователи -> Отключить пользователя <-> Отключить выделенных пользователей }
var opcode_Users_ConsultingStateForNewbie: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_Users_ConsultingStateForNewbie_Enabled: TvcmOperationStateIndex = (rID : -1);
 {* Пользователи -> Разрешить/Запретить вновь созданным пользователям использование услуги Правового консалтинга <-> Запретить вновь созданным пользователям использование услуги Правового консалтинга }
var st_user_Users_ConsultingStateForNewbie_Disabled: TvcmOperationStateIndex = (rID : -1);
 {* Пользователи -> Разрешить/Запретить вновь созданным пользователям использование услуги Правового консалтинга <-> Разрешить вновь созданным пользователям использование услуги Правового консалтинга }
var opcode_Users_Autoregistration: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_Users_Autoregistration_Enabled: TvcmOperationStateIndex = (rID : -1);
 {* Пользователи -> Разрешить/Запретить авторегистрацию новых пользователей <-> Запретить авторегистрацию новых пользователей }
var st_user_Users_Autoregistration_Disabled: TvcmOperationStateIndex = (rID : -1);
 {* Пользователи -> Разрешить/Запретить авторегистрацию новых пользователей <-> Разрешить авторегистрацию новых пользователей }
var opcode_Users_AddPrivelegedRight: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_Users_AddPrivelegedRight_MultiUsers: TvcmOperationStateIndex = (rID : -1);
 {* Пользователи -> Сделать выделенных пользователей привилегированными <->  }
var st_user_Users_AddPrivelegedRight_SingleUser: TvcmOperationStateIndex = (rID : -1);
 {* Пользователи -> Сделать выделенных пользователей привилегированными <-> Сделать привилегированным }
var opcode_Users_RemovePrivelegedRight: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_Users_RemovePrivelegedRight_MultiUsers: TvcmOperationStateIndex = (rID : -1);
 {* Пользователи -> Отменить для выделенных пользователей режим привилегий <->  }
var st_user_Users_RemovePrivelegedRight_SingleUser: TvcmOperationStateIndex = (rID : -1);
 {* Пользователи -> Отменить для выделенных пользователей режим привилегий <-> Отменить режим привилегий }
var opcode_Users_UserFilter: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Users_DisableConsulting: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Users_EnableConsulting: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Users_MakeFiltersShared: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Users_DenyDeleteIdle: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Users_Add: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Groups_Add: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Groups_ChangeBaseAccess: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Groups_Rename: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Result_Save: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_Result_Save_Create: TvcmOperationStateIndex = (rID : -1);
 {*  -> Сохранить <-> Создать }
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
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
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Users, op_LogoutUser, en_capUsers, op_capLogoutUser, False, False, opcode_Users_LogoutUser)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('SingleUser', st_user_Users_LogoutUser_SingleUser))^ do
  begin
  end;
  with AddState(TvcmOperationStateForRegister_C('MultiUsers', st_user_Users_LogoutUser_MultiUsers))^ do
  begin
   rCaption := 'Отключить выделенных пользователей';
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Users, op_ConsultingStateForNewbie, en_capUsers, op_capConsultingStateForNewbie, False, False, opcode_Users_ConsultingStateForNewbie)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Enabled', st_user_Users_ConsultingStateForNewbie_Enabled))^ do
  begin
   rCaption := 'Запретить вновь созданным пользователям использование услуги Правового консалтинга';
   rImageIndex := 163;
  end;
  with AddState(TvcmOperationStateForRegister_C('Disabled', st_user_Users_ConsultingStateForNewbie_Disabled))^ do
  begin
   rCaption := 'Разрешить вновь созданным пользователям использование услуги Правового консалтинга';
   rChecked := vcm_osfTrue;
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Users, op_Autoregistration, en_capUsers, op_capAutoregistration, False, False, opcode_Users_Autoregistration)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Enabled', st_user_Users_Autoregistration_Enabled))^ do
  begin
   rCaption := 'Запретить авторегистрацию новых пользователей';
   rImageIndex := 171;
  end;
  with AddState(TvcmOperationStateForRegister_C('Disabled', st_user_Users_Autoregistration_Disabled))^ do
  begin
   rCaption := 'Разрешить авторегистрацию новых пользователей';
   rChecked := vcm_osfTrue;
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Users, op_AddPrivelegedRight, en_capUsers, op_capAddPrivelegedRight, False, False, opcode_Users_AddPrivelegedRight)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('MultiUsers', st_user_Users_AddPrivelegedRight_MultiUsers))^ do
  begin
  end;
  with AddState(TvcmOperationStateForRegister_C('SingleUser', st_user_Users_AddPrivelegedRight_SingleUser))^ do
  begin
   rCaption := 'Сделать привилегированным';
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Users, op_RemovePrivelegedRight, en_capUsers, op_capRemovePrivelegedRight, False, False, opcode_Users_RemovePrivelegedRight)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('MultiUsers', st_user_Users_RemovePrivelegedRight_MultiUsers))^ do
  begin
  end;
  with AddState(TvcmOperationStateForRegister_C('SingleUser', st_user_Users_RemovePrivelegedRight_SingleUser))^ do
  begin
   rCaption := 'Отменить режим привилегий';
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Users, op_UserFilter, en_capUsers, op_capUserFilter, False, False, opcode_Users_UserFilter)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Users, op_DisableConsulting, en_capUsers, op_capDisableConsulting, False, False, opcode_Users_DisableConsulting)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Users, op_EnableConsulting, en_capUsers, op_capEnableConsulting, False, False, opcode_Users_EnableConsulting)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Users, op_MakeFiltersShared, en_capUsers, op_capMakeFiltersShared, False, False, opcode_Users_MakeFiltersShared)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Users, op_DenyDeleteIdle, en_capUsers, op_capDenyDeleteIdle, False, False, opcode_Users_DenyDeleteIdle)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Users, op_Add, en_capUsers, op_capAdd, False, False, opcode_Users_Add)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Groups, op_Add, en_capGroups, op_capAdd, False, False, opcode_Groups_Add)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Groups, op_ChangeBaseAccess, en_capGroups, op_capChangeBaseAccess, False, False, opcode_Groups_ChangeBaseAccess)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Groups, op_Rename, en_capGroups, op_capRename, False, False, opcode_Groups_Rename)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Result, op_Save, en_capResult, op_capSave, False, False, opcode_Result_Save)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Create', st_user_Result_Save_Create))^ do
  begin
   rCaption := 'Создать';
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Result, op_Save, en_capResult, op_capSave, False, False, opcode_Result_Save)) do
 begin
 end;

{$IfEnd} // Defined(Admin)

end.
