unit PrimSettings_cutSettings_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/Forms/PrimSettings_cutSettings_UserType.pas"
// �����: 02.10.2009 21:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 �������� ����������::Settings::View::Settings::PrimSettings::cutSettings
//
// ��������� ������������
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
   { ��������� ��� ���� ����� cutSettings }
  cutSettingsName = 'cutSettings';
   { ��������� ������������� ����������������� ���� "��������� ������������" }
  cutSettings = TvcmUserType(0);
   { ��������� ������������ }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_cutSettings = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� cutSettings }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_cutSettings
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_cutSettings

class function Tkw_FormUserType_cutSettings.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::cutSettings';
end;//Tkw_FormUserType_cutSettings.GetWordNameForRegister

function Tkw_FormUserType_cutSettings.GetInteger: Integer;
 {-}
begin
 Result := cutSettings;
end;//Tkw_FormUserType_cutSettings.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_cutSettings
 Tkw_FormUserType_cutSettings.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.