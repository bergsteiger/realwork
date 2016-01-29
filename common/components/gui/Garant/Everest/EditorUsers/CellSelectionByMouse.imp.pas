{$IfNDef CellSelectionByMouse_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest$EditorUsers"
// Модуль: "w:/common/components/gui/Garant/Everest/EditorUsers/CellSelectionByMouse.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest$EditorUsers::MixIns::CellSelectionByMouse
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define CellSelectionByMouse_imp}
{$If not defined(NoScripts)}
 _Para2Point_Parent_ = _CellSelectionByMouse_Parent_;
 {$Include ..\EditorUsers\Para2Point.imp.pas}
 _HotSpotTools_Parent_ = _Para2Point_;
 {$Include ..\EditorUsers\HotSpotTools.imp.pas}
 _CellSelectionByMouse_ = {mixin} class(_HotSpotTools_)
 protected
 // overridden protected methods
   function GetPoint(const aMap: InevMap): Tl3Point; override;
     {* Возвращает точку, на которую нужно спозиционироваться. }
 public
 // public methods
   function SelectCell(aText: TevCustomEditorWindow): Boolean;
 end;//_CellSelectionByMouse_
{$Else}

 _Para2Point_Parent_ = _CellSelectionByMouse_Parent_;
 {$Include ..\EditorUsers\Para2Point.imp.pas}
 _HotSpotTools_Parent_ = _Para2Point_;
 {$Include ..\EditorUsers\HotSpotTools.imp.pas}
 _CellSelectionByMouse_ = _HotSpotTools_;

{$IfEnd} //not NoScripts

{$Else CellSelectionByMouse_imp}

{$If not defined(NoScripts)}

{$Include ..\EditorUsers\Para2Point.imp.pas}

{$Include ..\EditorUsers\HotSpotTools.imp.pas}

// start class _CellSelectionByMouse_

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
//#UC START# *4C3C927B027E_4E97EE2D00D7_var*
//#UC END# *4C3C927B027E_4E97EE2D00D7_var*
begin
//#UC START# *4C3C927B027E_4E97EE2D00D7_impl*
 Result := l3Point(aMap.Bounds.Left + 3 * evEpsilon, aMap.Outer.Bounds.Bottom - 2 * evEpsilon);
//#UC END# *4C3C927B027E_4E97EE2D00D7_impl*
end;//_CellSelectionByMouse_.GetPoint

{$IfEnd} //not NoScripts

{$EndIf CellSelectionByMouse_imp}
