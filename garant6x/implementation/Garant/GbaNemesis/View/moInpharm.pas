unit moInpharm;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// �����: �������� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/moInpharm.pas"
// �����: 2008/03/12 11:01:35
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMUseCaseRealization::Class>> F1 ���������� ��������::Inpharm::Inpharm
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
  Inpharm_Module
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
Tmo_Inpharm = {final formspack} class(TInpharmModule)
 {* ������ }
end;//Tmo_Inpharm
{$IfEnd} //not Admin AND not Monitorings

implementation

end.