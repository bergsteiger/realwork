unit K598131874;
 {* [RequestLink:598131874] }

// ������: "w:\common\components\rtl\Garant\Daily\K598131874.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK598131874 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:598131874] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK598131874
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK598131874.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK598131874.GetFolder

function TK598131874.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '561CE690036B';
end;//TK598131874.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK598131874.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
