unit ReleaseItsLAW;
 {* ����� ��� ���������� ����� (�������� �������) }

// ������: "w:\common\components\DailyTest\ReleaseItsLAW.pas"
// ���������: "TestResults"

{$Include DailyTest.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TReleaseItsLAW = class(TTestResultsPlace)
  {* ����� ��� ���������� ����� (�������� �������) }
  protected
   {$If NOT Defined(NotTunedDUnit)}
   class function IsLAW: Boolean; override;
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
 end;//TReleaseItsLAW
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TReleaseItsLAW.CommandLineKey: AnsiString;
 {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
//#UC START# *4B7AB0B6016E_97FE67497778_var*
//#UC END# *4B7AB0B6016E_97FE67497778_var*
begin
//#UC START# *4B7AB0B6016E_97FE67497778_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_97FE67497778_impl*
end;//TReleaseItsLAW.CommandLineKey
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TReleaseItsLAW.TimesPage: Integer;
 {* �������� ��� ������ ������� ������� }
//#UC START# *4B7C0B43005B_97FE67497778_var*
//#UC END# *4B7C0B43005B_97FE67497778_var*
begin
//#UC START# *4B7C0B43005B_97FE67497778_impl*
 Result := 260441621;
//#UC END# *4B7C0B43005B_97FE67497778_impl*
end;//TReleaseItsLAW.TimesPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TReleaseItsLAW.ResultsPage: Integer;
 {* �������� ��� ������ ����������� ������ }
//#UC START# *4B7C0B670215_97FE67497778_var*
//#UC END# *4B7C0B670215_97FE67497778_var*
begin
//#UC START# *4B7C0B670215_97FE67497778_impl*
 Result := 260441606;
//#UC END# *4B7C0B670215_97FE67497778_impl*
end;//TReleaseItsLAW.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TReleaseItsLAW.IsLAW: Boolean;
//#UC START# *4C35A6DA02E9_97FE67497778_var*
//#UC END# *4C35A6DA02E9_97FE67497778_var*
begin
//#UC START# *4C35A6DA02E9_97FE67497778_impl*
 Result := true;
//#UC END# *4C35A6DA02E9_97FE67497778_impl*
end;//TReleaseItsLAW.IsLAW
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
