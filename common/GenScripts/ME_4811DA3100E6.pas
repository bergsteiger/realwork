unit nevShapesPainted;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , nevTools
 , nevBase
 , nevShapePrim
 , afwInterfaces
 , nevShapePrimRefList
;

type
 TnevShape = class(TnevShapePrim, InevMap)
  function AddShape(const aShape: InevObject;
   const aTopLeft: TnevPoint;
   MakeVisible: Boolean;
   const aHacker: InevK235870994Hacker): TnevShape;
  function Bounds: TafwRect;
  function Outer: IafwShape;
  function rVisible: Boolean;
  procedure SetDrawnBottom(const aBottom: TnevPoint);
  function ReserveMap(const aShape: InevObject): InevMap;
  function IsLinked: Boolean;
  procedure AdjustTopByAnchor(const aView: InevView;
   const anAnchor: InevBasePoint);
  function CheckFormatInfo(const anObject: InevObject): TInevFormatInfoRet;
  procedure ClearBounds;
   {* Очищает прямоугольник. }
  function FI: TInevFormatInfoRet;
   {* Информация о форматировании }
  function GetMaxTop: Integer;
   {* Ищет самое нижнее значение Top у дочерних ячеек. }
  procedure CleanupRefs;
   {* Очищает ссылки на сторонние объекты }
  function GetChildMap(anIndex: Integer): InevMap;
  procedure SetDrawnTop(aTop: Integer);
  function GetChildenRight4Fill: Integer;
  function IsMapValid: Boolean;
 end;//TnevShape
 
 TnevLeafShape = class(TnevShape)
  function AddShape(const aShape: InevObject;
   const aTopLeft: TnevPoint;
   MakeVisible: Boolean;
   const aHacker: InevK235870994Hacker): TnevShape;
 end;//TnevLeafShape
 
 TnevTextParaShape = class(TnevLeafShape)
 end;//TnevTextParaShape
 
 TnevBaseTopShape = class(TnevShape)
  function AddShape(const aShape: InevObject;
   const aTopLeft: TnevPoint;
   MakeVisible: Boolean;
   const aHacker: InevK235870994Hacker): TnevShape;
 end;//TnevBaseTopShape
 
 TnevListShape = class(TnevBaseTopShape)
 end;//TnevListShape
 
 TnevLinesStoredListShape = class(TnevListShape)
 end;//TnevLinesStoredListShape
 
 TnevHorzListShape = class(TnevListShape)
 end;//TnevHorzListShape
 
 TnevRowShape = class(TnevHorzListShape)
 end;//TnevRowShape
 
 TnevDocumentShape = class(TnevListShape)
 end;//TnevDocumentShape
 
 TnevTopShape = class(TnevDocumentShape)
 end;//TnevTopShape
 
 TnevHorzTopShape = class(TnevTopShape)
 end;//TnevHorzTopShape
 
 TnevShapesPainted = class(Tl3CacheableBase)
  {* Коллекция отрисованных параграфов }
  function Root: InevMap;
  function PointByPt(const aView: InevView;
   const aPos: TnevPoint;
   CheckHidden: Boolean): InevBaseLine4Anchor;
   {* возвращает параграф самого нижнего уровня по координатам. }
  function MapByPoint(const aPoint: InevBasePoint): InevMap;
  function Empty: Boolean;
  function SubShapesCount: Integer;
  procedure SetSingle(aValue: Boolean);
   {* Переводим в режим отрисовки одиночного элемента. }
  procedure Clear;
   {* очищает список InevShape. }
  procedure ClearEx;
   {* очищает список InevShape. <?> Чем отличается от Clear? }
  procedure BeginDraw(const aShape: InevObject;
   const anAnchor: InevBasePoint;
   const aTopLeft: TnevPoint;
   var theMap: InevMap);
  procedure EndDraw;
  function MaxWidth: Integer;
  function VertScroll(const aView: InevView;
   const aFrom: InevBasePoint;
   const aTo: InevBasePoint;
   const anEx: TnevPoint): Integer;
   {* изменяется координаты элементы коллекции на расстояние от aFrom до
             aTo и возвращает расстояние между верхними границами параграфов. }
  function HorzScroll(aFrom: Integer;
   aTo: Integer;
   const anEx: TnevPoint): Integer;
   {* изменяется координаты элементы коллекции на расстояние от aFrom до
             aTo и возвращает расстояние между верхними границами параграфов. }
 end;//TnevShapesPainted
 
implementation

uses
 l3ImplUses
 , nevShapesPaintedSpy
;

end.
