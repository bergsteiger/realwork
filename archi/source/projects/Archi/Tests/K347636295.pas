unit K347636295;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ArchiInsiderTests"
// ������: "w:/archi/source/projects/Archi/Tests/K347636295.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$Test::ArchiInsiderTests::Text2TableTests::K347636295
//
// {Requestlink:347636295}
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
 TK347636295 = class(TArchiInsiderTest)
  {* [Requestlink:347636295] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK347636295
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  TestFrameWork
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TK347636295

function TK347636295.GetFolder: AnsiString;
 {-}
begin
 Result := 'Text2TableTests';
end;//TK347636295.GetFolder

function TK347636295.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4F6C55ED0287';
end;//TK347636295.GetModelElementGUID

{$IfEnd} //InsiderTest AND nsTest

initialization
 TestFramework.RegisterTest(TK347636295.Suite);

end.