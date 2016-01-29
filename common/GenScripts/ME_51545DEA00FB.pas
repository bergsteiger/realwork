unit StackPrim.imp;

interface

uses
 l3IntfUses
;

type
 // _ItemType_
 
 ItemsHolder = array of _ItemType_;
 
 _StackPrim_ = class
  procedure Push(const anItem: _ItemType_);
  function Pop: _ItemType_;
 end;//_StackPrim_
 
implementation

uses
 l3ImplUses
;

end.
