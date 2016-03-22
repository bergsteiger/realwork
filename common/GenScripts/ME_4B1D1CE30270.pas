{$IfNDef nevBreakParaAnchorModify_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\nevBreakParaAnchorModify.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "nevBreakParaAnchorModify" MUID: (4B1D1CE30270)
// Имя типа: "_nevBreakParaAnchorModify_"

{$Define nevBreakParaAnchorModify_imp}

{$If Defined(evUseVisibleCursors)}
 _nevBreakParaAnchorModify_ = class(_nevBreakParaAnchorModify_Parent_)
  protected
   procedure DoBottom(const aView: InevView); override;
   function DoIncLinePrim(const aView: InevView;
    var theLine: Integer;
    aSmall: Boolean): Integer; override;
 end;//_nevBreakParaAnchorModify_

{$Else Defined(evUseVisibleCursors)}

_nevBreakParaAnchorModify_ = _nevBreakParaAnchorModify_Parent_;

{$IfEnd} // Defined(evUseVisibleCursors)
{$Else nevBreakParaAnchorModify_imp}

{$IfNDef nevBreakParaAnchorModify_imp_impl}

{$Define nevBreakParaAnchorModify_imp_impl}

{$If Defined(evUseVisibleCursors)}
procedure _nevBreakParaAnchorModify_.DoBottom(const aView: InevView);
//#UC START# *4B1CFD7B0332_4B1D1CE30270_var*
//#UC END# *4B1CFD7B0332_4B1D1CE30270_var*
begin
//#UC START# *4B1CFD7B0332_4B1D1CE30270_impl*
//#UC END# *4B1CFD7B0332_4B1D1CE30270_impl*
end;//_nevBreakParaAnchorModify_.DoBottom

function _nevBreakParaAnchorModify_.DoIncLinePrim(const aView: InevView;
 var theLine: Integer;
 aSmall: Boolean): Integer;
//#UC START# *4B1CFD9401A2_4B1D1CE30270_var*
//#UC END# *4B1CFD9401A2_4B1D1CE30270_var*
begin
//#UC START# *4B1CFD9401A2_4B1D1CE30270_impl*
 Result := 0;
//#UC END# *4B1CFD9401A2_4B1D1CE30270_impl*
end;//_nevBreakParaAnchorModify_.DoIncLinePrim
{$IfEnd} // Defined(evUseVisibleCursors)

{$EndIf nevBreakParaAnchorModify_imp_impl}

{$EndIf nevBreakParaAnchorModify_imp}

