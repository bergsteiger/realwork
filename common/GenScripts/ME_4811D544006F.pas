unit nevBaseView;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , nevTools
 , nevShapesPainted
 , nevBase
;

type
 TnevBaseView = class(Tl3ProtoObject, InevView)
  {* Базовая реализация области вывода. }
  procedure DoVersionInfoVisabilityChanged(aValue: Boolean);
  procedure DoInvalidateShape(const aShape: InevObject;
   aParts: TnevShapeParts);
  procedure Create;
  function DoGetMetrics: InevViewMetrics;
  function DoGetProcessor: InevProcessor;
  procedure ClearShapesPrim;
  procedure DoClearShapes(aNeedClearMax: Boolean);
   {* очищает список отображаемых форм. }
  procedure DoBeginDrawShape(const aShape: InevObject;
   const anAnchor: InevBasePoint;
   const anOrg: TnevPoint;
   var theMap: InevMap;
   aFake: Boolean;
   const aHacker: InevK235870994Hacker);
  function GetRootFormatInfo: TnevFormatInfoPrim;
  function Metrics: InevViewMetrics;
  function Data: InevObject;
  function RootMap: InevMap;
  function Processor: InevProcessor;
  procedure ClearShapes;
  procedure BeginDrawShape(const aShape: InevObject;
   const anAnchor: InevBasePoint;
   const anOrg: TnevPoint;
   var theMap: InevMap;
   aFake: Boolean;
   const aHacker: InevK235870994Hacker);
   {* Начинает добавление формы в список. }
  procedure EndDrawShape;
   {* Заканчивает добавление формы в список. }
  function MapByPoint(const aPoint: InevBasePoint;
   aCheckTopVisible: Boolean): InevMap;
  function FormatInfoByPoint(const aPoint: InevBasePoint): TnevFormatInfoPrim;
  function RootFormatInfo: TnevFormatInfoPrim;
  procedure InvalidateShape(const aShape: InevObject;
   aParts: TnevShapeParts);
  function ActiveElement: InevActiveElement;
   {* Активный элемент (тот в котором находится мышь) }
  function ForceDrawFocusRect: Boolean;
   {* Форсировать ли рисование рамки у текущего параграфа редактора }
  function IsObjectCollapsed: Boolean;
  procedure VersionInfoVisabilityChanged(aValue: Boolean);
  function FormatInfoByPara(const aPara: InevObject): TnevFormatInfoPrim; overload;
  function FormatInfoByObj(const anObj: InevObjectPrim): TnevFormatInfoPrim;
  function FormatInfoByPara(aPara: PInevObject): TnevFormatInfoPrim; overload;
 end;//TnevBaseView
 
implementation

uses
 l3ImplUses
 , SysUtils
 , k2Tags
;

end.
