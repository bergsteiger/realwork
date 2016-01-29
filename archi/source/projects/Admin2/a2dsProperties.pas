unit a2dsProperties;

{ $Id: a2dsProperties.pas,v 1.6 2009/03/06 14:18:19 fireton Exp $}

// $Log: a2dsProperties.pas,v $
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
// Revision 1.1  2005/08/22 13:12:59  fireton
// - промежуточный коммит (реализация визуальной части - bug fix и группы пользователей)
//

interface

uses
 vcmInterfaces,
 vcmFormDataSource,

 a2Interfaces;

type
 Ta2dsPropertyContainer = class(TvcmFormDataSource, Ia2dsPropertyContainer)
 private
  f_Persistent: Ia2Persistent;
  function pm_GetSDS: Ia2sdsAdmin;
  function pm_GetPersistent: Ia2Persistent;
  procedure Refresh(aProfile: Ia2Profile);
 protected
  procedure Cleanup; override;
 public
  procedure GotData; override;
  property Persistent: Ia2Persistent read pm_GetPersistent;
  property SDS: Ia2sdsAdmin read pm_GetSDS;
 end;

implementation
uses
 SysUtils;

procedure Ta2dsPropertyContainer.Cleanup;
begin
 f_Persistent := nil;
 inherited;
end;

procedure Ta2dsPropertyContainer.GotData;
begin
 inherited;
 Supports(PartData, Ia2Persistent, f_Persistent);
end;

function Ta2dsPropertyContainer.pm_GetSDS: Ia2sdsAdmin;
begin
 Supports(UseCaseController, Ia2sdsAdmin, Result);
end;

function Ta2dsPropertyContainer.pm_GetPersistent: Ia2Persistent;
begin
 Result := f_Persistent;
end;

procedure Ta2dsPropertyContainer.Refresh(aProfile: Ia2Profile);
begin
 SDS.RefreshTree(aProfile);
end;

end.
