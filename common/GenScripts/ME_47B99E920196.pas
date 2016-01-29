unit l3UncomparabeObjectRefList.imp;

interface

uses
 l3IntfUses
;

type
 _l3UncomparabeObjectRefList_ = class(_l3ObjectRefListPrim_)
  procedure FillItem(var aPlace: _ItemType_;
   const anItem: _ItemType_;
   anItems: _l3Items_);
   {* Заполняет элемент списка. }
  procedure FreeItem(var aPlace: _ItemType_;
   aList: _l3Items_);
   {* Очищает элемент списка }
 end;//_l3UncomparabeObjectRefList_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
