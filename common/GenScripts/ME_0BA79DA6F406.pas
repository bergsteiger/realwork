unit kw_Common_opPageSetup;
 {* ����� ������� ��� ������ �������� ������ Common.PageSetup (���� ��������� ��������...) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\kw_Common_opPageSetup.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Common_opPageSetup" MUID: (0BA79DA6F406)

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
 Tkw_Common_opPageSetup = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Common.PageSetup (���� ��������� ��������...) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Common_opPageSetup

class function Tkw_Common_opPageSetup.GetWordNameForRegister: AnsiString;
begin
 Result := '���::����_���������_��������...';
end;//Tkw_Common_opPageSetup.GetWordNameForRegister

class function Tkw_Common_opPageSetup.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Common_PageSetup;
end;//Tkw_Common_opPageSetup.GetModuleOperationCode

initialization
 Tkw_Common_opPageSetup.RegisterInEngine;
 {* ����������� Tkw_Common_opPageSetup }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
