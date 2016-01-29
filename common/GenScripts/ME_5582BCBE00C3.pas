unit vcmIterator.imp;

interface

uses
 l3IntfUses
 , vcmBase
;

type
 _vcmIterator_ = class(TvcmCacheableBase)
  function GetNext: _ItemType_;
  procedure Create(const aList: _ListType_);
 end;//_vcmIterator_
 
implementation

uses
 l3ImplUses
;

end.
