unit m3StorageHolderList;

interface

uses
 l3IntfUses
 , m3StorageHolderListPrim1
;

type
 Tm3StorageHolderList = class(_l3CriticalSectionHolder_)
  function Exists: Boolean;
  procedure Drop(const aFileName: WideString);
  procedure DropAll;
 end;//Tm3StorageHolderList
 
implementation

uses
 l3ImplUses
 , l3Types
 , SysUtils
;

end.
