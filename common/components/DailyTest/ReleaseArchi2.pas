unit ReleaseArchi2;
 {* Тесты на Archi2 (релизный вариант) }

// Модуль: "w:\common\components\DailyTest\ReleaseArchi2.pas"
// Стереотип: "TestResults"
// Элемент модели: "ReleaseArchi2" MUID: (6B92D0808EA8)
// Имя типа: "TReleaseArchi2"

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
 TReleaseArchi2 = class(TTestResultsPlace)
  {* Тесты на Archi2 (релизный вариант) }
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
 end;//TReleaseArchi2
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TReleaseArchi2.CommandLineKey: AnsiString;
 {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
begin
 Result := '-Archi2';
end;//TReleaseArchi2.CommandLineKey

class function TReleaseArchi2.TimesPage: Integer;
 {* Страница для вывода замеров времени }
//#UC START# *4B7C0B43005B_6B92D0808EA8_var*
//#UC END# *4B7C0B43005B_6B92D0808EA8_var*
begin
//#UC START# *4B7C0B43005B_6B92D0808EA8_impl*
 Result := 260441631;
//#UC END# *4B7C0B43005B_6B92D0808EA8_impl*
end;//TReleaseArchi2.TimesPage

class function TReleaseArchi2.ResultsPage: Integer;
 {* Страница для вывода результатов тестов }
//#UC START# *4B7C0B670215_6B92D0808EA8_var*
//#UC END# *4B7C0B670215_6B92D0808EA8_var*
begin
//#UC START# *4B7C0B670215_6B92D0808EA8_impl*
 Result := 260441628;
//#UC END# *4B7C0B670215_6B92D0808EA8_impl*
end;//TReleaseArchi2.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
