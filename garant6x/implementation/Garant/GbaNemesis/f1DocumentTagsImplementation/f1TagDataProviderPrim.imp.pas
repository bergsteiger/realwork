{$IfNDef f1TagDataProviderPrim_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "f1DocumentTagsImplementation"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/f1TagDataProviderPrim.imp.pas"
// Начат: 23.08.2010 15:49
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Базовые определения предметной области::LegalDomain::f1DocumentTagsImplementation::TagDataProviders::f1TagDataProviderPrim
//
// Базовый источник данных тега
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define f1TagDataProviderPrim_imp}
 _f1TagDataProviderPrim_ = {mixin} class(Tl3CProtoObject)
  {* Базовый источник данных тега }
 protected
 // protected methods
   procedure DoBuildSubs(aProp: Tk2CustomProperty;
    const aChecker: If1AtomChecker); virtual;
   procedure DoSetWStyle(const aValue: IStream); virtual;
 end;//_f1TagDataProviderPrim_

{$Else f1TagDataProviderPrim_imp}

// start class _f1TagDataProviderPrim_

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

{$EndIf f1TagDataProviderPrim_imp}
