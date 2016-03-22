unit ddServerTaskManagerForTests;

// ������: "w:\archi\source\projects\PipeInAuto\Tests\ddServerTaskManagerForTests.pas"
// ���������: "SimpleClass"
// ������� ������: "TddServerTaskManagerForTests" MUID: (52F8E8A101EC)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 , alcuTaskManager
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
 , Classes
 , alcuServerTaskManagerFactory
 , alcuBaseEngineHolder
;

type
 TTaskDone = class(TThread)
  private
   f_Task: TddProcessTask;
   ServerTaskManager: TddServerTaskManager;
  protected
   procedure Execute; override;
 end;//TTaskDone

 TalcuServerTaskManagerFactoryForTests = class(TalcuServerTaskManagerFactory)
  protected
   class function DoMake(const aRootPath: AnsiString;
    const aBaseEngineHolder: TalcuBaseEngineHolder): TddServerTaskManager; override;
 end;//TalcuServerTaskManagerFactoryForTests

 TddServerTaskManagerForTests = class(TddServerTaskManager)
  protected
   procedure SimulateTaskDone(aTask: TddProcessTask); override;
    {* ��������� �������� ���������� ������������ ����� ���������� ������� }
   procedure BeforeSaveQuery; override;
   function NeedRaiseInProcessQuery: Boolean; override;
 end;//TddServerTaskManagerForTests
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , SysUtils
 {$If NOT Defined(NoScripts)}
 , afwAnswer
 {$IfEnd} // NOT Defined(NoScripts)
 , l3BatchService
;

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
 {* ��������� �������� ���������� ������������ ����� ���������� ������� }
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
 // - ��� ��������� �������� ��������� ������������
//#UC END# *52F8EDDA037F_52F8E8A101EC_impl*
end;//TddServerTaskManagerForTests.SimulateTaskDone

procedure TddServerTaskManagerForTests.BeforeSaveQuery;
//#UC START# *52F8EDF703C0_52F8E8A101EC_var*
//#UC END# *52F8EDF703C0_52F8E8A101EC_var*
begin
//#UC START# *52F8EDF703C0_52F8E8A101EC_impl*
 inherited;
 Sleep(100);
 // - ��������� ��������, ����� ������ ������ ������ "���������� �����"
//#UC END# *52F8EDF703C0_52F8E8A101EC_impl*
end;//TddServerTaskManagerForTests.BeforeSaveQuery

function TddServerTaskManagerForTests.NeedRaiseInProcessQuery: Boolean;
//#UC START# *52F8F0990208_52F8E8A101EC_var*
//#UC END# *52F8F0990208_52F8E8A101EC_var*
begin
//#UC START# *52F8F0990208_52F8E8A101EC_impl*
 Result := Tl3BatchService.Instance.IsBatchMode;
 // - �� ����� ����������, ����� ������� �� � ������
//#UC END# *52F8F0990208_52F8E8A101EC_impl*
end;//TddServerTaskManagerForTests.NeedRaiseInProcessQuery

initialization
//#UC START# *52FA2A9C014E*
 alcuServerTaskManagerFactory.g_FactoryClass := TalcuServerTaskManagerFactoryForTests;
//#UC END# *52FA2A9C014E*
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
