unit toKPrime;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\toKPrime.pas"
// ���������: "TestResults"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TtoKPrime = class(TTestResultsPlace)
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
 end;//TtoKPrime
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(Monitorings)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(Monitorings)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TtoKPrime.CommandLineKey: AnsiString;
 {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
//#UC START# *4B7AB0B6016E_5123804E003E_var*
//#UC END# *4B7AB0B6016E_5123804E003E_var*
begin
//#UC START# *4B7AB0B6016E_5123804E003E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_5123804E003E_impl*
end;//TtoKPrime.CommandLineKey
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TtoKPrime.TimesPage: Integer;
 {* �������� ��� ������ ������� ������� }
//#UC START# *4B7C0B43005B_5123804E003E_var*
//#UC END# *4B7C0B43005B_5123804E003E_var*
begin
//#UC START# *4B7C0B43005B_5123804E003E_impl*
 Result := 431377600;
//#UC END# *4B7C0B43005B_5123804E003E_impl*
end;//TtoKPrime.TimesPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TtoKPrime.ResultsPage: Integer;
 {* �������� ��� ������ ����������� ������ }
//#UC START# *4B7C0B670215_5123804E003E_var*
//#UC END# *4B7C0B670215_5123804E003E_var*
begin
//#UC START# *4B7C0B670215_5123804E003E_impl*
 Result := 431377598;
//#UC END# *4B7C0B670215_5123804E003E_impl*
end;//TtoKPrime.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(Monitorings)
end.
