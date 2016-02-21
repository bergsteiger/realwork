unit K458072971;
 {* [Requestlink:458072971] }

// ������: "w:\archi\source\projects\Archi\Tests\K458072971.pas"
// ���������: "TestCase"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK458072971 = class(TArchiInsiderTest)
  {* [Requestlink:458072971] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK458072971
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK458072971.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FilterTests';
end;//TK458072971.GetFolder

function TK458072971.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51A4608F021D';
end;//TK458072971.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK458072971.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
