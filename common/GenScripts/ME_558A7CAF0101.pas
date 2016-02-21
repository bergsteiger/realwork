unit K602000766;
 {* [Requestlink:602000766] }

// ������: "w:\common\components\rtl\Garant\Daily\K602000766.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK602000766 = class(TEVDtoBothNSRCWriterTest)
  {* [Requestlink:602000766] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK602000766
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK602000766.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK602000766.GetFolder

function TK602000766.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '558A7CAF0101';
end;//TK602000766.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK602000766.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
