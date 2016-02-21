unit K120718860;
 {* [Requestlink:120718860] }

// ������: "w:\archi\source\projects\Archi\Tests\K120718860.pas"
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
 TK120718860 = class(TArchiInsiderTest)
  {* [Requestlink:120718860] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK120718860
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK120718860.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FilterTests';
end;//TK120718860.GetFolder

function TK120718860.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5216109100C2';
end;//TK120718860.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK120718860.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
