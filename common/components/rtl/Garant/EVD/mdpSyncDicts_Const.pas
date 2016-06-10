unit mdpSyncDicts_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/mdpSyncDicts_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::mdpSyncDicts
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега mdpSyncDicts .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrSyncFolderMask: Integer;

function k2_attrGuardName: Integer;

function k2_typmdpSyncDicts: mdpSyncDictsTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_mdpSyncDicts : mdpSyncDictsTag = nil;

// start class mdpSyncDictsTag

function k2_typmdpSyncDicts: mdpSyncDictsTag;
begin
 if (g_mdpSyncDicts = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_mdpSyncDicts := TevdTasksSchema(Tk2TypeTable.GetInstance).t_mdpSyncDicts;
 end;//g_mdpSyncDicts = nil
 Result := g_mdpSyncDicts;
end;
var
 g_k2_attrSyncFolderMask: Integer = -1;

function k2_attrSyncFolderMask: Integer;
begin
 if (g_k2_attrSyncFolderMask = -1) then
  g_k2_attrSyncFolderMask :=  Tk2Attributes.Instance.CheckIDByName('SyncFolderMask');
 Result := g_k2_attrSyncFolderMask;
end;

var
 g_k2_attrGuardName: Integer = -1;

function k2_attrGuardName: Integer;
begin
 if (g_k2_attrGuardName = -1) then
  g_k2_attrGuardName :=  Tk2Attributes.Instance.CheckIDByName('GuardName');
 Result := g_k2_attrGuardName;
end;


end.