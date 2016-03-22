unit K103942050;
 {* [Requestlink:103942050] }

// ������: "w:\common\components\rtl\Garant\Daily\K103942050.pas"
// ���������: "TestCase"
// ������� ������: "K103942050" MUID: (529DA88400C3)
// ��� ����: "TK103942050"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK103942050 = class(THTMLtoEVDTest)
  {* [Requestlink:103942050] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK103942050
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK103942050.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK103942050.GetFolder

function TK103942050.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '529DA88400C3';
end;//TK103942050.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK103942050.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
