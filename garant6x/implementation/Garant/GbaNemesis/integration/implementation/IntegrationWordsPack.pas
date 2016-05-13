unit IntegrationWordsPack;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Integration\Implementation\IntegrationWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "IntegrationWordsPack" MUID: (5135EFD80062)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 //#UC START# *5135EFD80062intf_uses*
 //#UC END# *5135EFD80062intf_uses*
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
 , nsIntegrationSupport
 , nsIntegrationModelPart
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *5135EFD80062impl_uses*
 //#UC END# *5135EFD80062impl_uses*
;

type
 TkwIntegrationOpenLink = {final} class(TtfwRegisterableWord)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwIntegrationOpenLink

class function TkwIntegrationOpenLink.GetWordNameForRegister: AnsiString;
begin
 Result := 'integration:OpenLink';
end;//TkwIntegrationOpenLink.GetWordNameForRegister

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

initialization
 TkwIntegrationOpenLink.RegisterInEngine;
 {* Регистрация integration_OpenLink }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
