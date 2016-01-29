unit K517772970_TddGetTaskRequestDefault;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Low Level Tests"
// ������: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoadWithDefault/K517772970_TddGetTaskRequestDefault.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TasksSaveLoadWithDefault::K517772970_TddGetTaskRequestDefault
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
  K517772970_TCheckSaveToStreamDefault
  {$If not defined(Nemesis)}
  ,
  ddServerTask
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}
type
 TK517772970_TddGetTaskRequestDefault = class(TK517772970_TCheckSaveToStreamDefault)
  {* [RequestLink:517772970] }
 protected
 // realized methods
   function GetTaskClass: TddTaskClass; override;
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
 end;//TK517772970_TddGetTaskRequestDefault
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
  ,
  l3Filer,
  SysUtils
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}

// start class TK517772970_TddGetTaskRequestDefault

function TK517772970_TddGetTaskRequestDefault.GetTaskClass: TddTaskClass;
//#UC START# *53170E4100CF_5319795B02BD_var*
//#UC END# *53170E4100CF_5319795B02BD_var*
begin
//#UC START# *53170E4100CF_5319795B02BD_impl*
 result := TddGetTaskRequest;
//#UC END# *53170E4100CF_5319795B02BD_impl*
end;//TK517772970_TddGetTaskRequestDefault.GetTaskClass

{$If defined(nsTest)}
function TK517772970_TddGetTaskRequestDefault.GetFolder: AnsiString;
 {-}
begin
 Result := 'TasksSaveLoadWithDefault';
end;//TK517772970_TddGetTaskRequestDefault.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TddGetTaskRequestDefault.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '5319795B02BD';
end;//TK517772970_TddGetTaskRequestDefault.GetModelElementGUID
{$IfEnd} //nsTest

{$IfEnd} //AppServerSide AND InsiderTest

initialization
 TestFramework.RegisterTest(TK517772970_TddGetTaskRequestDefault.Suite);

end.