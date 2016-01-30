unit toKT;
 {* ���������� ������ F1 � ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\toKT.pas"
// ���������: "TestResults"

{$Include nsDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TtoKT = class(TTestResultsPlace)
  {* ���������� ������ F1 � ����� }
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
 end;//TtoKT
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TtoKT.CommandLineKey: AnsiString;
 {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
//#UC START# *4B7AB0B6016E_4E9EE25001F7_var*
//#UC END# *4B7AB0B6016E_4E9EE25001F7_var*
begin
//#UC START# *4B7AB0B6016E_4E9EE25001F7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_4E9EE25001F7_impl*
end;//TtoKT.CommandLineKey
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TtoKT.TimesPage: Integer;
 {* �������� ��� ������ ������� ������� }
//#UC START# *4B7C0B43005B_4E9EE25001F7_var*
//#UC END# *4B7C0B43005B_4E9EE25001F7_var*
begin
//#UC START# *4B7C0B43005B_4E9EE25001F7_impl*
 if HasTabs then
  Result := 600103364
 else
  Result := 356071770;
//#UC END# *4B7C0B43005B_4E9EE25001F7_impl*
end;//TtoKT.TimesPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TtoKT.ResultsPage: Integer;
 {* �������� ��� ������ ����������� ������ }
//#UC START# *4B7C0B670215_4E9EE25001F7_var*
//#UC END# *4B7C0B670215_4E9EE25001F7_var*
begin
//#UC START# *4B7C0B670215_4E9EE25001F7_impl*
 if HasTabs then
  Result := 600103362
 else
  Result := 356071766;
//#UC END# *4B7C0B670215_4E9EE25001F7_impl*
end;//TtoKT.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TtoKT.IsGK: Boolean;
 {* ����� �������� �� }
//#UC START# *4BEA9969001B_4E9EE25001F7_var*
//#UC END# *4BEA9969001B_4E9EE25001F7_var*
begin
//#UC START# *4BEA9969001B_4E9EE25001F7_impl*
 Result := true;
//#UC END# *4BEA9969001B_4E9EE25001F7_impl*
end;//TtoKT.IsGK
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
