unit l3SimpleMemoryManager;

interface

uses
 l3IntfUses
 , l3SimpleMemoryManagerPrim
;

type
 Tl3MemoryBlock = object
 end;//Tl3MemoryBlock
 
 Pl3MemoryBlock = ^Tl3MemoryBlock;
 
 Tl3SimpleMemoryManager = class(Tl3SimpleMemoryManagerPrim)
  function CanFreeBlocks: Boolean;
  procedure FreeBlocks;
  procedure DoGetMem(var P;
   aSize: Cardinal);
  procedure DoFreeMem(var P);
  procedure AllocNewBlock;
  procedure Create(aBlockSize: Cardinal);
  procedure GetMem(var P;
   aSize: Cardinal);
  procedure FreeMem(var P);
 end;//Tl3SimpleMemoryManager
 
implementation

uses
 l3ImplUses
 , l3MemUtils
 , l3ExceptionsLog
 , SysUtils
;

end.
