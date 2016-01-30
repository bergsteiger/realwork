{$IfNDef nevParaListViewBounds_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\nevParaListViewBounds.imp.pas"
// Стереотип: "Impurity"

{$Define nevParaListViewBounds_imp}

{$If Defined(evUseVisibleCursors)}
 _nevParaListViewBounds_ = class(_nevParaListViewBounds_Parent_)
  protected
   function GetViewBounds(const aView: InevView;
    const aMap: InevMap): TnevRect; override;
 end;//_nevParaListViewBounds_

{$Else Defined(evUseVisibleCursors)}

_nevParaListViewBounds_ = _nevParaListViewBounds_Parent_;

{$IfEnd} // Defined(evUseVisibleCursors)
{$Else nevParaListViewBounds_imp}

{$IfNDef nevParaListViewBounds_imp_impl}

{$Define nevParaListViewBounds_imp_impl}

{$If Defined(evUseVisibleCursors)}
function _nevParaListViewBounds_.GetViewBounds(const aView: InevView;
 const aMap: InevMap): TnevRect;
//#UC START# *4A5CCD9D028D_4A5CD0CB0038_var*
//#UC END# *4A5CCD9D028D_4A5CD0CB0038_var*
begin
//#UC START# *4A5CCD9D028D_4A5CD0CB0038_impl*
 if not Self.HasInner then
  Result := inherited GetViewBounds(aView, aMap)
 else
  Result := Self.GetInner.ViewBounds(aView, aMap.ReserveMap(Self.GetInner.Obj^))
//#UC END# *4A5CCD9D028D_4A5CD0CB0038_impl*
end;//_nevParaListViewBounds_.GetViewBounds
{$IfEnd} // Defined(evUseVisibleCursors)

{$EndIf nevParaListViewBounds_imp_impl}

{$EndIf nevParaListViewBounds_imp}

