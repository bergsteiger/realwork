unit ReleaseToK3;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/common/components/SearchTest/ReleaseToK3.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestResults::Class>> Shared Delphi Search Tests::ReleaseSearch::ReleaseToK3
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
 TReleaseToK3 = class(TTestResultsPlace)
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
 end;//TReleaseToK3
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}

// start class TReleaseToK3

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleaseToK3.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-ToK3';
end;//TReleaseToK3.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleaseToK3.TimesPage: Integer;
//#UC START# *4B7C0B43005B_3337505C7D4E_var*
//#UC END# *4B7C0B43005B_3337505C7D4E_var*
begin
//#UC START# *4B7C0B43005B_3337505C7D4E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7C0B43005B_3337505C7D4E_impl*
end;//TReleaseToK3.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleaseToK3.ResultsPage: Integer;
//#UC START# *4B7C0B670215_3337505C7D4E_var*
//#UC END# *4B7C0B670215_3337505C7D4E_var*
begin
//#UC START# *4B7C0B670215_3337505C7D4E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7C0B670215_3337505C7D4E_impl*
end;//TReleaseToK3.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest

end.