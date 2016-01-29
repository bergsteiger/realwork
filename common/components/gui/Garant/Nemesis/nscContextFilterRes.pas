unit nscContextFilterRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Nemesis"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Nemesis/nscContextFilterRes.pas"
// �����: 10.03.2010 21:16
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For F1::Nemesis::ContextFilter::nscContextFilterRes
//
// ������� ��� TnscContextFilter
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  l3StringIDEx
  ;

var
  { ������������ ������ ContextFilterMessages }
 str_nsc_LabelCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_LabelCaption'; rValue : '����������� ������');
  { '����������� ������' }
 str_nsc_ContextEmptyMessage : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_ContextEmptyMessage'; rValue : '������� ����� ��� ������ � ����������');
  { '������� ����� ��� ������ � ����������' }
 str_nsc_ButtonActiveHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_ButtonActiveHint'; rValue : '��������� ����������� ������');
  { '��������� ����������� ������' }
 str_nsc_ButtonInActiveHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_ButtonInActiveHint'; rValue : '�������� ����������� ������');
  { '�������� ����������� ������' }
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  l3MessageID
  ;

{$IfEnd} //Nemesis

initialization
{$If defined(Nemesis)}
// ������������� str_nsc_LabelCaption
 str_nsc_LabelCaption.Init;
{$IfEnd} //Nemesis
{$If defined(Nemesis)}
// ������������� str_nsc_ContextEmptyMessage
 str_nsc_ContextEmptyMessage.Init;
{$IfEnd} //Nemesis
{$If defined(Nemesis)}
// ������������� str_nsc_ButtonActiveHint
 str_nsc_ButtonActiveHint.Init;
{$IfEnd} //Nemesis
{$If defined(Nemesis)}
// ������������� str_nsc_ButtonInActiveHint
 str_nsc_ButtonInActiveHint.Init;
{$IfEnd} //Nemesis

end.