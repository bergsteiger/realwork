unit K210043510;
 {* [RequestLink:210043510] }

// ������: "w:\common\components\rtl\Garant\Daily\K210043510.pas"
// ���������: "TestCase"
// ������� ������: "K210043510" MUID: (4BE2AA0D00ED)
// ��� ����: "TK210043510"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK210043510 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:210043510] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK210043510
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK210043510.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK210043510.GetFolder

function TK210043510.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BE2AA0D00ED';
end;//TK210043510.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK210043510.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
