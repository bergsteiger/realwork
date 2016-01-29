unit NOT_FINISHED_l3Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3$Domain"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3Const.pas"
// �����: 13.04.1998 14:05
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi ���������� � �������������� �����������::L3$Domain::l3Const
//
// ��������� ���������� L3.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\L3\l3Define.inc}

interface

const
  { Messages }
 rs_LongOperation = '����������� ���������� ��������...';
  { L3 Core Consts }
 l3NilLong = High(Longint);
  { NULL ��� �����. }
 l3Inch = 1440;
  { ����. }
 l3mmInInch = 254;
  { ����� ����������� � �����. }
 l3FontIndexDelta = l3Inch div 16;
 l3Epsilon = l3Inch div 120;
  { ������ ��������. }
 l3AlingDelta = l3Epsilon * 4;
  { ������� ������������ (�������� ������������ �� ������� �� ������ ������� ��������� �������). }
 l3ShapeNil = Low(Longint) div 2;
  { NULL ��� ��������� �������� ��������. }
  { Strings }
 l3NULLStr = '<NULL>';

implementation

end.