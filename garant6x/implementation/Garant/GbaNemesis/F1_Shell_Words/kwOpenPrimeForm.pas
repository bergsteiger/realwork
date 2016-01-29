unit kwOpenPrimeForm;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Shell Words"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwOpenPrimeForm.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Shell Words::F1 Shell Words::OpenPrimeForm
//
// http://mdp.garant.ru/pages/viewpage.action?pageId=235046973
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwOpenPrimeForm = {final scriptword} class(TtfwRegisterableWord)
  {* http://mdp.garant.ru/pages/viewpage.action?pageId=235046973 }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwOpenPrimeForm
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  Classes
  {$If not defined(Admin) AND not defined(Monitorings)}
  ,
  PrimMonitorings_Module
  {$IfEnd} //not Admin AND not Monitorings
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwOpenPrimeForm

procedure TkwOpenPrimeForm.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_54294F2701D0_var*
//#UC END# *4DAEEDE10285_54294F2701D0_var*
begin
//#UC START# *4DAEEDE10285_54294F2701D0_impl*
 TPrimMonitoringsModule.OpenNewsLinePrim;
//#UC END# *4DAEEDE10285_54294F2701D0_impl*
end;//TkwOpenPrimeForm.DoDoIt

class function TkwOpenPrimeForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'OpenPrimeForm';
end;//TkwOpenPrimeForm.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация OpenPrimeForm
 TkwOpenPrimeForm.RegisterInEngine;
{$IfEnd} //not NoScripts

end.