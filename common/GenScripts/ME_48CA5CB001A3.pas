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
  {* Объект группирующий горизонтальные или вертикальные выравнивающие линии. }
  procedure Create(anOrientation: Boolean);
  procedure DrawLines(const aCanvas: Il3Canvas;
   const aColorArray: Tl3LinesColorArray;
   aWidth: Integer);
   {* Отрисовать все элементы для объекта с anObjectID }
  function AddLine(aMapValue: Integer;
   aLine: Tl3FrameLine;
   aToBuffer: Boolean): Tl3FrameLine;
   {* Добавляет значение в мапу }
  procedure AlignBoundary(aStart: Integer;
   aFinish: Integer;
   aDestList: Tl3CoordinateMap);
   {* Применить выравнивающие ограничения - выравниванием все линии от aStart
         до aFinish по значению aFinish. }
  procedure AlignAllLines(aValue: Integer;
   aDestList: Tl3CoordinateMap);
   {* Выравнять все линии по значению aValue (используется для выравнивания отсвшихся горизонтальных линий) }
  procedure CheckLine(aMinBound: Integer;
   aMaxBound: Integer);
   {* Вызывает CheckCoordinate для всех отрезков. }
  procedure ClearPrev(aClearAll: Boolean);
   {* Сбрасывает индекс предыдущего }
  function GetAlignData: Il3IntegerList;
   {* Получить данные о выравнивании }
  procedure SetAlignData(const aData: Il3IntegerList);
   {* Сохранить данные о выравнивании }
  procedure SavePrev;
   {* Запомнить PrevIndex для последующего применения. }
  procedure Clear;
   {* Очищает данные о линиях. }
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
