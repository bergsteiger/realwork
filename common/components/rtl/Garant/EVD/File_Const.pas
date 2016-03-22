unit File_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/File_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::File
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега File .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typFile_AdditionalFiles: File_AdditionalFiles_Tag;

function k2_attrAdditionalFiles: Integer;
function k2_typFile: FileTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_File : FileTag = nil;

// start class FileTag

function k2_typFile: FileTag;
begin
 if (g_File = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_File := TevdTasksSchema(Tk2TypeTable.GetInstance).t_File;
 end;//g_File = nil
 Result := g_File;
end;
var
 g_k2_attrAdditionalFiles: Integer = -1;

function k2_attrAdditionalFiles: Integer;
begin
 if (g_k2_attrAdditionalFiles = -1) then
  g_k2_attrAdditionalFiles :=  Tk2Attributes.Instance.CheckIDByName('AdditionalFiles');
 Result := g_k2_attrAdditionalFiles;
end;


var
 g_File_AdditionalFiles : File_AdditionalFiles_Tag = nil;

// start class AdditionalFiles

function k2_typFile_AdditionalFiles: File_AdditionalFiles_Tag;
begin
 if (g_File_AdditionalFiles = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_File_AdditionalFiles := TevdTasksSchema(Tk2TypeTable.GetInstance).t_File_AdditionalFiles;
 end;//g_File = nil
 Result := g_File_AdditionalFiles;
end;


end.