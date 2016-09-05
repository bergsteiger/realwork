unit K585129079_NSRC;
 {* [RequestLink:585129079] }

// ������: "w:\common\components\rtl\Garant\Daily\K585129079_NSRC.pas"
// ���������: "TestCase"
// ������� ������: "K585129079_NSRC" MUID: (5491A60A003A)
// ��� ����: "TK585129079_NSRC"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

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
 //#UC START# *5491A60A003Aimpl_uses*
 //#UC END# *5491A60A003Aimpl_uses*
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
