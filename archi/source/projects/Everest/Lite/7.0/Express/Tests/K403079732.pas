unit K403079732;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EverestLiteTests"
// ������: "w:/archi/source/projects/Everest/Lite/7.0/Express/Tests/K403079732.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$EverestLite$Test::EverestLiteTests::FileFormatTests::K403079732
//
// {Requestlink:403079732}
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

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
 TK403079732 = class(TArchiInsiderTest)
  {* [Requestlink:403079732] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK403079732
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  TestFrameWork
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TK403079732

function TK403079732.GetFolder: AnsiString;
 {-}
begin
 Result := 'FileFormatTests';
end;//TK403079732.GetFolder

function TK403079732.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '524146DB01BA';
end;//TK403079732.GetModelElementGUID

{$IfEnd} //InsiderTest AND nsTest

initialization
 TestFramework.RegisterTest(TK403079732.Suite);

end.