unit a2sdsAdmin;

// Источник данных сборки

{ $Id: a2sdsAdmin.pas,v 1.19 2009/03/06 14:18:19 fireton Exp $}

// $Log: a2sdsAdmin.pas,v $
// Revision 1.19  2009/03/06 14:18:19  fireton
// - попытка пересборки с обновленным VCM
//
// Revision 1.18  2009/01/29 14:22:48  fireton
// - пересборка под обновленный VCM
//
// Revision 1.17  2009/01/28 15:32:24  fireton
// - пересборка под обновленный VCM
//
// Revision 1.16  2007/06/22 09:13:58  mmorozov
// - new: параметры обновления представления сборки оформлены интерфейсом;
//
// Revision 1.15  2007/05/14 12:26:57  fireton
// - bug fix: не очищался контейнер для данных группы
//
// Revision 1.14  2007/01/30 08:47:38  fireton
// - переезд на новую версию VCM
//
// Revision 1.13  2006/11/28 10:17:26  fireton
// - чистка кода
//
// Revision 1.12  2006/11/22 16:22:20  fireton
// - переход на новую инкарнацию VCM
//
// Revision 1.11  2006/02/15 14:15:37  fireton
// - переключение баз и импорт/экспорт пользователей
//
// Revision 1.10  2006/02/14 11:20:43  fireton
// - реализация Большого Брата
//
// Revision 1.9  2006/02/01 16:08:23  fireton
// - запись в файл и печать
//
// Revision 1.8  2005/09/09 13:51:31  fireton
// - add: добавлена возможность редактирования списка пользователей внутри группы
//
// Revision 1.7  2005/08/30 10:17:22  fireton
// - полностью доделал редактирование прав групп и данных профилей
//
// Revision 1.6  2005/08/29 15:03:48  fireton
// - промежуточный коммит (профили группы)
//
// Revision 1.5  2005/08/26 13:16:55  fireton
// - промежуточный коммит (профили группы + bug fix)
//
// Revision 1.4  2005/08/23 13:58:29  fireton
// - промежуточный коммит (реализация сохранения + bug fix)
//
// Revision 1.3  2005/08/22 13:12:59  fireton
// - промежуточный коммит (реализация визуальной части - bug fix и группы пользователей)
//
// Revision 1.2  2005/08/20 11:06:16  fireton
// - промежуточный коммит (реализация визуальной части и подгонка под сборки)
//


interface

uses
 vcmInterfaces,
 vcmControllers,
 vcmFormSetDataSource,
 vcmFormDataSourceRef,

 a2Interfaces;

const
 adm_rrNoEdit        = 1;
 adm_rrEditGroup     = 2;
 adm_rrEditUser      = 3;
 adm_rrRefreshTree   = 4;
 adm_rrRefreshRights = 5;
 adm_rrBigBrother    = 6;

type
 Ta2fdsAdmin = class(TvcmFormSetDataSource, Ia2sdsAdmin)
 private
  f_CurProfile: Ia2Profile;
  f_RightsList: Ia2MarkedList;
  f_State     : Ta2AdminState;
  f_PropertyContainerLink: IvcmFormDataSourceRef;
  f_UserProfileLink: IvcmFormDataSourceRef;
  f_UserProfileGroupsLink: IvcmFormDataSourceRef;
  f_GroupProfileLink: IvcmFormDataSourceRef;
  f_GroupProfileRightsLink: IvcmFormDataSourceRef;
  f_GroupProfileRightsValuesLink: IvcmFormDataSourceRef;
  f_GroupProfileUsersListLink: IvcmFormDataSourceRef;
  f_BigBrotherLink: IvcmFormDataSourceRef;
  f_TreeLink: IvcmFormDataSourceRef;
  procedure NoEdit;
  procedure EditUser(aData: Ia2UserProfile);
  procedure EditGroup(aData: Ia2UserGroupProfile);
  procedure RefreshTree(aData: Ia2Profile);
  procedure ReloadRights(aData: Ia2MarkedList);
  procedure BigBrother(aData: Ia2Profile);
  function pm_GetCurProfile: Ia2Profile;
  function pm_GetState: Ta2AdminState;
  function pm_GetGroupRightsValues: Ia2MarkedList;
  function pm_GetDS_PropertyContainer: IvcmFormDataSource;
  function pm_GetDS_UserProfile: IvcmFormDataSource;
  function pm_GetDS_UserProfileGroups: IvcmFormDataSource;
  function pm_GetDS_GroupProfile: IvcmFormDataSource;
  function pm_GetDS_GroupProfileRights: IvcmFormDataSource;
  function pm_GetDS_GroupProfileRightsValues: IvcmFormDataSource;
  function pm_GetDS_GroupProfileUsersList: IvcmFormDataSource;
  function pm_GetDS_BigBrother: IvcmFormDataSource;
  function pm_GetDS_Tree: IvcmFormDataSource;
 public
   // public methods
   procedure InitFields; override;
 end;




implementation
uses
 SysUtils,
 stdRes,

 vcmUtils,
 vcmFormDataSource,

 a2bBase,

 a2bUserGroupTree,
 a2dsUserProfile,
 a2dsMarkedList,
 a2dsProperties,
 a2dsUserGroupProfile,
 a2dsGroupRights,
 a2dsBigBrother;

procedure Ta2fdsAdmin.BigBrother(aData: Ia2Profile);
begin
 f_State      := asBigBrother;
 f_CurProfile := aData;
 f_BigBrotherLink.Clear;
 Refresh;
end;

procedure Ta2fdsAdmin.EditGroup(aData: Ia2UserGroupProfile);
begin
 f_State      := asGroupEdit;
 f_CurProfile := aData as Ia2Profile;
 f_RightsList := nil;
 f_GroupProfileLink.Clear;
 f_GroupProfileRightsLink.Clear;
 f_GroupProfileRightsValuesLink.Clear;
 f_GroupProfileUsersListLink.Clear;
 f_PropertyContainerLink.Clear;
 Refresh;
end;

procedure Ta2fdsAdmin.EditUser(aData: Ia2UserProfile);
begin
 f_State      := asUserEdit;
 f_CurProfile := aData as Ia2Profile;
 f_UserProfileLink.Clear;
 f_UserProfileGroupsLink.Clear;
 f_PropertyContainerLink.Clear;
 Refresh;
end;

procedure Ta2fdsAdmin.InitFields;
begin
 inherited;
 f_State := asNoEdit;
 f_CurProfile := nil;
 f_RightsList := nil;
 f_PropertyContainerLink := TvcmFormDataSourceRef.Make;
 f_UserProfileLink := TvcmFormDataSourceRef.Make;
 f_UserProfileGroupsLink := TvcmFormDataSourceRef.Make;
 f_GroupProfileLink := TvcmFormDataSourceRef.Make;
 f_GroupProfileRightsLink := TvcmFormDataSourceRef.Make;
 f_GroupProfileRightsValuesLink := TvcmFormDataSourceRef.Make;
 f_GroupProfileUsersListLink := TvcmFormDataSourceRef.Make;
 f_BigBrotherLink := TvcmFormDataSourceRef.Make;
 f_TreeLink := TvcmFormDataSourceRef.Make;
end;

procedure Ta2fdsAdmin.NoEdit;
begin
 f_State := asNoEdit;
 Refresh;
end;

function Ta2fdsAdmin.pm_GetCurProfile: Ia2Profile;
begin
 Result := f_CurProfile;
end;

function Ta2fdsAdmin.pm_GetDS_BigBrother: IvcmFormDataSource;
begin
 if f_BigBrotherLink.IsEmpty then
  f_BigBrotherLink.Referred := Ta2dsBigBrother.Make(Self, f_CurProfile);
 Result := f_BigBrotherLink.Referred;
end;

function Ta2fdsAdmin.pm_GetDS_GroupProfile: IvcmFormDataSource;
begin
 if f_GroupProfileLink.IsEmpty then
  f_GroupProfileLink.Referred := Ta2dsUserGroupProfile.Make(Self, f_CurProfile);
 Result := f_GroupProfileLink.Referred; 
end;

function Ta2fdsAdmin.pm_GetDS_GroupProfileRights: IvcmFormDataSource;
begin
 if f_GroupProfileRightsLink.IsEmpty then
  f_GroupProfileRightsLink.Referred := Ta2dsGroupRightsList.Make(Self, (f_CurProfile as Ia2UserGroupProfile).GetRightsGroupList);
 Result := f_GroupProfileRightsLink.Referred; 
end;

function Ta2fdsAdmin.pm_GetDS_GroupProfileRightsValues: IvcmFormDataSource;
begin
 if f_GroupProfileRightsValuesLink.IsEmpty then
  f_GroupProfileRightsValuesLink.Referred := Ta2dsMarkedList.Make(Self, f_RightsList);
 Result := f_GroupProfileRightsValuesLink.Referred;
end;

function Ta2fdsAdmin.pm_GetDS_GroupProfileUsersList: IvcmFormDataSource;
begin
 if f_GroupProfileUsersListLink.IsEmpty then
  f_GroupProfileUsersListLink.Referred := Ta2dsMarkedList.Make(Self, (f_CurProfile as Ia2UserGroupProfile).GetUserList);
 Result := f_GroupProfileUsersListLink.Referred; 
end;

function Ta2fdsAdmin.pm_GetDS_PropertyContainer: IvcmFormDataSource;
begin
 if f_PropertyContainerLink.IsEmpty then
  f_PropertyContainerLink.Referred := Ta2dsPropertyContainer.Make(Self, f_CurProfile);
 Result := f_PropertyContainerLink.Referred;
end;

function Ta2fdsAdmin.pm_GetDS_Tree: IvcmFormDataSource;
begin
 if f_TreeLink.IsEmpty then
  f_TreeLink.Referred := Ta2UserGroupTree.Make(Self, f_CurProfile);
 Result := f_TreeLink.Referred; 
end;

function Ta2fdsAdmin.pm_GetDS_UserProfile: IvcmFormDataSource;
begin
 if f_UserProfileLink.IsEmpty then
  f_UserProfileLink.Referred := Ta2dsUserProfile.Make(Self, f_CurProfile);
 Result := f_UserProfileLink.Referred;
end;

function Ta2fdsAdmin.pm_GetDS_UserProfileGroups: IvcmFormDataSource;
begin
 if f_UserProfileGroupsLink.IsEmpty then
  f_UserProfileGroupsLink.Referred := Ta2dsMarkedList.Make(Self, (f_CurProfile as Ia2UserProfile).GetGroupStates);
 Result := f_UserProfileGroupsLink.Referred;
end;

function Ta2fdsAdmin.pm_GetGroupRightsValues: Ia2MarkedList;
begin
 Result := f_RightsList;
end;

function Ta2fdsAdmin.pm_GetState: Ta2AdminState;
begin
 Result := f_State;
end;

procedure Ta2fdsAdmin.RefreshTree(aData: Ia2Profile);
begin
 f_CurProfile := aData;
 f_TreeLink.Clear;
 Refresh;
end;

procedure Ta2fdsAdmin.ReloadRights(aData: Ia2MarkedList);
begin
 f_RightsList := aData;
 f_GroupProfileRightsValuesLink.Clear;
 Refresh;
end;


end.
