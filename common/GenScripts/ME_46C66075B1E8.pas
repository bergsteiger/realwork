unit ReleaseItsLAW;
 {*  (релизный вариант) }

// Модуль: "w:\MDProcess\NewGenTest\ReleaseItsLAW.pas"
// Стереотип: "TestResults"

{$Include NewGenTest.inc}

interface

{$If Defined(NewGen)}
uses
 l3IntfUses
 {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
;

type
 TReleaseItsLAW = class(TTestResultsPlace)
  {*  (релизный вариант) }
  public
   {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
   class function CommandLineKey: AnsiString; override;
    {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
   {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
   {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
   class function TimesPage: Integer; override;
    {* Страница для вывода замеров времени }
   {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
   {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
   class function ResultsPage: Integer; override;
    {* Страница для вывода результатов тестов }
   {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
 end;//TReleaseItsLAW
{$IfEnd} // Defined(NewGen)

implementation

{$If Defined(NewGen)}
uses
 l3ImplUses
;

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
class function TReleaseItsLAW.CommandLineKey: AnsiString;
 {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
//#UC START# *4B7AB0B6016E_46C66075B1E8_var*
//#UC END# *4B7AB0B6016E_46C66075B1E8_var*
begin
//#UC START# *4B7AB0B6016E_46C66075B1E8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_46C66075B1E8_impl*
end;//TReleaseItsLAW.CommandLineKey
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
class function TReleaseItsLAW.TimesPage: Integer;
 {* Страница для вывода замеров времени }
//#UC START# *4B7C0B43005B_46C66075B1E8_var*
//#UC END# *4B7C0B43005B_46C66075B1E8_var*
begin
//#UC START# *4B7C0B43005B_46C66075B1E8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7C0B43005B_46C66075B1E8_impl*
end;//TReleaseItsLAW.TimesPage
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
class function TReleaseItsLAW.ResultsPage: Integer;
 {* Страница для вывода результатов тестов }
//#UC START# *4B7C0B670215_46C66075B1E8_var*
//#UC END# *4B7C0B670215_46C66075B1E8_var*
begin
//#UC START# *4B7C0B670215_46C66075B1E8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7C0B670215_46C66075B1E8_impl*
end;//TReleaseItsLAW.ResultsPage
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(NewGen)
end.
