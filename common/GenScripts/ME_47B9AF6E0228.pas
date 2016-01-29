unit l3InterfaceRefListPrim.imp;

interface

uses
 l3IntfUses
;

type
 _l3InterfaceRefListPrim_ = class(_l3RefList_)
  procedure FillItem(var aPlace: _ItemType_;
   const anItem: _ItemType_;
   anItems: _l3Items_);
   {* ��������� ������� ������. }
  procedure FreeItem(var aPlace: _ItemType_;
   aList: _l3Items_);
   {* ������� ������� ������ }
 end;//_l3InterfaceRefListPrim_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
