{$IfNDef nevParentPointHolder_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\nevParentPointHolder.imp.pas"
// Стереотип: "Impurity"

{$Define nevParentPointHolder_imp}

{$If Defined(evUseVisibleCursors)}
 _nevParentPointHolder_ = class(_nevParentPointHolder_Parent_)
  {* Реализация точки, имеющей родителя }
  private
   f_ParentPoint: Pointer;
  protected
   procedure SetParentPoint(const aValue: InevBasePoint); virtual;
   procedure pm_SetOuter(const aValue: InevBasePoint);
   function pm_GetParentPoint: InevBasePoint;
 end;//_nevParentPointHolder_

{$Else Defined(evUseVisibleCursors)}

_nevParentPointHolder_ = _nevParentPointHolder_Parent_;

{$IfEnd} // Defined(evUseVisibleCursors)
{$Else nevParentPointHolder_imp}

{$IfNDef nevParentPointHolder_imp_impl}

{$Define nevParentPointHolder_imp_impl}

{$If Defined(evUseVisibleCursors)}
procedure _nevParentPointHolder_.SetParentPoint(const aValue: InevBasePoint);
//#UC START# *49DE1C6903E1_49D269880299_var*
//#UC END# *49DE1C6903E1_49D269880299_var*
begin
//#UC START# *49DE1C6903E1_49D269880299_impl*
 f_ParentPoint := Pointer(aValue);
//#UC END# *49DE1C6903E1_49D269880299_impl*
end;//_nevParentPointHolder_.SetParentPoint

procedure _nevParentPointHolder_.pm_SetOuter(const aValue: InevBasePoint);
//#UC START# *49D266AC032F_49D269880299set_var*
//#UC END# *49D266AC032F_49D269880299set_var*
begin
//#UC START# *49D266AC032F_49D269880299set_impl*
 if (aValue = nil) then
  SetParentPoint(nil)
 else
 begin
  if (f_ParentPoint <> Pointer(aValue)) then
   SetParentPoint(aValue);
 end;//aValue = nil
//#UC END# *49D266AC032F_49D269880299set_impl*
end;//_nevParentPointHolder_.pm_SetOuter

function _nevParentPointHolder_.pm_GetParentPoint: InevBasePoint;
//#UC START# *49D2687002C7_49D269880299get_var*
//#UC END# *49D2687002C7_49D269880299get_var*
begin
//#UC START# *49D2687002C7_49D269880299get_impl*
 Result := InevBasePoint(f_ParentPoint);
//#UC END# *49D2687002C7_49D269880299get_impl*
end;//_nevParentPointHolder_.pm_GetParentPoint
{$IfEnd} // Defined(evUseVisibleCursors)

{$EndIf nevParentPointHolder_imp_impl}

{$EndIf nevParentPointHolder_imp}

