unit kw_Inpharm_opDrugList;
 {* ����� ������� ��� ������ �������� ������ Inpharm.DrugList$Op (������ ������ ����������� ����������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\kw_Inpharm_opDrugList.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Inpharm_opDrugList" MUID: (2911C76291C9)

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
 Tkw_Inpharm_opDrugList = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Inpharm.DrugList$Op (������ ������ ����������� ����������) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Inpharm_opDrugList

class function Tkw_Inpharm_opDrugList.GetWordNameForRegister: AnsiString;
begin
 Result := '���::������_������_�����������_����������';
end;//Tkw_Inpharm_opDrugList.GetWordNameForRegister

class function Tkw_Inpharm_opDrugList.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Inpharm_DrugList;
end;//Tkw_Inpharm_opDrugList.GetModuleOperationCode

initialization
 Tkw_Inpharm_opDrugList.RegisterInEngine;
 {* ����������� Tkw_Inpharm_opDrugList }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
