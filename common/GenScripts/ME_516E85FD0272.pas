unit K450277041;
 {* [Requestlink:450277041] }

// ������: "w:\common\components\rtl\Garant\Daily\K450277041.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK450277041 = class(TEVDtoBothNSRCWriterTest)
  {* [Requestlink:450277041] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK450277041
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK450277041.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK450277041.GetFolder

function TK450277041.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '516E85FD0272';
end;//TK450277041.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK450277041.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
