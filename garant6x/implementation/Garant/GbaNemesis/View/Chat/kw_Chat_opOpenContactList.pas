unit kw_Chat_opOpenContactList;
 {* ����� ������� ��� ������ �������� ������ Chat.OpenContactList (���) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\kw_Chat_opOpenContactList.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Chat_opOpenContactList" MUID: (D4640548703B)

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
 Tkw_Chat_opOpenContactList = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Chat.OpenContactList (���) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Chat_opOpenContactList

class function Tkw_Chat_opOpenContactList.GetWordNameForRegister: AnsiString;
begin
 Result := '���::���_OpenContactList';
end;//Tkw_Chat_opOpenContactList.GetWordNameForRegister

class function Tkw_Chat_opOpenContactList.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Chat_OpenContactList;
end;//Tkw_Chat_opOpenContactList.GetModuleOperationCode

initialization
 Tkw_Chat_opOpenContactList.RegisterInEngine;
 {* ����������� Tkw_Chat_opOpenContactList }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
