unit K254349574;
 {* [Requestlink:252524299]. ��������� ���� �� ��������� ���������. ������ ��������� [Requestlink:254349574] }

// ������: "w:\common\components\rtl\Garant\Daily\K254349574.pas"
// ���������: "TestCase"
// ������� ������: "K254349574" MUID: (4E3FDDF10075)
// ��� ����: "TK254349574"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AutoTest
;

type
 TK254349574 = class(TAutoTest)
  {* [Requestlink:252524299]. ��������� ���� �� ��������� ���������. ������ ��������� [Requestlink:254349574] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK254349574
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4E3FDDF10075impl_uses*
 //#UC END# *4E3FDDF10075impl_uses*
;

function TK254349574.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'ScriptTest';
end;//TK254349574.GetFolder

function TK254349574.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4E3FDDF10075';
end;//TK254349574.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK254349574.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
