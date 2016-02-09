unit kwConfigurationsGetCount;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwConfigurationsGetCount.pas"
// Стереотип: "ScriptKeyword"

{$Include nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwConfigurationsWord
 , tfwScriptingInterfaces
;

type
 TkwConfigurationsGetCount = {final} class(TkwConfigurationsWord)
  protected
   procedure DoWithConfigurations(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigurationsGetCount
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , DataAdapter
 , SettingsUnit
;

procedure TkwConfigurationsGetCount.DoWithConfigurations(const aCtx: TtfwContext);
//#UC START# *53B2E1D201CE_53B2DE010174_var*
var
 l_C: IConfigurations;
//#UC END# *53B2E1D201CE_53B2DE010174_var*
begin
//#UC START# *53B2E1D201CE_53B2DE010174_impl*
 ConfigurationManager.GetConfigurations(l_C);
 try
  aCtx.rEngine.PushInt(l_C.Count);
 finally
  l_C := nil;
 end;
//#UC END# *53B2E1D201CE_53B2DE010174_impl*
end;//TkwConfigurationsGetCount.DoWithConfigurations

class function TkwConfigurationsGetCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'configurations:GetCount';
end;//TkwConfigurationsGetCount.GetWordNameForRegister

initialization
 TkwConfigurationsGetCount.RegisterInEngine;
 {* Регистрация configurations_GetCount }
{$IfEnd} // NOT Defined(NoScripts)

end.
