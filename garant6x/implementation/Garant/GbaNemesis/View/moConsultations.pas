unit moConsultations;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/moConsultations.pas"
// �����: 25.09.2009 21:16
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMUseCaseRealization::Class>> F1 ���������������� �������::Consultation::Consultations$UC
//
// ������������
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
  Consultation_Module
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
Tmo_Consultations = {final formspack} class(TConsultationModule)
 {* ������������ }
end;//Tmo_Consultations
{$IfEnd} //not Admin AND not Monitorings

implementation

end.