unit PlainFile_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/PlainFile_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::PlainFile
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега PlainFile .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrName: Integer;

function k2_typPlainFile: PlainFileTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_PlainFile : PlainFileTag = nil;

// start class PlainFileTag

function k2_typPlainFile: PlainFileTag;
begin
 if (g_PlainFile = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_PlainFile := TevdTasksSchema(Tk2TypeTable.GetInstance).t_PlainFile;
 end;//g_PlainFile = nil
 Result := g_PlainFile;
end;
var
 g_k2_attrName: Integer = -1;

function k2_attrName: Integer;
begin
 if (g_k2_attrName = -1) then
  g_k2_attrName :=  Tk2Attributes.Instance.CheckIDByName('Name');
 Result := g_k2_attrName;
end;


end.