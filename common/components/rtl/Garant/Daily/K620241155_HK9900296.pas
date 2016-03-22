unit K620241155_HK9900296;
 {* [RequestLink:620241155] }

// ������: "w:\common\components\rtl\Garant\Daily\K620241155_HK9900296.pas"
// ���������: "TestCase"
// ������� ������: "K620241155_HK9900296" MUID: (56F135860110)
// ��� ����: "TK620241155_HK9900296"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620241155_HK9900296 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620241155] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK620241155_HK9900296
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK620241155_HK9900296.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'CrossSegments';
end;//TK620241155_HK9900296.GetFolder

function TK620241155_HK9900296.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56F135860110';
end;//TK620241155_HK9900296.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620241155_HK9900296.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
