unit kw_ToolbarMenu_opAvailableOperations;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/common/components/gui/Garant/VCM/View/ToolbarMenu/kw_ToolbarMenu_opAvailableOperations.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi Operations::VCMCustomization::View::ToolbarMenu::Tkw_ToolbarMenu_opAvailableOperations
//
// ����� ������� ��� ������ �������� ������ ToolbarMenu.AvailableOperations (��������� �������
// ��������� ��������...)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  tfwModuleOperationWord,
  vcmExternalInterfaces
  ;
{$IfEnd} //not NoScripts AND not NoVCM


implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  StdRes
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}
type
 Tkw_ToolbarMenu_opAvailableOperations = {final scriptword} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ ToolbarMenu.AvailableOperations (��������� ������� ��������� ��������...) }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_ToolbarMenu_opAvailableOperations
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}

// start class Tkw_ToolbarMenu_opAvailableOperations

class function Tkw_ToolbarMenu_opAvailableOperations.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���::���������_�������_���������_��������...';
end;//Tkw_ToolbarMenu_opAvailableOperations.GetWordNameForRegister

class function Tkw_ToolbarMenu_opAvailableOperations.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_ToolbarMenu_AvailableOperations;
end;//Tkw_ToolbarMenu_opAvailableOperations.GetModuleOperationCode

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_ToolbarMenu_opAvailableOperations
 Tkw_ToolbarMenu_opAvailableOperations.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.