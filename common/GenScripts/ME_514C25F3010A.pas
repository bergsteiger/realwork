unit K440434932;
 {* [Requestlink:440434932] }

// ������: "w:\common\components\rtl\Garant\Daily\K440434932.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK440434932 = class(TEVDtoBothNSRCWriterTest)
  {* [Requestlink:440434932] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK440434932
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK440434932.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK440434932.GetFolder

function TK440434932.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '514C25F3010A';
end;//TK440434932.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK440434932.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
