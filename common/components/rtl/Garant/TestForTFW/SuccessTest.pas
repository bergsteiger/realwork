unit SuccessTest;
 {* �������� ���� }

// ������: "w:\common\components\rtl\Garant\TestForTFW\SuccessTest.pas"
// ���������: "TestCase"
// ������� ������: "TSuccessTest" MUID: (4CA0B27401E4)

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TSuccessTest = class({$If NOT Defined(NotTunedDUnit)}
 TBaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 )
  {* �������� ���� }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
  published
   procedure DoIt;
 end;//TSuccessTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4CA0B27401E4impl_uses*
 //#UC END# *4CA0B27401E4impl_uses*
;

{$If NOT Defined(NotTunedDUnit)}
procedure TSuccessTest.DoIt;
//#UC START# *4CA0B2AC0096_4CA0B27401E4_var*
//#UC END# *4CA0B2AC0096_4CA0B27401E4_var*
begin
//#UC START# *4CA0B2AC0096_4CA0B27401E4_impl*
 Check(true);
//#UC END# *4CA0B2AC0096_4CA0B27401E4_impl*
end;//TSuccessTest.DoIt

function TSuccessTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TFWTests';
end;//TSuccessTest.GetFolder

function TSuccessTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CA0B27401E4';
end;//TSuccessTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TSuccessTest.Suite);
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
