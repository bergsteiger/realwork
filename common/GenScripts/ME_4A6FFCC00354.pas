unit l3InterfacePtrListPrim.imp;

interface

uses
 l3IntfUses
;

type
 _l3InterfacePtrListPrim_ = class(_l3PtrListPrim_)
  procedure FillItem(var aPlace: _ItemType_;
   const anItem: _ItemType_;
   anItems: _l3Items_);
   {* Заполняет элемент списка. }
 end;//_l3InterfacePtrListPrim_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
