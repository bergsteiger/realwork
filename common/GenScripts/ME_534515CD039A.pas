unit l3VariantListPrim.imp;

interface

uses
 l3IntfUses
 , l3Variant
;

type
 _l3VariantListPrim_ = class(_l3RefList_)
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure FillItem(var aPlace: _ItemType_;
   const anItem: _ItemType_;
   anItems: _l3Items_);
   {* Заполняет элемент списка. }
  procedure FreeItem(var aPlace: _ItemType_;
   aList: _l3Items_);
   {* Очищает элемент списка }
 end;//_l3VariantListPrim_
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
;

end.
