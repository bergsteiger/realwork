unit kw_Settings_opOpenStyleEditorAsModal;
 {* ����� ������� ��� ������ �������� ������ Settings.OpenStyleEditorAsModal$Op (��������� �������� ������...) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\kw_Settings_opOpenStyleEditorAsModal.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Settings_opOpenStyleEditorAsModal" MUID: (E9A444242DF9)

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
 Tkw_Settings_opOpenStyleEditorAsModal = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Settings.OpenStyleEditorAsModal$Op (��������� �������� ������...) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Settings_opOpenStyleEditorAsModal

class function Tkw_Settings_opOpenStyleEditorAsModal.GetWordNameForRegister: AnsiString;
begin
 Result := '���::���������_��������_������...';
end;//Tkw_Settings_opOpenStyleEditorAsModal.GetWordNameForRegister

class function Tkw_Settings_opOpenStyleEditorAsModal.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Settings_OpenStyleEditorAsModal;
end;//Tkw_Settings_opOpenStyleEditorAsModal.GetModuleOperationCode

initialization
 Tkw_Settings_opOpenStyleEditorAsModal.RegisterInEngine;
 {* ����������� Tkw_Settings_opOpenStyleEditorAsModal }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
