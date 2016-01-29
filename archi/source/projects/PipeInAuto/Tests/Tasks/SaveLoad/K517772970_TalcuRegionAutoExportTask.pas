unit K517772970_TalcuRegionAutoExportTask;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Low Level Tests"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoad/K517772970_TalcuRegionAutoExportTask.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TaskSaveLoad::K517772970_TalcuRegionAutoExportTask
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
  K517772970_TddProcessTask
  {$If not defined(Nemesis)}
  ,
  ddServerTask
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}
type
 TK517772970_TalcuRegionAutoExportTask = class(TK517772970_TddProcessTask)
  {* [RequestLink:517772970] }
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
   function TaskClass: TddTaskClass; override;
   procedure InitTask(Task: TddTaskItem); override;
 end;//TK517772970_TalcuRegionAutoExportTask
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  Classes
  {$If defined(ServerTasks)}
  ,
  alcuRegionAutoExportTask
  {$IfEnd} //ServerTasks
  
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}

// start class TK517772970_TalcuRegionAutoExportTask

{$If defined(nsTest)}
function TK517772970_TalcuRegionAutoExportTask.GetFolder: AnsiString;
 {-}
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TalcuRegionAutoExportTask.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TalcuRegionAutoExportTask.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '53214D920123';
end;//TK517772970_TalcuRegionAutoExportTask.GetModelElementGUID
{$IfEnd} //nsTest

function TK517772970_TalcuRegionAutoExportTask.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53214D920123_var*
//#UC END# *5320088202FB_53214D920123_var*
begin
//#UC START# *5320088202FB_53214D920123_impl*
 result := TalcuRegionAutoExportTask;
//#UC END# *5320088202FB_53214D920123_impl*
end;//TK517772970_TalcuRegionAutoExportTask.TaskClass

procedure TK517772970_TalcuRegionAutoExportTask.InitTask(Task: TddTaskItem);
//#UC START# *532008D203BA_53214D920123_var*
const
 IntConst = 2;
//#UC END# *532008D203BA_53214D920123_var*
begin
//#UC START# *532008D203BA_53214D920123_impl*
 inherited InitTask(Task);
 (Task as TalcuRegionAutoExportTask).RegionIndex := IntConst;
//#UC END# *532008D203BA_53214D920123_impl*
end;//TK517772970_TalcuRegionAutoExportTask.InitTask

{$IfEnd} //AppServerSide AND InsiderTest

initialization
 TestFramework.RegisterTest(TK517772970_TalcuRegionAutoExportTask.Suite);

end.