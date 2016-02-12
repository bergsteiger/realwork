unit ItsLAW;

// Модуль: "w:\MDProcess\NewGenTest\ItsLAW.pas"
// Стереотип: "TestResults"

{$Include w:\MDProcess\NewGenTest\NewGenTest.inc}

interface

{$If Defined(NewGen) AND Defined(nsTest)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TItsLAW = class(TTestResultsPlace)
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
{$IfEnd} // Defined(NewGen) AND Defined(nsTest)

implementation

{$If Defined(NewGen) AND Defined(nsTest)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TItsLAW.CommandLineKey: AnsiString;
 {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
//#UC START# *4B7AB0B6016E_4F5F53F900AB_var*
//#UC END# *4B7AB0B6016E_4F5F53F900AB_var*
begin
//#UC START# *4B7AB0B6016E_4F5F53F900AB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_4F5F53F900AB_impl*
end;//TItsLAW.CommandLineKey
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TItsLAW.TimesPage: Integer;
 {* Страница для вывода замеров времени }
//#UC START# *4B7C0B43005B_4F5F53F900AB_var*
//#UC END# *4B7C0B43005B_4F5F53F900AB_var*
begin
//#UC START# *4B7C0B43005B_4F5F53F900AB_impl*
 Result := 344753963;
//#UC END# *4B7C0B43005B_4F5F53F900AB_impl*
end;//TItsLAW.TimesPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TItsLAW.ResultsPage: Integer;
 {* Страница для вывода результатов тестов }
//#UC START# *4B7C0B670215_4F5F53F900AB_var*
//#UC END# *4B7C0B670215_4F5F53F900AB_var*
begin
//#UC START# *4B7C0B670215_4F5F53F900AB_impl*
 Result := 344753961;
//#UC END# *4B7C0B670215_4F5F53F900AB_impl*
end;//TItsLAW.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(NewGen) AND Defined(nsTest)
end.
