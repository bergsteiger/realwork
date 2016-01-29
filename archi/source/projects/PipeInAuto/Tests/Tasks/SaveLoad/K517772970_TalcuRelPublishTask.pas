unit K517772970_TalcuRelPublishTask;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Low Level Tests"
// ������: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoad/K517772970_TalcuRelPublishTask.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TaskSaveLoad::K517772970_TalcuRelPublishTask
//
// {RequestLink:517772970}
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
  K517772970_TcsImportTaskItem
  {$If not defined(Nemesis)}
  ,
  ddServerTask
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}
type
 TK517772970_TalcuRelPublishTask = class(TK517772970_TcsImportTaskItem)
  {* [RequestLink:517772970] }
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
   function TaskClass: TddTaskClass; override;
 end;//TK517772970_TalcuRelPublishTask
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  Classes
  {$If defined(ServerTasks)}
  ,
  alcuRelCorrector
  {$IfEnd} //ServerTasks
  
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}

// start class TK517772970_TalcuRelPublishTask

{$If defined(nsTest)}
function TK517772970_TalcuRelPublishTask.GetFolder: AnsiString;
 {-}
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TalcuRelPublishTask.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TalcuRelPublishTask.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '53218ABF03BE';
end;//TK517772970_TalcuRelPublishTask.GetModelElementGUID
{$IfEnd} //nsTest

function TK517772970_TalcuRelPublishTask.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53218ABF03BE_var*
//#UC END# *5320088202FB_53218ABF03BE_var*
begin
//#UC START# *5320088202FB_53218ABF03BE_impl*
 result := TalcuRelPublishTask;
//#UC END# *5320088202FB_53218ABF03BE_impl*
end;//TK517772970_TalcuRelPublishTask.TaskClass

{$IfEnd} //AppServerSide AND InsiderTest

initialization
 TestFramework.RegisterTest(TK517772970_TalcuRelPublishTask.Suite);

end.