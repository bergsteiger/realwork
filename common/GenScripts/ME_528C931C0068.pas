{$IfNDef ddDocAtomWithAssign_imp}

// Модуль: "w:\common\components\rtl\Garant\dd\ddDocAtomWithAssign.imp.pas"
// Стереотип: "Impurity"

{$Define ddDocAtomWithAssign_imp}

 _ddDocAtomWithAssign_ = class(_ddDocAtomWithAssign_Parent_)
  public
   procedure Assign(const aDocAtomObj: Tl3ProtoObject); virtual;
 end;//_ddDocAtomWithAssign_

{$Else ddDocAtomWithAssign_imp}

{$IfNDef ddDocAtomWithAssign_imp_impl}

{$Define ddDocAtomWithAssign_imp_impl}

procedure _ddDocAtomWithAssign_.Assign(const aDocAtomObj: Tl3ProtoObject);
//#UC START# *528C8C2F02D9_528C931C0068_var*
//#UC END# *528C8C2F02D9_528C931C0068_var*
begin
//#UC START# *528C8C2F02D9_528C931C0068_impl*
//#UC END# *528C8C2F02D9_528C931C0068_impl*
end;//_ddDocAtomWithAssign_.Assign

{$EndIf ddDocAtomWithAssign_imp_impl}

{$EndIf ddDocAtomWithAssign_imp}

