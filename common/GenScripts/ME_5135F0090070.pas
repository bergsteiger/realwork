unit kwIntegrationOpenLink;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwIntegrationOpenLink.pas"
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
 TkwIntegrationOpenLink = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwIntegrationOpenLink
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 , nsIntegrationSupport
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
 {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 , nsIntegrationModelPart
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
;

procedure TkwIntegrationOpenLink.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5135F0090070_var*
var
 l_Link: ansistring;
//#UC END# *4DAEEDE10285_5135F0090070_var*
begin
//#UC START# *4DAEEDE10285_5135F0090070_impl*
 l_Link := aCtx.rEngine.PopDelphiString;
 GarantShowLink(PAnsiChar(l_Link), False, 500);
//#UC END# *4DAEEDE10285_5135F0090070_impl*
end;//TkwIntegrationOpenLink.DoDoIt

class function TkwIntegrationOpenLink.GetWordNameForRegister: AnsiString;
begin
 Result := 'integration:OpenLink';
end;//TkwIntegrationOpenLink.GetWordNameForRegister

initialization
 TkwIntegrationOpenLink.RegisterInEngine;
 {* Регистрация integration_OpenLink }
{$IfEnd} // NOT Defined(NoScripts)

end.
