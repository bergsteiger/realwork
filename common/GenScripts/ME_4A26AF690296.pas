unit evTextParaHotSpotTester;

// Модуль: "w:\common\components\gui\Garant\Everest\evTextParaHotSpotTester.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , k2TagTool
 , nevGUIInterfaces
 , l3Variant
 , nevTools
 , nevBase
 , evSegmentHotSpot
;

type
 RevSegmentClass = class of TevSegmentHotSpot;

 _evDecorHotSpotTester_Parent_ = Tk2TagTool;
 {$Include evDecorHotSpotTester.imp.pas}
 TevTextParaHotSpotTester = class(_evDecorHotSpotTester_, InevHotSpotTester2)
  protected
   function GetSegmentClass: RevSegmentClass; virtual;
   function DoGetAdvancedHotSpot(const aView: InevControlView;
    const aState: TevCursorState;
    const aPt: InevBasePoint;
    const aMap: InevMap;
    out theSpot: IevHotSpot): Boolean; virtual;
   function GetAdvancedHotSpot(const aView: InevControlView;
    const aState: TevCursorState;
    const aPt: InevBasePoint;
    const aMap: InevMap;
    out theSpot: IevHotSpot): Boolean;
    {* Возвращает "горячую точку" }
  public
   class function Make(aTag: Tl3Variant): InevHotSpotTester2; reintroduce;
 end;//TevTextParaHotSpotTester
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
 , k2Tags
 , evdTypes
 , k2Base
 , l3Units
 , l3Types
 , evTextParaHeaderHotSpot
 , evdStyles
 , evParaCollapser
 , evDecorHotSpot
 , l3String
 {$If Defined(k2ForEditor)}
 , evTextParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , evExpandedTextCollapser
 , evArchiCollapser
 {$If Defined(k2ForEditor)}
 , evAACContentUtils
 {$IfEnd} // Defined(k2ForEditor)
;

{$Include evDecorHotSpotTester.imp.pas}

function TevTextParaHotSpotTester.GetSegmentClass: RevSegmentClass;
//#UC START# *4A26B035006A_4A26AF690296_var*
//#UC END# *4A26B035006A_4A26AF690296_var*
begin
//#UC START# *4A26B035006A_4A26AF690296_impl*
 Result := TevSegmentHotSpot;
//#UC END# *4A26B035006A_4A26AF690296_impl*
end;//TevTextParaHotSpotTester.GetSegmentClass

class function TevTextParaHotSpotTester.Make(aTag: Tl3Variant): InevHotSpotTester2;
var
 l_Inst : TevTextParaHotSpotTester;
begin
 l_Inst := Create(aTag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevTextParaHotSpotTester.Make

function TevTextParaHotSpotTester.DoGetAdvancedHotSpot(const aView: InevControlView;
 const aState: TevCursorState;
 const aPt: InevBasePoint;
 const aMap: InevMap;
 out theSpot: IevHotSpot): Boolean;
//#UC START# *4A26B4EB02EB_4A26AF690296_var*

var
 l_Segment     : Tl3Variant;
 l_LayerHandle : Integer;

 function LayerGetSegmentOnPos(aLayer: Tl3Variant; Index: Integer): Boolean;
 var
  l_Seg    : Tl3Variant;
  l_Len    : Integer;
  l_Handle : Integer;
 begin//LayerGetSegmentOnPos
  l_Handle := aLayer.IntA[k2_tiHandle];
  if (l_Handle > Ord(ev_slSuperposition))
     {$IfDef Nemesis}
     AND (l_Handle < Ord(ev_slFoundWords))
     {$EndIf Nemesis} then
  begin
   l_Seg := aLayer.rAtomEx([k2_tiChildren, l3_siNative, Succ(aPt.Position)]);
   if l_Seg.IsValid then
   begin
    l_Segment := l_Seg;
    l_LayerHandle := l_Handle;
   end//l_Seg.IsValid
   else
    if aView.Metrics.AACLike = nev_aacLeft then
    begin
     l_Len := TagInst.PCharLenA[k2_tiText].SLen;
     l_Seg := aLayer.rAtomEx([k2_tiChildren, l3_siNative, l_Len - 2]);
     if EvIsAACItem(l_Seg, l_Len, True) then
     begin
      l_Segment := l_Seg;
      l_LayerHandle := l_Handle;
     end//l_Seg.IsValid
    end; // if aView.Metrics.AACLike = nev_aacLeft then
  end;//l_Handle > ev_slSuperposition
  Result := true;
 end;//LayerGetSegmentOnPos

 function lp_CheckExpandedTextHeader(aPara: InevPara): Boolean;
 var
  l_Segment: Tl3Variant;
 begin
  Result := False;
  l_Segment := evGetFirstParaHyperlink(aPara, aMap.FI);
  if l_Segment <> nil then
  begin
   {$IFDEF Nemesis}
   theSpot := GetSegmentClass.Make(aPt, l_Segment, Ord(ev_slHyperlinks), aView.Processor);
   theSpot := TevExpandedTextCollapser.Make(aPara, theSpot);
   {$ELSE}
   theSpot := TevArchiCollapser.Make(aPt, l_Segment, Ord(ev_slHyperlinks), aView.Processor);
   {$ENDIF Nemesis}
   Result := True;
  end; // if l_Segment <> nil then
 end;

var
 l_Para  : InevPara;
 l_M     : TnevRect;
 l_Y     : Integer;
//#UC END# *4A26B4EB02EB_4A26AF690296_var*
begin
//#UC START# *4A26B4EB02EB_4A26AF690296_impl*
 Result := false;
 if Tl3Rect(aMap.Bounds).ContainsPt(aState.rPoint) then
 begin
  if not GetRedirect.QT(InevPara, l_Para) then
   Assert(false);
  l_M := aMap.FI.Spacing;
  l_Y := aState.rPoint.Y - aMap.Bounds.Top;
  if (l_M.Bottom > 0) AND
     (l_Y > aMap.Bounds.Bottom - aMap.Bounds.Top - l_M.Bottom) then
  begin
   if GetDecorHotSpot(nev_dtFooter, aView, aState, aMap, theSpot) then
   begin
    Result := true;
    theSpot := TevDecorHotSpot.Make(l_Para, theSpot);
    Exit;
   end;//GetDecorHotSpot
  end;//l_M.Bottom > 0
  if (l_M.Top > 0) AND
     (l_Y < l_M.Top) then
  begin
   if GetDecorHotSpot(nev_dtHeader, aView, aState, aMap, theSpot) then
   begin
    Result := true;
    if l_Para.AsObject.Attr[k2_tiStyle].BoolA[k2_tiCollapsable] then
     theSpot := TevParaCollapser.Make(l_Para, theSpot)
    else
     theSpot := TevDecorHotSpot.Make(l_Para, theSpot);
    Exit;
   end;//GetDecorHotSpot
   {$If Defined(Nemesis) OR (not Defined(Archi) AND not Defined(EverestLite))}
   // http://mdp.garant.ru/pages/viewpage.action?pageId=264902382
   Result := true;
   if l_Para.AsObject.Attr[k2_tiStyle].BoolA[k2_tiCollapsable] AND
      not l3IsNil(l_Para.AsObject.Attr[k2_tiStyle].PCharLenA[k2_tiShortName]) AND
      not aMap.FI.DecorObj(nev_dtHeader).IsValid then
    theSpot := TevTextParaHeaderHotSpot.Make(l_Para, aView.Processor)
   else
   {$IfEnd}
    Result := false;
  end//l_Y < l_M.Top
  else
  begin
   Result := lp_CheckExpandedTextHeader(l_Para);
   if not Result then
   begin
    l_Segment := k2NullTag;
    with l_Para.AsObject.Attr[k2_tiSegments] do
     if IsValid then
     begin
      IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@LayerGetSegmentOnPos));
      if l_Segment.IsValid then
      begin
       theSpot := GetSegmentClass.Make(aPt, l_Segment, l_LayerHandle, aView.Processor);
       Result := True;
       Exit;
      end;//l_Segment.IsValid
     end;//IsValid
   end; // if not Result then
  end;//l_Y < l_M.Top
 end;//aMap.Bounds.ContainsPt(aState.rPoint)
//   IevHotSpot(Result) := TevTextParaHotSpot.Make(l_EntryPoint.Position);
//#UC END# *4A26B4EB02EB_4A26AF690296_impl*
end;//TevTextParaHotSpotTester.DoGetAdvancedHotSpot

function TevTextParaHotSpotTester.GetAdvancedHotSpot(const aView: InevControlView;
 const aState: TevCursorState;
 const aPt: InevBasePoint;
 const aMap: InevMap;
 out theSpot: IevHotSpot): Boolean;
 {* Возвращает "горячую точку" }
//#UC START# *4A250DD6037C_4A26AF690296_var*
//#UC END# *4A250DD6037C_4A26AF690296_var*
begin
//#UC START# *4A250DD6037C_4A26AF690296_impl*
 Result := DoGetAdvancedHotSpot(aView, aState, aPt, aMap, theSpot);
//#UC END# *4A250DD6037C_4A26AF690296_impl*
end;//TevTextParaHotSpotTester.GetAdvancedHotSpot
{$IfEnd} // Defined(evNeedHotSpot)

end.
