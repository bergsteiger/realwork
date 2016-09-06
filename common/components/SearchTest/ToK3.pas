unit ToK3;

// Модуль: "w:\common\components\SearchTest\ToK3.pas"
// Стереотип: "TestResults"
// Элемент модели: "ToK3" MUID: (537A1E5F03D2)
// Имя типа: "TToK3"

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TToK3 = class({$If NOT Defined(NotTunedDUnit)}
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
 end;//TToK3
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 //#UC START# *537A1E5F03D2impl_uses*
 //#UC END# *537A1E5F03D2impl_uses*
;

{$If NOT Defined(NotTunedDUnit)}
class function TToK3.CommandLineKey: AnsiString;
 {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
begin
 Result := '-ToK3';
end;//TToK3.CommandLineKey

class function TToK3.TimesPage: Integer;
 {* Страница для вывода замеров времени }
//#UC START# *4B7C0B43005B_537A1E5F03D2_var*
//#UC END# *4B7C0B43005B_537A1E5F03D2_var*
begin
//#UC START# *4B7C0B43005B_537A1E5F03D2_impl*
 Result := 535904146;
//#UC END# *4B7C0B43005B_537A1E5F03D2_impl*
end;//TToK3.TimesPage

class function TToK3.ResultsPage: Integer;
 {* Страница для вывода результатов тестов }
//#UC START# *4B7C0B670215_537A1E5F03D2_var*
//#UC END# *4B7C0B670215_537A1E5F03D2_var*
begin
//#UC START# *4B7C0B670215_537A1E5F03D2_impl*
 Result := 535904142;
//#UC END# *4B7C0B670215_537A1E5F03D2_impl*
end;//TToK3.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest)
end.
