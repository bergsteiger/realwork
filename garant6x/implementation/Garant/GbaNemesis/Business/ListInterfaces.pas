unit ListInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Business"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Business/ListInterfaces.pas"
// �����: 07.09.2009 14:34
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Core::Common::Business::ListInterfaces
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
 TbsLinkType = (
  {* ��� ������ �� ������ ��� ������. �������� ������ ���������� ���� ��� ��� ����������� ����� ������ ���������� ������� }
   ltDocument // ������� ������ ��������
 , ltList // ������� ������ ������
 );//TbsLinkType
{$IfEnd} //not Admin AND not Monitorings

implementation

end.