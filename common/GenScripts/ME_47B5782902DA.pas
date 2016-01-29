unit l3PtrList.imp;

interface

uses
 l3IntfUses
;

type
 _l3PtrList_ = class(_l3PtrListPrim_)
  {* Примесь для списков указателей. Список НЕ УПРАВЛЯЕТ временем жизни элементов. }
  procedure FillItem(var aPlace: _ItemType_;
   const anItem: _ItemType_;
   anItems: _l3Items_);
   {* Заполняет элемент списка. }
 end;//_l3PtrList_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
