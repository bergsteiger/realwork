unit ReleasetoKT;
 {* ���������� ����� ��������� � ����� (�������� �������) }

// ������: "w:\common\components\DailyTest\ReleasetoKT.pas"
// ���������: "TestResults"
// ������� ������: "ReleasetoKT" MUID: (7C0A8318D8D4)
// ��� ����: "TReleasetoKT"

{$Include w:\common\components\DailyTest\DailyTest.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TReleasetoKT = class({$If NOT Defined(NotTunedDUnit)}
 TTestResultsPlace
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 )
  {* ���������� ����� ��������� � ����� (�������� �������) }
  protected
   {$If NOT Defined(NotTunedDUnit)}
   class function IsGK: Boolean; override;
    {* ����� �������� �� }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
  public
   {$If NOT Defined(NotTunedDUnit)}
   class function CommandLineKey: AnsiString; override;
    {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   {$If NOT Defined(NotTunedDUnit)}
   class function TimesPage: Integer; override;
    {* �������� ��� ������ ������� ������� }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   {$If NOT Defined(NotTunedDUnit)}
   class function ResultsPage: Integer; override;
    {* �������� ��� ������ ����������� ������ }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
 end;//TReleasetoKT
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *7C0A8318D8D4impl_uses*
 //#UC END# *7C0A8318D8D4impl_uses*
;

{$If NOT Defined(NotTunedDUnit)}
class function TReleasetoKT.CommandLineKey: AnsiString;
 {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
begin
 Result := '-toKT';
end;//TReleasetoKT.CommandLineKey

class function TReleasetoKT.TimesPage: Integer;
 {* �������� ��� ������ ������� ������� }
//#UC START# *4B7C0B43005B_7C0A8318D8D4_var*
//#UC END# *4B7C0B43005B_7C0A8318D8D4_var*
begin
//#UC START# *4B7C0B43005B_7C0A8318D8D4_impl*
 Result := -1;
 Assert(false);
//#UC END# *4B7C0B43005B_7C0A8318D8D4_impl*
end;//TReleasetoKT.TimesPage

class function TReleasetoKT.ResultsPage: Integer;
 {* �������� ��� ������ ����������� ������ }
//#UC START# *4B7C0B670215_7C0A8318D8D4_var*
//#UC END# *4B7C0B670215_7C0A8318D8D4_var*
begin
//#UC START# *4B7C0B670215_7C0A8318D8D4_impl*
 Result := -1;
 Assert(false);
//#UC END# *4B7C0B670215_7C0A8318D8D4_impl*
end;//TReleasetoKT.ResultsPage

class function TReleasetoKT.IsGK: Boolean;
 {* ����� �������� �� }
//#UC START# *4BEA9969001B_7C0A8318D8D4_var*
//#UC END# *4BEA9969001B_7C0A8318D8D4_var*
begin
//#UC START# *4BEA9969001B_7C0A8318D8D4_impl*
 Result := true;
//#UC END# *4BEA9969001B_7C0A8318D8D4_impl*
end;//TReleasetoKT.IsGK
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
