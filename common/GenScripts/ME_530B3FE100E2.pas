unit k2MemoryStream;

interface

uses
 l3IntfUses
 , l3Memory
 , k2Interfaces
;

type
 Tk2MemoryStream = class(Tl3MemoryStream, Ik2RawData)
  function IsModified: Boolean;
 end;//Tk2MemoryStream
 
implementation

uses
 l3ImplUses
;

end.
