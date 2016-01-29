{$IfNDef nevTextParaViewBounds_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/nevTextParaViewBounds.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::Cursors::nevTextParaViewBounds
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nevTextParaViewBounds_imp}
{$If defined(evUseVisibleCursors)}
 TnevLineCoord = record
  {* Координаты строки }
   rLine : Integer; // Строка
   rOfs : Integer; // Смещение в строке
 end;//TnevLineCoord

 _nevTextParaViewBounds_ = {mixin} class(_nevTextParaViewBounds_Parent_)
 protected
 // overridden protected methods
   function GetViewBounds(const aView: InevView;
    const aMap: InevMap): TnevRect; override;
 end;//_nevTextParaViewBounds_
{$Else}

 _nevTextParaViewBounds_ = _nevTextParaViewBounds_Parent_;

{$IfEnd} //evUseVisibleCursors

{$Else nevTextParaViewBounds_imp}

{$If defined(evUseVisibleCursors)}

// start class _nevTextParaViewBounds_

function _nevTextParaViewBounds_.GetViewBounds(const aView: InevView;
  const aMap: InevMap): TnevRect;
//#UC START# *4A5CCD9D028D_4A5CD38B00C6_var*
var
 l_LC : TnevLineCoord;
//#UC END# *4A5CCD9D028D_4A5CD38B00C6_var*
begin
//#UC START# *4A5CCD9D028D_4A5CD38B00C6_impl*
 l_LC := GetLC(Self, aMap.FI);
 Result := evTextParaViewBounds(aMap,
                                ParaX.Text,
                                ParaX,
                                l_LC.rOfs,
                                l_LC.rLine);
//#UC END# *4A5CCD9D028D_4A5CD38B00C6_impl*
end;//_nevTextParaViewBounds_.GetViewBounds

{$IfEnd} //evUseVisibleCursors

{$EndIf nevTextParaViewBounds_imp}
