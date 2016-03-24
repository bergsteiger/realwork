unit K620262073_C20900337_1;
 {* [RequestLink:620262073] }

// ������: "w:\common\components\rtl\Garant\Daily\K620262073_C20900337_1.pas"
// ���������: "TestCase"
// ������� ������: "K620262073_C20900337_1" MUID: (56F416880123)
// ��� ����: "TK620262073_C20900337_1"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620262073_C20900337_1 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620262073] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK620262073_C20900337_1
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK620262073_C20900337_1.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'CrossSegments';
end;//TK620262073_C20900337_1.GetFolder

function TK620262073_C20900337_1.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56F416880123';
end;//TK620262073_C20900337_1.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620262073_C20900337_1.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
