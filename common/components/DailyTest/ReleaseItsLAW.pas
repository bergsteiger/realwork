unit ReleaseItsLAW;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/common/components/DailyTest/ReleaseItsLAW.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestResults::Class>> Shared Delphi Tests::ReleaseDaily$Test::ReleaseItsLAW
//
// ����� ��� ���������� ����� (�������� �������)
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
 TReleaseItsLAW = class(TTestResultsPlace)
  {* ����� ��� ���������� ����� (�������� �������) }
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
   class function IsLAW: Boolean; override;
   {$IfEnd} //nsTest AND not NotTunedDUnit
 end;//TReleaseItsLAW
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TReleaseItsLAW

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleaseItsLAW.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-ItsLAW';
end;//TReleaseItsLAW.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleaseItsLAW.TimesPage: Integer;
//#UC START# *4B7C0B43005B_97FE67497778_var*
//#UC END# *4B7C0B43005B_97FE67497778_var*
begin
//#UC START# *4B7C0B43005B_97FE67497778_impl*
 Result := 260441621;
//#UC END# *4B7C0B43005B_97FE67497778_impl*
end;//TReleaseItsLAW.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleaseItsLAW.ResultsPage: Integer;
//#UC START# *4B7C0B670215_97FE67497778_var*
//#UC END# *4B7C0B670215_97FE67497778_var*
begin
//#UC START# *4B7C0B670215_97FE67497778_impl*
 Result := 260441606;
//#UC END# *4B7C0B670215_97FE67497778_impl*
end;//TReleaseItsLAW.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleaseItsLAW.IsLAW: Boolean;
//#UC START# *4C35A6DA02E9_97FE67497778_var*
//#UC END# *4C35A6DA02E9_97FE67497778_var*
begin
//#UC START# *4C35A6DA02E9_97FE67497778_impl*
 Result := true;
//#UC END# *4C35A6DA02E9_97FE67497778_impl*
end;//TReleaseItsLAW.IsLAW
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

end.