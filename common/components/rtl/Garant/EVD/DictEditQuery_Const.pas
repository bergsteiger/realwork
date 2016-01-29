unit DictEditQuery_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/DictEditQuery_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::DictEditQuery
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега DictEditQuery .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrFamily: Integer;

function k2_attrDictType: Integer;

function k2_attrOperation: Integer;

function k2_attrID: Integer;

function k2_attrParentID: Integer;

function k2_attrNextID: Integer;

function k2_typDictEditQuery: DictEditQueryTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_DictEditQuery : DictEditQueryTag = nil;

// start class DictEditQueryTag

function k2_typDictEditQuery: DictEditQueryTag;
begin
 if (g_DictEditQuery = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_DictEditQuery := TevdTasksSchema(Tk2TypeTable.GetInstance).t_DictEditQuery;
 end;//g_DictEditQuery = nil
 Result := g_DictEditQuery;
end;
var
 g_k2_attrFamily: Integer = -1;

function k2_attrFamily: Integer;
begin
 if (g_k2_attrFamily = -1) then
  g_k2_attrFamily :=  Tk2Attributes.Instance.CheckIDByName('Family');
 Result := g_k2_attrFamily;
end;

var
 g_k2_attrDictType: Integer = -1;

function k2_attrDictType: Integer;
begin
 if (g_k2_attrDictType = -1) then
  g_k2_attrDictType :=  Tk2Attributes.Instance.CheckIDByName('DictType');
 Result := g_k2_attrDictType;
end;

var
 g_k2_attrOperation: Integer = -1;

function k2_attrOperation: Integer;
begin
 if (g_k2_attrOperation = -1) then
  g_k2_attrOperation :=  Tk2Attributes.Instance.CheckIDByName('Operation');
 Result := g_k2_attrOperation;
end;

var
 g_k2_attrID: Integer = -1;

function k2_attrID: Integer;
begin
 if (g_k2_attrID = -1) then
  g_k2_attrID :=  Tk2Attributes.Instance.CheckIDByName('ID');
 Result := g_k2_attrID;
end;

var
 g_k2_attrParentID: Integer = -1;

function k2_attrParentID: Integer;
begin
 if (g_k2_attrParentID = -1) then
  g_k2_attrParentID :=  Tk2Attributes.Instance.CheckIDByName('ParentID');
 Result := g_k2_attrParentID;
end;

var
 g_k2_attrNextID: Integer = -1;

function k2_attrNextID: Integer;
begin
 if (g_k2_attrNextID = -1) then
  g_k2_attrNextID :=  Tk2Attributes.Instance.CheckIDByName('NextID');
 Result := g_k2_attrNextID;
end;


end.