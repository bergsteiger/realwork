unit kw_ToolbarMenu_opIconsSize;
 {* ����� ������� ��� ������ �������� ������ ToolbarMenu.IconsSize (��������� ������� ������ ������) }

// ������: "w:\common\components\gui\Garant\VCM\View\ToolbarMenu\kw_ToolbarMenu_opIconsSize.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_ToolbarMenu_opIconsSize" MUID: (B38E374B69AD)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwModuleOperationWord
 , vcmExternalInterfaces
 , StdRes
;

type
 Tkw_ToolbarMenu_opIconsSize = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ ToolbarMenu.IconsSize (��������� ������� ������ ������) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_ToolbarMenu_opIconsSize

class function Tkw_ToolbarMenu_opIconsSize.GetWordNameForRegister: AnsiString;
begin
 Result := '���::���������_�������_������_������';
end;//Tkw_ToolbarMenu_opIconsSize.GetWordNameForRegister

class function Tkw_ToolbarMenu_opIconsSize.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_ToolbarMenu_IconsSize;
end;//Tkw_ToolbarMenu_opIconsSize.GetModuleOperationCode

initialization
 Tkw_ToolbarMenu_opIconsSize.RegisterInEngine;
 {* ����������� Tkw_ToolbarMenu_opIconsSize }
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts)

end.
