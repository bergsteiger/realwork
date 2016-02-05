unit NOT_FINISHED_l3Const;
 {* ��������� ���������� L3. }

// ������: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3Const.pas"
// ���������: "Interfaces"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
;

const
 rs_LongOperation = '����������� ���������� ��������...';
 l3NilLong = High(Longint);
  {* NULL ��� �����. }
 l3Inch = 1440;
  {* ����. }
 l3mmInInch = 254;
  {* ����� ����������� � �����. }
 l3FontIndexDelta = l3Inch div 16;
 l3Epsilon = l3Inch div 120;
  {* ������ ��������. }
 l3AlingDelta = l3Epsilon * 4;
  {* ������� ������������ (�������� ������������ �� ������� �� ������ ������� ��������� �������). }
 l3ShapeNil = Low(Longint) div 2;
  {* NULL ��� ��������� �������� ��������. }
 l3NULLStr = '<NULL>';

implementation

uses
 l3ImplUses
;

end.
