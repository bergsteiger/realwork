unit l3MapPrim.imp;

interface

uses
 l3IntfUses
;

type
 // _KeyType_
 
 // _ValueType_
 
 Tl3KeyValuePair = object
  {* Пара ключ-значение }
 end;//Tl3KeyValuePair
 
 PValueType = ^_ValueType_;
 
 _l3MapPrim_ = class(_l3RecordListPrim_, Ml3Unknown)
  {* Словарь (ключ-значение) }
  function Has(const aKey: _KeyType_): Boolean;
  procedure Add(const aKey: _KeyType_;
   const aValue: _ValueType_);
  function ValueByKey(const aKey: _KeyType_): _ValueType_;
  function ValueSlotByKey(const aKey: _KeyType_): PValueType;
  function IndexByKey(const aKey: _KeyType_): Integer;
  function CompareKeys(const aA: _KeyType_;
   const aB: _KeyType_): Integer;
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//_l3MapPrim_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
