unit K226006206;
 {* [RequestLink:226006206] }

// ������: "w:\common\components\rtl\Garant\Daily\K226006206.pas"
// ���������: "TestCase"
// ������� ������: "K226006206" MUID: (4C73E85C02D6)
// ��� ����: "TK226006206"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK226006206 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:226006206] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK226006206
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK226006206.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK226006206.GetFolder

function TK226006206.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C73E85C02D6';
end;//TK226006206.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK226006206.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
