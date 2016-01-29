unit a2dsMarkedList;

{ $Id: a2dsMarkedList.pas,v 1.6 2009/03/06 14:18:19 fireton Exp $}

// $Log: a2dsMarkedList.pas,v $
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
 Ta2dsMarkedList = class(TvcmFormDataSource, Ia2dsMarkedList)
 private
  f_MarkedList: Ia2MarkedList;
  function pm_GetSDS: Ia2sdsAdmin;
  function pm_GetMarkedList: Ia2MarkedList;
 protected
  procedure Cleanup; override;
 public
  procedure GotData; override;
  property MarkedList: Ia2MarkedList read pm_GetMarkedList;
  property SDS: Ia2sdsAdmin read pm_GetSDS;
 end;

implementation
uses
 SysUtils;

procedure Ta2dsMarkedList.Cleanup;
begin
 f_MarkedList := nil;
 inherited;
end;

procedure Ta2dsMarkedList.GotData;
begin
 inherited;
 Supports(PartData, Ia2MarkedList, f_MarkedList);
end;

function Ta2dsMarkedList.pm_GetSDS: Ia2sdsAdmin;
begin
 Supports(UseCaseController, Ia2sdsAdmin, Result);
end;

function Ta2dsMarkedList.pm_GetMarkedList: Ia2MarkedList;
begin
 Result := f_MarkedList;
end;

end.
