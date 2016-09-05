unit K537768536;
 {* [Requestlink:537768536] }

// ������: "w:\common\components\rtl\Garant\Daily\K537768536.pas"
// ���������: "TestCase"
// ������� ������: "K537768536" MUID: (53843E030196)
// ��� ����: "TK537768536"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK537768536 = class(THTMLtoEVDTest)
  {* [Requestlink:537768536] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK537768536
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *53843E030196impl_uses*
 //#UC END# *53843E030196impl_uses*
;

function TK537768536.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK537768536.GetFolder

function TK537768536.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53843E030196';
end;//TK537768536.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK537768536.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
