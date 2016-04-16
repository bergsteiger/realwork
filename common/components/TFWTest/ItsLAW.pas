unit ItsLAW;

// Модуль: "w:\common\components\TFWTest\ItsLAW.pas"
// Стереотип: "TestResults"
// Элемент модели: "ItsLAW" MUID: (4CA0B4860072)
// Имя типа: "TItsLAW"

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TItsLAW = class({$If NOT Defined(NotTunedDUnit)}
 TTestResultsPlace
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 )
  protected
   {$If NOT Defined(NotTunedDUnit)}
   class function IsLAW: Boolean; override;
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
 end;//TItsLAW
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TItsLAW.CommandLineKey: AnsiString;
 {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
begin
 Result := '-ItsLAW';
end;//TItsLAW.CommandLineKey

class function TItsLAW.TimesPage: Integer;
 {* Страница для вывода замеров времени }
//#UC START# *4B7C0B43005B_4CA0B4860072_var*
//#UC END# *4B7C0B43005B_4CA0B4860072_var*
begin
//#UC START# *4B7C0B43005B_4CA0B4860072_impl*
 Result := 235059738;
//#UC END# *4B7C0B43005B_4CA0B4860072_impl*
end;//TItsLAW.TimesPage

class function TItsLAW.ResultsPage: Integer;
 {* Страница для вывода результатов тестов }
//#UC START# *4B7C0B670215_4CA0B4860072_var*
//#UC END# *4B7C0B670215_4CA0B4860072_var*
begin
//#UC START# *4B7C0B670215_4CA0B4860072_impl*
 Result := 235059736;
//#UC END# *4B7C0B670215_4CA0B4860072_impl*
end;//TItsLAW.ResultsPage

class function TItsLAW.IsLAW: Boolean;
//#UC START# *4C35A6DA02E9_4CA0B4860072_var*
//#UC END# *4C35A6DA02E9_4CA0B4860072_var*
begin
//#UC START# *4C35A6DA02E9_4CA0B4860072_impl*
 Result := true;
//#UC END# *4C35A6DA02E9_4CA0B4860072_impl*
end;//TItsLAW.IsLAW
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
