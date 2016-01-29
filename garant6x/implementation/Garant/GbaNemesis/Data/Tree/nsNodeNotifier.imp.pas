{$IfNDef nsNodeNotifier_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Tree/nsNodeNotifier.imp.pas"
// Начат: 2005/11/22 16:19:33
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Базовые определения предметной области::LegalDomain::Data::Tree::nsNodeNotifier
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nsNodeNotifier_imp}
 _nsNodeNotifierImplementation_Parent_ = _nsNodeNotifier_Parent_;
 {$Include ..\Tree\nsNodeNotifierImplementation.imp.pas}
 _nsNodeNotifier_ = {mixin} class(_nsNodeNotifierImplementation_)
 protected
 // protected methods
   procedure Changing;
   procedure Changed;
 end;//_nsNodeNotifier_

{$Else nsNodeNotifier_imp}

{$Include ..\Tree\nsNodeNotifierImplementation.imp.pas}

// start class _nsNodeNotifier_

procedure _nsNodeNotifier_.Changing;
//#UC START# *48FDB28502C3_48FDB24300E8_var*
//#UC END# *48FDB28502C3_48FDB24300E8_var*
begin
//#UC START# *48FDB28502C3_48FDB24300E8_impl*
 OldChanging;
//#UC END# *48FDB28502C3_48FDB24300E8_impl*
end;//_nsNodeNotifier_.Changing

procedure _nsNodeNotifier_.Changed;
//#UC START# *48FDB29002D2_48FDB24300E8_var*
//#UC END# *48FDB29002D2_48FDB24300E8_var*
begin
//#UC START# *48FDB29002D2_48FDB24300E8_impl*
 OldChanged;
//#UC END# *48FDB29002D2_48FDB24300E8_impl*
end;//_nsNodeNotifier_.Changed

{$EndIf nsNodeNotifier_imp}
