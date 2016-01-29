unit nscTreeViewRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Nemesis"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Nemesis/nscTreeViewRes.pas"
// �����: 10.03.2010 20:52
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For F1::Nemesis::Tree::nscTreeViewRes
//
// ������� ��� TnscTreeView
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
  { ������������ ������ nscMultiStroke }
 str_nsc_WrapHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_WrapHint'; rValue : '�������� ������� �� ������');
  { '�������� ������� �� ������' }
 str_nsc_UnwrapHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_UnwrapHint'; rValue : '��������� ������� �� ������');
  { '��������� ������� �� ������' }

const
  { ����� �������������� �������������� ����� nscMultiStroke }
 nscMultiStrokeMap : array [Boolean] of Pl3StringIDEx = (
  @str_nsc_WrapHint
  , @str_nsc_UnwrapHint
 );//nscMultiStrokeMap
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  l3MessageID
  ;

{$IfEnd} //Nemesis

initialization
{$If defined(Nemesis)}
// ������������� str_nsc_WrapHint
 str_nsc_WrapHint.Init;
{$IfEnd} //Nemesis
{$If defined(Nemesis)}
// ������������� str_nsc_UnwrapHint
 str_nsc_UnwrapHint.Init;
{$IfEnd} //Nemesis

end.