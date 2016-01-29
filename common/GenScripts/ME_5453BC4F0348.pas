unit m3BranchHandleList;

interface

uses
 l3IntfUses
 , m3BranchHandle
;

type
 Tm3WideString = record
 end;//Tm3WideString
 
 Tm3BranchHandleList = class(_m3ListWithFind_)
  function CompareKeyByItem(const aKey: _KeyType_;
   const anItem: _ItemType_): Integer;
 end;//Tm3BranchHandleList
 
implementation

uses
 l3ImplUses
 , m3BranchHandlePrim
 , m3WideStringManager
 , m2MemLib
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
