unit alcuImportTest;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\Import\Abstract\alcuImportTest.pas"
// Стереотип: "TestCase"

{$Include alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 _TaskSaver_Parent_ = TBaseTest;
 {$Include w:\archi\source\projects\PipeInAuto\Tests\TaskSaver.imp.pas}
 TalcuImportTest = {abstract} class(_TaskSaver_)
  protected
   {$If Defined(nsTest)}
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$IfEnd} // Defined(nsTest)
   {$If Defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$IfEnd} // Defined(nsTest)
  public
   procedure DoIt;
 end;//TalcuImportTest
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , alcuServer
 {$If NOT Defined(Nemesis)}
 , csImport
 {$IfEnd} // NOT Defined(Nemesis)
 , SysUtils
 , ddFileIterator
 {$If Defined(ServerTasks)}
 , alcuImport
 {$IfEnd} // Defined(ServerTasks)
 , afwFacade
 , ddAppConfig
 , l3FileUtils
 , l3Stream
 , l3Types
 {$If NOT Defined(Nemesis)}
 , csLoopBack
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
 , l3Filer
;

{$Include w:\archi\source\projects\PipeInAuto\Tests\TaskSaver.imp.pas}

procedure TalcuImportTest.DoIt;
//#UC START# *537226BB0284_5372265401B9_var*
const
 defaultUser = 65000;
 cMask = '*.evd';
var
 l_Task : TcsImportTaskItem;
 l_TestSetFolder : String;
 l_RootTaskFolder : String;
 //l_TaskFolder : String;
 l_S : Tl3NamedTextStream;
//#UC END# *537226BB0284_5372265401B9_var*
begin
//#UC START# *537226BB0284_5372265401B9_impl*
 l_RootTaskFolder := ddAppConfiguration.AsString['RootTaskFolder'];
 PureDir(l_RootTaskFolder);
 TalcuServer.Instance.TaskProcessor.TaskExecutionEnabled := true;
 TalcuServer.Instance.TaskProcessor.TaskList.Clear;
 TalcuServer.Instance.UpdateRequestLists;
 TalcuServer.Instance.TaskProcessor.WaitForAsyncRunningTasks;
 l_TestSetFolder := Self.FileFromCurrent('K' + Self.KPage);
 //l_TaskFolder := '';
 try
  l_Task := {TalcuImport}TcsImportTaskItem.Create(defaultUser, defaultUser);
  try
//   l_Task.Date := defaultUser;
   l_Task.SourceDir := l_TestSetFolder;
   l_Task.TaskFolder := l_RootTaskFolder;

   with TddFileIterator.Make(l_Task.SourceDir, cMask) do
   try
    l_Task.SourceFiles.CopyFrom(FileList);
   finally
    Free;
   end;//try..finally
   SaveTask(l_Task, true);

(*   l_TaskFolder := l_Task.TaskFolder;
   ForceDirectories(l_TaskFolder);
   DeleteFilesByMask(l_TaskFolder, cMask);
   CopyFilesByMask(l_Task.SourceDir, l_TaskFolder, cMask);

   TalcuServer.Instance.TaskProcessor.AddTaskToRawList(l_Task);*)
  finally
   FreeAndNil(l_Task);
  end;//try..finally

  l_S := Tl3NamedTextStream.Create(FileForOutput, l3_fmRead, 1000);
  try
   TalcuServer.Instance.TaskProcessor.AddTaskFromStreamToIncoming(l_S, l_RootTaskFolder, true);
  finally
   FreeAndNil(l_S);
  end;//try..finally

  StartTimer;
  try
   TalcuServer.Instance.UpdateRequestLists;
   TalcuServer.Instance.TaskProcessor.WaitForAsyncRunningTasks;
  finally
   StopTimer;
  end;//try..finally
 finally
  //if (l_TaskFolder <> '') then
  // DelDir(l_TaskFolder);
  PureDir(l_RootTaskFolder);
 end;//try..finally
//#UC END# *537226BB0284_5372265401B9_impl*
end;//TalcuImportTest.DoIt

{$If Defined(nsTest)}
function TalcuImportTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'AbstractImportTasks';
end;//TalcuImportTest.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TalcuImportTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5372265401B9';
end;//TalcuImportTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)
end.
