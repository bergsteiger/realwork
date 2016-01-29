unit l3CoordinateMap;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , l3FrameLineList
 , l3FrameLine
 , l3Interfaces
 , l3InternalInterfaces
;

type
 Tl3CoordinateMap = class(Tl3CProtoObject)
  {* ������ ������������ �������������� ��� ������������ ������������� �����. }
  procedure Create(anOrientation: Boolean);
  procedure DrawLines(const aCanvas: Il3Canvas;
   const aColorArray: Tl3LinesColorArray;
   aWidth: Integer);
   {* ���������� ��� �������� ��� ������� � anObjectID }
  function AddLine(aMapValue: Integer;
   aLine: Tl3FrameLine;
   aToBuffer: Boolean): Tl3FrameLine;
   {* ��������� �������� � ���� }
  procedure AlignBoundary(aStart: Integer;
   aFinish: Integer;
   aDestList: Tl3CoordinateMap);
   {* ��������� ������������� ����������� - ������������� ��� ����� �� aStart
         �� aFinish �� �������� aFinish. }
  procedure AlignAllLines(aValue: Integer;
   aDestList: Tl3CoordinateMap);
   {* ��������� ��� ����� �� �������� aValue (������������ ��� ������������ ��������� �������������� �����) }
  procedure CheckLine(aMinBound: Integer;
   aMaxBound: Integer);
   {* �������� CheckCoordinate ��� ���� ��������. }
  procedure ClearPrev(aClearAll: Boolean);
   {* ���������� ������ ����������� }
  function GetAlignData: Il3IntegerList;
   {* �������� ������ � ������������ }
  procedure SetAlignData(const aData: Il3IntegerList);
   {* ��������� ������ � ������������ }
  procedure SavePrev;
   {* ��������� PrevIndex ��� ������������ ����������. }
  procedure Clear;
   {* ������� ������ � ������. }
  function GetValues: Tl3FrameLineList;
 end;//Tl3CoordinateMap
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3Types
 , l3Const
 , l3InterfacedIntegerList
 , SysUtils
 , l3UnitsTools
;

end.
