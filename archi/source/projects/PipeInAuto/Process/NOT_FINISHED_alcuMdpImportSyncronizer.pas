unit NOT_FINISHED_alcuMdpImportSyncronizer;
 {* Синхронизация в Гардок журнала импорта документов в Архивариус }

// Модуль: "w:\archi\source\projects\PipeInAuto\Process\NOT_FINISHED_alcuMdpImportSyncronizer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMdpImportSyncronizer" MUID: (574C0FA701BB)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
 l3IntfUses
 , alcuMdpDatedSyncronizer
 , Classes
;

type
 TalcuMdpImportSyncronizer = class(TalcuMdpDatedSyncronizer)
  {* Синхронизация в Гардок журнала импорта документов в Архивариус }
  protected
   function PrepareData(aStream: TStream): Boolean; override;
   function GetTitle: AnsiString; override;
   function GetIniParamName: AnsiString; override;
 end;//TalcuMdpImportSyncronizer

implementation

uses
 l3ImplUses
;

function TalcuMdpImportSyncronizer.PrepareData(aStream: TStream): Boolean;
//#UC START# *574C359C0010_574C0FA701BB_var*
//#UC END# *574C359C0010_574C0FA701BB_var*
begin
//#UC START# *574C359C0010_574C0FA701BB_impl*

//#UC END# *574C359C0010_574C0FA701BB_impl*
end;//TalcuMdpImportSyncronizer.PrepareData

function TalcuMdpImportSyncronizer.GetTitle: AnsiString;
//#UC START# *574C395100E9_574C0FA701BB_var*
//#UC END# *574C395100E9_574C0FA701BB_var*
begin
//#UC START# *574C395100E9_574C0FA701BB_impl*

//#UC END# *574C395100E9_574C0FA701BB_impl*
end;//TalcuMdpImportSyncronizer.GetTitle

function TalcuMdpImportSyncronizer.GetIniParamName: AnsiString;
//#UC START# *574E9F28031C_574C0FA701BB_var*
//#UC END# *574E9F28031C_574C0FA701BB_var*
begin
//#UC START# *574E9F28031C_574C0FA701BB_impl*
 !!! Needs to be implemented !!!
//#UC END# *574E9F28031C_574C0FA701BB_impl*
end;//TalcuMdpImportSyncronizer.GetIniParamName

end.
