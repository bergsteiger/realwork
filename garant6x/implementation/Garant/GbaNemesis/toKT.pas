unit toKT;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/toKT.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestResults::Class>> F1 Ежедневные тесты::Nemesis::toKT
//
// Результаты тестов F1 в Твери
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
 TtoKT = class(TTestResultsPlace)
  {* Результаты тестов F1 в Твери }
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
 end;//TtoKT
{$IfEnd} //InsiderTest AND nsTest AND not Admin AND not Monitorings

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(Admin) AND not defined(Monitorings)}

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
//#UC START# *4B7C0B43005B_4E9EE25001F7_var*
//#UC END# *4B7C0B43005B_4E9EE25001F7_var*
begin
//#UC START# *4B7C0B43005B_4E9EE25001F7_impl*
 if HasTabs then
  Result := 600103364
 else
  Result := 356071770;
//#UC END# *4B7C0B43005B_4E9EE25001F7_impl*
end;//TtoKT.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoKT.ResultsPage: Integer;
//#UC START# *4B7C0B670215_4E9EE25001F7_var*
//#UC END# *4B7C0B670215_4E9EE25001F7_var*
begin
//#UC START# *4B7C0B670215_4E9EE25001F7_impl*
 if HasTabs then
  Result := 600103362
 else
  Result := 356071766;
//#UC END# *4B7C0B670215_4E9EE25001F7_impl*
end;//TtoKT.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoKT.IsGK: Boolean;
//#UC START# *4BEA9969001B_4E9EE25001F7_var*
//#UC END# *4BEA9969001B_4E9EE25001F7_var*
begin
//#UC START# *4BEA9969001B_4E9EE25001F7_impl*
 Result := true;
//#UC END# *4BEA9969001B_4E9EE25001F7_impl*
end;//TtoKT.IsGK
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //InsiderTest AND nsTest AND not Admin AND not Monitorings

end.