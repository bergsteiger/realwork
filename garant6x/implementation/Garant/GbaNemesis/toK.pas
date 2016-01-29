unit toK;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/toK.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestResults::Class>> F1 Ежедневные тесты::Nemesis::toK
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
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   class function IsGK: Boolean; override;
     {* Тесты запущены ГК }
   {$IfEnd} //nsTest AND not NotTunedDUnit
 end;//TtoK
{$IfEnd} //InsiderTest AND nsTest AND not Admin AND not Monitorings

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(Admin) AND not defined(Monitorings)}

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
//#UC START# *4B7C0B43005B_4DA3327C0398_var*
//#UC END# *4B7C0B43005B_4DA3327C0398_var*
begin
//#UC START# *4B7C0B43005B_4DA3327C0398_impl*
 Result := 260447843;
//#UC END# *4B7C0B43005B_4DA3327C0398_impl*
end;//TtoK.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoK.ResultsPage: Integer;
//#UC START# *4B7C0B670215_4DA3327C0398_var*
//#UC END# *4B7C0B670215_4DA3327C0398_var*
begin
//#UC START# *4B7C0B670215_4DA3327C0398_impl*
 Result := 260447840;
//#UC END# *4B7C0B670215_4DA3327C0398_impl*
end;//TtoK.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoK.IsGK: Boolean;
//#UC START# *4BEA9969001B_4DA3327C0398_var*
//#UC END# *4BEA9969001B_4DA3327C0398_var*
begin
//#UC START# *4BEA9969001B_4DA3327C0398_impl*
 Result := true;
//#UC END# *4BEA9969001B_4DA3327C0398_impl*
end;//TtoK.IsGK
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //InsiderTest AND nsTest AND not Admin AND not Monitorings

end.