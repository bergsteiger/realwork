unit kw_ToolbarMenu_opCustomize;
 {* ����� ������� ��� ������ �������� ������ ToolbarMenu.Customize (��������� ������� ���������...) }

// ������: "w:\common\components\gui\Garant\VCM\View\ToolbarMenu\kw_ToolbarMenu_opCustomize.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_ToolbarMenu_opCustomize" MUID: (DD15B59C2A3E)

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
 Tkw_ToolbarMenu_opCustomize = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ ToolbarMenu.Customize (��������� ������� ���������...) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_ToolbarMenu_opCustomize

class function Tkw_ToolbarMenu_opCustomize.GetWordNameForRegister: AnsiString;
begin
 Result := '���::���������_�������_���������...';
end;//Tkw_ToolbarMenu_opCustomize.GetWordNameForRegister

class function Tkw_ToolbarMenu_opCustomize.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_ToolbarMenu_Customize;
end;//Tkw_ToolbarMenu_opCustomize.GetModuleOperationCode

initialization
 Tkw_ToolbarMenu_opCustomize.RegisterInEngine;
 {* ����������� Tkw_ToolbarMenu_opCustomize }
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts)

end.
