unit kw_Common_opOpenMainMenuByButton;
 {* ����� ������� ��� ������ �������� ������ Common.OpenMainMenuByButton (���� �������� ���� ������� ������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\kw_Common_opOpenMainMenuByButton.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Common_opOpenMainMenuByButton" MUID: (4F966167879D)

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
 Tkw_Common_opOpenMainMenuByButton = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Common.OpenMainMenuByButton (���� �������� ���� ������� ������) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Common_opOpenMainMenuByButton

class function Tkw_Common_opOpenMainMenuByButton.GetWordNameForRegister: AnsiString;
begin
 Result := '���::����_��������_����_�������_������';
end;//Tkw_Common_opOpenMainMenuByButton.GetWordNameForRegister

class function Tkw_Common_opOpenMainMenuByButton.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Common_OpenMainMenuByButton;
end;//Tkw_Common_opOpenMainMenuByButton.GetModuleOperationCode

initialization
 Tkw_Common_opOpenMainMenuByButton.RegisterInEngine;
 {* ����������� Tkw_Common_opOpenMainMenuByButton }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
