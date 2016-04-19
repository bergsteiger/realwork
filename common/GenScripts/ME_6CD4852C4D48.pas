unit kw_Folders_opMyInformation;
 {* ����� ������� ��� ������ �������� ������ Folders.MyInformation (����� ��� ����������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\kw_Folders_opMyInformation.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Folders_opMyInformation" MUID: (6CD4852C4D48)

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
 Tkw_Folders_opMyInformation = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Folders.MyInformation (����� ��� ����������) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Folders_opMyInformation

class function Tkw_Folders_opMyInformation.GetWordNameForRegister: AnsiString;
begin
 Result := '���::�����_���_����������';
end;//Tkw_Folders_opMyInformation.GetWordNameForRegister

class function Tkw_Folders_opMyInformation.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Folders_MyInformation;
end;//Tkw_Folders_opMyInformation.GetModuleOperationCode

initialization
 Tkw_Folders_opMyInformation.RegisterInEngine;
 {* ����������� Tkw_Folders_opMyInformation }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
