unit K479402089;
 {* [Requestlink:479402089] }

// ������: "w:\archi\source\projects\Archi\Tests\K479402089.pas"
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
 TK479402089 = class(TArchiInsiderTest)
  {* [Requestlink:479402089] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK479402089
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK479402089.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FilterTests';
end;//TK479402089.GetFolder

function TK479402089.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '521712E10090';
end;//TK479402089.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK479402089.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
