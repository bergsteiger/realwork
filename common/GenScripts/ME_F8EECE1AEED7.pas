unit ReleaseItsLAW;
 {*  (релизный вариант) }

// Модуль: "w:\common\components\TFWTest\ReleaseItsLAW.pas"
// Стереотип: "TestResults"
// Элемент модели: "ReleaseItsLAW" MUID: (F8EECE1AEED7)
// Имя типа: "TReleaseItsLAW"

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TReleaseItsLAW = class(TTestResultsPlace)
  {*  (релизный вариант) }
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
 end;//TReleaseItsLAW
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TReleaseItsLAW.CommandLineKey: AnsiString;
 {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
//#UC START# *4B7AB0B6016E_F8EECE1AEED7_var*
//#UC END# *4B7AB0B6016E_F8EECE1AEED7_var*
begin
//#UC START# *4B7AB0B6016E_F8EECE1AEED7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_F8EECE1AEED7_impl*
end;//TReleaseItsLAW.CommandLineKey

class function TReleaseItsLAW.TimesPage: Integer;
 {* Страница для вывода замеров времени }
//#UC START# *4B7C0B43005B_F8EECE1AEED7_var*
//#UC END# *4B7C0B43005B_F8EECE1AEED7_var*
begin
//#UC START# *4B7C0B43005B_F8EECE1AEED7_impl*
 Result := 260441923;
//#UC END# *4B7C0B43005B_F8EECE1AEED7_impl*
end;//TReleaseItsLAW.TimesPage

class function TReleaseItsLAW.ResultsPage: Integer;
 {* Страница для вывода результатов тестов }
//#UC START# *4B7C0B670215_F8EECE1AEED7_var*
//#UC END# *4B7C0B670215_F8EECE1AEED7_var*
begin
//#UC START# *4B7C0B670215_F8EECE1AEED7_impl*
 Result := 260441921;
//#UC END# *4B7C0B670215_F8EECE1AEED7_impl*
end;//TReleaseItsLAW.ResultsPage

class function TReleaseItsLAW.IsLAW: Boolean;
//#UC START# *4C35A6DA02E9_F8EECE1AEED7_var*
//#UC END# *4C35A6DA02E9_F8EECE1AEED7_var*
begin
//#UC START# *4C35A6DA02E9_F8EECE1AEED7_impl*
 Result := true;
//#UC END# *4C35A6DA02E9_F8EECE1AEED7_impl*
end;//TReleaseItsLAW.IsLAW
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
