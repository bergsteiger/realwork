unit ToK3;

// ������: "w:\common\components\SearchTest\ToK3.pas"
// ���������: "TestResults"

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TToK3 = class(TTestResultsPlace)
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
 end;//TToK3
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TToK3.CommandLineKey: AnsiString;
 {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
//#UC START# *4B7AB0B6016E_537A1E5F03D2_var*
//#UC END# *4B7AB0B6016E_537A1E5F03D2_var*
begin
//#UC START# *4B7AB0B6016E_537A1E5F03D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_537A1E5F03D2_impl*
end;//TToK3.CommandLineKey
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TToK3.TimesPage: Integer;
 {* �������� ��� ������ ������� ������� }
//#UC START# *4B7C0B43005B_537A1E5F03D2_var*
//#UC END# *4B7C0B43005B_537A1E5F03D2_var*
begin
//#UC START# *4B7C0B43005B_537A1E5F03D2_impl*
 Result := 535904146;
//#UC END# *4B7C0B43005B_537A1E5F03D2_impl*
end;//TToK3.TimesPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TToK3.ResultsPage: Integer;
 {* �������� ��� ������ ����������� ������ }
//#UC START# *4B7C0B670215_537A1E5F03D2_var*
//#UC END# *4B7C0B670215_537A1E5F03D2_var*
begin
//#UC START# *4B7C0B670215_537A1E5F03D2_impl*
 Result := 535904142;
//#UC END# *4B7C0B670215_537A1E5F03D2_impl*
end;//TToK3.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest)
end.
