unit K590512137;
 {* [Requestlink:590512137] }

// ������: "w:\common\components\rtl\Garant\Daily\K590512137.pas"
// ���������: "TestCase"
// ������� ������: "K590512137" MUID: (54FEAB9E02C4)
// ��� ����: "TK590512137"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK590512137 = class(TEVDtoBothNSRCWriterTest)
  {* [Requestlink:590512137] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK590512137
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK590512137.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK590512137.GetFolder

function TK590512137.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '54FEAB9E02C4';
end;//TK590512137.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK590512137.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
