unit m3ListWithFind.imp;

interface

uses
 l3IntfUses
;

type
 // _KeyType_
 
 _m3ListWithFind_ = class(_m3AutoAllocList_)
  function FindItemByKey(const aKey: _KeyType_;
   var theIndex: Integer): Boolean;
  function CompareKeyByItem(const aKey: _KeyType_;
   const anItem: _ItemType_): Integer;
 end;//_m3ListWithFind_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
