unit toKTPrime;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/toKTPrime.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestResults::Class>> F1 Ежедневные тесты ПРАЙМ::Prime::toKTPrime
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\GbaNemesis\nsDefine.inc}

interface

{$If defined(InsiderTest) AND defined(Monitorings) AND defined(nsTest)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  KTestRunner
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //InsiderTest AND Monitorings AND nsTest

{$If defined(InsiderTest) AND defined(Monitorings) AND defined(nsTest)}
type
 TtoKTPrime = class(TTestResultsPlace)
 public
 // realized methods
   {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   class function CommandLineKey: AnsiString; override;
     {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
   {$IfEnd} //nsTest AND not NotTunedDUnit
   {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   class function TimesPage: Integer; override;
     {* Страница для вывода замеров времени }
   {$IfEnd} //nsTest AND not NotTunedDUnit
   {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   class function ResultsPage: Integer; override;
     {* Страница для вывода результатов тестов }
   {$IfEnd} //nsTest AND not NotTunedDUnit
 end;//TtoKTPrime
{$IfEnd} //InsiderTest AND Monitorings AND nsTest

implementation

{$If defined(InsiderTest) AND defined(Monitorings) AND defined(nsTest)}

// start class TtoKTPrime

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoKTPrime.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-toKTPrime';
end;//TtoKTPrime.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoKTPrime.TimesPage: Integer;
//#UC START# *4B7C0B43005B_512388060314_var*
//#UC END# *4B7C0B43005B_512388060314_var*
begin
//#UC START# *4B7C0B43005B_512388060314_impl*
 Result := 431377634;
//#UC END# *4B7C0B43005B_512388060314_impl*
end;//TtoKTPrime.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoKTPrime.ResultsPage: Integer;
//#UC START# *4B7C0B670215_512388060314_var*
//#UC END# *4B7C0B670215_512388060314_var*
begin
//#UC START# *4B7C0B670215_512388060314_impl*
 Result := 431377632;
//#UC END# *4B7C0B670215_512388060314_impl*
end;//TtoKTPrime.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //InsiderTest AND Monitorings AND nsTest

end.