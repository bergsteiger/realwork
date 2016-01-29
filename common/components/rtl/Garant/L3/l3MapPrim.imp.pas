{$IfNDef l3MapPrim_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/l3MapPrim.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::L3::Containers::l3MapPrim
//
// Словарь (ключ-значение)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define l3MapPrim_imp}
 Tl3KeyValuePair = {$IfDef XE4}record{$Else}object{$EndIf}
  {* Пара ключ-значение }
 public
   rKey : _KeyType_;
   rValue : _ValueType_;
 end;//Tl3KeyValuePair

 PValueType = ^_ValueType_;

 _ItemType_ = Tl3KeyValuePair;
 _l3RecordListPrim_Parent_ = _l3MapPrim_Parent_;
 {$Include ..\L3\l3RecordListPrim.imp.pas}
 _l3MapPrim_ = {abstract mixin} class(_l3RecordListPrim_)
  {* Словарь (ключ-значение) }
 protected
 // overridden protected methods
   procedure InitFields; override;
 public
 // public methods
   function Has(const aKey: _KeyType_): Boolean;
   procedure Add(const aKey: _KeyType_;
     const aValue: _ValueType_);
   function ValueByKey(const aKey: _KeyType_): _ValueType_;
   function ValueSlotByKey(const aKey: _KeyType_): PValueType;
   function IndexByKey(const aKey: _KeyType_): Integer;
 end;//_l3MapPrim_

function Tl3KeyValuePair_C(const aKey: _KeyType_;
     const aValue: _ValueType_): Tl3KeyValuePair;
function Tl3KeyValuePair_ForFind(const aKey: _KeyType_): Tl3KeyValuePair;

{$Else l3MapPrim_imp}

// start class _l3MapPrim_

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_); forward;
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort


function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_560907E00134_var*
//#UC END# *47B07CF403D0_560907E00134_var*
begin
//#UC START# *47B07CF403D0_560907E00134_impl*
 Result := false;
 Assert(false);
//#UC END# *47B07CF403D0_560907E00134_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_560907E00134_var*
//#UC END# *47B2C42A0163_560907E00134_var*
begin
//#UC START# *47B2C42A0163_560907E00134_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_560907E00134_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_560907E00134_var*
//#UC END# *47B99D4503A2_560907E00134_var*
begin
//#UC START# *47B99D4503A2_560907E00134_impl*
 Result := CompareKeys(CI.rA^.rKey, CI.rB^.rKey);
//#UC END# *47B99D4503A2_560907E00134_impl*
end;//CompareExistingItems


{$Include ..\L3\l3RecordListPrim.imp.pas}

// start class _l3MapPrim_

function _l3MapPrim_.Has(const aKey: _KeyType_): Boolean;
//#UC START# *560909F101B3_560907E00134_var*
var
 l_Index : Integer;
//#UC END# *560909F101B3_560907E00134_var*
begin
//#UC START# *560909F101B3_560907E00134_impl*
 Result := FindData(Tl3KeyValuePair_ForFind(aKey), l_Index);
//#UC END# *560909F101B3_560907E00134_impl*
end;//_l3MapPrim_.Has

procedure _l3MapPrim_.Add(const aKey: _KeyType_;
  const aValue: _ValueType_);
//#UC START# *56090A1801B9_560907E00134_var*
//#UC END# *56090A1801B9_560907E00134_var*
begin
//#UC START# *56090A1801B9_560907E00134_impl*
 inherited Add(Tl3KeyValuePair_C(aKey, aValue));
//#UC END# *56090A1801B9_560907E00134_impl*
end;//_l3MapPrim_.Add

function _l3MapPrim_.ValueByKey(const aKey: _KeyType_): _ValueType_;
//#UC START# *560914720336_560907E00134_var*
var
 l_Index : Integer;
//#UC END# *560914720336_560907E00134_var*
begin
//#UC START# *560914720336_560907E00134_impl*
 if FindData(Tl3KeyValuePair_ForFind(aKey), l_Index) then
  Result := ItemSlot(l_Index).rValue
 else
  raise EListError.Create('Нет значения в словаре'); 
//#UC END# *560914720336_560907E00134_impl*
end;//_l3MapPrim_.ValueByKey

function _l3MapPrim_.ValueSlotByKey(const aKey: _KeyType_): PValueType;
//#UC START# *560914A20271_560907E00134_var*
var
 l_Index : Integer;
//#UC END# *560914A20271_560907E00134_var*
begin
//#UC START# *560914A20271_560907E00134_impl*
 if FindData(Tl3KeyValuePair_ForFind(aKey), l_Index) then
  Result := @ItemSlot(l_Index).rValue
 else
  raise EListError.Create('Нет значения в словаре');
//#UC END# *560914A20271_560907E00134_impl*
end;//_l3MapPrim_.ValueSlotByKey

function _l3MapPrim_.IndexByKey(const aKey: _KeyType_): Integer;
//#UC START# *56092E020346_560907E00134_var*
//#UC END# *56092E020346_560907E00134_var*
begin
//#UC START# *56092E020346_560907E00134_impl*
 if not FindData(Tl3KeyValuePair_ForFind(aKey), Result) then
  Result := -1;
//#UC END# *56092E020346_560907E00134_impl*
end;//_l3MapPrim_.IndexByKey

function Tl3KeyValuePair_C(const aKey: _KeyType_;
        const aValue: _ValueType_): Tl3KeyValuePair;
//#UC START# *560909B400E6_5609089D0006_var*
//#UC END# *560909B400E6_5609089D0006_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *560909B400E6_5609089D0006_impl*
 Result.rKey := aKey;
 Result.rValue := aValue;
//#UC END# *560909B400E6_5609089D0006_impl*
end;//Tl3KeyValuePair.C


function Tl3KeyValuePair_ForFind(const aKey: _KeyType_): Tl3KeyValuePair;
//#UC START# *560909D5014E_5609089D0006_var*
//#UC END# *560909D5014E_5609089D0006_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *560909D5014E_5609089D0006_impl*
 Result.rKey := aKey;
//#UC END# *560909D5014E_5609089D0006_impl*
end;//Tl3KeyValuePair.ForFind

// start class _l3MapPrim_

procedure _l3MapPrim_.InitFields;
//#UC START# *47A042E100E2_560907E00134_var*
//#UC END# *47A042E100E2_560907E00134_var*
begin
//#UC START# *47A042E100E2_560907E00134_impl*
 inherited;
 Sorted := true;
 Duplicates := l3_dupError;
//#UC END# *47A042E100E2_560907E00134_impl*
end;//_l3MapPrim_.InitFields

{$EndIf l3MapPrim_imp}
