unit l3FrameLine;

interface

uses
 l3IntfUses
 , l3Const
 , l3CProtoObject
 , l3Interfaces
 , l3ProtoDataContainer
 , l3InternalInterfaces
;

type
 Tl3FrameLinePrim = class(Tl3CProtoObject)
  {* Это чтобы избежать Tl3FrameLine "[Error] l3FrameLine.pas(40): Type 'Tl3FrameLine' is not yet completely defined" }
  procedure ChangeLine(aSource: Tl3FrameLinePrim;
   aDest: Tl3FrameLinePrim);
   {* Сменить линию }
 end;//Tl3FrameLinePrim
 
 Tl3LinePart = object
  {* Массив отрезков }
 end;//Tl3LinePart
 
 {$Define l3Items_NoSort}
 
 Tl3LineParts = class(Tl3ProtoDataContainer)
  {* Отрезок }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tl3LineParts
 
 Tl3FrameLine = class(Tl3FrameLinePrim)
  {* Выравнивающая линия }
  procedure AssignData(aValue: Tl3FrameLine);
   {* Копируем данные об объекте }
  procedure DrawLine(const aCanvas: Il3Canvas;
   const aColorArray: Tl3LinesColorArray;
   aVert: Boolean;
   aWidth: Integer);
   {* Нарисовать линию }
  procedure AddBounds(aMinBound: Tl3FrameLine;
   aMaxBound: Tl3FrameLine;
   aColor: Integer;
   aLinePartType: Tl3LinePartDrawType);
   {* Добавляет границы для отрезка линии и корректирует её видимость }
  procedure Create(aLineCoordinate: Integer);
  procedure CheckCoordinate(aMinBound: Integer;
   aMaxBound: Integer);
   {* Функция проверяющая лежит находится ли коррдината линии в заданных пределах и если находится, то линия будет выравнена при следующем вызове AlignBoundary (используется для выравнивания нижних границ ячейек по нижней границе строки) }
  function GetBoundsArray: Tl3LineParts;
  procedure ChangeLine(aSource: Tl3FrameLinePrim;
   aDest: Tl3FrameLinePrim);
   {* Сменить линию }
 end;//Tl3FrameLine
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 , l3Units
 , Windows
 , l3UnitsTools
;

end.
