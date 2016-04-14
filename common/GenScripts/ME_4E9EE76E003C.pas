unit toKT;
 {* ���������� ����� ��������� � ����� }

// ������: "w:\common\components\DailyTest\toKT.pas"
// ���������: "TestResults"
// ������� ������: "toKT" MUID: (4E9EE76E003C)
// ��� ����: "TtoKT"

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
 TtoKT = class(TTestResultsPlace)
  {* ���������� ����� ��������� � ����� }
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
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TtoKT.CommandLineKey: AnsiString;
 {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
begin
 Result := '-toKT';
end;//TtoKT.CommandLineKey

class function TtoKT.TimesPage: Integer;
 {* �������� ��� ������ ������� ������� }
//#UC START# *4B7C0B43005B_4E9EE76E003C_var*
//#UC END# *4B7C0B43005B_4E9EE76E003C_var*
begin
//#UC START# *4B7C0B43005B_4E9EE76E003C_impl*
 Result := 294594448;
//#UC END# *4B7C0B43005B_4E9EE76E003C_impl*
end;//TtoKT.TimesPage

class function TtoKT.ResultsPage: Integer;
 {* �������� ��� ������ ����������� ������ }
//#UC START# *4B7C0B670215_4E9EE76E003C_var*
//#UC END# *4B7C0B670215_4E9EE76E003C_var*
begin
//#UC START# *4B7C0B670215_4E9EE76E003C_impl*
 Result := 294594446;
//#UC END# *4B7C0B670215_4E9EE76E003C_impl*
end;//TtoKT.ResultsPage

class function TtoKT.IsGK: Boolean;
 {* ����� �������� �� }
//#UC START# *4BEA9969001B_4E9EE76E003C_var*
//#UC END# *4BEA9969001B_4E9EE76E003C_var*
begin
//#UC START# *4BEA9969001B_4E9EE76E003C_impl*
 Result := true;
//#UC END# *4BEA9969001B_4E9EE76E003C_impl*
end;//TtoKT.IsGK
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
