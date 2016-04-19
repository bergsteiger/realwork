unit kw_Diction_opOpenDict;
 {* ����� ������� ��� ������ �������� ������ Diction.OpenDict (�������� ������� �������� �������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\kw_Diction_opOpenDict.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Diction_opOpenDict" MUID: (BEB9AA7B4638)

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
 Tkw_Diction_opOpenDict = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Diction.OpenDict (�������� ������� �������� �������) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Diction_opOpenDict

class function Tkw_Diction_opOpenDict.GetWordNameForRegister: AnsiString;
begin
 Result := '���::��������_�������_��������_�������';
end;//Tkw_Diction_opOpenDict.GetWordNameForRegister

class function Tkw_Diction_opOpenDict.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Diction_OpenDict;
end;//Tkw_Diction_opOpenDict.GetModuleOperationCode

initialization
 Tkw_Diction_opOpenDict.RegisterInEngine;
 {* ����������� Tkw_Diction_opOpenDict }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
