unit kwConfigurationGetID;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 Words"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwConfigurationGetID.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ��������� ������::F1 Words::Words::configuration_GetID
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
  kwConfigurationWord,
  SettingsUnit,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwConfigurationGetID = {final scriptword} class(TkwConfigurationWord)
 protected
 // realized methods
   procedure DoWithConfiguration(const aConfiguration: IConfiguration;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigurationGetID
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  DataAdapter
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwConfigurationGetID

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
 {-}
begin
 Result := 'configuration:GetID';
end;//TkwConfigurationGetID.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� configuration_GetID
 TkwConfigurationGetID.RegisterInEngine;
{$IfEnd} //not NoScripts

end.