{$IfNDef nevTextParaViewBounds_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\nevTextParaViewBounds.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "nevTextParaViewBounds" MUID: (4A5CD38B00C6)
// Имя типа: "_nevTextParaViewBounds_"

{$Define nevTextParaViewBounds_imp}

{$If Defined(evUseVisibleCursors)}
type
 TnevLineCoord = record
  {* Координаты строки }
  rLine: Integer;
   {* Строка }
  rOfs: Integer;
   {* Смещение в строке }
 end;//TnevLineCoord

 _nevTextParaViewBounds_ = class(_nevTextParaViewBounds_Parent_)
  protected
   function GetViewBounds(const aView: InevView;
    const aMap: InevMap): TnevRect; override;
 end;//_nevTextParaViewBounds_

{$Else Defined(evUseVisibleCursors)}

_nevTextParaViewBounds_ = _nevTextParaViewBounds_Parent_;

{$IfEnd} // Defined(evUseVisibleCursors)
{$Else nevTextParaViewBounds_imp}

{$IfNDef nevTextParaViewBounds_imp_impl}

{$Define nevTextParaViewBounds_imp_impl}

{$If Defined(evUseVisibleCursors)}
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
{$IfEnd} // Defined(evUseVisibleCursors)

{$EndIf nevTextParaViewBounds_imp_impl}

{$EndIf nevTextParaViewBounds_imp}

