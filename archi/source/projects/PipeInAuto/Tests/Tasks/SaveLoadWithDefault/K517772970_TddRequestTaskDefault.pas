unit K517772970_TddRequestTaskDefault;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Low Level Tests"
// ������: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoadWithDefault/K517772970_TddRequestTaskDefault.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TasksSaveLoadWithDefault::K517772970_TddRequestTaskDefault
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
 TK517772970_TddRequestTaskDefault = class(TK517772970_TCheckSaveToStreamDefault)
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
 end;//TK517772970_TddRequestTaskDefault
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  csRequestTask
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

// start class TK517772970_TddRequestTaskDefault

function TK517772970_TddRequestTaskDefault.GetTaskClass: TddTaskClass;
//#UC START# *53170E4100CF_53197B720111_var*
//#UC END# *53170E4100CF_53197B720111_var*
begin
//#UC START# *53170E4100CF_53197B720111_impl*
 result := TddRequestTask;
//#UC END# *53170E4100CF_53197B720111_impl*
end;//TK517772970_TddRequestTaskDefault.GetTaskClass

{$If defined(nsTest)}
function TK517772970_TddRequestTaskDefault.GetFolder: AnsiString;
 {-}
begin
 Result := 'TasksSaveLoadWithDefault';
end;//TK517772970_TddRequestTaskDefault.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TddRequestTaskDefault.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '53197B720111';
end;//TK517772970_TddRequestTaskDefault.GetModelElementGUID
{$IfEnd} //nsTest

{$IfEnd} //AppServerSide AND InsiderTest

initialization
 TestFramework.RegisterTest(TK517772970_TddRequestTaskDefault.Suite);

end.