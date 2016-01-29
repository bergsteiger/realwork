unit l3MemUtils;

interface

uses
 l3IntfUses
 , Refcounted
 , Windows
;

type
 Rl3MemUtils = class of Tl3MemUtils;
 
 Tl3MemUtils = class(TRefcounted)
  procedure ReallocLocalMem(var P;
   NewSize: Cardinal);
   {* перераспределить кусок локальной памяти }
  procedure FreeLocalMem(var P);
   {* освободить кусок локальной памяти }
  procedure CheckMaxes;
  procedure StatMemAlloc(aSize: Integer;
   aL3: Boolean);
  function IsDown: Boolean;
  procedure DownBegins;
  procedure GetLocalMem(var P;
   Size: Cardinal);
  procedure GetLocalMemZ(var P;
   Size: Cardinal);
  function GlobalSize(aMem: THandle): Cardinal; overload;
  function GlobalSize(aMem: Pointer): Cardinal; overload;
  function GlobalFreePtr(var Mem: Pointer): THandle;
  function GlobalAllocPtr(Bytes: Integer): Pointer;
 end;//Tl3MemUtils
 
implementation

uses
 l3ImplUses
 , l3MemorySizeUtils
 , l3Interlocked
;

end.
