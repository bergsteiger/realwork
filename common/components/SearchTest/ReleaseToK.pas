unit ReleaseToK;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/common/components/SearchTest/ReleaseToK.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestResults::Class>> Shared Delphi Search Tests::ReleaseSearch::ReleaseToK
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
 TReleaseToK = class(TTestResultsPlace)
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
 end;//TReleaseToK
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}

// start class TReleaseToK

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleaseToK.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-ToK';
end;//TReleaseToK.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleaseToK.TimesPage: Integer;
//#UC START# *4B7C0B43005B_BA6E3EC73E04_var*
//#UC END# *4B7C0B43005B_BA6E3EC73E04_var*
begin
//#UC START# *4B7C0B43005B_BA6E3EC73E04_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7C0B43005B_BA6E3EC73E04_impl*
end;//TReleaseToK.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleaseToK.ResultsPage: Integer;
//#UC START# *4B7C0B670215_BA6E3EC73E04_var*
//#UC END# *4B7C0B670215_BA6E3EC73E04_var*
begin
//#UC START# *4B7C0B670215_BA6E3EC73E04_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7C0B670215_BA6E3EC73E04_impl*
end;//TReleaseToK.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest

end.