unit l3SizedPoolManager;

interface

uses
 l3IntfUses
 , l3SimpleMemoryManager
;

type
 Tl3SizedPoolManager = class(Tl3SimpleMemoryManager)
  procedure Create(aBlockSize: Cardinal;
   anItemSize: Cardinal);
  procedure AllocItem(var theItem;
   aLength: Cardinal);
  procedure FreeItem(var theItem);
  function ItemLength(anItem: Pointer): Integer;
 end;//Tl3SizedPoolManager
 
implementation

uses
 l3ImplUses
;

end.
