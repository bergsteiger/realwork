unit toK;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/common/components/DailyTest/toK.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestResults::Class>> Shared Delphi Tests::Daily$Test::toK
//
// Стандартный вывод для ГК
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
 TtoK = class(TTestResultsPlace)
  {* Стандартный вывод для ГК }
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
 end;//TtoK
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils
  {$If defined(nsTest) AND not defined(InsiderTest) AND not defined(NoScripts)}
  ,
  SHDTestScriptEngine
  {$IfEnd} //nsTest AND not InsiderTest AND not NoScripts
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TtoK

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoK.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-toK';
end;//TtoK.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoK.TimesPage: Integer;
//#UC START# *4B7C0B43005B_4B7BFDB40015_var*
//#UC END# *4B7C0B43005B_4B7BFDB40015_var*
begin
//#UC START# *4B7C0B43005B_4B7BFDB40015_impl*
 Result := 177963135;
//#UC END# *4B7C0B43005B_4B7BFDB40015_impl*
end;//TtoK.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoK.ResultsPage: Integer;
//#UC START# *4B7C0B670215_4B7BFDB40015_var*
//#UC END# *4B7C0B670215_4B7BFDB40015_var*
begin
//#UC START# *4B7C0B670215_4B7BFDB40015_impl*
 Result := 177963133;
//#UC END# *4B7C0B670215_4B7BFDB40015_impl*
end;//TtoK.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoK.IsGK: Boolean;
//#UC START# *4BEA9969001B_4B7BFDB40015_var*
//#UC END# *4BEA9969001B_4B7BFDB40015_var*
begin
//#UC START# *4BEA9969001B_4B7BFDB40015_impl*
 Result := true;
//#UC END# *4BEA9969001B_4B7BFDB40015_impl*
end;//TtoK.IsGK
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

end.