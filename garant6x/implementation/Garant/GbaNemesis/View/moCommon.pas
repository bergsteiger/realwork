unit moCommon;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// �����: ������ �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/moCommon.pas"
// �����: 2003/05/23 14:19:16
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> F1 Core::Common::Common$FP
//
// ����
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
  PrimF1Common_Module
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
Tmo_Common = {final formspack} class(TPrimF1CommonModule)
 {* ���� }
end;//Tmo_Common
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsDataExchangeRealization
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings
end.