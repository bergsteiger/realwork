unit csGetFilePart_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csGetFilePart_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csGetFilePart
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csGetFilePart .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrTaskID: Integer;

function k2_attrFileName: Integer;

function k2_attrOffset: Integer;

function k2_attrPartSize: Integer;

function k2_typcsGetFilePart: csGetFilePartTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csGetFilePart : csGetFilePartTag = nil;

// start class csGetFilePartTag

function k2_typcsGetFilePart: csGetFilePartTag;
begin
 if (g_csGetFilePart = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csGetFilePart := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csGetFilePart;
 end;//g_csGetFilePart = nil
 Result := g_csGetFilePart;
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
 g_k2_attrFileName: Integer = -1;

function k2_attrFileName: Integer;
begin
 if (g_k2_attrFileName = -1) then
  g_k2_attrFileName :=  Tk2Attributes.Instance.CheckIDByName('FileName');
 Result := g_k2_attrFileName;
end;

var
 g_k2_attrOffset: Integer = -1;

function k2_attrOffset: Integer;
begin
 if (g_k2_attrOffset = -1) then
  g_k2_attrOffset :=  Tk2Attributes.Instance.CheckIDByName('Offset');
 Result := g_k2_attrOffset;
end;

var
 g_k2_attrPartSize: Integer = -1;

function k2_attrPartSize: Integer;
begin
 if (g_k2_attrPartSize = -1) then
  g_k2_attrPartSize :=  Tk2Attributes.Instance.CheckIDByName('PartSize');
 Result := g_k2_attrPartSize;
end;


end.