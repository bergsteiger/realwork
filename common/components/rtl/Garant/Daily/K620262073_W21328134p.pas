unit K620262073_W21328134p;
 {* [RequestLink:620262073] }

// ������: "w:\common\components\rtl\Garant\Daily\K620262073_W21328134p.pas"
// ���������: "TestCase"
// ������� ������: "K620262073_W21328134p" MUID: (56F416E50126)
// ��� ����: "TK620262073_W21328134p"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620262073_W21328134p = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620262073] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK620262073_W21328134p
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK620262073_W21328134p.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'CrossSegments';
end;//TK620262073_W21328134p.GetFolder

function TK620262073_W21328134p.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56F416E50126';
end;//TK620262073_W21328134p.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620262073_W21328134p.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
