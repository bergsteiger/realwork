unit kwF1ImportConsultation;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Shell_Words\kwF1ImportConsultation.pas"
// Стереотип: "ScriptKeyword"

{$Include nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwF1ImportConsultation = class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwF1ImportConsultation
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , DataAdapter
 , nsTypes
;

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
{$IfEnd} // NOT Defined(NoScripts)

end.
