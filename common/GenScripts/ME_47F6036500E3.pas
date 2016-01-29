unit nevAfterEndPoint;

interface

uses
 l3IntfUses
 , nevTools
 , nevBase
 , l3Core
;

type
 TnevAfterEndPoint = class(_nevPrimPoint_, InevPoint, InevBasePoint)
  {* Точка, указывающая ЗА КОНЕЦ параграфа. }
  procedure Create(const aPoint: InevBasePoint);
  function DoMake(const aPoint: InevBasePoint): InevPoint;
  function Make(const aView: InevView;
   const aPoint: InevBasePoint): InevBasePoint;
  function Range: InevRange;
  function Formatting: InevDataFormatting;
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
  procedure AssignPoint(const aView: InevView;
   const aPoint: InevBasePoint);
  procedure Bottom(const aView: InevView);
  function IncLine(const aView: InevView;
   var theLine: Integer;
   aByLine: Boolean): Integer;
   {* сдвигает якорь на указанное число строк. Возвращает количество параграфов на которое сдвинулся якорь. }
  function InnerFor(const aChild: InevObject;
   var aRealTop: InevBasePoint): InevBasePoint;
  function AfterEnd: Boolean;
  function AsLeaf: InevLeafPoint;
  function LinkedPoint: InevLinkedPoint;
  function AtEnd(const aView: InevView): Boolean;
  function AtStart: Boolean;
  function Diff(const aView: InevView;
   const aPoint: InevBasePoint;
   aMap: TnevFormatInfoPrim): Integer;
   {* сравнивает курсор с "якорем" по вертикали. }
  function Text: InevText;
  procedure DisableListener;
   {* Отключает нотификацию об изменении }
  procedure EnableListener;
   {* Включает нотификацию об изменении }
  function HasInner: Boolean;
   {* Есть ли дочерний якорь }
  function ShowCollapsed: Boolean;
  function Compare(const aPoint: InevBasePoint): Integer;
  procedure CheckPos(const anOp: InevOp);
   {* Избавляемся от рассинхронизации позиции курсора и дочернего параграфа. Заплатка конечно }
  function ReadOnly: Boolean;
  function AsPoint: InevBasePoint;
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
  function PartiallyVisible(const aView: InevView;
   const aPoint: InevBasePoint;
   const aMap: TnevFormatInfoPrim): Boolean;
   {* Определяет может ли точка "частично видимой" относительно другой точки (aPoint). Сделано для определения видимости начальной ячейки относительно якоря. }
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
 end;//TnevAfterEndPoint
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
