unit Archi2;
 {* Тесты на Archi2 }

// Модуль: "w:\common\components\DailyTest\Archi2.pas"
// Стереотип: "TestResults"

{$Include DailyTest.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TArchi2 = class(TTestResultsPlace)
  {* Тесты на Archi2 }
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
 end;//TArchi2
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TArchi2.CommandLineKey: AnsiString;
 {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
//#UC START# *4B7AB0B6016E_4C35A13B0201_var*
//#UC END# *4B7AB0B6016E_4C35A13B0201_var*
begin
//#UC START# *4B7AB0B6016E_4C35A13B0201_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_4C35A13B0201_impl*
end;//TArchi2.CommandLineKey
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TArchi2.TimesPage: Integer;
 {* Страница для вывода замеров времени }
//#UC START# *4B7C0B43005B_4C35A13B0201_var*
//#UC END# *4B7C0B43005B_4C35A13B0201_var*
begin
//#UC START# *4B7C0B43005B_4C35A13B0201_impl*
 Result := 224789164;
//#UC END# *4B7C0B43005B_4C35A13B0201_impl*
end;//TArchi2.TimesPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TArchi2.ResultsPage: Integer;
 {* Страница для вывода результатов тестов }
//#UC START# *4B7C0B670215_4C35A13B0201_var*
//#UC END# *4B7C0B670215_4C35A13B0201_var*
begin
//#UC START# *4B7C0B670215_4C35A13B0201_impl*
 Result := 224789160;
//#UC END# *4B7C0B670215_4C35A13B0201_impl*
end;//TArchi2.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
