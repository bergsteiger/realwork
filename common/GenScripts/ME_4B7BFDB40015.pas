unit toK;
 {* Стандартный вывод для ГК }

// Модуль: "w:\common\components\DailyTest\toK.pas"
// Стереотип: "TestResults"
// Элемент модели: "toK" MUID: (4B7BFDB40015)
// Имя типа: "TtoK"

{$Include w:\common\components\DailyTest\DailyTest.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TtoK = class(TTestResultsPlace)
  {* Стандартный вывод для ГК }
  protected
   {$If NOT Defined(NotTunedDUnit)}
   class function IsGK: Boolean; override;
    {* Тесты запущены ГК }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
  public
   {$If NOT Defined(NotTunedDUnit)}
   class function CommandLineKey: AnsiString; override;
    {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   {$If NOT Defined(NotTunedDUnit)}
   class function TimesPage: Integer; override;
    {* Страница для вывода замеров времени }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   {$If NOT Defined(NotTunedDUnit)}
   class function ResultsPage: Integer; override;
    {* Страница для вывода результатов тестов }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
 end;//TtoK
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(InsiderTest)}
 , SHDTestScriptEngine
 {$IfEnd} // NOT Defined(InsiderTest)
;

{$If NOT Defined(NotTunedDUnit)}
class function TtoK.CommandLineKey: AnsiString;
 {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
begin
 Result := '-toK';
end;//TtoK.CommandLineKey

class function TtoK.TimesPage: Integer;
 {* Страница для вывода замеров времени }
//#UC START# *4B7C0B43005B_4B7BFDB40015_var*
//#UC END# *4B7C0B43005B_4B7BFDB40015_var*
begin
//#UC START# *4B7C0B43005B_4B7BFDB40015_impl*
 Result := 177963135;
//#UC END# *4B7C0B43005B_4B7BFDB40015_impl*
end;//TtoK.TimesPage

class function TtoK.ResultsPage: Integer;
 {* Страница для вывода результатов тестов }
//#UC START# *4B7C0B670215_4B7BFDB40015_var*
//#UC END# *4B7C0B670215_4B7BFDB40015_var*
begin
//#UC START# *4B7C0B670215_4B7BFDB40015_impl*
 Result := 177963133;
//#UC END# *4B7C0B670215_4B7BFDB40015_impl*
end;//TtoK.ResultsPage

class function TtoK.IsGK: Boolean;
 {* Тесты запущены ГК }
//#UC START# *4BEA9969001B_4B7BFDB40015_var*
//#UC END# *4BEA9969001B_4B7BFDB40015_var*
begin
//#UC START# *4BEA9969001B_4B7BFDB40015_impl*
 Result := true;
//#UC END# *4BEA9969001B_4B7BFDB40015_impl*
end;//TtoK.IsGK
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
