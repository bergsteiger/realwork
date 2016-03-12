unit ReleasetoK64;
 {*  (релизный вариант) }

// Модуль: "w:\common\components\DailyTest\ReleasetoK64.pas"
// Стереотип: "TestResults"

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
 TReleasetoK64 = class(TTestResultsPlace)
  {*  (релизный вариант) }
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
 end;//TReleasetoK64
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TReleasetoK64.CommandLineKey: AnsiString;
 {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
//#UC START# *4B7AB0B6016E_18F018C495DA_var*
//#UC END# *4B7AB0B6016E_18F018C495DA_var*
begin
//#UC START# *4B7AB0B6016E_18F018C495DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_18F018C495DA_impl*
end;//TReleasetoK64.CommandLineKey

class function TReleasetoK64.TimesPage: Integer;
 {* Страница для вывода замеров времени }
//#UC START# *4B7C0B43005B_18F018C495DA_var*
//#UC END# *4B7C0B43005B_18F018C495DA_var*
begin
//#UC START# *4B7C0B43005B_18F018C495DA_impl*
 Result := -1;
 Assert(false);
//#UC END# *4B7C0B43005B_18F018C495DA_impl*
end;//TReleasetoK64.TimesPage

class function TReleasetoK64.ResultsPage: Integer;
 {* Страница для вывода результатов тестов }
//#UC START# *4B7C0B670215_18F018C495DA_var*
//#UC END# *4B7C0B670215_18F018C495DA_var*
begin
//#UC START# *4B7C0B670215_18F018C495DA_impl*
 Result := -1;
 Assert(false);
//#UC END# *4B7C0B670215_18F018C495DA_impl*
end;//TReleasetoK64.ResultsPage

class function TReleasetoK64.IsGK: Boolean;
 {* Тесты запущены ГК }
//#UC START# *4BEA9969001B_18F018C495DA_var*
//#UC END# *4BEA9969001B_18F018C495DA_var*
begin
//#UC START# *4BEA9969001B_18F018C495DA_impl*
 Result := false;
//#UC END# *4BEA9969001B_18F018C495DA_impl*
end;//TReleasetoK64.IsGK
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
