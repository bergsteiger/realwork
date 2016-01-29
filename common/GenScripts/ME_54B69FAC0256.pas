unit l3BoxMemoryManagerPrim;

interface

uses
 l3IntfUses
 , l3BaseBoxMemoryManager
;

type
 Tl3BoxMemoryManagerPrim = class(Tl3BaseBoxMemoryManager)
  procedure Create(aBlockSize: Integer;
   aHighIndex: Integer;
   aLowIndex: Integer);
  function SizeSize: Cardinal;
  function Size2Index(aSize: Cardinal): Integer;
  function AlignSize(aSize: Cardinal): Cardinal;
  function GetPSz(aPt: PAnsiChar): Cardinal;
  procedure SetPSz(aPt: PAnsiChar;
   aValue: Cardinal);
  function HasFreed: Boolean;
  procedure InitFreed;
  procedure ClearFreed;
  function IsValidIndex(anIndex: Integer): Boolean;
  function GetFreed(anIndex: Integer): Pointer;
  procedure SetFreed(anIndex: Integer;
   aValue: Pointer);
 end;//Tl3BoxMemoryManagerPrim
 
implementation

uses
 l3ImplUses
 , l3MinMax
 , l3MemUtils
;

end.
