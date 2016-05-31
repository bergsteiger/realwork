unit NOT_COMPLETED_nevBase;
 {* ������� ���������� ���������� �������. }

// ������: "w:\common\components\gui\Garant\Everest\new\NOT_COMPLETED_nevBase.pas"
// ���������: "InternalInterfaces"
// ������� ������: "nevBase" MUID: (4678209200A6)

{$Include w:\common\components\gui\Garant\Everest\new\nevDefine.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , k2Interfaces
 , l3Types
 , afwInterfaces
 , l3InternalInterfaces
 , l3TreeInterfaces
 , evdTypes
 , l3Core
 , evdStyles
 , l3Chars
 , evConst
 , l3Tree_TLB
 , k2Tags
 , evdInterfaces
 , k2Prim
 , l3Variant
 , k2BaseStruct
 , SysUtils
 , l3ProtoObject
 , evResultFontInterfaces
 , k2Base
 , l3CustomString
;

const
 imOneLevel = l3TreeInterfaces.imOneLevel;
 otNone = evdTypes.ev_msNone;
 otUpper = evdTypes.ev_msHead;
 otLower = evdTypes.ev_msContinue;
 {* ������������� ������ ����������. }
 nev_plThis = TnevParaLevel(0);
 nev_plNearest = TnevParaLevel(1);
 nev_plTopmost = High(TnevParaLevel);
 {* ������� ����������. }
 nev_piNull = TnevParaIndex(-1);
  {* ������������� ��������. }
 nev_piFirst = TnevParaIndex(0);
  {* ������ ��������. }
 nev_piLast = High(TnevParaIndex);
  {* ��������� ��������. }
 nevInch = TnevInch(evInchMul);
  {* ����. }
 nevTop = TnevInch(0);
  {* ����������� ������� �� �����������/���������. }
 nevBottom = High(TnevInch);
  {* ������������ ������� �� �����������/���������. }
 CP_DefaultValue = l3Chars.CP_DefaultValue;
 nev_MinusDiff = Low(Integer);
  {* ������������� ������� ���������. }
 nev_PlusDiff = High(Integer);
  {* ������������� ������� ���������. }
 evDefaultLoadFlags = [ev_lfNeedJoin, ev_lfSkipSubdocuments];
 evDefaultCopyFlags = evDefaultLoadFlags - [ev_lfNeedJoin];
 evDefaultStoreFlags = evd_DefaultStoreFlags;

type
 InevBase = interface(Il3Base)
  {* ������� ��������� ��� ������������ ���������. }
  ['{1532D13B-6E48-4307-933D-22C86383A2E0}']
 end;//InevBase

 PnevControlImageInfo = ^TnevControlImageInfo;

 TnevInch = type Integer;
  {* �����. }

 InevMetricsPrim = interface(InevBase)
  {* ������� �����������. }
  ['{C4B2D092-BFB3-4B0D-8CFE-E0F514C4360A}']
  function pm_GetLimitWidth: TnevInch;
  property LimitWidth: TnevInch
   read pm_GetLimitWidth;
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
  ['{AF2281DE-4C1A-48A3-8B1B-F343523E693B}']
  function pm_GetInfoCanvas: InevInfoCanvas;
  function Get_FormatCanvas: InevInfoCanvas;
  property InfoCanvas: InevInfoCanvas
   read pm_GetInfoCanvas;
   {* �������������� �������� ����������, ��� �������� ���� ������������� ���������. }
  property FormatCanvas: InevInfoCanvas
   read Get_FormatCanvas;
   {* ����� ��� ��������������. [$157450362] }
 end;//InevMetrics

 InevTagTool = Ik2TagTool;

 InevCanvas = Il3Canvas;
  {* �����. }

 InevCommandProcessor = Il3CommandProcessor;
  {* ��������� ������. }

 IevAnchorIndex = interface(InevBase)
  {* ������ ����� }
  ['{4A9029DA-6827-4AC3-BA09-82E6979A91D4}']
  procedure Delete(Layer: Integer;
   Handle: Integer);
   {* ������� ����� �� �������. }
 end;//IevAnchorIndex

 IevTable = interface(InevBase)
  {* ������� (��. IedTable) }
  ['{2C49178B-853E-4739-ACFB-64154CE2C4E7}']
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
  function pm_GetPID: TnevParaIndex;
  function IsList: Boolean;
  property PID: TnevParaIndex
   read pm_GetPID;
   {* ������ ��������� � ��������. }
 end;//MnevObject
 *)

 InevTabStops = Il3TabStops;

 TevNormalSegLayerHandleSet = evdTypes.TevNormalSegLayerHandleSet;

 TnevControlImageInfo = record
  rImageList: InevImageList;
  rFirstIndex: Integer;
  rLastIndex: Integer;
  rLeftIndent: Integer;
  rPictureOnly: Boolean;
   {* ������������ �� ������ �����. True ������ ��� ������ �������� ������������. }
  rHidePicture: Boolean;
   {* ����������� ��� ������ ��������� ���������. }
 end;//TnevControlImageInfo

 TevPreviewCacheKey = record
  HiddenStyles: TevStandardStyles;
  CaleeArea: TafwPreviewCaleeArea;
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

 InevObjectPrim = interface;

 TnevRubberTablesMode = (
  nev_rtmNone
  , nev_rtmZoom
  , nev_rtmFitToWindow
 );//TnevRubberTablesMode

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
  function NeedTotalRecalc: Boolean;
  function IsTagCollapsed(aTag: Tl3Variant): Boolean;
  function AllowsThisDecor(aFI: TnevFormatInfoPrim;
   aType: TnevDecorType): Boolean;
   {* ��������� �� ��������� ��������� ��������� ��������� ������������� }
  property IsWebStyle: Boolean
   read pm_GetIsWebStyle;
  property ShowDocumentParts: Boolean
   read pm_GetShowDocumentParts;
   {* ���������� �� ������� ��������� ���������? }
  property ShowSpecial: Boolean
   read pm_GetShowSpecial;
  property HiddenStyles: TnevStandardStyles
   read pm_GetHiddenStyles;
  property Extent: TnevPoint
   read pm_GetExtent;
  property ExcludeSuper: TevNormalSegLayerHandleSet
   read Get_ExcludeSuper;
   {* ����������� ��� ����������� ���� }
  property AACLike: TnevAACLikeMode
   read Get_AACLike;
  property AllowRubberTables: TnevRubberTablesMode
   read Get_AllowRubberTables;
   {* ��������� �� ��������� ������� }
  property Data: InevObjectPrim
   read Get_Data;
 end;//InevViewMetrics

 (*
 MnevShapeDeprecated = interface
  function ClientToParent(anX: Integer;
   aParentLevel: TnevParaLevel = nev_plTopmost): Integer;
  function ParentToClient(const aPt: TnevPoint;
   aParentLevel: TnevParaLevel = nev_plTopmost): TnevPoint;
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
  function Get_Spacing: TnevRect;
  function Height: Integer;
  function Width: Integer;
  property Spacing: TnevRect
   read Get_Spacing;
 end;//MnevShapeDim
 *)

 (*
 MnevFormatInfoForMergedTablesMayBe = interface
  function Get_DeltaHeight: Integer;
  function CompareWithMax(anIndex: Integer): Integer;
   {* �������� ����� � �������� anIndex � ������������ }
  procedure UpdateHeitghPart(anIndex: Integer;
   aValue: Integer);
  function GreatestObjPID(anInLines: Boolean = True): Integer;
  property DeltaHeight: Integer
   read Get_DeltaHeight;
   {* �������� ����� ����������� �����, ������� ��������� � ���� ������ }
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
  function Get_MaxLinesCount: Integer;
  function Get_Hidden: Boolean;
  function Get_FirstIndent: Integer;
  function Get_FrameTextFont: InevFont;
  function Get_Font(aCorrectItalic: Boolean): InevFont;
  function Get_Rendered: Il3Bitmap;
  function Get_LineSpacing: Integer;
  function Get_ImageInfo: PnevControlImageInfo;
  function Get_Metrics: InevViewMetrics;
  function Get_Obj: InevObjectPrim;
  function Get_Zoom: Integer;
  function rLimitWidth: Integer;
  property MaxLinesCount: Integer
   read Get_MaxLinesCount;
  property Hidden: Boolean
   read Get_Hidden;
   {* ������ ������� }
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
   {* ������, ��� ������� ������� ������ �������������� }
  property Zoom: Integer
   read Get_Zoom;
   {* ������� }
 end;//MnevFormatInfo
 *)

 (*
 MnevDecor = interface
  function DecorFormatInfo(aType: TnevDecorType): TnevFormatInfoPrim;
  function DecorHeight(aType: TnevDecorType): Integer;
  function DecorObj(aType: TnevDecorType): Tl3Variant;
 end;//MnevDecor
 *)

 TnevFormatInfoPrim = {abstract} class(Tl3ProtoObject)
  {* ���������� � �������������� }
  protected
   function Get_ParentInfo: TnevFormatInfoPrim; virtual; abstract;
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
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   function InfoForChild(const aChild: InevObjectPrim): TnevFormatInfoPrim; virtual; abstract;
   function ViewSegments: Tl3Variant; virtual; abstract;
   function rLimitWidth: Integer; virtual; abstract;
   function Width: Integer; virtual; abstract;
   function Height: Integer; virtual; abstract;
   function Lines: InevLines; virtual; abstract;
   function CompareWithMax(anIndex: Integer): Integer; virtual; abstract;
    {* �������� ����� � �������� anIndex � ������������ }
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
    {* ��������� �� ������ � �������� ���������� ���� ��� ��� �������� ������� }
   function CalcClientValue4Column(aColumnID: Integer): Integer; virtual; abstract;
   procedure ResizeColumn(aColumnID: Integer;
    aValue: Integer;
    const aContext: InevOp); virtual; abstract;
   function VerticalAlignmentMargin: Integer; virtual; abstract;
    {* ���������� �������� ��������� �� ������� �������, � ����������� �� ������������� ������������. }
   function GreatestObjPID(anInLines: Boolean = True): Integer; virtual; abstract;
  public
   property ParentInfo: TnevFormatInfoPrim
    read Get_ParentInfo;
   property DeltaHeight: Integer
    read Get_DeltaHeight;
    {* �������� ����� ����������� �����, ������� ��������� � ���� ������ }
   property MaxLinesCount: Integer
    read Get_MaxLinesCount;
   property Zoom: Integer
    read Get_Zoom;
    {* ������� }
   property Hidden: Boolean
    read Get_Hidden;
    {* ������ ������� }
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
    {* ������, ��� ������� ������� ������ �������������� }
 end;//TnevFormatInfoPrim

 TOverlapType = TevMergeStatus;

 (*
 MnevShapePrim = interface
  function pm_GetOffsetX: Integer;
  function pm_GetIsVertical: Boolean;
  function Get_OverlapType: TOverlapType;
  function Get_TreatCollapsedAsHidden: Boolean;
  function NeedIncludeHeight(aCheckType: Boolean = True): Boolean;
   {* ����� �� ��������� ������ ������� ��� �������� ������ �������������. }
  function IsHiddenPrim(aMap: TnevFormatInfoPrim;
   aHiddenStyles: TnevStandardStyles): Boolean;
  property OffsetX: Integer
   read pm_GetOffsetX;
   {* ���������� �������� ��������� ������� ������������ ��������. }
  property IsVertical: Boolean
   read pm_GetIsVertical;
  property OverlapType: TOverlapType
   read Get_OverlapType;
   {* ������������� ������ }
  property TreatCollapsedAsHidden: Boolean
   read Get_TreatCollapsedAsHidden;
 end;//MnevShapePrim
 *)

 (*
 MnevStringCache = interface
  function CheckS(i: Integer): Tl3CustomString;
 end;//MnevStringCache
 *)

 InevStringCache = interface(InevBase)
  ['{A8756814-D7E7-4179-B053-867523E79892}']
  function CheckS(i: Integer): Tl3CustomString;
 end;//InevStringCache

 InevObjectHolderPrim = interface;

 (*
 MnevObjectData = interface
  function pm_GetText: TnevStr;
  function pm_GetTabStops: InevTabStops;
  property Text: TnevStr
   read pm_GetText;
  property TabStops: InevTabStops
   read pm_GetTabStops;
 end;//MnevObjectData
 *)

 InevObjectPrim = interface(InevTagTool)
  {* ������ }
  ['{96C7E12F-CE8F-4E80-9B18-1EF2A695E61F}']
  function Get_HolderPrim: InevObjectHolderPrim;
  function pm_GetPID: TnevParaIndex;
  function pm_GetOffsetX: Integer;
  function pm_GetIsVertical: Boolean;
  function Get_OverlapType: TOverlapType;
  function Get_TreatCollapsedAsHidden: Boolean;
  function pm_GetText: TnevStr;
  function pm_GetTabStops: InevTabStops;
  function DecorObj(aType: TnevDecorType): Tl3Variant;
  function IsLegalComment: Boolean;
   {* ����������� �����������? }
  function IsDecorationElement: Boolean;
  function IsList: Boolean;
  function NeedIncludeHeight(aCheckType: Boolean = True): Boolean;
   {* ����� �� ��������� ������ ������� ��� �������� ������ �������������. }
  function IsHiddenPrim(aMap: TnevFormatInfoPrim;
   aHiddenStyles: TnevStandardStyles): Boolean;
  property HolderPrim: InevObjectHolderPrim
   read Get_HolderPrim;
  property PID: TnevParaIndex
   read pm_GetPID;
   {* ������ ��������� � ��������. }
  property OffsetX: Integer
   read pm_GetOffsetX;
   {* ���������� �������� ��������� ������� ������������ ��������. }
  property IsVertical: Boolean
   read pm_GetIsVertical;
  property OverlapType: TOverlapType
   read Get_OverlapType;
   {* ������������� ������ }
  property TreatCollapsedAsHidden: Boolean
   read Get_TreatCollapsedAsHidden;
  property Text: TnevStr
   read pm_GetText;
  property TabStops: InevTabStops
   read pm_GetTabStops;
 end;//InevObjectPrim

 TnevControlInfo = object
  public
   rControl: InevObjectPrim;
   rFormatInfo: TnevFormatInfoPrim;
   rMetrics: InevViewMetrics;
 end;//TnevControlInfo

 InevObjectHolderPrim = interface(Il3ChangeNotifier)
  ['{7402A863-C5CA-4208-BB67-0AE30CCE7CA5}']
  function GetControlImg(const aControl: TnevControlInfo;
   out theImageInfo: TnevControlImageInfo): Boolean;
 end;//InevObjectHolderPrim

 (*
 ConstantsHolder = interface
 end;//ConstantsHolder
 *)

 TInevFormatInfoRet = TnevFormatInfoPrim;

 Tl3Variant = l3Variant.Tl3Variant;

const
 evDefaultPreviewCacheKey: TevPreviewCacheKey = (HiddenStyles : []; CaleeArea : afw_pcaMain);
 nevPt0: TnevPoint = (P : (X: 0; Y: 0));
 nevRect0: TnevRect = (R: (Left: 0; Top: 0; Right: 0; Bottom: 0));
 nevNullFrame: TnevPoint = (P : (X: 0; Y: 0));
 nevDefaultColor = l3Core.clDefault;
 nev_ParaListFakeParaEx: TnevPoint = (P : (X: nevInch; Y: nevInch div 2));
 evViewFlags = [ev_uwfCursor, ev_uwfBlock, ev_uwfRegion, ev_uwfWasScroll];

function TnevControlInfo_C(const aPara: InevObjectPrim;
 aFormatInfo: TnevFormatInfoPrim;
 const aMetrics: InevViewMetrics): TnevControlInfo;

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

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
end;//TnevControlInfo_C

{$If NOT Defined(DesignTimeLibrary)}
class function TnevFormatInfoPrim.IsCacheable: Boolean;
 {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
//#UC START# *47A6FEE600FC_480F377B0271_var*
//#UC END# *47A6FEE600FC_480F377B0271_var*
begin
//#UC START# *47A6FEE600FC_480F377B0271_impl*
 Result := true{false};
//#UC END# *47A6FEE600FC_480F377B0271_impl*
end;//TnevFormatInfoPrim.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(EnevMaybeBaseSwitched));
 {* ����������� ���� EnevMaybeBaseSwitched }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(EnevMaybePreviewCancelled));
 {* ����������� ���� EnevMaybePreviewCancelled }
{$IfEnd} // NOT Defined(NoScripts)

end.
