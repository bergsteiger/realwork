unit l3FrameObject;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , l3Interfaces
 , l3CoordinateMap
 , l3Units
 , l3InternalInterfaces
;

type
 Tl3FrameObject = class(Tl3CProtoObject)
  {* ������ � ������ }
  procedure Create(aFrameID: Integer;
   const aColorArray: Tl3LinesColorArray);
  procedure AddFrame(const aFrame: Tl3Frame;
   const aFrameRect: Tl3Rect;
   anAnalizeType: Tl3FrameAnalizeType);
   {* ������ ����� (�������� ���� ��� ��������� ����� ��� ������� �����) }
  procedure AlignBoundary(const aFrame: Tl3Frame;
   anIsSingle: Boolean);
   {* ��������� ������������� ����������� - ������������� ��� ����� �� aStart 
         �� aFinish �� �������� Finish }
  procedure FinishFrameObject(aAlignValue: Integer);
   {* ������ ��� ��������� "�������" �������� � ������� - ������ }
  procedure DrawLines(const aCanvas: Il3Canvas);
   {* ���������� ����������� ����� }
  function GetAlignData: Il3IntegerList;
   {* �������� ������ � ������������ }
  procedure SetAlignData(const aData: Il3IntegerList);
   {* ��������� ���������� � ������������ }
  procedure Clear;
   {* �������� ����� ��� �������� �������. }
  function GetLines(aVertical: Boolean): Tl3CoordinateMap;
  function GetColorArray: Tl3LinesColorArray;
 end;//Tl3FrameObject
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3FrameLine
 , l3MinMax
;

end.
