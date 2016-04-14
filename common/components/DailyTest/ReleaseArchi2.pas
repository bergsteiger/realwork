unit ReleaseArchi2;
 {* ����� �� Archi2 (�������� �������) }

// ������: "w:\common\components\DailyTest\ReleaseArchi2.pas"
// ���������: "TestResults"
// ������� ������: "ReleaseArchi2" MUID: (6B92D0808EA8)
// ��� ����: "TReleaseArchi2"

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
begin
 Result := '-Archi2';
end;//TReleaseArchi2.CommandLineKey

class function TReleaseArchi2.TimesPage: Integer;
 {* �������� ��� ������ ������� ������� }
//#UC START# *4B7C0B43005B_6B92D0808EA8_var*
//#UC END# *4B7C0B43005B_6B92D0808EA8_var*
begin
//#UC START# *4B7C0B43005B_6B92D0808EA8_impl*
 Result := 260441631;
//#UC END# *4B7C0B43005B_6B92D0808EA8_impl*
end;//TReleaseArchi2.TimesPage

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
