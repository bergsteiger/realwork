unit kwConfigurationsGetCount;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 Words"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwConfigurationsGetCount.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ��������� ������::F1 Words::Words::configurations_GetCount
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
// ����������� configurations_GetCount
 TkwConfigurationsGetCount.RegisterInEngine;
{$IfEnd} //not NoScripts

end.