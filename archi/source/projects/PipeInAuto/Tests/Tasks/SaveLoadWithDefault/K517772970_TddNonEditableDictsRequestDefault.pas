unit K517772970_TddNonEditableDictsRequestDefault;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Low Level Tests"
// ������: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoadWithDefault/K517772970_TddNonEditableDictsRequestDefault.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TasksSaveLoadWithDefault::K517772970_TddNonEditableDictsRequestDefault
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

{$If defined(AppServerSide) AND defined(InsiderTest) AND defined(RemoteDict)}
uses
  K517772970_TCheckSaveToStreamDefault
  {$If not defined(Nemesis)}
  ,
  ddServerTask
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest AND RemoteDict

{$If defined(AppServerSide) AND defined(InsiderTest) AND defined(RemoteDict)}
type
 TK517772970_TddNonEditableDictsRequestDefault = class(TK517772970_TCheckSaveToStreamDefault)
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
 end;//TK517772970_TddNonEditableDictsRequestDefault
{$IfEnd} //AppServerSide AND InsiderTest AND RemoteDict

implementation

{$If defined(AppServerSide) AND defined(InsiderTest) AND defined(RemoteDict)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  csNonEditableDictsRequest
  {$IfEnd} //not Nemesis
  
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  ,
  l3Filer,
  SysUtils
  ;
{$IfEnd} //AppServerSide AND InsiderTest AND RemoteDict

{$If defined(AppServerSide) AND defined(InsiderTest) AND defined(RemoteDict)}

// start class TK517772970_TddNonEditableDictsRequestDefault

function TK517772970_TddNonEditableDictsRequestDefault.GetTaskClass: TddTaskClass;
//#UC START# *53170E4100CF_53197A9A0212_var*
//#UC END# *53170E4100CF_53197A9A0212_var*
begin
//#UC START# *53170E4100CF_53197A9A0212_impl*
 result := TddNonEditableDictsRequest;
//#UC END# *53170E4100CF_53197A9A0212_impl*
end;//TK517772970_TddNonEditableDictsRequestDefault.GetTaskClass

{$If defined(nsTest)}
function TK517772970_TddNonEditableDictsRequestDefault.GetFolder: AnsiString;
 {-}
begin
 Result := 'TasksSaveLoadWithDefault';
end;//TK517772970_TddNonEditableDictsRequestDefault.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TddNonEditableDictsRequestDefault.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '53197A9A0212';
end;//TK517772970_TddNonEditableDictsRequestDefault.GetModelElementGUID
{$IfEnd} //nsTest

{$IfEnd} //AppServerSide AND InsiderTest AND RemoteDict

initialization
 TestFramework.RegisterTest(TK517772970_TddNonEditableDictsRequestDefault.Suite);

end.