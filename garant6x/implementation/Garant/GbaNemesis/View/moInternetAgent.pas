unit moInternetAgent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/moInternetAgent.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMUseCaseRealization::Class>> F1 ���������� ��������::InternetAgent::InternetAgent$UC
//
// ��������-�����
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
  PrimInternetAgent_Module
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
Tmo_InternetAgent = {final formspack} class(TPrimInternetAgentModule)
 {* ��������-����� }
end;//Tmo_InternetAgent
{$IfEnd} //not Admin AND not Monitorings

implementation

end.