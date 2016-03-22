unit K619944727_R910m0034956;
 {* [RequestLink:619944727] }

// ������: "w:\common\components\rtl\Garant\Daily\K619944727_R910m0034956.pas"
// ���������: "TestCase"
// ������� ������: "K619944727_R910m0034956" MUID: (56E9523D01D2)
// ��� ����: "TK619944727_R910m0034956"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK619944727_R910m0034956 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:619944727] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK619944727_R910m0034956
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619944727_R910m0034956.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'CrossSegments';
end;//TK619944727_R910m0034956.GetFolder

function TK619944727_R910m0034956.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56E9523D01D2';
end;//TK619944727_R910m0034956.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619944727_R910m0034956.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
