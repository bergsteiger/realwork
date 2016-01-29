unit nevBase;

interface

uses
 l3IntfUses
 , evdInterfaces
 , l3Interfaces
 , l3Types
 , l3InternalInterfaces
 , evdStyles
 , k2Prim
 , k2Interfaces
 , l3Tree_TLB
 , l3TreeInterfaces
 , afwInterfaces
 , l3Variant
 , k2BaseStruct
 , k2Tags
 , evdTypes
 , SysUtils
 , l3ProtoObject
 , evResultFontInterfaces
 , k2Base
 , l3CustomString
 , l3Core
;

type
 InevBase = interface(Il3Base)
  {* Базовый интерфейс для наследования остальных. }
 end;//InevBase
 
 TnevInch = type Integer;
  {* дюймы. }
 
 InevMetricsPrim = interface
  {* Метрики отображения. }
 end;//InevMetricsPrim
 
 TnevStr = Tl3PCharLen;
  {* строка. }
 
 TnevParaIndex = type Integer;
  {* Индекс параграфа. }
 
 TnevParaLevel = type Integer;
 
 InevInfoCanvas = Il3InfoCanvas;
  {* Информационная канва. }
 
 TnevStandardStyles = TevStandardStyles;
 
 TnevPosition = type Integer;
 
 InevOp = Il3OpPack;
 
 TevLoadFlag = (
  ev_lfInternal
  , ev_lfNeedJoin
  , ev_lfAtEnd
  , ev_lfSkipSubdocuments
 );//TevLoadFlag
 
 TevLoadFlags = set of TevLoadFlag;
 
 InevProcessor = Ik2Processor;
 
 InevFont = Il3Font;
  {* Шрифт. }
 
 InevTree = Il3Tree;
 
 InevSimpleTree = Il3SimpleTree;
 
 InevSimpleNode = Il3SimpleNode;
 
 InevNode = Il3Node;
 
 TnevColor = Tl3Color;
  {* Цвет. }
 
 TnevFormat = Tl3ClipboardFormat;
  {* Формат данных в буфере обмена. }
 
 InevMetrics = interface(InevMetricsPrim)
  {* Метрики отображения. }
 end;//InevMetrics
 
 InevTagTool = Ik2TagTool;
 
 InevCanvas = Il3Canvas;
  {* Канва. }
 
 InevCommandProcessor = Il3CommandProcessor;
  {* Процессор команд. }
 
 IevAnchorIndex = interface
  {* Индекс меток }
  procedure Delete(Layer: Integer;
   Handle: Integer);
   {* удаляет метку из индекса. }
 end;//IevAnchorIndex
 
 IevTable = interface
  {* Таблица (см. IedTable) }
  procedure InsertRows(NumRows: Integer;
   aAtEnd: Boolean);
   {* вставляет NumRows строк в текущее место таблицы. }
  procedure InsertColumns(NumColumns: Integer);
   {* вставляет NumColumns столбцов в текущее место таблицы. }
  procedure DeleteRow;
   {* удалить текущую строку таблицы. }
  procedure DeleteColumn;
   {* удалить столбец таблицы. }
 end;//IevTable
 
 TnevPoint = TafwPoint;
 
 InevShapePrim = IafwShape;
 
 TnevRect = TafwRect;
 
 InevImageList = Il3ImageList;
 
 TnevMouseState = TafwMouseState;
 
 InevScrollListener = IafwScrollListener;
 
 InevComplexDocumentPreview = IafwComplexDocumentPreview;
 
 TnevCursorState = TafwCursorState;
 
 TnevMouseEffect = TafwMouseEffect;
 
 InevLines = Il3Lines;
 
 InevHAFPainter = Il3HAFPainter;
 
 TnevSPoint = TafwSPoint;
 
 InevTagGenerator = Ik2TagGenerator;
 
 InevReader = Ik2TagReader;
 
 TnevValues = Tk2Values;
 
 TnevFontParam = Tk2FontParam;
 
 InevProgress = Il3Progress;
 
 InevRootNode = Il3RootNode;
 
 InevDocumentPreview = IafwDocumentPreview;
 
 InevMultiDocumentPreview = IafwMultiDocumentPreview;
  {* Предварительный просмотр нескольких документов пачкой. }
 
 TnevFramePart = Tl3FramePart;
 
 TevStoreFlags = TevdStoreFlags;
 
 TnevShapePart = (
  nev_spExtent
  , nev_spSegments
  , nev_spCellExtent
 );//TnevShapePart
 
 TnevShapeParts = set of TnevShapePart;
 
 (*
 MnevShape = interface
  {* Визуально отображаемый объект }
  function AppliesToMaxWidth: Boolean;
  procedure Invalidate(aParts: TnevShapeParts);
   {* Сообщает о необходимости перерисовать форму, если она отображается в каком-нибудь View. }
 end;//MnevShape
 *)
 
 (*
 MnevObject = interface
  {* Объект }
  function IsList: Boolean;
 end;//MnevObject
 *)
 
 InevTabStops = Il3TabStops;
 
 TevNormalSegLayerHandleSet = evdTypes.TevNormalSegLayerHandleSet;
 
 TnevControlImageInfo = record
 end;//TnevControlImageInfo
 
 PnevControlImageInfo = ^TnevControlImageInfo;
 
 TevPreviewCacheKey = record
 end;//TevPreviewCacheKey
 
 TevUpdateWindowFlag = (
  ev_uwfCursor
  , ev_uwfScrollCaret
  , ev_uwfBlock
  , ev_uwfRegion
  , ev_uwfWasScroll
  , ev_uwfPara
  , ev_uwfRuler
  , ev_uwfText
   {* Текст менялся }
  , ev_uwfForceHScroll
   {* Проверить горизонтальный скроллер }
 );//TevUpdateWindowFlag
 
 TevUpdateWindowFlags = set of TevUpdateWindowFlag;
 
 TnevDecorType = (
  {* Тип элемента декора }
  nev_dtHeader
  , nev_dtFooter
 );//TnevDecorType
 
 TnevAACLikeMode = (
  nev_aacNone
  , nev_aacLeft
   {* левая половина заголовка ЭР }
  , nev_aacRight
   {* правая половина заголовка ЭР }
  , nev_aacTextLeft
   {* левая половина документа ЭР }
  , nev_aacTextRight
   {* правая половина документа ЭР }
 );//TnevAACLikeMode
 
 TnevFormatInfoPrim = class;
 
 (*
 MnevDocumentContainerDecorationRules = interface
  {* Правила оформления декораций в контейнере документа }
  function AllowsThisDecor(aFI: TnevFormatInfoPrim;
   aType: TnevDecorType): Boolean;
   {* Разрешает ли контейтер документа применять указанное декорирование }
 end;//MnevDocumentContainerDecorationRules
 *)
 
 EnevMaybeBaseSwitched = class(Exception)
  {* Наверное переключили базы }
 end;//EnevMaybeBaseSwitched
 
 EnevMaybePreviewCancelled = class(Exception)
  {* Наверное прервали построение Preview }
 end;//EnevMaybePreviewCancelled
 
 TnevRubberTablesMode = (
  nev_rtmNone
  , nev_rtmZoom
  , nev_rtmFitToWindow
 );//TnevRubberTablesMode
 
 InevObjectPrim = interface;
 
 InevViewMetrics = interface(InevMetrics)
  function NeedTotalRecalc: Boolean;
  function IsTagCollapsed(aTag: Tl3Variant): Boolean;
  function AllowsThisDecor(aFI: TnevFormatInfoPrim;
   aType: TnevDecorType): Boolean;
   {* Разрешает ли контейтер документа применять указанное декорирование }
 end;//InevViewMetrics
 
 (*
 MnevShapeDeprecated = interface
  function ClientToParent(anX: Integer;
   aParentLevel: TnevParaLevel): Integer;
  function ParentToClient(const aPt: TnevPoint;
   aParentLevel: TnevParaLevel): TnevPoint;
 end;//MnevShapeDeprecated
 *)
 
 (*
 MnevFontCalculator = interface
  function GetObjFont(aCorrectItalic: Boolean): IevResultFont;
 end;//MnevFontCalculator
 *)
 
 (*
 MnevShapeTools = interface
  function InPara(aTypeID: Tk2Type): Boolean;
   {* Находится ли объект в родителе указанного типа или сам является таковым }
  function VerticalAlignmentMargin: Integer;
   {* Возвращает смещение параграфа от верхней границы, в зависимости от вертикального выравнивания. }
 end;//MnevShapeTools
 *)
 
 (*
 MnevShapeDim = interface
  function Height: Integer;
  function Width: Integer;
 end;//MnevShapeDim
 *)
 
 (*
 MnevFormatInfoForMergedTablesMayBe = interface
  function CompareWithMax(anIndex: Integer): Integer;
   {* Сравнить точку с индексом anIndex с максимальной }
  procedure UpdateHeitghPart(anIndex: Integer;
   aValue: Integer);
  function GreatestObjPID(anInLines: Boolean): Integer;
 end;//MnevFormatInfoForMergedTablesMayBe
 *)
 
 (*
 MnevFormatInfoForTextPara = interface
  function Lines: InevLines;
  function ViewSegments: Tl3Variant;
 end;//MnevFormatInfoForTextPara
 *)
 
 (*
 MnevObjInfo = interface
  function IsHidden(aRecursive: Boolean;
   aNeedCheckCollapsed: Boolean): Boolean;
  function IsHiddenPrim: Boolean;
 end;//MnevObjInfo
 *)
 
 (*
 MFormatInfoForSBS = interface
  {* Поддержка работы с подписями }
  function CalcClientValue4Column(aColumnID: Integer): Integer;
  procedure ResizeColumn(aColumnID: Integer;
   aValue: Integer;
   const aContext: InevOp);
 end;//MFormatInfoForSBS
 *)
 
 (*
 MnevFormatInfo = interface
  function rLimitWidth: Integer;
 end;//MnevFormatInfo
 *)
 
 (*
 MnevDecor = interface
  function DecorFormatInfo(aType: TnevDecorType): TnevFormatInfoPrim;
  function DecorHeight(aType: TnevDecorType): Integer;
  function DecorObj(aType: TnevDecorType): Tl3Variant;
 end;//MnevDecor
 *)
 
 TnevFormatInfoPrim = class(Tl3ProtoObject)
  {* Информация о форматировании }
  function InfoForChild(const aChild: InevObjectPrim): TnevFormatInfoPrim;
  function ViewSegments: Tl3Variant;
  function rLimitWidth: Integer;
  function Width: Integer;
  function Height: Integer;
  function Lines: InevLines;
  function DeltaHeight: Integer;
   {* максимум высот объединённых ячеек, которые кончаются в этой строке }
  function CompareWithMax(anIndex: Integer): Integer;
   {* Сравнить точку с индексом anIndex с максимальной }
  procedure UpdateHeitghPart(anIndex: Integer;
   aValue: Integer);
  function MaxLinesCount: Integer;
  function Zoom: Integer;
   {* Масштаб }
  function Hidden: Boolean;
   {* Объект спрятан }
  function DecorFormatInfo(aType: TnevDecorType): TnevFormatInfoPrim;
  function DecorObj(aType: TnevDecorType): Tl3Variant;
  function FirstIndent: Integer;
  function FrameTextFont: InevFont;
  function DecorHeight(aType: TnevDecorType): Integer;
  function ClientToParent(anX: Integer;
   aParentLevel: TnevParaLevel): Integer;
  function ParentToClient(const aPt: TnevPoint;
   aParentLevel: TnevParaLevel): TnevPoint;
  function Font: InevFont;
  function GetObjFont(aCorrectItalic: Boolean): IevResultFont;
  function Rendered: Il3Bitmap;
  function LineSpacing: Integer;
  function IsHidden(aRecursive: Boolean;
   aNeedCheckCollapsed: Boolean): Boolean;
  function IsHiddenPrim: Boolean;
  function InPara(aTypeID: Tk2Type): Boolean;
   {* Находится ли объект в родителе указанного типа или сам является таковым }
  function ImageInfo: PnevControlImageInfo;
  function Metrics: InevViewMetrics;
  function Spacing: TnevRect;
  function Obj: InevObjectPrim;
   {* Объект, для котороо создано данное форматирование }
  function CalcClientValue4Column(aColumnID: Integer): Integer;
  procedure ResizeColumn(aColumnID: Integer;
   aValue: Integer;
   const aContext: InevOp);
  function VerticalAlignmentMargin: Integer;
   {* Возвращает смещение параграфа от верхней границы, в зависимости от вертикального выравнивания. }
  function GreatestObjPID(anInLines: Boolean): Integer;
 end;//TnevFormatInfoPrim
 
 TOverlapType = TevMergeStatus;
 
 (*
 MnevShapePrim = interface
  function NeedIncludeHeight(aCheckType: Boolean): Boolean;
   {* Нужно ли учитывать высоту объекта при подсчете высоты родительского. }
  function IsHiddenPrim(aMap: TnevFormatInfoPrim;
   aHiddenStyles: TnevStandardStyles): Boolean;
 end;//MnevShapePrim
 *)
 
 (*
 MnevStringCache = interface
  function CheckS(i: Integer): Tl3CustomString;
 end;//MnevStringCache
 *)
 
 InevStringCache = interface
  function CheckS(i: Integer): Tl3CustomString;
 end;//InevStringCache
 
 (*
 MnevObjectData = interface
 end;//MnevObjectData
 *)
 
 InevObjectHolderPrim = interface;
 
 InevObjectPrim = interface(InevTagTool)
  {* Объект }
  function DecorObj(aType: TnevDecorType): Tl3Variant;
  function IsLegalComment: Boolean;
   {* Юридический комментарий? }
  function IsDecorationElement: Boolean;
  function IsList: Boolean;
  function NeedIncludeHeight(aCheckType: Boolean): Boolean;
   {* Нужно ли учитывать высоту объекта при подсчете высоты родительского. }
  function IsHiddenPrim(aMap: TnevFormatInfoPrim;
   aHiddenStyles: TnevStandardStyles): Boolean;
 end;//InevObjectPrim
 
 TnevControlInfo = object
 end;//TnevControlInfo
 
 InevObjectHolderPrim = interface(Il3ChangeNotifier)
  function GetControlImg(const aControl: TnevControlInfo;
   out theImageInfo: TnevControlImageInfo): Boolean;
 end;//InevObjectHolderPrim
 
 (*
 ConstantsHolder = interface
 end;//ConstantsHolder
 *)
 
 TInevFormatInfoRet = TnevFormatInfoPrim;
 
 Tl3Variant = l3Variant.Tl3Variant;
 
implementation

uses
 l3ImplUses
;

end.
