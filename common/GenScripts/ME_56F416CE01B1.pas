unit K620262073_W210p0293;
 {* [RequestLink:620262073] }

// ������: "w:\common\components\rtl\Garant\Daily\K620262073_W210p0293.pas"
// ���������: "TestCase"
// ������� ������: "K620262073_W210p0293" MUID: (56F416CE01B1)
// ��� ����: "TK620262073_W210p0293"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620262073_W210p0293 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620262073] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK620262073_W210p0293
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK620262073_W210p0293.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'CrossSegments';
end;//TK620262073_W210p0293.GetFolder

function TK620262073_W210p0293.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56F416CE01B1';
end;//TK620262073_W210p0293.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620262073_W210p0293.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
