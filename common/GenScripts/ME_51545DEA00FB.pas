{$IfNDef StackPrim_imp}

// Модуль: "w:\common\components\SandBox\StackPrim.imp.pas"
// Стереотип: "Impurity"

{$Define StackPrim_imp}

type
 // _ItemType_

 ItemsHolder = array of _ItemType_;

 _StackPrim_ = class(_StackPrim_Parent_)
  private
   f_Items: ItemsHolder;
  public
   procedure Push(const anItem: _ItemType_);
   function Pop: _ItemType_;
 end;//_StackPrim_

{$Else StackPrim_imp}

{$IfNDef StackPrim_imp_impl}

{$Define StackPrim_imp_impl}

procedure _StackPrim_.Push(const anItem: _ItemType_);
//#UC START# *51545E8E032C_51545DEA00FB_var*
var
 l_L : Integer;
//#UC END# *51545E8E032C_51545DEA00FB_var*
begin
//#UC START# *51545E8E032C_51545DEA00FB_impl*
 l_L :=  Length(f_Items);
 SetLength(f_Items, l_L + 1);
 f_Items[l_L] := anItem;
//#UC END# *51545E8E032C_51545DEA00FB_impl*
end;//_StackPrim_.Push

function _StackPrim_.Pop: _ItemType_;
//#UC START# *51545EB100A8_51545DEA00FB_var*
var
 l_L : Integer;
//#UC END# *51545EB100A8_51545DEA00FB_var*
begin
//#UC START# *51545EB100A8_51545DEA00FB_impl*
 l_L :=  Length(f_Items) - 1;
 Result := f_Items[l_L];
 SetLength(f_Items, l_L);
//#UC END# *51545EB100A8_51545DEA00FB_impl*
end;//_StackPrim_.Pop

{$EndIf StackPrim_imp_impl}

{$EndIf StackPrim_imp}

