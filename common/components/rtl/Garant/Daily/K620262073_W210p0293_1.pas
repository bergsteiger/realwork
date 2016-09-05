unit K620262073_W210p0293_1;
 {* [RequestLink:620262073] }

// ������: "w:\common\components\rtl\Garant\Daily\K620262073_W210p0293_1.pas"
// ���������: "TestCase"
// ������� ������: "K620262073_W210p0293_1" MUID: (56F5425603B2)
// ��� ����: "TK620262073_W210p0293_1"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620262073_W210p0293_1 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620262073] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK620262073_W210p0293_1
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56F5425603B2impl_uses*
 //#UC END# *56F5425603B2impl_uses*
;

function TK620262073_W210p0293_1.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'CrossSegments';
end;//TK620262073_W210p0293_1.GetFolder

function TK620262073_W210p0293_1.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56F5425603B2';
end;//TK620262073_W210p0293_1.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620262073_W210p0293_1.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
