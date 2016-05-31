unit alcuMdpImportSyncronizer;
 {* Синхронизация в Гардок журнала импорта документов в Архивариус }

// Модуль: "w:\archi\source\projects\PipeInAuto\Process\alcuMdpImportSyncronizer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMdpImportSyncronizer" MUID: (574C0FA701BB)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
 l3IntfUses
 , alcuMdpProtoSyncronizer
 , Classes
;

type
 TalcuMdpImportSyncronizer = class(TalcuMdpProtoSyncronizer)
  {* Синхронизация в Гардок журнала импорта документов в Архивариус }
  protected
   function PrepareData(aStream: TStream): Boolean; override;
   procedure BeforeSync; override;
   procedure AfterSuccessfulSync; override;
   function GetTitle: AnsiString; override;
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
 !!! Needs to be implemented !!!
//#UC END# *574C359C0010_574C0FA701BB_impl*
end;//TalcuMdpImportSyncronizer.PrepareData

procedure TalcuMdpImportSyncronizer.BeforeSync;
//#UC START# *574C36DA009E_574C0FA701BB_var*
//#UC END# *574C36DA009E_574C0FA701BB_var*
begin
//#UC START# *574C36DA009E_574C0FA701BB_impl*
 !!! Needs to be implemented !!!
//#UC END# *574C36DA009E_574C0FA701BB_impl*
end;//TalcuMdpImportSyncronizer.BeforeSync

procedure TalcuMdpImportSyncronizer.AfterSuccessfulSync;
//#UC START# *574C37130370_574C0FA701BB_var*
//#UC END# *574C37130370_574C0FA701BB_var*
begin
//#UC START# *574C37130370_574C0FA701BB_impl*
 !!! Needs to be implemented !!!
//#UC END# *574C37130370_574C0FA701BB_impl*
end;//TalcuMdpImportSyncronizer.AfterSuccessfulSync

function TalcuMdpImportSyncronizer.GetTitle: AnsiString;
//#UC START# *574C395100E9_574C0FA701BB_var*
//#UC END# *574C395100E9_574C0FA701BB_var*
begin
//#UC START# *574C395100E9_574C0FA701BB_impl*
 !!! Needs to be implemented !!!
//#UC END# *574C395100E9_574C0FA701BB_impl*
end;//TalcuMdpImportSyncronizer.GetTitle

end.
