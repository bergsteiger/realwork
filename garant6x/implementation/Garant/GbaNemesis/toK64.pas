unit toK64;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\toK64.pas"
// ���������: "TestResults"
// ������� ������: "toK64" MUID: (4DB6A92C025D)
// ��� ����: "TtoK64"

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
 TtoK64 = class({$If NOT Defined(NotTunedDUnit)}
 TTestResultsPlace
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 )
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
 end;//TtoK64
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TtoK64.CommandLineKey: AnsiString;
 {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
begin
 Result := '-toK64';
end;//TtoK64.CommandLineKey

class function TtoK64.TimesPage: Integer;
 {* �������� ��� ������ ������� ������� }
//#UC START# *4B7C0B43005B_4DB6A92C025D_var*
//#UC END# *4B7C0B43005B_4DB6A92C025D_var*
begin
//#UC START# *4B7C0B43005B_4DB6A92C025D_impl*
 Result := 265393499;
//#UC END# *4B7C0B43005B_4DB6A92C025D_impl*
end;//TtoK64.TimesPage

class function TtoK64.ResultsPage: Integer;
 {* �������� ��� ������ ����������� ������ }
//#UC START# *4B7C0B670215_4DB6A92C025D_var*
//#UC END# *4B7C0B670215_4DB6A92C025D_var*
begin
//#UC START# *4B7C0B670215_4DB6A92C025D_impl*
 Result := 265393494;
//#UC END# *4B7C0B670215_4DB6A92C025D_impl*
end;//TtoK64.ResultsPage

class function TtoK64.IsGK: Boolean;
 {* ����� �������� �� }
//#UC START# *4BEA9969001B_4DB6A92C025D_var*
//#UC END# *4BEA9969001B_4DB6A92C025D_var*
begin
//#UC START# *4BEA9969001B_4DB6A92C025D_impl*
 Result := true;
//#UC END# *4BEA9969001B_4DB6A92C025D_impl*
end;//TtoK64.IsGK
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
