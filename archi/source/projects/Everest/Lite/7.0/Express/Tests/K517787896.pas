unit K517787896;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EverestLiteTests"
// ������: "w:/archi/source/projects/Everest/Lite/7.0/Express/Tests/K517787896.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$EverestLite$Test::EverestLiteTests::PreivewTests::K517787896
//
// {Requestlink:517787896}
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  ArchiInsiderTest
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}
type
 TK517787896 = class(TArchiInsiderTest)
  {* [Requestlink:517787896] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK517787896
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  TestFrameWork
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TK517787896

function TK517787896.GetFolder: AnsiString;
 {-}
begin
 Result := 'PreivewTests';
end;//TK517787896.GetFolder

function TK517787896.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '5322D7820314';
end;//TK517787896.GetModelElementGUID

{$IfEnd} //InsiderTest AND nsTest

initialization
 TestFramework.RegisterTest(TK517787896.Suite);

end.