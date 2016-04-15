unit toKT;
 {* Ежедневные тесты библиотек в Твери }

// Модуль: "w:\common\components\DailyTest\toKT.pas"
// Стереотип: "TestResults"
// Элемент модели: "toKT" MUID: (4E9EE76E003C)
// Имя типа: "TtoKT"

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
 TtoKT = class(TTestResultsPlace)
  {* Ежедневные тесты библиотек в Твери }
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
 end;//TtoKT
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TtoKT.CommandLineKey: AnsiString;
 {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
begin
 Result := '-toKT';
end;//TtoKT.CommandLineKey

class function TtoKT.TimesPage: Integer;
 {* Страница для вывода замеров времени }
//#UC START# *4B7C0B43005B_4E9EE76E003C_var*
//#UC END# *4B7C0B43005B_4E9EE76E003C_var*
begin
//#UC START# *4B7C0B43005B_4E9EE76E003C_impl*
 Result := 294594448;
//#UC END# *4B7C0B43005B_4E9EE76E003C_impl*
end;//TtoKT.TimesPage

class function TtoKT.ResultsPage: Integer;
 {* Страница для вывода результатов тестов }
//#UC START# *4B7C0B670215_4E9EE76E003C_var*
//#UC END# *4B7C0B670215_4E9EE76E003C_var*
begin
//#UC START# *4B7C0B670215_4E9EE76E003C_impl*
 Result := 294594446;
//#UC END# *4B7C0B670215_4E9EE76E003C_impl*
end;//TtoKT.ResultsPage

class function TtoKT.IsGK: Boolean;
 {* Тесты запущены ГК }
//#UC START# *4BEA9969001B_4E9EE76E003C_var*
//#UC END# *4BEA9969001B_4E9EE76E003C_var*
begin
//#UC START# *4BEA9969001B_4E9EE76E003C_impl*
 Result := true;
//#UC END# *4BEA9969001B_4E9EE76E003C_impl*
end;//TtoKT.IsGK
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
