unit toK2;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/toK2.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestResults::Class>> F1 ���������� �����::Nemesis::toK2
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\GbaNemesis\nsDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  KTestRunner
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //InsiderTest AND nsTest AND not Admin AND not Monitorings

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(Admin) AND not defined(Monitorings)}
type
 TtoK2 = class(TTestResultsPlace)
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
 end;//TtoK2
{$IfEnd} //InsiderTest AND nsTest AND not Admin AND not Monitorings

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(Admin) AND not defined(Monitorings)}

// start class TtoK2

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoK2.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-toK2';
end;//TtoK2.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoK2.TimesPage: Integer;
//#UC START# *4B7C0B43005B_5522999603C4_var*
//#UC END# *4B7C0B43005B_5522999603C4_var*
begin
//#UC START# *4B7C0B43005B_5522999603C4_impl*
 Result := 596177468;
//#UC END# *4B7C0B43005B_5522999603C4_impl*
end;//TtoK2.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoK2.ResultsPage: Integer;
//#UC START# *4B7C0B670215_5522999603C4_var*
//#UC END# *4B7C0B670215_5522999603C4_var*
begin
//#UC START# *4B7C0B670215_5522999603C4_impl*
 Result := 596177461;
//#UC END# *4B7C0B670215_5522999603C4_impl*
end;//TtoK2.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //InsiderTest AND nsTest AND not Admin AND not Monitorings

end.