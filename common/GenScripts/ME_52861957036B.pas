unit K502351620;
 {* [RequestLink:502351620] }

// ������: "w:\common\components\rtl\Garant\Daily\K502351620.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK502351620 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:502351620] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK502351620
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK502351620.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK502351620.GetFolder

function TK502351620.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '52861957036B';
end;//TK502351620.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK502351620.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
