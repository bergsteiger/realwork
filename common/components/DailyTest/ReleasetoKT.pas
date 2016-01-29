unit ReleasetoKT;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/common/components/DailyTest/ReleasetoKT.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestResults::Class>> Shared Delphi Tests::ReleaseDaily$Test::ReleasetoKT
//
// Ежедневные тесты библиотек в Твери (релизный вариант)
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
 TReleasetoKT = class(TTestResultsPlace)
  {* Ежедневные тесты библиотек в Твери (релизный вариант) }
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
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   class function IsGK: Boolean; override;
     {* Тесты запущены ГК }
   {$IfEnd} //nsTest AND not NotTunedDUnit
 end;//TReleasetoKT
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TReleasetoKT

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleasetoKT.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-toKT';
end;//TReleasetoKT.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleasetoKT.TimesPage: Integer;
//#UC START# *4B7C0B43005B_7C0A8318D8D4_var*
//#UC END# *4B7C0B43005B_7C0A8318D8D4_var*
begin
//#UC START# *4B7C0B43005B_7C0A8318D8D4_impl*
 Result := -1;
 Assert(false);
//#UC END# *4B7C0B43005B_7C0A8318D8D4_impl*
end;//TReleasetoKT.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleasetoKT.ResultsPage: Integer;
//#UC START# *4B7C0B670215_7C0A8318D8D4_var*
//#UC END# *4B7C0B670215_7C0A8318D8D4_var*
begin
//#UC START# *4B7C0B670215_7C0A8318D8D4_impl*
 Result := -1;
 Assert(false);
//#UC END# *4B7C0B670215_7C0A8318D8D4_impl*
end;//TReleasetoKT.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleasetoKT.IsGK: Boolean;
//#UC START# *4BEA9969001B_7C0A8318D8D4_var*
//#UC END# *4BEA9969001B_7C0A8318D8D4_var*
begin
//#UC START# *4BEA9969001B_7C0A8318D8D4_impl*
 Result := true;
//#UC END# *4BEA9969001B_7C0A8318D8D4_impl*
end;//TReleasetoKT.IsGK
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

end.