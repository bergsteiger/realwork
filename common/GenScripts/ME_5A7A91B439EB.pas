unit kw_ToolbarMenu_opAvailableOperations;
 {* ����� ������� ��� ������ �������� ������ ToolbarMenu.AvailableOperations (��������� ������� ��������� ��������...) }

// ������: "w:\common\components\gui\Garant\VCM\View\ToolbarMenu\kw_ToolbarMenu_opAvailableOperations.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_ToolbarMenu_opAvailableOperations" MUID: (5A7A91B439EB)

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
 Tkw_ToolbarMenu_opAvailableOperations = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ ToolbarMenu.AvailableOperations (��������� ������� ��������� ��������...) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_ToolbarMenu_opAvailableOperations

class function Tkw_ToolbarMenu_opAvailableOperations.GetWordNameForRegister: AnsiString;
begin
 Result := '���::���������_�������_���������_��������...';
end;//Tkw_ToolbarMenu_opAvailableOperations.GetWordNameForRegister

class function Tkw_ToolbarMenu_opAvailableOperations.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_ToolbarMenu_AvailableOperations;
end;//Tkw_ToolbarMenu_opAvailableOperations.GetModuleOperationCode

initialization
 Tkw_ToolbarMenu_opAvailableOperations.RegisterInEngine;
 {* ����������� Tkw_ToolbarMenu_opAvailableOperations }
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts)

end.
