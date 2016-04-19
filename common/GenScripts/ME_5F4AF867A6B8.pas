unit kw_Folders_opUnderControlOpenFrmAct;
 {* ����� ������� ��� ������ �������� ������ Folders.UnderControlOpenFrmAct (����� ��������� �� ��������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\kw_Folders_opUnderControlOpenFrmAct.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Folders_opUnderControlOpenFrmAct" MUID: (5F4AF867A6B8)

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
 Tkw_Folders_opUnderControlOpenFrmAct = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Folders.UnderControlOpenFrmAct (����� ��������� �� ��������) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Folders_opUnderControlOpenFrmAct

class function Tkw_Folders_opUnderControlOpenFrmAct.GetWordNameForRegister: AnsiString;
begin
 Result := '���::�����_���������_��_��������';
end;//Tkw_Folders_opUnderControlOpenFrmAct.GetWordNameForRegister

class function Tkw_Folders_opUnderControlOpenFrmAct.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Folders_UnderControlOpenFrmAct;
end;//Tkw_Folders_opUnderControlOpenFrmAct.GetModuleOperationCode

initialization
 Tkw_Folders_opUnderControlOpenFrmAct.RegisterInEngine;
 {* ����������� Tkw_Folders_opUnderControlOpenFrmAct }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
