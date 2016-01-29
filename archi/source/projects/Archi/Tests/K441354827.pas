unit K441354827;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ArchiInsiderTests"
// ������: "w:/archi/source/projects/Archi/Tests/K441354827.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$Test::ArchiInsiderTests::FilterTests::K441354827
//
// {Requestlink:441354827}
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  Classes
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  ArchiInsiderTest
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}
type
 TK441354827 = class(TArchiInsiderTest)
  {* [Requestlink:441354827] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK441354827
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  TestFrameWork
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TK441354827

function TK441354827.GetFolder: AnsiString;
 {-}
begin
 Result := 'FilterTests';
end;//TK441354827.GetFolder

function TK441354827.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '5217342400A7';
end;//TK441354827.GetModelElementGUID

{$IfEnd} //InsiderTest AND nsTest

initialization
 TestFramework.RegisterTest(TK441354827.Suite);

end.