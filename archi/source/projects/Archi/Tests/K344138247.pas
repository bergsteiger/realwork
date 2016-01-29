unit K344138247;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ArchiInsiderTests"
// ������: "w:/archi/source/projects/Archi/Tests/K344138247.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$Test::ArchiInsiderTests::Drawing Tests::K344138247
//
// {Requestlink:344138247}
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
 TK344138247 = class(TArchiInsiderTest)
  {* [Requestlink:344138247] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK344138247
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  TestFrameWork
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TK344138247

function TK344138247.GetFolder: AnsiString;
 {-}
begin
 Result := 'Drawing Tests';
end;//TK344138247.GetFolder

function TK344138247.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4F6086480381';
end;//TK344138247.GetModelElementGUID

{$IfEnd} //InsiderTest AND nsTest

initialization
 TestFramework.RegisterTest(TK344138247.Suite);

end.