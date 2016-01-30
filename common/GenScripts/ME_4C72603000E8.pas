{$IfNDef f1TagDataProviderPrim_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\f1TagDataProviderPrim.imp.pas"
// Стереотип: "Impurity"

{$Define f1TagDataProviderPrim_imp}

 _f1TagDataProviderPrim_ = class(Tl3CProtoObject)
  {* Базовый источник данных тега }
  protected
   procedure DoBuildSubs(aProp: Tk2CustomProperty;
    const aChecker: If1AtomChecker); virtual;
   procedure DoSetWStyle(const aValue: IStream); virtual;
 end;//_f1TagDataProviderPrim_

{$Else f1TagDataProviderPrim_imp}

{$IfNDef f1TagDataProviderPrim_imp_impl}

{$Define f1TagDataProviderPrim_imp_impl}

procedure _f1TagDataProviderPrim_.DoBuildSubs(aProp: Tk2CustomProperty;
 const aChecker: If1AtomChecker);
//#UC START# *4C722FFF0364_4C72603000E8_var*
//#UC END# *4C722FFF0364_4C72603000E8_var*
begin
//#UC START# *4C722FFF0364_4C72603000E8_impl*
 Assert(false);
//#UC END# *4C722FFF0364_4C72603000E8_impl*
end;//_f1TagDataProviderPrim_.DoBuildSubs

procedure _f1TagDataProviderPrim_.DoSetWStyle(const aValue: IStream);
//#UC START# *4C6EAFC9029B_4C72603000E8_var*
//#UC END# *4C6EAFC9029B_4C72603000E8_var*
begin
//#UC START# *4C6EAFC9029B_4C72603000E8_impl*
 Assert(false);
//#UC END# *4C6EAFC9029B_4C72603000E8_impl*
end;//_f1TagDataProviderPrim_.DoSetWStyle

{$EndIf f1TagDataProviderPrim_imp_impl}

{$EndIf f1TagDataProviderPrim_imp}

