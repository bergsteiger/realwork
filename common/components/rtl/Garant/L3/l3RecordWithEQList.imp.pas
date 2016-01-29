{$IfNDef l3RecordWithEQList_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3RecordWithEQList.imp.pas"
// Начат: 11.12.2009 15:40
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3RecordWithEQList
//
// Список записей с операцией EQ
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define l3RecordWithEQList_imp}
 _l3RecordListPrim_Parent_ = _l3RecordWithEQList_Parent_;
 {$Include ..\L3\l3RecordListPrim.imp.pas}
 _l3RecordWithEQList_ = {mixin} class(_l3RecordListPrim_)
  {* Список записей с операцией EQ }
 end;//_l3RecordWithEQList_

{$Else l3RecordWithEQList_imp}

// start class _l3RecordWithEQList_

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_4B223DB5024B_var*
//#UC END# *47B07CF403D0_4B223DB5024B_var*
begin
//#UC START# *47B07CF403D0_4B223DB5024B_impl*
 Result := A.EQ(B);
//#UC END# *47B07CF403D0_4B223DB5024B_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic


{$Include ..\L3\l3RecordListPrim.imp.pas}


{$EndIf l3RecordWithEQList_imp}
