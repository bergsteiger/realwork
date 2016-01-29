unit a2bGroupProfile;

{ $Id: a2bGroupProfile.pas,v 1.24 2015/01/22 14:31:11 lukyanets Exp $}

// $Log: a2bGroupProfile.pas,v $
// Revision 1.24  2015/01/22 14:31:11  lukyanets
// Переносим отсылку задачи в более правильное место
//
// Revision 1.23  2014/10/08 13:07:32  lukyanets
// Переносим процедуры в правильное место
//
// Revision 1.22  2014/06/23 07:55:19  fireton
// - не собиралось
//
// Revision 1.21  2014/03/04 08:58:37  fireton
// - не собиралось
//
// Revision 1.20  2010/02/24 11:10:47  narry
// - удаление зависимости проектов от парня
//
// Revision 1.19  2009/04/21 14:19:33  fireton
// - пересборка
//
// Revision 1.18  2008/10/03 11:57:53  fireton
// - принудительно инициализируем Большого Брата
//
// Revision 1.17  2008/09/29 08:08:37  narry
// - рефакторинг механизма подключения к базе
//
// Revision 1.16  2008/02/19 15:05:30  lulin
// - переводим сортировку списков на новые, менее виртуальные, рельсы.
//
// Revision 1.15  2007/04/25 11:03:22  fireton
// - Рефакторинг DT. Все типы переехали в DT_Types, а константы - в DT_Const
//
// Revision 1.14  2007/03/15 14:11:08  fireton
// - тип групп пользователей теперь не TDictID, а TUserGrID
//
// Revision 1.13  2007/02/08 14:22:09  fireton
// - bug fix
// - доработан экспорт и импорт
//
// Revision 1.12  2006/11/30 15:37:31  fireton
// - багфикс и доработка
//
// Revision 1.11  2005/09/23 14:53:27  fireton
// - добавляем приоритеты в свойства групп
//
// Revision 1.10  2005/09/14 10:50:24  fireton
// - bug fix: неправильное присвоение (и как следствие - AV)
//
// Revision 1.9  2005/09/09 13:37:12  fireton
// - bug fix: не записывался список пользователей
//
// Revision 1.8  2005/08/29 15:03:48  fireton
// - промежуточный коммит (профили группы)
//
// Revision 1.7  2005/08/20 11:01:53  fireton
// - промежуточный коммит (реализация визуальной части и подгонка под сборки)
//
// Revision 1.6  2005/08/17 14:10:58  fireton
// - промежуточный коммит (подгонка под систему сборок)
//
// Revision 1.5  2005/08/15 07:57:57  fireton
// - введение служебного интерфейса: Ia2Service
//
// Revision 1.4  2005/08/09 13:03:24  fireton
// - реализация бизнес-объектов
//
// Revision 1.3  2005/08/05 14:58:24  fireton
// - реализация бизнес-объектов
//
// Revision 1.2  2005/08/04 16:30:54  fireton
// - реализация бизнес-объектов
//
// Revision 1.1  2005/08/02 15:14:57  fireton
// - реализация бизнес-объектов
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
 Ta2UserGroupProfile = class(Ta2Profile, Ia2UserGroupProfile)
 private
  f_CanChangeDataGroup: Integer;
  f_CanDelete: Integer;
  f_CurFamily: TFamilyID;
  f_RightsList: Ta2GroupRightsList;
  f_UserList: Ta2MarkedList;
  f_ImportPriority: Ta2Priority;
  f_ExportPriority: Ta2Priority;
  procedure ReloadRightsList;
  procedure ReloadUserList;
  procedure SaveRightsList;
 protected
  { - Ia2UserGroupProfile property methods -}
  function pm_GetCanChangeDataGroup: Integer;
  function pm_GetCanDelete: Integer;
  procedure pm_SetCanChangeDataGroup(const Value: Integer);
  procedure pm_SetCanDelete(const Value: Integer);
  function pm_GetIsVirtual: Boolean;
  function pm_GetExportPriority: Ta2Priority;
  function pm_GetImportPriority: Ta2Priority;
  procedure pm_SetExportPriority(const Value: Ta2Priority);
  procedure pm_SetImportPriority(const Value: Ta2Priority);
  { - Ia2UserGroupProfile methods - }
  function GetRightsGroupList: Ia2GroupRightsList;
  function GetUserList: Ia2MarkedList;
  { - overrided methods - }
  procedure DoRevert; override;
  procedure DoSave; override;
 public
  constructor Create;
  procedure Cleanup; override;
  { - Ia2UserGroupProfile properties - }
  property CanChangeDataGroup: Integer read pm_GetCanChangeDataGroup write pm_SetCanChangeDataGroup;
  property CanDelete: Integer read pm_GetCanDelete write pm_SetCanDelete;
  property IsVirtual: Boolean read pm_GetIsVirtual;
  property ExportPriority: Ta2Priority read pm_GetExportPriority write pm_SetExportPriority;
  property ImportPriority: Ta2Priority read pm_GetImportPriority write pm_SetImportPriority;
 end;

implementation

uses

 l3DatLst,
 l3Bits,
 l3ObjectStringList,

 csQueryTypes,

 ddClientBaseEngine,
 csUserRequestManager,
 csServerTaskTypes,

 DT_Const,
 Dt_Acces;

resourcestring
 Sa2NoFamilyError = 'Ta2UserGroupProfile.DoRevert: Нет семейств (что бы это ни значило)';

constructor Ta2UserGroupProfile.Create;
begin
 inherited;
 f_UserList := nil;
 f_RightsList := nil;
 f_ImportPriority := pvNormal;
 f_ExportPriority := pvNormal;
end;

procedure Ta2UserGroupProfile.Cleanup;
begin
 l3Free(f_UserList);
 l3Free(f_RightsList);
 inherited;
end;

procedure Ta2UserGroupProfile.DoRevert;
var
 l_Tmp: Integer;
 l_SelfMask: TTblMaskRec;
 l_FamilyList: Tl3StringDataList;
 l_IPriority,
 l_EPriority: TPriority;

 function Priority2a2Priority(aPriority: TPriority): Ta2Priority;
 begin
  case aPriority of
   prLowest  : Result := pvLowest;
   prLow     : Result := pvLow;
   prNormal  : Result := pvNormal;
   prHigh    : Result := pvHigh;
   prHighest : Result := pvHighest;
  end;
 end;
 
begin
 f_CurFamily := 1;
 if (f_ID <> a2cNewItemID) then
 begin
  l_FamilyList:=Tl3StringDataList.Create;
  try
   UserManager.GetDocGroupData(f_ID, MainTblsFamily, l_FamilyList);
   if l_FamilyList.Count = 0 then
    raise Ea2GroupDataLoadError.Create(Sa2NoFamilyError);
   l_SelfMask:=PUGAccessMask(l_FamilyList.Data[l_FamilyList.IndexOfData(f_CurFamily, SizeOf(f_CurFamily), 0)])^.MaskRec;
   if UserManager.UsGrDt.ReadPriorities(f_ID, l_IPriority, l_EPriority) then
   begin
    f_ImportPriority := Priority2a2Priority(l_IPriority);
    f_ExportPriority := Priority2a2Priority(l_EPriority);
   end; // UserManager.UsGrDt.ReadPriorities
  finally
   l3Free(l_FamilyList);
  end; {try..finally}
  f_CanChangeDataGroup := GetSelectStateFromMask(l_SelfMask, 0);
  f_CanDelete := GetSelectStateFromMask(l_SelfMask, 1);
  l_Tmp := UserManager.UGroups.IndexOfData(f_ID, SizeOf(TUserGrID));
  f_Name := UserManager.UGroups.PasStr[l_Tmp];
 end
 else
 begin
  f_Name := 'Новая группа';
  f_CanChangeDataGroup := 0;
  f_CanDelete := 0;
 end;
 if Assigned(f_UserList) then
  ReloadUserList;
 if Assigned(f_RightsList) then
  ReloadRightsList;
 Modified := False;
end;

procedure Ta2UserGroupProfile.DoSave;
var
 l_Ind: Integer;
 l_FamilyList: Tl3StringDataList;
 l_Name : ShortString;
 l_Mask : TTblMaskRec;
 l_Task : TUserEditQuery;

 function a2Priority2Priority(aPriority: Ta2Priority): TPriority;
 begin
  case aPriority of
   pvLowest  : Result := prLowest;
   pvLow     : Result := prLow;
   pvNormal  : Result := prNormal;
   pvHigh    : Result := prHigh;
   pvHighest : Result := prHighest;
  end;
 end;

begin
 if not Modified then
  Exit;
 l_Name := f_Name;
 CheckBBUserID;
 if f_ID = a2cNewItemID then
  f_ID := UserManager.AddUserGroup(l_Name);
 UserManager.EditUserGroup(f_ID, l_Name, a2Priority2Priority(f_ImportPriority),
     a2Priority2Priority(f_ExportPriority));
 l_Mask.AllowMask := 0;
 l_Mask.DenyMask := 0;
 SetSelectStateToMask(l_Mask, 0, f_CanChangeDataGroup);
 SetSelectStateToMask(l_Mask, 1, f_CanDelete);
 l_FamilyList:=Tl3StringDataList.Create;
 try
  UserManager.GetDocGroupData(f_ID, MainTblsFamily, l_FamilyList);
  l_Ind:=l_FamilyList.IndexOfData(f_CurFamily, SizeOf(f_CurFamily), 0);
  If l_Ind < 0 then
   raise Ea2GroupDataLoadError.Create(Sa2NoFamilyError);
  PUGAccessMask(l_FamilyList.Data[l_Ind])^.MaskRec := l_Mask;
  l_FamilyList.Flags[l_Ind]:=l_FamilyList.Flags[l_Ind] or lfItemModified;
  UserManager.PutDocGroupData(f_ID, MainTblsFamily, l_FamilyList);
 finally
  l3Free(l_FamilyList);
 end; {try..finally}
 SaveRightsList;
 if Assigned(f_UserList) and f_UserList.Modified then
 begin
  UserManager.SetHostUserListOnGroup(f_ID, f_UserList);
  f_UserList.Modified := False;
 end;
 if Assigned(g_BaseEngine.CSClient) and g_BaseEngine.CSClient.IsStarted then
 begin
  l_Task := TUserEditQuery.Create(g_BaseEngine.CSClient.ClientId);
  try
   l_Task.IsGroup := True;
   l_Task.ID := ID;
   UserRequestManager.SendTask(l_Task);
  finally
   l3Free(l_Task);
  end;
 end;
 f_Modified := False;
end;

function Ta2UserGroupProfile.GetRightsGroupList: Ia2GroupRightsList;
begin
 if not Assigned(f_RightsList) then
 begin
  f_RightsList := Ta2GroupRightsList.Create;
  ReloadRightsList;
 end;
 Result := f_RightsList;
end;

function Ta2UserGroupProfile.GetUserList: Ia2MarkedList;
begin
 if not Assigned(f_UserList) then
 begin
  f_UserList := Ta2MarkedList.Create(Self as Ia2Persistent);
  ReloadUserList;
 end; 
 Result := f_UserList;
end;

function Ta2UserGroupProfile.pm_GetCanChangeDataGroup: Integer;
begin
 Result := f_CanChangeDataGroup;
end;

function Ta2UserGroupProfile.pm_GetCanDelete: Integer;
begin
 Result := f_CanDelete;
end;

function Ta2UserGroupProfile.pm_GetExportPriority: Ta2Priority;
begin
 Result := f_ExportPriority;
end;

function Ta2UserGroupProfile.pm_GetImportPriority: Ta2Priority;
begin
 Result := f_ImportPriority;
end;

function Ta2UserGroupProfile.pm_GetIsVirtual: Boolean;
begin
 Result := (f_ID = a2cAllUsersGroup);
end;

procedure Ta2UserGroupProfile.pm_SetCanChangeDataGroup(const Value: Integer);
begin
 if f_CanChangeDataGroup <> Value then
 begin
  f_CanChangeDataGroup := Value;
  f_Modified := True;
 end;
end;

procedure Ta2UserGroupProfile.pm_SetCanDelete(const Value: Integer);
begin
 if f_CanDelete <> Value then
 begin
  f_CanDelete := Value;
  f_Modified := True;
 end;
end;

procedure Ta2UserGroupProfile.pm_SetExportPriority(const Value: Ta2Priority);
begin
 if Value <> f_ExportPriority then
 begin
  f_ExportPriority := Value;
  Modified := True;
 end;
end;

procedure Ta2UserGroupProfile.pm_SetImportPriority(const Value: Ta2Priority);
begin
 if Value <> f_ImportPriority then
 begin
  f_ImportPriority := Value;
  Modified := True;
 end;
end;

procedure Ta2UserGroupProfile.ReloadRightsList;
var
 I: Integer;
 lSrchData: Integer;
 l_TempList: Tl3StringDataList;
 l_Rights  : Ta2GroupRightsObject;
 l_Mask    : TUGAccessMask;
 l_ID      : TDictID;
begin
 l_TempList := Tl3StringDataList.Create;
 try
  UserManager.GetDocGroupData(f_ID, f_CurFamily, l_TempList);
  with l_TempList do
  begin
   Sorted := False;
   for I := 1 to 4 do
   begin
    lSrchData := IndexOfData(I, SizeOf(TDictID));
    If lSrchData >= 0 then
     Move(lSrchData, I);
   end;
  end;
  f_RightsList.Clear;
  for I := 0 to l_TempList.Count-1 do
  begin
   l_Mask := PUGAccessMask(l_TempList.Data[I])^;
   l_Rights := Ta2GroupRightsObject.Create(Self, l_Mask);
   try
    f_RightsList.Add(l_TempList.PasStr[I], l_Rights);
   finally
    l3Free(l_Rights);
   end;
  end;
 finally
  l3Free(l_TempList);
 end;
end;

procedure Ta2UserGroupProfile.ReloadUserList;
var
 I: Integer;
begin
 if f_ID <> a2cNewItemID then
  UserManager.GetHostUserListOnGroup(f_ID, f_UserList, True)
 else
 begin
  f_UserList.Clear;
  f_UserList.HostDataList := UserManager.Users;
  for I := 0 to f_UserList.Count-1 do
   f_UserList.Select[I] := False;
 end;
 f_UserList.Modified := False;
end;

procedure Ta2UserGroupProfile.SaveRightsList;
var
 I: Integer;
 l_Rights: Ta2GroupRightsObject;
begin
 if not Assigned(f_RightsList) then
  Exit;
 for I := 0 to f_RightsList.Count-1 do
 begin
  l_Rights := Ta2GroupRightsObject(f_RightsList.Objects[I]);
  if l_Rights.Modified then
  begin
   AccessServer.fMaskTbl.UpdateMask(f_CurFamily, f_ID, l_Rights.RightsMask.ID,
     l_Rights.RightsMask.Mask);
   l_Rights.Modified := False;
  end;
 end;
end;

end.
