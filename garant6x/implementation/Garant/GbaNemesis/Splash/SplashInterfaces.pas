unit SplashInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Splash"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Splash/SplashInterfaces.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Core::Splash::Splash::SplashInterfaces
//
// ��������� ��� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
type
 InsSplashClient = interface(IUnknown)
  {* ������������ ������.
������� ������ ��� ������� � ��������� ���.
����� ����������� ������� �������, ��� ����� ��� �� ���������� �����. }
   ['{6DE59664-EC43-42E5-AE95-A2465CF37006}']
 end;//InsSplashClient
{$IfEnd} //not Admin AND not Monitorings

implementation

end.