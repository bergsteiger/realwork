unit kwRestoreSettings;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwRestoreSettings.pas"
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
 TkwRestoreSettings = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwRestoreSettings
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 , nsConfigurationList
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
;

procedure TkwRestoreSettings.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_539834A703AD_var*
//#UC END# *4DAEEDE10285_539834A703AD_var*
begin
//#UC START# *4DAEEDE10285_539834A703AD_impl*
 ConfigurationList.ActiveConfig.RestoreAllSettings;
//#UC END# *4DAEEDE10285_539834A703AD_impl*
end;//TkwRestoreSettings.DoDoIt

class function TkwRestoreSettings.GetWordNameForRegister: AnsiString;
begin
 Result := 'RestoreSettings';
end;//TkwRestoreSettings.GetWordNameForRegister

initialization
 TkwRestoreSettings.RegisterInEngine;
 {* Регистрация RestoreSettings }
{$IfEnd} // NOT Defined(NoScripts)

end.
