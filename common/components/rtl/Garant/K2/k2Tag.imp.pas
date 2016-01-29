{$IfNDef k2Tag_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2Tag.imp.pas"
// Начат: 20.04.2005 19:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::K2::k2CoreObjects::k2Tag
//
// Реализация тега.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define k2Tag_imp}
 _k2TagPrim_Parent_ = _k2Tag_Parent_;
 {$Include ..\K2\k2TagPrim.imp.pas}
 _k2Tag_ = {mixin} class(_k2TagPrim_)
  {* Реализация тега. }
 end;//_k2Tag_

{$Else k2Tag_imp}


{$Include ..\K2\k2TagPrim.imp.pas}


{$EndIf k2Tag_imp}
