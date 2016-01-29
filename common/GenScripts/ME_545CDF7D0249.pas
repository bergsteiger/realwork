unit l3ObjectsMemoryManager;

interface

uses
 l3IntfUses
 , l3SimpleMemoryManager
;

type
 Tl3ObjectsMemoryManager = class(Tl3SimpleMemoryManager)
  procedure Create;
  procedure FreeMem(anObject: TObject);
  procedure GetMem(out thePlace: TObject;
   aClass: TClass);
 end;//Tl3ObjectsMemoryManager
 
implementation

uses
 l3ImplUses
 , l3MemUtils
 , SysUtils
;

end.
