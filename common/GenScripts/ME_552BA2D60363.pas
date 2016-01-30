unit K596385658;
 {* [Requestlink:596385658] }

// ������: "w:\common\components\rtl\Garant\Daily\K596385658.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK596385658 = class(TEVDtoBothNSRCWriterTest)
  {* [Requestlink:596385658] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK596385658
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK596385658.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK596385658.GetFolder

function TK596385658.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '552BA2D60363';
end;//TK596385658.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK596385658.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
