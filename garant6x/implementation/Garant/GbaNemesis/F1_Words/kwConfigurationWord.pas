unit kwConfigurationWord;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 Words"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwConfigurationWord.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ��������� ������::F1 Words::Words::ConfigurationWord
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
  SettingsUnit,
  tfwScriptingInterfaces,
  kwConfigurationsWord
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwConfigurationWord = {abstract scriptword} class(TkwConfigurationsWord)
 protected
 // realized methods
   procedure DoWithConfigurations(const aCtx: TtfwContext); override;
 protected
 // protected methods
   procedure DoWithConfiguration(const aConfiguration: IConfiguration;
     const aCtx: TtfwContext); virtual; abstract;
 end;//TkwConfigurationWord
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  SysUtils,
  DataAdapter
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwConfigurationWord

procedure TkwConfigurationWord.DoWithConfigurations(const aCtx: TtfwContext);
//#UC START# *53B2E1D201CE_53B2E13A03D6_var*
var
 l_Unk: IUnknown;
 l_Conf: IConfiguration;
//#UC END# *53B2E1D201CE_53B2E13A03D6_var*
begin
//#UC START# *53B2E1D201CE_53B2E13A03D6_impl*
 RunnerAssert(aCtx.rEngine.IsTopIntf, '�� �������� ������������!', aCtx);
 l_Unk := aCtx.rEngine.PopIntf;
 if Supports(l_Unk, IConfiguration, l_Conf) then
  DoWithConfiguration(l_Conf, aCtx)
 else
  RunnerAssert(False, '�� �������� ������������!', aCtx);
//#UC END# *53B2E1D201CE_53B2E13A03D6_impl*
end;//TkwConfigurationWord.DoWithConfigurations

{$IfEnd} //not NoScripts

end.