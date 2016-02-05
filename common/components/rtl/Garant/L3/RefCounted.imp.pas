{$IfNDef RefCounted_imp}

// ћодуль: "w:\common\components\rtl\Garant\L3\RefCounted.imp.pas"
// —тереотип: "Impurity"

{$Define RefCounted_imp}

 _RefCountedPrim_Parent_ = _RefCounted_Parent_;
 {$Include RefCountedPrim.imp.pas}
 _RefCounted_ = class(_RefCountedPrim_)
  {* ¬ этом классе собираем методы, которые запрещено перекрывать и вызывать напр€мую }
  public
   destructor destroy;
    {* Ёто чтобы не было соблазна перекрывать destroy. }
   class function NewInstance: TObject;
   procedure FreeInstance;
   procedure AfterConstruction;
   procedure BeforeDestruction;
 end;//_RefCounted_

{$Else RefCounted_imp}

{$IfNDef RefCounted_imp_impl}

{$Define RefCounted_imp_impl}

{$Include RefCountedPrim.imp.pas}

destructor _RefCounted_.destroy;
 {* Ёто чтобы не было соблазна перекрывать destroy. }
//#UC START# *5161409E01B6_51614065019A_var*
//#UC END# *5161409E01B6_51614065019A_var*
begin
//#UC START# *5161409E01B6_51614065019A_impl*
 assert(false, 'ѕо идее мы попасть сюда не должны');
 inherited;
//#UC END# *5161409E01B6_51614065019A_impl*
end;//_RefCounted_.destroy

class function _RefCounted_.NewInstance: TObject;
//#UC START# *516D4E5A000A_51614065019A_var*
//#UC END# *516D4E5A000A_51614065019A_var*
begin
//#UC START# *516D4E5A000A_51614065019A_impl*
 Result := nil;
 assert(false);
//#UC END# *516D4E5A000A_51614065019A_impl*
end;//_RefCounted_.NewInstance

procedure _RefCounted_.FreeInstance;
//#UC START# *516D4E780193_51614065019A_var*
//#UC END# *516D4E780193_51614065019A_var*
begin
//#UC START# *516D4E780193_51614065019A_impl*
 assert(false);
//#UC END# *516D4E780193_51614065019A_impl*
end;//_RefCounted_.FreeInstance

procedure _RefCounted_.AfterConstruction;
//#UC START# *516D4E9403A0_51614065019A_var*
//#UC END# *516D4E9403A0_51614065019A_var*
begin
//#UC START# *516D4E9403A0_51614065019A_impl*
 assert(false);
//#UC END# *516D4E9403A0_51614065019A_impl*
end;//_RefCounted_.AfterConstruction

procedure _RefCounted_.BeforeDestruction;
//#UC START# *516D4EAD0095_51614065019A_var*
//#UC END# *516D4EAD0095_51614065019A_var*
begin
//#UC START# *516D4EAD0095_51614065019A_impl*
 assert(false);
//#UC END# *516D4EAD0095_51614065019A_impl*
end;//_RefCounted_.BeforeDestruction

{$EndIf RefCounted_imp_impl}

{$EndIf RefCounted_imp}

