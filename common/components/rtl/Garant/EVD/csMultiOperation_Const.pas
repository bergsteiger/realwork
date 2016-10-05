unit csMultiOperation_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csMultiOperation_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csMultiOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csMultiOperation .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typcsMultiOperation_DocIDList: csMultiOperation_DocIDList_Tag;

function k2_typcsMultiOperation_Operation: csMultiOperation_Operation_Tag;

function k2_attrFamilyID: Integer;

function k2_attrDocIDList: Integer;

function k2_attrOperation: Integer;
function k2_typcsMultiOperation: csMultiOperationTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csMultiOperation : csMultiOperationTag = nil;

// start class csMultiOperationTag

function k2_typcsMultiOperation: csMultiOperationTag;
begin
 if (g_csMultiOperation = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csMultiOperation := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csMultiOperation;
 end;//g_csMultiOperation = nil
 Result := g_csMultiOperation;
end;
var
 g_k2_attrFamilyID: Integer = -1;

function k2_attrFamilyID: Integer;
begin
 if (g_k2_attrFamilyID = -1) then
  g_k2_attrFamilyID :=  Tk2Attributes.Instance.CheckIDByName('FamilyID');
 Result := g_k2_attrFamilyID;
end;

var
 g_k2_attrDocIDList: Integer = -1;

function k2_attrDocIDList: Integer;
begin
 if (g_k2_attrDocIDList = -1) then
  g_k2_attrDocIDList :=  Tk2Attributes.Instance.CheckIDByName('DocIDList');
 Result := g_k2_attrDocIDList;
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
 g_csMultiOperation_DocIDList : csMultiOperation_DocIDList_Tag = nil;

// start class DocIDList

function k2_typcsMultiOperation_DocIDList: csMultiOperation_DocIDList_Tag;
begin
 if (g_csMultiOperation_DocIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csMultiOperation_DocIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csMultiOperation_DocIDList;
 end;//g_csMultiOperation = nil
 Result := g_csMultiOperation_DocIDList;
end;

var
 g_csMultiOperation_Operation : csMultiOperation_Operation_Tag = nil;

// start class Operation

function k2_typcsMultiOperation_Operation: csMultiOperation_Operation_Tag;
begin
 if (g_csMultiOperation_Operation = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csMultiOperation_Operation := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csMultiOperation_Operation;
 end;//g_csMultiOperation = nil
 Result := g_csMultiOperation_Operation;
end;


end.