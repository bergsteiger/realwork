unit CustomizeToolsKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VCM/View/ToolbarMenu/CustomizeToolsKeywordsPack.pas"
// �����: 13.09.2010 18:24
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> Shared Delphi Operations::VCMCustomization::View::ToolbarMenu::PrimToolbarMenu::CustomizeToolsKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� CustomizeTools
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
  CustomizeTools_Form,
  tfwControlString
  ;

{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes
  ;

type
  Tkw_Form_CustomizeTools = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� CustomizeTools
----
*������ �������������*:
[code]
'aControl' �����::CustomizeTools TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Form_CustomizeTools

// start class Tkw_Form_CustomizeTools

class function Tkw_Form_CustomizeTools.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::CustomizeTools';
end;//Tkw_Form_CustomizeTools.GetWordNameForRegister

function Tkw_Form_CustomizeTools.GetString: AnsiString;
 {-}
begin
 Result := 'CustomizeToolsForm';
end;//Tkw_Form_CustomizeTools.GetString

class procedure Tkw_Form_CustomizeTools.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TCustomizeToolsForm);
end;//Tkw_Form_CustomizeTools.RegisterInEngine
{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_Form_CustomizeTools
 Tkw_Form_CustomizeTools.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.