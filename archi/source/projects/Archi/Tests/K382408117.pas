unit K382408117;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ArchiInsiderTests"
// ������: "w:/archi/source/projects/Archi/Tests/K382408117.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$Test::ArchiInsiderTests::TableBoundariesAlignment::K382408117
//
// {Requestlink:382408117}
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
  ArchiInsiderTest
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}
type
 TK382408117 = class(TArchiInsiderTest)
  {* [Requestlink:382408117] }
 protected
 // overridden protected methods
   function GetFolder: String; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: String; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK382408117
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  TestFrameWork
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TK382408117

function TK382408117.GetFolder: String;
 {-}
begin
 Result := 'TableBoundariesAlignment';
end;//TK382408117.GetFolder

function TK382408117.GetModelElementGUID: String;
 {-}
begin
 Result := '502BA5D00130';
end;//TK382408117.GetModelElementGUID

{$IfEnd} //InsiderTest AND nsTest

initialization
 TestFramework.RegisterTest(TK382408117.Suite);

end.