unit evConst;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evConst.pas"
// �����: 11.12.96
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::Everest::evConst
//
// ��������� ���������� �������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3Types,
  l3Units,
  l3Const
  ;

const
  { evL3CoreConsts }
 evEpsilon = l3Epsilon;
  { ������ ��������. }
 evFindCellDelta = l3AlingDelta;
  { ����������� ��� ������ ���������� �����. }
 evShapeNil = l3ShapeNil;
  { NULL ��� ��������� �������� ��������. }
 evUndefHeight = l3ShapeNil;
 evInchMul = l3Inch;
 evCmPerInch = 2.54;
  { ������� ����������� � �����. }
 ev_MmInInch = l3mmInInch;
  { ����� ����������� � �����. }
  { evPointConst }
 evPoint0 : Tl3Point = (P: (X: 0; Y: 0));
 Point0 : Tl3SPoint = (P: (X: 0; Y: 0));
 evRect0 : Tl3Rect = (R: (Left: 0; Top: 0; Right: 0; Bottom: 0));
 Rect0 : Tl3SRect = (R: (Left: 0; Top: 0; Right: 0; Bottom: 0));
 evRect1 : Tl3Rect = (R: (Left: 0; Top: 0; Right: 1; Bottom: 1));
 Rect1 : Tl3SRect = (R: (Left: 0; Top: 0; Right: 1; Bottom: 1));
  { evFontConst }
 evFontIndexDelta = l3FontIndexDelta;
  { �������� ������ ��� ������� ��� ������ �������. }

{$If not defined(evRunTime)}  { evPageNames }
 evEverestPage = 'Everest Controls';
 evEverestComponentsPage = 'Everest Components';
 evReaders = 'Everest Readers';
 evWriters = 'Everest Writers';
{$IfEnd} //not evRunTime

implementation

end.