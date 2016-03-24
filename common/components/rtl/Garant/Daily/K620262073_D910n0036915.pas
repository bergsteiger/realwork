unit K620262073_D910n0036915;
 {* [RequestLink:620262073] }

// ������: "w:\common\components\rtl\Garant\Daily\K620262073_D910n0036915.pas"
// ���������: "TestCase"
// ������� ������: "K620262073_D910n0036915" MUID: (56F4169F0104)
// ��� ����: "TK620262073_D910n0036915"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620262073_D910n0036915 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620262073] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK620262073_D910n0036915
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK620262073_D910n0036915.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'CrossSegments';
end;//TK620262073_D910n0036915.GetFolder

function TK620262073_D910n0036915.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56F4169F0104';
end;//TK620262073_D910n0036915.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620262073_D910n0036915.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
