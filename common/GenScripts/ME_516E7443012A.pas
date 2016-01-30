unit K251339809;
 {* [Requestlink:251339809] }

// ������: "w:\common\components\rtl\Garant\Daily\K251339809.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoHTMLTest
;

type
 TK251339809 = class(TEVDtoHTMLTest)
  {* [Requestlink:251339809] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK251339809
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK251339809.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK251339809.GetFolder

function TK251339809.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '516E7443012A';
end;//TK251339809.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK251339809.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
