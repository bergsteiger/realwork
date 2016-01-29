unit m3ArcHandleList;

interface

uses
 l3IntfUses
 , m3ArcHandle
;

type
 Tm3ArcHandleList = class(_m3PersistentList_)
  function CompareKeyByItem(const aKey: _KeyType_;
   const anItem: _ItemType_): Integer;
 end;//Tm3ArcHandleList
 
implementation

uses
 l3ImplUses
 , m2S64Lib
 , m3Persistent
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
