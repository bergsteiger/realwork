unit K514874360;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EverestLiteTests"
// ������: "w:/archi/source/projects/Everest/Lite/7.0/Express/Tests/K514874360.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$EverestLite$Test::EverestLiteTests::FileFormatTests::K514874360
//
// {Requestlink:514874360}
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
 TK514874360 = class(TArchiInsiderTest)
  {* [Requestlink:514874360] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK514874360
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  TestFrameWork
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TK514874360

function TK514874360.GetFolder: AnsiString;
 {-}
begin
 Result := 'FileFormatTests';
end;//TK514874360.GetFolder

function TK514874360.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '53294DFB01F4';
end;//TK514874360.GetModelElementGUID

{$IfEnd} //InsiderTest AND nsTest

initialization
 TestFramework.RegisterTest(TK514874360.Suite);

end.