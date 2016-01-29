{$IfNDef l3LockedChange_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3LockedChange.imp.pas"
// Начат: 24.11.2008 17:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::L3::Стандартные примеси::l3LockedChange
//
// Нотификатор об изменениях со счётчиком ссылок изменений
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define l3LockedChange_imp}
 _l3LockedChangePrim_Parent_ = _l3LockedChange_Parent_;
 {$Include ..\L3\l3LockedChangePrim.imp.pas}
 _l3LockedChange_ = {mixin} class(_l3LockedChangePrim_)
  {* Нотификатор об изменениях со счётчиком ссылок изменений }
 end;//_l3LockedChange_

{$Else l3LockedChange_imp}

{$Include ..\L3\l3LockedChangePrim.imp.pas}


{$EndIf l3LockedChange_imp}
