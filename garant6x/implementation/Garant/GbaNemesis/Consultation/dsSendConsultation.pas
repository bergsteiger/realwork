unit dsSendConsultation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Consultation"
// �����: ������� �.�
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Consultation/dsSendConsultation.pas"
// �����: 06.04.2006 17.27
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 ���������������� �������::Consultation::Consultation::Consultation::TdsSendConsultation
//
// ������ ������ "������ �� ������������"
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
  dsQuery
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdsSendConsultation = {vac} class(TdsQuery)
  {* ������ ������ "������ �� ������������" }
 end;//TdsSendConsultation
{$IfEnd} //not Admin AND not Monitorings

implementation

end.