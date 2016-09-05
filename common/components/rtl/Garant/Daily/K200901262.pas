unit K200901262;
 {* [RequestLink:200901262] }

// ������: "w:\common\components\rtl\Garant\Daily\K200901262.pas"
// ���������: "TestCase"
// ������� ������: "K200901262" MUID: (4BB5EDA102EE)
// ��� ����: "TK200901262"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK200901262 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:200901262] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK200901262
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4BB5EDA102EEimpl_uses*
 //#UC END# *4BB5EDA102EEimpl_uses*
;

function TK200901262.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK200901262.GetFolder

function TK200901262.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BB5EDA102EE';
end;//TK200901262.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK200901262.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
