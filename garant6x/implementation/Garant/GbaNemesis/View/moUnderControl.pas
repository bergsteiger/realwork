unit moUnderControl;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/moUnderControl.pas"
// �����: 29.10.2010 17:06
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMUseCaseRealization::Class>> F1 ������ � ���������� � ������� ����������::UnderControl::UnderControl$UC
//
// ��������� �� ��������
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
  UnderControl_Module
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
Tmo_UnderControl = {final formspack} class(TUnderControlModule)
 {* ��������� �� �������� }
end;//Tmo_UnderControl
{$IfEnd} //not Admin AND not Monitorings

implementation

end.