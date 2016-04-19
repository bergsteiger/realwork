unit kw_Folders_opOpenFrmAct;
 {* ����� ������� ��� ������ �������� ������ Folders.OpenFrmAct (����� ��� ���������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\kw_Folders_opOpenFrmAct.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Folders_opOpenFrmAct" MUID: (FCFE035FCFBF)

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
 Tkw_Folders_opOpenFrmAct = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Folders.OpenFrmAct (����� ��� ���������) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Folders_opOpenFrmAct

class function Tkw_Folders_opOpenFrmAct.GetWordNameForRegister: AnsiString;
begin
 Result := '���::�����_���_���������';
end;//Tkw_Folders_opOpenFrmAct.GetWordNameForRegister

class function Tkw_Folders_opOpenFrmAct.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Folders_OpenFrmAct;
end;//Tkw_Folders_opOpenFrmAct.GetModuleOperationCode

initialization
 Tkw_Folders_opOpenFrmAct.RegisterInEngine;
 {* ����������� Tkw_Folders_opOpenFrmAct }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
