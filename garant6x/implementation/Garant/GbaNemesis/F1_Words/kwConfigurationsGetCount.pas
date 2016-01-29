unit kwConfigurationsGetCount;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Words"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwConfigurationsGetCount.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Words::Words::configurations_GetCount
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  kwConfigurationsWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwConfigurationsGetCount = {final scriptword} class(TkwConfigurationsWord)
 protected
 // realized methods
   procedure DoWithConfigurations(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigurationsGetCount
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  DataAdapter,
  SettingsUnit
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwConfigurationsGetCount

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
 {-}
begin
 Result := 'configurations:GetCount';
end;//TkwConfigurationsGetCount.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация configurations_GetCount
 TkwConfigurationsGetCount.RegisterInEngine;
{$IfEnd} //not NoScripts

end.