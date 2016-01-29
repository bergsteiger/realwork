unit evCursor;

interface

uses
 l3IntfUses
 , nevTools
 , nevBase
 , l3Core
;

type
 TevCursor = class(_evCursor_, InevPoint, InevBasePoint)
  {* Курсор }
  procedure DoCorrectMoveRight(const aView: InevView;
   const aPoint: InevBasePoint;
   const anOp: InevOp);
  function VertPosition(const aView: InevView;
   aMap: TnevFormatInfoPrim): TnevParaIndex;
  function NeedWindowsCaret: Boolean;
  function ClonePoint(const aView: InevView): InevBasePoint;
  function DeltaX(const aView: InevView;
   const aMap: InevMap): Integer;
  function Inner: InevBasePoint;
   {* Дочерний "якорь". Детализирует позицию - внутри дочернего объекта }
  function Position: TnevPosition;
   {* позиция. }
  function InnerFor(const aChild: InevObject;
   var aRealTop: InevBasePoint): InevBasePoint;
  function AfterEnd: Boolean;
  function AsLeaf: InevLeafPoint;
  function LinkedPoint: InevLinkedPoint;
  function AtEnd(const aView: InevView): Boolean;
  function AtStart: Boolean;
  function HasInner: Boolean;
   {* Есть ли дочерний якорь }
  function ShowCollapsed: Boolean;
  function Compare(const aPoint: InevBasePoint): Integer;
  procedure CheckPos(const anOp: InevOp);
   {* Избавляемся от рассинхронизации позиции курсора и дочернего параграфа. Заплатка конечно }
  function ReadOnly: Boolean;
  function AsCursor(const aView: InevView): InevPoint;
  function MarkersSource: IevMarkersSource;
   {* Источник информации о "засечках" (в частности для линейки) }
  function ProcessMessage(const aView: InevControlView;
   var aMessage: TMessage;
   aTime: Cardinal): Boolean;
  function Listener: InevPointListener;
  function GetBlockLength: Integer;
  procedure MergeTo(const aView: InevView;
   const aBaseLine: InevBasePoint);
   {* Объединяем значения отрисованных частей. }
  function InnerForChildThatNotAfterEnd(aFI: TnevFormatInfoPrim;
   aForDrawing: TnevInnerType): InevBasePoint;
   {* Получаем первый параграф, по которому можно получить вложенную точку. }
  function HasBaseLine: Boolean;
   {* Проверяет есть ли возможность работы с базовой линией на точке }
  procedure AddInner(const aView: InevView;
   const anInner: InevBaseLine4Anchor;
   anIndex: Integer;
   var aFirst: Boolean;
   aMode: TnevAddInnerMode);
  procedure CompareWithOtherInner(const aView: InevView;
   anMaxID: Integer);
   {* После применения AnchorByPoint могут остаться "неинициализированные" (будут указывать на начало ячейки) дочерние точки в базовой линии. }
  function InnerHead(aPID: Integer): InevBasePoint;
   {* Аналог InnerFor, но для частей объдеиненных ячеек, попадающих на данную строку (пока используется только для печати). }
  function HasHeadPart: Boolean;
   {* Строка содержит продолжение объединенных ячеек. }
  procedure AddHeadInner(const aHeadInner: InevBasePoint);
   {* Служит для добавления в базовую линию продолжений объединенных ячеек (используется только для печати). }
  procedure CopyHeadParts(const aFrom: InevBasePoint);
   {* Копирует только части продолжений ячеек, если они есть. }
  procedure InitByCursor(const aView: InevView;
   const anInnerPoint: InevBasePoint);
   {* Инициализируем базовую линию по курсору. }
  procedure InitBaseLineInner(const aView: InevView;
   const anItem: InevPara);
  function InnerTop(const aChild: InevObject): InevBasePoint;
   {* Возвращает указатель на первоначальную позицию для точки. Для обычных точек - всегда nil. }
  function BeforeStart: Boolean;
  procedure CorrectMoveRight(const aView: InevView;
   const aPoint: InevBasePoint;
   const anOp: InevOp);
 end;//TevCursor
 
implementation

uses
 l3ImplUses
 , evOp
 , k2Base
 , l3InterfacesMisc
 , SysUtils
 , k2Tags
 , evdTypes
 , k2Const
;

end.
