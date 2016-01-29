unit a2dsUserProfile;

{ $Id: a2dsUserProfile.pas,v 1.6 2009/03/06 14:18:19 fireton Exp $}

// $Log: a2dsUserProfile.pas,v $
// Revision 1.6  2009/03/06 14:18:19  fireton
// - попытка пересборки с обновленным VCM
//
// Revision 1.5  2009/01/29 14:22:48  fireton
// - пересборка под обновленный VCM
//
// Revision 1.4  2009/01/28 15:32:24  fireton
// - пересборка под обновленный VCM
//
// Revision 1.3  2008/11/10 14:27:31  fireton
// - новая версия VCM
//
// Revision 1.2  2005/08/23 13:58:29  fireton
// - промежуточный коммит (реализация сохранения + bug fix)
//
// Revision 1.1  2005/08/20 11:05:32  fireton
// - промежуточный коммит (реализация визуальной части и подгонка под сборки)
//

interface

uses
 vcmInterfaces,
 vcmFormDataSource,

 a2Interfaces;

type
 Ta2dsUserProfile = class(TvcmFormDataSource, Ia2dsUserProfile)
 private
  f_UserProfile: Ia2UserProfile;
  function pm_GetSDS: Ia2sdsAdmin;
  function pm_GetUserProfile: Ia2UserProfile;
 protected
  procedure Cleanup; override;
 public
  procedure GotData; override;
  property UserProfile: Ia2UserProfile read pm_GetUserProfile;
  property SDS: Ia2sdsAdmin read pm_GetSDS;
 end;

implementation
uses
 SysUtils;

procedure Ta2dsUserProfile.Cleanup;
begin
 f_UserProfile := nil;
 inherited;
end;

procedure Ta2dsUserProfile.GotData;
begin
 inherited;
 Supports(PartData, Ia2UserProfile, f_UserProfile);
end;

function Ta2dsUserProfile.pm_GetSDS: Ia2sdsAdmin;
begin
 Supports(UseCaseController, Ia2sdsAdmin, Result);
end;

function Ta2dsUserProfile.pm_GetUserProfile: Ia2UserProfile;
begin
 Result := f_UserProfile;
end;

end.
