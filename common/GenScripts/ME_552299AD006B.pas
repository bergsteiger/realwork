unit toK3;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\toK3.pas"
// Стереотип: "TestResults"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TtoK3 = class(TTestResultsPlace)
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
 end;//TtoK3
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TtoK3.CommandLineKey: AnsiString;
 {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
//#UC START# *4B7AB0B6016E_552299AD006B_var*
//#UC END# *4B7AB0B6016E_552299AD006B_var*
begin
//#UC START# *4B7AB0B6016E_552299AD006B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_552299AD006B_impl*
end;//TtoK3.CommandLineKey

class function TtoK3.TimesPage: Integer;
 {* Страница для вывода замеров времени }
//#UC START# *4B7C0B43005B_552299AD006B_var*
//#UC END# *4B7C0B43005B_552299AD006B_var*
begin
//#UC START# *4B7C0B43005B_552299AD006B_impl*
 Result := 596177470;
//#UC END# *4B7C0B43005B_552299AD006B_impl*
end;//TtoK3.TimesPage

class function TtoK3.ResultsPage: Integer;
 {* Страница для вывода результатов тестов }
//#UC START# *4B7C0B670215_552299AD006B_var*
//#UC END# *4B7C0B670215_552299AD006B_var*
begin
//#UC START# *4B7C0B670215_552299AD006B_impl*
 Result := 596177465;
//#UC END# *4B7C0B670215_552299AD006B_impl*
end;//TtoK3.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
