unit toKT;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/archi/source/projects/Archi/toKT.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestResults::Class>> archi$Test::Archi$Test::toKT
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Archi\arDefine.inc}

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
//#UC START# *4B7C0B43005B_525FC3B4005D_var*
//#UC END# *4B7C0B43005B_525FC3B4005D_var*
begin
//#UC START# *4B7C0B43005B_525FC3B4005D_impl*
 Result := 493857845;
//#UC END# *4B7C0B43005B_525FC3B4005D_impl*
end;//TtoKT.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoKT.ResultsPage: Integer;
//#UC START# *4B7C0B670215_525FC3B4005D_var*
//#UC END# *4B7C0B670215_525FC3B4005D_var*
begin
//#UC START# *4B7C0B670215_525FC3B4005D_impl*
 Result := 493857780;
//#UC END# *4B7C0B670215_525FC3B4005D_impl*
end;//TtoKT.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //InsiderTest AND nsTest

end.