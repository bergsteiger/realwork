unit Archi2;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/common/components/DailyTest/Archi2.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestResults::Class>> Shared Delphi Tests::Daily$Test::Archi2
//
// Тесты на Archi2
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
 TArchi2 = class(TTestResultsPlace)
  {* Тесты на Archi2 }
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
 end;//TArchi2
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TArchi2

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TArchi2.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-Archi2';
end;//TArchi2.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TArchi2.TimesPage: Integer;
//#UC START# *4B7C0B43005B_4C35A13B0201_var*
//#UC END# *4B7C0B43005B_4C35A13B0201_var*
begin
//#UC START# *4B7C0B43005B_4C35A13B0201_impl*
 Result := 224789164;
//#UC END# *4B7C0B43005B_4C35A13B0201_impl*
end;//TArchi2.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TArchi2.ResultsPage: Integer;
//#UC START# *4B7C0B670215_4C35A13B0201_var*
//#UC END# *4B7C0B670215_4C35A13B0201_var*
begin
//#UC START# *4B7C0B670215_4C35A13B0201_impl*
 Result := 224789160;
//#UC END# *4B7C0B670215_4C35A13B0201_impl*
end;//TArchi2.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

end.