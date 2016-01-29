unit ReleaseArchi2;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/common/components/DailyTest/ReleaseArchi2.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestResults::Class>> Shared Delphi Tests::ReleaseDaily$Test::ReleaseArchi2
//
// Тесты на Archi2 (релизный вариант)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DailyTest\DailyTest.inc}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  KTestRunner
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TReleaseArchi2 = class(TTestResultsPlace)
  {* Тесты на Archi2 (релизный вариант) }
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
 end;//TReleaseArchi2
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TReleaseArchi2

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleaseArchi2.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-Archi2';
end;//TReleaseArchi2.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleaseArchi2.TimesPage: Integer;
//#UC START# *4B7C0B43005B_6B92D0808EA8_var*
//#UC END# *4B7C0B43005B_6B92D0808EA8_var*
begin
//#UC START# *4B7C0B43005B_6B92D0808EA8_impl*
 Result := 260441631;
//#UC END# *4B7C0B43005B_6B92D0808EA8_impl*
end;//TReleaseArchi2.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleaseArchi2.ResultsPage: Integer;
//#UC START# *4B7C0B670215_6B92D0808EA8_var*
//#UC END# *4B7C0B670215_6B92D0808EA8_var*
begin
//#UC START# *4B7C0B670215_6B92D0808EA8_impl*
 Result := 260441628;
//#UC END# *4B7C0B670215_6B92D0808EA8_impl*
end;//TReleaseArchi2.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

end.