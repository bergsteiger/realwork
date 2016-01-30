unit toK;

// Модуль: "w:\archi\source\projects\PipeInAuto\toK.pas"
// Стереотип: "TestResults"

{$Include alcuDefine.inc}

interface

{$If Defined(AppServerSide)}
uses
 l3IntfUses
 {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
;

type
 TtoK = class(TTestResultsPlace)
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
 end;//TtoK
{$IfEnd} // Defined(AppServerSide)

implementation

{$If Defined(AppServerSide)}
uses
 l3ImplUses
;

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
class function TtoK.CommandLineKey: AnsiString;
 {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
//#UC START# *4B7AB0B6016E_52F250640165_var*
//#UC END# *4B7AB0B6016E_52F250640165_var*
begin
//#UC START# *4B7AB0B6016E_52F250640165_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_52F250640165_impl*
end;//TtoK.CommandLineKey
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
class function TtoK.TimesPage: Integer;
 {* Страница для вывода замеров времени }
//#UC START# *4B7C0B43005B_52F250640165_var*
//#UC END# *4B7C0B43005B_52F250640165_var*
begin
//#UC START# *4B7C0B43005B_52F250640165_impl*
 Result := 516170212;
//#UC END# *4B7C0B43005B_52F250640165_impl*
end;//TtoK.TimesPage
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
class function TtoK.ResultsPage: Integer;
 {* Страница для вывода результатов тестов }
//#UC START# *4B7C0B670215_52F250640165_var*
//#UC END# *4B7C0B670215_52F250640165_var*
begin
//#UC START# *4B7C0B670215_52F250640165_impl*
 Result := 516170210;
//#UC END# *4B7C0B670215_52F250640165_impl*
end;//TtoK.ResultsPage
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(AppServerSide)
end.
