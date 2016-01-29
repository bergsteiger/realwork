unit toK;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/archi/source/projects/PipeInAuto/toK.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestResults::Class>> archi$AutoPipeServer$Garant::AutoPipeServer$Test::toK
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AppServerSide)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  KTestRunner
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //AppServerSide

{$If defined(AppServerSide)}
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
{$IfEnd} //AppServerSide

implementation

{$If defined(AppServerSide)}

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
//#UC START# *4B7C0B43005B_52F250640165_var*
//#UC END# *4B7C0B43005B_52F250640165_var*
begin
//#UC START# *4B7C0B43005B_52F250640165_impl*
 Result := 516170212;
//#UC END# *4B7C0B43005B_52F250640165_impl*
end;//TtoK.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TtoK.ResultsPage: Integer;
//#UC START# *4B7C0B670215_52F250640165_var*
//#UC END# *4B7C0B670215_52F250640165_var*
begin
//#UC START# *4B7C0B670215_52F250640165_impl*
 Result := 516170210;
//#UC END# *4B7C0B670215_52F250640165_impl*
end;//TtoK.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //AppServerSide

end.