{$IfNDef MouseClickOnPoint_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\EditorUsers\MouseClickOnPoint.imp.pas"
// Стереотип: "Impurity"

{$Define MouseClickOnPoint_imp}

{$If NOT Defined(NoScripts)}
 _Para2Point_Parent_ = _MouseClickOnPoint_Parent_;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\Para2Point.imp.pas}
 _HotSpotTools_Parent_ = _Para2Point_;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\HotSpotTools.imp.pas}
 _MouseClickOnPoint_ = class(_HotSpotTools_)
  {* Щелчок мышью на точке в редакторе }
  protected
   procedure ClickOnPoint(aText: TevCustomEditorWindow;
    aNeedMouseUp: Boolean); virtual;
 end;//_MouseClickOnPoint_

{$Else NOT Defined(NoScripts)}

_Para2Point_Parent_ = _MouseClickOnPoint_Parent_;
{$Include w:\common\components\gui\Garant\Everest\EditorUsers\Para2Point.imp.pas}
_HotSpotTools_Parent_ = _Para2Point_;
{$Include w:\common\components\gui\Garant\Everest\EditorUsers\HotSpotTools.imp.pas}
_MouseClickOnPoint_ = _HotSpotTools_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else MouseClickOnPoint_imp}

{$IfNDef MouseClickOnPoint_imp_impl}

{$Define MouseClickOnPoint_imp_impl}

{$If NOT Defined(NoScripts)}
{$Include w:\common\components\gui\Garant\Everest\EditorUsers\Para2Point.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\HotSpotTools.imp.pas}

procedure _MouseClickOnPoint_.ClickOnPoint(aText: TevCustomEditorWindow;
 aNeedMouseUp: Boolean);
//#UC START# *4DDF64120066_4DDF61B503D1_var*
var
 l_HotSpot : IevHotSpot;
 l_Effect  : TevMouseEffect;
 l_Keys    : TevMouseState;
 l_l3Pt    : Tl3Point;
//#UC END# *4DDF64120066_4DDF61B503D1_var*
begin
//#UC START# *4DDF64120066_4DDF61B503D1_impl*
 l_l3Pt := TranslatePara2Point(aText);
 l_HotSpot := GetHotSpot(aText, l_l3Pt, False);
 if l_HotSpot <> nil then
 begin
  l3FillChar(l_Keys, SizeOf(l_Keys), 0);
  l_Keys.rKeys := [];
  l_Keys.rInitialPoint := l_l3Pt;
  l_Keys.rPoint := l_l3Pt;
  l_HotSpot.LButtonDown(aText.View, l_Keys, l_Effect);
  if aNeedMouseUp then
   l_HotSpot.LButtonUp(aText.View, l_Keys);
 end; //if l_HotSpot <> nil then
//#UC END# *4DDF64120066_4DDF61B503D1_impl*
end;//_MouseClickOnPoint_.ClickOnPoint
{$IfEnd} // NOT Defined(NoScripts)

{$EndIf MouseClickOnPoint_imp_impl}

{$EndIf MouseClickOnPoint_imp}

