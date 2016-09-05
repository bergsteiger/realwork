unit K435460794;
 {* [Requestlink:435460794] }

// ������: "w:\common\components\rtl\Garant\Daily\K435460794.pas"
// ���������: "TestCase"
// ������� ������: "K435460794" MUID: (5141662201E0)
// ��� ����: "TK435460794"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK435460794 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:435460794] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK435460794
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5141662201E0impl_uses*
 //#UC END# *5141662201E0impl_uses*
;

function TK435460794.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK435460794.GetFolder

function TK435460794.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5141662201E0';
end;//TK435460794.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK435460794.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
