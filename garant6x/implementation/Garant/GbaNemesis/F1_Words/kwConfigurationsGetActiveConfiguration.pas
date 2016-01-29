unit kwConfigurationsGetActiveConfiguration;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 Words"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwConfigurationsGetActiveConfiguration.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ��������� ������::F1 Words::Words::configurations_GetActiveConfiguration
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

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
 TkwConfigurationsGetActiveConfiguration = {final scriptword} class(TkwConfigurationsWord)
 protected
 // realized methods
   procedure DoWithConfigurations(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigurationsGetActiveConfiguration
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  DataAdapter,
  SettingsUnit
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwConfigurationsGetActiveConfiguration

procedure TkwConfigurationsGetActiveConfiguration.DoWithConfigurations(const aCtx: TtfwContext);
//#UC START# *53B2E1D201CE_53B2DF81021D_var*
var
 l_C: IConfiguration;
//#UC END# *53B2E1D201CE_53B2DF81021D_var*
begin
//#UC START# *53B2E1D201CE_53B2DF81021D_impl*
 ConfigurationManager.GetActive(l_C);
 try
  aCtx.rEngine.PushIntf(l_C, TypeInfo(IConfiguration));
 finally
  l_C := nil;
 end;
//#UC END# *53B2E1D201CE_53B2DF81021D_impl*
end;//TkwConfigurationsGetActiveConfiguration.DoWithConfigurations

class function TkwConfigurationsGetActiveConfiguration.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'configurations:GetActiveConfiguration';
end;//TkwConfigurationsGetActiveConfiguration.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� configurations_GetActiveConfiguration
 TkwConfigurationsGetActiveConfiguration.RegisterInEngine;
{$IfEnd} //not NoScripts

end.