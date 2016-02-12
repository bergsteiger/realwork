unit toKT;

// Модуль: "w:\archi\source\projects\Everest\Lite\7.0\Express\toKT.pas"
// Стереотип: "TestResults"

{$Include w:\archi\source\projects\Everest\Lite\7.0\Express\EverestLite.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TtoKT = class(TTestResultsPlace)
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
 end;//TtoKT
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TtoKT.CommandLineKey: AnsiString;
 {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
//#UC START# *4B7AB0B6016E_53F312A7027C_var*
//#UC END# *4B7AB0B6016E_53F312A7027C_var*
begin
//#UC START# *4B7AB0B6016E_53F312A7027C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_53F312A7027C_impl*
end;//TtoKT.CommandLineKey
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TtoKT.TimesPage: Integer;
 {* Страница для вывода замеров времени }
//#UC START# *4B7C0B43005B_53F312A7027C_var*
//#UC END# *4B7C0B43005B_53F312A7027C_var*
begin
//#UC START# *4B7C0B43005B_53F312A7027C_impl*
 Result := 562617404;
//#UC END# *4B7C0B43005B_53F312A7027C_impl*
end;//TtoKT.TimesPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TtoKT.ResultsPage: Integer;
 {* Страница для вывода результатов тестов }
//#UC START# *4B7C0B670215_53F312A7027C_var*
//#UC END# *4B7C0B670215_53F312A7027C_var*
begin
//#UC START# *4B7C0B670215_53F312A7027C_impl*
 Result := 562617393;
//#UC END# *4B7C0B670215_53F312A7027C_impl*
end;//TtoKT.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
