unit ConsultationWordsPack;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\ConsultationWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ConsultationWordsPack" MUID: (571A296801DD)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 //#UC START# *571A296801DDintf_uses*
 //#UC END# *571A296801DDintf_uses*
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
 , DataAdapter
 , nsTypes
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
 //#UC START# *571A296801DDimpl_uses*
 //#UC END# *571A296801DDimpl_uses*
;

type
 TkwF1ImportConsultation = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwF1ImportConsultation

procedure TkwF1ImportConsultation.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DECF7F4001F_var*
var
 l_S : String;
//#UC END# *4DAEEDE10285_4DECF7F4001F_var*
begin
//#UC START# *4DAEEDE10285_4DECF7F4001F_impl*
 l_S := aCtx.rEngine.PopDelphiString;
 l_S := aCtx.rCaller.ResolveInputFilePath(l_S);
 DefDataAdapter.ConsultationManager.LoadFromXml(nsAStr(l_S){.S});
//#UC END# *4DAEEDE10285_4DECF7F4001F_impl*
end;//TkwF1ImportConsultation.DoDoIt

class function TkwF1ImportConsultation.GetWordNameForRegister: AnsiString;
begin
 Result := 'f1::ImportConsultation';
end;//TkwF1ImportConsultation.GetWordNameForRegister

initialization
 TkwF1ImportConsultation.RegisterInEngine;
 {* Регистрация TkwF1ImportConsultation }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
