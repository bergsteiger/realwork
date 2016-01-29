unit AutoClassTask_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/AutoClassTask_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::AutoClassTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега AutoClassTask .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrBuilderFileName: Integer;

function k2_attrResultFileName: Integer;

function k2_attrSourceFolder: Integer;

function k2_attrLogFileName: Integer;

function k2_attreMailNotifyList: Integer;

function k2_typAutoClassTask: AutoClassTaskTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_AutoClassTask : AutoClassTaskTag = nil;

// start class AutoClassTaskTag

function k2_typAutoClassTask: AutoClassTaskTag;
begin
 if (g_AutoClassTask = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AutoClassTask := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AutoClassTask;
 end;//g_AutoClassTask = nil
 Result := g_AutoClassTask;
end;
var
 g_k2_attrBuilderFileName: Integer = -1;

function k2_attrBuilderFileName: Integer;
begin
 if (g_k2_attrBuilderFileName = -1) then
  g_k2_attrBuilderFileName :=  Tk2Attributes.Instance.CheckIDByName('BuilderFileName');
 Result := g_k2_attrBuilderFileName;
end;

var
 g_k2_attrResultFileName: Integer = -1;

function k2_attrResultFileName: Integer;
begin
 if (g_k2_attrResultFileName = -1) then
  g_k2_attrResultFileName :=  Tk2Attributes.Instance.CheckIDByName('ResultFileName');
 Result := g_k2_attrResultFileName;
end;

var
 g_k2_attrSourceFolder: Integer = -1;

function k2_attrSourceFolder: Integer;
begin
 if (g_k2_attrSourceFolder = -1) then
  g_k2_attrSourceFolder :=  Tk2Attributes.Instance.CheckIDByName('SourceFolder');
 Result := g_k2_attrSourceFolder;
end;

var
 g_k2_attrLogFileName: Integer = -1;

function k2_attrLogFileName: Integer;
begin
 if (g_k2_attrLogFileName = -1) then
  g_k2_attrLogFileName :=  Tk2Attributes.Instance.CheckIDByName('LogFileName');
 Result := g_k2_attrLogFileName;
end;

var
 g_k2_attreMailNotifyList: Integer = -1;

function k2_attreMailNotifyList: Integer;
begin
 if (g_k2_attreMailNotifyList = -1) then
  g_k2_attreMailNotifyList :=  Tk2Attributes.Instance.CheckIDByName('eMailNotifyList');
 Result := g_k2_attreMailNotifyList;
end;


end.