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
  {* Комментарии к использованию: 
Есть возможность отрисовывать все накопленные линии сразу или по одному 
объекту (в качестве идентификатора выступает PID). Последнее используется 
при выводе на печать. При выводе на экран накапливается информация для всех 
таблиц, а потом выводить все за один прием выводится. Можно использовать
для любых объектов, имеющих рамку, но пока используется только для таблиц. }
  function GetFrameObjects: Tl3FrameObjectList;
  procedure Make;
   {* конструктор }
  function InternalFrameObject(anObjID: Integer): Tl3FrameObject;
   {* Возвращает объект отрисовки по ключу }
  procedure UpdateFrameRect(const aCanvas: Il3Canvas;
   const aFrame: Tl3Frame;
   var aRect: Tl3Rect);
   {* Добавить к aRect отсутпы границ рамок }
  procedure StartFrameObject(anBehaviour: Tl3FrameObjectBehaviour;
   aFrameObjID: Integer;
   const aColorArray: Tl3LinesColorArray);
   {* Скобки для отрисовки "сложных" объектов с рамками - таблиц. }
  procedure FinishFrameObject(anObjectID: Integer;
   aAlignValue: Integer);
   {* Скобки для отрисовки "сложных" объектов с рамками - таблиц. }
  procedure AddFrame(const aCanvas: Il3Canvas;
   anObjectID: Integer;
   const aFrame: Tl3Frame;
   anAnalizeType: Tl3FrameAnalizeType);
   {* Учесть рамку (продлить одну или несколько линий или создать новую). }
  procedure AlignBoundary(anObjectID: Integer;
   const aFrame: Tl3Frame;
   anIsSingle: Boolean);
   {* Применить выравнивающие ограничения. }
  procedure DrawAllLines(const aCanvas: Il3Canvas;
   anObjectID: Integer);
   {* Нарисовать выровненные рамки. anObjectID = -1 выводить все линии, 
          если anObjectID > -1, то выводим линии только для одного объекта. 
          Пока в качестве anObjectID передается PID параграфа (таблицы и т.п.) }
  procedure DrawFrame(const aCanvas: Il3Canvas;
   const aFrame: Tl3Frame;
   const aText: Il3FrameTextPainter);
   {* Отрисовывает рамку. }
  function FinishedFO: Boolean;
   {* Флаг окончания отрисовки объекта. }
  function GetLineWidth(aFrameObjID: Integer): Integer;
   {* Возвращает ширину линии для указанного объекта. }
  function ReadAlignData(anObjectID: Integer): Il3IntegerList;
   {* Прочитать массив данных для сохранения }
  procedure WriteAlignData(anObjectID: Integer;
   const aData: Il3IntegerList);
   {* Записать данные о выравнивании }
  procedure SetNeedLogging(anObjectID: Integer;
   aNeedLog: Boolean);
   {* Метод для тестов. Выставляет флаг объекту о необходимости записи в лог. }
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
