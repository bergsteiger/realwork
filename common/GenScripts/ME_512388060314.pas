unit toKTPrime;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\toKTPrime.pas"
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
 TtoKTPrime = class(TTestResultsPlace)
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
 end;//TtoKTPrime
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(Monitorings)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(Monitorings)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TtoKTPrime.CommandLineKey: AnsiString;
 {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
//#UC START# *4B7AB0B6016E_512388060314_var*
//#UC END# *4B7AB0B6016E_512388060314_var*
begin
//#UC START# *4B7AB0B6016E_512388060314_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_512388060314_impl*
end;//TtoKTPrime.CommandLineKey

class function TtoKTPrime.TimesPage: Integer;
 {* �������� ��� ������ ������� ������� }
//#UC START# *4B7C0B43005B_512388060314_var*
//#UC END# *4B7C0B43005B_512388060314_var*
begin
//#UC START# *4B7C0B43005B_512388060314_impl*
 Result := 431377634;
//#UC END# *4B7C0B43005B_512388060314_impl*
end;//TtoKTPrime.TimesPage

class function TtoKTPrime.ResultsPage: Integer;
 {* �������� ��� ������ ����������� ������ }
//#UC START# *4B7C0B670215_512388060314_var*
//#UC END# *4B7C0B670215_512388060314_var*
begin
//#UC START# *4B7C0B670215_512388060314_impl*
 Result := 431377632;
//#UC END# *4B7C0B670215_512388060314_impl*
end;//TtoKTPrime.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(Monitorings)
end.
