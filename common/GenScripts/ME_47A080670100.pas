unit l3Stream;

interface

uses
 l3IntfUses
 , l3Interfaces
 , Classes
 , l3BaseStream
 , l3Memory
;

type
 Tl3BufferState = (
  {* Состояние буфера. }
  bsUnknown
  , bsRead
  , bsWrite
 );//Tl3BufferState
 
 Tl3TextStream = class
 end;//Tl3TextStream
 
 Tl3NamedTextStream = class
 end;//Tl3NamedTextStream
 
 Tl3FileStream = class
 end;//Tl3FileStream
 
 Tl3HandleStream = class(Tl3Stream)
 end;//Tl3HandleStream
 
 Tl3TempFileStream = class(Tl3HandleStream)
 end;//Tl3TempFileStream
 
 Tl3NamedFileStream = class
 end;//Tl3NamedFileStream
 
 Tl3ResourceStream = class(Tl3ConstMemoryStream)
 end;//Tl3ResourceStream
 
implementation

uses
 l3ImplUses
;

end.
