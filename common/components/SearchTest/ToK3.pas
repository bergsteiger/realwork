unit ToK3;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/common/components/SearchTest/ToK3.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestResults::Class>> Shared Delphi Search Tests::Search::ToK3
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
 TToK3 = class(TTestResultsPlace)
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
 end;//TToK3
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}

// start class TToK3

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TToK3.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-ToK3';
end;//TToK3.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TToK3.TimesPage: Integer;
//#UC START# *4B7C0B43005B_537A1E5F03D2_var*
//#UC END# *4B7C0B43005B_537A1E5F03D2_var*
begin
//#UC START# *4B7C0B43005B_537A1E5F03D2_impl*
 Result := 535904146;
//#UC END# *4B7C0B43005B_537A1E5F03D2_impl*
end;//TToK3.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TToK3.ResultsPage: Integer;
//#UC START# *4B7C0B670215_537A1E5F03D2_var*
//#UC END# *4B7C0B670215_537A1E5F03D2_var*
begin
//#UC START# *4B7C0B670215_537A1E5F03D2_impl*
 Result := 535904142;
//#UC END# *4B7C0B670215_537A1E5F03D2_impl*
end;//TToK3.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest

end.