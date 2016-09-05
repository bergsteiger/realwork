unit DownloadDocRequest_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/DownloadDocRequest_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::DownloadDocRequest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега DownloadDocRequest .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typDownloadDocRequest: DownloadDocRequestTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_DownloadDocRequest : DownloadDocRequestTag = nil;

// start class DownloadDocRequestTag

function k2_typDownloadDocRequest: DownloadDocRequestTag;
begin
 if (g_DownloadDocRequest = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_DownloadDocRequest := TevdTasksSchema(Tk2TypeTable.GetInstance).t_DownloadDocRequest;
 end;//g_DownloadDocRequest = nil
 Result := g_DownloadDocRequest;
end;

end.