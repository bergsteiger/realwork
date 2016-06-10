unit mdpSyncImport_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/mdpSyncImport_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::mdpSyncImport
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега mdpSyncImport .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typmdpSyncImport: mdpSyncImportTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_mdpSyncImport : mdpSyncImportTag = nil;

// start class mdpSyncImportTag

function k2_typmdpSyncImport: mdpSyncImportTag;
begin
 if (g_mdpSyncImport = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_mdpSyncImport := TevdTasksSchema(Tk2TypeTable.GetInstance).t_mdpSyncImport;
 end;//g_mdpSyncImport = nil
 Result := g_mdpSyncImport;
end;

end.