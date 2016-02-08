{$IfNDef evDecorHotSpotTester_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\evDecorHotSpotTester.imp.pas"
// Стереотип: "Impurity"

{$Define evDecorHotSpotTester_imp}

{$If Defined(evNeedHotSpot)}
 _evDecorHotSpotTester_ = class(_evDecorHotSpotTester_Parent_)
  protected
   function GetDecorHotSpot(aType: TnevDecorType;
    const aView: InevControlView;
    const aState: TevCursorState;
    const aMap: InevMap;
    out theSpot: IevHotSpot): Boolean;
 end;//_evDecorHotSpotTester_

{$Else Defined(evNeedHotSpot)}

_evDecorHotSpotTester_ = _evDecorHotSpotTester_Parent_;

{$IfEnd} // Defined(evNeedHotSpot)
{$Else evDecorHotSpotTester_imp}

{$IfNDef evDecorHotSpotTester_imp_impl}

{$Define evDecorHotSpotTester_imp_impl}

{$If Defined(evNeedHotSpot)}
function _evDecorHotSpotTester_.GetDecorHotSpot(aType: TnevDecorType;
 const aView: InevControlView;
 const aState: TevCursorState;
 const aMap: InevMap;
 out theSpot: IevHotSpot): Boolean;
var l_Decor: Tl3Tag;
var l_T: InevHotSpotTester2;
var l_O: InevObject;
var l_Map: InevMap;
var l_Pt: InevBasePoint;
var l_P: InevPara;
//#UC START# *4E6F1DD701FA_4E6F1D860184_var*
//#UC END# *4E6F1DD701FA_4E6F1D860184_var*
begin
//#UC START# *4E6F1DD701FA_4E6F1D860184_impl*
 Result := false;
 l_Decor := aMap.FI.DecorObj(aType);
 if l_Decor.IsValid then
  if l_Decor.QT(InevHotSpotTester2, l_T) then
  begin
   if not l_Decor.QT(InevObject, l_O) then
    Assert(false);
   l_Map := aMap.ReserveMap(l_O);
   l_Pt := l_O.MakePoint;
   if not l_O.AsObject.QT(InevPara, l_P) then
    Assert(false);
   l_Pt.AsLeaf.InitPointByPt(aView, aState.rPoint, l_Map);
   Result := l_T.GetAdvancedHotSpot(aView,
                                    aState,
                                    l_Pt,
                                    l_Map,
                                    theSpot);
  end;//l_Decor.QT(InevHotSpotTester2, l_T)
//#UC END# *4E6F1DD701FA_4E6F1D860184_impl*
end;//_evDecorHotSpotTester_.GetDecorHotSpot
{$IfEnd} // Defined(evNeedHotSpot)

{$EndIf evDecorHotSpotTester_imp_impl}

{$EndIf evDecorHotSpotTester_imp}

