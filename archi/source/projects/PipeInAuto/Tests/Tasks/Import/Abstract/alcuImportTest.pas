unit alcuImportTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Low Level Tests"
// Автор: Люлин А.В.
// Модуль: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/Import/Abstract/alcuImportTest.pas"
// Начат: 13.05.2014 18:07
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::AbstractImportTasks::TalcuImportTest
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
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  BaseTest
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  {$If not defined(Nemesis)}
  ,
  ddServerTask
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}
type
 _TaskSaver_Parent_ = TBaseTest;
 {$Include w:\archi\source\projects\PipeInAuto\Tests\TaskSaver.imp.pas}
 TalcuImportTest = {abstract} class(_TaskSaver_)
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
 published
 // published methods
   procedure DoIt;
 end;//TalcuImportTest
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  alcuServer
  {$If not defined(Nemesis)}
  ,
  csImport
  {$IfEnd} //not Nemesis
  ,
  SysUtils,
  ddFileIterator
  {$If defined(ServerTasks)}
  ,
  alcuImport
  {$IfEnd} //ServerTasks
  ,
  afwFacade,
  ddAppConfig,
  l3FileUtils,
  l3Stream,
  l3Types
  {$If not defined(Nemesis)}
  ,
  csLoopBack
  {$IfEnd} //not Nemesis
  
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  ,
  l3Filer
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}

{$Include w:\archi\source\projects\PipeInAuto\Tests\TaskSaver.imp.pas}

// start class TalcuImportTest

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

{$If defined(nsTest)}
function TalcuImportTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'AbstractImportTasks';
end;//TalcuImportTest.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TalcuImportTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '5372265401B9';
end;//TalcuImportTest.GetModelElementGUID
{$IfEnd} //nsTest

{$IfEnd} //AppServerSide AND InsiderTest

end.