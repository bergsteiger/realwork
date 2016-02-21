unit K276537900;
 {* [Requestlink:276537900]. ���� �� �������� ��������� ������� ������ ����� ��������� ������ ������ ��� ���. }

// ������: "w:\common\components\rtl\Garant\Daily\K276537900.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AutoTest
;

type
 TK276537900 = class(TAutoTest)
  {* [Requestlink:276537900]. ���� �� �������� ��������� ������� ������ ����� ��������� ������ ������ ��� ���. }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK276537900
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK276537900.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'ScriptTest';
end;//TK276537900.GetFolder

function TK276537900.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4E3684550188';
end;//TK276537900.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK276537900.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
