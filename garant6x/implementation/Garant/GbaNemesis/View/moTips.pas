unit moTips;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// �����: �������� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/moTips.pas"
// �����: 2008/02/20 11:00:21
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMUseCaseRealization::Class>> F1 ������������ ��������::DayTips::Tips
//
// ����� ���
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
  DayTips_Module
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
Tmo_Tips = {final formspack} class(TDayTipsModule)
 {* ����� ��� }
end;//Tmo_Tips
{$IfEnd} //not Admin AND not Monitorings

implementation

end.