unit kwConfigurationGetID;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwConfigurationGetID.pas"
// Стереотип: "ScriptKeyword"

{$Include nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwConfigurationWord
 , SettingsUnit
 , tfwScriptingInterfaces
;

type
 TkwConfigurationGetID = {final} class(TkwConfigurationWord)
  protected
   procedure DoWithConfiguration(const aConfiguration: IConfiguration;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigurationGetID
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , DataAdapter
;

procedure TkwConfigurationGetID.DoWithConfiguration(const aConfiguration: IConfiguration;
 const aCtx: TtfwContext);
//#UC START# *53B2E36A0075_53B2E3EF00C4_var*
//#UC END# *53B2E36A0075_53B2E3EF00C4_var*
begin
//#UC START# *53B2E36A0075_53B2E3EF00C4_impl*
 aCtx.rEngine.PushInt(aConfiguration.GetID);
//#UC END# *53B2E36A0075_53B2E3EF00C4_impl*
end;//TkwConfigurationGetID.DoWithConfiguration

class function TkwConfigurationGetID.GetWordNameForRegister: AnsiString;
begin
 Result := 'configuration:GetID';
end;//TkwConfigurationGetID.GetWordNameForRegister

initialization
 TkwConfigurationGetID.RegisterInEngine;
 {* Регистрация configuration_GetID }
{$IfEnd} // NOT Defined(NoScripts)

end.
