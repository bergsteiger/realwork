unit kwConfigurationGetName;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwConfigurationGetName.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "configuration_GetName" MUID: (53B2DF500282)
// Имя типа: "TkwConfigurationGetName"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwConfigurationWord
 , SettingsUnit
 , tfwScriptingInterfaces
;

type
 TkwConfigurationGetName = {final} class(TkwConfigurationWord)
  protected
   procedure DoWithConfiguration(const aConfiguration: IConfiguration;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigurationGetName
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , IOUnit
 , nsTypes
 , DataAdapter
;

procedure TkwConfigurationGetName.DoWithConfiguration(const aConfiguration: IConfiguration;
 const aCtx: TtfwContext);
//#UC START# *53B2E36A0075_53B2DF500282_var*
var
 l_S: IString;
//#UC END# *53B2E36A0075_53B2DF500282_var*
begin
//#UC START# *53B2E36A0075_53B2DF500282_impl*
 aConfiguration.GetName(l_S);
 try
  aCtx.rEngine.PushString(nsCStr(l_S));
 finally
  l_S := nil;
 end;
//#UC END# *53B2E36A0075_53B2DF500282_impl*
end;//TkwConfigurationGetName.DoWithConfiguration

class function TkwConfigurationGetName.GetWordNameForRegister: AnsiString;
begin
 Result := 'configuration:GetName';
end;//TkwConfigurationGetName.GetWordNameForRegister

initialization
 TkwConfigurationGetName.RegisterInEngine;
 {* Регистрация configuration_GetName }
{$IfEnd} // NOT Defined(NoScripts)

end.
