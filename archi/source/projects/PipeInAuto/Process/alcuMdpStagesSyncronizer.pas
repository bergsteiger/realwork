unit alcuMdpStagesSyncronizer;
 {* Синхронизация этапов в Гардок }

// Модуль: "w:\archi\source\projects\PipeInAuto\Process\alcuMdpStagesSyncronizer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMdpStagesSyncronizer" MUID: (574C0F390376)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
 l3IntfUses
 , alcuMdpProtoSyncronizer
 , Classes
;

type
 TalcuMdpStagesSyncronizer = class(TalcuMdpProtoSyncronizer)
  {* Синхронизация этапов в Гардок }
  protected
   function PrepareData(aStream: TStream): Boolean; override;
   procedure BeforeSync; override;
   procedure AfterSuccessfulSync; override;
   function GetTitle: AnsiString; override;
 end;//TalcuMdpStagesSyncronizer

implementation

uses
 l3ImplUses
;

function TalcuMdpStagesSyncronizer.PrepareData(aStream: TStream): Boolean;
//#UC START# *574C359C0010_574C0F390376_var*
//#UC END# *574C359C0010_574C0F390376_var*
begin
//#UC START# *574C359C0010_574C0F390376_impl*
 !!! Needs to be implemented !!!
//#UC END# *574C359C0010_574C0F390376_impl*
end;//TalcuMdpStagesSyncronizer.PrepareData

procedure TalcuMdpStagesSyncronizer.BeforeSync;
//#UC START# *574C36DA009E_574C0F390376_var*
//#UC END# *574C36DA009E_574C0F390376_var*
begin
//#UC START# *574C36DA009E_574C0F390376_impl*
 !!! Needs to be implemented !!!
//#UC END# *574C36DA009E_574C0F390376_impl*
end;//TalcuMdpStagesSyncronizer.BeforeSync

procedure TalcuMdpStagesSyncronizer.AfterSuccessfulSync;
//#UC START# *574C37130370_574C0F390376_var*
//#UC END# *574C37130370_574C0F390376_var*
begin
//#UC START# *574C37130370_574C0F390376_impl*
 !!! Needs to be implemented !!!
//#UC END# *574C37130370_574C0F390376_impl*
end;//TalcuMdpStagesSyncronizer.AfterSuccessfulSync

function TalcuMdpStagesSyncronizer.GetTitle: AnsiString;
//#UC START# *574C395100E9_574C0F390376_var*
//#UC END# *574C395100E9_574C0F390376_var*
begin
//#UC START# *574C395100E9_574C0F390376_impl*
 !!! Needs to be implemented !!!
//#UC END# *574C395100E9_574C0F390376_impl*
end;//TalcuMdpStagesSyncronizer.GetTitle

end.
