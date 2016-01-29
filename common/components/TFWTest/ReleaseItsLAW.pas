unit ReleaseItsLAW;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/common/components/TFWTest/ReleaseItsLAW.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestResults::Class>> Shared Delphi Tests::ReleaseTFW::ReleaseItsLAW
//
// (релизный вариант)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  KTestRunner
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TReleaseItsLAW = class(TTestResultsPlace)
  {*  (релизный вариант) }
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
   class function IsLAW: Boolean; override;
   {$IfEnd} //nsTest AND not NotTunedDUnit
 end;//TReleaseItsLAW
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TReleaseItsLAW

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleaseItsLAW.CommandLineKey: AnsiString;
 {-}
begin
 Result := '-ItsLAW';
end;//TReleaseItsLAW.CommandLineKey
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleaseItsLAW.TimesPage: Integer;
//#UC START# *4B7C0B43005B_F8EECE1AEED7_var*
//#UC END# *4B7C0B43005B_F8EECE1AEED7_var*
begin
//#UC START# *4B7C0B43005B_F8EECE1AEED7_impl*
 Result := 260441923;
//#UC END# *4B7C0B43005B_F8EECE1AEED7_impl*
end;//TReleaseItsLAW.TimesPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleaseItsLAW.ResultsPage: Integer;
//#UC START# *4B7C0B670215_F8EECE1AEED7_var*
//#UC END# *4B7C0B670215_F8EECE1AEED7_var*
begin
//#UC START# *4B7C0B670215_F8EECE1AEED7_impl*
 Result := 260441921;
//#UC END# *4B7C0B670215_F8EECE1AEED7_impl*
end;//TReleaseItsLAW.ResultsPage
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
class function TReleaseItsLAW.IsLAW: Boolean;
//#UC START# *4C35A6DA02E9_F8EECE1AEED7_var*
//#UC END# *4C35A6DA02E9_F8EECE1AEED7_var*
begin
//#UC START# *4C35A6DA02E9_F8EECE1AEED7_impl*
 Result := true;
//#UC END# *4C35A6DA02E9_F8EECE1AEED7_impl*
end;//TReleaseItsLAW.IsLAW
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

end.