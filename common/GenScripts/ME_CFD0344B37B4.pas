unit ReleaseToK2;
 {*  (релизный вариант) }

// Модуль: "w:\common\components\SearchTest\ReleaseToK2.pas"
// Стереотип: "TestResults"

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TReleaseToK2 = class(TTestResultsPlace)
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
 end;//TReleaseToK2
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TReleaseToK2.CommandLineKey: AnsiString;
 {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
//#UC START# *4B7AB0B6016E_CFD0344B37B4_var*
//#UC END# *4B7AB0B6016E_CFD0344B37B4_var*
begin
//#UC START# *4B7AB0B6016E_CFD0344B37B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_CFD0344B37B4_impl*
end;//TReleaseToK2.CommandLineKey
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TReleaseToK2.TimesPage: Integer;
 {* Страница для вывода замеров времени }
//#UC START# *4B7C0B43005B_CFD0344B37B4_var*
//#UC END# *4B7C0B43005B_CFD0344B37B4_var*
begin
//#UC START# *4B7C0B43005B_CFD0344B37B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7C0B43005B_CFD0344B37B4_impl*
end;//TReleaseToK2.TimesPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TReleaseToK2.ResultsPage: Integer;
 {* Страница для вывода результатов тестов }
//#UC START# *4B7C0B670215_CFD0344B37B4_var*
//#UC END# *4B7C0B670215_CFD0344B37B4_var*
begin
//#UC START# *4B7C0B670215_CFD0344B37B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7C0B670215_CFD0344B37B4_impl*
end;//TReleaseToK2.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest)
end.
