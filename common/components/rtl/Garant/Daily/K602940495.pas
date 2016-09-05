unit K602940495;
 {* [Requestlink:602940495] }

// ������: "w:\common\components\rtl\Garant\Daily\K602940495.pas"
// ���������: "TestCase"
// ������� ������: "K602940495" MUID: (559288E2010C)
// ��� ����: "TK602940495"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK602940495 = class(TEVDtoBothNSRCWriterTest)
  {* [Requestlink:602940495] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK602940495
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *559288E2010Cimpl_uses*
 //#UC END# *559288E2010Cimpl_uses*
;

function TK602940495.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK602940495.GetFolder

function TK602940495.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '559288E2010C';
end;//TK602940495.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK602940495.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
