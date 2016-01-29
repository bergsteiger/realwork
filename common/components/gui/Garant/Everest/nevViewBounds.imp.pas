{$IfNDef nevViewBounds_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/nevViewBounds.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::Cursors::nevViewBounds
//
// Границы отображаемого объекта
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nevViewBounds_imp}
{$If defined(evUseVisibleCursors)}
 _nevViewBounds_ = {mixin} class(_nevViewBounds_Parent_)
  {* Границы отображаемого объекта }
 public
 // realized methods
   function ViewBounds(const aView: InevView;
    const aMap: InevMap): TnevRect;
     {* Ограничивающий точку "прямоугольник". Для текстовых параграфов реализация не самая быстрая. Если потребуется активное использование, то реализацию стоит пересмотреть }
 protected
 // protected methods
   function GetViewBounds(const aView: InevView;
    const aMap: InevMap): TnevRect; virtual;
 end;//_nevViewBounds_
{$Else}

 _nevViewBounds_ = _nevViewBounds_Parent_;

{$IfEnd} //evUseVisibleCursors

{$Else nevViewBounds_imp}

{$If defined(evUseVisibleCursors)}

// start class _nevViewBounds_

function _nevViewBounds_.GetViewBounds(const aView: InevView;
  const aMap: InevMap): TnevRect;
//#UC START# *4A5CCD9D028D_4A5CCD5F00C1_var*
//#UC END# *4A5CCD9D028D_4A5CCD5F00C1_var*
begin
//#UC START# *4A5CCD9D028D_4A5CCD5F00C1_impl*
 Result := aMap.Bounds;
//#UC END# *4A5CCD9D028D_4A5CCD5F00C1_impl*
end;//_nevViewBounds_.GetViewBounds

function _nevViewBounds_.ViewBounds(const aView: InevView;
  const aMap: InevMap): TnevRect;
//#UC START# *4A5CCBFC00B3_4A5CCD5F00C1_var*
//#UC END# *4A5CCBFC00B3_4A5CCD5F00C1_var*
begin
//#UC START# *4A5CCBFC00B3_4A5CCD5F00C1_impl*
 if aMap.rVisible then
  Result := GetViewBounds(aView, aMap)
 else
  Result := nevRect0;
//#UC END# *4A5CCBFC00B3_4A5CCD5F00C1_impl*
end;//_nevViewBounds_.ViewBounds

{$IfEnd} //evUseVisibleCursors

{$EndIf nevViewBounds_imp}
