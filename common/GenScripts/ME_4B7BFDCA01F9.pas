unit ItsLAW;
 {* ����� ��� ���������� ����� }

// ������: "w:\common\components\DailyTest\ItsLAW.pas"
// ���������: "TestResults"

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
 TItsLAW = class(TTestResultsPlace)
  {* ����� ��� ���������� ����� }
  protected
   {$If NOT Defined(NotTunedDUnit)}
   class function IsLAW: Boolean; override;
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
 end;//TItsLAW
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TItsLAW.CommandLineKey: AnsiString;
 {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
//#UC START# *4B7AB0B6016E_4B7BFDCA01F9_var*
//#UC END# *4B7AB0B6016E_4B7BFDCA01F9_var*
begin
//#UC START# *4B7AB0B6016E_4B7BFDCA01F9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_4B7BFDCA01F9_impl*
end;//TItsLAW.CommandLineKey
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TItsLAW.TimesPage: Integer;
 {* �������� ��� ������ ������� ������� }
//#UC START# *4B7C0B43005B_4B7BFDCA01F9_var*
//#UC END# *4B7C0B43005B_4B7BFDCA01F9_var*
begin
//#UC START# *4B7C0B43005B_4B7BFDCA01F9_impl*
 Result := {$IfDef XE}457086788{$Else}174719816{$EndIf};
//#UC END# *4B7C0B43005B_4B7BFDCA01F9_impl*
end;//TItsLAW.TimesPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TItsLAW.ResultsPage: Integer;
 {* �������� ��� ������ ����������� ������ }
//#UC START# *4B7C0B670215_4B7BFDCA01F9_var*
//#UC END# *4B7C0B670215_4B7BFDCA01F9_var*
begin
//#UC START# *4B7C0B670215_4B7BFDCA01F9_impl*
 Result := {$IfDef XE}457086786{$Else}174295160{$EndIf};
//#UC END# *4B7C0B670215_4B7BFDCA01F9_impl*
end;//TItsLAW.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TItsLAW.IsLAW: Boolean;
//#UC START# *4C35A6DA02E9_4B7BFDCA01F9_var*
//#UC END# *4C35A6DA02E9_4B7BFDCA01F9_var*
begin
//#UC START# *4C35A6DA02E9_4B7BFDCA01F9_impl*
 Result := true;
//#UC END# *4C35A6DA02E9_4B7BFDCA01F9_impl*
end;//TItsLAW.IsLAW
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
