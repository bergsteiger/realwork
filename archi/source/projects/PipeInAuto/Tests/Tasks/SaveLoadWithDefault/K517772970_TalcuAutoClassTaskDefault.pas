unit K517772970_TalcuAutoClassTaskDefault;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Low Level Tests"
// ������: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoadWithDefault/K517772970_TalcuAutoClassTaskDefault.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TasksSaveLoadWithDefault::K517772970_TalcuAutoClassTaskDefault
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
 TK517772970_TalcuAutoClassTaskDefault = class(TK517772970_TCheckSaveToStreamDefault)
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
 end;//TK517772970_TalcuAutoClassTaskDefault
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  Classes
  {$If defined(ServerTasks)}
  ,
  alcuAutoClassifier
  {$IfEnd} //ServerTasks
  
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

// start class TK517772970_TalcuAutoClassTaskDefault

function TK517772970_TalcuAutoClassTaskDefault.GetTaskClass: TddTaskClass;
//#UC START# *53170E4100CF_531956300316_var*
//#UC END# *53170E4100CF_531956300316_var*
begin
//#UC START# *53170E4100CF_531956300316_impl*
 result := TalcuAutoClassTask;
//#UC END# *53170E4100CF_531956300316_impl*
end;//TK517772970_TalcuAutoClassTaskDefault.GetTaskClass

{$If defined(nsTest)}
function TK517772970_TalcuAutoClassTaskDefault.GetFolder: AnsiString;
 {-}
begin
 Result := 'TasksSaveLoadWithDefault';
end;//TK517772970_TalcuAutoClassTaskDefault.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TalcuAutoClassTaskDefault.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '531956300316';
end;//TK517772970_TalcuAutoClassTaskDefault.GetModelElementGUID
{$IfEnd} //nsTest

{$IfEnd} //AppServerSide AND InsiderTest

initialization
 TestFramework.RegisterTest(TK517772970_TalcuAutoClassTaskDefault.Suite);

end.