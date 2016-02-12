{$IfNDef ColumnResizeByMouse_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\EditorUsers\ColumnResizeByMouse.imp.pas"
// Стереотип: "Impurity"

{$Define ColumnResizeByMouse_imp}

{$If NOT Defined(NoScripts)}
 _Para2Point_Parent_ = _ColumnResizeByMouse_Parent_;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\Para2Point.imp.pas}
 _HotSpotTools_Parent_ = _Para2Point_;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\HotSpotTools.imp.pas}
 _ColumnResizeByMouse_ = class(_HotSpotTools_)
  protected
   procedure SelectColumn(aText: TevCustomEditorWindow);
   function GetKeys: TShiftState; virtual;
   procedure GetColumnAndRow(var aCol: Integer;
    var aRow: Integer); virtual;
   function GetDelta: Integer; virtual;
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
    {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
   function GetPoint(const aMap: InevMap): Tl3Point; override;
    {* Возвращает точку, на которую нужно спозиционироваться. }
 end;//_ColumnResizeByMouse_

{$Else NOT Defined(NoScripts)}

_Para2Point_Parent_ = _ColumnResizeByMouse_Parent_;
{$Include w:\common\components\gui\Garant\Everest\EditorUsers\Para2Point.imp.pas}
_HotSpotTools_Parent_ = _Para2Point_;
{$Include w:\common\components\gui\Garant\Everest\EditorUsers\HotSpotTools.imp.pas}
_ColumnResizeByMouse_ = _HotSpotTools_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else ColumnResizeByMouse_imp}

{$IfNDef ColumnResizeByMouse_imp_impl}

{$Define ColumnResizeByMouse_imp_impl}

{$If NOT Defined(NoScripts)}
{$Include w:\common\components\gui\Garant\Everest\EditorUsers\Para2Point.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\HotSpotTools.imp.pas}

procedure _ColumnResizeByMouse_.SelectColumn(aText: TevCustomEditorWindow);
//#UC START# *4E32C9D70275_4E32C9540390_var*
var
 l_SS      : TShiftState;
 l_Keys    : TevMouseState;
 l_l3Pt    : Tl3Point;
 l_Delta   : Integer;
 l_Effect  : TevMouseEffect;
 l_HotSpot : IevHotSpot;
//#UC END# *4E32C9D70275_4E32C9540390_var*
begin
//#UC START# *4E32C9D70275_4E32C9540390_impl*
 l_l3Pt := TranslatePara2Point(aText);
 l_HotSpot := GetHotSpot(aText, l_l3Pt, True);
 l_SS := GetKeys;
 l_Delta := GetDelta;
 if l_HotSpot = nil then
  Assert(False, 'Не нашли хотспот!')
 else
 begin
  l_Effect.rNeedAsyncLoop := True;
  l3FillChar(l_Keys, SizeOf(l_Keys), 0);
  l_Keys.rKeys := l_SS;
  l_Keys.rInitialPoint := l_l3Pt;
  l_Keys.rPoint := l_l3Pt;
  l_Keys.rInMove := true;
  l_Keys.rPoint := l3Point(l_l3Pt.X + l_Delta, l_l3Pt.Y);
  l_HotSpot.LButtonDown(aText.View, l_Keys, l_Effect);
  l_HotSpot.MouseMove(aText.View, l_Keys);
  l_HotSpot.LButtonUp(aText.View, l_Keys);
 end;// if l_HotSpotTester.GetAdvancedHotSpot(aText.View,
//#UC END# *4E32C9D70275_4E32C9540390_impl*
end;//_ColumnResizeByMouse_.SelectColumn

function _ColumnResizeByMouse_.GetKeys: TShiftState;
//#UC START# *4E32CA120170_4E32C9540390_var*
//#UC END# *4E32CA120170_4E32C9540390_var*
begin
//#UC START# *4E32CA120170_4E32C9540390_impl*
 Result := [];
//#UC END# *4E32CA120170_4E32C9540390_impl*
end;//_ColumnResizeByMouse_.GetKeys

procedure _ColumnResizeByMouse_.GetColumnAndRow(var aCol: Integer;
 var aRow: Integer);
//#UC START# *4E32CA35008A_4E32C9540390_var*
//#UC END# *4E32CA35008A_4E32C9540390_var*
begin
//#UC START# *4E32CA35008A_4E32C9540390_impl*
 aCol := 0;
 aRow := 0;
//#UC END# *4E32CA35008A_4E32C9540390_impl*
end;//_ColumnResizeByMouse_.GetColumnAndRow

function _ColumnResizeByMouse_.GetDelta: Integer;
//#UC START# *4E32CA5E0115_4E32C9540390_var*
//#UC END# *4E32CA5E0115_4E32C9540390_var*
begin
//#UC START# *4E32CA5E0115_4E32C9540390_impl*
 Result := 0;
//#UC END# *4E32CA5E0115_4E32C9540390_impl*
end;//_ColumnResizeByMouse_.GetDelta

function _ColumnResizeByMouse_.GetInnerPara(const aView: InevInputView;
 const aDocument: InevPara): InevPara;
 {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
//#UC START# *4BF4E6A00093_4E32C9540390_var*
var
 l_Col : Integer;
 l_Row : Integer;
//#UC END# *4BF4E6A00093_4E32C9540390_var*
begin
//#UC START# *4BF4E6A00093_4E32C9540390_impl*
 GetColumnAndRow(l_Col, l_Row);
 Result := aDocument.AsList.Para[0].AsList.Para[l_Row].AsList.Para[l_Col];
//#UC END# *4BF4E6A00093_4E32C9540390_impl*
end;//_ColumnResizeByMouse_.GetInnerPara

function _ColumnResizeByMouse_.GetPoint(const aMap: InevMap): Tl3Point;
 {* Возвращает точку, на которую нужно спозиционироваться. }
//#UC START# *4C3C927B027E_4E32C9540390_var*
//#UC END# *4C3C927B027E_4E32C9540390_var*
begin
//#UC START# *4C3C927B027E_4E32C9540390_impl*
 Result := l3Point(aMap.Bounds.Right, aMap.Outer.Bounds.Top + 7 * evEpsilon);
//#UC END# *4C3C927B027E_4E32C9540390_impl*
end;//_ColumnResizeByMouse_.GetPoint
{$IfEnd} // NOT Defined(NoScripts)

{$EndIf ColumnResizeByMouse_imp_impl}

{$EndIf ColumnResizeByMouse_imp}

