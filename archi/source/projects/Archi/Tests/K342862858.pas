unit K342862858;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ArchiInsiderTests"
// ������: "w:/archi/source/projects/Archi/Tests/K342862858.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$Test::ArchiInsiderTests::TableTools::K342862858
//
// {Requestlink:342862858}
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
 TK342862858 = class(TArchiInsiderTest)
  {* [Requestlink:342862858] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK342862858
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  TestFrameWork
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TK342862858

function TK342862858.GetFolder: AnsiString;
 {-}
begin
 Result := 'TableTools';
end;//TK342862858.GetFolder

function TK342862858.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4F50C48F01E0';
end;//TK342862858.GetModelElementGUID

{$IfEnd} //InsiderTest AND nsTest

initialization
 TestFramework.RegisterTest(TK342862858.Suite);

end.