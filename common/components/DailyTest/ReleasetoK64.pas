unit ReleasetoK64;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/common/components/DailyTest/ReleasetoK64.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestResults::Class>> Shared Delphi Tests::ReleaseDaily$Test::ReleasetoK64
//
// (�������� �������)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\DailyTest\DailyTest.inc}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  KTestRunner
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TReleasetoK64 = class(TTestResultsPlace)
  {*  (�������� �������) }
 public
 // realized methods
   {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   class function CommandLineKey: AnsiString; override;
     {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
   {$IfEnd} //nsTest AND not NotTunedDUnit
   {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   class function TimesPage: Integer; override;
     {* �������� ��� ������ ������� ������� }
   {$IfEnd} //nsTest AND not NotTunedDUnit
   {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   class function ResultsPage: Integer; override;
     {* �������� ��� ������ ����������� ������ }
   {$IfEnd} //nsTest AND not NotTunedDUnit
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   class function IsGK: Boolean; override;
     {* ����� �������� �� }
   {$IfEnd} //nsTest AND not NotTunedDUnit
 end;//TReleasetoK64
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TReleasetoK64

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleasetoK64.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-toK64';
end;//TReleasetoK64.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleasetoK64.TimesPage: Integer;
//#UC START# *4B7C0B43005B_18F018C495DA_var*
//#UC END# *4B7C0B43005B_18F018C495DA_var*
begin
//#UC START# *4B7C0B43005B_18F018C495DA_impl*
 Result := -1;
 Assert(false);
//#UC END# *4B7C0B43005B_18F018C495DA_impl*
end;//TReleasetoK64.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleasetoK64.ResultsPage: Integer;
//#UC START# *4B7C0B670215_18F018C495DA_var*
//#UC END# *4B7C0B670215_18F018C495DA_var*
begin
//#UC START# *4B7C0B670215_18F018C495DA_impl*
 Result := -1;
 Assert(false);
//#UC END# *4B7C0B670215_18F018C495DA_impl*
end;//TReleasetoK64.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleasetoK64.IsGK: Boolean;
//#UC START# *4BEA9969001B_18F018C495DA_var*
//#UC END# *4BEA9969001B_18F018C495DA_var*
begin
//#UC START# *4BEA9969001B_18F018C495DA_impl*
 Result := false;
//#UC END# *4BEA9969001B_18F018C495DA_impl*
end;//TReleasetoK64.IsGK
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

end.