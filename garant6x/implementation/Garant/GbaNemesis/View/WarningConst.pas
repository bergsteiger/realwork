unit WarningConst;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/WarningConst.pas"
// �����: 18.04.2011 17:31
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Core::Base Operations::View::Common::WarningConst
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
  l3StringIDEx
  ;

var
  { ������������ ������ WarningConst }
 str_wgJurorCommentHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgJurorCommentHint'; rValue : '�������� � ������������� �������');
  { '�������� � ������������� �������' }
 str_wgTimeMachineOffHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgTimeMachineOffHint'; rValue : '������ ������� ����� ���������, � ����� ��������� ����� ����������� � ���������� ��������');
  { '������ ������� ����� ���������, � ����� ��������� ����� ����������� � ���������� ��������' }
 str_wgNotShureWarningHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgNotShureWarningHint'; rValue : '������ �������� ������ �������� ��������� �� ����� ���� ��������� ����������');
  { '������ �������� ������ �������� ��������� �� ����� ���� ��������� ����������' }
 str_wgReferenceHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgReferenceHint'; rValue : '������ �� ������� � ���������');
  { '������ �� ������� � ���������' }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3MessageID
  ;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_wgJurorCommentHint
 str_wgJurorCommentHint.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_wgTimeMachineOffHint
 str_wgTimeMachineOffHint.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_wgNotShureWarningHint
 str_wgNotShureWarningHint.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_wgReferenceHint
 str_wgReferenceHint.Init;
{$IfEnd} //not Admin AND not Monitorings

end.