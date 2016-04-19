unit kw_Common_get_navigator;
 {* ����� ������� ��� ������ �������� ������ Common.get_navigator$Op (���� ���� (�������)) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\kw_Common_get_navigator.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Common_get_navigator" MUID: (DD1F5844B1F3)

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
 Tkw_Common_get_navigator = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Common.get_navigator$Op (���� ���� (�������)) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Common_get_navigator

class function Tkw_Common_get_navigator.GetWordNameForRegister: AnsiString;
begin
 Result := '���::����_����_(�������)';
end;//Tkw_Common_get_navigator.GetWordNameForRegister

class function Tkw_Common_get_navigator.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Common_get_navigator;
end;//Tkw_Common_get_navigator.GetModuleOperationCode

initialization
 Tkw_Common_get_navigator.RegisterInEngine;
 {* ����������� Tkw_Common_get_navigator }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
