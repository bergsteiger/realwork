unit toKT;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/common/components/DailyTest/toKT.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestResults::Class>> Shared Delphi Tests::Daily$Test::toKT
//
// ���������� ����� ��������� � �����
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
 TtoKT = class(TTestResultsPlace)
  {* ���������� ����� ��������� � ����� }
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
 end;//TtoKT
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TtoKT

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoKT.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-toKT';
end;//TtoKT.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoKT.TimesPage: Integer;
//#UC START# *4B7C0B43005B_4E9EE76E003C_var*
//#UC END# *4B7C0B43005B_4E9EE76E003C_var*
begin
//#UC START# *4B7C0B43005B_4E9EE76E003C_impl*
 Result := 294594448;
//#UC END# *4B7C0B43005B_4E9EE76E003C_impl*
end;//TtoKT.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoKT.ResultsPage: Integer;
//#UC START# *4B7C0B670215_4E9EE76E003C_var*
//#UC END# *4B7C0B670215_4E9EE76E003C_var*
begin
//#UC START# *4B7C0B670215_4E9EE76E003C_impl*
 Result := 294594446;
//#UC END# *4B7C0B670215_4E9EE76E003C_impl*
end;//TtoKT.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoKT.IsGK: Boolean;
//#UC START# *4BEA9969001B_4E9EE76E003C_var*
//#UC END# *4BEA9969001B_4E9EE76E003C_var*
begin
//#UC START# *4BEA9969001B_4E9EE76E003C_impl*
 Result := true;
//#UC END# *4BEA9969001B_4E9EE76E003C_impl*
end;//TtoKT.IsGK
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

end.