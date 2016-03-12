unit ItsLAW;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\ItsLAW.pas"
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
 TItsLAW = class(TTestResultsPlace)
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
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TItsLAW.CommandLineKey: AnsiString;
 {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
//#UC START# *4B7AB0B6016E_4DA33288030A_var*
//#UC END# *4B7AB0B6016E_4DA33288030A_var*
begin
//#UC START# *4B7AB0B6016E_4DA33288030A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_4DA33288030A_impl*
end;//TItsLAW.CommandLineKey

class function TItsLAW.TimesPage: Integer;
 {* Страница для вывода замеров времени }
//#UC START# *4B7C0B43005B_4DA33288030A_var*
//#UC END# *4B7C0B43005B_4DA33288030A_var*
begin
//#UC START# *4B7C0B43005B_4DA33288030A_impl*
 if HasTabs then
  Result := 600103382
 else
  Result := 260447847;
//#UC END# *4B7C0B43005B_4DA33288030A_impl*
end;//TItsLAW.TimesPage

class function TItsLAW.ResultsPage: Integer;
 {* Страница для вывода результатов тестов }
//#UC START# *4B7C0B670215_4DA33288030A_var*
//#UC END# *4B7C0B670215_4DA33288030A_var*
begin
//#UC START# *4B7C0B670215_4DA33288030A_impl*
 if HasTabs then
  Result := 600103379
 else
  Result := 260447845;
//#UC END# *4B7C0B670215_4DA33288030A_impl*
end;//TItsLAW.ResultsPage

class function TItsLAW.IsLAW: Boolean;
//#UC START# *4C35A6DA02E9_4DA33288030A_var*
//#UC END# *4C35A6DA02E9_4DA33288030A_var*
begin
//#UC START# *4C35A6DA02E9_4DA33288030A_impl*
 Result := true;
//#UC END# *4C35A6DA02E9_4DA33288030A_impl*
end;//TItsLAW.IsLAW
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
