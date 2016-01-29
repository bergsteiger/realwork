unit nevBase;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevBase.pas"
// Начат: 23.09.2005 17:01
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<InternalInterfaces::Category>> Shared Delphi::Everest::nevBase
//
// Базовые интерфейсы библиотеки Эверест.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\new\nevDefine.inc}

interface

uses
  l3Interfaces,
  k2Interfaces,
  l3Types,
  afwInterfaces,
  l3InternalInterfaces,
  l3TreeInterfaces,
  evdTypes,
  l3Core,
  evdStyles,
  l3Chars,
  evConst,
  l3Tree_TLB,
  k2Tags,
  evdInterfaces,
  l3CustomString,
  SysUtils,
  k2Base,
  l3ProtoObject,
  k2Prim,
  k2BaseStruct,
  evResultFontInterfaces,
  l3Variant
  ;

type
 InevBase = interface(Il3Base)
  {* Базовый интерфейс для наследования остальных. }
   ['{1532D13B-6E48-4307-933D-22C86383A2E0}']
 end;//InevBase

 TnevInch = type System.Integer;
  {* дюймы. }

 InevMetricsPrim = interface(InevBase)
  {* Метрики отображения. }
   ['{C4B2D092-BFB3-4B0D-8CFE-E0F514C4360A}']
   function pm_GetLimitWidth: TnevInch;
   property LimitWidth: TnevInch
     read pm_GetLimitWidth;
 end;//InevMetricsPrim

 TnevStr = l3Types.Tl3PCharLen;
  {* строка. }

 TnevParaIndex = type System.Integer;
  {* Индекс параграфа. }

 TnevParaLevel = type System.Integer;

 InevInfoCanvas = l3InternalInterfaces.Il3InfoCanvas;
  {* Информационная канва. }

 TnevStandardStyles = evdStyles.TevStandardStyles;

 TnevPosition = type System.Integer;

 InevOp = k2Prim.Il3OpPack;

const
  { Относительные уровни параграфов. }
 nev_plThis = TnevParaLevel(0);
 nev_plNearest = TnevParaLevel(1);
 nev_plTopmost = High(TnevParaLevel);
  { Индексы параграфов. }
 nev_piNull = TnevParaIndex(-1);
  { отсутствующий параграф. }
 nev_piFirst = TnevParaIndex(0);
  { первый параграф. }
 nev_piLast = High(TnevParaIndex);
  { последний параграф. }
  { Inches }
 nevInch = TnevInch(evInchMul);
  { дюйм. }
 nevTop = TnevInch(0);
  { минимальная позиция по горизонтали/вертикали. }
 nevBottom = High(TnevInch);
  { максимальная позиция по горизонтали/вертикали. }
  { CodePages }
 CP_DefaultValue = l3Chars.CP_DefaultValue;

type
 TevLoadFlag = (
   ev_lfInternal
 , ev_lfNeedJoin
 , ev_lfAtEnd
 , ev_lfSkipSubdocuments
 );//TevLoadFlag

 TevLoadFlags = set of TevLoadFlag;

const
  { CompareResults }
 nev_MinusDiff = Low(Integer);
  { отрицательная разница сравнения. }
 nev_PlusDiff = High(Integer);
  { положительная разница сравнения. }
  { LoadDefaults }
 evDefaultLoadFlags = [ev_lfNeedJoin, ev_lfSkipSubdocuments];
 evDefaultCopyFlags = evDefaultLoadFlags - [ev_lfNeedJoin];

type
 InevProcessor = k2Interfaces.Ik2Processor;

 InevFont = l3Interfaces.Il3Font;
  {* Шрифт. }

 InevTree = l3Tree_TLB.Il3Tree;

 InevSimpleTree = l3TreeInterfaces.Il3SimpleTree;

 InevSimpleNode = l3TreeInterfaces.Il3SimpleNode;

 InevNode = l3Tree_TLB.Il3Node;

 TnevColor = l3Interfaces.Tl3Color;
  {* Цвет. }

 TnevFormat = l3Interfaces.Tl3ClipboardFormat;
  {* Формат данных в буфере обмена. }

 InevMetrics = interface(InevMetricsPrim)
  {* Метрики отображения. }
   ['{AF2281DE-4C1A-48A3-8B1B-F343523E693B}']
   function pm_GetInfoCanvas: InevInfoCanvas;
   function Get_FormatCanvas: InevInfoCanvas;
   property InfoCanvas: InevInfoCanvas
     read pm_GetInfoCanvas;
     {* информационный контекст устройства, для которого надо форматировать параграфы. }
   property FormatCanvas: InevInfoCanvas
     read Get_FormatCanvas;
     {* Канва для форматирования. [$157450362] }
 end;//InevMetrics

 InevTagTool = k2Interfaces.Ik2TagTool;

 InevCanvas = l3InternalInterfaces.Il3Canvas;
  {* Канва. }

 InevCommandProcessor = l3InternalInterfaces.Il3CommandProcessor;
  {* Процессор команд. }

 IevAnchorIndex = interface(InevBase)
  {* Индекс меток }
   ['{4A9029DA-6827-4AC3-BA09-82E6979A91D4}']
   procedure Delete(Layer: Integer;
    Handle: Integer);
     {* удаляет метку из индекса. }
 end;//IevAnchorIndex

 IevTable = interface(InevBase)
  {* Таблица (см. IedTable) }
   ['{2C49178B-853E-4739-ACFB-64154CE2C4E7}']
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

 TnevPoint = afwInterfaces.TafwPoint;

 InevShapePrim = afwInterfaces.IafwShape;

 TnevRect = afwInterfaces.TafwRect;

 InevImageList = l3InternalInterfaces.Il3ImageList;

 TnevMouseState = afwInterfaces.TafwMouseState;

 InevScrollListener = afwInterfaces.IafwScrollListener;

 InevComplexDocumentPreview = afwInterfaces.IafwComplexDocumentPreview;

 TnevCursorState = afwInterfaces.TafwCursorState;

 TnevMouseEffect = afwInterfaces.TafwMouseEffect;

 InevLines = l3Interfaces.Il3Lines;

 InevHAFPainter = l3InternalInterfaces.Il3HAFPainter;

 TnevSPoint = afwInterfaces.TafwSPoint;

 InevTagGenerator = l3Variant.Ik2TagGenerator;

 InevReader = k2Interfaces.Ik2TagReader;

 TnevValues = k2BaseStruct.Tk2Values;

 TnevFontParam = k2Tags.Tk2FontParam;

 InevProgress = l3Interfaces.Il3Progress;

 InevRootNode = l3Tree_TLB.Il3RootNode;

 InevDocumentPreview = afwInterfaces.IafwDocumentPreview;

 InevMultiDocumentPreview = afwInterfaces.IafwMultiDocumentPreview;
  {* Предварительный просмотр нескольких документов пачкой. }

 TnevFramePart = l3Interfaces.Tl3FramePart;

 TevStoreFlags = evdInterfaces.TevdStoreFlags;

const
  { StoreDefaults }
 evDefaultStoreFlags = evdInterfaces.evd_DefaultStoreFlags;

type
  TnevShapePart = (
    nev_spExtent
  , nev_spSegments
  , nev_spCellExtent
  );//TnevShapePart

  TnevShapeParts = set of TnevShapePart;

(*
 MnevShape = PureMixIn
  {* Визуально отображаемый объект }
   function AppliesToMaxWidth: Boolean;
   procedure Invalidate(aParts: TnevShapeParts);
     {* Сообщает о необходимости перерисовать форму, если она отображается в каком-нибудь View. }
 end;//MnevShape
*)

(*
 MnevObject = PureMixIn
  {* Объект }
   function pm_GetPID: TnevParaIndex;
   function IsList: Boolean;
   property PID: TnevParaIndex
     read pm_GetPID;
     {* индекс параграфа в родителе. }
 end;//MnevObject
*)

 InevTabStops = l3Interfaces.Il3TabStops;

 TevNormalSegLayerHandleSet = evdTypes.TevNormalSegLayerHandleSet;

 TnevControlImageInfo = record
   rImageList : InevImageList;
   rFirstIndex : Integer;
   rLastIndex : Integer;
   rLeftIndent : Integer;
   rPictureOnly : Boolean; // Определяется на основе стиля. True только для стилей правовой энциклопедии.
   rHidePicture : Boolean; // Обновляется при каждом получении структуры.
 end;//TnevControlImageInfo

 PnevControlImageInfo = ^TnevControlImageInfo;

 TevPreviewCacheKey = record
   HiddenStyles : TevStandardStyles;
   CaleeArea : TafwPreviewCaleeArea;
 end;//TevPreviewCacheKey

 TevUpdateWindowFlag = (
   ev_uwfCursor
 , ev_uwfScrollCaret
 , ev_uwfBlock
 , ev_uwfRegion
 , ev_uwfWasScroll
 , ev_uwfPara
 , ev_uwfRuler
 , ev_uwfText // Текст менялся
 , ev_uwfForceHScroll // Проверить горизонтальный скроллер
 );//TevUpdateWindowFlag

 TevUpdateWindowFlags = set of TevUpdateWindowFlag;

 TnevDecorType = (
  {* Тип элемента декора }
   nev_dtHeader
 , nev_dtFooter
 );//TnevDecorType

 TnevAACLikeMode = (
   nev_aacNone
 , nev_aacLeft // левая половина заголовка ЭР
 , nev_aacRight // правая половина заголовка ЭР
 , nev_aacTextLeft // левая половина документа ЭР
 , nev_aacTextRight // правая половина документа ЭР
 );//TnevAACLikeMode

 TnevFormatInfoPrim = class;


(*
 MnevDocumentContainerDecorationRules = PureMixIn
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
 { - предварительное описание InevObjectPrim. }

 InevViewMetrics = interface(InevMetrics)
   ['{F727E8B4-54BC-4980-BF0D-5D3635152090}']
   function pm_GetIsWebStyle: Boolean;
   function pm_GetShowDocumentParts: Boolean;
   function pm_GetShowSpecial: Boolean;
   function pm_GetHiddenStyles: TnevStandardStyles;
   function pm_GetExtent: TnevPoint;
   function Get_ExcludeSuper: TevNormalSegLayerHandleSet;
   function Get_AACLike: TnevAACLikeMode;
   function Get_AllowRubberTables: TnevRubberTablesMode;
   function Get_Data: InevObjectPrim;
   function IsTagCollapsed(aTag: Tl3Variant): Boolean;
   property IsWebStyle: Boolean
     read pm_GetIsWebStyle;
   property ShowDocumentParts: Boolean
     read pm_GetShowDocumentParts;
     {* показывать ли блочную структуру документа? }
   property ShowSpecial: Boolean
     read pm_GetShowSpecial;
   property HiddenStyles: TnevStandardStyles
     read pm_GetHiddenStyles;
   property Extent: TnevPoint
     read pm_GetExtent;
   property ExcludeSuper: TevNormalSegLayerHandleSet
     read Get_ExcludeSuper;
     {* Отключаемые при отображении слои }
   property AACLike: TnevAACLikeMode
     read Get_AACLike;
   property AllowRubberTables: TnevRubberTablesMode
     read Get_AllowRubberTables;
     {* Разрешены ли резиновые таблицы }
   property Data: InevObjectPrim
     read Get_Data;
  // MnevDocumentContainerDecorationRules
   function AllowsThisDecor(aFI: TnevFormatInfoPrim;
     aType: TnevDecorType): Boolean;
     {* Разрешает ли контейтер документа применять указанное декорирование }
 end;//InevViewMetrics

(*
 MnevShapeDeprecated = PureMixIn
   function ClientToParent(anX: Integer;
    aParentLevel: TnevParaLevel = nev_plTopmost): Integer; virtual; abstract;
   function ParentToClient(const aPt: TnevPoint;
    aParentLevel: TnevParaLevel = nev_plTopmost): TnevPoint; virtual; abstract;
 end;//MnevShapeDeprecated
*)

(*
 MnevFontCalculator = PureMixIn
   function GetObjFont(aCorrectItalic: Boolean): IevResultFont; virtual; abstract;
 end;//MnevFontCalculator
*)

(*
 MnevShapeTools = PureMixIn
   function InPara(aTypeID: Tk2Type): Boolean; virtual; abstract;
     {* Находится ли объект в родителе указанного типа или сам является таковым }
   function VerticalAlignmentMargin: Integer; virtual; abstract;
     {* Возвращает смещение параграфа от верхней границы, в зависимости от вертикального выравнивания. }
 end;//MnevShapeTools
*)

(*
 MnevShapeDim = PureMixIn
   function Get_Spacing: TnevRect; virtual; abstract;
   function Height: Integer; virtual; abstract;
   function Width: Integer; virtual; abstract;
   property Spacing: TnevRect
     read Get_Spacing;
 end;//MnevShapeDim
*)

(*
 MnevFormatInfoForMergedTablesMayBe = PureMixIn
   function Get_DeltaHeight: Integer; virtual; abstract;
   function CompareWithMax(anIndex: Integer): Integer; virtual; abstract;
     {* Сравнить точку с индексом anIndex с максимальной }
   procedure UpdateHeitghPart(anIndex: Integer;
    aValue: Integer); virtual; abstract;
   function GreatestObjPID(anInLines: Boolean = True): Integer; virtual; abstract;
   property DeltaHeight: Integer
     read Get_DeltaHeight;
     {* максимум высот объединённых ячеек, которые кончаются в этой строке }
 end;//MnevFormatInfoForMergedTablesMayBe
*)

(*
 MnevFormatInfoForTextPara = PureMixIn
   function Lines: InevLines; virtual; abstract;
   function ViewSegments: Tl3Variant; virtual; abstract;
 end;//MnevFormatInfoForTextPara
*)

(*
 MnevObjInfo = PureMixIn
   function IsHidden(aRecursive: Boolean;
    aNeedCheckCollapsed: Boolean): Boolean; virtual; abstract;
   function IsHiddenPrim: Boolean; virtual; abstract;
 end;//MnevObjInfo
*)

(*
 MFormatInfoForSBS = PureMixIn
  {* Поддержка работы с подписями }
   function CalcClientValue4Column(aColumnID: Integer): Integer; virtual; abstract;
   procedure ResizeColumn(aColumnID: Integer;
    aValue: Integer;
    const aContext: InevOp); virtual; abstract;
 end;//MFormatInfoForSBS
*)

(*
 MnevFormatInfo = PureMixIn
   function Get_MaxLinesCount: Integer; virtual; abstract;
   function Get_Hidden: Boolean; virtual; abstract;
   function Get_FirstIndent: Integer; virtual; abstract;
   function Get_FrameTextFont: InevFont; virtual; abstract;
   function Get_Font(aCorrectItalic: Boolean): InevFont; virtual; abstract;
   function Get_Rendered: Il3Bitmap; virtual; abstract;
   function Get_LineSpacing: Integer; virtual; abstract;
   function Get_ImageInfo: PnevControlImageInfo; virtual; abstract;
   function Get_Metrics: InevViewMetrics; virtual; abstract;
   function Get_Obj: InevObjectPrim; virtual; abstract;
   function Get_Zoom: Integer; virtual; abstract;
   function RLimitWidth: Integer; virtual; abstract;
   property MaxLinesCount: Integer
     read Get_MaxLinesCount;
   property Hidden: Boolean
     read Get_Hidden;
     {* Объект спрятан }
   property FirstIndent: Integer
     read Get_FirstIndent;
   property FrameTextFont: InevFont
     read Get_FrameTextFont;
   property Font[aCorrectItalic: Boolean]: InevFont
     read Get_Font;
   property Rendered: Il3Bitmap
     read Get_Rendered;
   property LineSpacing: Integer
     read Get_LineSpacing;
   property ImageInfo: PnevControlImageInfo
     read Get_ImageInfo;
   property Metrics: InevViewMetrics
     read Get_Metrics;
   property Obj: InevObjectPrim
     read Get_Obj;
     {* Объект, для котороо создано данное форматирование }
   property Zoom: Integer
     read Get_Zoom;
     {* Масштаб }
 end;//MnevFormatInfo
*)

(*
 MnevDecor = PureMixIn
   function DecorFormatInfo(aType: TnevDecorType): TnevFormatInfoPrim; virtual; abstract;
   function DecorHeight(aType: TnevDecorType): Integer; virtual; abstract;
   function DecorObj(aType: TnevDecorType): Tl3Variant; virtual; abstract;
 end;//MnevDecor
*)

 TnevFormatInfoPrim = {abstract} class(Tl3ProtoObject)
  {* Информация о форматировании }
 protected
 // property methods
   function Get_ParentInfo: TnevFormatInfoPrim; virtual; abstract;
 protected
 // realized methods
   function Get_DeltaHeight: Integer; virtual; abstract;
   function Get_MaxLinesCount: Integer; virtual; abstract;
   function Get_Zoom: Integer; virtual; abstract;
   function Get_Hidden: Boolean; virtual; abstract;
   function Get_FirstIndent: Integer; virtual; abstract;
   function Get_FrameTextFont: InevFont; virtual; abstract;
   function Get_Font(aCorrectItalic: Boolean): InevFont; virtual; abstract;
   function Get_Rendered: Il3Bitmap; virtual; abstract;
   function Get_LineSpacing: Integer; virtual; abstract;
   function Get_ImageInfo: PnevControlImageInfo; virtual; abstract;
   function Get_Metrics: InevViewMetrics; virtual; abstract;
   function Get_Spacing: TnevRect; virtual; abstract;
   function Get_Obj: InevObjectPrim; virtual; abstract;
 public
 // realized methods
   function ViewSegments: Tl3Variant; virtual; abstract;
   function RLimitWidth: Integer; virtual; abstract;
   function Width: Integer; virtual; abstract;
   function Height: Integer; virtual; abstract;
   function Lines: InevLines; virtual; abstract;
   function CompareWithMax(anIndex: Integer): Integer; virtual; abstract;
     {* Сравнить точку с индексом anIndex с максимальной }
   procedure UpdateHeitghPart(anIndex: Integer;
     aValue: Integer); virtual; abstract;
   function DecorFormatInfo(aType: TnevDecorType): TnevFormatInfoPrim; virtual; abstract;
   function DecorObj(aType: TnevDecorType): Tl3Variant; virtual; abstract;
   function DecorHeight(aType: TnevDecorType): Integer; virtual; abstract;
   function ClientToParent(anX: Integer;
     aParentLevel: TnevParaLevel = nev_plTopmost): Integer; virtual; abstract;
   function ParentToClient(const aPt: TnevPoint;
     aParentLevel: TnevParaLevel = nev_plTopmost): TnevPoint; virtual; abstract;
   function GetObjFont(aCorrectItalic: Boolean): IevResultFont; virtual; abstract;
   function IsHidden(aRecursive: Boolean;
     aNeedCheckCollapsed: Boolean): Boolean; virtual; abstract;
   function IsHiddenPrim: Boolean; virtual; abstract;
   function InPara(aTypeID: Tk2Type): Boolean; virtual; abstract;
     {* Находится ли объект в родителе указанного типа или сам является таковым }
   function CalcClientValue4Column(aColumnID: Integer): Integer; virtual; abstract;
   procedure ResizeColumn(aColumnID: Integer;
     aValue: Integer;
     const aContext: InevOp); virtual; abstract;
   function VerticalAlignmentMargin: Integer; virtual; abstract;
     {* Возвращает смещение параграфа от верхней границы, в зависимости от вертикального выравнивания. }
   function GreatestObjPID(anInLines: Boolean = True): Integer; virtual; abstract;
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
 public
 // public methods
   function InfoForChild(const aChild: InevObjectPrim): TnevFormatInfoPrim; virtual; abstract;
 public
 // public properties
   property ParentInfo: TnevFormatInfoPrim
     read Get_ParentInfo;
   property DeltaHeight: Integer
     read Get_DeltaHeight;
     {* максимум высот объединённых ячеек, которые кончаются в этой строке }
   property MaxLinesCount: Integer
     read Get_MaxLinesCount;
   property Zoom: Integer
     read Get_Zoom;
     {* Масштаб }
   property Hidden: Boolean
     read Get_Hidden;
     {* Объект спрятан }
   property FirstIndent: Integer
     read Get_FirstIndent;
   property FrameTextFont: InevFont
     read Get_FrameTextFont;
   property Font[aCorrectItalic: Boolean]: InevFont
     read Get_Font;
   property Rendered: Il3Bitmap
     read Get_Rendered;
   property LineSpacing: Integer
     read Get_LineSpacing;
   property ImageInfo: PnevControlImageInfo
     read Get_ImageInfo;
   property Metrics: InevViewMetrics
     read Get_Metrics;
   property Spacing: TnevRect
     read Get_Spacing;
   property Obj: InevObjectPrim
     read Get_Obj;
     {* Объект, для котороо создано данное форматирование }
 end;//TnevFormatInfoPrim

  TOverlapType = evdTypes.TevMergeStatus;

(*
 MnevShapePrim = PureMixIn
   function pm_GetOffsetX: Integer;
   function pm_GetIsVertical: Boolean;
   function Get_OverlapType: TOverlapType;
   function Get_TreatCollapsedAsHidden: Boolean;
   function NeedIncludeHeight(aCheckType: Boolean = True): Boolean;
     {* Нужно ли учитывать высоту объекта при подсчете высоты родительского. }
   function IsHiddenPrim(aMap: TnevFormatInfoPrim;
    aHiddenStyles: TnevStandardStyles): Boolean;
   property OffsetX: Integer
     read pm_GetOffsetX;
     {* Возвращает смещение дочернего объекта относительно родителя. }
   property IsVertical: Boolean
     read pm_GetIsVertical;
   property OverlapType: TOverlapType
     read Get_OverlapType;
     {* Перекрывающий объект }
   property TreatCollapsedAsHidden: Boolean
     read Get_TreatCollapsedAsHidden;
 end;//MnevShapePrim
*)

(*
 MnevStringCache = PureMixIn
   function CheckS(i: Integer): Tl3CustomString;
 end;//MnevStringCache
*)

 InevStringCache = interface(InevBase)
   ['{A8756814-D7E7-4179-B053-867523E79892}']
  // MnevStringCache
   function CheckS(i: Integer): Tl3CustomString;
 end;//InevStringCache

(*
 MnevObjectData = PureMixIn
   function pm_GetText: TnevStr;
   function pm_GetTabStops: InevTabStops;
   property Text: TnevStr
     read pm_GetText;
   property TabStops: InevTabStops
     read pm_GetTabStops;
 end;//MnevObjectData
*)

 InevObjectHolderPrim = interface;
 { - предварительное описание InevObjectHolderPrim. }

 InevObjectPrim = interface(InevTagTool)
  {* Объект }
   ['{96C7E12F-CE8F-4E80-9B18-1EF2A695E61F}']
   function Get_HolderPrim: InevObjectHolderPrim;
   function DecorObj(aType: TnevDecorType): Tl3Variant;
   function IsLegalComment: Boolean;
     {* Юридический комментарий? }
   function IsDecorationElement: Boolean;
   property HolderPrim: InevObjectHolderPrim
     read Get_HolderPrim;
  // MnevObject
   function pm_GetPID: TnevParaIndex;
   function IsList: Boolean;
   property PID: TnevParaIndex
     read pm_GetPID;
     {* индекс параграфа в родителе. }
  // MnevShapePrim
   function pm_GetOffsetX: Integer;
   function pm_GetIsVertical: Boolean;
   function Get_OverlapType: TOverlapType;
   function Get_TreatCollapsedAsHidden: Boolean;
   function NeedIncludeHeight(aCheckType: Boolean = True): Boolean;
     {* Нужно ли учитывать высоту объекта при подсчете высоты родительского. }
   function IsHiddenPrim(aMap: TnevFormatInfoPrim;
    aHiddenStyles: TnevStandardStyles): Boolean;
   property OffsetX: Integer
     read pm_GetOffsetX;
     {* Возвращает смещение дочернего объекта относительно родителя. }
   property IsVertical: Boolean
     read pm_GetIsVertical;
   property OverlapType: TOverlapType
     read Get_OverlapType;
     {* Перекрывающий объект }
   property TreatCollapsedAsHidden: Boolean
     read Get_TreatCollapsedAsHidden;
  // MnevObjectData
   function pm_GetText: TnevStr;
   function pm_GetTabStops: InevTabStops;
   property Text: TnevStr
     read pm_GetText;
   property TabStops: InevTabStops
     read pm_GetTabStops;
 end;//InevObjectPrim

  TnevControlInfo = {$IfDef XE4}record{$Else}object{$EndIf}
  public
     rControl : InevObjectPrim;
     rFormatInfo : TnevFormatInfoPrim;
     rMetrics : InevViewMetrics;
  end;//TnevControlInfo

 InevObjectHolderPrim = interface(Il3ChangeNotifier)
   ['{7402A863-C5CA-4208-BB67-0AE30CCE7CA5}']
   function GetControlImg(const aControl: TnevControlInfo;
    out theImageInfo: TnevControlImageInfo): Boolean;
 end;//InevObjectHolderPrim

const
   { PreviewKeys }
  evDefaultPreviewCacheKey : TevPreviewCacheKey = (HiddenStyles : []; CaleeArea : afw_pcaMain);
   { Constants }
  nevPt0 : TnevPoint = (P : (X: 0; Y: 0));
  nevRect0 : TnevRect = (R: (Left: 0; Top: 0; Right: 0; Bottom: 0));
  nevNullFrame : TnevPoint = (P : (X: 0; Y: 0));
  nevDefaultColor = l3Core.clDefault;
  nev_ParaListFakeParaEx : TnevPoint = (P : (X: nevInch; Y: nevInch div 2));
  evViewFlags = [ev_uwfCursor, ev_uwfBlock, ev_uwfRegion, ev_uwfWasScroll];
   { Tree Consts }
  imOneLevel = l3TreeInterfaces.imOneLevel;
   { OverlapTypes }
  otNone = evdTypes.ev_msNone;
  otUpper = evdTypes.ev_msHead;
  otLower = evdTypes.ev_msContinue;

(*
 ConstantsHolder = PureMixIn
 end;//ConstantsHolder
*)

type
 TInevFormatInfoRet = TnevFormatInfoPrim;

 Tl3Variant = l3Variant.Tl3Variant;


function TnevControlInfo_C(const aPara: InevObjectPrim;
      aFormatInfo: TnevFormatInfoPrim;
      const aMetrics: InevViewMetrics): TnevControlInfo;

implementation

uses
  l3Base
  ;

// start class TnevFormatInfoPrim

{$If not defined(DesignTimeLibrary)}
class function TnevFormatInfoPrim.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_480F377B0271_var*
//#UC END# *47A6FEE600FC_480F377B0271_var*
begin
//#UC START# *47A6FEE600FC_480F377B0271_impl*
 Result := true{false};
//#UC END# *47A6FEE600FC_480F377B0271_impl*
end;//TnevFormatInfoPrim.IsCacheable
{$IfEnd} //not DesignTimeLibrary

function TnevControlInfo_C(const aPara: InevObjectPrim;
        aFormatInfo: TnevFormatInfoPrim;
        const aMetrics: InevViewMetrics): TnevControlInfo;
//#UC START# *4E25BFB80333_4E25BB410189_var*
//#UC END# *4E25BFB80333_4E25BB410189_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4E25BFB80333_4E25BB410189_impl*
 Result.rControl := aPara;
 Result.rFormatInfo := aFormatInfo;
 Result.rMetrics := aMetrics;
//#UC END# *4E25BFB80333_4E25BB410189_impl*
end;//TnevControlInfo.C

end.