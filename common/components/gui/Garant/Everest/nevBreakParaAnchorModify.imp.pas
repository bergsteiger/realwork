{$IfNDef nevBreakParaAnchorModify_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/nevBreakParaAnchorModify.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::Cursors::nevBreakParaAnchorModify
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nevBreakParaAnchorModify_imp}
{$If defined(evUseVisibleCursors)}
 _nevBreakParaAnchorModify_ = {mixin} class(_nevBreakParaAnchorModify_Parent_)
 protected
 // realized methods
   procedure DoBottom(const aView: InevView); override;
   function DoIncLinePrim(const aView: InevView;
    var theLine: Integer;
    aSmall: Boolean): Integer; override;
 end;//_nevBreakParaAnchorModify_
{$Else}

 _nevBreakParaAnchorModify_ = _nevBreakParaAnchorModify_Parent_;

{$IfEnd} //evUseVisibleCursors

{$Else nevBreakParaAnchorModify_imp}

{$If defined(evUseVisibleCursors)}

// start class _nevBreakParaAnchorModify_

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

{$IfEnd} //evUseVisibleCursors

{$EndIf nevBreakParaAnchorModify_imp}
