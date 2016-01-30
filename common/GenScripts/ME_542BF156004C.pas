unit K565842263;
 {* [Requestlink:565842263] }

// ������: "w:\common\components\rtl\Garant\Daily\K565842263.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK565842263 = class(TNSRCtoEVDTest)
  {* [Requestlink:565842263] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK565842263
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK565842263.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'NSRCTests';
end;//TK565842263.GetFolder

function TK565842263.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '542BF156004C';
end;//TK565842263.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK565842263.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
