unit K290266820;
 {* [RequestLink:290266820] }

// ������: "w:\common\components\rtl\Garant\Daily\K290266820.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AutoTest
;

type
 TK290266820 = class(TAutoTest)
  {* [RequestLink:290266820] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK290266820
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK290266820.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'ScriptTest';
end;//TK290266820.GetFolder

function TK290266820.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F15696B0227';
end;//TK290266820.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK290266820.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
