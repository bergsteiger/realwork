unit K620262073_C20900337_3;
 {* [RequestLink:620262073] }

// ������: "w:\common\components\rtl\Garant\Daily\K620262073_C20900337_3.pas"
// ���������: "TestCase"
// ������� ������: "K620262073_C20900337_3" MUID: (56F420D80346)
// ��� ����: "TK620262073_C20900337_3"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620262073_C20900337_3 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620262073] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK620262073_C20900337_3
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56F420D80346impl_uses*
 //#UC END# *56F420D80346impl_uses*
;

function TK620262073_C20900337_3.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'CrossSegments';
end;//TK620262073_C20900337_3.GetFolder

function TK620262073_C20900337_3.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56F420D80346';
end;//TK620262073_C20900337_3.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620262073_C20900337_3.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
