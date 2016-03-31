unit NOT_COMPLETED_evParaCursor;
 {* Базовый класс для реализации курсора параграфа }

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_COMPLETED_evParaCursor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevParaCursor" MUID: (49DE22650362)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evCursor
 , nevTools
 , l3Interfaces
 , evMarker
 , l3Variant
 , nevBase
 , l3Core
;

type
 TevParaCursor = class(TevCursor{$If Defined(evNeedMarkers)}
 , IevMarkersSource
 {$IfEnd} // Defined(evNeedMarkers)
 )
  {* Базовый класс для реализации курсора параграфа }
  protected
   {$If Defined(evNeedMarkers)}
   procedure AddMarker(const aView: InevView;
    const aList: IevMarkersList;
    aType: Integer;
    aStyle: TevParaMarkerStyle;
    const aHint: Il3CString;
    aMarkerClass: RevMarker = nil);
   {$IfEnd} // Defined(evNeedMarkers)
   {$If Defined(evNeedMarkers)}
   procedure DoGetMarkers(const aView: InevView;
    const aList: IevMarkersList); virtual;
   {$IfEnd} // Defined(evNeedMarkers)
   {$If Defined(evNeedMarkers)}
   procedure GetMarkers(const aView: InevView;
    const aList: IevMarkersList);
    {* получить маркеры из источника в aList. }
   {$IfEnd} // Defined(evNeedMarkers)
   function DoDeleteCharToLeft(const aView: InevView;
    aDrawLines: Boolean;
    const anOp: InevOp): Boolean; override;
   function DoGetStyle(Stop: PInteger): Tl3Variant; override;
   function DoChangeParam(const aView: InevView;
    const aMarker: IevMarker;
    aValue: Integer;
    const anOp: InevOp): Boolean; override;
   function DoGetFont(const aView: InevView;
    aMap: TnevFormatInfoPrim;
    Stop: PInteger): InevFontPrim; override;
   {$If Defined(evNeedMarkers)}
   function pm_GetMarkersSource: IevMarkersSource; override;
   {$IfEnd} // Defined(evNeedMarkers)
 end;//TevParaCursor
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , evExcept
 , evOp
 , nevInterfaces
 , k2Base
 , SysUtils
 , k2Tags
;

{$If Defined(evNeedMarkers)}
procedure TevParaCursor.AddMarker(const aView: InevView;
 const aList: IevMarkersList;
 aType: Integer;
 aStyle: TevParaMarkerStyle;
 const aHint: Il3CString;
 aMarkerClass: RevMarker = nil);
//#UC START# *4A38AA9702EC_49DE22650362_var*
var
 l_Marker : TevMarker;
//#UC END# *4A38AA9702EC_49DE22650362_var*
begin
//#UC START# *4A38AA9702EC_49DE22650362_impl*
 if (aMarkerClass = nil) then aMarkerClass := TevMarker;
 if not Tk2Type(GetRedirect.TagType).Prop[aType].ReadOnly then
 begin
  l_Marker := aMarkerClass.Create(aView, GetRedirect, aType, aStyle, aHint);
  try
   aList.Add(l_Marker);
  finally
   FreeAndNil(l_Marker);
  end;//try..finally
 end;//not GetRedirect.Prop[aType].ReadOnly
//#UC END# *4A38AA9702EC_49DE22650362_impl*
end;//TevParaCursor.AddMarker
{$IfEnd} // Defined(evNeedMarkers)

{$If Defined(evNeedMarkers)}
procedure TevParaCursor.DoGetMarkers(const aView: InevView;
 const aList: IevMarkersList);
//#UC START# *4A38AA5C019F_49DE22650362_var*
//#UC END# *4A38AA5C019F_49DE22650362_var*
begin
//#UC START# *4A38AA5C019F_49DE22650362_impl*
 with Tk2Type(GetRedirect.TagType) do
 begin
  if not Prop[k2_tiLeftIndent].ReadOnly then
   AddMarker(aView, aList, k2_tiLeftIndent, ev_pmsParaIndent,
    str_nevmhLeftIndent.AsCStr);
  if not Prop[k2_tiWidth].ReadOnly then
   AddMarker(aView, aList, k2_tiWidth, ev_pmsParaSize,
    str_nevmhRightIndent.AsCStr);
 end;//GetRedirect.TagType
//#UC END# *4A38AA5C019F_49DE22650362_impl*
end;//TevParaCursor.DoGetMarkers
{$IfEnd} // Defined(evNeedMarkers)

{$If Defined(evNeedMarkers)}
procedure TevParaCursor.GetMarkers(const aView: InevView;
 const aList: IevMarkersList);
 {* получить маркеры из источника в aList. }
//#UC START# *47C689AE016E_49DE22650362_var*
var
 l_I  : InevBasePoint;
 l_MS : IevMarkersSource;
//#UC END# *47C689AE016E_49DE22650362_var*
begin
//#UC START# *47C689AE016E_49DE22650362_impl*
 if (aList <> nil) then
 begin
  DoGetMarkers(aView, aList);       
  l_I := Self.GetInner;
  if (l_I <> nil) AND l_I.Obj.AsObject.IsValid and not l_I.AfterEnd and not l_I.BeforeStart then
  begin
   l_MS := l_I.MarkersSource;
   if (l_MS <> nil) then
    l_MS.GetMarkers(aView, aList);
  end;//l_I <> nil..
 end;//aList <> nil
//#UC END# *47C689AE016E_49DE22650362_impl*
end;//TevParaCursor.GetMarkers
{$IfEnd} // Defined(evNeedMarkers)

function TevParaCursor.DoDeleteCharToLeft(const aView: InevView;
 aDrawLines: Boolean;
 const anOp: InevOp): Boolean;
//#UC START# *4A29419B0319_49DE22650362_var*
var
 l_DC : InevText;
//#UC END# *4A29419B0319_49DE22650362_var*
begin
//#UC START# *4A29419B0319_49DE22650362_impl*
 Result := false;
 l_DC := Self.pm_GetTopParentPoint.Text;
 if (l_DC <> nil) then
  try
   if aDrawLines then
   begin
    try
     if Move(aView, ev_ocPrevCharForDelete, anOp) then
      Result := l_DC.Modify.DeleteChar(aView, aDrawLines, anOp);
    except
     on EevReadOnly do Result := true;
    end;//try..except
   end//aDrawLines
   else
   begin
    if Move(aView, ev_ocCharLeft, anOp) then
     Result := l_DC.Modify.DeleteChar(aView, aDrawLines, anOp);
   end;//aDrawLines
  finally
   l_DC := nil;
  end;//try..finally
//#UC END# *4A29419B0319_49DE22650362_impl*
end;//TevParaCursor.DoDeleteCharToLeft

function TevParaCursor.DoGetStyle(Stop: PInteger): Tl3Variant;
//#UC START# *4A2945060101_49DE22650362_var*
var
 l_CP : InevBasePoint;  
//#UC END# *4A2945060101_49DE22650362_var*
begin
//#UC START# *4A2945060101_49DE22650362_impl*
 l_CP := Self.GetInner;
 if (l_CP <> nil) and not l_CP.AfterEnd and not l_CP.BeforeStart then
  Result := l_CP.Formatting.GetStyle(Stop)
 else
  Result := nil;
//#UC END# *4A2945060101_49DE22650362_impl*
end;//TevParaCursor.DoGetStyle

function TevParaCursor.DoChangeParam(const aView: InevView;
 const aMarker: IevMarker;
 aValue: Integer;
 const anOp: InevOp): Boolean;
//#UC START# *4A29465701BC_49DE22650362_var*
//#UC END# *4A29465701BC_49DE22650362_var*
begin
//#UC START# *4A29465701BC_49DE22650362_impl*
 if GetRedirect.IsSame(aMarker.Para.AsObject) then
 begin
  aMarker.SetValue(aValue, anOp);
  Result := true;
 end//GetRedirect.IsSame(aMarker.Para)
 else
  Result := false;
//#UC END# *4A29465701BC_49DE22650362_impl*
end;//TevParaCursor.DoChangeParam

function TevParaCursor.DoGetFont(const aView: InevView;
 aMap: TnevFormatInfoPrim;
 Stop: PInteger): InevFontPrim;
//#UC START# *4A29477801BF_49DE22650362_var*
var
 l_CP  : InevBasePoint;
 l_Map : TnevFormatInfoPrim;
//#UC END# *4A29477801BF_49DE22650362_var*
begin
//#UC START# *4A29477801BF_49DE22650362_impl*
 l_CP := Self.GetInner;
 if (l_CP = nil) then
  Result := nil
 else
 begin
  l_Map := aMap.InfoForChild(l_CP.Obj^);
  if (l_Map = nil) then
  // http://mdp.garant.ru/pages/viewpage.action?pageId=110986032
   Result := nil
  else
   Result := l_CP.Formatting.GetFont(aView, l_Map, Stop);
 end;//l_CP = nil
//#UC END# *4A29477801BF_49DE22650362_impl*
end;//TevParaCursor.DoGetFont

{$If Defined(evNeedMarkers)}
function TevParaCursor.pm_GetMarkersSource: IevMarkersSource;
//#UC START# *4A38BC2D00FB_49DE22650362get_var*
//#UC END# *4A38BC2D00FB_49DE22650362get_var*
begin
//#UC START# *4A38BC2D00FB_49DE22650362get_impl*
 Result := Self;
//#UC END# *4A38BC2D00FB_49DE22650362get_impl*
end;//TevParaCursor.pm_GetMarkersSource
{$IfEnd} // Defined(evNeedMarkers)

{$IfEnd} // Defined(evUseVisibleCursors)
end.
