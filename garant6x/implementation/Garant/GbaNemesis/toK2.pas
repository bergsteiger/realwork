unit toK2;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\toK2.pas"
// ���������: "TestResults"
// ������� ������: "toK2" MUID: (5522999603C4)
// ��� ����: "TtoK2"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TtoK2 = class({$If NOT Defined(NotTunedDUnit)}
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
 end;//TtoK2
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 //#UC START# *5522999603C4impl_uses*
 //#UC END# *5522999603C4impl_uses*
;

{$If NOT Defined(NotTunedDUnit)}
class function TtoK2.CommandLineKey: AnsiString;
 {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
begin
 Result := '-toK2';
end;//TtoK2.CommandLineKey

class function TtoK2.TimesPage: Integer;
 {* �������� ��� ������ ������� ������� }
//#UC START# *4B7C0B43005B_5522999603C4_var*
//#UC END# *4B7C0B43005B_5522999603C4_var*
begin
//#UC START# *4B7C0B43005B_5522999603C4_impl*
 Result := 596177468;
//#UC END# *4B7C0B43005B_5522999603C4_impl*
end;//TtoK2.TimesPage

class function TtoK2.ResultsPage: Integer;
 {* �������� ��� ������ ����������� ������ }
//#UC START# *4B7C0B670215_5522999603C4_var*
//#UC END# *4B7C0B670215_5522999603C4_var*
begin
//#UC START# *4B7C0B670215_5522999603C4_impl*
 Result := 596177461;
//#UC END# *4B7C0B670215_5522999603C4_impl*
end;//TtoK2.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
