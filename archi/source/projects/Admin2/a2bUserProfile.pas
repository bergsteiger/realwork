unit a2bUserProfile;

{ $Id: a2bUserProfile.pas,v 1.30 2015/04/07 07:35:52 lukyanets Exp $}

// $Log: a2bUserProfile.pas,v $
// Revision 1.30  2015/04/07 07:35:52  lukyanets
// Изолируем HT
//
// Revision 1.29  2015/01/22 14:31:11  lukyanets
// Переносим отсылку задачи в более правильное место
//
// Revision 1.28  2014/10/08 13:07:32  lukyanets
// Переносим процедуры в правильное место
//
// Revision 1.27  2014/06/23 07:55:19  fireton
// - не собиралось
//
// Revision 1.26  2014/03/04 08:58:38  fireton
// - не собиралось
//
// Revision 1.25  2011/02/07 14:26:09  fireton
// - даём сохранить пользователя, если логин не поменялся (хотя редактировался)
//
// Revision 1.24  2010/10/19 08:52:59  fireton
// - не теряем стек ошибки
//
// Revision 1.23  2010/02/24 11:10:47  narry
// - удаление зависимости проектов от парня
//
// Revision 1.22  2009/04/21 14:19:33  fireton
// - пересборка
//
// Revision 1.21  2009/04/02 13:11:30  fireton
// - [$137470683]. Правка огрехов в отрисовке дерева пользователей.
//
// Revision 1.20  2008/10/03 11:57:53  fireton
// - принудительно инициализируем Большого Брата
//
// Revision 1.19  2008/09/29 08:08:37  narry
// - рефакторинг механизма подключения к базе
//
// Revision 1.18  2008/02/19 15:05:30  lulin
// - переводим сортировку списков на новые, менее виртуальные, рельсы.
//
// Revision 1.17  2007/05/14 12:26:04  fireton
// - проверка подтверждения пароля пользователя уехала с БО на формы
//
// Revision 1.16  2007/04/19 12:01:57  fireton
// - более корректное сообщение об ошибках при добавлении/редактировании пользователя
//
// Revision 1.15  2007/03/26 13:16:30  fireton
// - мелкий багфикс там и сям
//
// Revision 1.14  2007/03/15 14:11:08  fireton
// - тип групп пользователей теперь не TDictID, а TUserGrID
//
// Revision 1.13  2007/03/13 09:09:07  fireton
// - не-админ теперь не сможет пользоваться программой
// - мелкие правки
// - чистка кода
//
// Revision 1.12  2007/02/08 14:22:09  fireton
// - bug fix
// - доработан экспорт и импорт
//
// Revision 1.11  2006/11/30 15:37:31  fireton
// - багфикс и доработка
//
// Revision 1.10  2006/11/27 16:24:39  fireton
// - bugfix
//
// Revision 1.9  2005/09/14 10:51:31  fireton
// - bug fix: неправильное присвоение (и как следствие - AV)
//
// Revision 1.8  2005/08/20 11:01:53  fireton
// - промежуточный коммит (реализация визуальной части и подгонка под сборки)
//
// Revision 1.7  2005/08/17 14:10:58  fireton
// - промежуточный коммит (подгонка под систему сборок)
//
// Revision 1.6  2005/08/15 07:58:28  fireton
// - введение служебного интерфейса: Ia2Service
//
// Revision 1.5  2005/08/09 13:03:24  fireton
// - реализация бизнес-объектов
//
// Revision 1.4  2005/08/05 14:58:24  fireton
// - реализация бизнес-объектов
//
// Revision 1.3  2005/08/04 16:30:54  fireton
// - реализация бизнес-объектов
//
// Revision 1.2  2005/08/02 15:14:20  fireton
// - реализация бизнес-объектов
//
// Revision 1.1  2005/07/29 16:53:07  fireton
// - первый коммит
//

interface
uses
 l3Base,

 Dt_Types,
 Dt_User,

 a2Interfaces,
 a2Base,
 a2bBase, vcmInterfaces;

type

 Ta2UserProfile = class(Ta2Profile, Ia2UserProfile)
 private
  f_GroupsList: Ta2MarkedList;
  f_PasswordChanged: Boolean;
  f_UEM: TUsEditMask;
  procedure ReloadGroupStates;
 protected
  f_Login      : string;
  f_Email      : string;
  f_IsActive   : Boolean;
  f_IsAdmin    : Boolean;
  f_Password   : string;
  f_OldLogin   : string;
  { - Ia2Profile overrided methods - }
  procedure pm_SetName(const Value: string); override;
  { - Ia2UserProfile property methods -}
  function pm_GetEmail: string;
  function pm_GetIsActive: Boolean;
  function pm_GetIsAdmin: Boolean;
  function pm_GetIsReadonly: Boolean;
  function pm_GetLogin: string;
  procedure pm_SetEmail(const Value: string);
  procedure pm_SetIsActive(const Value: Boolean);
  procedure pm_SetIsAdmin(const Value: Boolean);
  procedure pm_SetLogin(const Value: string);
  { - Ia2UserProfile methods - }
  procedure SetPassword(aPassword: string);
  function GetGroupStates: Ia2MarkedList;
  { - overrided methods -}
  procedure DoRevert; override;
  procedure DoSave; override;
 public
  { - Ia2UserProfile properties - }
  property Login: string read pm_GetLogin write pm_SetLogin;
  property Email: string read pm_GetEmail write pm_SetEmail;
  property IsActive: Boolean read pm_GetIsActive write pm_SetIsActive;
  property IsAdmin: Boolean read pm_GetIsAdmin write pm_SetIsAdmin;
  property IsReadonly: Boolean read pm_GetIsReadonly;
  { - methods - }
  constructor Create;
  procedure Cleanup; override;
  procedure IncludeInGroup(aGroup: TUserGrID);
 end;

implementation

uses
 SysUtils,

 l3DatLst,

 daInterfaces,

 csQueryTypes,

 ddClientBaseEngine,
 csUserRequestManager,
 CsClient, csServerTaskTypes;

constructor Ta2UserProfile.Create;
begin
 inherited;
 f_GroupsList := nil;
 GetGroupStates;
 ReloadGroupStates;
end;

procedure Ta2UserProfile.Cleanup;
begin
 l3Free(f_GroupsList);
 inherited;
end;

procedure Ta2UserProfile.DoRevert;
var
 l_Flags: Byte;
 l_Name, l_Login: ShortString;
begin
 if f_ID <> a2cNewItemID then
 begin
  UserManager.GetUserInfo(f_ID, l_Name, l_Login, l_Flags);
  f_Name := l_Name;
  f_Login := l_Login;
  f_OldLogin := f_Login;
  f_IsActive := ((l_Flags and $01) > 0);
  f_IsAdmin  := ((l_Flags and $02) > 0);
 end
 else
 begin
  f_Name := '';
  f_Login := '';
  f_OldLogin := '';
  f_IsActive := True;
  f_IsAdmin := False;
 end;
 f_PasswordChanged := False;
 f_Modified := False;
 with f_UEM do
 begin
  ActivFlag := False;
  LoginName := False;
  Name := False;
 end;
 if Assigned(f_GroupsList) then
  ReloadGroupStates;
end;

procedure Ta2UserProfile.DoSave;
var
 l_Flags: Byte;
 l_Task: TUserEditQuery;
 l_TmpStr: string;
begin
 if not f_Modified then
  Exit;
 CheckBBUserID;
 if f_Login = '' then
  raise Ea2UserDataSaveError.Create('Не задан логин пользователя.');
 l_Flags := 0;
 if f_IsActive then
  l_Flags := $01;
 if f_IsAdmin then
  l_Flags := l_Flags or $02;
 if f_Name = '' then
  f_Name := f_Login;
 if f_ID = a2cNewItemID then
 begin
  try
   f_ID:= UserManager.AddUser(f_Name, f_Login, f_Password, l_Flags)
  except
   on E: Exception do
   begin
    l_TmpStr := Format('Не удалось добавить пользователя: %s', [E.Message]);
    l3System.Stack2Log(l_TmpStr);
    raise Ea2UserDataSaveError.Create(l_TmpStr);
   end;
  end;
 end
 else
 try
  UserManager.EditUser(f_ID, f_Name, f_Login, l_Flags, f_UEM);
 except
  on E: Exception do
  begin
   l_TmpStr := Format('Не удалось изменить данные пользователя: %s', [E.Message]);
    l3System.Stack2Log(l_TmpStr);
    raise Ea2UserDataSaveError.Create(l_TmpStr);
  end;
 end;
 if f_PasswordChanged then
 begin
  UserManager.AdminChangePassWord(f_ID, f_Password);
  f_PasswordChanged := False;
 end;
 if Assigned(f_GroupsList) and f_GroupsList.Modified then
 begin
  UserManager.SetUserGroupList(f_ID, f_GroupsList);
  f_GroupsList.Modified := False;
 end;
 if g_BaseEngine.CSClient.IsStarted then
 begin
  l_Task := TUserEditQuery.Create(g_BaseEngine.CSClient.ClientId);
  try
   l_Task.IsGroup := False;
   l_Task.ID := ID;
   UserRequestManager.SendTask(l_Task);
  finally
   l3Free(l_Task);
  end;
 end;
 //Revert;
 f_Modified := False;
end;

function Ta2UserProfile.GetGroupStates: Ia2MarkedList;
begin
 if not Assigned(f_GroupsList) then
  f_GroupsList := Ta2MarkedList.Create(Self as Ia2Persistent);
 if f_ID <> a2cNewItemID then
  ReloadGroupStates;
 Result := f_GroupsList;
end;

procedure Ta2UserProfile.IncludeInGroup(aGroup: TUserGrID);
var
 l_Idx: Integer;
begin
 GetGroupStates;
 l_Idx := f_GroupsList.IndexOfData(aGroup, SizeOf(aGroup));
 if l_Idx <> -1 then
 begin
  f_GroupsList.Select[l_Idx] := True;
  f_GroupsList.DataInt[l_Idx] := 1;
  f_GroupsList.Modified := True;
 end;
end;       

function Ta2UserProfile.pm_GetEmail: string;
begin
 Result := f_Email;
end;

function Ta2UserProfile.pm_GetIsActive: Boolean;
begin
 Result := f_IsActive;
end;

function Ta2UserProfile.pm_GetIsAdmin: Boolean;
begin
 Result := f_IsAdmin;
end;

function Ta2UserProfile.pm_GetIsReadonly: Boolean;
begin
 Result := (f_ID = usSupervisor) or (f_ID = usAdminReserved);
end;

function Ta2UserProfile.pm_GetLogin: string;
begin
 Result := f_Login;
end;

procedure Ta2UserProfile.pm_SetEmail(const Value: string);
begin
 if Value <> f_Email then
 begin
  f_Email := Value;
  f_Modified := True;
 end;
end;

procedure Ta2UserProfile.pm_SetIsActive(const Value: Boolean);
begin
 if f_IsActive <> Value then
 begin
  f_IsActive := Value;
  f_Modified := True;
  f_UEM.ActivFlag := True;
 end;
end;

procedure Ta2UserProfile.pm_SetIsAdmin(const Value: Boolean);
begin
 if f_IsAdmin <> Value then
 begin
  f_IsAdmin := Value;
  f_Modified := True;
  f_UEM.ActivFlag := True;
 end;
end;

procedure Ta2UserProfile.pm_SetLogin(const Value: string);
begin
 if Value <> f_Login then
 begin
  f_Login := Value;
  f_Modified := True;
  f_UEM.LoginName := not AnsiSameText(f_Login, f_OldLogin);
 end;
end;

procedure Ta2UserProfile.pm_SetName(const Value: string);
begin
 if f_Name <> Value then
  f_UEM.Name := True;
 inherited;
end;

procedure Ta2UserProfile.ReloadGroupStates;
var
 I: Integer;
begin
 f_GroupsList.HostDataList := nil;
 if f_ID <> a2cNewItemID then
  UserManager.GetUserGroupList(f_ID, f_GroupsList)
 else
 begin
  // если новый пользователь просто копируем список групп...
  if f_GroupsList.HostDataList <> UserManager.UGroups then
  begin
   f_GroupsList.Clear;
   f_GroupsList.HostDataList := UserManager.UGroups;
  end;
  for I := 0 to UserManager.UGroups.Count-1 do
   f_GroupsList.Select[I] := False;
 end;
 f_GroupsList.Modified := False;
end;

procedure Ta2UserProfile.SetPassword(aPassword: string);
begin
 f_Password := aPassword;
 f_PasswordChanged := True;
 f_Modified := True;
end;

end.
