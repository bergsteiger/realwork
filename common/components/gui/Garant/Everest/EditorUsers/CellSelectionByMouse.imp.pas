{$IfNDef CellSelectionByMouse_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\EditorUsers\CellSelectionByMouse.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "CellSelectionByMouse" MUID: (4E97EE2D00D7)
// Имя типа: "_CellSelectionByMouse_"

{$Define CellSelectionByMouse_imp}

{$If NOT Defined(NoScripts)}
 _Para2Point_Parent_ = _CellSelectionByMouse_Parent_;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\Para2Point.imp.pas}
 _HotSpotTools_Parent_ = _Para2Point_;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\HotSpotTools.imp.pas}
 _CellSelectionByMouse_ = class(_HotSpotTools_)
  protected
   function GetPoint(const aMap: InevMap): Tl3Point; override;
    {* Возвращает точку, на которую нужно спозиционироваться. }
  public
   function SelectCell(aText: TevCustomEditorWindow): Boolean;
 end;//_CellSelectionByMouse_

{$Else NOT Defined(NoScripts)}

_Para2Point_Parent_ = _CellSelectionByMouse_Parent_;
{$Include w:\common\components\gui\Garant\Everest\EditorUsers\Para2Point.imp.pas}
_HotSpotTools_Parent_ = _Para2Point_;
{$Include w:\common\components\gui\Garant\Everest\EditorUsers\HotSpotTools.imp.pas}
_CellSelectionByMouse_ = _HotSpotTools_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else CellSelectionByMouse_imp}

{$IfNDef CellSelectionByMouse_imp_impl}

{$Define CellSelectionByMouse_imp_impl}

{$If NOT Defined(NoScripts)}
{$Include w:\common\components\gui\Garant\Everest\EditorUsers\Para2Point.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\HotSpotTools.imp.pas}

function _CellSelectionByMouse_.SelectCell(aText: TevCustomEditorWindow): Boolean;
//#UC START# *4E97EEAA0320_4E97EE2D00D7_var*
var
 l_HotSpot : IevHotSpot;
 l_Effect  : TevMouseEffect;
 l_Keys    : TevMouseState;
 l_l3Pt    : Tl3Point;
//#UC END# *4E97EEAA0320_4E97EE2D00D7_var*
begin
//#UC START# *4E97EEAA0320_4E97EE2D00D7_impl*
 l_l3Pt := TranslatePara2Point(aText);
 l_HotSpot := GetHotSpot(aText, l_l3Pt, False);
 if l_HotSpot <> nil then
 begin
  l3FillChar(l_Keys, SizeOf(l_Keys), 0);
  l_Keys.rKeys := [];
  l_Keys.rInitialPoint := l_l3Pt;
  l_Keys.rPoint := l_l3Pt;
  l_HotSpot.LButtonDown(aText.View, l_Keys, l_Effect);
 end; // if l_HotSpotTester.GetAdvancedHotSpot(aText.View,
 Result := true;
//#UC END# *4E97EEAA0320_4E97EE2D00D7_impl*
end;//_CellSelectionByMouse_.SelectCell

function _CellSelectionByMouse_.GetPoint(const aMap: InevMap): Tl3Point;
 {* Возвращает точку, на которую нужно спозиционироваться. }
//#UC START# *4C3C927B027E_4E97EE2D00D7_var*
//#UC END# *4C3C927B027E_4E97EE2D00D7_var*
begin
//#UC START# *4C3C927B027E_4E97EE2D00D7_impl*
 if aMap = nil then
  Result := l3Point0
 else
  Result := l3Point(aMap.Bounds.Left + 3 * evEpsilon, aMap.Outer.Bounds.Bottom - 2 * evEpsilon);
//#UC END# *4C3C927B027E_4E97EE2D00D7_impl*
end;//_CellSelectionByMouse_.GetPoint
{$IfEnd} // NOT Defined(NoScripts)

{$EndIf CellSelectionByMouse_imp_impl}

{$EndIf CellSelectionByMouse_imp}

