unit moSettings;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/moSettings.pas"
// �����: 24.09.2009 15:51
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMUseCaseRealization::Class>> F1 �������� ����������::Settings::Settings
//
// ���������
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
  Settings_Module
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
Tmo_Settings = {final formspack} class(TSettingsModule)
 {* ��������� }
end;//Tmo_Settings
{$IfEnd} //not Admin AND not Monitorings

implementation

end.