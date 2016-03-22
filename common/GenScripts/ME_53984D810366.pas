unit K541895041;
 {* [Requestlink:541895041] }

// ������: "w:\common\components\rtl\Garant\Daily\K541895041.pas"
// ���������: "TestCase"
// ������� ������: "K541895041" MUID: (53984D810366)
// ��� ����: "TK541895041"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK541895041 = class(THTMLtoEVDTest)
  {* [Requestlink:541895041] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK541895041
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK541895041.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK541895041.GetFolder

function TK541895041.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53984D810366';
end;//TK541895041.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK541895041.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
