unit moChangesBetweenEditions;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/moChangesBetweenEditions.pas"
// �����: 24.05.2011 17:12
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMUseCaseRealization::Class>> F1 ���������������� �������::ChangesBetweenEditions::ChangesBetweenEditions
//
// �������� ������ ���������� ����������
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
  ChangesBetweenEditions_Module
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
Tmo_ChangesBetweenEditions = {final formspack} class(TChangesBetweenEditionsModule)
 {* �������� ������ ���������� ���������� }
end;//Tmo_ChangesBetweenEditions
{$IfEnd} //not Admin AND not Monitorings

implementation

end.