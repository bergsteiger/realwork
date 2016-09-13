unit UploadDocRequest_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/UploadDocRequest_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::UploadDocRequest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега UploadDocRequest .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typUploadDocRequest: UploadDocRequestTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_UploadDocRequest : UploadDocRequestTag = nil;

// start class UploadDocRequestTag

function k2_typUploadDocRequest: UploadDocRequestTag;
begin
 if (g_UploadDocRequest = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_UploadDocRequest := TevdTasksSchema(Tk2TypeTable.GetInstance).t_UploadDocRequest;
 end;//g_UploadDocRequest = nil
 Result := g_UploadDocRequest;
end;

end.