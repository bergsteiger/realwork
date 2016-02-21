unit kwOpenPrimeForm;
 {* http://mdp.garant.ru/pages/viewpage.action?pageId=235046973 }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Shell_Words\kwOpenPrimeForm.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwOpenPrimeForm = {final} class(TtfwRegisterableWord)
  {* http://mdp.garant.ru/pages/viewpage.action?pageId=235046973 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwOpenPrimeForm
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 , PrimMonitorings_Module
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
;

procedure TkwOpenPrimeForm.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_54294F2701D0_var*
//#UC END# *4DAEEDE10285_54294F2701D0_var*
begin
//#UC START# *4DAEEDE10285_54294F2701D0_impl*
 TPrimMonitoringsModule.OpenNewsLinePrim;
//#UC END# *4DAEEDE10285_54294F2701D0_impl*
end;//TkwOpenPrimeForm.DoDoIt

class function TkwOpenPrimeForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'OpenPrimeForm';
end;//TkwOpenPrimeForm.GetWordNameForRegister

initialization
 TkwOpenPrimeForm.RegisterInEngine;
 {* Регистрация OpenPrimeForm }
{$IfEnd} // NOT Defined(NoScripts)

end.
