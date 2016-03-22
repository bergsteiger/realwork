{$IfNDef nevDiff_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\nevDiff.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "nevDiff" MUID: (49DF54E500B3)
// Имя типа: "_nevDiff_"

{$Define nevDiff_imp}

{$If Defined(evUseVisibleCursors)}
 _nevDiff_ = class(_nevDiff_Parent_)
  protected
   function DoDiff(const aView: InevView;
    const aPoint: InevBasePoint;
    aMap: TnevFormatInfoPrim): Integer; virtual;
   function DoPartiallyVisible(const aView: InevView;
    const aPoint: InevBasePoint;
    aMap: TnevFormatInfoPrim): Boolean; virtual;
  public
   function Diff(const aView: InevView;
    const aPoint: InevBasePoint;
    aMap: TnevFormatInfoPrim): Integer;
    {* сравнивает курсор с "якорем" по вертикали. }
   function PartiallyVisible(const aView: InevView;
    const aPoint: InevBasePoint;
    const aMap: TnevFormatInfoPrim): Boolean;
    {* Определяет может ли точка "частично видимой" относительно другой точки (aPoint). Сделано для определения видимости начальной ячейки относительно якоря. }
 end;//_nevDiff_

{$Else Defined(evUseVisibleCursors)}

_nevDiff_ = _nevDiff_Parent_;

{$IfEnd} // Defined(evUseVisibleCursors)
{$Else nevDiff_imp}

{$IfNDef nevDiff_imp_impl}

{$Define nevDiff_imp_impl}

{$If Defined(evUseVisibleCursors)}
function _nevDiff_.DoDiff(const aView: InevView;
 const aPoint: InevBasePoint;
 aMap: TnevFormatInfoPrim): Integer;
//#UC START# *4AA785540310_49DF54E500B3_var*
var
 l_Inn   : InevBasePoint;
//#UC END# *4AA785540310_49DF54E500B3_var*
begin
//#UC START# *4AA785540310_49DF54E500B3_impl*
 if (aMap = nil) then
  if not ParaX.AsObject.Owner.IsValid then
  // - параграф удалили
  begin
   Result := nev_MinusDiff;
   Exit;
  end;//not Obj.Owner.IsValid
 Assert(aMap <> nil);
 if (aPoint = nil) then
  Result := nev_PlusDiff
 else
 begin
  if ParaX.AsObject.IsSame(aPoint.Obj^.AsObject) then
  begin
   if ParaX.IsVertical then
    Result := _Instance_R_(Self).VertPosition(aView, aMap) - aPoint.VertPosition(aView, aMap)
   else
    Result := 0;
   if (Result = 0) then
   begin
    l_Inn := _Instance_R_(Self).pm_GetInner;
    if not aPoint.HasInner or not aPoint.Inner.AsObject.IsValid then
    begin
     if (l_Inn <> nil) then
      Result := nev_PlusDiff;
    end//aPoint.Inner = nil
    else
    if (l_Inn <> nil) then
     Result := l_Inn.Diff(aView, aPoint.Inner, aMap.InfoForChild(l_Inn.Obj^))
    else
     Result := nev_MinusDiff;
   end;//Result = 0
  end//ParaX.IsSame(aPoint.Obj)
  else
   Result := 0;
 end;//aPoint = nil
//#UC END# *4AA785540310_49DF54E500B3_impl*
end;//_nevDiff_.DoDiff

function _nevDiff_.DoPartiallyVisible(const aView: InevView;
 const aPoint: InevBasePoint;
 aMap: TnevFormatInfoPrim): Boolean;
//#UC START# *4BBB10FB015B_49DF54E500B3_var*
//#UC END# *4BBB10FB015B_49DF54E500B3_var*
begin
//#UC START# *4BBB10FB015B_49DF54E500B3_impl*
 Result := False;
//#UC END# *4BBB10FB015B_49DF54E500B3_impl*
end;//_nevDiff_.DoPartiallyVisible

function _nevDiff_.Diff(const aView: InevView;
 const aPoint: InevBasePoint;
 aMap: TnevFormatInfoPrim): Integer;
 {* сравнивает курсор с "якорем" по вертикали. }
//#UC START# *49DF51870234_49DF54E500B3_var*
//#UC END# *49DF51870234_49DF54E500B3_var*
begin
//#UC START# *49DF51870234_49DF54E500B3_impl*
 Result := DoDiff(aView, aPoint, aMap);
//#UC END# *49DF51870234_49DF54E500B3_impl*
end;//_nevDiff_.Diff

function _nevDiff_.PartiallyVisible(const aView: InevView;
 const aPoint: InevBasePoint;
 const aMap: TnevFormatInfoPrim): Boolean;
 {* Определяет может ли точка "частично видимой" относительно другой точки (aPoint). Сделано для определения видимости начальной ячейки относительно якоря. }
//#UC START# *4BBB0DDD026D_49DF54E500B3_var*
//#UC END# *4BBB0DDD026D_49DF54E500B3_var*
begin
//#UC START# *4BBB0DDD026D_49DF54E500B3_impl*
 Result := DoPartiallyVisible(aView, aPoint, aMap);
//#UC END# *4BBB0DDD026D_49DF54E500B3_impl*
end;//_nevDiff_.PartiallyVisible
{$IfEnd} // Defined(evUseVisibleCursors)

{$EndIf nevDiff_imp_impl}

{$EndIf nevDiff_imp}

