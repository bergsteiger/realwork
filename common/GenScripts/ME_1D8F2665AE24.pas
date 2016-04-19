unit kw_Common_opOpenRubricator;
 {* ����� ������� ��� ������ �������� ������ Common.OpenRubricator (���� �������� ���������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\kw_Common_opOpenRubricator.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Common_opOpenRubricator" MUID: (1D8F2665AE24)

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
 Tkw_Common_opOpenRubricator = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Common.OpenRubricator (���� �������� ���������) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Common_opOpenRubricator

class function Tkw_Common_opOpenRubricator.GetWordNameForRegister: AnsiString;
begin
 Result := '���::����_��������_���������';
end;//Tkw_Common_opOpenRubricator.GetWordNameForRegister

class function Tkw_Common_opOpenRubricator.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Common_OpenRubricator;
end;//Tkw_Common_opOpenRubricator.GetModuleOperationCode

initialization
 Tkw_Common_opOpenRubricator.RegisterInEngine;
 {* ����������� Tkw_Common_opOpenRubricator }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
