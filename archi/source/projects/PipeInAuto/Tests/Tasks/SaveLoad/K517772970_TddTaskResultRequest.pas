unit K517772970_TddTaskResultRequest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Low Level Tests"
// ������: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoad/K517772970_TddTaskResultRequest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TaskSaveLoad::K517772970_TddTaskResultRequest
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
 TK517772970_TddTaskResultRequest = class(TK517772970_TaskRequest)
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
 end;//TK517772970_TddTaskResultRequest
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

// start class TK517772970_TddTaskResultRequest

{$If defined(nsTest)}
function TK517772970_TddTaskResultRequest.GetFolder: AnsiString;
 {-}
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TddTaskResultRequest.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TddTaskResultRequest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '532140140146';
end;//TK517772970_TddTaskResultRequest.GetModelElementGUID
{$IfEnd} //nsTest

function TK517772970_TddTaskResultRequest.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_532140140146_var*
//#UC END# *5320088202FB_532140140146_var*
begin
//#UC START# *5320088202FB_532140140146_impl*
 result := TddTaskResultRequest;
//#UC END# *5320088202FB_532140140146_impl*
end;//TK517772970_TddTaskResultRequest.TaskClass

{$IfEnd} //AppServerSide AND InsiderTest

initialization
 TestFramework.RegisterTest(TK517772970_TddTaskResultRequest.Suite);

end.