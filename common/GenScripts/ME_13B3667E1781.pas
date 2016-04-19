unit kw_TasksPanelMenu_opCustomize;
 {* ����� ������� ��� ������ �������� ������ TasksPanelMenu.Customize (��������� ������ ����� ���������...) }

// ������: "w:\common\components\gui\Garant\VCM\View\TasksPanel\kw_TasksPanelMenu_opCustomize.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_TasksPanelMenu_opCustomize" MUID: (13B3667E1781)

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
 Tkw_TasksPanelMenu_opCustomize = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ TasksPanelMenu.Customize (��������� ������ ����� ���������...) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_TasksPanelMenu_opCustomize

class function Tkw_TasksPanelMenu_opCustomize.GetWordNameForRegister: AnsiString;
begin
 Result := '���::���������_������_�����_���������...';
end;//Tkw_TasksPanelMenu_opCustomize.GetWordNameForRegister

class function Tkw_TasksPanelMenu_opCustomize.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_TasksPanelMenu_Customize;
end;//Tkw_TasksPanelMenu_opCustomize.GetModuleOperationCode

initialization
 Tkw_TasksPanelMenu_opCustomize.RegisterInEngine;
 {* ����������� Tkw_TasksPanelMenu_opCustomize }
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts)

end.
