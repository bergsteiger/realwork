unit ReleasetoK;
 {* Стандартный вывод для ГК (релизный вариант) }

// Модуль: "w:\common\components\DailyTest\ReleasetoK.pas"
// Стереотип: "TestResults"
// Элемент модели: "ReleasetoK" MUID: (431348CB3E15)
// Имя типа: "TReleasetoK"

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
 TReleasetoK = class({$If NOT Defined(NotTunedDUnit)}
 TTestResultsPlace
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 )
  {* Стандартный вывод для ГК (релизный вариант) }
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
 end;//TReleasetoK
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *431348CB3E15impl_uses*
 //#UC END# *431348CB3E15impl_uses*
;

{$If NOT Defined(NotTunedDUnit)}
class function TReleasetoK.CommandLineKey: AnsiString;
 {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
begin
 Result := '-toK';
end;//TReleasetoK.CommandLineKey

class function TReleasetoK.TimesPage: Integer;
 {* Страница для вывода замеров времени }
//#UC START# *4B7C0B43005B_431348CB3E15_var*
//#UC END# *4B7C0B43005B_431348CB3E15_var*
begin
//#UC START# *4B7C0B43005B_431348CB3E15_impl*
 Result := 260441616;
//#UC END# *4B7C0B43005B_431348CB3E15_impl*
end;//TReleasetoK.TimesPage

class function TReleasetoK.ResultsPage: Integer;
 {* Страница для вывода результатов тестов }
//#UC START# *4B7C0B670215_431348CB3E15_var*
//#UC END# *4B7C0B670215_431348CB3E15_var*
begin
//#UC START# *4B7C0B670215_431348CB3E15_impl*
 Result := 260441614;
//#UC END# *4B7C0B670215_431348CB3E15_impl*
end;//TReleasetoK.ResultsPage

class function TReleasetoK.IsGK: Boolean;
 {* Тесты запущены ГК }
//#UC START# *4BEA9969001B_431348CB3E15_var*
//#UC END# *4BEA9969001B_431348CB3E15_var*
begin
//#UC START# *4BEA9969001B_431348CB3E15_impl*
 Result := true;
//#UC END# *4BEA9969001B_431348CB3E15_impl*
end;//TReleasetoK.IsGK
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
