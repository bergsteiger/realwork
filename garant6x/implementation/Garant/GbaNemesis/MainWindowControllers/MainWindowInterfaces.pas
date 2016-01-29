unit MainWindowInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "MainWindowControllers"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/MainWindowControllers/MainWindowInterfaces.pas"
// �����: 03.05.2011 18:23
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ControllerInterfaces::Category>> F1 Core::Common::MainWindowControllers::MainWindowInterfaces
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
  DocumentAndListInterfaces,
  BaseSearchInterfaces,
  vcmInterfaces {a},
  vcmControllers {a}
  ;

type
 IsdsMainWindow = interface(IvcmUseCaseController{, InsWarningGenerator})
  {* �������� ���� }
   ['{4BABE209-5CE4-4408-B307-6EF460A071E8}']
   function pm_GetDsBaloonWarning: IdsWarning;
   property dsBaloonWarning: IdsWarning
     read pm_GetDsBaloonWarning;
  // ������ �������������� � ����������� �����������
   function As_InsWarningGenerator: InsWarningGenerator;
 end;//IsdsMainWindow
{$IfEnd} //not Admin AND not Monitorings

implementation

end.