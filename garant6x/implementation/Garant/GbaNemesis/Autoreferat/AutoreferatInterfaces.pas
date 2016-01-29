unit AutoreferatInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Autoreferat"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Autoreferat/AutoreferatInterfaces.pas"
// �����: 27.11.2008 23:40
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ControllerInterfaces::Category>> F1 ���������������� �������::Autoreferat::Autoreferat::AutoreferatInterfaces
//
// ���������� ��� ������ � ��������� ������
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
  SearchInterfaces,
  vcmInterfaces {a},
  vcmControllers {a}
  ;

type
 IdsNewsLine = interface(IvcmViewAreaController)
  {* ��������� ����� }
   ['{34D4F64F-ABFB-48BE-B04F-DD609BB32DAB}']
 end;//IdsNewsLine

 IsdsAutoreferat = interface(IsdsBaseDocument)
   ['{22A93E6D-D6A0-4D95-BA27-C6A9CFBBF259}']
   function pm_GetMakeNewsLineFakeDS: IdsNewsLine;
   property MakeNewsLineFakeDS: IdsNewsLine
     read pm_GetMakeNewsLineFakeDS;
     {* ��������� ������ ������ ��������� ����� }
 end;//IsdsAutoreferat
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

end.