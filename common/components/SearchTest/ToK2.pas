unit ToK2;

// Модуль: "w:\common\components\SearchTest\ToK2.pas"
// Стереотип: "TestResults"
// Элемент модели: "ToK2" MUID: (537A1E5302EF)
// Имя типа: "TToK2"

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TToK2 = class({$If NOT Defined(NotTunedDUnit)}
 TTestResultsPlace
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 )
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
 end;//TToK2
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 //#UC START# *537A1E5302EFimpl_uses*
 //#UC END# *537A1E5302EFimpl_uses*
;

{$If NOT Defined(NotTunedDUnit)}
class function TToK2.CommandLineKey: AnsiString;
 {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
begin
 Result := '-ToK2';
end;//TToK2.CommandLineKey

class function TToK2.TimesPage: Integer;
 {* Страница для вывода замеров времени }
//#UC START# *4B7C0B43005B_537A1E5302EF_var*
//#UC END# *4B7C0B43005B_537A1E5302EF_var*
begin
//#UC START# *4B7C0B43005B_537A1E5302EF_impl*
 Result := 535904144;
//#UC END# *4B7C0B43005B_537A1E5302EF_impl*
end;//TToK2.TimesPage

class function TToK2.ResultsPage: Integer;
 {* Страница для вывода результатов тестов }
//#UC START# *4B7C0B670215_537A1E5302EF_var*
//#UC END# *4B7C0B670215_537A1E5302EF_var*
begin
//#UC START# *4B7C0B670215_537A1E5302EF_impl*
 Result := 535904140;
//#UC END# *4B7C0B670215_537A1E5302EF_impl*
end;//TToK2.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest)
end.
