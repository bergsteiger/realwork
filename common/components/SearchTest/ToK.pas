unit ToK;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/common/components/SearchTest/ToK.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestResults::Class>> Shared Delphi Search Tests::Search::ToK
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
 TToK = class(TTestResultsPlace)
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
 end;//TToK
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}

// start class TToK

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TToK.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-ToK';
end;//TToK.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TToK.TimesPage: Integer;
//#UC START# *4B7C0B43005B_511B4CD501E9_var*
//#UC END# *4B7C0B43005B_511B4CD501E9_var*
begin
//#UC START# *4B7C0B43005B_511B4CD501E9_impl*
 Result := 430737727;
//#UC END# *4B7C0B43005B_511B4CD501E9_impl*
end;//TToK.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TToK.ResultsPage: Integer;
//#UC START# *4B7C0B670215_511B4CD501E9_var*
//#UC END# *4B7C0B670215_511B4CD501E9_var*
begin
//#UC START# *4B7C0B670215_511B4CD501E9_impl*
 Result := 430737722;
//#UC END# *4B7C0B670215_511B4CD501E9_impl*
end;//TToK.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest

end.