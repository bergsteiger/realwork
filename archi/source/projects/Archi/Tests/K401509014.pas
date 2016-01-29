unit K401509014;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ArchiInsiderTests"
// ������: "w:/archi/source/projects/Archi/Tests/K401509014.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$Test::ArchiInsiderTests::TableBoundariesAlignment::K401509014
//
// {$Requestlink:401509014}
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
 TK401509014 = class(TArchiInsiderTest)
  {* [$Requestlink:401509014] }
 protected
 // overridden protected methods
   function GetFolder: String; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: String; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK401509014
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  TestFrameWork
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TK401509014

function TK401509014.GetFolder: String;
 {-}
begin
 Result := 'TableBoundariesAlignment';
end;//TK401509014.GetFolder

function TK401509014.GetModelElementGUID: String;
 {-}
begin
 Result := '507548CD000C';
end;//TK401509014.GetModelElementGUID

{$IfEnd} //InsiderTest AND nsTest

initialization
 TestFramework.RegisterTest(TK401509014.Suite);

end.