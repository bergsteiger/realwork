unit toK64;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\toK64.pas"
// ���������: "TestResults"

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
 TtoK64 = class(TTestResultsPlace)
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
//#UC START# *4B7AB0B6016E_4DB6A92C025D_var*
//#UC END# *4B7AB0B6016E_4DB6A92C025D_var*
begin
//#UC START# *4B7AB0B6016E_4DB6A92C025D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_4DB6A92C025D_impl*
end;//TtoK64.CommandLineKey
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TtoK64.TimesPage: Integer;
 {* �������� ��� ������ ������� ������� }
//#UC START# *4B7C0B43005B_4DB6A92C025D_var*
//#UC END# *4B7C0B43005B_4DB6A92C025D_var*
begin
//#UC START# *4B7C0B43005B_4DB6A92C025D_impl*
 Result := 265393499;
//#UC END# *4B7C0B43005B_4DB6A92C025D_impl*
end;//TtoK64.TimesPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TtoK64.ResultsPage: Integer;
 {* �������� ��� ������ ����������� ������ }
//#UC START# *4B7C0B670215_4DB6A92C025D_var*
//#UC END# *4B7C0B670215_4DB6A92C025D_var*
begin
//#UC START# *4B7C0B670215_4DB6A92C025D_impl*
 Result := 265393494;
//#UC END# *4B7C0B670215_4DB6A92C025D_impl*
end;//TtoK64.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
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
