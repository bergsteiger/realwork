unit nevTools;

interface

uses
 l3IntfUses
 , nevBase
 , l3Variant
 , l3Types
 , l3Interfaces
 , k2Interfaces
 , k2Prim
 , evdInterfaces
 , evTypes
 , l3Core
 , k2Base
 , l3PureMixIns
 , afwInterfaces
 , evdTypes
 , Messages
;

type
 InevViewControl = interface
  {* Контрол для управления View. }
  procedure Top;
  procedure Bottom;
  procedure PageUp;
  function PageDown: Boolean;
  procedure LineUp(aCount: Integer);
  procedure LineDown(aCount: Integer);
 end;//InevViewControl
 
 InevCaret = interface(InevViewControl)
  {* Каретка. }
  procedure Home;
  procedure EndLine;
 end;//InevCaret
 
 InevBase = nevBase.InevBase;
 
 InevScroller = interface(InevViewControl)
  {* Скроллер. }
  function Min: Integer;
  function Max: Integer;
  function Page: Integer;
  function Pos: Integer;
  function ScrollTo(aPosition: Integer): Boolean;
  procedure WheelUp;
  procedure WheelDown;
  procedure EndScroll;
 end;//InevScroller
 
 TevPair = object
 end;//TevPair
 
 TnevAddInnerMode = (
  nev_aimUsual
  , nev_aimHead
  , nev_aimSingleUsual
  , nev_aimSingleHead
 );//TnevAddInnerMode
 
 TnevInnerType = (
  nev_itNone
  , nev_itForDrawing
  , nev_itNeedInit
 );//TnevInnerType
 
 (*
 MnevBordersHolder = interface
 end;//MnevBordersHolder
 *)
 
 InevObjectModify = interface
  function Delete(anInMerge: Boolean;
   const anOp: InevOp): Boolean;
   {* удаляет параграф aPara. }
 end;//InevObjectModify
 
 InevPara = interface;
 
 InevRange = interface;
 
 InevPoint = interface;
 
 InevBasePoint = interface;
 
 InevAnchor = interface;
 
 InevView = interface;
 
 InevObjectList = interface;
 
 InevObjectHolder = interface;
 
 InevBaseLine4Anchor = interface;
 
 InevBaseLine4Print = interface;
 
 InevObject = interface(InevObjectPrim)
  {* Отображаемый объект }
  function Range(const aStart: InevBasePoint;
   const aFinish: InevBasePoint;
   aSharp: Boolean): InevRange;
   {* выделение на данном объекте. }
  function SubRange(const aView: InevView;
   aStart: Integer;
   aFinish: Integer): InevRange;
   {* возвращает выделение на данном объекте от aStart до aFinish. }
  function MakePoint(const aParent: InevBasePoint): InevPoint;
   {* точка в объекте. }
  function CloneObj: InevObject;
  function OwnerObj: InevObjectList;
   {* родительский объект данного объекта. }
  function IsPara: Boolean;
  function AsPara: InevPara;
   {* преобразует объект к параграфу, если это возможно, иначе - исключение. }
  function ToList: InevObjectList;
  function MakeAnchor: InevAnchor;
  function Edit: InevObjectModify;
  function IsCollapsed(const aView: InevView): Boolean;
  function BaseLine4Anchor: InevBaseLine4Anchor;
  function BaseLine4Print: InevBaseLine4Print;
  function AppliesToMaxWidth: Boolean;
  procedure Invalidate(aParts: TnevShapeParts);
   {* Сообщает о необходимости перерисовать форму, если она отображается в каком-нибудь View. }
 end;//InevObject
 
 InevParaInternal = interface(InevPara)
  {* Параграф, "для тех кто знает". }
  procedure SignalPID(aPID: TnevParaIndex);
 end;//InevParaInternal
 
 InevDocumentContainer = interface;
 
 InevParaList = interface;
 
 InevSubList = interface;
 
 InevPara = interface(InevObject)
  {* Утилита для работы с тегом как с параграфом. }
  function OwnerTag: Tl3Variant;
   {* родительский тег данного параграфа. }
  function OwnerPara: InevParaList;
   {* родительский параграф данного параграфа. }
  function AsList: InevParaList;
  function IsComment: Boolean;
 end;//InevPara
 
 InevFontPrim = interface
  function SubFont(const aFont: InevFontPrim): Boolean;
   {* вычитает шрифт. }
  function AsFont(CorrectItalic: Boolean): Il3Font;
   {* преобразует к Il3Font. }
  function GetParam(ItemIndex: TnevFontParam): Integer;
  procedure Set2Font(const aFont: Il3Font;
   CorrectItalic: Boolean);
   {* присваивает себя Il3Font. }
  function Empty: Boolean;
  procedure MakeFontArray(BlockFont: Boolean);
  procedure InitFromTag(aTag: Tl3Variant);
 end;//InevFontPrim
 
 InevDataFormattingModify = interface
  function SetAtom(const aView: InevView;
   anIndex: Cardinal;
   aValue: Tl3Variant;
   const anOp: InevOp): Boolean;
  function ChangeParam(const aView: InevView;
   const aMarker: IevMarker;
   aValue: Integer;
   const anOp: InevOp): Boolean;
  function DeleteHyperlink(const anOp: InevOp): Boolean;
  function DeleteSegments(const anOp: InevOp): Boolean;
   {* удаляет сегменты. }
  function AddIndentMarker(const aView: InevView;
   aValue: Integer;
   const anOpPack: InevOp): Boolean;
  function DeleteIndentMarker(const aView: InevView;
   const anOpPack: InevOp): Boolean;
 end;//InevDataFormattingModify
 
 IevMarker = interface;
 
 InevDataFormatting = interface
  function GetFont(const aView: InevView;
   aMap: TnevFormatInfoPrim;
   Stop: PInteger): InevFontPrim;
  function GetStyle(Stop: PInteger): Tl3Variant;
  function Modify(const aView: InevView): InevDataFormattingModify;
 end;//InevDataFormatting
 
 TnevInsertStringFlag = (
  {* Флаг операций удаления/вставки строки. }
  misfDirect
  , misfLockSegments
  , misfLockCursors
  , misfDraw
  , misfSetText
  , misfForSelection
   {* Операция применяется изначально не к курсору, а к выделению http://mdp.garant.ru/pages/viewpage.action?pageId=220596558 }
 );//TnevInsertStringFlag
 
 TnevInsertStringFlags = set of TnevInsertStringFlag;
  {* Флаги операций удаления/вставки строки. }
 
 InevTextModify = interface
  function InsertString(const aView: InevView;
   const aString: Il3CString;
   const anOp: InevOp;
   InsertMode: Boolean;
   aFlags: TnevInsertStringFlags): Boolean;
   {* вставляет строку. }
  function InsertStream(const aView: InevView;
   const aStream: IStream;
   aFormat: TnevFormat;
   const anOp: InevOp;
   aFlags: TevLoadFlags;
   aCodePage: Integer): Boolean;
  function DeleteString(const aView: InevView;
   Count: Integer;
   const anOp: InevOp;
   aFlags: TnevInsertStringFlags): Boolean;
   {* удаляет строку. }
  function DeleteChar(const aView: InevView;
   aDrawLines: Boolean;
   const anOp: InevOp): Boolean;
  function InsertBreak(const aView: InevView;
   aDrawLines: Boolean;
   const anOp: InevOp): Boolean;
  function DeleteCharToLeft(const aView: InevView;
   aDrawLines: Boolean;
   const anOp: InevOp): Boolean;
  function Split(const aView: InevView;
   aFlags: TnevInsertStringFlags;
   const anOp: InevOp): Il3TagRef;
  function JoinWith(const aView: InevView;
   aSecondPara: Tl3Variant;
   const anOp: InevOp;
   MoveSubs: Boolean): Integer;
  function JoinWithNext(const aView: InevView;
   const anOp: InevOp): Boolean;
 end;//InevTextModify
 
 InevText = interface
  function CanBeDeleted: Boolean;
  function Modify: InevTextModify;
 end;//InevText
 
 (*
 MnevObjectPointer = interface
  {* "Указатель" на объект }
 end;//MnevObjectPointer
 *)
 
 InevLocation = interface(Il3TagRef)
  function Range: InevRange;
  function AsPoint: InevBasePoint;
 end;//InevLocation
 
 InevRangePrim_Iterate_Action = function(const anItem: InevRange;
  anIndex: Integer): Boolean;
  {* Тип подитеративной функции для InevRangePrim.Iterate }
 
 InevRangePrim = interface(InevLocation)
  {* Выделенная часть объекта. Для удобства переноса на модель }
  procedure Iterate;
   {* Итератор по вложенным выделенным объектам }
 end;//InevRangePrim
 
 TevClearMode = (
  ev_cmAll
  , ev_cmKeepOne
  , ev_cmEmpty
  , ev_cmForceKeepOne
   {* ВСЕГДА оставлять один параграф.
http://mdp.garant.ru/pages/viewpage.action?pageId=228693150 }
  , ev_cmVertMergeCells
  , ev_cmClearFirstCell
  , ev_cmEmpty4BlockResize
  , ev_cmLeaveSegments
 );//TevClearMode
 
 InevRangeModify = interface
  {* Выделенная часть объекта с возможностью редактирования. }
  function Delete(const aView: InevView;
   const anOp: InevOp;
   aMode: TevClearMode;
   const aPara: InevPara): Boolean;
 end;//InevRangeModify
 
 IevSearchTool = interface
  procedure Start;
   {* начало поиска. }
  procedure Finish(aCancel: Boolean;
   const aBlock: InevRange);
   {* конец поиска. }
 end;//IevSearchTool
 
 IevSearcher = interface(IevSearchTool)
  {* Инструмент для определения критерий отбора параграфа (его фрагмента). }
  function Check(const aView: InevView;
   const aBlock: InevRange;
   out theStart: InevBasePoint;
   out theFinish: InevBasePoint;
   const PrevBlock: InevRange): Boolean;
   {* определяет критерий отбора параграфа (его фрагмента). }
 end;//IevSearcher
 
 InevConfirm = interface;
 
 IevReplacer = interface(IevSearchTool)
  function Replace(const Container: InevOp;
   const aBlock: InevRange;
   const aConfirm: InevConfirm): Boolean;
  function NeedProgress: Boolean;
 end;//IevReplacer
 
 TevReplaceConfirmEvent = function(Sender: TObject;
  const aBlock: InevRange): ShortInt of object;
  {* Событие для запроса на замену выделения Block. Результатом может быть:
       |<br>
       |<ul>
       | <li><b>mrOk</b> - заменить.</li>
       | <li><b>mrYes</b> - заменить.</li>
       | <li><b>mrNo</b> - не заменять.</li>
       | <li><b>mrAll</b> - заменить все.</li>
       | <li><b>mrCancel</b> - закончить цикл поиска/замены.</li>
       | <li><b>mrAbort</b> - закончить цикл поиска/замены.</li>
       |</ul> }
 
 InevConfirm = interface
  {* call-back интерфейс для обработки запроса на замену. }
  function ReplaceConfirm(const aBlock: InevRange;
   AlienReplaceConfirm: TevReplaceConfirmEvent): ShortInt;
   {* запрос на замену. Возвращаемое значение см. TevReplaceConfirmEvent. }
  function DeleteFoundRgn: Boolean;
  procedure Update;
 end;//InevConfirm
 
 (*
 MnevSearchReplace = interface
  function SearchReplace(const aSearcher: IevSearcher;
   const aReplacer: IevReplacer;
   const aConfirm: InevConfirm;
   const aCursor: InevBasePoint;
   const anOpPack: InevOp;
   aNeedProgress: Boolean): Boolean;
   {* процесс поиска/замены. Возвращает - была ли отмена замены. }
 end;//MnevSearchReplace
 *)
 
 (*
 MnevSearchCriteria = interface
  {* Критерий поиска }
  function Search(const aView: InevView;
   const aSearcher: IevSearcher;
   const Progress: Il3Progress;
   const aStart: InevBasePoint;
   out cFStart: InevBasePoint;
   out cFFinish: InevBasePoint): Boolean;
   {* ищет в выделении критерий ОnSearch
             и возвращает начало и конец найденного фрагмента в (cFStart, cFFinish). }
 end;//MnevSearchCriteria
 *)
 
 InevRangeFactory = interface(InevRange)
  {* Внутренний интерфейс для иницииализации выделения в объекте }
  procedure Init(const aStart: InevBasePoint;
   const aFinish: InevBasePoint;
   aSharp: Boolean);
 end;//InevRangeFactory
 
 IevTableRange = interface
  {* Диапазон выделения в таблице. }
  function GetRangeOffsets(out theStartOffset: Integer;
   out theFinishOffset: Integer): Boolean;
   {* возвращает горизонтальные границы диапазона выделения. }
  function GetRangeBorders(out theStartRow: Integer;
   out theFinishRow: Integer;
   out theStartOffset: Integer;
   out theFinishOffset: Integer): Boolean;
   {* возвращает границы диапазона выделения. }
  function Offset2Cells(aRow: Tl3Variant;
   aStartOffset: Integer;
   aFinishOffset: Integer;
   out theStartCell: Integer;
   out theFinishCell: Integer): Boolean;
   {* получить индексы для ячеек aRow для смещений (aStartOffset, aFinishOffset). }
 end;//IevTableRange
 
 InevDataObjectPrim2 = interface;
 
 InevRange = interface(InevRangePrim)
  {* Выделенная часть объекта. }
  function SolidBottomChildBlock(const aView: InevView): InevRange;
  function GetChildSel(const aView: InevView;
   aChildIndex: Integer;
   aForDrawing: Boolean): InevRange;
  procedure GetBorderPoints(out BS: InevBasePoint;
   out BF: InevBasePoint);
  function BottomChildBlock(const aView: InevView): InevRange;
  function CloneSel(const aView: InevView): InevRange;
  function Modify: InevRangeModify;
  function ParentRange(aLevel: Integer): InevRange;
  function Contains(const aView: InevView;
   const aPoint: InevBasePoint): Boolean;
  procedure Select(const aView: InevView;
   const C: InevBasePoint;
   aTarget: TevSelectTarget;
   const Ctx: InevOp); overload;
  procedure Select(const aView: InevView;
   const C: InevBasePoint;
   aOpen: Integer;
   aClose: Integer;
   const Ctx: InevOp); overload;
  function Solid(const aView: InevView): Boolean;
  function ContainsEnd(const aView: InevView): Boolean;
  function Collapsed(const aView: InevView): Boolean;
  function AsStorable: InevDataObjectPrim2;
  procedure RefreshBorders;
   {* Обновляет границы блока. http://mdp.garant.ru/pages/viewpage.action?pageId=409750147 }
  function SearchReplace(const aSearcher: IevSearcher;
   const aReplacer: IevReplacer;
   const aConfirm: InevConfirm;
   const aCursor: InevBasePoint;
   const anOpPack: InevOp;
   aNeedProgress: Boolean): Boolean;
   {* процесс поиска/замены. Возвращает - была ли отмена замены. }
  function Search(const aView: InevView;
   const aSearcher: IevSearcher;
   const Progress: Il3Progress;
   const aStart: InevBasePoint;
   out cFStart: InevBasePoint;
   out cFFinish: InevBasePoint): Boolean;
   {* ищет в выделении критерий ОnSearch
             и возвращает начало и конец найденного фрагмента в (cFStart, cFFinish). }
 end;//InevRange
 
 (*
 MnevBasePointModify = interface
  procedure AssignPoint(const aView: InevView;
   const aPoint: InevBasePoint);
  procedure DisableListener;
   {* Отключает нотификацию об изменении }
  procedure EnableListener;
   {* Включает нотификацию об изменении }
 end;//MnevBasePointModify
 *)
 
 (*
 MnevAnchorModify = interface
  {* Точка привязки с возможностью модификации }
  procedure Bottom(const aView: InevView);
  function IncLine(const aView: InevView;
   var theLine: Integer;
   aByLine: Boolean): Integer;
   {* сдвигает якорь на указанное число строк. Возвращает количество параграфов на которое сдвинулся якорь. }
 end;//MnevAnchorModify
 *)
 
 TevParaMarkerStyle = (
  ev_pmsNone
  , ev_pmsFirstIndent
   {* отступ первой строки }
  , ev_pmsLeftIndent
   {* левый отступ }
  , ev_pmsWrapColumn
   {* правая граница текста }
  , ev_pmsColumnBorder
   {* граница колонки таблицы }
  , ev_pmsParaIndent
   {* левый отступ списка параграфов }
  , ev_pmsParaSize
   {* размер списка параграфов }
  , ev_pmsPageLeftIndent
   {* левый отступ страницы }
  , ev_pmsPageRightIndent
   {* правый отступ страницы }
  , ev_pmsPageSize
   {* размер страницы }
  , ev_pmsTabIndent
   {* отступ параграфа по табуляции }
 );//TevParaMarkerStyle
 
 IevMarker = interface
  {* Маркер изменяемого параметра объекта (ширина, отступы и т.п.). }
  function MakeCopy(const aTagWrap: InevPara): IevMarker;
   {* делает копию маркера для aTagWrap. }
  procedure SetValue(Value: Integer;
   const Context: InevOp);
   {* установить новое значение параметра. }
  function CompareLevel(aTagWrap: Tl3Variant): Integer;
   {* сравнить уровени вложенности маркера и тега. }
  function Compare(const aMarker: IevMarker): Integer;
   {* сравнивает маркеры. }
 end;//IevMarker
 
 InevMap = interface;
 
 (*
 MnevViewBounds = interface
  {* Границы отображаемого объекта }
  function ViewBounds(const aView: InevView;
   const aMap: InevMap): TnevRect;
   {* Ограничивающий точку "прямоугольник". Для текстовых параграфов реализация не самая быстрая. Если потребуется активное использование, то реализацию стоит пересмотреть }
 end;//MnevViewBounds
 *)
 
 InevPointListener = interface
  {* Объект, принимающий уведомления об изменении курсора. }
  procedure CursorChanged(const aCursor: InevBasePoint);
   {* курсор aCursor изменился. }
  procedure ParaChanged(const aCursor: InevBasePoint);
   {* текущий параграф изменился. }
 end;//InevPointListener
 
 TnevMoveResult = (
  ev_dcNotDone
  , ev_dcDoneOk
  , ev_dcDoneFail
 );//TnevMoveResult
 
 IevCursorContext = interface
  {* Объект для записи изменений курсора. }
  procedure RecordCursor(const aCursor: InevBasePoint);
   {* начать запись курсора. }
  procedure StopRecord;
   {* закончить запись курсоров. }
 end;//IevCursorContext
 
 (*
 MnevPointModify = interface
  function DoMove(const aView: InevView;
   aCode: Integer;
   const anOp: InevOp;
   aCount: Integer): TnevMoveResult;
  function Move(const aView: InevView;
   aCode: Cardinal;
   const anOp: InevOp;
   aCount: Integer): Boolean;
  procedure Refresh;
  procedure SetEntryPointPrim(Value: Integer;
   const Context: IevCursorContext);
  procedure SetEntryPoint(Value: Integer;
   const Context: IevCursorContext); overload;
  procedure SetEntryPoint(aValue: Integer;
   const aContext: InevOp); overload;
  function ToBottomChild(const aView: InevView): InevBasePoint;
  procedure SetAtEnd(const aView: InevView;
   aValue: Boolean);
  procedure SetAtStart(const aView: InevView;
   aValue: Boolean);
 end;//MnevPointModify
 *)
 
 IevROMarkersList = interface
 end;//IevROMarkersList
 
 IevMarkersList = interface(IevROMarkersList)
  function Add(const anItem: IevMarker): Integer;
 end;//IevMarkersList
 
 IevMarkersSource = interface
  {* Источник маркеров, в частности для линеек (см. TevRuler) }
  procedure GetMarkers(const aView: InevView;
   const aList: IevMarkersList);
   {* получить маркеры из источника в aList. }
 end;//IevMarkersSource
 
 (*
 MnevPaintOffsetY = interface
  function PaintOffsetY(const aView: InevView;
   aMap: TnevFormatInfoPrim): Integer;
 end;//MnevPaintOffsetY
 *)
 
 InevLeafPoint = interface
  {* Листьевая точка. }
  procedure InitPointByPt(const aView: InevView;
   const aPoint: TnevPoint;
   const aMap: InevMap);
  function PaintOffsetY(const aView: InevView;
   aMap: TnevFormatInfoPrim): Integer;
 end;//InevLeafPoint
 
 (*
 MnevParentPointFactory = interface
  {* Производитель курсоров на родительский объект }
  function PointToParent(const aThisTarget: InevObjectPrim;
   aNeedShowCollapsed: Boolean): InevBasePoint;
 end;//MnevParentPointFactory
 *)
 
 (*
 MnevParentPointFactoryEx = interface
  function PointToParentByLevel(aLevel: Integer): InevBasePoint;
  function PointToTypedParent(aParentType: Tk2Type): InevBasePoint;
 end;//MnevParentPointFactoryEx
 *)
 
 (*
 MnevOuter = interface
 end;//MnevOuter
 *)
 
 (*
 MnevParentPoint = interface
 end;//MnevParentPoint
 *)
 
 (*
 MnevMostInner = interface
  {* Самая внутренняя точка объекта }
 end;//MnevMostInner
 *)
 
 (*
 MnevDiff = interface
  function Diff(const aView: InevView;
   const aPoint: InevBasePoint;
   aMap: TnevFormatInfoPrim): Integer;
   {* сравнивает курсор с "якорем" по вертикали. }
  function PartiallyVisible(const aView: InevView;
   const aPoint: InevBasePoint;
   const aMap: TnevFormatInfoPrim): Boolean;
   {* Определяет может ли точка "частично видимой" относительно другой точки (aPoint). Сделано для определения видимости начальной ячейки относительно якоря. }
 end;//MnevDiff
 *)
 
 (*
 MnevCorrectMove = interface
  procedure CorrectMoveRight(const aView: InevView;
   const aPoint: InevBasePoint;
   const anOp: InevOp);
 end;//MnevCorrectMove
 *)
 
 InevControlView = interface;
 
 InevBasePoint = interface(InevLocation)
  {* Базовая точка внутри объекта }
  function VertPosition(const aView: InevView;
   aMap: TnevFormatInfoPrim): TnevParaIndex;
  function NeedWindowsCaret: Boolean;
  function ClonePoint(const aView: InevView): InevBasePoint;
  function DeltaX(const aView: InevView;
   const aMap: InevMap): Integer;
  function InnerFor(const aChild: InevObject;
   var aRealTop: InevBasePoint): InevBasePoint;
  function AtEnd(const aView: InevView): Boolean;
  function AtStart: Boolean;
  function Compare(const aPoint: InevBasePoint): Integer;
  procedure CheckPos(const anOp: InevOp);
   {* Избавляемся от рассинхронизации позиции курсора и дочернего параграфа. Заплатка конечно }
  function ReadOnly: Boolean;
  function AsCursor(const aView: InevView): InevPoint;
  function ProcessMessage(const aView: InevControlView;
   var aMessage: TMessage;
   aTime: Cardinal): Boolean;
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
  procedure AssignPoint(const aView: InevView;
   const aPoint: InevBasePoint);
  procedure DisableListener;
   {* Отключает нотификацию об изменении }
  procedure EnableListener;
   {* Включает нотификацию об изменении }
  procedure Bottom(const aView: InevView);
  function IncLine(const aView: InevView;
   var theLine: Integer;
   aByLine: Boolean): Integer;
   {* сдвигает якорь на указанное число строк. Возвращает количество параграфов на которое сдвинулся якорь. }
  function DoMove(const aView: InevView;
   aCode: Integer;
   const anOp: InevOp;
   aCount: Integer): TnevMoveResult;
  function Move(const aView: InevView;
   aCode: Cardinal;
   const anOp: InevOp;
   aCount: Integer): Boolean;
  procedure Refresh;
  procedure SetEntryPointPrim(Value: Integer;
   const Context: IevCursorContext);
  procedure SetEntryPoint(Value: Integer;
   const Context: IevCursorContext); overload;
  procedure SetEntryPoint(aValue: Integer;
   const aContext: InevOp); overload;
  function ToBottomChild(const aView: InevView): InevBasePoint;
  procedure SetAtEnd(const aView: InevView;
   aValue: Boolean);
  procedure SetAtStart(const aView: InevView;
   aValue: Boolean);
  function PointToParent(const aThisTarget: InevObjectPrim;
   aNeedShowCollapsed: Boolean): InevBasePoint;
  function PointToParentByLevel(aLevel: Integer): InevBasePoint;
  function PointToTypedParent(aParentType: Tk2Type): InevBasePoint;
  function Diff(const aView: InevView;
   const aPoint: InevBasePoint;
   aMap: TnevFormatInfoPrim): Integer;
   {* сравнивает курсор с "якорем" по вертикали. }
  function PartiallyVisible(const aView: InevView;
   const aPoint: InevBasePoint;
   const aMap: TnevFormatInfoPrim): Boolean;
   {* Определяет может ли точка "частично видимой" относительно другой точки (aPoint). Сделано для определения видимости начальной ячейки относительно якоря. }
  function ViewBounds(const aView: InevView;
   const aMap: InevMap): TnevRect;
   {* Ограничивающий точку "прямоугольник". Для текстовых параграфов реализация не самая быстрая. Если потребуется активное использование, то реализацию стоит пересмотреть }
  procedure CorrectMoveRight(const aView: InevView;
   const aPoint: InevBasePoint;
   const anOp: InevOp);
 end;//InevBasePoint
 
 InevBaseLine4Anchor = interface(InevBasePoint)
 end;//InevBaseLine4Anchor
 
 InevBaseLine4Print = interface(InevBaseLine4Anchor)
 end;//InevBaseLine4Print
 
 TevDeleteParaFlag = (
  ev_dpfAtEnd
  , ev_dpfInternal
  , ev_dpfInMerge
  , ev_dpfForce
 );//TevDeleteParaFlag
 
 IevTagLine = interface
  {* "Строка" в объекте }
  function GetLine(aMap: TnevFormatInfoPrim): Integer;
 end;//IevTagLine
 
 IevOpInsertPara = interface
  function DoIt(const anOpPack: InevOp;
   aPara: Tl3Variant;
   aFlags: TevInsertParaFlags): Boolean;
 end;//IevOpInsertPara
 
 TevDeleteParaFlags = set of TevDeleteParaFlag;
 
 IevSavedCursor = interface
  procedure Store(const Cursor: InevBasePoint);
  procedure Load(const Cursor: InevBasePoint);
  function Clone: IevSavedCursor;
 end;//IevSavedCursor
 
 InevLinkedPoint = interface(InevPoint)
  {* Точка, привязанная к контролу }
  procedure LinkListener(const aListener: InevPointListener);
  procedure UnlinkListener(const aListener: InevPointListener);
 end;//InevLinkedPoint
 
 IevOpDeletePara = interface
  function DoIt(const anOpPack: InevOp;
   aFlags: TevDeleteParaFlags): Boolean;
 end;//IevOpDeletePara
 
 TevLineStyle = (
  ev_lsNormal
  , ev_lsClear
  , ev_lsSymbol
  , ev_lsMove
 );//TevLineStyle
 
 TevLineDirection = (
  {* Направление рисования линии }
  ev_ldUp
  , ev_ldDown
  , ev_ldLeft
  , ev_ldRight
  , ev_ldHome
  , ev_ldEnd
 );//TevLineDirection
 
 IevDrawLineTool = interface
  {* Инструмент для рисования линий }
  function DrawLine(const aView: InevView;
   aDirection: TevLineDirection;
   aStyle: TevLineStyle;
   const anOp: InevOp): Boolean;
   {* Нарисовать линию в направлении aDirection }
 end;//IevDrawLineTool
 
 InevPoint = interface(InevBaseLine4Print)
 end;//InevPoint
 
 InevAnchor = interface(InevBaseLine4Anchor)
  {* Якорь на точку внутри объекта }
  function LinkListener(const aView: InevScrollListener): InevScrollListener;
  procedure UnlinkListener(const aControl: InevScrollListener);
 end;//InevAnchor
 
 InevMap = interface(InevShapePrim)
  function IsMapValid: Boolean;
  function rVisible: Boolean;
  procedure SetDrawnBottom(const aBottom: TnevPoint);
  function ReserveMap(const aShape: InevObject): InevMap;
  function IsLinked: Boolean;
  procedure AdjustTopByAnchor(const aView: InevView;
   const anAnchor: InevBasePoint);
  function CheckFormatInfo(const anObject: InevObject): TInevFormatInfoRet;
  procedure ClearBounds;
   {* Очищает прямоугольник. }
  function GetMaxTop: Integer;
   {* Ищет самое нижнее значение Top у дочерних ячеек. }
  function GetChildMap(anIndex: Integer): InevMap;
  procedure SetDrawnTop(aTop: Integer);
  function GetChildenRight4Fill: Integer;
 end;//InevMap
 
 (*
 ShapeView = interface
  procedure InvalidateShape(const aShape: InevObject;
   aParts: TnevShapeParts);
 end;//ShapeView
 *)
 
 InevSimpleView = interface
  {* Место отображения объекта с возможность управления необходимостью перерисовки. }
  procedure InvalidateShape(const aShape: InevObject;
   aParts: TnevShapeParts);
 end;//InevSimpleView
 
 InevActiveElement = interface;
 
 (*
 ActiveElementHolder = interface
  {* Объект владеющий активным элементом интерфейса }
 end;//ActiveElementHolder
 *)
 
 InevK235870994Hacker = interface
  {* [RequestLink:235870994] }
  function HackK235870994(const aMap: InevMap): Boolean;
 end;//InevK235870994Hacker
 
 InevMeasureView = interface
  {* "Область вывода" для измерений }
  procedure MakePointVisible(const aTop: InevAnchor;
   const aPoint: InevBasePoint;
   var thePos: Integer);
   {* Делает так, чтобы курсор был видим на заданном экране }
 end;//InevMeasureView
 
 (*
 InevShapesPainted = interface
  {* Интерфейс описывающий работу с коллекцией отрисованных параграфов }
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
 end;//InevShapesPainted
 *)
 
 InevView = interface(InevSimpleView)
  {* Место отображения объекта }
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
  procedure VersionInfoVisabilityChanged(aValue: Boolean);
  function FormatInfoByPara(const aPara: InevObject): TnevFormatInfoPrim; overload;
  function FormatInfoByObj(const anObj: InevObjectPrim): TnevFormatInfoPrim;
  function FormatInfoByPara(aPara: PInevObject): TnevFormatInfoPrim; overload;
 end;//InevView
 
 TnevChangePlace = (
  {* Что меняется }
  nev_cpView
   {* параметры области отображения изменились }
  , nev_cpPara
   {* состав параграфов изменился }
  , nev_cpText
   {* текст параграфа изменился }
 );//TnevChangePlace
 
 InevViewArea = interface(InevSimpleView)
  {* Область вывода. }
  procedure Invalidate;
   {* сообщает контролу о необходимости перерисовки, когда-нибудь в будущем. }
  procedure Update;
   {* сообщает контролу о необходимости перерисовки, в данный момент. }
  procedure Changed(aPlace: TnevChangePlace);
   {* Данные для отображения изменились }
 end;//InevViewArea
 
 InevSelection = interface
  function Select(const aSource: InevRange;
   AllowAddToMulti: Boolean): Boolean;
   {* присваивает одно выделение другому. }
  procedure SelectPt(const Value: TnevPoint;
   aNeedUpdate: Boolean);
   {* устанавливает позицию выделения (в мировых координатах). }
  function SelectPoint(const aPoint: InevBasePoint;
   aNeedSetTop: Boolean;
   aNeedShowCaret: Boolean;
   aDiff: Integer): Boolean;
   {* параметр aNeedSetTop означает подравливать ли верхний край экрана под курсор
если false, то курсор должен показаться в ЛЮБОМ месте экрана
а если true - то жёстко сверху }
  function AddBlock(const aStart: InevBasePoint;
   const aFinish: InevBasePoint): Boolean;
   {* добавляет отрезок выделения. }
  function Unselect: Boolean;
   {* снять выделение. }
  function GetBlock: InevRange;
   {* получить текущий объект выделения. }
  function Contains(const C: InevBasePoint): Boolean;
   {* проверяет содержит ли выделение курсор. }
 end;//InevSelection
 
 InevInputView = interface;
 
 InevControl = interface(IafwControl)
  {* Контрол вывода. }
  procedure InvalidateRect(const aRect: TnevRect);
   {* сообщает контролу о необходимости перерисовки указанного прямоугольника, когда-нибудь в будущем. }
  procedure SignalScroll(aDeltaY: Integer;
   aNeedVert: Boolean);
   {* сообщает контролу, о том, что изменилась позиция скроллера. }
  function GetDelphiControl: TComponent;
  function CloseQuery: Boolean;
   {* спрашивает контрол, о возможности закрытия окна, которому он принадлежит. }
  function LP2DP(const aPoint: TnevPoint;
   toScreen: Boolean): TPoint;
  procedure CursorChanged;
  function CanScroll: Boolean;
  procedure SetFlag(aFlag: TevUpdateWindowFlag);
   {* установить флаг aFlag. }
  procedure UpdateCaretAndInvalidate;
   {* Проверить и переставить каретку + перерисоваться }
  procedure ParaChanged;
   {* Нотификация о смене текущего параграфа. }
  procedure ForceRepaint;
   {* По жёсткому перерисовать сожержимое контрола (прямо внутри операции редактирования). Нужно для http://mdp.garant.ru/pages/viewpage.action?pageId=204113269 }
  function InClose: Boolean;
   {* Редактор в процессе закрытия. }
 end;//InevControl
 
 InevControlView = interface(InevView)
  {* Место отображения объекта, привязанное к контролу вывода. }
  function PointByPt(const aPt: TnevPoint;
   aForSetCursor: Boolean): InevBasePoint;
   {* Возвращает курсор указывающий на данную точку, в системе координат View. }
 end;//InevControlView
 
 InevLinkedView = interface(InevControlView)
  {* Место отображения объекта, привязанное к контролу вывода. }
  procedure UnlinkControl(const aControl: InevControl);
   {* отсоединяет контрол от области вывода. }
 end;//InevLinkedView
 
 InevDrawView = interface(InevLinkedView)
  function IsDocumentTailVisible: Boolean;
  function Draw(const aBlock: InevRange;
   var theMap: InevMap): Boolean;
  function BottomAnchor(aSimple: Boolean): InevAnchor;
 end;//InevDrawView
 
 InevScrollView = interface(InevDrawView)
  {* View с возможностью скроллирования. }
 end;//InevScrollView
 
 InevSelectionView = interface(InevScrollView)
  {* View с возможностью выделения контента. }
  function MakePointVisible(const aPoint: InevBasePoint): Boolean;
  procedure MakePairVisible(const aStart: InevBasePoint;
   const aFinish: InevBasePoint);
 end;//InevSelectionView
 
 InevInputView = interface(InevSelectionView)
  {* View с возможностью ввода. }
  function InMakeCaretVisible: Boolean;
  procedure MakeCaretVisible;
  function IsCaretVisible: Boolean;
  procedure ClearPointToShow;
   {* Очистить закешированную позицию для перехода }
 end;//InevInputView
 
 InevStorable = interface
  procedure Store(const aView: InevView;
   const G: InevTagGenerator;
   aFlags: TevdStoreFlags); overload;
   {* сохраняет выделение в G. }
 end;//InevStorable
 
 InevDataObjectPrim2 = interface(InevStorable)
 end;//InevDataObjectPrim2
 
 InevObjectList = interface(InevObject)
  function IndexOfObj(const aPara: InevObject): TnevParaIndex;
 end;//InevObjectList
 
 IevSubCache = interface
  procedure ClearSubs;
  procedure NotifySubDeleted(const aSub: IevSub);
 end;//IevSubCache
 
 IevSub = interface;
 
 (*
 MnevTextArea = interface
  {* Область текста }
 end;//MnevTextArea
 *)
 
 IelEditStrings = interface
  {* Строки редактора. }
 end;//IelEditStrings
 
 InevTagReader = interface
  function ReadTag(aFormat: TnevFormat;
   const aPool: IStream;
   const aFilters: InevTagGenerator;
   const Block: InevDataObjectPrim2;
   aFlags: TevdStoreFlags;
   aCodePage: Integer): Integer;
   {* считать тег из Storage в aPool. }
  function ReadTagEx(const Writer: InevTagGenerator;
   const aPool: IStream;
   const aBlock: InevDataObjectPrim2;
   aFlags: TevdStoreFlags;
   CharCountMul: Integer;
   const FormatName: Il3CString;
   aCodePage: Integer): Integer;
   {* записать документ в память (Pool) из TextSource. }
 end;//InevTagReader
 
 InevTagWriter = interface
  function WriteTag(const aView: InevView;
   aFormat: TnevFormat;
   const aPool: IStream;
   const aBlock: IUnknown;
   aFlags: TevLoadFlags;
   aCodePage: Integer): Boolean;
   {* записать тэг из Pool в Storage. }
  procedure WriteTagEx(const aView: InevView;
   const aReader: InevReader;
   const aBlock: IUnknown;
   aFlags: TevLoadFlags);
   {* записать тэг из Pool в Storage. }
 end;//InevTagWriter
 
 InevFormatPool = interface
  function FormatInfoForView(const aView: InevView): TnevFormatInfoPrim;
  procedure ClearFormatInfoForView(const aView: InevView);
 end;//InevFormatPool
 
 InevSectionBreaks = interface
  function GetSectionWidth(const aChild: InevObject;
   out theWidth: Integer): Boolean;
  function GetSectionBreak(const aChild: InevObject;
   out theBreak: InevObject): Boolean;
   {* Возвращает разрыв раздела для указанного дочернего элемента }
 end;//InevSectionBreaks
 
 InevObjectHolder = interface(InevObjectHolderPrim)
  function TagReader: InevTagReader;
  function TagWriter: InevTagWriter;
  function FindObjByID(aParaID: Integer;
   out aPara: InevObject): Boolean;
  procedure ChildAdded(aList: Tl3Variant;
   aProp: Tk2ArrayProperty;
   aChild: Tl3Variant;
   anIndex: Integer;
   const anOpPack: InevOp);
  procedure ChildDeleted(aList: Tl3Variant;
   aProp: Tk2ArrayProperty;
   aChild: Tl3Variant;
   anIndex: Integer;
   const anOpPack: InevOp);
  procedure UpdatePreview;
  procedure PropChanged(Prop: Tk2Prop;
   const V: TnevValues;
   const anOpPack: InevOp);
  procedure SectionBreakAdded(const anObject: InevObject);
   {* Добавился разрыв раздела }
  procedure InvalidateShape(const aShape: InevObject;
   aParts: TnevShapeParts);
  function AllowsThisDecor(aFI: TnevFormatInfoPrim;
   aType: TnevDecorType): Boolean;
   {* Разрешает ли контейтер документа применять указанное декорирование }
 end;//InevObjectHolder
 
 IevSelectionPairs = interface
 end;//IevSelectionPairs
 
 IevTreeDataObject = interface
  procedure Store(const G: InevTagGenerator;
   aLevelTag: Integer;
   aIndent: Integer);
   {* Сохраняет ноду дерева в G }
 end;//IevTreeDataObject
 
 IevDocumentPreviewInfo = interface
 end;//IevDocumentPreviewInfo
 
 InevDocumentLimits = interface
  {* Ограничения документа. }
 end;//InevDocumentLimits
 
 InevDocumentInfo = interface
  {* Информация о документе. }
  procedure ClearStat;
 end;//InevDocumentInfo
 
 TevChangeType = (
  ev_chtAdded
  , ev_chtDeleted
  , ev_chtDocument
 );//TevChangeType
 
 TnevDocumentEvent = (
  nev_deNettoCharCountChange
  , nev_deBruttoCharCountChange
  , nev_deTextParaCountChange
  , nev_deTOCCreated
  , nev_deChangeModified
 );//TnevDocumentEvent
 
 InevSubChangeListener = interface
  procedure SubChanged(aSub: Tl3Variant;
   aChangeType: TevChangeType);
   {* Саб добавлен/удален. }
 end;//InevSubChangeListener
 
 InevCommentTextProvider = interface
  function GetCommentTextByParaID(aParaID: Integer): Il3CString;
  procedure DeleteCommentByParaID(aParaID: Integer);
 end;//InevCommentTextProvider
 
 InevWaiter = interface
  function TrySelect(const aContainer: InevDocumentContainer): Boolean;
  function TrySelectObj(const aContainer: InevDocumentContainer;
   aParent: Tl3Variant;
   aChild: Tl3Variant): Boolean;
 end;//InevWaiter
 
 InevTextSource = interface;
 
 IevDocument = interface;
 
 InevDocumentContainer = interface(InevObjectHolder)
  {* Контейнер документа. Служит для связи документа с редакторами, View, и TextSource. }
  function HasDocument: Boolean;
  function IsSame(const aContainer: InevDocumentContainer): Boolean;
  function IsSameText(const aTextSource: IUnknown): Boolean; overload;
  function IsSameText(const aContainer: InevDocumentContainer): Boolean; overload;
  function ReadFrom(const aStream: IStream): Boolean;
  procedure WriteTo(const aGenerator: InevTagGenerator);
  procedure LinkTextSource(const aTextSource: InevTextSource);
  procedure UnlinkTextSource(const aTextSource: InevTextSource);
  function HasProcessor: Boolean;
  procedure RemoveFromDocumentsCache;
  function Internal: IUnknown;
   {* //InevDocumentContainerInternal }
  procedure GetSubFlagsIterator(aLayer: Integer);
  function Preview(const aKey: TevPreviewCacheKey;
   const aMacroReplacer: IafwHAFMacroReplacer;
   const aRange: InevRange;
   TreatRangeAsSelection: Boolean): InevComplexDocumentPreview;
  function RealizeSub(aLayerHandle: Integer;
   Atom: Tl3Variant;
   anObject: Tl3Variant): Tl3Variant; overload;
  function LinkWaiter(const aWaiter: InevWaiter): Boolean;
  function GetGenerator(const aView: InevView;
   const aGeneratorTarget: IUnknown): InevTagGenerator;
  procedure LinkSubChangeListener(const aSubChangeListener: InevSubChangeListener);
  function DefaultDocumentType: Tk2Type;
   {* Тип документа по-умолчанию }
  procedure NotifySubAdded(aParaID: Integer;
   aSubID: Integer;
   aLayerID: Integer;
   const aSubName: Tl3WString;
   aFlags: Integer);
   {* Нотификация о добавлении Sub'а в другом "похожем" документе }
 end;//InevDocumentContainer
 
 TevInsertParaFlag = (
  ev_ipfCheckPrev
  , ev_ipfNeedFire
  , ev_ipfForce
  , ev_ipfAtEnd
 );//TevInsertParaFlag
 
 (*
 MnevParaIterator = interface
 end;//MnevParaIterator
 *)
 
 TevInsertParaFlags = set of TevInsertParaFlag;
 
 InevParaListModify = interface(Il3TagRef)
  {* Утилита для работы с тегом как со списком параграфов. }
  function InsertPara(aPID: TnevParaIndex;
   aPara: Tl3Variant;
   const anOp: InevOp;
   aFlags: TevInsertParaFlags): Boolean;
   {* вставляет параграф в указанную позицию. }
  function InsertDefaultPara(aPID: TnevParaIndex;
   const anOp: InevOp;
   aNeedFire: Boolean): Boolean;
   {* вставляет параграф с типом по-умолчанию в указанную позицию. }
 end;//InevParaListModify
 
 InevParas = interface
  {* Отдельно стоящий список параграфов. Не является элементом структуры документа. Служит для пакетных операций над пачкой параграфов. }
 end;//InevParas
 
 InevParaList_IteratePara_Action = function(const anItem: InevPara;
  anIndex: Integer): Boolean;
  {* Тип подитеративной функции для InevParaList.IteratePara }
 
 InevParaList = interface(InevPara)
  {* Утилита для работы с тегом как со списком параграфов без возможности модификации. }
  procedure IteratePara;
  function GetParas(aFrom: TnevParaIndex;
   aTo: TnevParaIndex): InevParas;
   {* возвращает список параграфов. }
  function Modify: InevParaListModify;
 end;//InevParaList
 
 TnevPoint = nevBase.TnevPoint;
 
 TnevRect = nevBase.TnevRect;
 
 TevMouseState = TnevMouseState;
 
 TevNeighbourPos = (
  {* Позиция соседа. }
  ev_npUp
  , ev_npDown
  , ev_npDownInternal
 );//TevNeighbourPos
 
 InevComplexDocumentPreview = nevBase.InevComplexDocumentPreview;
 
 TevMouseEffect = TnevMouseEffect;
 
 InevOp = nevBase.InevOp;
 
 InevProcessor = nevBase.InevProcessor;
 
 TnevFramePart = nevBase.TnevFramePart;
 
 InevScrollListener = nevBase.InevScrollListener;
 
 InevCanvas = nevBase.InevCanvas;
 
 TevCursorState = TnevCursorState;
 
 InevProgress = nevBase.InevProgress;
 
 TnevColor = nevBase.TnevColor;
 
 InevInfoCanvas = nevBase.InevInfoCanvas;
 
 InevSimpleTree = nevBase.InevSimpleTree;
 
 InevViewMetrics = nevBase.InevViewMetrics;
 
 InevSimpleNode = nevBase.InevSimpleNode;
 
 InevNode = nevBase.InevNode;
 
 TevLoadDocFlag = (
  {* Флаг генерации }
  ev_ldfDocumentReaded
 );//TevLoadDocFlag
 
 TevLoadDocFlags = set of TevLoadDocFlag;
  {* Флаги генерации }
 
 (*
 BasePrimitives = interface
  {* Базовые типы }
 end;//BasePrimitives
 *)
 
 InevSubList_Iterate_Action = function(const anItem: IevSub;
  anIndex: Integer): Boolean;
  {* Тип подитеративной функции для InevSubList.Iterate }
 
 IevDocumentPart = interface;
 
 InevSubList = interface
  {* Список меток. }
  procedure Iterate;
   {* Перебирает список меток }
 end;//InevSubList
 
 IevSub = interface
  {* Точка входа (метка) }
  function IsVisibleOnSubPanel: Boolean;
  procedure SetTo(EntryPoint: Tl3Variant);
   {* устанавливает метку в EntryPoint. }
  function Select(const Selection: InevSelection): Boolean;
   {* перемещает Selection на данную метку. }
  function Delete(const aView: InevView): Boolean;
   {* удаляет метку. }
  function IsInIndex: Boolean;
  function Exists: Boolean;
   {* проверяет существует ли такая метка. }
  function SubInstance: Tl3Variant;
   {* собственно Sub. }
  function AsObject: Tl3Variant;
 end;//IevSub
 
 InevTool = interface
 end;//InevTool
 
 InevTextSource = interface
  {* Источник документа. Служит для связи документа с редакторами и View }
  function CastAnyEditorTo(const IID: TGUID;
   out theObj): Boolean;
  procedure DocumentChanged(anOldDocument: Tl3Variant;
   aNewDocument: Tl3Variant);
  procedure MakeCursor;
  function GetSubFlags(aLayer: Integer;
   const aSubList: InevSubList): Boolean;
  function GetControlData(const aControl: IevControl): IUnknown;
   {* возвращает данные для контрола. }
  function GetControlImg(const aControl: TnevControlInfo;
   out theImageInfo: TnevControlImageInfo): Boolean;
   {* возвращает картинки для контрола. }
  procedure PropChanged(Prop: Tk2Prop;
   const V: TnevValues;
   const anOpPack: InevOp);
 end;//InevTextSource
 
 TevContentsRec = object
 end;//TevContentsRec
 
 IevDocumentPart = interface(IevSub)
  {* Структурный блок документа. }
  function Merge: Boolean;
   {* объединяет блок со следующим. }
  function GetViewKind: TevBlockViewKind;
 end;//IevDocumentPart
 
 IevDocument = interface(IevDocumentPart)
  {* Документ. }
 end;//IevDocument
 
 InevActiveElement = interface
  {* Активный элемент текста }
  procedure Invalidate;
   {* Перерисовывает область активного элемента }
  function IsSame(const anElement: InevActiveElement): Boolean;
 end;//InevActiveElement
 
 PInevObject = ^InevObject;
 
 HnevView = object
  {* Обёртка над InevView }
 end;//HnevView
 
 InevCommentSwitcher = interface
 end;//InevCommentSwitcher
 
 InevRestartPositionSource = interface
  {* Источник позиции перезапуска searcher'а }
 end;//InevRestartPositionSource
 
 InevDocumentProvider = interface(InevStorable)
  {* Поставщик документа }
 end;//InevDocumentProvider
 
 InevControlListener = interface
  function CanInsertPara: Boolean;
   {* Разрешено ли вставлять параграф. }
  procedure InsertOnUndo(aPrev: Tl3Variant;
   aChild: Tl3Variant;
   anAdd: Boolean);
   {* Реакция на вставку при откатке. }
  procedure DeleteOnUndo(aTag: Tl3Variant);
   {* Реакция удаления при откатке. }
  procedure HideDroppedControl(CanSetFocus: Boolean);
   {* Обработчик изменения события состояния редактора (нужно для выпадающего контрола). }
  function MouseWheel(aDown: Boolean): Boolean;
   {* Событие прокрутки мыши. }
  function KeyDown(const aView: InevView;
   var Msg: TWMKeyDown;
   aCurPara: Tl3Variant): Boolean;
   {* Посылка сообщений о нажатии клавиш. }
  procedure ChangePara(const aCurPara: InevPara);
   {* Событие смена текуего параграфа. }
  procedure BeforeRMouseClick;
   {* Событие, вызываемое перед обработкой мыши. }
  procedure ClearUpper;
  function NeedKey(aPara: Tl3Variant;
   var aKeyCode: Word): Boolean;
   {* Контрол/Поле перехватывает курсор. }
  procedure CursorCreate;
   {* Обновить курсор после создания. }
  procedure UpdateState;
  function IsLastField(aPara: Tl3Variant): Boolean;
   {* Проверяет является ли параграф последним для передачи фокуса. }
  function IsFirstField(aPara: Tl3Variant): Boolean;
   {* Проверяет является ли параграф первым для передачи фокуса. }
  procedure StartPaste;
   {* Скобки для операции вставки. }
  procedure FinishPaste;
   {* Скобки для операции вставки. }
  function IsPasting: Boolean;
   {* Внутри скобок для операции вставки. }
  function GetFirstPara(OnlyFields: Boolean): InevPara;
   {* Получить первый параграф, в который может получить фокус. }
  function GetLastPara(OnlyFields: Boolean): InevPara;
   {* Получить последний параграф, в который может получить фокус. }
 end;//InevControlListener
 
 InevQueryDocumentContainer = interface(InevDocumentContainer)
  function GetCurrPara: Tl3Variant;
  procedure SetCursorToPara(const aPara: InevPara;
   bAtEnd: Boolean;
   aNeedClear: Boolean);
   {* Устанавливает курсор на определенный параграф. }
  procedure ClearCard;
   {* Обработчик очистки КЗ. }
  procedure AfterCollapsed;
  procedure ReleaseListeners;
  procedure LinkListener(const aListener: InevControlListener);
  procedure UnlinkListener(const aListener: InevControlListener);
 end;//InevQueryDocumentContainer
 
 IevRange = interface
  {* Выделение }
  procedure AssignSel(const aView: InevView;
   const aSource: InevRange);
   {* присваивает одно выделение другому }
  function GetBlock: InevRange;
   {* получить текущий объект выделения }
  procedure SetToStart;
   {* установить выделение в начало }
  function Unselect(const aView: InevView): Boolean;
   {* снять выделение }
  procedure SetToFinish(aMoveUpInLines: Integer);
 end;//IevRange
 
 TnevPointByPtMode = (
  {* Режим получения точки из списка отрисованных. }
  nev_ppmNone
   {* Обычные параметры. }
  , nev_ppmNeedAnchor
   {* Инициализация якоря (для строк таблицы инициализируется базовая линия). }
  , nev_ppmCheckHidden
   {* Проверка невидимых, но отрисованных шейпов - для поиска начальных частей объединенной ячейки. }
  , nev_ppmSetCursor
   {* Получение точки при установке курсора. Если найдена ячейка-продолжения объединенной, то пытаемся получить Head-ячейку. }
  , nev_ppmNeedAnchorWithSimpleBaseLine
   {* Получение якоря с не полностью инициализированной базовой линией. }
 );//TnevPointByPtMode
 
 IevDocumentPoint = interface
  function Select(const Selection: InevSelection): Boolean;
   {* перемещает Selection на данную метку. }
 end;//IevDocumentPoint
 
 IevCommonControl = interface(InevPara)
  {* Базовый интерфейс для всех контрол-подобных элементов. }
 end;//IevCommonControl
 
 IevControl = interface(IevCommonControl)
  {* Контрол ввода. }
 end;//IevControl
 
 InevLeafPara = interface(InevPara)
  {* Утилита для работы с тегом как с листьевым параграфом. }
 end;//InevLeafPara
 
 InevTextPara = interface(InevLeafPara)
  {* Утилита для работы с тегом как с текстовым параграфом. }
 end;//InevTextPara
 
 InevTable = interface(InevParaList)
  {* Инструмент для работы с таблицей. }
  procedure AddRow(aColCount: Integer;
   aColumnWidth: Integer;
   aFramed: Boolean);
   {* Добавляет в таблицу строку с колонками одинаковой ширины aColumnWidth. 
         Если aFramed выставлен, то для каждой ячейки добавляются рамки. }
 end;//InevTable
 
 InevTableRow = interface(InevParaList)
  function FindCell(aStart: Integer;
   aWidth: Integer;
   aRight: Boolean): TnevParaIndex;
   {* Пытается найти ячейку по смещению и по ширине. }
 end;//InevTableRow
 
 TnevFindCell = (
  {* <?> Коллеги, это что? }
  fc_Up
  , fc_Down
  , fc_DownInternal
 );//TnevFindCell
 
 InevTableCell = interface(InevParaList)
  {* Инструмент для работы с ячейками. }
  function GetMergeHead(anIgnoreMergeStatus: Boolean): InevTableCell;
   {* Возвращает первую ячейку в объединении. }
  function GetContinueCell(aNeedValidate: Boolean;
   aWhereFind: TnevFindCell): InevTableCell;
   {* Возвращает нижнюю ячейку объединения, если такая существует. }
  function GetContinueCellInRow(const aRow: InevPara;
   aWhereFind: TnevFindCell): InevTableCell;
  function GetHeadCellPara(anIgnoreMergeStatus: Boolean): InevPara;
  function GetContinueCellPara(aNeedValidate: Boolean;
   aWhereFind: TnevFindCell): InevPara;
  function CheckCellWidth(aValue: Integer;
   aOuterWidth: Integer): Integer;
  function IsEmptyCell: Boolean;
  function GetUpperCell: InevPara;
   {* Возвращает ячейку сверху. }
 end;//InevTableCell
 
 (*
 Paragraphs = interface
  {* "Папка" с параграфами }
 end;//Paragraphs
 *)
 
 InevPrintView = interface(InevView)
  {* Область печати. }
 end;//InevPrintView
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
