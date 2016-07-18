unit NOT_FINISHED_alcuMdpStagesSyncronizer;
 {* Синхронизация этапов в Гардок }

// Модуль: "w:\archi\source\projects\PipeInAuto\Process\NOT_FINISHED_alcuMdpStagesSyncronizer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMdpStagesSyncronizer" MUID: (574C0F390376)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
 l3IntfUses
 , alcuMdpDatedSyncronizer
 , dt_Types
 , Classes
;

type
 TalcuMdpStagesSyncronizer = class(TalcuMdpDatedSyncronizer)
  {* Синхронизация этапов в Гардок }
  private
   function GetGardocStageCode(aStageType: TStageType): Integer;
  protected
   function PrepareData(aStream: TStream): Boolean; override;
   function GetTitle: AnsiString; override;
   function GetIniParamName: AnsiString; override;
 end;//TalcuMdpStagesSyncronizer

implementation

uses
 l3ImplUses
 , l3XMLWriter
 , l3Interfaces
 , l3Date
 {$If NOT Defined(Nemesis)}
 , dtIntf
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_Sab
 {$IfEnd} // NOT Defined(Nemesis)
 , daTypes
;

function TalcuMdpStagesSyncronizer.GetGardocStageCode(aStageType: TStageType): Integer;
//#UC START# *574EC035002D_574C0F390376_var*
//#UC END# *574EC035002D_574C0F390376_var*
begin
//#UC START# *574EC035002D_574C0F390376_impl*
 !!! Needs to be implemented !!!
//#UC END# *574EC035002D_574C0F390376_impl*
end;//TalcuMdpStagesSyncronizer.GetGardocStageCode

function TalcuMdpStagesSyncronizer.PrepareData(aStream: TStream): Boolean;
//#UC START# *574C359C0010_574C0F390376_var*
//#UC END# *574C359C0010_574C0F390376_var*
begin
//#UC START# *574C359C0010_574C0F390376_impl*

//#UC END# *574C359C0010_574C0F390376_impl*
end;//TalcuMdpStagesSyncronizer.PrepareData

function TalcuMdpStagesSyncronizer.GetTitle: AnsiString;
//#UC START# *574C395100E9_574C0F390376_var*
//#UC END# *574C395100E9_574C0F390376_var*
begin
//#UC START# *574C395100E9_574C0F390376_impl*

//#UC END# *574C395100E9_574C0F390376_impl*
end;//TalcuMdpStagesSyncronizer.GetTitle

function TalcuMdpStagesSyncronizer.GetIniParamName: AnsiString;
//#UC START# *574E9F28031C_574C0F390376_var*
//#UC END# *574E9F28031C_574C0F390376_var*
begin
//#UC START# *574E9F28031C_574C0F390376_impl*
 !!! Needs to be implemented !!!
//#UC END# *574E9F28031C_574C0F390376_impl*
end;//TalcuMdpStagesSyncronizer.GetIniParamName

end.
