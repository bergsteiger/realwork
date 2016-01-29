unit kwRestoreSettings;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 Words"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwRestoreSettings.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ��������� ������::F1 Words::Words::RestoreSettings
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
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwRestoreSettings = {final scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwRestoreSettings
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  Classes
  {$If not defined(Admin) AND not defined(Monitorings)}
  ,
  nsConfigurationList
  {$IfEnd} //not Admin AND not Monitorings
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwRestoreSettings

procedure TkwRestoreSettings.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_539834A703AD_var*
//#UC END# *4DAEEDE10285_539834A703AD_var*
begin
//#UC START# *4DAEEDE10285_539834A703AD_impl*
 ConfigurationList.ActiveConfig.RestoreAllSettings;
//#UC END# *4DAEEDE10285_539834A703AD_impl*
end;//TkwRestoreSettings.DoDoIt

class function TkwRestoreSettings.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'RestoreSettings';
end;//TkwRestoreSettings.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� RestoreSettings
 TkwRestoreSettings.RegisterInEngine;
{$IfEnd} //not NoScripts

end.