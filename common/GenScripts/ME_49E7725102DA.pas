unit l3ProtoPersistent;

interface

uses
 l3IntfUses
 , l3CastablePersistent
;

type
 Tl3ProtoPersistent = class(_l3Unknown_)
 end;//Tl3ProtoPersistent
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
;

end.
