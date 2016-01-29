unit K517772970_TalcuAnnotationTask;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Low Level Tests"
// ������: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoad/K517772970_TalcuAnnotationTask.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TaskSaveLoad::K517772970_TalcuAnnotationTask
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
  K517772970_TddProcessTask
  {$If not defined(Nemesis)}
  ,
  ddServerTask
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}
type
 TK517772970_TalcuAnnotationTask = class(TK517772970_TddProcessTask)
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
 end;//TK517772970_TalcuAnnotationTask
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  Classes
  {$If defined(ServerTasks)}
  ,
  alcuAnnotationTask
  {$IfEnd} //ServerTasks
  
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}

// start class TK517772970_TalcuAnnotationTask

{$If defined(nsTest)}
function TK517772970_TalcuAnnotationTask.GetFolder: AnsiString;
 {-}
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TalcuAnnotationTask.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TalcuAnnotationTask.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '53214E9A00C3';
end;//TK517772970_TalcuAnnotationTask.GetModelElementGUID
{$IfEnd} //nsTest

function TK517772970_TalcuAnnotationTask.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53214E9A00C3_var*
//#UC END# *5320088202FB_53214E9A00C3_var*
begin
//#UC START# *5320088202FB_53214E9A00C3_impl*
 result := TalcuAnnotationTask;
//#UC END# *5320088202FB_53214E9A00C3_impl*
end;//TK517772970_TalcuAnnotationTask.TaskClass

{$IfEnd} //AppServerSide AND InsiderTest

initialization
 TestFramework.RegisterTest(TK517772970_TalcuAnnotationTask.Suite);

end.