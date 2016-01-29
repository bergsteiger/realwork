unit K517791575;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ArchiInsiderTests"
// ������: "w:/archi/source/projects/Archi/Tests/K517791575.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$Test::ArchiInsiderTests::LoadText::K517791575
//
// {Requestlink:517791575}
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
 TK517791575 = class(TArchiInsiderTest)
  {* [Requestlink:517791575] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK517791575
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  TestFrameWork
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TK517791575

function TK517791575.GetFolder: AnsiString;
 {-}
begin
 Result := 'LoadText';
end;//TK517791575.GetFolder

function TK517791575.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '5322BDF20048';
end;//TK517791575.GetModelElementGUID

{$IfEnd} //InsiderTest AND nsTest

initialization
 TestFramework.RegisterTest(TK517791575.Suite);

end.