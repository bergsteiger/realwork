unit toKAdmin;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/toKAdmin.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestResults::Class>> F1 Ежедневные тесты Администратора::Admin::toKAdmin
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\GbaNemesis\nsDefine.inc}

interface

{$If defined(Admin) AND defined(InsiderTest) AND defined(nsTest)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  KTestRunner
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //Admin AND InsiderTest AND nsTest

{$If defined(Admin) AND defined(InsiderTest) AND defined(nsTest)}
type
 TtoKAdmin = class(TTestResultsPlace)
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
 end;//TtoKAdmin
{$IfEnd} //Admin AND InsiderTest AND nsTest

implementation

{$If defined(Admin) AND defined(InsiderTest) AND defined(nsTest)}

// start class TtoKAdmin

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoKAdmin.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-toKAdmin';
end;//TtoKAdmin.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoKAdmin.TimesPage: Integer;
//#UC START# *4B7C0B43005B_5123A75E00D5_var*
//#UC END# *4B7C0B43005B_5123A75E00D5_var*
begin
//#UC START# *4B7C0B43005B_5123A75E00D5_impl*
 Result := 431378129;
//#UC END# *4B7C0B43005B_5123A75E00D5_impl*
end;//TtoKAdmin.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoKAdmin.ResultsPage: Integer;
//#UC START# *4B7C0B670215_5123A75E00D5_var*
//#UC END# *4B7C0B670215_5123A75E00D5_var*
begin
//#UC START# *4B7C0B670215_5123A75E00D5_impl*
 Result := 431378120;
//#UC END# *4B7C0B670215_5123A75E00D5_impl*
end;//TtoKAdmin.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //Admin AND InsiderTest AND nsTest

end.