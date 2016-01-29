unit ToK2;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/common/components/SearchTest/ToK2.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestResults::Class>> Shared Delphi Search Tests::Search::ToK2
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
 TToK2 = class(TTestResultsPlace)
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
 end;//TToK2
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}

// start class TToK2

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TToK2.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-ToK2';
end;//TToK2.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TToK2.TimesPage: Integer;
//#UC START# *4B7C0B43005B_537A1E5302EF_var*
//#UC END# *4B7C0B43005B_537A1E5302EF_var*
begin
//#UC START# *4B7C0B43005B_537A1E5302EF_impl*
 Result := 535904144;
//#UC END# *4B7C0B43005B_537A1E5302EF_impl*
end;//TToK2.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TToK2.ResultsPage: Integer;
//#UC START# *4B7C0B670215_537A1E5302EF_var*
//#UC END# *4B7C0B670215_537A1E5302EF_var*
begin
//#UC START# *4B7C0B670215_537A1E5302EF_impl*
 Result := 535904140;
//#UC END# *4B7C0B670215_537A1E5302EF_impl*
end;//TToK2.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest

end.