{$IfNDef MouseClickSupport_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\EditorUsers\MouseClickSupport.imp.pas"
// Стереотип: "Impurity"

{$Define MouseClickSupport_imp}

{$If NOT Defined(NoScripts)}
 _MouseClickSupport_ = class(_MouseClickSupport_Parent_)
  {* Поддержка щелканья мышью на компоненте }
  protected
   function GetKeyData: Integer; virtual;
   procedure MakeClick(aControl: TWinControl);
   procedure GetDeltaXY(var X: Integer;
    var Y: Integer); virtual;
    {* Получить кординаты "щелчка" относительно левого верхнего угла контрола. }
 end;//_MouseClickSupport_

{$Else NOT Defined(NoScripts)}

_MouseClickSupport_ = _MouseClickSupport_Parent_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else MouseClickSupport_imp}

{$IfNDef MouseClickSupport_imp_impl}

{$Define MouseClickSupport_imp_impl}

{$If NOT Defined(NoScripts)}
function _MouseClickSupport_.GetKeyData: Integer;
//#UC START# *4EF42D190011_4D6E5ECF0236_var*
//#UC END# *4EF42D190011_4D6E5ECF0236_var*
begin
//#UC START# *4EF42D190011_4D6E5ECF0236_impl*
 Result := 0;
//#UC END# *4EF42D190011_4D6E5ECF0236_impl*
end;//_MouseClickSupport_.GetKeyData

procedure _MouseClickSupport_.MakeClick(aControl: TWinControl);
//#UC START# *4D6E5F1900B1_4D6E5ECF0236_var*
var
 l_X        : Integer;
 l_Y        : Integer;
 l_Pos      : TPoint;
 l_MousePos : TSmallPoint;
//#UC END# *4D6E5F1900B1_4D6E5ECF0236_var*
begin
//#UC START# *4D6E5F1900B1_4D6E5ECF0236_impl*
 GetDeltaXY(l_X, l_Y);
 l_Pos := Point(aControl.BoundsRect.Left + l_X, aControl.BoundsRect.Top + l_Y);
 l_MousePos := PointToSmallPoint(l_Pos);
 SendMessage(aControl.Handle, WM_LBUTTONDOWN, 0, Longint(l_MousePos));
 SendMessage(aControl.Handle, WM_LBUTTONUP, 0, Longint(l_MousePos));
//#UC END# *4D6E5F1900B1_4D6E5ECF0236_impl*
end;//_MouseClickSupport_.MakeClick

procedure _MouseClickSupport_.GetDeltaXY(var X: Integer;
 var Y: Integer);
 {* Получить кординаты "щелчка" относительно левого верхнего угла контрола. }
//#UC START# *4D6E5F340304_4D6E5ECF0236_var*
//#UC END# *4D6E5F340304_4D6E5ECF0236_var*
begin
//#UC START# *4D6E5F340304_4D6E5ECF0236_impl*
 X := 0;
 Y := 0;
//#UC END# *4D6E5F340304_4D6E5ECF0236_impl*
end;//_MouseClickSupport_.GetDeltaXY
{$IfEnd} // NOT Defined(NoScripts)

{$EndIf MouseClickSupport_imp_impl}

{$EndIf MouseClickSupport_imp}

