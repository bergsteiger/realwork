unit FailedTest;

// ������: "w:\common\components\rtl\Garant\TestForTFW\FailedTest.pas"
// ���������: "TestCase"
// ������� ������: "TFailedTest" MUID: (4CA0B2BA01AC)

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TFailedTest = class({$If NOT Defined(NotTunedDUnit)}
 TBaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 )
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
  published
   procedure DoIt;
 end;//TFailedTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NotTunedDUnit)}
procedure TFailedTest.DoIt;
//#UC START# *4CA0B2E40378_4CA0B2BA01AC_var*
//#UC END# *4CA0B2E40378_4CA0B2BA01AC_var*
begin
//#UC START# *4CA0B2E40378_4CA0B2BA01AC_impl*
 Check(false);
//#UC END# *4CA0B2E40378_4CA0B2BA01AC_impl*
end;//TFailedTest.DoIt

function TFailedTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TFWTests';
end;//TFailedTest.GetFolder

function TFailedTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CA0B2BA01AC';
end;//TFailedTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TFailedTest.Suite);
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
