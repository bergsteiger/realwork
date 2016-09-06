unit ReleaseToK3;
 {*  (релизный вариант) }

// Модуль: "w:\common\components\SearchTest\ReleaseToK3.pas"
// Стереотип: "TestResults"
// Элемент модели: "ReleaseToK3" MUID: (3337505C7D4E)
// Имя типа: "TReleaseToK3"

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TReleaseToK3 = class({$If NOT Defined(NotTunedDUnit)}
 TTestResultsPlace
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 )
  {*  (релизный вариант) }
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
 end;//TReleaseToK3
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 //#UC START# *3337505C7D4Eimpl_uses*
 //#UC END# *3337505C7D4Eimpl_uses*
;

{$If NOT Defined(NotTunedDUnit)}
class function TReleaseToK3.CommandLineKey: AnsiString;
 {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
begin
 Result := '-ToK3';
end;//TReleaseToK3.CommandLineKey

class function TReleaseToK3.TimesPage: Integer;
 {* Страница для вывода замеров времени }
//#UC START# *4B7C0B43005B_3337505C7D4E_var*
//#UC END# *4B7C0B43005B_3337505C7D4E_var*
begin
//#UC START# *4B7C0B43005B_3337505C7D4E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7C0B43005B_3337505C7D4E_impl*
end;//TReleaseToK3.TimesPage

class function TReleaseToK3.ResultsPage: Integer;
 {* Страница для вывода результатов тестов }
//#UC START# *4B7C0B670215_3337505C7D4E_var*
//#UC END# *4B7C0B670215_3337505C7D4E_var*
begin
//#UC START# *4B7C0B670215_3337505C7D4E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7C0B670215_3337505C7D4E_impl*
end;//TReleaseToK3.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest)
end.
