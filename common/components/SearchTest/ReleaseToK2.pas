unit ReleaseToK2;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/common/components/SearchTest/ReleaseToK2.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestResults::Class>> Shared Delphi Search Tests::ReleaseSearch::ReleaseToK2
//
// (релизный вариант)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

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
  {*  (релизный вариант) }
 public
 // realized methods
   {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   class function CommandLineKey: AnsiString; override;
     {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
   {$IfEnd} //nsTest AND not NotTunedDUnit
   {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   class function TimesPage: Integer; override;
     {* Страница для вывода замеров времени }
   {$IfEnd} //nsTest AND not NotTunedDUnit
   {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   class function ResultsPage: Integer; override;
     {* Страница для вывода результатов тестов }
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