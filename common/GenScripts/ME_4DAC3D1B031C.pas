unit WarningConst;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\WarningConst.pas"
// ���������: "UtilityPack"
// ������� ������: "WarningConst" MUID: (4DAC3D1B031C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ WarningConst }
 str_wgJurorCommentHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgJurorCommentHint'; rValue : '�������� � ������������� �������');
  {* '�������� � ������������� �������' }
 str_wgTimeMachineOffHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgTimeMachineOffHint'; rValue : '������ ������� ����� ���������, � ����� ��������� ����� ����������� � ���������� ��������');
  {* '������ ������� ����� ���������, � ����� ��������� ����� ����������� � ���������� ��������' }
 str_wgNotShureWarningHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgNotShureWarningHint'; rValue : '������ �������� ������ �������� ��������� �� ����� ���� ��������� ����������');
  {* '������ �������� ������ �������� ��������� �� ����� ���� ��������� ����������' }
 str_wgReferenceHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgReferenceHint'; rValue : '������ �� ������� � ���������');
  {* '������ �� ������� � ���������' }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

initialization
 str_wgJurorCommentHint.Init;
 {* ������������� str_wgJurorCommentHint }
 str_wgTimeMachineOffHint.Init;
 {* ������������� str_wgTimeMachineOffHint }
 str_wgNotShureWarningHint.Init;
 {* ������������� str_wgNotShureWarningHint }
 str_wgReferenceHint.Init;
 {* ������������� str_wgReferenceHint }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
