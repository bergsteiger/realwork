{$IfNDef HotSpotTools_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest$EditorUsers"
// Модуль: "w:/common/components/gui/Garant/Everest/EditorUsers/HotSpotTools.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest$EditorUsers::MixIns::HotSpotTools
//
// Работа с хотспотом
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define HotSpotTools_imp}
{$If not defined(NoScripts)}
 _HotSpotTools_ = {mixin} class(_HotSpotTools_Parent_)
  {* Работа с хотспотом }
 protected
 // protected methods
   function GetHotSpot(aText: TevCustomEditorWindow;
    const aPoint: Tl3Point;
    aMoveLeft: Boolean): IevHotSpot; virtual;
     {* Получить курсор по точке. }
 end;//_HotSpotTools_
{$Else}

 _HotSpotTools_ = _HotSpotTools_Parent_;

{$IfEnd} //not NoScripts

{$Else HotSpotTools_imp}

{$If not defined(NoScripts)}

// start class _HotSpotTools_

function _HotSpotTools_.GetHotSpot(aText: TevCustomEditorWindow;
  const aPoint: Tl3Point;
  aMoveLeft: Boolean): IevHotSpot;
//#UC START# *4D53D37F00AE_4D53D342026E_var*
var
 l_Map           : InevMap;
 l_State         : TevCursorState;
 l_Point         : InevBasePoint;
 l_HotSpotTester : InevHotSpotTester2;
//#UC END# *4D53D37F00AE_4D53D342026E_var*
begin
//#UC START# *4D53D37F00AE_4D53D342026E_impl*
 Result := nil;
 if aMoveLeft then
  l_Point := aText.View.PointByPt(l3Point(aPoint.X - 50, aPoint.Y))
 else
  l_Point := aText.View.PointByPt(aPoint);
 l_Map := aText.View.RootMap;
 l_State.rInitialPoint := aPoint;
 l_State.rPoint := aPoint;
 l_State.rKeys := [];
 if aText.Document.AsObject.QT(InevHotSpotTester2, l_HotSpotTester, aText.TextSource.Processor) then
  l_HotSpotTester.GetAdvancedHotSpot(aText.View, l_State, l_Point, l_Map, Result);
//#UC END# *4D53D37F00AE_4D53D342026E_impl*
end;//_HotSpotTools_.GetHotSpot

{$IfEnd} //not NoScripts

{$EndIf HotSpotTools_imp}
