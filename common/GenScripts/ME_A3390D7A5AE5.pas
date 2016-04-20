unit kw_Settings_opSelectConfig;
 {* ����� ������� ��� ������ �������� ������ Settings.SelectConfig (��������� ����� ������������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\kw_Settings_opSelectConfig.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Settings_opSelectConfig" MUID: (A3390D7A5AE5)

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
 {$If NOT Defined(NoVCM)}
 , tfwModuleOperationWord
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

{$If NOT Defined(NoVCM)}
type
 Tkw_Settings_opSelectConfig = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Settings.SelectConfig (��������� ����� ������������) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Settings_opSelectConfig

class function Tkw_Settings_opSelectConfig.GetWordNameForRegister: AnsiString;
begin
 Result := '���::���������_�����_������������';
end;//Tkw_Settings_opSelectConfig.GetWordNameForRegister

class function Tkw_Settings_opSelectConfig.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Settings_SelectConfig;
end;//Tkw_Settings_opSelectConfig.GetModuleOperationCode

initialization
 Tkw_Settings_opSelectConfig.RegisterInEngine;
 {* ����������� Tkw_Settings_opSelectConfig }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
