unit toKT;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/archi/source/projects/Everest/Lite/7.0/Express/toKT.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestResults::Class>> archi$EverestLite$Test::EverestLite$Test::toKT
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Express\EverestLite.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  KTestRunner
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}
type
 TtoKT = class(TTestResultsPlace)
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
 end;//TtoKT
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TtoKT

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoKT.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-toKT';
end;//TtoKT.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoKT.TimesPage: Integer;
//#UC START# *4B7C0B43005B_53F312A7027C_var*
//#UC END# *4B7C0B43005B_53F312A7027C_var*
begin
//#UC START# *4B7C0B43005B_53F312A7027C_impl*
 Result := 562617404;
//#UC END# *4B7C0B43005B_53F312A7027C_impl*
end;//TtoKT.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoKT.ResultsPage: Integer;
//#UC START# *4B7C0B670215_53F312A7027C_var*
//#UC END# *4B7C0B670215_53F312A7027C_var*
begin
//#UC START# *4B7C0B670215_53F312A7027C_impl*
 Result := 562617393;
//#UC END# *4B7C0B670215_53F312A7027C_impl*
end;//TtoKT.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //InsiderTest AND nsTest

end.