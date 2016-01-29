unit ReleasetoK;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/common/components/DailyTest/ReleasetoK.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestResults::Class>> Shared Delphi Tests::ReleaseDaily$Test::ReleasetoK
//
// ����������� ����� ��� �� (�������� �������)
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
 TReleasetoK = class(TTestResultsPlace)
  {* ����������� ����� ��� �� (�������� �������) }
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
 end;//TReleasetoK
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TReleasetoK

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleasetoK.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-toK';
end;//TReleasetoK.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleasetoK.TimesPage: Integer;
//#UC START# *4B7C0B43005B_431348CB3E15_var*
//#UC END# *4B7C0B43005B_431348CB3E15_var*
begin
//#UC START# *4B7C0B43005B_431348CB3E15_impl*
 Result := 260441616;
//#UC END# *4B7C0B43005B_431348CB3E15_impl*
end;//TReleasetoK.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleasetoK.ResultsPage: Integer;
//#UC START# *4B7C0B670215_431348CB3E15_var*
//#UC END# *4B7C0B670215_431348CB3E15_var*
begin
//#UC START# *4B7C0B670215_431348CB3E15_impl*
 Result := 260441614;
//#UC END# *4B7C0B670215_431348CB3E15_impl*
end;//TReleasetoK.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleasetoK.IsGK: Boolean;
//#UC START# *4BEA9969001B_431348CB3E15_var*
//#UC END# *4BEA9969001B_431348CB3E15_var*
begin
//#UC START# *4BEA9969001B_431348CB3E15_impl*
 Result := true;
//#UC END# *4BEA9969001B_431348CB3E15_impl*
end;//TReleasetoK.IsGK
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

end.