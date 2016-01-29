{$IfNDef l3AtomicListPrim_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3AtomicListPrim.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3AtomicListPrim
//
// Список атомарных элементов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define l3AtomicListPrim_imp}
 {$Define l3Items_IsAtomic}
 { Определяет, что элементы списка - атомарные }

 _l3UnrefcountedList_Parent_ = _l3AtomicListPrim_Parent_;
 {$Include ..\L3\l3UnrefcountedList.imp.pas}
 _l3AtomicListPrim_ = {mixin} class(_l3UnrefcountedList_)
  {* Список атомарных элементов }
 end;//_l3AtomicListPrim_

{$Else l3AtomicListPrim_imp}


{$Include ..\L3\l3UnrefcountedList.imp.pas}


{$EndIf l3AtomicListPrim_imp}
