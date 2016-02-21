unit K569230238_NSRC;
 {* [RequestLink:569230238] }

// ������: "w:\common\components\rtl\Garant\Daily\K569230238_NSRC.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK569230238_NSRC = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:569230238] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK569230238_NSRC
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK569230238_NSRC.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK569230238_NSRC.GetFolder

function TK569230238_NSRC.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5492C14A0322';
end;//TK569230238_NSRC.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK569230238_NSRC.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
