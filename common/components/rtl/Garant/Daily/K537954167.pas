unit K537954167;
 {* [Requestlink:537954167] }

// ������: "w:\common\components\rtl\Garant\Daily\K537954167.pas"
// ���������: "TestCase"
// ������� ������: "K537954167" MUID: (53831AB20223)
// ��� ����: "TK537954167"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK537954167 = class(THTMLtoEVDTest)
  {* [Requestlink:537954167] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK537954167
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *53831AB20223impl_uses*
 //#UC END# *53831AB20223impl_uses*
;

function TK537954167.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK537954167.GetFolder

function TK537954167.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53831AB20223';
end;//TK537954167.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK537954167.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
