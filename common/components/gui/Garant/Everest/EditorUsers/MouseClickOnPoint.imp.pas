{$IfNDef MouseClickOnPoint_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest$EditorUsers"
// Модуль: "w:/common/components/gui/Garant/Everest/EditorUsers/MouseClickOnPoint.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest$EditorUsers::MixIns::MouseClickOnPoint
//
// Щелчок мышью на точке в редакторе
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define MouseClickOnPoint_imp}
{$If not defined(NoScripts)}
 _Para2Point_Parent_ = _MouseClickOnPoint_Parent_;
 {$Include ..\EditorUsers\Para2Point.imp.pas}
 _HotSpotTools_Parent_ = _Para2Point_;
 {$Include ..\EditorUsers\HotSpotTools.imp.pas}
 _MouseClickOnPoint_ = {mixin} class(_HotSpotTools_)
  {* Щелчок мышью на точке в редакторе }
 protected
 // protected methods
   procedure ClickOnPoint(aText: TevCustomEditorWindow;
    aNeedMouseUp: Boolean); virtual;
 end;//_MouseClickOnPoint_
{$Else}

 _Para2Point_Parent_ = _MouseClickOnPoint_Parent_;
 {$Include ..\EditorUsers\Para2Point.imp.pas}
 _HotSpotTools_Parent_ = _Para2Point_;
 {$Include ..\EditorUsers\HotSpotTools.imp.pas}
 _MouseClickOnPoint_ = _HotSpotTools_;

{$IfEnd} //not NoScripts

{$Else MouseClickOnPoint_imp}

{$If not defined(NoScripts)}

{$Include ..\EditorUsers\Para2Point.imp.pas}

{$Include ..\EditorUsers\HotSpotTools.imp.pas}

// start class _MouseClickOnPoint_

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

{$IfEnd} //not NoScripts

{$EndIf MouseClickOnPoint_imp}
