unit m3TOCHandleList;

interface

uses
 l3IntfUses
 , m3TOCHandle
 , l3Interfaces
;

type
 Tm3TOCHandleList = class(_m3PersistentList_)
  function CompareKeyByItem(const aKey: _KeyType_;
   const anItem: _ItemType_): Integer;
 end;//Tm3TOCHandleList
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Types
 , m3Persistent
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
