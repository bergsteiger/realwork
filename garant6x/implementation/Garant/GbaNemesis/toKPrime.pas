unit toKPrime;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/toKPrime.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestResults::Class>> F1 ���������� ����� �����::Prime::toKPrime
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\GbaNemesis\nsDefine.inc}

interface

{$If defined(InsiderTest) AND defined(Monitorings) AND defined(nsTest)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  KTestRunner
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //InsiderTest AND Monitorings AND nsTest

{$If defined(InsiderTest) AND defined(Monitorings) AND defined(nsTest)}
type
 TtoKPrime = class(TTestResultsPlace)
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
 end;//TtoKPrime
{$IfEnd} //InsiderTest AND Monitorings AND nsTest

implementation

{$If defined(InsiderTest) AND defined(Monitorings) AND defined(nsTest)}

// start class TtoKPrime

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoKPrime.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-toKPrime';
end;//TtoKPrime.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoKPrime.TimesPage: Integer;
//#UC START# *4B7C0B43005B_5123804E003E_var*
//#UC END# *4B7C0B43005B_5123804E003E_var*
begin
//#UC START# *4B7C0B43005B_5123804E003E_impl*
 Result := 431377600;
//#UC END# *4B7C0B43005B_5123804E003E_impl*
end;//TtoKPrime.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoKPrime.ResultsPage: Integer;
//#UC START# *4B7C0B670215_5123804E003E_var*
//#UC END# *4B7C0B670215_5123804E003E_var*
begin
//#UC START# *4B7C0B670215_5123804E003E_impl*
 Result := 431377598;
//#UC END# *4B7C0B670215_5123804E003E_impl*
end;//TtoKPrime.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //InsiderTest AND Monitorings AND nsTest

end.