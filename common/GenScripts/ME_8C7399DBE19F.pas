unit kw_Inpharm_opMedicDiction;
 {* ����� ������� ��� ������ �������� ������ Inpharm.MedicDiction$Op (������ ������� ����������� ��������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\kw_Inpharm_opMedicDiction.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Inpharm_opMedicDiction" MUID: (8C7399DBE19F)

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
 Tkw_Inpharm_opMedicDiction = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Inpharm.MedicDiction$Op (������ ������� ����������� ��������) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Inpharm_opMedicDiction

class function Tkw_Inpharm_opMedicDiction.GetWordNameForRegister: AnsiString;
begin
 Result := '���::������_�������_�����������_��������';
end;//Tkw_Inpharm_opMedicDiction.GetWordNameForRegister

class function Tkw_Inpharm_opMedicDiction.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Inpharm_MedicDiction;
end;//Tkw_Inpharm_opMedicDiction.GetModuleOperationCode

initialization
 Tkw_Inpharm_opMedicDiction.RegisterInEngine;
 {* ����������� Tkw_Inpharm_opMedicDiction }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
