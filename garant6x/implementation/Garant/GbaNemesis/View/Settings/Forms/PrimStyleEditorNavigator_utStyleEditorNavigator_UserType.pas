unit PrimStyleEditorNavigator_utStyleEditorNavigator_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/Forms/PrimStyleEditorNavigator_utStyleEditorNavigator_UserType.pas"
// �����: 28.10.2009 14:01
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 �������� ����������::Settings::View::Settings::PrimStyleEditorNavigator::utStyleEditorNavigator
//
// ������ ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� utStyleEditorNavigator }
  utStyleEditorNavigatorName = 'utStyleEditorNavigator';
   { ��������� ������������� ����������������� ���� "������ ������" }
  utStyleEditorNavigator = TvcmUserType(0);
   { ������ ������ }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utStyleEditorNavigator = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utStyleEditorNavigator }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utStyleEditorNavigator
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utStyleEditorNavigator

class function Tkw_FormUserType_utStyleEditorNavigator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utStyleEditorNavigator';
end;//Tkw_FormUserType_utStyleEditorNavigator.GetWordNameForRegister

function Tkw_FormUserType_utStyleEditorNavigator.GetInteger: Integer;
 {-}
begin
 Result := utStyleEditorNavigator;
end;//Tkw_FormUserType_utStyleEditorNavigator.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utStyleEditorNavigator
 Tkw_FormUserType_utStyleEditorNavigator.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.