{$IfNDef l3MapPrim_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3MapPrim.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "l3MapPrim" MUID: (560907E00134)
// Имя типа: "_l3MapPrim_"

{$Define l3MapPrim_imp}

type
 PValueType = ^_ValueType_;

 // _KeyType_

 // _ValueType_

 Tl3KeyValuePair = {$IfDef XE4}record{$Else}object{$EndIf}
  {* Пара ключ-значение }
  public
   rKey: _KeyType_;
   rValue: _ValueType_;
 end;//Tl3KeyValuePair

 _ItemType_ = Tl3KeyValuePair;
 _l3RecordListPrim_Parent_ = _l3MapPrim_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 _l3MapPrim_ = {abstract} class(_l3RecordListPrim_)
  {* Словарь (ключ-значение) }
  protected
   procedure InitFields; override;
  public
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

{$IfNDef l3MapPrim_imp_impl}

{$Define l3MapPrim_imp_impl}

function Tl3KeyValuePair_C(const aKey: _KeyType_;
 const aValue: _ValueType_): Tl3KeyValuePair;
//#UC START# *560909B400E6_5609089D0006_var*
//#UC END# *560909B400E6_5609089D0006_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *560909B400E6_5609089D0006_impl*
 Result.rKey := aKey;
 Result.rValue := aValue;
//#UC END# *560909B400E6_5609089D0006_impl*
end;//Tl3KeyValuePair_C

function Tl3KeyValuePair_ForFind(const aKey: _KeyType_): Tl3KeyValuePair;
//#UC START# *560909D5014E_5609089D0006_var*
//#UC END# *560909D5014E_5609089D0006_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *560909D5014E_5609089D0006_impl*
 Result.rKey := aKey;
//#UC END# *560909D5014E_5609089D0006_impl*
end;//Tl3KeyValuePair_ForFind

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_560907E00134_var*
//#UC END# *47B07CF403D0_560907E00134_var*
begin
//#UC START# *47B07CF403D0_560907E00134_impl*
 Result := false;
 //Assert(false);
//#UC END# *47B07CF403D0_560907E00134_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_560907E00134_var*
//#UC END# *47B2C42A0163_560907E00134_var*
begin
//#UC START# *47B2C42A0163_560907E00134_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_560907E00134_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_560907E00134_var*
//#UC END# *47B99D4503A2_560907E00134_var*
begin
//#UC START# *47B99D4503A2_560907E00134_impl*
 Result := CompareKeys(CI.rA^.rKey, CI.rB^.rKey);
//#UC END# *47B99D4503A2_560907E00134_impl*
end;//CompareExistingItems

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}

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

{$EndIf l3MapPrim_imp_impl}

{$EndIf l3MapPrim_imp}

