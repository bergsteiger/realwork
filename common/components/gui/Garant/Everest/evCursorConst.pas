unit evCursorConst;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evCursorConst.pas"
// �����: 18.12.2002 17:23
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::Cursors::evCursorConst
//
// ��������� ��� ������ � ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evUseVisibleCursors)}
const
  { Cursor Positions }
 ev_cpTop = -1;
 ev_cpBottom = -2;
 ev_cpNull = -3;
 ev_cpAtEnd = High(Integer);
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}
{$IfEnd} //evUseVisibleCursors
end.