unit ToK;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/common/components/SearchTest/ToK.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestResults::Class>> Shared Delphi Search Tests::Search::ToK
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
 TToK = class(TTestResultsPlace)
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