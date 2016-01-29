unit toK;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/archi/source/projects/Everest/Lite/7.0/Express/toK.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestResults::Class>> archi$EverestLite$Test::EverestLite$Test::toK
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
 TtoK = class(TTestResultsPlace)
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
 end;//TtoK
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TtoK

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoK.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-toK';
end;//TtoK.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoK.TimesPage: Integer;
//#UC START# *4B7C0B43005B_512AF81103C7_var*
//#UC END# *4B7C0B43005B_512AF81103C7_var*
begin
//#UC START# *4B7C0B43005B_512AF81103C7_impl*
 Result := 433561379;
//#UC END# *4B7C0B43005B_512AF81103C7_impl*
end;//TtoK.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoK.ResultsPage: Integer;
//#UC START# *4B7C0B670215_512AF81103C7_var*
//#UC END# *4B7C0B670215_512AF81103C7_var*
begin
//#UC START# *4B7C0B670215_512AF81103C7_impl*
 Result := 433561370;
//#UC END# *4B7C0B670215_512AF81103C7_impl*
end;//TtoK.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //InsiderTest AND nsTest

end.