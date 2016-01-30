unit K242843959;
 {* [RequestLink:242843959] }

// ������: "w:\common\components\rtl\Garant\Daily\K242843959.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoNSRCTest
;

type
 TK242843959 = class(TNSRCtoNSRCTest)
  {* [RequestLink:242843959] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK242843959
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK242843959.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK242843959.GetFolder

function TK242843959.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CE67E39035D';
end;//TK242843959.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK242843959.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
