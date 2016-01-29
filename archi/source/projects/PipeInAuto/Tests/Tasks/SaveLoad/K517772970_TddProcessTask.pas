unit K517772970_TddProcessTask;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Low Level Tests"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoad/K517772970_TddProcessTask.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TaskSaveLoad::K517772970_TddProcessTask
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
  K517772970_TddTaskItem
  {$If not defined(Nemesis)}
  ,
  ddServerTask
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}
type
 TK517772970_TddProcessTask = class(TK517772970_TddTaskItem)
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
 end;//TK517772970_TddProcessTask
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  csProcessTask
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  csTaskTypes
  {$IfEnd} //not Nemesis
  
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}

// start class TK517772970_TddProcessTask

{$If defined(nsTest)}
function TK517772970_TddProcessTask.GetFolder: AnsiString;
 {-}
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TddProcessTask.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TddProcessTask.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '53200B5D0155';
end;//TK517772970_TddProcessTask.GetModelElementGUID
{$IfEnd} //nsTest

function TK517772970_TddProcessTask.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53200B5D0155_var*
//#UC END# *5320088202FB_53200B5D0155_var*
begin
//#UC START# *5320088202FB_53200B5D0155_impl*
 result := TddProcessTask;
//#UC END# *5320088202FB_53200B5D0155_impl*
end;//TK517772970_TddProcessTask.TaskClass

procedure TK517772970_TddProcessTask.InitTask(Task: TddTaskItem);
//#UC START# *532008D203BA_53200B5D0155_var*
const
 Const111 = 111;
 Const123 = 123;
 Const678 = 678;
//#UC END# *532008D203BA_53200B5D0155_var*
begin
//#UC START# *532008D203BA_53200B5D0155_impl*
 inherited InitTask(Task);
 with (Task as TddProcessTask) do
 begin
  RequestRun;
  //Status := cs_tsRun;
  Comment := ClassName;
  DocumentIDList.Add(Const111);
  DocumentIDList.Add(Const123);
  DocumentIDList.Add(Const678);
 end;
//#UC END# *532008D203BA_53200B5D0155_impl*
end;//TK517772970_TddProcessTask.InitTask

{$IfEnd} //AppServerSide AND InsiderTest

initialization
 TestFramework.RegisterTest(TK517772970_TddProcessTask.Suite);

end.