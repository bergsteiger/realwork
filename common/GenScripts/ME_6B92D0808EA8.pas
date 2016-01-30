unit ReleaseArchi2;
 {* ����� �� Archi2 (�������� �������) }

// ������: "w:\common\components\DailyTest\ReleaseArchi2.pas"
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
 TReleaseArchi2 = class(TTestResultsPlace)
  {* ����� �� Archi2 (�������� �������) }
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
 end;//TReleaseArchi2
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TReleaseArchi2.CommandLineKey: AnsiString;
 {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
//#UC START# *4B7AB0B6016E_6B92D0808EA8_var*
//#UC END# *4B7AB0B6016E_6B92D0808EA8_var*
begin
//#UC START# *4B7AB0B6016E_6B92D0808EA8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_6B92D0808EA8_impl*
end;//TReleaseArchi2.CommandLineKey
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TReleaseArchi2.TimesPage: Integer;
 {* �������� ��� ������ ������� ������� }
//#UC START# *4B7C0B43005B_6B92D0808EA8_var*
//#UC END# *4B7C0B43005B_6B92D0808EA8_var*
begin
//#UC START# *4B7C0B43005B_6B92D0808EA8_impl*
 Result := 260441631;
//#UC END# *4B7C0B43005B_6B92D0808EA8_impl*
end;//TReleaseArchi2.TimesPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TReleaseArchi2.ResultsPage: Integer;
 {* �������� ��� ������ ����������� ������ }
//#UC START# *4B7C0B670215_6B92D0808EA8_var*
//#UC END# *4B7C0B670215_6B92D0808EA8_var*
begin
//#UC START# *4B7C0B670215_6B92D0808EA8_impl*
 Result := 260441628;
//#UC END# *4B7C0B670215_6B92D0808EA8_impl*
end;//TReleaseArchi2.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
