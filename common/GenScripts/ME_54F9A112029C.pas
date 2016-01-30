unit K590528525;
 {* [Requestlink:590528525] }

// ������: "w:\common\components\rtl\Garant\Daily\K590528525.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK590528525 = class(TNSRCtoEVDTest)
  {* [Requestlink:590528525] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK590528525
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK590528525.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK590528525.GetFolder

function TK590528525.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '54F9A112029C';
end;//TK590528525.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK590528525.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
