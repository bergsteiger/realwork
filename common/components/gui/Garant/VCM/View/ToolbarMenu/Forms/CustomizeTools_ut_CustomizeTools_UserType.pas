unit CustomizeTools_ut_CustomizeTools_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VCM/View/ToolbarMenu/Forms/CustomizeTools_ut_CustomizeTools_UserType.pas"
// �����: 13.09.2010 19:27
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> Shared Delphi Operations::VCMCustomization::View::ToolbarMenu::PrimToolbarMenu::CustomizeTools::ut_CustomizeTools
//
// CustomizeTools
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmUserControls
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
    { ��������� ��� ���� ����� ut_CustomizeTools }
   ut_CustomizeToolsName = 'ut_CustomizeTools';
    { ��������� ������������� ����������������� ���� "CustomizeTools" }
   ut_CustomizeTools = TvcmUserType(0);
    { CustomizeTools }
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
{$If not defined(NoScripts) AND not defined(NoVCM)}
type
   Tkw_FormUserType_ut_CustomizeTools = {final scriptword} class(TtfwInteger)
    {* ����� ������� ��� ���� ����� ut_CustomizeTools }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_CustomizeTools
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}

// start class Tkw_FormUserType_ut_CustomizeTools

class function Tkw_FormUserType_ut_CustomizeTools.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::ut_CustomizeTools';
end;//Tkw_FormUserType_ut_CustomizeTools.GetWordNameForRegister

function Tkw_FormUserType_ut_CustomizeTools.GetInteger: Integer;
 {-}
begin
 Result := ut_CustomizeTools;
end;//Tkw_FormUserType_ut_CustomizeTools.GetInteger

{$IfEnd} //not NoScripts AND not NoVCM
{$IfEnd} //not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_FormUserType_ut_CustomizeTools
 Tkw_FormUserType_ut_CustomizeTools.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.