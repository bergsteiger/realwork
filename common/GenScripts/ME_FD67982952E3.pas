unit kw_Common_opOpenIntranet;
 {* ����� ������� ��� ������ �������� ������ Common.OpenIntranet (����) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\kw_Common_opOpenIntranet.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Common_opOpenIntranet" MUID: (FD67982952E3)

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
 Tkw_Common_opOpenIntranet = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Common.OpenIntranet (����) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Common_opOpenIntranet

class function Tkw_Common_opOpenIntranet.GetWordNameForRegister: AnsiString;
begin
 Result := '���::����_OpenIntranet';
end;//Tkw_Common_opOpenIntranet.GetWordNameForRegister

class function Tkw_Common_opOpenIntranet.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Common_OpenIntranet;
end;//Tkw_Common_opOpenIntranet.GetModuleOperationCode

initialization
 Tkw_Common_opOpenIntranet.RegisterInEngine;
 {* ����������� Tkw_Common_opOpenIntranet }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
