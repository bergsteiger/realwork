unit evConst;
 {* ��������� ���������� �������. }

// ������: "w:\common\components\gui\Garant\Everest\evConst.pas"
// ���������: "Interfaces"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3Units
;

const
 evEpsilon = l3Epsilon;
  {* ������ ��������. }
 evFindCellDelta = l3AlingDelta;
  {* ����������� ��� ������ ���������� �����. }
 evShapeNil = l3ShapeNil;
  {* NULL ��� ��������� �������� ��������. }
 evUndefHeight = l3ShapeNil;
 evInchMul = l3Inch;
 evCmPerInch = 2.54;
  {* ������� ����������� � �����. }
 ev_MmInInch = l3mmInInch;
  {* ����� ����������� � �����. }
 evPoint0: Tl3Point = (P: (X: 0; Y: 0));
 Point0: Tl3SPoint = (P: (X: 0; Y: 0));
 evRect0: Tl3Rect = (R: (Left: 0; Top: 0; Right: 0; Bottom: 0));
 Rect0: Tl3SRect = (R: (Left: 0; Top: 0; Right: 0; Bottom: 0));
 evRect1: Tl3Rect = (R: (Left: 0; Top: 0; Right: 1; Bottom: 1));
 Rect1: Tl3SRect = (R: (Left: 0; Top: 0; Right: 1; Bottom: 1));
 evFontIndexDelta = l3FontIndexDelta;
  {* �������� ������ ��� ������� ��� ������ �������. }
{$If NOT Defined(evRunTime)}
 evEverestPage = 'Everest Controls';
 evEverestComponentsPage = 'Everest Components';
 evReaders = 'Everest Readers';
 evWriters = 'Everest Writers';
{$IfEnd} // NOT Defined(evRunTime)

implementation

uses
 l3ImplUses
;

end.
