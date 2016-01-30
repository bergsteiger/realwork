unit K585129079_NSRC;
 {* [RequestLink:585129079] }

// ������: "w:\common\components\rtl\Garant\Daily\K585129079_NSRC.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK585129079_NSRC = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:585129079] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK585129079_NSRC
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK585129079_NSRC.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK585129079_NSRC.GetFolder

function TK585129079_NSRC.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5491A60A003A';
end;//TK585129079_NSRC.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK585129079_NSRC.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
