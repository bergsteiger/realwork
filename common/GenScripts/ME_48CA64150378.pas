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
  {* Объект с рамкой }
  procedure Create(aFrameID: Integer;
   const aColorArray: Tl3LinesColorArray);
  procedure AddFrame(const aFrame: Tl3Frame;
   const aFrameRect: Tl3Rect;
   anAnalizeType: Tl3FrameAnalizeType);
   {* Учесть рамку (продлить одну или несколько линий или создать новую) }
  procedure AlignBoundary(const aFrame: Tl3Frame;
   anIsSingle: Boolean);
   {* Применить выравнивающие ограничения - выравниванием все линии от aStart 
         до aFinish по значению Finish }
  procedure FinishFrameObject(aAlignValue: Integer);
   {* Скобки для отрисовки "сложных" объектов с рамками - таблиц }
  procedure DrawLines(const aCanvas: Il3Canvas);
   {* Нарисовать выровненные рамки }
  function GetAlignData: Il3IntegerList;
   {* Получить данный о выравнивании }
  procedure SetAlignData(const aData: Il3IntegerList);
   {* Сохранить информацию о выравнивании }
  procedure Clear;
   {* Очистить линии для текущего объекта. }
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
