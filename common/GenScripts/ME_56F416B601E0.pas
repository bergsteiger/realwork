unit K620262073_D910n0036950;
 {* [RequestLink:620262073] }

// ������: "w:\common\components\rtl\Garant\Daily\K620262073_D910n0036950.pas"
// ���������: "TestCase"
// ������� ������: "K620262073_D910n0036950" MUID: (56F416B601E0)
// ��� ����: "TK620262073_D910n0036950"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620262073_D910n0036950 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620262073] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK620262073_D910n0036950
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK620262073_D910n0036950.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'CrossSegments';
end;//TK620262073_D910n0036950.GetFolder

function TK620262073_D910n0036950.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56F416B601E0';
end;//TK620262073_D910n0036950.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620262073_D910n0036950.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
