unit K408654725;
 {* [RequestLink:408654725] }

// ������: "w:\common\components\rtl\Garant\Daily\K408654725.pas"
// ���������: "TestCase"
// ������� ������: "K408654725" MUID: (50BDC5460081)
// ��� ����: "TK408654725"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK408654725 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:408654725] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK408654725
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *50BDC5460081impl_uses*
 //#UC END# *50BDC5460081impl_uses*
;

function TK408654725.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK408654725.GetFolder

function TK408654725.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '50BDC5460081';
end;//TK408654725.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK408654725.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
