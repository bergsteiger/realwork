unit kw_Common_opComplectInfo;
 {* ����� ������� ��� ������ �������� ������ Common.ComplectInfo (���� ���������� � ���������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\kw_Common_opComplectInfo.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Common_opComplectInfo" MUID: (106F0B324556)

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
 Tkw_Common_opComplectInfo = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Common.ComplectInfo (���� ���������� � ���������) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Common_opComplectInfo

class function Tkw_Common_opComplectInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '���::����_����������_�_���������';
end;//Tkw_Common_opComplectInfo.GetWordNameForRegister

class function Tkw_Common_opComplectInfo.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Common_ComplectInfo;
end;//Tkw_Common_opComplectInfo.GetModuleOperationCode

initialization
 Tkw_Common_opComplectInfo.RegisterInEngine;
 {* ����������� Tkw_Common_opComplectInfo }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
