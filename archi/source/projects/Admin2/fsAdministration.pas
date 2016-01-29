unit fsAdministration;

{ $Id: fsAdministration.pas,v 1.7 2009/03/06 14:18:19 fireton Exp $}

// $Log: fsAdministration.pas,v $
// Revision 1.7  2009/03/06 14:18:19  fireton
// - попытка пересборки с обновленным VCM
//
// Revision 1.6  2008/11/19 18:25:01  lulin
// - <K>: 122674155.
//
// Revision 1.5  2007/01/30 08:47:38  fireton
// - переезд на новую версию VCM
//
// Revision 1.4  2006/11/24 10:04:44  fireton
// - bugfix: предлагалось сохранять изменения при хождении по группам документов
//
// Revision 1.3  2006/11/22 16:22:21  fireton
// - переход на новую инкарнацию VCM
//
// Revision 1.2  2005/08/20 11:06:16  fireton
// - промежуточный коммит (реализация визуальной части и подгонка под сборки)
//

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs,

  vcmInterfaces,
  vcmBase,
  vcmFormSetFactory,
  vcmFormSetFormsCollectionItem,
  vcmUserControls;

type
  TfsAdmin = class(TvcmFormSetFactory)
    function fsAdmincfVertical_utVGeneralNeedMakeForm(
      const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      const aSubUserType: TvcmUserType): Boolean;

    function cfVertical_utVGeneralenUserTree_utUsersTreeNeedMakeForm(
      const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      const aSubUserType: TvcmUserType): Boolean;

    function cfVertical_utVGeneralenNoEditForm_utNoEditNeedMakeForm(
      const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      const aSubUserType: TvcmUserType): Boolean;

    function cfVertical_utVGeneralcfProps_utPropertiesNeedMakeForm(
      const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      const aSubUserType: TvcmUserType): Boolean;

    function cfProps_utPropertiescfHorizontal_utHUserPropertiesNeedMakeForm(
      const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      const aSubUserType: TvcmUserType): Boolean;

    function cfHorizontal_utHUserPropertiesenUserPropertiesForm_utUserPropertiesNeedMakeForm(
      const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      const aSubUserType: TvcmUserType): Boolean;

    function cfHorizontal_utHUserPropertiesenMarkedListForm_utGroupsListNeedMakeForm(
      const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      const aSubUserType: TvcmUserType): Boolean;

    function cfProps_utPropertiescfHorizontal_utHUserGroupPropertiesNeedMakeForm(
      const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      const aSubUserType: TvcmUserType): Boolean;

    function cfHorizontal_utHUserGroupPropertiesenUserGroupPropetriesForm_utUserGroupPropetriesNeedMakeForm(
      const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      const aSubUserType: TvcmUserType): Boolean;

    function cfVertical_utVGroupRightsenGroupRightsForm_utGroupRightsNeedMakeForm(
      const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      const aSubUserType: TvcmUserType): Boolean;

    function cfVertical_utVGroupRightsenRigthsValuesForm_utRightsValuesNeedMakeForm(
      const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      const aSubUserType: TvcmUserType): Boolean;

    function cfProps_utPropertiesenMarkedListForm_utUsersListNeedMakeForm(
      const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      const aSubUserType: TvcmUserType): Boolean;

    function cfVertical_utVGeneralenBigBrotherForm_ugBigBrotherNeedMakeForm(
      const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      const aSubUserType: TvcmUserType): Boolean;

    private
      { Private declarations }
    public
      { Public declarations }
  end;

implementation
uses
 a2Interfaces,

 a2bUserGroupTree,
 a2dsUserProfile,
 a2dsMarkedList,
 a2dsProperties,
 a2dsUserGroupProfile,
 a2dsGroupRights,
 a2dsBigBrother, vcmFormDataSource;

{$R *.DFM}

function TfsAdmin.fsAdmincfVertical_utVGeneralNeedMakeForm(
  const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  const aSubUserType: TvcmUserType): Boolean;
begin
 Result := True;
end;

function TfsAdmin.cfVertical_utVGeneralenUserTree_utUsersTreeNeedMakeForm(
  const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  const aSubUserType: TvcmUserType): Boolean;
var
 l_SDS: Ia2sdsAdmin;
begin
 if Supports(aDataSource, Ia2sdsAdmin, l_SDS) then
  try
   aNew := l_SDS.DS_Tree;
  finally
   l_SDS := nil;
  end;
 Result := Assigned(aNew);
end;

function TfsAdmin.cfVertical_utVGeneralenNoEditForm_utNoEditNeedMakeForm(
  const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  const aSubUserType: TvcmUserType): Boolean;
var
 l_SDS: Ia2sdsAdmin;
begin
 if Supports(aDataSource, Ia2sdsAdmin, l_SDS) then
 begin
  Result := l_SDS.State = asNoEdit;
  l_SDS := nil;
 end
 else
  Result := False;
end;

function TfsAdmin.cfVertical_utVGeneralcfProps_utPropertiesNeedMakeForm(
  const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  const aSubUserType: TvcmUserType): Boolean;
var
 l_SDS: Ia2sdsAdmin;
 l_Pers : Ia2Persistent;
begin
 if Supports(aDataSource, Ia2sdsAdmin, l_SDS) then
 begin
  Result := l_SDS.State in [asUserEdit, asGroupEdit];
  if Result then
   aNew := l_SDS.DS_PropertyContainer;
 end
 else
  Result := False;
end;

function TfsAdmin.cfProps_utPropertiescfHorizontal_utHUserPropertiesNeedMakeForm(
  const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  const aSubUserType: TvcmUserType): Boolean;
var
 l_SDS: Ia2sdsAdmin;
begin
 if Supports(aDataSource, Ia2sdsAdmin, l_SDS) then
 begin
  Result := l_SDS.State = asUserEdit;
  l_SDS := nil;
 end
 else
  Result := False;
end;

function TfsAdmin.cfHorizontal_utHUserPropertiesenUserPropertiesForm_utUserPropertiesNeedMakeForm(
  const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  const aSubUserType: TvcmUserType): Boolean;
var
 l_SDS: Ia2sdsAdmin;
begin
 if Supports(aDataSource, Ia2sdsAdmin, l_SDS) then
 begin
  try
   Result := l_SDS.State = asUserEdit;
   if Result then
    aNew := l_SDS.DS_UserProfile;
  finally
   l_SDS := nil;
  end;
 end
 else
  Result := False;
end;

function TfsAdmin.cfHorizontal_utHUserPropertiesenMarkedListForm_utGroupsListNeedMakeForm(
  const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  const aSubUserType: TvcmUserType): Boolean;
var
 l_SDS: Ia2sdsAdmin;
begin
 if Supports(aDataSource, Ia2sdsAdmin, l_SDS) then
 begin
  try
   Result := l_SDS.State = asUserEdit;
   if Result then
    aNew := l_SDS.DS_UserProfileGroups;
  finally
   l_SDS := nil;
  end;
 end
 else
  Result := False;
end;

function TfsAdmin.cfProps_utPropertiescfHorizontal_utHUserGroupPropertiesNeedMakeForm(
  const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  const aSubUserType: TvcmUserType): Boolean;
var
 l_SDS: Ia2sdsAdmin;
begin
 if Supports(aDataSource, Ia2sdsAdmin, l_SDS) then
 begin
  Result := l_SDS.State = asGroupEdit;
  l_SDS := nil;
 end
 else
  Result := False;
end;

function TfsAdmin.cfHorizontal_utHUserGroupPropertiesenUserGroupPropetriesForm_utUserGroupPropetriesNeedMakeForm(
  const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  const aSubUserType: TvcmUserType): Boolean;
var
 l_SDS: Ia2sdsAdmin;
begin
 if Supports(aDataSource, Ia2sdsAdmin, l_SDS) then
 begin
  try
   Result := l_SDS.State = asGroupEdit;
   if Result then
    aNew := l_SDS.DS_GroupProfile;
  finally
   l_SDS := nil;
  end;
 end
 else
  Result := False;
end;

function TfsAdmin.cfVertical_utVGroupRightsenGroupRightsForm_utGroupRightsNeedMakeForm(
  const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  const aSubUserType: TvcmUserType): Boolean;
var
 l_SDS: Ia2sdsAdmin;
begin
 if Supports(aDataSource, Ia2sdsAdmin, l_SDS) then
 begin
  try
   Result := l_SDS.State = asGroupEdit;
   if Result then
    aNew := l_SDS.DS_GroupProfileRights;
  finally
   l_SDS := nil;
  end;
 end
 else
  Result := False;
end;

function TfsAdmin.cfVertical_utVGroupRightsenRigthsValuesForm_utRightsValuesNeedMakeForm(
  const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  const aSubUserType: TvcmUserType): Boolean;
var
 l_SDS: Ia2sdsAdmin;
begin
 if Supports(aDataSource, Ia2sdsAdmin, l_SDS) then
 begin
  try
   Result := l_SDS.State = asGroupEdit;
   if Result and Assigned(l_SDS.GroupRightsValues) then
    aNew := l_SDS.DS_GroupProfileRightsValues;
  finally
   l_SDS := nil;
  end;
 end
 else
  Result := False;
end;

function TfsAdmin.cfProps_utPropertiesenMarkedListForm_utUsersListNeedMakeForm(
  const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  const aSubUserType: TvcmUserType): Boolean;
var
 l_SDS: Ia2sdsAdmin;
 l_UG: Ia2UserGroupProfile;
begin
 if Supports(aDataSource, Ia2sdsAdmin, l_SDS) then
 begin
  try
   Result := l_SDS.State = asGroupEdit;
   if Result then
    aNew := l_SDS.DS_GroupProfileUsersList;
  finally
   l_SDS := nil;
  end;
 end
 else
  Result := False;
end;

function TfsAdmin.cfVertical_utVGeneralenBigBrotherForm_ugBigBrotherNeedMakeForm(
  const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  const aSubUserType: TvcmUserType): Boolean;
var
 l_SDS: Ia2sdsAdmin;
begin
 if Supports(aDataSource, Ia2sdsAdmin, l_SDS) then
 begin
  try
   Result := l_SDS.State = asBigBrother;
   if Result then
    aNew := l_SDS.DS_BigBrother;
  finally
   l_SDS := nil;
  end;
 end
 else
  Result := False;
end;

end.
