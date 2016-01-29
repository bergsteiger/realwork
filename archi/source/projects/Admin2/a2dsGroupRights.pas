unit a2dsGroupRights;

{ $Id: a2dsGroupRights.pas,v 1.6 2009/03/06 14:18:19 fireton Exp $}

// $Log: a2dsGroupRights.pas,v $
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
// Revision 1.2  2005/08/30 10:17:22  fireton
// - полностью доделал редактирование прав групп и данных профилей
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
 Ta2dsGroupRightsList = class(TvcmFormDataSource, Ia2dsGroupRightsList)
 private
  f_GroupRightsList: Ia2GroupRightsList;
  function pm_GetSDS: Ia2sdsAdmin;
  function pm_GetGroupRightsList: Ia2GroupRightsList;
  procedure ReloadRightValies(const Index: Integer);
 protected
  procedure Cleanup; override;
 public
  procedure GotData; override;
  property GroupRightsList: Ia2GroupRightsList read pm_GetGroupRightsList;
  property SDS: Ia2sdsAdmin read pm_GetSDS;
 end;

implementation
uses
 SysUtils;

procedure Ta2dsGroupRightsList.Cleanup;
begin
 f_GroupRightsList := nil;
 inherited;
end;

procedure Ta2dsGroupRightsList.GotData;
begin
 inherited;
 Supports(PartData, Ia2GroupRightsList, f_GroupRightsList);
end;

function Ta2dsGroupRightsList.pm_GetSDS: Ia2sdsAdmin;
begin
 Supports(UseCaseController, Ia2sdsAdmin, Result);
end;

function Ta2dsGroupRightsList.pm_GetGroupRightsList: Ia2GroupRightsList;
begin
 Result := f_GroupRightsList;
end;

procedure Ta2dsGroupRightsList.ReloadRightValies(const Index: Integer);
begin
 SDS.ReloadRights(GroupRightsList.GetRights(Index));
end;

end.
