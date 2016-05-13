unit SettingsKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Settings }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\SettingsKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "SettingsKeywordsPack" MUID: (62CEA735C6AD)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Settings_Form
 , tfwControlString
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 Tkw_Form_Settings = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Settings
----
*������ �������������*:
[code]
'aControl' �����::Settings TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_Settings

function Tkw_Form_Settings.GetString: AnsiString;
begin
 Result := 'cf_Settings';
end;//Tkw_Form_Settings.GetString

class function Tkw_Form_Settings.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Settings';
end;//Tkw_Form_Settings.GetWordNameForRegister

initialization
 Tkw_Form_Settings.RegisterInEngine;
 {* ����������� Tkw_Form_Settings }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Tcf_Settings));
 {* ����������� ���� Tcf_Settings }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
