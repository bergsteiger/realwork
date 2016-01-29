unit K515862135;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Low Level Tests"
// ������: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/Processing/K515862135.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TasksProcessing::K515862135
//
// {RequestLink:515862135}
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  BaseTest
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}
type
 TK515862135 = class(TBaseTest)
  {* [RequestLink:515862135] }
 protected
 // overridden protected methods
   {$If defined(nsTest)}
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   {$IfEnd} //nsTest
   {$If defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
   {$IfEnd} //nsTest
 published
 // published methods
   procedure DoIt;
 end;//TK515862135
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  ddAppConfig,
  SysUtils,
  AutoPipeServerForm,
  l3FileUtils,
  alcuTaskManager
  {$If not defined(Nemesis)}
  ,
  csProcessTask
  {$IfEnd} //not Nemesis
  ,
  alcuServer,
  ddServerTaskManagerForTests,
  l3Stream,
  l3Types
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}

// start class TK515862135

procedure TK515862135.DoIt;
//#UC START# *52F2765601BE_52F2763F0320_var*
var
 l_Index : Integer;
 //l_TaskMen: TddServerTaskManager;
 //l_Task: TddProcessTask;
 l_TestSetFolder : String;
 l_RootTaskFolder : String;
 //l_RootTaskFolder_2 : string;
 l_NewTaskFolder : String;
 l_TaskStream : Tl3NamedTextStream;
//#UC END# *52F2765601BE_52F2763F0320_var*
begin
//#UC START# *52F2765601BE_52F2763F0320_impl*
 //ExpectedException := EListError;
 // - �������, ��� ������ ����������� ������ ����������
 for l_Index := 0 to 6 do
 // - ����, ����� ������ ����� �����������
 begin
  l_TestSetFolder := Self.FileFromCurrent('K' + Self.KPage);
  l_RootTaskFolder := ddAppConfiguration.AsString['RootTaskFolder'];
(*  l_RootTaskFolder_2 := l_RootTaskFolder + 'K' + Self.KPage;

  if DirectoryExists(l_RootTaskFolder_2) then
   DeleteFilesByMask(l_RootTaskFolder_2, '*')
  else
   CreateDir(l_RootTaskFolder_2);
  CopyFilesByMask(l_TestSetFolder + '\TaskRoot_New', l_RootTaskFolder_2, '*');
  // - ��� ������� �������� �������, ������� "����� �����"*)

  try
   // ===== ��� ������� ������� �������
    DeleteFilesByMask(l_RootTaskFolder, '*');
    TalcuServer.Instance.TaskProcessor.TaskList.Clear;
    TalcuServer.Instance.TaskProcessor.ActiveTaskList.Clear;
    ArchiServerForm.RefreshButtonClick(nil);
   // =====

   Check(TalcuServer.Instance.TaskProcessor.TaskList.Count = 0, '������� ������� �� ������');
   // - ����������, ��� ������� ������� ������

   // ===== ��� ��������� ��� ������� ��� ����������
    DeleteFilesByMask(l_RootTaskFolder, '*');
    CopyFilesByMask(l_TestSetFolder + '\TaskRoot_Save', l_RootTaskFolder, '*');
    TalcuServer.Instance.TaskProcessor.LoadQuery;
    ArchiServerForm.RefreshButtonClick(nil);
    // - � �� ���� - "���-�� ���" ���� �� ������� ������ ����������� �� ����������
    //   ������ � ��������� ������
    // - ��� �� ��� - ��� ������ �� �����������, ��� ������ ���������� �������
    //   �� ���� �������
   // =====

   // ===== ��� �������� ������ ������� �� ������������. ��� ����� �� TCP/IP
(*   l_TaskMen := TddServerTaskManager.Create(l_RootTaskFolder_2);
   try*)
    l_NewTaskFolder := l_TestSetFolder + '\TaskRoot_New';
    l_TaskStream := Tl3NamedTextStream.Create(l_NewTaskFolder + '\659-10-02-05-889.query', l3_fmRead, 1000);
    try
     TalcuServer.Instance.TaskProcessor.AddTaskFromStreamToIncoming(l_TaskStream, l_NewTaskFolder, false);
    finally
     FreeAndNil(l_TaskStream);
    end;//try..finally
(*     l_TaskMen.LoadQuery;
     l_Task := l_TaskMen.ActiveTaskList[0];
     TalcuServer.Instance.TaskProcessor.RawList.Add(l_Task);*)
     // - �������� TddServerTaskManager.cs_ServerTaskReply
     // !!! ���� ����� ����� ����� ���������� ����� ���������� ������ - http://mdp.garant.ru/pages/viewpage.action?pageId=516544010
   // =====

    TalcuServer.Instance.TaskProcessor.CanSimulateTaskDone := true;
    TalcuServer.Instance.UpdateRequestLists;
    TalcuServer.Instance.TaskProcessor.WaitForAsyncRunningTasks;
    // - ������ �����, ������� � ����� ������� � ���������� ������� �������
    //   ������� � �������� � ������
    //   �������� ��� ��������� ����� "��������� ��������� ������������" (TaskDone,
    //   ������� � ��������� ������� �������) � "����������� ������ �������",
    //   ��� ��� ��� �������� ��� ��� � ���� � ������ �������
(*   finally
    FreeAndNil(l_TaskMen);
   end;//try..finally*)
  finally
   DeleteFilesByMask(l_RootTaskFolder, '*');
   // - ������� "�����", ����� ���� ����� ����������
  end;//try..finally
 end;//for l_Index
//#UC END# *52F2765601BE_52F2763F0320_impl*
end;//TK515862135.DoIt

{$If defined(nsTest)}
function TK515862135.GetFolder: AnsiString;
 {-}
begin
 Result := 'TasksProcessing';
end;//TK515862135.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK515862135.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '52F2763F0320';
end;//TK515862135.GetModelElementGUID
{$IfEnd} //nsTest

{$IfEnd} //AppServerSide AND InsiderTest

initialization
 TestFramework.RegisterTest(TK515862135.Suite);

end.