unit l3FrameLines;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , l3InternalInterfaces
 , l3FrameObjectList
 , l3FrameObject
 , l3Interfaces
 , l3Units
;

type
 Tl3FrameLines = class(Tl3CProtoObject, Il3FrameLines)
  {* ����������� � �������������: 
���� ����������� ������������ ��� ����������� ����� ����� ��� �� ������ 
������� (� �������� �������������� ��������� PID). ��������� ������������ 
��� ������ �� ������. ��� ������ �� ����� ������������� ���������� ��� ���� 
������, � ����� �������� ��� �� ���� ����� ���������. ����� ������������
��� ����� ��������, ������� �����, �� ���� ������������ ������ ��� ������. }
  function GetFrameObjects: Tl3FrameObjectList;
  procedure Make;
   {* ����������� }
  function InternalFrameObject(anObjID: Integer): Tl3FrameObject;
   {* ���������� ������ ��������� �� ����� }
  procedure UpdateFrameRect(const aCanvas: Il3Canvas;
   const aFrame: Tl3Frame;
   var aRect: Tl3Rect);
   {* �������� � aRect ������� ������ ����� }
  procedure StartFrameObject(anBehaviour: Tl3FrameObjectBehaviour;
   aFrameObjID: Integer;
   const aColorArray: Tl3LinesColorArray);
   {* ������ ��� ��������� "�������" �������� � ������� - ������. }
  procedure FinishFrameObject(anObjectID: Integer;
   aAlignValue: Integer);
   {* ������ ��� ��������� "�������" �������� � ������� - ������. }
  procedure AddFrame(const aCanvas: Il3Canvas;
   anObjectID: Integer;
   const aFrame: Tl3Frame;
   anAnalizeType: Tl3FrameAnalizeType);
   {* ������ ����� (�������� ���� ��� ��������� ����� ��� ������� �����). }
  procedure AlignBoundary(anObjectID: Integer;
   const aFrame: Tl3Frame;
   anIsSingle: Boolean);
   {* ��������� ������������� �����������. }
  procedure DrawAllLines(const aCanvas: Il3Canvas;
   anObjectID: Integer);
   {* ���������� ����������� �����. anObjectID = -1 �������� ��� �����, 
          ���� anObjectID > -1, �� ������� ����� ������ ��� ������ �������. 
          ���� � �������� anObjectID ���������� PID ��������� (������� � �.�.) }
  procedure DrawFrame(const aCanvas: Il3Canvas;
   const aFrame: Tl3Frame;
   const aText: Il3FrameTextPainter);
   {* ������������ �����. }
  function FinishedFO: Boolean;
   {* ���� ��������� ��������� �������. }
  function GetLineWidth(aFrameObjID: Integer): Integer;
   {* ���������� ������ ����� ��� ���������� �������. }
  function ReadAlignData(anObjectID: Integer): Il3IntegerList;
   {* ��������� ������ ������ ��� ���������� }
  procedure WriteAlignData(anObjectID: Integer;
   const aData: Il3IntegerList);
   {* �������� ������ � ������������ }
  procedure SetNeedLogging(anObjectID: Integer;
   aNeedLog: Boolean);
   {* ����� ��� ������. ���������� ���� ������� � ������������� ������ � ���. }
  procedure ClearFrameObject(aFrameObjID: Integer);
 end;//Tl3FrameLines
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3Types
 , l3MinMax
 , Windows
 , l3FrameLinesSpy
;

end.
