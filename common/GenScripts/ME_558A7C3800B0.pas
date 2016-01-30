unit K601992686;
 {* [Requestlink:601992686] }

// ������: "w:\common\components\rtl\Garant\Daily\K601992686.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK601992686 = class(TEVDtoBothNSRCWriterTest)
  {* [Requestlink:601992686] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK601992686
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK601992686.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK601992686.GetFolder

function TK601992686.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '558A7C3800B0';
end;//TK601992686.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK601992686.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
