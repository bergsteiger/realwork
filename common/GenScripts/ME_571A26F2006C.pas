unit PrimMonitoringsWordsPack;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\PrimMonitoringsWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "PrimMonitoringsWordsPack" MUID: (571A26F2006C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 //#UC START# *571A26F2006Cintf_uses*
 //#UC END# *571A26F2006Cintf_uses*
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
 , PrimMonitorings_Module
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *571A26F2006Cimpl_uses*
 //#UC END# *571A26F2006Cimpl_uses*
;

type
 TkwOpenPrimeForm = {final} class(TtfwRegisterableWord)
  {* http://mdp.garant.ru/pages/viewpage.action?pageId=235046973 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwOpenPrimeForm

class function TkwOpenPrimeForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'OpenPrimeForm';
end;//TkwOpenPrimeForm.GetWordNameForRegister

procedure TkwOpenPrimeForm.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_54294F2701D0_var*
//#UC END# *4DAEEDE10285_54294F2701D0_var*
begin
//#UC START# *4DAEEDE10285_54294F2701D0_impl*
 TPrimMonitoringsModule.OpenNewsLinePrim;
//#UC END# *4DAEEDE10285_54294F2701D0_impl*
end;//TkwOpenPrimeForm.DoDoIt

initialization
 TkwOpenPrimeForm.RegisterInEngine;
 {* Регистрация OpenPrimeForm }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
