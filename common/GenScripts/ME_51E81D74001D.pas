unit InterfaceList.imp;

interface

uses
 l3IntfUses
;

type
 _InterfaceList_ = class(_List_)
  function IsSame(const A: _ItemType_;
   const B: _ItemType_): Boolean;
 end;//_InterfaceList_
 
implementation

uses
 l3ImplUses
 , RTLConsts
 , l3MemorySizeUtils
;

end.
