unit kw_Common_opShowEULA;
 {* ����� ������� ��� ������ �������� ������ Common.ShowEULA (���� ������� �������������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\kw_Common_opShowEULA.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Common_opShowEULA" MUID: (8F4D0554FC7C)

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
 Tkw_Common_opShowEULA = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Common.ShowEULA (���� ������� �������������) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Common_opShowEULA

class function Tkw_Common_opShowEULA.GetWordNameForRegister: AnsiString;
begin
 Result := '���::����_�������_�������������';
end;//Tkw_Common_opShowEULA.GetWordNameForRegister

class function Tkw_Common_opShowEULA.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Common_ShowEULA;
end;//Tkw_Common_opShowEULA.GetModuleOperationCode

initialization
 Tkw_Common_opShowEULA.RegisterInEngine;
 {* ����������� Tkw_Common_opShowEULA }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
