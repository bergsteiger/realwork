unit moList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/moList.pas"
// �����: 07.09.2009 15:45
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMUseCaseRealization::Class>> F1 ������ � ���������� � ������� ����������::WorkWithList::List$UC
//
// ������
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
  List_Module
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
Tmo_List = {final formspack} class(TListModule)
 {* ������ }
end;//Tmo_List
{$IfEnd} //not Admin AND not Monitorings

implementation

end.