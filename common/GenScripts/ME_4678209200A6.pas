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
  {* ������� ��������� ��� ������������ ���������. }
 end;//InevBase
 
 TnevInch = type Integer;
  {* �����. }
 
 InevMetricsPrim = interface
  {* ������� �����������. }
 end;//InevMetricsPrim
 
 TnevStr = Tl3PCharLen;
  {* ������. }
 
 TnevParaIndex = type Integer;
  {* ������ ���������. }
 
 TnevParaLevel = type Integer;
 
 InevInfoCanvas = Il3InfoCanvas;
  {* �������������� �����. }
 
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
  {* �����. }
 
 InevTree = Il3Tree;
 
 InevSimpleTree = Il3SimpleTree;
 
 InevSimpleNode = Il3SimpleNode;
 
 InevNode = Il3Node;
 
 TnevColor = Tl3Color;
  {* ����. }
 
 TnevFormat = Tl3ClipboardFormat;
  {* ������ ������ � ������ ������. }
 
 InevMetrics = interface(InevMetricsPrim)
  {* ������� �����������. }
 end;//InevMetrics
 
 InevTagTool = Ik2TagTool;
 
 InevCanvas = Il3Canvas;
  {* �����. }
 
 InevCommandProcessor = Il3CommandProcessor;
  {* ��������� ������. }
 
 IevAnchorIndex = interface
  {* ������ ����� }
  procedure Delete(Layer: Integer;
   Handle: Integer);
   {* ������� ����� �� �������. }
 end;//IevAnchorIndex
 
 IevTable = interface
  {* ������� (��. IedTable) }
  procedure InsertRows(NumRows: Integer;
   aAtEnd: Boolean);
   {* ��������� NumRows ����� � ������� ����� �������. }
  procedure InsertColumns(NumColumns: Integer);
   {* ��������� NumColumns �������� � ������� ����� �������. }
  procedure DeleteRow;
   {* ������� ������� ������ �������. }
  procedure DeleteColumn;
   {* ������� ������� �������. }
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
  {* ��������������� �������� ���������� ���������� ������. }
 
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
  {* ��������� ������������ ������ }
  function AppliesToMaxWidth: Boolean;
  procedure Invalidate(aParts: TnevShapeParts);
   {* �������� � ������������� ������������ �����, ���� ��� ������������ � �����-������ View. }
 end;//MnevShape
 *)
 
 (*
 MnevObject = interface
  {* ������ }
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
   {* ����� ������� }
  , ev_uwfForceHScroll
   {* ��������� �������������� �������� }
 );//TevUpdateWindowFlag
 
 TevUpdateWindowFlags = set of TevUpdateWindowFlag;
 
 TnevDecorType = (
  {* ��� �������� ������ }
  nev_dtHeader
  , nev_dtFooter
 );//TnevDecorType
 
 TnevAACLikeMode = (
  nev_aacNone
  , nev_aacLeft
   {* ����� �������� ��������� �� }
  , nev_aacRight
   {* ������ �������� ��������� �� }
  , nev_aacTextLeft
   {* ����� �������� ��������� �� }
  , nev_aacTextRight
   {* ������ �������� ��������� �� }
 );//TnevAACLikeMode
 
 TnevFormatInfoPrim = class;
 
 (*
 MnevDocumentContainerDecorationRules = interface
  {* ������� ���������� ��������� � ���������� ��������� }
  function AllowsThisDecor(aFI: TnevFormatInfoPrim;
   aType: TnevDecorType): Boolean;
   {* ��������� �� ��������� ��������� ��������� ��������� ������������� }
 end;//MnevDocumentContainerDecorationRules
 *)
 
 EnevMaybeBaseSwitched = class(Exception)
  {* �������� ����������� ���� }
 end;//EnevMaybeBaseSwitched
 
 EnevMaybePreviewCancelled = class(Exception)
  {* �������� �������� ���������� Preview }
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
   {* ��������� �� ��������� ��������� ��������� ��������� ������������� }
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
   {* ��������� �� ������ � �������� ���������� ���� ��� ��� �������� ������� }
  function VerticalAlignmentMargin: Integer;
   {* ���������� �������� ��������� �� ������� �������, � ����������� �� ������������� ������������. }
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
   {* �������� ����� � �������� anIndex � ������������ }
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
  {* ��������� ������ � ��������� }
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
  {* ���������� � �������������� }
  function InfoForChild(const aChild: InevObjectPrim): TnevFormatInfoPrim;
  function ViewSegments: Tl3Variant;
  function rLimitWidth: Integer;
  function Width: Integer;
  function Height: Integer;
  function Lines: InevLines;
  function DeltaHeight: Integer;
   {* �������� ����� ����������� �����, ������� ��������� � ���� ������ }
  function CompareWithMax(anIndex: Integer): Integer;
   {* �������� ����� � �������� anIndex � ������������ }
  procedure UpdateHeitghPart(anIndex: Integer;
   aValue: Integer);
  function MaxLinesCount: Integer;
  function Zoom: Integer;
   {* ������� }
  function Hidden: Boolean;
   {* ������ ������� }
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
   {* ��������� �� ������ � �������� ���������� ���� ��� ��� �������� ������� }
  function ImageInfo: PnevControlImageInfo;
  function Metrics: InevViewMetrics;
  function Spacing: TnevRect;
  function Obj: InevObjectPrim;
   {* ������, ��� ������� ������� ������ �������������� }
  function CalcClientValue4Column(aColumnID: Integer): Integer;
  procedure ResizeColumn(aColumnID: Integer;
   aValue: Integer;
   const aContext: InevOp);
  function VerticalAlignmentMargin: Integer;
   {* ���������� �������� ��������� �� ������� �������, � ����������� �� ������������� ������������. }
  function GreatestObjPID(anInLines: Boolean): Integer;
 end;//TnevFormatInfoPrim
 
 TOverlapType = TevMergeStatus;
 
 (*
 MnevShapePrim = interface
  function NeedIncludeHeight(aCheckType: Boolean): Boolean;
   {* ����� �� ��������� ������ ������� ��� �������� ������ �������������. }
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
  {* ������ }
  function DecorObj(aType: TnevDecorType): Tl3Variant;
  function IsLegalComment: Boolean;
   {* ����������� �����������? }
  function IsDecorationElement: Boolean;
  function IsList: Boolean;
  function NeedIncludeHeight(aCheckType: Boolean): Boolean;
   {* ����� �� ��������� ������ ������� ��� �������� ������ �������������. }
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
