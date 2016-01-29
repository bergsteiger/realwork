unit K517772970_TalcuAutoExportTaskDefault;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Low Level Tests"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoadWithDefault/K517772970_TalcuAutoExportTaskDefault.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TasksSaveLoadWithDefault::K517772970_TalcuAutoExportTaskDefault
//
// {RequestLink:517772970}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  K517772970_TCheckSaveToStreamDefault
  {$If not defined(Nemesis)}
  ,
  ddServerTask
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}
type
 TK517772970_TalcuAutoExportTaskDefault = class(TK517772970_TCheckSaveToStreamDefault)
  {* [RequestLink:517772970] }
 protected
 // realized methods
   function GetTaskClass: TddTaskClass; override;
 protected
 // overridden protected methods
   {$If defined(nsTest)}
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   {$IfEnd} //nsTest
   {$If defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
   {$IfEnd} //nsTest
 end;//TK517772970_TalcuAutoExportTaskDefault
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  Classes
  {$If defined(ServerTasks)}
  ,
  alcuAutoExportTask
  {$IfEnd} //ServerTasks
  
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  ,
  l3Filer,
  SysUtils
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}

// start class TK517772970_TalcuAutoExportTaskDefault

function TK517772970_TalcuAutoExportTaskDefault.GetTaskClass: TddTaskClass;
//#UC START# *53170E4100CF_531976560191_var*
//#UC END# *53170E4100CF_531976560191_var*
begin
//#UC START# *53170E4100CF_531976560191_impl*
 result := TalcuAutoExportTask;
//#UC END# *53170E4100CF_531976560191_impl*
end;//TK517772970_TalcuAutoExportTaskDefault.GetTaskClass

{$If defined(nsTest)}
function TK517772970_TalcuAutoExportTaskDefault.GetFolder: AnsiString;
 {-}
begin
 Result := 'TasksSaveLoadWithDefault';
end;//TK517772970_TalcuAutoExportTaskDefault.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TalcuAutoExportTaskDefault.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '531976560191';
end;//TK517772970_TalcuAutoExportTaskDefault.GetModelElementGUID
{$IfEnd} //nsTest

{$IfEnd} //AppServerSide AND InsiderTest

initialization
 TestFramework.RegisterTest(TK517772970_TalcuAutoExportTaskDefault.Suite);

end.