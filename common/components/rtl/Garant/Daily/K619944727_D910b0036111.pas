unit K619944727_D910b0036111;
 {* [RequestLink:619944727] }

// ������: "w:\common\components\rtl\Garant\Daily\K619944727_D910b0036111.pas"
// ���������: "TestCase"
// ������� ������: "K619944727_D910b0036111" MUID: (56E951AC03B8)
// ��� ����: "TK619944727_D910b0036111"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK619944727_D910b0036111 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:619944727] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK619944727_D910b0036111
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56E951AC03B8impl_uses*
 //#UC END# *56E951AC03B8impl_uses*
;

function TK619944727_D910b0036111.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'CrossSegments';
end;//TK619944727_D910b0036111.GetFolder

function TK619944727_D910b0036111.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56E951AC03B8';
end;//TK619944727_D910b0036111.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619944727_D910b0036111.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
