unit nevFormatInfo;

interface

uses
 l3IntfUses
 , nevBase
 , nevTools
 , l3Variant
 , evResultFontInterfaces
 , l3InternalInterfaces
 , k2Base
;

type
 TnevFormatInfoRec = record
 end;//TnevFormatInfoRec
 
 TnevRenderingInfoPart = (
  {* Часть информации о форматировании. }
  nev_ripHeight
  , nev_ripLines
  , nev_ripWidth
  , nev_ripDeltaHeight
  , nev_ripCellParams
 );//TnevRenderingInfoPart
 
 TnevRenderingInfoParts = set of TnevRenderingInfoPart;
  {* Информация о форматировании. }
 
 // nev_ripAll
 
 TnevCachedControlImageInfo = record
 end;//TnevCachedControlImageInfo
 
 TnevCachedInteger = record
 end;//TnevCachedInteger
 
 TnevCachedFont = record
 end;//TnevCachedFont
 
 TnevCachedDecorHeight = array [TnevDecorType] of TnevCachedInteger;
 
 TnevCahcedSpacing = record
 end;//TnevCahcedSpacing
 
 RnevFormatInfo = class of TnevFormatInfo;
 
 TnevFormatInfo = class(TnevFormatInfoPrim)
  procedure ClearCache;
  function RootFormatInfo: TnevFormatInfo;
  procedure TuneFrameText(aText: Tl3Variant);
  function IsSegment: Boolean;
  function ParaFont(aCorrectItalic: Boolean): IevResultFont;
  procedure DoFontSuperposition(var theResult: IevResultFont;
   var theNeedApplyZoom: Boolean;
   aCorrectItalic: Boolean;
   aInTable: Boolean;
   var theOwnFont: Boolean);
  function GetObjIFont(aCorrectItalic: Boolean): InevFont;
  function DoGetFont(aCorrectItalic: Boolean): InevFont;
  function locDecorHeight(const aView: InevViewMetrics;
   aFI: TnevFormatInfo;
   aType: TnevDecorType): Integer;
  function locLocDecorFormatInfo(const aDecorObj: InevObjectPrim): TnevFormatInfo;
  function CreateInst(const aChild: InevObjectPrim;
   aParent: TnevFormatInfo;
   const aMetrics: InevViewMetrics): TnevFormatInfo;
  procedure DoPrepare;
  procedure DoRecalc(const aView: InevViewMetrics);
  function locDecorFormatInfo(aType: TnevDecorType): TnevFormatInfo;
  procedure ClearParentRef;
  function GetInfoForChild(const aChild: InevObjectPrim): TnevFormatInfo;
  procedure Create(aParent: TnevFormatInfo;
   const anObject: InevObjectPrim);
  procedure DoInvalidateShape(const aShape: InevObject;
   aParts: TnevShapeParts);
  function Metrics: InevViewMetrics;
  function ViewArea: InevViewArea;
  function Container: InevObjectHolder;
  procedure ForceParent;
  procedure wForce(aParts: TnevRenderingInfoParts);
  function Prepare(aParts: TnevRenderingInfoParts): Boolean;
  function DoCompareWithMax(anIndex: Integer): Integer;
  procedure DoUpdateHeitghPart(anIndex: Integer;
   aValue: Integer);
  function GetMaxLinesCount: Integer;
  function GetZoomForChild(aChild: TnevFormatInfo): Integer;
  function GetIsHidden: Boolean;
   {* Объект спрятан }
  procedure wHeight(aValue: Integer);
  procedure wWidth(aValue: Integer);
  procedure wMap(const aValue: InevLines);
  procedure InvalidateShape(const aShape: InevObject;
   aParts: TnevShapeParts);
  function ParentInfo: TnevFormatInfoPrim;
  function InfoForChild(const aChild: InevObjectPrim): TnevFormatInfoPrim;
 end;//TnevFormatInfo
 
implementation

uses
 l3ImplUses
 , k2Tags
 , SysUtils
 , nevFormatInfoFactory
 , k2Const
 , l3Base
 , TextPara_Const
 , evdStyles
 , Graphics
 , l3MinMax
 , l3Types
 , l3String
 , l3Units
 , evStandardStyles
 , evParaTools
 , evStyleInterface
 , evDefaultStylesFontSizes
 , l3Math
 , evdTypes
 , Table_Const
 , evDef
 , evGlyphFont
 , evResultFontHolder
 , l3Chars
 , evdStylesRes
 , l3ImageList
 , evdTextStyle_Const
 , evTextStyle_Const
;

end.
