unit mdpImportDocs_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/mdpImportDocs_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::mdpImportDocs
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега mdpImportDocs .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrMail: Integer;

function k2_attrErrorMail: Integer;

function k2_attrMaxCount: Integer;

function k2_typmdpImportDocs: mdpImportDocsTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_mdpImportDocs : mdpImportDocsTag = nil;

// start class mdpImportDocsTag

function k2_typmdpImportDocs: mdpImportDocsTag;
begin
 if (g_mdpImportDocs = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_mdpImportDocs := TevdTasksSchema(Tk2TypeTable.GetInstance).t_mdpImportDocs;
 end;//g_mdpImportDocs = nil
 Result := g_mdpImportDocs;
end;
var
 g_k2_attrMail: Integer = -1;

function k2_attrMail: Integer;
begin
 if (g_k2_attrMail = -1) then
  g_k2_attrMail :=  Tk2Attributes.Instance.CheckIDByName('Mail');
 Result := g_k2_attrMail;
end;

var
 g_k2_attrErrorMail: Integer = -1;

function k2_attrErrorMail: Integer;
begin
 if (g_k2_attrErrorMail = -1) then
  g_k2_attrErrorMail :=  Tk2Attributes.Instance.CheckIDByName('ErrorMail');
 Result := g_k2_attrErrorMail;
end;

var
 g_k2_attrMaxCount: Integer = -1;

function k2_attrMaxCount: Integer;
begin
 if (g_k2_attrMaxCount = -1) then
  g_k2_attrMaxCount :=  Tk2Attributes.Instance.CheckIDByName('MaxCount');
 Result := g_k2_attrMaxCount;
end;


end.