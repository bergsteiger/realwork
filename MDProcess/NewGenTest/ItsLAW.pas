unit ItsLAW;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/NewGenTest/ItsLAW.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestResults::Class>> MDProcess$NewGen::NewGen::ItsLAW
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\NewGenTest\NewGenTest.inc}

interface

{$If defined(NewGen) AND defined(nsTest)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  KTestRunner
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //NewGen AND nsTest

{$If defined(NewGen) AND defined(nsTest)}
type
 TItsLAW = class(TTestResultsPlace)
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
 end;//TItsLAW
{$IfEnd} //NewGen AND nsTest

implementation

{$If defined(NewGen) AND defined(nsTest)}

// start class TItsLAW

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TItsLAW.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-ItsLAW';
end;//TItsLAW.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TItsLAW.TimesPage: Integer;
//#UC START# *4B7C0B43005B_4F5F53F900AB_var*
//#UC END# *4B7C0B43005B_4F5F53F900AB_var*
begin
//#UC START# *4B7C0B43005B_4F5F53F900AB_impl*
 Result := 344753963;
//#UC END# *4B7C0B43005B_4F5F53F900AB_impl*
end;//TItsLAW.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TItsLAW.ResultsPage: Integer;
//#UC START# *4B7C0B670215_4F5F53F900AB_var*
//#UC END# *4B7C0B670215_4F5F53F900AB_var*
begin
//#UC START# *4B7C0B670215_4F5F53F900AB_impl*
 Result := 344753961;
//#UC END# *4B7C0B670215_4F5F53F900AB_impl*
end;//TItsLAW.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //NewGen AND nsTest

end.