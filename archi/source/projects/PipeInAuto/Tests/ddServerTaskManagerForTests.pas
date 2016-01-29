unit ddServerTaskManagerForTests;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Low Level Tests"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tests/ddServerTaskManagerForTests.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TaskProcessingTuningForTests::TddServerTaskManagerForTests
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
  Classes,
  alcuTaskManager
  {$If not defined(Nemesis)}
  ,
  csProcessTask
  {$IfEnd} //not Nemesis
  ,
  alcuServerTaskManagerFactory,
  alcuBaseEngineHolder
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}
type
 TTaskDone = class(TThread)
 private
 // private fields
   f_Task : TddProcessTask;
   ServerTaskManager : TddServerTaskManager;
 protected
 // realized methods
   procedure Execute; override;
 end;//TTaskDone

 TalcuServerTaskManagerFactoryForTests = class(TalcuServerTaskManagerFactory)
 protected
 // overridden protected methods
   class function DoMake(const aRootPath: AnsiString;
    const aBaseEngineHolder: TalcuBaseEngineHolder): TddServerTaskManager; override;
 end;//TalcuServerTaskManagerFactoryForTests

 TddServerTaskManagerForTests = class(TddServerTaskManager)
 protected
 // overridden protected methods
   procedure SimulateTaskDone(aTask: TddProcessTask); override;
     {* имитирует отправку результата пользователю после выполнения задания }
   procedure BeforeSaveQuery; override;
     {* Сигнатура метода BeforeSaveQuery }
   function NeedRaiseInProcessQuery: Boolean; override;
 end;//TddServerTaskManagerForTests
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  afwAnswer
  {$IfEnd} //not NoScripts
  ,
  l3BatchService
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}

// start class TTaskDone

procedure TTaskDone.Execute;
//#UC START# *4FFFDF740099_52F8EE5400B0_var*
//#UC END# *4FFFDF740099_52F8EE5400B0_var*
begin
//#UC START# *4FFFDF740099_52F8EE5400B0_impl*
 try
  TddServerTaskManagerForTests(ServerTaskManager).TaskDone(f_Task);
 finally
  FreeAndNil(f_Task);
 end;//try..finally
//#UC END# *4FFFDF740099_52F8EE5400B0_impl*
end;//TTaskDone.Execute
// start class TalcuServerTaskManagerFactoryForTests

class function TalcuServerTaskManagerFactoryForTests.DoMake(const aRootPath: AnsiString;
  const aBaseEngineHolder: TalcuBaseEngineHolder): TddServerTaskManager;
//#UC START# *52FA2C99010A_52FA2C470046_var*
//#UC END# *52FA2C99010A_52FA2C470046_var*
begin
//#UC START# *52FA2C99010A_52FA2C470046_impl*
 Result := TddServerTaskManagerForTests.Create(aRootPath, aBaseEngineHolder);
//#UC END# *52FA2C99010A_52FA2C470046_impl*
end;//TalcuServerTaskManagerFactoryForTests.DoMake

procedure TddServerTaskManagerForTests.SimulateTaskDone(aTask: TddProcessTask);
//#UC START# *52F8EDDA037F_52F8E8A101EC_var*
//#UC END# *52F8EDDA037F_52F8E8A101EC_var*
begin
//#UC START# *52F8EDDA037F_52F8E8A101EC_impl*
 inherited;
 with TTaskDone.Create(false) do
 begin
  aTask.SetRefTo(f_Task);
  ServerTaskManager := Self;
  FreeOnTerminate := true;
  Resume;
 end;//with TTaskDone.Create(false)
 // - тут эмулируем отправку сообщения пользователю
//#UC END# *52F8EDDA037F_52F8E8A101EC_impl*
end;//TddServerTaskManagerForTests.SimulateTaskDone

procedure TddServerTaskManagerForTests.BeforeSaveQuery;
//#UC START# *52F8EDF703C0_52F8E8A101EC_var*
//#UC END# *52F8EDF703C0_52F8E8A101EC_var*
begin
//#UC START# *52F8EDF703C0_52F8E8A101EC_impl*
 inherited;
 Sleep(100);
 // - эмулируем задержку, чтобы другие потоки смогли "проскочить вперёд"
//#UC END# *52F8EDF703C0_52F8E8A101EC_impl*
end;//TddServerTaskManagerForTests.BeforeSaveQuery

function TddServerTaskManagerForTests.NeedRaiseInProcessQuery: Boolean;
//#UC START# *52F8F0990208_52F8E8A101EC_var*
//#UC END# *52F8F0990208_52F8E8A101EC_var*
begin
//#UC START# *52F8F0990208_52F8E8A101EC_impl*
 Result := Tl3BatchService.Instance.IsBatchMode;
 // - не давим исключения, чтобы увидеть их в тестах
//#UC END# *52F8F0990208_52F8E8A101EC_impl*
end;//TddServerTaskManagerForTests.NeedRaiseInProcessQuery

{$IfEnd} //AppServerSide AND InsiderTest

initialization
{$If defined(AppServerSide) AND defined(InsiderTest)}
//#UC START# *52FA2A9C014E*
 alcuServerTaskManagerFactory.g_FactoryClass := TalcuServerTaskManagerFactoryForTests;
//#UC END# *52FA2A9C014E*
{$IfEnd} //AppServerSide AND InsiderTest

end.