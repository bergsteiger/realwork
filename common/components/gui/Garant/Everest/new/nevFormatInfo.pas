unit nevFormatInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevFormatInfo.pas"
// Начат: 24.04.2008 23:31
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Rendering::TnevFormatInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevBase,
  l3InternalInterfaces,
  nevTools,
  evResultFontInterfaces,
  l3Variant,
  k2Base
  ;

type
 TnevFormatInfoRec = record
   rHeight : Integer;
   rWidth : Integer;
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

const
 nev_ripAll = [Low(TnevRenderingInfoPart)..High(TnevRenderingInfoPart)];

type
 TnevCachedControlImageInfo = record
   rInfo : TnevControlImageInfo;
   rIsCached : Boolean;
 end;//TnevCachedControlImageInfo

 TnevCachedInteger = record
   rValue : Integer;
   rIsCached : Boolean;
 end;//TnevCachedInteger

 TnevCachedFont = record
   rValue : InevFont;
   rIsCached : Boolean;
 end;//TnevCachedFont

 TnevCachedDecorHeight = array [TnevDecorType] of TnevCachedInteger;

 TnevCahcedSpacing = record
   rValue : TnevRect;
   rIsCached : Boolean;
 end;//TnevCahcedSpacing

 RnevFormatInfo = class of TnevFormatInfo;

 TnevFormatInfo = class(TnevFormatInfoPrim)
 private
 // private fields
   f_ImageInfo : TnevCachedControlImageInfo;
   f_FirstIndent : TnevCachedInteger;
   f_FrameFont : TnevCachedFont;
   f_DecorHeight : TnevCachedDecorHeight;
   f_Spacing : TnevCahcedSpacing;
   f_FrameTextFormatInfo : TnevFormatInfo;
   f_Prepared : TnevRenderingInfoParts;
    {* Поле для свойства Prepared}
   f_LimitWidth : Integer;
    {* Поле для свойства LimitWidth}
   f_Obj : InevObjectPrim;
    {* Поле для свойства Obj}
   f_Parent : TnevFormatInfo;
    {* Поле для свойства Parent}
 private
 // private methods
   procedure DoPrepare;
 protected
 // property methods
   function pm_GetLocDeltaHeight: Integer; virtual;
   function pm_GetViewSegmentsPlace: Tl3Variant; virtual;
   procedure pm_SetLimitWidth(aValue: Integer);
   function pm_GetLinesPlace: InevLines; virtual;
   procedure pm_SetLinesPlace(const aValue: InevLines); virtual;
   function pm_GetLocSpacing: TnevRect; virtual;
   function pm_GetRendered: Il3Bitmap; virtual;
 protected
 // realized methods
   function Get_ParentInfo: TnevFormatInfoPrim; override;
   function InfoForChild(const aChild: InevObjectPrim): TnevFormatInfoPrim; override;
 public
 // realized methods
   procedure InvalidateShape(const aShape: InevObject;
    aParts: TnevShapeParts);
 protected
 // overridden property methods
   function Get_DeltaHeight: Integer; override;
   function Get_MaxLinesCount: Integer; override;
   function Get_Zoom: Integer; override;
   function Get_Hidden: Boolean; override;
   function Get_FirstIndent: Integer; override;
   function Get_FrameTextFont: InevFont; override;
   function Get_Font(aCorrectItalic: Boolean): InevFont; override;
   function Get_Rendered: Il3Bitmap; override;
   function Get_LineSpacing: Integer; override;
   function Get_ImageInfo: PnevControlImageInfo; override;
   function Get_Metrics: InevViewMetrics; override;
   function Get_Spacing: TnevRect; override;
   function Get_Obj: InevObjectPrim; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure Release; override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // overridden public methods
   function ViewSegments: Tl3Variant; override;
   function RLimitWidth: Integer; override;
   function Width: Integer; override;
   function Height: Integer; override;
   function Lines: InevLines; override;
   function CompareWithMax(anIndex: Integer): Integer; override;
     {* Сравнить точку с индексом anIndex с максимальной }
   procedure UpdateHeitghPart(anIndex: Integer;
     aValue: Integer); override;
   function DecorFormatInfo(aType: TnevDecorType): TnevFormatInfoPrim; override;
   function DecorObj(aType: TnevDecorType): Tl3Variant; override;
   function DecorHeight(aType: TnevDecorType): Integer; override;
   function ClientToParent(anX: Integer;
     aParentLevel: TnevParaLevel = nev_plTopmost): Integer; override;
   function ParentToClient(const aPt: TnevPoint;
     aParentLevel: TnevParaLevel = nev_plTopmost): TnevPoint; override;
   function GetObjFont(aCorrectItalic: Boolean): IevResultFont; override;
   function IsHidden(aRecursive: Boolean;
     aNeedCheckCollapsed: Boolean): Boolean; override;
   function IsHiddenPrim: Boolean; override;
   function InPara(aTypeID: Tk2Type): Boolean; override;
     {* Находится ли объект в родителе указанного типа или сам является таковым }
   function VerticalAlignmentMargin: Integer; override;
     {* Возвращает смещение параграфа от верхней границы, в зависимости от вертикального выравнивания. }
   function GreatestObjPID(anInLines: Boolean = True): Integer; override;
 protected
 // protected fields
   f_FI : TnevFormatInfoRec;
   f_ParaFont : IevResultFont;
 public
 // public fields
   SectionBreak : InevObject;
 protected
 // protected methods
   procedure ClearCache; virtual;
   function RootFormatInfo: TnevFormatInfo;
   procedure TuneFrameText(aText: Tl3Variant); virtual;
   function IsSegment: Boolean; virtual;
   procedure DoFontSuperposition(var theResult: IevResultFont;
     var theNeedApplyZoom: Boolean;
     aCorrectItalic: Boolean;
     aInTable: Boolean;
     var theOwnFont: Boolean); virtual;
   function GetObjIFont(aCorrectItalic: Boolean): InevFont; virtual;
   function DoGetFont(aCorrectItalic: Boolean): InevFont; virtual;
   function LocDecorHeight(const aView: InevViewMetrics;
     aFI: TnevFormatInfo;
     aType: TnevDecorType): Integer; virtual;
   function LocLocDecorFormatInfo(const aDecorObj: InevObjectPrim): TnevFormatInfo; virtual;
   procedure DoRecalc(const aView: InevViewMetrics); virtual;
   procedure ClearParentRef;
   function DoCompareWithMax(anIndex: Integer): Integer; virtual;
   procedure DoUpdateHeitghPart(anIndex: Integer;
    aValue: Integer); virtual;
   function GetMaxLinesCount: Integer; virtual;
   function GetZoomForChild(aChild: TnevFormatInfo): Integer; virtual;
   function GetIsHidden: Boolean; virtual;
     {* Объект спрятан }
 public
 // public methods
   function ParaFont(aCorrectItalic: Boolean): IevResultFont; virtual;
   class function CreateInst(const aChild: InevObjectPrim;
     aParent: TnevFormatInfo;
     const aMetrics: InevViewMetrics): TnevFormatInfo; virtual;
   function LocDecorFormatInfo(aType: TnevDecorType): TnevFormatInfo;
   function GetInfoForChild(const aChild: InevObjectPrim): TnevFormatInfo; virtual;
   constructor Create(aParent: TnevFormatInfo;
    const anObject: InevObjectPrim); reintroduce;
   procedure DoInvalidateShape(const aShape: InevObject;
    aParts: TnevShapeParts); virtual; abstract;
   function Metrics: InevViewMetrics; virtual;
   function ViewArea: InevViewArea; virtual;
   function Container: InevObjectHolder; virtual;
   procedure ForceParent;
   procedure WForce(aParts: TnevRenderingInfoParts); virtual;
   function Prepare(aParts: TnevRenderingInfoParts): Boolean;
   procedure WHeight(aValue: Integer);
   procedure WWidth(aValue: Integer);
   procedure WMap(const aValue: InevLines);
 protected
 // protected properties
   property locDeltaHeight: Integer
     read pm_GetLocDeltaHeight;
     {* Поправка к высоте - учитывающая объединение по вертикали. }
   property Prepared: TnevRenderingInfoParts
     read f_Prepared
     write f_Prepared;
   property ViewSegmentsPlace: Tl3Variant
     read pm_GetViewSegmentsPlace;
   property LinesPlace: InevLines
     read pm_GetLinesPlace
     write pm_SetLinesPlace;
   property Parent: TnevFormatInfo
     read f_Parent;
   property locSpacing: TnevRect
     read pm_GetLocSpacing;
   property Rendered: Il3Bitmap
     read pm_GetRendered;
 public
 // public properties
   property LimitWidth: Integer
     read f_LimitWidth
     write pm_SetLimitWidth;
   property Obj: InevObjectPrim
     read f_Obj;
 end;//TnevFormatInfo

implementation

uses
  k2Tags,
  SysUtils,
  nevFormatInfoFactory,
  k2Const,
  l3Base,
  TextPara_Const,
  evdStyles,
  Graphics,
  l3MinMax,
  l3Types,
  l3String,
  l3Units,
  evStandardStyles
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  evStyleInterface,
  evDefaultStylesFontSizes,
  l3Math,
  evdTypes,
  Table_Const,
  evDef,
  evGlyphFont,
  evResultFontHolder,
  l3Chars,
  evdStylesRes,
  l3ImageList,
  evdTextStyle_Const,
  evTextStyle_Const
  ;

// start class TnevFormatInfo

procedure TnevFormatInfo.DoPrepare;
//#UC START# *4E709452014A_4810DFE100B4_var*
var
 l_LS : Integer;
 l_V  : InevViewMetrics;
//#UC END# *4E709452014A_4810DFE100B4_var*
begin
//#UC START# *4E709452014A_4810DFE100B4_impl*
 l_LS := Get_LineSpacing;
 l_V := Metrics;
 l_V.InfoCanvas.PushLineSpacing;
 try
  l_V.FormatCanvas.PushLineSpacing;
  try
   l_V.InfoCanvas.LineSpacing := l_LS;
   l_V.FormatCanvas.LineSpacing := l_LS;
  (* if not Para.IsHiddenPrim(Map, f_View.HiddenStyles) then*)
    DoRecalc(l_V);
  finally
   l_V.FormatCanvas.PopLineSpacing;
  end;//try..finally
 finally
  l_V.InfoCanvas.PopLineSpacing;
 end;//try..finally
//#UC END# *4E709452014A_4810DFE100B4_impl*
end;//TnevFormatInfo.DoPrepare

procedure TnevFormatInfo.ClearCache;
//#UC START# *4E5E7D240227_4810DFE100B4_var*
var
 l_T : TnevDecorType;
//#UC END# *4E5E7D240227_4810DFE100B4_var*
begin
//#UC START# *4E5E7D240227_4810DFE100B4_impl*
 f_ParaFont := nil;
 FreeAndNil(f_FrameTextFormatInfo);
 for l_T := Low(l_T) to High(l_T) do
  f_DecorHeight[l_T].rIsCached := false;
 Finalize(f_FrameFont);
 Finalize(f_ImageInfo);
 f_Spacing.rIsCached := false;
 f_FrameFont.rIsCached := false;
 f_ImageInfo.rIsCached := false;
 f_FirstIndent.rIsCached := false;
//#UC END# *4E5E7D240227_4810DFE100B4_impl*
end;//TnevFormatInfo.ClearCache

function TnevFormatInfo.RootFormatInfo: TnevFormatInfo;
//#UC START# *4E170E0903A8_4810DFE100B4_var*
//#UC END# *4E170E0903A8_4810DFE100B4_var*
begin
//#UC START# *4E170E0903A8_4810DFE100B4_impl*
 if (f_Parent = nil) then
  Result := Self
 else
  Result := f_Parent.RootFormatInfo;
//#UC END# *4E170E0903A8_4810DFE100B4_impl*
end;//TnevFormatInfo.RootFormatInfo

procedure TnevFormatInfo.TuneFrameText(aText: Tl3Variant);
//#UC START# *4E5F8B2601DC_4810DFE100B4_var*
var
 l_IsLegalComment : Boolean;
 l_Font : InevFont;
 l_Size : Integer;
//#UC END# *4E5F8B2601DC_4810DFE100B4_var*
begin
//#UC START# *4E5F8B2601DC_4810DFE100B4_impl*
 if (Obj.AsObject.IntA[k2_tiStyle] = ev_saChangesInfo) then
 begin
  aText.IntA[k2_tiStyle] := ev_saSubHeaderForChangesInfo;
  Exit;
 end;//Obj.IntA[k2_tiStyle] = ev_saChangesInfo
 l_IsLegalComment := Obj.IsLegalComment;
 if l_IsLegalComment then
  aText.IntA[k2_tiStyle] := ev_saTxtComment
 else
  aText.IntA[k2_tiStyle] := ev_saTxtNormalANSI;
 with aText.cAtom(k2_tiFont) do
 begin
  IntA[k2_tiForeColor] := clBlack;
  if Obj.AsObject.Attr[k2_tiStyle].BoolA[k2_tiHeaderHasOwnSpace] then
  begin
   if l_IsLegalComment then
   begin
    with Tk2Type(Tk2Type(aText.TagType).Prop[k2_tiStyle].TagType) do
     l_Font := TevStandardStyles.
                Instance.
                 GetStyleFont(ValueTable.DRByID[ev_saTxtNormalANSI],
                              Metrics.InfoCanvas.Printing
                              {$IFNDef Nemesis}
                              OR not Metrics.IsWebStyle
                              {$EndIf}).AsFont(true, false);
    l_Size := Max(6, l_Font.Size - 2);
   end//l_IsLegalComment
   else
   begin
    l_Size := 12;
   end;//l_IsLegalComment
  end//Obj.Attr[k2_tiStyle].BoolA[k2_tiHeaderHasOwnSpace]
  else
  begin
   l_Font := Self.Get_Font(false);
   l_Size := l_Font.Size;
  end;//Obj.Attr[k2_tiStyle].BoolA[k2_tiHeaderHasOwnSpace]
  IntA[k2_tiSize] := l_Size;
  if not l_IsLegalComment then
   BoolA[k2_tiBold] := true;
 end;//with aText.cAtom(k2_tiFont)
//#UC END# *4E5F8B2601DC_4810DFE100B4_impl*
end;//TnevFormatInfo.TuneFrameText

function TnevFormatInfo.IsSegment: Boolean;
//#UC START# *4E5FAB8A0258_4810DFE100B4_var*
//#UC END# *4E5FAB8A0258_4810DFE100B4_var*
begin
//#UC START# *4E5FAB8A0258_4810DFE100B4_impl*
 Result := false;
//#UC END# *4E5FAB8A0258_4810DFE100B4_impl*
end;//TnevFormatInfo.IsSegment

function TnevFormatInfo.ParaFont(aCorrectItalic: Boolean): IevResultFont;
//#UC START# *4E5FBCFA0118_4810DFE100B4_var*
//#UC END# *4E5FBCFA0118_4810DFE100B4_var*
begin
//#UC START# *4E5FBCFA0118_4810DFE100B4_impl*
 if (f_ParaFont = nil) then
  f_ParaFont := GetObjFont(aCorrectItalic);
 Result := f_ParaFont;
 Assert(Result <> nil);  
//#UC END# *4E5FBCFA0118_4810DFE100B4_impl*
end;//TnevFormatInfo.ParaFont

procedure TnevFormatInfo.DoFontSuperposition(var theResult: IevResultFont;
  var theNeedApplyZoom: Boolean;
  aCorrectItalic: Boolean;
  aInTable: Boolean;
  var theOwnFont: Boolean);
//#UC START# *4E5FC90E03BD_4810DFE100B4_var*
//#UC END# *4E5FC90E03BD_4810DFE100B4_var*
begin
//#UC START# *4E5FC90E03BD_4810DFE100B4_impl*
 // - ничего не делаем
//#UC END# *4E5FC90E03BD_4810DFE100B4_impl*
end;//TnevFormatInfo.DoFontSuperposition

function TnevFormatInfo.GetObjIFont(aCorrectItalic: Boolean): InevFont;
//#UC START# *4E60BA9903B0_4810DFE100B4_var*
//#UC END# *4E60BA9903B0_4810DFE100B4_var*
begin
//#UC START# *4E60BA9903B0_4810DFE100B4_impl*
 Result := GetObjFont(aCorrectItalic).AsFont(aCorrectItalic, false);
//#UC END# *4E60BA9903B0_4810DFE100B4_impl*
end;//TnevFormatInfo.GetObjIFont

function TnevFormatInfo.DoGetFont(aCorrectItalic: Boolean): InevFont;
//#UC START# *4E60CEB700BD_4810DFE100B4_var*
//#UC END# *4E60CEB700BD_4810DFE100B4_var*
begin
//#UC START# *4E60CEB700BD_4810DFE100B4_impl*
 Result := ParaFont(aCorrectItalic).AsFont(aCorrectItalic, false);
//#UC END# *4E60CEB700BD_4810DFE100B4_impl*
end;//TnevFormatInfo.DoGetFont

function TnevFormatInfo.LocDecorHeight(const aView: InevViewMetrics;
  aFI: TnevFormatInfo;
  aType: TnevDecorType): Integer;
//#UC START# *4E6DE6D800F4_4810DFE100B4_var*
var
 l_FI : TnevFormatInfo;
 l_Collapsed : Boolean;
 l_Cont : InevObjectHolder;
 l_Allow : Boolean;
//#UC END# *4E6DE6D800F4_4810DFE100B4_var*
begin
//#UC START# *4E6DE6D800F4_4810DFE100B4_impl*
 Assert(aFI <> nil);
 if (aFI <> nil) then
  l_FI := aFI.LocDecorFormatInfo(aType)
 else
  l_FI := nil;
 Result := 0;
 l_Allow := true;
 if (l_FI <> nil) then
 begin
  l_Cont := Self.Container;
  if (l_Cont <> nil) then
   if not l_Cont.AllowsThisDecor(l_FI, aType) then
   // - не показываем декорации, которые нам контейнер запретил
   // http://mdp.garant.ru/pages/viewpage.action?pageId=321988011
    l_Allow := false
   else
   if not aView.AllowsThisDecor(l_FI, aType) then
   // http://mdp.garant.ru/pages/viewpage.action?pageId=321986755
    l_Allow := false;
 end;//l_FI <> nil
 l_Collapsed := aView.IsTagCollapsed(Obj.AsObject);
 if (aType = nev_dtHeader) then
 begin
  if not l_Collapsed OR (l_FI = nil) OR not l_Allow then
  begin
   if Obj.AsObject.Attr[k2_tiStyle].BoolA[k2_tiHeaderHasOwnSpace] then
   begin
    if l3Same(Obj.AsObject.Attr[k2_tiStyle].PCharLenA[k2_tiShortName], sp_HardSpace[false]) then
    // - заточка для тех хитрых, которые шапку не хотят, а отступ - хотят
    // http://mdp.garant.ru/pages/viewpage.action?pageId=294600965
    begin
    end//l3Same(aText, sp_HardSpace[false])
    else
    begin
     aView.InfoCanvas.PushFC;
     try
      aView.InfoCanvas.Font := aFI.Get_FrameTextFont;
      Result := aView.InfoCanvas.TextExtent(l3PCharLen('W')).Y;
     finally
      aView.InfoCanvas.PopFC;
     end;//try..finally
     Result := Max(nevInch div 6, Result);
    end;//l3Same(aText, sp_HardSpace[false])
    Inc(Result, nevInch div 16);
   end//Obj.Attr[k2_tiStyle].BoolA[k2_tiHeaderHasOwnSpace]
   else
   if l3IsNil(Obj.AsObject.PCharLenA[k2_tiText]) then
    Dec(Result, Obj.AsObject.IntA[k2_tiSpaceBefore]);
  end//not l_Collapsed
  else
   Dec(Result, Obj.AsObject.IntA[k2_tiSpaceBefore]);
 end//aType = nev_dtHeader
 else
 if not l_Collapsed then
  Result := nevInch div 12;
 if (l_FI <> nil) then
  if (not l_Collapsed OR (aType = nev_dtHeader)) AND l_Allow then
   Inc(Result, l_FI.Height);
//#UC END# *4E6DE6D800F4_4810DFE100B4_impl*
end;//TnevFormatInfo.LocDecorHeight

function TnevFormatInfo.LocLocDecorFormatInfo(const aDecorObj: InevObjectPrim): TnevFormatInfo;
//#UC START# *4E6DF94C00F1_4810DFE100B4_var*
//#UC END# *4E6DF94C00F1_4810DFE100B4_var*
begin
//#UC START# *4E6DF94C00F1_4810DFE100B4_impl*
 Result := GetInfoForChild(aDecorObj);
//#UC END# *4E6DF94C00F1_4810DFE100B4_impl*
end;//TnevFormatInfo.LocLocDecorFormatInfo

class function TnevFormatInfo.CreateInst(const aChild: InevObjectPrim;
  aParent: TnevFormatInfo;
  const aMetrics: InevViewMetrics): TnevFormatInfo;
//#UC START# *4E706B7C00A6_4810DFE100B4_var*
//#UC END# *4E706B7C00A6_4810DFE100B4_var*
begin
//#UC START# *4E706B7C00A6_4810DFE100B4_impl*
 Result := Create(aParent, aChild);
//#UC END# *4E706B7C00A6_4810DFE100B4_impl*
end;//TnevFormatInfo.CreateInst

procedure TnevFormatInfo.DoRecalc(const aView: InevViewMetrics);
//#UC START# *4E7094780214_4810DFE100B4_var*
//#UC END# *4E7094780214_4810DFE100B4_var*
begin
//#UC START# *4E7094780214_4810DFE100B4_impl*
 // - ничего не делаем, т.к. неизвестно, что делать
 Self.wMap(nil);
//#UC END# *4E7094780214_4810DFE100B4_impl*
end;//TnevFormatInfo.DoRecalc

function TnevFormatInfo.LocDecorFormatInfo(aType: TnevDecorType): TnevFormatInfo;
//#UC START# *4E70C2570279_4810DFE100B4_var*
var
 l_H : Tl3Variant;
 l_O : InevObjectPrim;
//#UC END# *4E70C2570279_4810DFE100B4_var*
begin
//#UC START# *4E70C2570279_4810DFE100B4_impl*
 l_H := DecorObj(aType);
 if l_H.IsValid then
 begin
  if not l_H.QT(InevObjectPrim, l_O) then
   Assert(false);
  Result := LocLocDecorFormatInfo(l_O);
  //Result := TnevFormatInfoFactory.Make(l_O, Self, Metrics, LimitWidth);
 end//l_H.IsValid
 else
  Result := nil;
//#UC END# *4E70C2570279_4810DFE100B4_impl*
end;//TnevFormatInfo.LocDecorFormatInfo

procedure TnevFormatInfo.ClearParentRef;
//#UC START# *4EA573D600DB_4810DFE100B4_var*
//#UC END# *4EA573D600DB_4810DFE100B4_var*
begin
//#UC START# *4EA573D600DB_4810DFE100B4_impl*
 f_Parent := nil;
//#UC END# *4EA573D600DB_4810DFE100B4_impl*
end;//TnevFormatInfo.ClearParentRef

function TnevFormatInfo.pm_GetLocDeltaHeight: Integer;
//#UC START# *4848EB800387_4810DFE100B4get_var*
//#UC END# *4848EB800387_4810DFE100B4get_var*
begin
//#UC START# *4848EB800387_4810DFE100B4get_impl*
 Result := 0;
//#UC END# *4848EB800387_4810DFE100B4get_impl*
end;//TnevFormatInfo.pm_GetLocDeltaHeight

function TnevFormatInfo.pm_GetViewSegmentsPlace: Tl3Variant;
//#UC START# *4821DB2500CB_4810DFE100B4get_var*
//#UC END# *4821DB2500CB_4810DFE100B4get_var*
begin
//#UC START# *4821DB2500CB_4810DFE100B4get_impl*
 Result := nil;
//#UC END# *4821DB2500CB_4810DFE100B4get_impl*
end;//TnevFormatInfo.pm_GetViewSegmentsPlace

procedure TnevFormatInfo.pm_SetLimitWidth(aValue: Integer);
//#UC START# *4821DDF603AB_4810DFE100B4set_var*
//#UC END# *4821DDF603AB_4810DFE100B4set_var*
begin
//#UC START# *4821DDF603AB_4810DFE100B4set_impl*
 if (f_LimitWidth <> aValue) then
 begin
  f_LimitWidth := aValue;
  wForce(nev_ripAll);
 end;//f_LimitWidth <> aValue
//#UC END# *4821DDF603AB_4810DFE100B4set_impl*
end;//TnevFormatInfo.pm_SetLimitWidth

function TnevFormatInfo.pm_GetLinesPlace: InevLines;
//#UC START# *4821DE24003D_4810DFE100B4get_var*
//#UC END# *4821DE24003D_4810DFE100B4get_var*
begin
//#UC START# *4821DE24003D_4810DFE100B4get_impl*
 Result := nil;
//#UC END# *4821DE24003D_4810DFE100B4get_impl*
end;//TnevFormatInfo.pm_GetLinesPlace

procedure TnevFormatInfo.pm_SetLinesPlace(const aValue: InevLines);
//#UC START# *4821DE24003D_4810DFE100B4set_var*
//#UC END# *4821DE24003D_4810DFE100B4set_var*
begin
//#UC START# *4821DE24003D_4810DFE100B4set_impl*
 Assert(aValue = nil);
//#UC END# *4821DE24003D_4810DFE100B4set_impl*
end;//TnevFormatInfo.pm_SetLinesPlace

function TnevFormatInfo.pm_GetLocSpacing: TnevRect;
//#UC START# *4E5F3D1102B8_4810DFE100B4get_var*
//#UC END# *4E5F3D1102B8_4810DFE100B4get_var*
begin
//#UC START# *4E5F3D1102B8_4810DFE100B4get_impl*
 Result.Left := Obj.AsObject.IntA[k2_tiLeftIndent];
 Result.Right := Obj.AsObject.IntA[k2_tiRightIndent];
 Result.Top := Obj.AsObject.IntA[k2_tiSpaceBefore];
 Result.Bottom := Obj.AsObject.IntA[k2_tiSpaceAfter];
 with Obj.AsObject.Attr[k2_tiFrame] do
  if IsValid then
  begin
   with Attr[k2_tiFrameUp] do
    if IsValid then
     Result.Top := Result.Top + IntA[k2_tiSpaceAfter] + IntA[k2_tiWidth] + IntA[k2_tiSpaceBefore];
   with Attr[k2_tiFrameDown] do
    if IsValid then
     Result.Bottom := Result.Bottom + IntA[k2_tiSpaceAfter] + IntA[k2_tiWidth] + IntA[k2_tiSpaceBefore];
  end;//IsValid
//#UC END# *4E5F3D1102B8_4810DFE100B4get_impl*
end;//TnevFormatInfo.pm_GetLocSpacing

function TnevFormatInfo.pm_GetRendered: Il3Bitmap;
//#UC START# *4E60F48503E6_4810DFE100B4get_var*
//#UC END# *4E60F48503E6_4810DFE100B4get_var*
begin
//#UC START# *4E60F48503E6_4810DFE100B4get_impl*
 Result := nil;
//#UC END# *4E60F48503E6_4810DFE100B4get_impl*
end;//TnevFormatInfo.pm_GetRendered

function TnevFormatInfo.GetInfoForChild(const aChild: InevObjectPrim): TnevFormatInfo;
//#UC START# *4815C94A027A_4810DFE100B4_var*
//#UC END# *4815C94A027A_4810DFE100B4_var*
begin
//#UC START# *4815C94A027A_4810DFE100B4_impl*
 Result := nil;
 Assert(false);
//#UC END# *4815C94A027A_4810DFE100B4_impl*
end;//TnevFormatInfo.GetInfoForChild

constructor TnevFormatInfo.Create(aParent: TnevFormatInfo;
  const anObject: InevObjectPrim);
//#UC START# *4815CE050234_4810DFE100B4_var*
//#UC END# *4815CE050234_4810DFE100B4_var*
begin
//#UC START# *4815CE050234_4810DFE100B4_impl*
 f_FrameFont.rIsCached := false;
 f_FirstIndent.rIsCached := false;
 f_ImageInfo.rIsCached := false;
 f_Obj := anObject;
 //LimitWidth := aWidth;
 inherited Create;
 Assert(aParent <> Self);
 Assert((aParent = nil) OR (aParent.f_Parent <> Self));
 f_Parent := aParent;
 l3FillChar(f_FI, SizeOf(f_FI));
 f_Prepared := [];
//#UC END# *4815CE050234_4810DFE100B4_impl*
end;//TnevFormatInfo.Create

function TnevFormatInfo.Metrics: InevViewMetrics;
//#UC START# *481733EB00F5_4810DFE100B4_var*
//#UC END# *481733EB00F5_4810DFE100B4_var*
begin
//#UC START# *481733EB00F5_4810DFE100B4_impl*
 Assert(f_Parent <> nil);
 Result := f_Parent.Metrics;
//#UC END# *481733EB00F5_4810DFE100B4_impl*
end;//TnevFormatInfo.Metrics

function TnevFormatInfo.ViewArea: InevViewArea;
//#UC START# *481740670066_4810DFE100B4_var*
//#UC END# *481740670066_4810DFE100B4_var*
begin
//#UC START# *481740670066_4810DFE100B4_impl*
 Result := f_Parent.ViewArea;
//#UC END# *481740670066_4810DFE100B4_impl*
end;//TnevFormatInfo.ViewArea

function TnevFormatInfo.Container: InevObjectHolder;
//#UC START# *481742AB0349_4810DFE100B4_var*
//#UC END# *481742AB0349_4810DFE100B4_var*
begin
//#UC START# *481742AB0349_4810DFE100B4_impl*
 Result := f_Parent.Container;
//#UC END# *481742AB0349_4810DFE100B4_impl*
end;//TnevFormatInfo.Container

procedure TnevFormatInfo.ForceParent;
//#UC START# *4817487000B5_4810DFE100B4_var*
//#UC END# *4817487000B5_4810DFE100B4_var*
begin
//#UC START# *4817487000B5_4810DFE100B4_impl*
 if (f_Parent <> nil) then
 begin
  //wForce(true);
  // - это похоже не нужно, т.к. мы сами уже Prepared
  f_Parent.wForce([nev_ripHeight]);
  f_Parent.ForceParent;
 end;//f_Parent <> nil
//#UC END# *4817487000B5_4810DFE100B4_impl*
end;//TnevFormatInfo.ForceParent

procedure TnevFormatInfo.WForce(aParts: TnevRenderingInfoParts);
//#UC START# *48175C1302A3_4810DFE100B4_var*
//#UC END# *48175C1302A3_4810DFE100B4_var*
begin
//#UC START# *48175C1302A3_4810DFE100B4_impl*
 if (aParts <> []) then
  ClearCache;
 f_Prepared := f_Prepared - aParts;
//#UC END# *48175C1302A3_4810DFE100B4_impl*
end;//TnevFormatInfo.WForce

function TnevFormatInfo.Prepare(aParts: TnevRenderingInfoParts): Boolean;
//#UC START# *481DDAAE014B_4810DFE100B4_var*
//#UC END# *481DDAAE014B_4810DFE100B4_var*
begin
//#UC START# *481DDAAE014B_4810DFE100B4_impl*
 if (aParts - f_Prepared <> []) then
 begin
  Result := true;
  Self.DoPrepare;
  Assert(aParts - f_Prepared = [], Format('%s : "%s" - not prepared', [Obj.AsObject.TagType.AsString, Obj.AsObject.StrA[k2_tiText]]));
  //wForce(false);
  // - надо скинуть признак необходимости переформатирования и больше не дёргаться
 end//aParts - f_Prepared <> []
 else
  Result := true; 
//#UC END# *481DDAAE014B_4810DFE100B4_impl*
end;//TnevFormatInfo.Prepare

function TnevFormatInfo.DoCompareWithMax(anIndex: Integer): Integer;
//#UC START# *4B9A10070246_4810DFE100B4_var*
//#UC END# *4B9A10070246_4810DFE100B4_var*
begin
//#UC START# *4B9A10070246_4810DFE100B4_impl*
 Result := 0; // - В общем случае сравниваем объект сам с собой...
//#UC END# *4B9A10070246_4810DFE100B4_impl*
end;//TnevFormatInfo.DoCompareWithMax

procedure TnevFormatInfo.DoUpdateHeitghPart(anIndex: Integer;
  aValue: Integer);
//#UC START# *4B9A1028013D_4810DFE100B4_var*
//#UC END# *4B9A1028013D_4810DFE100B4_var*
begin
//#UC START# *4B9A1028013D_4810DFE100B4_impl*

//#UC END# *4B9A1028013D_4810DFE100B4_impl*
end;//TnevFormatInfo.DoUpdateHeitghPart

function TnevFormatInfo.GetMaxLinesCount: Integer;
//#UC START# *4BC45843011E_4810DFE100B4_var*
//#UC END# *4BC45843011E_4810DFE100B4_var*
begin
//#UC START# *4BC45843011E_4810DFE100B4_impl*
 Result := 0;
//#UC END# *4BC45843011E_4810DFE100B4_impl*
end;//TnevFormatInfo.GetMaxLinesCount

function TnevFormatInfo.GetZoomForChild(aChild: TnevFormatInfo): Integer;
//#UC START# *4BFD5AB10227_4810DFE100B4_var*
//#UC END# *4BFD5AB10227_4810DFE100B4_var*
begin
//#UC START# *4BFD5AB10227_4810DFE100B4_impl*
 if (f_Parent = nil) then
  Result := 100
 else
  Result := f_Parent.GetZoomForChild(Self);
//#UC END# *4BFD5AB10227_4810DFE100B4_impl*
end;//TnevFormatInfo.GetZoomForChild

function TnevFormatInfo.GetIsHidden: Boolean;
//#UC START# *4C0D27380357_4810DFE100B4_var*
//#UC END# *4C0D27380357_4810DFE100B4_var*
begin
//#UC START# *4C0D27380357_4810DFE100B4_impl*
 Result := false;
//#UC END# *4C0D27380357_4810DFE100B4_impl*
end;//TnevFormatInfo.GetIsHidden

procedure TnevFormatInfo.WHeight(aValue: Integer);
//#UC START# *481DEC1D0261_4810DFE100B4_var*
//#UC END# *481DEC1D0261_4810DFE100B4_var*
begin
//#UC START# *481DEC1D0261_4810DFE100B4_impl*
 f_FI.rHeight := aValue;
 Include(f_Prepared, nev_ripHeight);
//#UC END# *481DEC1D0261_4810DFE100B4_impl*
end;//TnevFormatInfo.WHeight

procedure TnevFormatInfo.WWidth(aValue: Integer);
//#UC START# *481DEC1701E4_4810DFE100B4_var*
//#UC END# *481DEC1701E4_4810DFE100B4_var*
begin
//#UC START# *481DEC1701E4_4810DFE100B4_impl*
 f_FI.rWidth := aValue;
 Include(f_Prepared, nev_ripWidth);
//#UC END# *481DEC1701E4_4810DFE100B4_impl*
end;//TnevFormatInfo.WWidth

procedure TnevFormatInfo.WMap(const aValue: InevLines);
//#UC START# *481DF043036F_4810DFE100B4_var*
//#UC END# *481DF043036F_4810DFE100B4_var*
begin
//#UC START# *481DF043036F_4810DFE100B4_impl*
 LinesPlace := aValue;
 Include(f_Prepared, nev_ripLines);
//#UC END# *481DF043036F_4810DFE100B4_impl*
end;//TnevFormatInfo.WMap

procedure TnevFormatInfo.InvalidateShape(const aShape: InevObject;
  aParts: TnevShapeParts);
//#UC START# *4816E2B2004E_4810DFE100B4_var*
//#UC END# *4816E2B2004E_4810DFE100B4_var*
begin
//#UC START# *4816E2B2004E_4810DFE100B4_impl*
 Assert(aParts <> []);
 if aShape.IsList then
 begin
  if (nev_spExtent in aParts) or (nev_spCellExtent in aParts) then
   DoInvalidateShape(aShape, aParts);
  with ViewArea do
  begin
   Changed(nev_cpView);
   Invalidate;
  end;//with ViewArea
  //Assert(false);
  // - ловим случаи - когда это случается
  // - поймали :-) - например при скрытии комментариев
 end//l_Obj.IsList
 else
  DoInvalidateShape(aShape, aParts);
//#UC END# *4816E2B2004E_4810DFE100B4_impl*
end;//TnevFormatInfo.InvalidateShape

function TnevFormatInfo.Get_ParentInfo: TnevFormatInfoPrim;
//#UC START# *49D0A2B003D0_4810DFE100B4get_var*
//#UC END# *49D0A2B003D0_4810DFE100B4get_var*
begin
//#UC START# *49D0A2B003D0_4810DFE100B4get_impl*
 Result := f_Parent;
//#UC END# *49D0A2B003D0_4810DFE100B4get_impl*
end;//TnevFormatInfo.Get_ParentInfo

function TnevFormatInfo.InfoForChild(const aChild: InevObjectPrim): TnevFormatInfoPrim;
//#UC START# *49D10BB90336_4810DFE100B4_var*
//#UC END# *49D10BB90336_4810DFE100B4_var*
begin
//#UC START# *49D10BB90336_4810DFE100B4_impl*
 Result := GetInfoForChild(aChild);
//#UC END# *49D10BB90336_4810DFE100B4_impl*
end;//TnevFormatInfo.InfoForChild

procedure TnevFormatInfo.Cleanup;
//#UC START# *479731C50290_4810DFE100B4_var*
//#UC END# *479731C50290_4810DFE100B4_var*
begin
//#UC START# *479731C50290_4810DFE100B4_impl*
 ClearCache;
 f_Obj := nil;
 inherited;
//#UC END# *479731C50290_4810DFE100B4_impl*
end;//TnevFormatInfo.Cleanup

procedure TnevFormatInfo.Release;
//#UC START# *479F2AFB0397_4810DFE100B4_var*
//#UC END# *479F2AFB0397_4810DFE100B4_var*
begin
//#UC START# *479F2AFB0397_4810DFE100B4_impl*
 inherited;
//#UC END# *479F2AFB0397_4810DFE100B4_impl*
end;//TnevFormatInfo.Release

function TnevFormatInfo.ViewSegments: Tl3Variant;
//#UC START# *480F39C1037C_4810DFE100B4_var*
//#UC END# *480F39C1037C_4810DFE100B4_var*
begin
//#UC START# *480F39C1037C_4810DFE100B4_impl*
 Result := ViewSegmentsPlace;
//#UC END# *480F39C1037C_4810DFE100B4_impl*
end;//TnevFormatInfo.ViewSegments

function TnevFormatInfo.RLimitWidth: Integer;
//#UC START# *481060DE0339_4810DFE100B4_var*
//#UC END# *481060DE0339_4810DFE100B4_var*
begin
//#UC START# *481060DE0339_4810DFE100B4_impl*
 Result := LimitWidth;
//#UC END# *481060DE0339_4810DFE100B4_impl*
end;//TnevFormatInfo.RLimitWidth

function TnevFormatInfo.Width: Integer;
//#UC START# *4810665E02DC_4810DFE100B4_var*
//#UC END# *4810665E02DC_4810DFE100B4_var*
begin
//#UC START# *4810665E02DC_4810DFE100B4_impl*
 if Obj.AsObject.BoolA[k2_tiFixedWidth] then
 // - это типа ОПТИМИЗАЦИЯ для ячеек таблиц
 // надо бы переделать в рамках http://mdp.garant.ru/pages/viewpage.action?pageId=210437161
  Result := LimitWidth
 else
 begin
  if not Prepare([nev_ripWidth]) then
   Assert(false);
  Result := f_FI.rWidth;
 end;//Obj.BoolA[k2_tiFixedWidth]
//#UC END# *4810665E02DC_4810DFE100B4_impl*
end;//TnevFormatInfo.Width

function TnevFormatInfo.Height: Integer;
//#UC START# *4810666502C4_4810DFE100B4_var*
//#UC END# *4810666502C4_4810DFE100B4_var*
begin
//#UC START# *4810666502C4_4810DFE100B4_impl*
 if not Prepare([nev_ripHeight]) then
  Assert(false);
 Result := f_FI.rHeight;                           
//#UC END# *4810666502C4_4810DFE100B4_impl*
end;//TnevFormatInfo.Height

function TnevFormatInfo.Lines: InevLines;
//#UC START# *48107EE80389_4810DFE100B4_var*
//#UC END# *48107EE80389_4810DFE100B4_var*
begin
//#UC START# *48107EE80389_4810DFE100B4_impl*
 if not Prepare([nev_ripLines]) then
  Assert(false);
 Result := LinesPlace;
//#UC END# *48107EE80389_4810DFE100B4_impl*
end;//TnevFormatInfo.Lines

function TnevFormatInfo.Get_DeltaHeight: Integer;
//#UC START# *484A370503D5_4810DFE100B4get_var*
//#UC END# *484A370503D5_4810DFE100B4get_var*
begin
//#UC START# *484A370503D5_4810DFE100B4get_impl*
 Result := locDeltaHeight;
//#UC END# *484A370503D5_4810DFE100B4get_impl*
end;//TnevFormatInfo.Get_DeltaHeight

function TnevFormatInfo.CompareWithMax(anIndex: Integer): Integer;
//#UC START# *4B9A0467010C_4810DFE100B4_var*
//#UC END# *4B9A0467010C_4810DFE100B4_var*
begin
//#UC START# *4B9A0467010C_4810DFE100B4_impl*
 Result := DoCompareWithMax(anIndex);
//#UC END# *4B9A0467010C_4810DFE100B4_impl*
end;//TnevFormatInfo.CompareWithMax

procedure TnevFormatInfo.UpdateHeitghPart(anIndex: Integer;
  aValue: Integer);
//#UC START# *4B9A04B4035A_4810DFE100B4_var*
//#UC END# *4B9A04B4035A_4810DFE100B4_var*
begin
//#UC START# *4B9A04B4035A_4810DFE100B4_impl*
 DoUpdateHeitghPart(anIndex, aValue);
//#UC END# *4B9A04B4035A_4810DFE100B4_impl*
end;//TnevFormatInfo.UpdateHeitghPart

function TnevFormatInfo.Get_MaxLinesCount: Integer;
//#UC START# *4BC457480356_4810DFE100B4get_var*
//#UC END# *4BC457480356_4810DFE100B4get_var*
begin
//#UC START# *4BC457480356_4810DFE100B4get_impl*
 Result := GetMaxLinesCount;
//#UC END# *4BC457480356_4810DFE100B4get_impl*
end;//TnevFormatInfo.Get_MaxLinesCount

function TnevFormatInfo.Get_Zoom: Integer;
//#UC START# *4BFD5A7C03AE_4810DFE100B4get_var*
//#UC END# *4BFD5A7C03AE_4810DFE100B4get_var*
begin
//#UC START# *4BFD5A7C03AE_4810DFE100B4get_impl*
 if (f_Parent = nil) then
  Result := 100
 else
  Result := f_Parent.GetZoomForChild(Self);
//#UC END# *4BFD5A7C03AE_4810DFE100B4get_impl*
end;//TnevFormatInfo.Get_Zoom

function TnevFormatInfo.Get_Hidden: Boolean;
//#UC START# *4C0D26E90378_4810DFE100B4get_var*
//#UC END# *4C0D26E90378_4810DFE100B4get_var*
begin
//#UC START# *4C0D26E90378_4810DFE100B4get_impl*
 Result := GetIsHidden;
//#UC END# *4C0D26E90378_4810DFE100B4get_impl*
end;//TnevFormatInfo.Get_Hidden

function TnevFormatInfo.DecorFormatInfo(aType: TnevDecorType): TnevFormatInfoPrim;
//#UC START# *4E17237701C9_4810DFE100B4_var*
//#UC END# *4E17237701C9_4810DFE100B4_var*
begin
//#UC START# *4E17237701C9_4810DFE100B4_impl*
 Result := LocDecorFormatInfo(aType);
//#UC END# *4E17237701C9_4810DFE100B4_impl*
end;//TnevFormatInfo.DecorFormatInfo

function TnevFormatInfo.DecorObj(aType: TnevDecorType): Tl3Variant;
//#UC START# *4E1C72E1021F_4810DFE100B4_var*
//#UC END# *4E1C72E1021F_4810DFE100B4_var*
begin
//#UC START# *4E1C72E1021F_4810DFE100B4_impl*
 Result := Obj.DecorObj(aType);
//#UC END# *4E1C72E1021F_4810DFE100B4_impl*
end;//TnevFormatInfo.DecorObj

function TnevFormatInfo.Get_FirstIndent: Integer;
//#UC START# *4E5E57E503E4_4810DFE100B4get_var*

 function GetFirstIndent(const aView : InevViewMetrics): Integer;
 var
  l_Style : Tl3Variant;
  l_S : Tl3PCharLen;
  l_Width : Integer;
  l_Gap : Integer;
  l_ImageInfo : PnevControlImageInfo;
  l_ImageWidth : Integer;
  l_CharWidth : Integer;
 begin
  Result := Obj.AsObject.IntA[k2_tiFirstIndent];
  l_Style := Obj.AsObject.Attr[k2_tiStyle];
  if l_Style.IsValid then
   if not l_Style.BoolA[k2_tiHeaderHasOwnSpace] then
   begin
    l_S := l_Style.PCharLenA[k2_tiShortName];
    if not l3IsNil(l_S) then
    begin
     if (Self.Spacing.Top <= 0) then
      Exit;
     aView.InfoCanvas.PushFC;
     try
      aView.InfoCanvas.Font := Self.FrameTextFont;
      l_CharWidth := aView.InfoCanvas.TextExtent(l3PCharLen('w')).X;
      l_Gap := l_CharWidth;
      l_ImageInfo := Self.ImageInfo;
      if (l_ImageInfo <> nil) then
       if (l_ImageInfo.rImageList <> nil) then
       begin
        l_ImageWidth := aView.InfoCanvas.DP2LP(PointX(l_ImageInfo.rImageList.Width)).X;
        if (l_ImageInfo.rFirstIndex >= 0) then
         Inc(l_Gap, l_ImageWidth * 2);
        if (l_ImageInfo.rLastIndex >= 0) then
         Inc(l_Gap, l_ImageWidth);
       end;//l_ImageInfo.rImageList <> nil
      l_Width := aView.InfoCanvas.TextExtent(l_S).X;
      if true{aView.InfoCanvas.Printing} then
       l_Width := l_Width + l_Gap
      else
       Result := Result + l_Gap;
      if (Self.rLimitWidth - 100
                         // ^ магическая константа, взятая из TnevTextParaFormatter.DoRecalc
          > Result + l_Width) then
      // http://mdp.garant.ru/pages/viewpage.action?pageId=280006084
       Result := Result + l_Width;
     finally
      aView.InfoCanvas.PopFC;
     end;//try..finally
    end;//not l3IsNil(l_S)
   end;//not l_Style.BoolA[k2_tiHeaderHasOwnSpace]
 end;//TevTextParaPainterEx.GetFirstIndent

//#UC END# *4E5E57E503E4_4810DFE100B4get_var*
begin
//#UC START# *4E5E57E503E4_4810DFE100B4get_impl*
 if not f_FirstIndent.rIsCached then
 begin
  f_FirstIndent.rValue := GetFirstIndent(Metrics);
  f_FirstIndent.rIsCached := true;
 end;//not f_FirstIndent.rIsCached
 Result := f_FirstIndent.rValue;
//#UC END# *4E5E57E503E4_4810DFE100B4get_impl*
end;//TnevFormatInfo.Get_FirstIndent

function TnevFormatInfo.Get_FrameTextFont: InevFont;
//#UC START# *4E5E77070150_4810DFE100B4get_var*
var
 l_FrameText : Tl3Variant;
 l_Obj : InevObjectPrim;
//#UC END# *4E5E77070150_4810DFE100B4get_var*
begin
//#UC START# *4E5E77070150_4810DFE100B4get_impl*
 if not f_FrameFont.rIsCached then
 begin
  l_FrameText := k2_typTextPara.MakeTag.AsObject;
  try
   TuneFrameText(l_FrameText);
   Assert(f_FrameTextFormatInfo = nil);
   if not l_FrameText.QT(InevObjectPrim, l_Obj) then
    Assert(false);
   f_FrameTextFormatInfo := TnevFormatInfoFactory.CreateFormatInfo(l_Obj, Self, Metrics);
   f_FrameTextFormatInfo.LimitWidth := LimitWidth;
   f_FrameFont.rValue := f_FrameTextFormatInfo.Get_Font(false);
   f_FrameFont.rIsCached := true;
  finally
   l_FrameText := nil;
  end;//try..finally
 end;//not f_FrameFont.rIsCached
 Result := f_FrameFont.rValue;
//#UC END# *4E5E77070150_4810DFE100B4get_impl*
end;//TnevFormatInfo.Get_FrameTextFont

function TnevFormatInfo.DecorHeight(aType: TnevDecorType): Integer;
//#UC START# *4E5F2AF2035A_4810DFE100B4_var*
//#UC END# *4E5F2AF2035A_4810DFE100B4_var*
begin
//#UC START# *4E5F2AF2035A_4810DFE100B4_impl*
 if not f_DecorHeight[aType].rIsCached then
 begin
  f_DecorHeight[aType].rValue := locDecorHeight(Metrics, Self, aType);
  f_DecorHeight[aType].rIsCached := true;
 end;//not f_DecorHeight[aType].rIsCached
 Result := f_DecorHeight[aType].rValue;
//#UC END# *4E5F2AF2035A_4810DFE100B4_impl*
end;//TnevFormatInfo.DecorHeight

function TnevFormatInfo.ClientToParent(anX: Integer;
  aParentLevel: TnevParaLevel = nev_plTopmost): Integer;
//#UC START# *4E5F6E480332_4810DFE100B4_var*
var
 l_Para : TnevFormatInfo;
//#UC END# *4E5F6E480332_4810DFE100B4_var*
begin
//#UC START# *4E5F6E480332_4810DFE100B4_impl*
 l_Para := Self;
 Result := anX;
 while (l_Para <> nil) AND (aParentLevel > 0) do
 begin
  Result := Result + l_Para.Get_Spacing.Left;
  Result := Result + l_Para.Obj.OffsetX;
  l_Para := l_Para.f_Parent;
  Dec(aParentLevel);
 end;//while (P <> nil).. // <stub>
//#UC END# *4E5F6E480332_4810DFE100B4_impl*
end;//TnevFormatInfo.ClientToParent

function TnevFormatInfo.ParentToClient(const aPt: TnevPoint;
  aParentLevel: TnevParaLevel = nev_plTopmost): TnevPoint;
//#UC START# *4E5F6E6D0264_4810DFE100B4_var*
var
 l_Para : TnevFormatInfo;
//#UC END# *4E5F6E6D0264_4810DFE100B4_var*
begin
//#UC START# *4E5F6E6D0264_4810DFE100B4_impl*
 l_Para := Self;
 Result := aPt;
 while (l_Para <> nil) AND (aParentLevel > 0) do
 begin
  Result := Tl3Point(Result).Sub(l_Para.Get_Spacing.TopLeft);
  Result := Tl3Point(Result).Sub(l3PointX(l_Para.Obj.OffsetX));
  l_Para := l_Para.f_Parent;
  Dec(aParentLevel);
 end;//while (P <> nil).. // <stub>
//#UC END# *4E5F6E6D0264_4810DFE100B4_impl*
end;//TnevFormatInfo.ParentToClient

function TnevFormatInfo.Get_Font(aCorrectItalic: Boolean): InevFont;
//#UC START# *4E5FA5330139_4810DFE100B4get_var*
//#UC END# *4E5FA5330139_4810DFE100B4get_var*
begin
//#UC START# *4E5FA5330139_4810DFE100B4get_impl*
 Result := DoGetFont(aCorrectItalic);
//#UC END# *4E5FA5330139_4810DFE100B4get_impl*
end;//TnevFormatInfo.Get_Font

function TnevFormatInfo.GetObjFont(aCorrectItalic: Boolean): IevResultFont;
//#UC START# *4E5FB65D02AA_4810DFE100B4_var*

var
 l_ObjectOwnFont : IevResultFont;
 
 procedure CheckOwnObjectFont;
 begin//CheckOwnObjectFont
  if (l_ObjectOwnFont = nil) then
   l_ObjectOwnFont := TevResultFontHolder.Make
  else
   l_ObjectOwnFont.Clear;
 end;//CheckOwnObjectFont

var
 l_OwnFont  : Boolean;
 l_Fixed    : Boolean;
 l_Printing : Boolean;

 procedure GetParaOwnFont;
 begin//GetParaOwnFont
  l_OwnFont := true;
  if IsSegment then
  begin
   CheckOwnObjectFont;
   if Obj.AsObject.HasSubAtom(k2_tiStyle) then
    l_ObjectOwnFont.AddStyledTag(Obj.AsObject)
   else
    l_ObjectOwnFont.AddTag(Obj.AsObject);
   Result := l_ObjectOwnFont;
  end//IsSegment
  else
  begin
   CheckOwnObjectFont;
   l_ObjectOwnFont.AddStyledTag(Obj.AsObject);
   Result := l_ObjectOwnFont;
  end;//IsSegment
 end;//GetParaOwnFont

 procedure ApplySize(aSize : Integer;
                     aCheckUserDefinedSize : Boolean
                     // http://mdp.garant.ru/pages/viewpage.action?pageId=278836408
                    );
 var
  l_pSize : PInteger;
 begin//ApplySize
  aSize := Max(6, aSize);
  if (aSize > 4) then
  begin
   if not l_OwnFont then
   begin
    if IsSegment then
     Assert(false)
    else
    begin
     l_OwnFont := true;
     CheckOwnObjectFont;
     l_ObjectOwnFont.AddFont(Result);
     Result := l_ObjectOwnFont;
     f_ParaFont := Result;
    end;//IsSegment
   end;//not l_OwnFont
   {$IfDef Nemesis}
   if aCheckUserDefinedSize then
   begin
    l_pSize := Result.GetItem(k2_tiSize);
    if (l_pSize <> nil) AND
       (l_pSize^ <> k2_TransparentValue) AND
       (l_pSize^ < aSize) then
    // http://mdp.garant.ru/pages/viewpage.action?pageId=278836408
     Exit;
     // - не применяем, то что поставили юристы, а используем настройку пользователя
   end;//aCheckUserDefinedSize
   {$EndIf Nemesis}
   Result.SetItem(k2_tiSize, aSize);
  end;//aSize > 4
 end;//ApplySize

 procedure ApplyPrintFontSize;

  procedure DoApply;
  var
   l_pSize         : PInteger;
   l_PrintFontSize : Integer;
   l_UserFontSize  : Integer;
  begin//DoApply
   if (TevIndentType(Obj.AsObject.IntA[k2_tiJustification]) = ev_itPreformatted) then
   begin
    l_PrintFontSize := Obj.AsObject.IntA[k2_tiPrintFontSize];
    if l_Fixed then
    begin
     l_UserFontSize := TevDefaultStylesFontSizes.Instance.FontSizeForTag(Obj.AsObject);
     if (l_PrintFontSize > l_UserFontSize) then
      l_PrintFontSize := l_UserFontSize;
    end;//l_Fixed
    ApplySize(l_PrintFontSize, not l_Fixed);
   end//TevIndentType(Obj.IntA[k2_tiJustification]) = ev_itPreformatted
   else
   if l_Fixed then
   begin
    if Obj.AsObject.HasSubAtom(k2_tiFont) then
    begin
     // - убиваем шрифт параграфа, зато исправляем ситуацию для f_FrameText
     Assert(l_OwnFont);
     Result.SetItem(k2_tiSize, TevDefaultStylesFontSizes.Instance.FontSizeForTag(Obj.AsObject));
    end//Obj.HasSubAtom(k2_tiFont)
    else
     begin
      l_pSize := Result.GetItem(k2_tiSize);
      if (l_pSize <> nil) and (l_pSize^ = k2_TransparentValue) then
       Result.SetItem(k2_tiSize, TevDefaultStylesFontSizes.Instance.FontSizeForTag(Obj.AsObject));
    end; 
   end;//l_Fixed
  end;//DoApply

  procedure lp_CorrectSegmentFontSize;
  var
   l_pSize : PInteger;
  begin
   l_pSize := Parent.ParaFont(aCorrectItalic).GetItem(k2_tiSize);
   Assert(l_pSize <> nil);
   Assert(l_pSize^ <> k2_TransparentValue);
   Result.SetItem(k2_tiSize, l_pSize^);
  end;

 begin//ApplyPrintFontSize
  if IsSegment then
  begin
   if l_Fixed then
    if Obj.AsObject.HasSubAtom(k2_tiFont) then
    // - убиваем шрифт сегмента, зато исправляем ситуацию для сегментов из суперпозиции
    begin
     if (Obj.AsObject.Attr[k2_tiFont].IntA[k2_tiSize] = k2_TransparentValue) then
     // http://mdp.garant.ru/pages/viewpage.action?pageId=281520589&focusedCommentId=294604352#comment-294604352
     // http://mdp.garant.ru/pages/viewpage.action?pageId=281520589&focusedCommentId=294604431#comment-294604431
      lp_CorrectSegmentFontSize
     else
      Result.SetItem(k2_tiSize, TevDefaultStylesFontSizes.Instance.FontSizeForTag(Obj.AsObject));
    end//Obj.HasSubAtom(k2_tiFont)
    else
     if l_Printing then // http://mdp.garant.ru/pages/viewpage.action?pageId=589884932
      lp_CorrectSegmentFontSize;
   //Assert(false);
  end//IsSegment
  else
  if l_Printing then
   DoApply;
 end;//ApplyPrintFontSize

var
 l_Zoom : Integer;

 procedure ApplyZoom;
 var
  l_FontSize  : Integer;
  l_SizePtr   : PInteger;
 begin//ApplyZoom
  l_SizePtr := Result.GetItem(k2_tiSize);
  if (l_SizePtr = nil) then
   l_FontSize := l3MulDiv(def_FontSize, l_Zoom, 100)
  else
  if (l_SizePtr^ = k2_TransparentValue) then
  begin
   Assert(not IsSegment);
   Exit;
  end//l_SizePtr^ = k2_tiTransparentValue
  else
  if l_Fixed AND Obj.AsObject.HasSubAtom(k2_tiFont) then
   l_FontSize := l3MulDiv(TevDefaultStylesFontSizes.Instance.FontSizeForTag(Obj.AsObject), l_Zoom, 100)
  else
   l_FontSize := l3MulDiv(l_SizePtr^, l_Zoom, 100);
  ApplySize(l_FontSize, false);
 end;//ApplyZoom

var
 l_NeedApplyZoom : Boolean;
 l_InTable       : Boolean;
//#UC END# *4E5FB65D02AA_4810DFE100B4_var*
begin
//#UC START# *4E5FB65D02AA_4810DFE100B4_impl*
 l_OwnFont := false;
 try
  l_Fixed := false;
  l_Printing := (Metrics.InfoCanvas.Printing
                 {$IFNDef Nemesis}
                 OR not Metrics.IsWebStyle
                 {$EndIf}
                );
  if (TevStyleInterface.PrintAndExportFontSize > 0){DocumentUseFixedFontForPrintAndExportSetting} then
   if l_Printing then
    l_Fixed := true;
  if Obj.AsObject.IsValid then
  begin
   if Obj.AsObject.HasSubAtom(k2_tiFont) then
    GetParaOwnFont
   else
   begin
    if not TevStandardStyles.Instance.GetStandardStyleFont(Obj.AsObject, l_Fixed, Result) then
     GetParaOwnFont;
   end;//Obj.HasSubAtom(k2_tiFont)
  end//Obj.IsValid
  else
  begin
   Assert(false);
   l_OwnFont := true;
   if IsSegment then
    Result := nil
   else
   begin
    CheckOwnObjectFont;
    Result := l_ObjectOwnFont;
   end;//IsSegment
  end;//Obj.IsValid
 finally
  l_NeedApplyZoom := true;
  l_Zoom := Get_Zoom;
  if (l_Zoom <= 0) OR (l_Zoom >= 100) then
   l_NeedApplyZoom := false;
  l_InTable := l_NeedApplyZoom;
  DoFontSuperposition(Result, l_NeedApplyZoom, aCorrectItalic, l_InTable, l_OwnFont);
  f_ParaFont := Result;
  if l_NeedApplyZoom then
   ApplyZoom
  else
  if not l_InTable then
   ApplyPrintFontSize;
  Result.AsFont(aCorrectItalic, l_OwnFont OR IsSegment {OR l_Fixed});
  Assert(f_ParaFont = Result);
 end;//try..finally
//#UC END# *4E5FB65D02AA_4810DFE100B4_impl*
end;//TnevFormatInfo.GetObjFont

function TnevFormatInfo.Get_Rendered: Il3Bitmap;
//#UC START# *4E60F4620137_4810DFE100B4get_var*
//#UC END# *4E60F4620137_4810DFE100B4get_var*
begin
//#UC START# *4E60F4620137_4810DFE100B4get_impl*
 Result := Rendered;
//#UC END# *4E60F4620137_4810DFE100B4get_impl*
end;//TnevFormatInfo.Get_Rendered

function TnevFormatInfo.Get_LineSpacing: Integer;
//#UC START# *4E689B2A003C_4810DFE100B4get_var*
//#UC END# *4E689B2A003C_4810DFE100B4get_var*
begin
//#UC START# *4E689B2A003C_4810DFE100B4get_impl*
 Result := Obj.AsObject.IntA[k2_tiLineSpacing];
 if (Result <= 0) OR (Result = k2_TransparentValue) then
  if (Parent <> nil) then
   Result := Parent.Get_LineSpacing;
//#UC END# *4E689B2A003C_4810DFE100B4get_impl*
end;//TnevFormatInfo.Get_LineSpacing

function TnevFormatInfo.IsHidden(aRecursive: Boolean;
  aNeedCheckCollapsed: Boolean): Boolean;
//#UC START# *4E6F79C702EC_4810DFE100B4_var*
//#UC END# *4E6F79C702EC_4810DFE100B4_var*
begin
//#UC START# *4E6F79C702EC_4810DFE100B4_impl*
 Result := Self.IsHiddenPrim;
 if not Result AND aNeedCheckCollapsed AND Obj.TreatCollapsedAsHidden then
  if Metrics.IsTagCollapsed(Obj.AsObject) then
   Result := true;
 if not Result AND aRecursive then
  if (Parent <> nil) then
   Result := Parent.IsHidden(true, aNeedCheckCollapsed);
//#UC END# *4E6F79C702EC_4810DFE100B4_impl*
end;//TnevFormatInfo.IsHidden

function TnevFormatInfo.IsHiddenPrim: Boolean;
//#UC START# *4E6F9B9401BE_4810DFE100B4_var*
//#UC END# *4E6F9B9401BE_4810DFE100B4_var*
begin
//#UC START# *4E6F9B9401BE_4810DFE100B4_impl*
 if Self.Get_Hidden then
  Result := true
 else
  Result := Obj.IsHiddenPrim(Self, Metrics.HiddenStyles);
//#UC END# *4E6F9B9401BE_4810DFE100B4_impl*
end;//TnevFormatInfo.IsHiddenPrim

function TnevFormatInfo.InPara(aTypeID: Tk2Type): Boolean;
//#UC START# *4E70759C00AC_4810DFE100B4_var*
var
 l_F : TnevFormatInfo;
//#UC END# *4E70759C00AC_4810DFE100B4_var*
begin
//#UC START# *4E70759C00AC_4810DFE100B4_impl*
 Result := false;
 l_F := Self;
 while (l_F <> nil) do
 begin
  if l_F.Obj.AsObject.IsKindOf(aTypeID) then
  begin
   Result := true;
   break;
  end//l_F.Obj.IsKindOf(aTypeID)
  else
   l_F := l_F.Parent;
 end;//l_F <> nil
//#UC END# *4E70759C00AC_4810DFE100B4_impl*
end;//TnevFormatInfo.InPara

function TnevFormatInfo.Get_ImageInfo: PnevControlImageInfo;
//#UC START# *4E71EB8303BA_4810DFE100B4get_var*
var
 l_Cont  : InevObjectHolderPrim;
 l_Style : Integer;
//#UC END# *4E71EB8303BA_4810DFE100B4get_var*
begin
//#UC START# *4E71EB8303BA_4810DFE100B4get_impl*
 if not f_ImageInfo.rIsCached then
 begin
  l3FillChar(f_ImageInfo.rInfo, SizeOf(f_ImageInfo.rInfo));
  f_ImageInfo.rInfo.rImageList := nil;
  f_ImageInfo.rInfo.rFirstIndex := -1;
  f_ImageInfo.rInfo.rLastIndex := -1;
  f_ImageInfo.rInfo.rPictureOnly := False;
  l_Style := Obj.AsObject.IntA[k2_tiStyle];
  l_Style := evdStyles_Res.StyleID2ImageIndex(l_Style);
  if EvHeaderTextPara(f_Obj) then
  begin
   f_ImageInfo.rInfo.rImageList := Tl3ImageList.Make(evdStyles_Res.TreeIconList);
   f_ImageInfo.rInfo.rFirstIndex := 0;
  end // if EvHeaderTextPara(f_Obj) then
  else
  if l_Style > -1 then
  begin
   f_ImageInfo.rInfo.rPictureOnly := True;
   f_ImageInfo.rInfo.rImageList := Tl3ImageList.Make(evdStyles_Res.StylesImages);
   f_ImageInfo.rInfo.rFirstIndex := l_Style;
  end // if l_Style > -1 then
  else
   if Metrics.AACLike in [nev_aacLeft, nev_aacRight] then
   begin
    f_ImageInfo.rInfo.rImageList := Tl3ImageList.Make(evdStyles_Res.AACImages);
    f_ImageInfo.rInfo.rFirstIndex := 0;
   end // if Metrics.AACLike then
   else
   begin
    l_Cont :=  Obj.HolderPrim;
    if (l_Cont = nil) then
     if (Metrics.Data <> nil) then
      l_Cont := Metrics.Data.HolderPrim;
    if (l_Cont <> nil) then
     l_Cont.GetControlImg(TnevControlInfo_C(Obj,
                                            Self,
                                            Metrics),
                          f_ImageInfo.rInfo);
   end;//f_ImageInfo.rInfo.rImageList = nil..
  f_ImageInfo.rIsCached := true;
 end;//f_ImageInfo.rIsCached
 f_ImageInfo.rInfo.rHidePicture := Metrics.InfoCanvas.Printing;
 Result := @f_ImageInfo.rInfo;
//#UC END# *4E71EB8303BA_4810DFE100B4get_impl*
end;//TnevFormatInfo.Get_ImageInfo

function TnevFormatInfo.Get_Metrics: InevViewMetrics;
//#UC START# *4E71EBC103C5_4810DFE100B4get_var*
//#UC END# *4E71EBC103C5_4810DFE100B4get_var*
begin
//#UC START# *4E71EBC103C5_4810DFE100B4get_impl*
 Result := Self.Metrics;
//#UC END# *4E71EBC103C5_4810DFE100B4get_impl*
end;//TnevFormatInfo.Get_Metrics

function TnevFormatInfo.Get_Spacing: TnevRect;
//#UC START# *4E71EBFF00A1_4810DFE100B4get_var*
//#UC END# *4E71EBFF00A1_4810DFE100B4get_var*
begin
//#UC START# *4E71EBFF00A1_4810DFE100B4get_impl*
 if not f_Spacing.rIsCached then
 begin
  f_Spacing.rValue := locSpacing;
  f_Spacing.rIsCached := true;
 end;//not f_Spacing.rIsCached
 Result := f_Spacing.rValue;
//#UC END# *4E71EBFF00A1_4810DFE100B4get_impl*
end;//TnevFormatInfo.Get_Spacing

function TnevFormatInfo.Get_Obj: InevObjectPrim;
//#UC START# *4E71EC33013E_4810DFE100B4get_var*
//#UC END# *4E71EC33013E_4810DFE100B4get_var*
begin
//#UC START# *4E71EC33013E_4810DFE100B4get_impl*
 Result := Obj;
//#UC END# *4E71EC33013E_4810DFE100B4get_impl*
end;//TnevFormatInfo.Get_Obj

procedure TnevFormatInfo.ClearFields;
 {-}
begin
 SectionBreak := nil;
 f_Obj := nil;
 inherited;
end;//TnevFormatInfo.ClearFields

function TnevFormatInfo.VerticalAlignmentMargin: Integer;
//#UC START# *52021CDE00B2_4810DFE100B4_var*
//#UC END# *52021CDE00B2_4810DFE100B4_var*
begin
//#UC START# *52021CDE00B2_4810DFE100B4_impl*
 Result := 0;
//#UC END# *52021CDE00B2_4810DFE100B4_impl*
end;//TnevFormatInfo.VerticalAlignmentMargin

function TnevFormatInfo.GreatestObjPID(anInLines: Boolean = True): Integer;
//#UC START# *55794BA600EA_4810DFE100B4_var*
//#UC END# *55794BA600EA_4810DFE100B4_var*
begin
//#UC START# *55794BA600EA_4810DFE100B4_impl*
 Result := -1;
 Assert(False);
//#UC END# *55794BA600EA_4810DFE100B4_impl*
end;//TnevFormatInfo.GreatestObjPID

end.