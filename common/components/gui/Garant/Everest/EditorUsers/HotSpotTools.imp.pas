{$IfNDef HotSpotTools_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\EditorUsers\HotSpotTools.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "HotSpotTools" MUID: (4D53D342026E)
// Имя типа: "_HotSpotTools_"

{$Define HotSpotTools_imp}

{$If NOT Defined(NoScripts)}
 _HotSpotTools_ = class(_HotSpotTools_Parent_)
  {* Работа с хотспотом }
  protected
   function GetHotSpot(aText: TevCustomEditorWindow;
    const aPoint: Tl3Point;
    aMoveLeft: Boolean): IevHotSpot; virtual;
    {* Получить курсор по точке. }
 end;//_HotSpotTools_

{$Else NOT Defined(NoScripts)}

_HotSpotTools_ = _HotSpotTools_Parent_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else HotSpotTools_imp}

{$IfNDef HotSpotTools_imp_impl}

{$Define HotSpotTools_imp_impl}

{$If NOT Defined(NoScripts)}
function _HotSpotTools_.GetHotSpot(aText: TevCustomEditorWindow;
 const aPoint: Tl3Point;
 aMoveLeft: Boolean): IevHotSpot;
 {* Получить курсор по точке. }
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
 if l_Point <> nil then
   if aText.Document.AsObject.QT(InevHotSpotTester2, l_HotSpotTester, aText.TextSource.Processor) then
    l_HotSpotTester.GetAdvancedHotSpot(aText.View, l_State, l_Point, l_Map, Result);
//#UC END# *4D53D37F00AE_4D53D342026E_impl*
end;//_HotSpotTools_.GetHotSpot
{$IfEnd} // NOT Defined(NoScripts)

{$EndIf HotSpotTools_imp_impl}

{$EndIf HotSpotTools_imp}

