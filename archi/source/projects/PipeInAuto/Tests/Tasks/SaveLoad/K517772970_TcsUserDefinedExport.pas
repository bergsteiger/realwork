unit K517772970_TcsUserDefinedExport;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Low Level Tests"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoad/K517772970_TcsUserDefinedExport.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TaskSaveLoad::K517772970_TcsUserDefinedExport
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
 TK517772970_TcsUserDefinedExport = class(TK517772970_TddProcessTask)
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
 end;//TK517772970_TcsUserDefinedExport
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  csUserDefinedExport
  {$IfEnd} //not Nemesis
  
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}

// start class TK517772970_TcsUserDefinedExport

{$If defined(nsTest)}
function TK517772970_TcsUserDefinedExport.GetFolder: AnsiString;
 {-}
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TcsUserDefinedExport.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TcsUserDefinedExport.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '53B26EC60189';
end;//TK517772970_TcsUserDefinedExport.GetModelElementGUID
{$IfEnd} //nsTest

function TK517772970_TcsUserDefinedExport.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53B26EC60189_var*
//#UC END# *5320088202FB_53B26EC60189_var*
begin
//#UC START# *5320088202FB_53B26EC60189_impl*
 Result := TcsUserDefinedExport;
//#UC END# *5320088202FB_53B26EC60189_impl*
end;//TK517772970_TcsUserDefinedExport.TaskClass

procedure TK517772970_TcsUserDefinedExport.InitTask(Task: TddTaskItem);
//#UC START# *532008D203BA_53B26EC60189_var*
//#UC END# *532008D203BA_53B26EC60189_var*
begin
//#UC START# *532008D203BA_53B26EC60189_impl*
 inherited;
 with (Task As TcsUserDefinedExport) do
 begin
  QueryFile := Self.FileFromCurrent('A.evd');
  TimeToRun := Date + 100;
 end;//with (Task As TcsUserDefinedExport)
//#UC END# *532008D203BA_53B26EC60189_impl*
end;//TK517772970_TcsUserDefinedExport.InitTask

{$IfEnd} //AppServerSide AND InsiderTest

initialization
 TestFramework.RegisterTest(TK517772970_TcsUserDefinedExport.Suite);

end.