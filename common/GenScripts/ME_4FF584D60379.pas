unit K370383768;
 {* [Requestlink:370383768] }

// ������: "w:\archi\source\projects\Archi\Tests\K370383768.pas"
// ���������: "TestCase"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK370383768 = class(TArchiInsiderTest)
  {* [Requestlink:370383768] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK370383768
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK370383768.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'ScrollTests';
end;//TK370383768.GetFolder

function TK370383768.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4FF584D60379';
end;//TK370383768.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK370383768.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
