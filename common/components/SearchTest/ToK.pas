unit ToK;

// Модуль: "w:\common\components\SearchTest\ToK.pas"
// Стереотип: "TestResults"
// Элемент модели: "ToK" MUID: (511B4CD501E9)
// Имя типа: "TToK"

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TToK = class({$If NOT Defined(NotTunedDUnit)}
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
 end;//TToK
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 //#UC START# *511B4CD501E9impl_uses*
 //#UC END# *511B4CD501E9impl_uses*
;

{$If NOT Defined(NotTunedDUnit)}
class function TToK.CommandLineKey: AnsiString;
 {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
begin
 Result := '-ToK';
end;//TToK.CommandLineKey

class function TToK.TimesPage: Integer;
 {* Страница для вывода замеров времени }
//#UC START# *4B7C0B43005B_511B4CD501E9_var*
//#UC END# *4B7C0B43005B_511B4CD501E9_var*
begin
//#UC START# *4B7C0B43005B_511B4CD501E9_impl*
 Result := 430737727;
//#UC END# *4B7C0B43005B_511B4CD501E9_impl*
end;//TToK.TimesPage

class function TToK.ResultsPage: Integer;
 {* Страница для вывода результатов тестов }
//#UC START# *4B7C0B670215_511B4CD501E9_var*
//#UC END# *4B7C0B670215_511B4CD501E9_var*
begin
//#UC START# *4B7C0B670215_511B4CD501E9_impl*
 Result := 430737722;
//#UC END# *4B7C0B670215_511B4CD501E9_impl*
end;//TToK.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest)
end.
