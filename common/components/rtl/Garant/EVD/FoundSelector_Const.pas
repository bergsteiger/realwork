unit FoundSelector_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/FoundSelector_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::FoundSelector
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега FoundSelector .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrPara: Integer;

function k2_attrWord: Integer;

function k2_attrDocument: Integer;

function k2_typFoundSelector: FoundSelectorTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_FoundSelector : FoundSelectorTag = nil;

// start class FoundSelectorTag

function k2_typFoundSelector: FoundSelectorTag;
begin
 if (g_FoundSelector = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_FoundSelector := TevdTasksSchema(Tk2TypeTable.GetInstance).t_FoundSelector;
 end;//g_FoundSelector = nil
 Result := g_FoundSelector;
end;
var
 g_k2_attrPara: Integer = -1;

function k2_attrPara: Integer;
begin
 if (g_k2_attrPara = -1) then
  g_k2_attrPara :=  Tk2Attributes.Instance.CheckIDByName('Para');
 Result := g_k2_attrPara;
end;

var
 g_k2_attrWord: Integer = -1;

function k2_attrWord: Integer;
begin
 if (g_k2_attrWord = -1) then
  g_k2_attrWord :=  Tk2Attributes.Instance.CheckIDByName('Word');
 Result := g_k2_attrWord;
end;

var
 g_k2_attrDocument: Integer = -1;

function k2_attrDocument: Integer;
begin
 if (g_k2_attrDocument = -1) then
  g_k2_attrDocument :=  Tk2Attributes.Instance.CheckIDByName('Document');
 Result := g_k2_attrDocument;
end;


end.