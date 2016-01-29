unit K517772970_TddGetTaskRequest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Low Level Tests"
// ������: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoad/K517772970_TddGetTaskRequest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TaskSaveLoad::K517772970_TddGetTaskRequest
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
  K517772970_TaskRequest
  {$If not defined(Nemesis)}
  ,
  ddServerTask
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}
type
 TK517772970_TddGetTaskRequest = class(TK517772970_TaskRequest)
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
 end;//TK517772970_TddGetTaskRequest
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  csTaskRequest
  {$IfEnd} //not Nemesis
  
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}

// start class TK517772970_TddGetTaskRequest

{$If defined(nsTest)}
function TK517772970_TddGetTaskRequest.GetFolder: AnsiString;
 {-}
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TddGetTaskRequest.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TddGetTaskRequest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '532140360355';
end;//TK517772970_TddGetTaskRequest.GetModelElementGUID
{$IfEnd} //nsTest

function TK517772970_TddGetTaskRequest.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_532140360355_var*
//#UC END# *5320088202FB_532140360355_var*
begin
//#UC START# *5320088202FB_532140360355_impl*
 result := TddGetTaskRequest;
//#UC END# *5320088202FB_532140360355_impl*
end;//TK517772970_TddGetTaskRequest.TaskClass

{$IfEnd} //AppServerSide AND InsiderTest

initialization
 TestFramework.RegisterTest(TK517772970_TddGetTaskRequest.Suite);

end.