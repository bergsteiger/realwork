unit toKPrime;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\toKPrime.pas"
// ���������: "TestResults"
// ������� ������: "toKPrime" MUID: (5123804E003E)
// ��� ����: "TtoKPrime"

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
 TtoKPrime = class({$If NOT Defined(NotTunedDUnit)}
 TTestResultsPlace
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 )
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
 //#UC START# *5123804E003Eimpl_uses*
 //#UC END# *5123804E003Eimpl_uses*
;

{$If NOT Defined(NotTunedDUnit)}
class function TtoKPrime.CommandLineKey: AnsiString;
 {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
begin
 Result := '-toKPrime';
end;//TtoKPrime.CommandLineKey

class function TtoKPrime.TimesPage: Integer;
 {* �������� ��� ������ ������� ������� }
//#UC START# *4B7C0B43005B_5123804E003E_var*
//#UC END# *4B7C0B43005B_5123804E003E_var*
begin
//#UC START# *4B7C0B43005B_5123804E003E_impl*
 Result := 431377600;
//#UC END# *4B7C0B43005B_5123804E003E_impl*
end;//TtoKPrime.TimesPage

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
