unit ReleaseToK2;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/common/components/SearchTest/ReleaseToK2.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestResults::Class>> Shared Delphi Search Tests::ReleaseSearch::ReleaseToK2
//
// (�������� �������)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

{$If defined(nsTest)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  KTestRunner
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}
type
 TReleaseToK2 = class(TTestResultsPlace)
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
 end;//TReleaseToK2
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}

// start class TReleaseToK2

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleaseToK2.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-ToK2';
end;//TReleaseToK2.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleaseToK2.TimesPage: Integer;
//#UC START# *4B7C0B43005B_CFD0344B37B4_var*
//#UC END# *4B7C0B43005B_CFD0344B37B4_var*
begin
//#UC START# *4B7C0B43005B_CFD0344B37B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7C0B43005B_CFD0344B37B4_impl*
end;//TReleaseToK2.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleaseToK2.ResultsPage: Integer;
//#UC START# *4B7C0B670215_CFD0344B37B4_var*
//#UC END# *4B7C0B670215_CFD0344B37B4_var*
begin
//#UC START# *4B7C0B670215_CFD0344B37B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7C0B670215_CFD0344B37B4_impl*
end;//TReleaseToK2.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest

end.