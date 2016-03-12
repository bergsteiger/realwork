unit ReleasetoK;
 {* ����������� ����� ��� �� (�������� �������) }

// ������: "w:\common\components\DailyTest\ReleasetoK.pas"
// ���������: "TestResults"

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
 TReleasetoK = class(TTestResultsPlace)
  {* ����������� ����� ��� �� (�������� �������) }
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
 end;//TReleasetoK
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TReleasetoK.CommandLineKey: AnsiString;
 {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
//#UC START# *4B7AB0B6016E_431348CB3E15_var*
//#UC END# *4B7AB0B6016E_431348CB3E15_var*
begin
//#UC START# *4B7AB0B6016E_431348CB3E15_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_431348CB3E15_impl*
end;//TReleasetoK.CommandLineKey

class function TReleasetoK.TimesPage: Integer;
 {* �������� ��� ������ ������� ������� }
//#UC START# *4B7C0B43005B_431348CB3E15_var*
//#UC END# *4B7C0B43005B_431348CB3E15_var*
begin
//#UC START# *4B7C0B43005B_431348CB3E15_impl*
 Result := 260441616;
//#UC END# *4B7C0B43005B_431348CB3E15_impl*
end;//TReleasetoK.TimesPage

class function TReleasetoK.ResultsPage: Integer;
 {* �������� ��� ������ ����������� ������ }
//#UC START# *4B7C0B670215_431348CB3E15_var*
//#UC END# *4B7C0B670215_431348CB3E15_var*
begin
//#UC START# *4B7C0B670215_431348CB3E15_impl*
 Result := 260441614;
//#UC END# *4B7C0B670215_431348CB3E15_impl*
end;//TReleasetoK.ResultsPage

class function TReleasetoK.IsGK: Boolean;
 {* ����� �������� �� }
//#UC START# *4BEA9969001B_431348CB3E15_var*
//#UC END# *4BEA9969001B_431348CB3E15_var*
begin
//#UC START# *4BEA9969001B_431348CB3E15_impl*
 Result := true;
//#UC END# *4BEA9969001B_431348CB3E15_impl*
end;//TReleasetoK.IsGK
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
