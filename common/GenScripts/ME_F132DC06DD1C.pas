unit kw_InternetAgent_opInternetAgent;
 {* ����� ������� ��� ������ �������� ������ InternetAgent.InternetAgent (��������-����� ������� ������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\kw_InternetAgent_opInternetAgent.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_InternetAgent_opInternetAgent" MUID: (F132DC06DD1C)

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
 Tkw_InternetAgent_opInternetAgent = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ InternetAgent.InternetAgent (��������-����� ������� ������) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_InternetAgent_opInternetAgent

class function Tkw_InternetAgent_opInternetAgent.GetWordNameForRegister: AnsiString;
begin
 Result := '���::��������-�����_�������_������';
end;//Tkw_InternetAgent_opInternetAgent.GetWordNameForRegister

class function Tkw_InternetAgent_opInternetAgent.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_InternetAgent_InternetAgent;
end;//Tkw_InternetAgent_opInternetAgent.GetModuleOperationCode

initialization
 Tkw_InternetAgent_opInternetAgent.RegisterInEngine;
 {* ����������� Tkw_InternetAgent_opInternetAgent }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
