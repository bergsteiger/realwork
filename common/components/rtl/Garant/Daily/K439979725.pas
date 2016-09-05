unit K439979725;
 {* [Requestlink:439979725] }

// ������: "w:\common\components\rtl\Garant\Daily\K439979725.pas"
// ���������: "TestCase"
// ������� ������: "K439979725" MUID: (514C0F9101A9)
// ��� ����: "TK439979725"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK439979725 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:439979725] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK439979725
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *514C0F9101A9impl_uses*
 //#UC END# *514C0F9101A9impl_uses*
;

function TK439979725.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK439979725.GetFolder

function TK439979725.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '514C0F9101A9';
end;//TK439979725.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK439979725.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
