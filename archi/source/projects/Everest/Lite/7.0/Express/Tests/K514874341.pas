unit K514874341;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EverestLiteTests"
// ������: "w:/archi/source/projects/Everest/Lite/7.0/Express/Tests/K514874341.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$EverestLite$Test::EverestLiteTests::FileFormatTests::K514874341
//
// {Requestlink:514874341}
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
 TK514874341 = class(TArchiInsiderTest)
  {* [Requestlink:514874341] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK514874341
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  TestFrameWork
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TK514874341

function TK514874341.GetFolder: AnsiString;
 {-}
begin
 Result := 'FileFormatTests';
end;//TK514874341.GetFolder

function TK514874341.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '5322CC6101C8';
end;//TK514874341.GetModelElementGUID

{$IfEnd} //InsiderTest AND nsTest

initialization
 TestFramework.RegisterTest(TK514874341.Suite);

end.