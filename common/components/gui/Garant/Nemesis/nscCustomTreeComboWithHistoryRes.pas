unit nscCustomTreeComboWithHistoryRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Nemesis"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Nemesis/nscCustomTreeComboWithHistoryRes.pas"
// �����: 10.03.2010 22:09
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For F1::Nemesis::Editor::nscCustomTreeComboWithHistoryRes
//
// ������� ��� TnscCustomTreeComboWithHistory
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
  { ������������ ������ MiscMessages }
 str_nsc_CloseHyperlinkText : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_CloseHyperlinkText'; rValue : '�������');
  { '�������' }
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  l3MessageID
  ;

{$IfEnd} //Nemesis

initialization
{$If defined(Nemesis)}
// ������������� str_nsc_CloseHyperlinkText
 str_nsc_CloseHyperlinkText.Init;
{$IfEnd} //Nemesis

end.