unit kw_Settings_opOpenConfList;
 {* ����� ������� ��� ������ �������� ������ Settings.OpenConfList$Op (��������� ������ ������������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\kw_Settings_opOpenConfList.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Settings_opOpenConfList" MUID: (7BCDAEAE5749)

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
 Tkw_Settings_opOpenConfList = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Settings.OpenConfList$Op (��������� ������ ������������) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Settings_opOpenConfList

class function Tkw_Settings_opOpenConfList.GetWordNameForRegister: AnsiString;
begin
 Result := '���::���������_������_������������';
end;//Tkw_Settings_opOpenConfList.GetWordNameForRegister

class function Tkw_Settings_opOpenConfList.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Settings_OpenConfList;
end;//Tkw_Settings_opOpenConfList.GetModuleOperationCode

initialization
 Tkw_Settings_opOpenConfList.RegisterInEngine;
 {* ����������� Tkw_Settings_opOpenConfList }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
