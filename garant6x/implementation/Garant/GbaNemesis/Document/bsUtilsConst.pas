unit bsUtilsConst;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Document"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Document/bsUtilsConst.pas"
// �����: 21.07.2011 19:03
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 ���������� ������ � ���������� � ����������� ������� ���������::F1 Document Processing::Document::Document::bsUtilsConst
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
  { ������������ ������ Local }
 str_wgReferenceHyperlinkSearchText : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgReferenceHyperlinkSearchText'; rValue : '��������� ��. � ������� � ���������');
  { '��������� ��. � ������� � ���������' }
 str_wgReferenceHyperlinkReplaceText : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgReferenceHyperlinkReplaceText'; rValue : '��������� [��. � ������� � ���������|script:��::��������_�������_�_���������|������ �� ������� � ���������]');
  { '��������� [��. � ������� � ���������|script:��::��������_�������_�_���������|������ �� ������� � ���������]' }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3MessageID
  ;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_wgReferenceHyperlinkSearchText
 str_wgReferenceHyperlinkSearchText.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_wgReferenceHyperlinkReplaceText
 str_wgReferenceHyperlinkReplaceText.Init;
{$IfEnd} //not Admin AND not Monitorings

end.