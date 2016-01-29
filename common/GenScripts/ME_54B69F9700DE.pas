unit l3BaseBoxMemoryManager;

interface

uses
 l3IntfUses
 , l3SimpleMemoryManager
;

type
 Tl3BaseBoxMemoryManager = class(Tl3SimpleMemoryManager)
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
  procedure Create(aBlockSize: Cardinal);
   {* создает менеджер }
  function GetSize(aPt: Pointer): Cardinal;
  procedure ReallocMem(var P;
   aNewSize: Cardinal);
 end;//Tl3BaseBoxMemoryManager
 
implementation

uses
 l3ImplUses
 , l3MinMax
;

end.
