unit toK64;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/toK64.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestResults::Class>> F1 Ежедневные тесты::Nemesis::toK64
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\GbaNemesis\nsDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  KTestRunner
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //InsiderTest AND nsTest AND not Admin AND not Monitorings

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(Admin) AND not defined(Monitorings)}
type
 TtoK64 = class(TTestResultsPlace)
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
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   class function IsGK: Boolean; override;
     {* Тесты запущены ГК }
   {$IfEnd} //nsTest AND not NotTunedDUnit
 end;//TtoK64
{$IfEnd} //InsiderTest AND nsTest AND not Admin AND not Monitorings

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(Admin) AND not defined(Monitorings)}

// start class TtoK64

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoK64.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-toK64';
end;//TtoK64.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoK64.TimesPage: Integer;
//#UC START# *4B7C0B43005B_4DB6A92C025D_var*
//#UC END# *4B7C0B43005B_4DB6A92C025D_var*
begin
//#UC START# *4B7C0B43005B_4DB6A92C025D_impl*
 Result := 265393499;
//#UC END# *4B7C0B43005B_4DB6A92C025D_impl*
end;//TtoK64.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoK64.ResultsPage: Integer;
//#UC START# *4B7C0B670215_4DB6A92C025D_var*
//#UC END# *4B7C0B670215_4DB6A92C025D_var*
begin
//#UC START# *4B7C0B670215_4DB6A92C025D_impl*
 Result := 265393494;
//#UC END# *4B7C0B670215_4DB6A92C025D_impl*
end;//TtoK64.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoK64.IsGK: Boolean;
//#UC START# *4BEA9969001B_4DB6A92C025D_var*
//#UC END# *4BEA9969001B_4DB6A92C025D_var*
begin
//#UC START# *4BEA9969001B_4DB6A92C025D_impl*
 Result := true;
//#UC END# *4BEA9969001B_4DB6A92C025D_impl*
end;//TtoK64.IsGK
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //InsiderTest AND nsTest AND not Admin AND not Monitorings

end.