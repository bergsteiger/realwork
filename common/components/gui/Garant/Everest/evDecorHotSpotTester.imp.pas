{$IfNDef evDecorHotSpotTester_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evDecorHotSpotTester.imp.pas"
// Начат: 13.09.2011 13:08
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::HotSpots::evDecorHotSpotTester
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define evDecorHotSpotTester_imp}
{$If defined(evNeedHotSpot)}
 _evDecorHotSpotTester_ = {mixin} class(_evDecorHotSpotTester_Parent_)
 protected
 // protected methods
   function GetDecorHotSpot(aType: TnevDecorType;
     const aView: InevControlView;
     const aState: TevCursorState;
     const aMap: InevMap;
     out theSpot: IevHotSpot): Boolean;
 end;//_evDecorHotSpotTester_
{$Else}

 _evDecorHotSpotTester_ = _evDecorHotSpotTester_Parent_;

{$IfEnd} //evNeedHotSpot

{$Else evDecorHotSpotTester_imp}

{$If defined(evNeedHotSpot)}

// start class _evDecorHotSpotTester_

function _evDecorHotSpotTester_.GetDecorHotSpot(aType: TnevDecorType;
  const aView: InevControlView;
  const aState: TevCursorState;
  const aMap: InevMap;
  out theSpot: IevHotSpot): Boolean;
//#UC START# *4E6F1DD701FA_4E6F1D860184_var*
//#UC END# *4E6F1DD701FA_4E6F1D860184_var*
var
 l_Decor : Tl3Tag;
 l_T : InevHotSpotTester2;
 l_O : InevObject;
 l_Map : InevMap;
 l_Pt : InevBasePoint;
 l_P : InevPara;
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

{$IfEnd} //evNeedHotSpot

{$EndIf evDecorHotSpotTester_imp}
