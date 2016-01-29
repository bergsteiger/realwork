unit ItsLAW;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/ItsLAW.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestResults::Class>> F1 ���������� �����::Nemesis::ItsLAW
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
 TItsLAW = class(TTestResultsPlace)
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
 end;//TItsLAW
{$IfEnd} //InsiderTest AND nsTest AND not Admin AND not Monitorings

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(Admin) AND not defined(Monitorings)}

// start class TItsLAW

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TItsLAW.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-ItsLAW';
end;//TItsLAW.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TItsLAW.TimesPage: Integer;
//#UC START# *4B7C0B43005B_4DA33288030A_var*
//#UC END# *4B7C0B43005B_4DA33288030A_var*
begin
//#UC START# *4B7C0B43005B_4DA33288030A_impl*
 if HasTabs then
  Result := 600103382
 else
  Result := 260447847;
//#UC END# *4B7C0B43005B_4DA33288030A_impl*
end;//TItsLAW.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TItsLAW.ResultsPage: Integer;
//#UC START# *4B7C0B670215_4DA33288030A_var*
//#UC END# *4B7C0B670215_4DA33288030A_var*
begin
//#UC START# *4B7C0B670215_4DA33288030A_impl*
 if HasTabs then
  Result := 600103379
 else
  Result := 260447845;
//#UC END# *4B7C0B670215_4DA33288030A_impl*
end;//TItsLAW.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TItsLAW.IsLAW: Boolean;
//#UC START# *4C35A6DA02E9_4DA33288030A_var*
//#UC END# *4C35A6DA02E9_4DA33288030A_var*
begin
//#UC START# *4C35A6DA02E9_4DA33288030A_impl*
 Result := true;
//#UC END# *4C35A6DA02E9_4DA33288030A_impl*
end;//TItsLAW.IsLAW
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //InsiderTest AND nsTest AND not Admin AND not Monitorings

end.