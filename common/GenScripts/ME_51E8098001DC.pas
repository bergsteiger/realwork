unit InterfacePtrList.imp;

interface

uses
 l3IntfUses
;

type
 _InterfacePtrList_ = class(_InterfaceList_)
  {* Список УКАЗАТЕЛЕЙ на интерфейсы. Не владеет своими элементами }
  procedure FreeItem(var thePlace: _ItemType_);
  procedure FillItem(var thePlace: _ItemType_;
   const aFrom: _ItemType_);
 end;//_InterfacePtrList_
 
implementation

uses
 l3ImplUses
 , RTLConsts
 , l3MemorySizeUtils
;

end.
