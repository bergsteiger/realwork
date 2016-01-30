unit kwConfigurationGetType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwConfigurationGetType.pas"
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
 TkwConfigurationGetType = {final} class(TkwConfigurationWord)
  protected
   procedure DoWithConfiguration(const aConfiguration: IConfiguration;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigurationGetType
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TkwConfigurationGetType.DoWithConfiguration(const aConfiguration: IConfiguration;
 const aCtx: TtfwContext);
//#UC START# *53B2E36A0075_53B2DF6C00CA_var*
//#UC END# *53B2E36A0075_53B2DF6C00CA_var*
begin
//#UC START# *53B2E36A0075_53B2DF6C00CA_impl*
 aCtx.rEngine.PushInt(Ord(aConfiguration.GetType));
//#UC END# *53B2E36A0075_53B2DF6C00CA_impl*
end;//TkwConfigurationGetType.DoWithConfiguration

class function TkwConfigurationGetType.GetWordNameForRegister: AnsiString;
begin
 Result := 'configuration:GetType';
end;//TkwConfigurationGetType.GetWordNameForRegister

initialization
 TkwConfigurationGetType.RegisterInEngine;
 {* Регистрация configuration_GetType }
{$IfEnd} // NOT Defined(NoScripts)

end.
