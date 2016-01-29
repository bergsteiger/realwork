unit csCorrectFolder_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csCorrectFolder_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::csCorrectFolder
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csCorrectFolder .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrTaskID: Integer;

function k2_attrNewFolder: Integer;

function k2_typcsCorrectFolder: csCorrectFolderTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csCorrectFolder : csCorrectFolderTag = nil;

// start class csCorrectFolderTag

function k2_typcsCorrectFolder: csCorrectFolderTag;
begin
 if (g_csCorrectFolder = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csCorrectFolder := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csCorrectFolder;
 end;//g_csCorrectFolder = nil
 Result := g_csCorrectFolder;
end;
var
 g_k2_attrTaskID: Integer = -1;

function k2_attrTaskID: Integer;
begin
 if (g_k2_attrTaskID = -1) then
  g_k2_attrTaskID :=  Tk2Attributes.Instance.CheckIDByName('TaskID');
 Result := g_k2_attrTaskID;
end;

var
 g_k2_attrNewFolder: Integer = -1;

function k2_attrNewFolder: Integer;
begin
 if (g_k2_attrNewFolder = -1) then
  g_k2_attrNewFolder :=  Tk2Attributes.Instance.CheckIDByName('NewFolder');
 Result := g_k2_attrNewFolder;
end;


end.