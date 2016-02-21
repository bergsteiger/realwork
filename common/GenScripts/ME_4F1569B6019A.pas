unit K290951357;
 {* [RequestLink:290951357] }

// ������: "w:\common\components\rtl\Garant\Daily\K290951357.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AutoTest
;

type
 TK290951357 = class(TAutoTest)
  {* [RequestLink:290951357] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK290951357
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK290951357.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'ScriptTest';
end;//TK290951357.GetFolder

function TK290951357.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F1569B6019A';
end;//TK290951357.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK290951357.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
