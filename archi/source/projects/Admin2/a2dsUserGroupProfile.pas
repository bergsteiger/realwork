unit a2dsUserGroupProfile;

{ $Id: a2dsUserGroupProfile.pas,v 1.5 2009/03/06 14:18:19 fireton Exp $}

// $Log: a2dsUserGroupProfile.pas,v $
// Revision 1.5  2009/03/06 14:18:19  fireton
// - попытка пересборки с обновленным VCM
//
// Revision 1.4  2009/01/29 14:22:48  fireton
// - пересборка под обновленный VCM
//
// Revision 1.3  2009/01/28 15:32:24  fireton
// - пересборка под обновленный VCM
//
// Revision 1.2  2008/11/10 14:27:31  fireton
// - новая версия VCM
//
// Revision 1.1  2005/08/29 15:03:48  fireton
// - промежуточный коммит (профили группы)
//

interface

uses
 vcmInterfaces,
 vcmFormDataSource,

 a2Interfaces;

type
 Ta2dsUserGroupProfile = class(TvcmFormDataSource, Ia2dsUserGroupProfile)
 private
  f_UserGroupProfile: Ia2UserGroupProfile;
  function pm_GetSDS: Ia2sdsAdmin;
  function pm_GetUserGroupProfile: Ia2UserGroupProfile;
 protected
  procedure Cleanup; override;
 public
  procedure GotData; override;
  property UserGroupProfile: Ia2UserGroupProfile read pm_GetUserGroupProfile;
  property SDS: Ia2sdsAdmin read pm_GetSDS;
 end;

implementation
uses
 SysUtils;

procedure Ta2dsUserGroupProfile.Cleanup;
begin
 f_UserGroupProfile := nil;
 inherited;
end;

procedure Ta2dsUserGroupProfile.GotData;
begin
 inherited;
 Supports(PartData, Ia2UserGroupProfile, f_UserGroupProfile);
end;

function Ta2dsUserGroupProfile.pm_GetSDS: Ia2sdsAdmin;
begin
 Supports(UseCaseController, Ia2sdsAdmin, Result);
end;

function Ta2dsUserGroupProfile.pm_GetUserGroupProfile: Ia2UserGroupProfile;
begin
 Result := f_UserGroupProfile;
end;

end.
