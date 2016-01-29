unit l3ProtoObject;

interface

uses
 l3IntfUses
 , l3CastableObject
;

type
 Tl3ProtoObject = class(Tl3CastableObject)
 end;//Tl3ProtoObject
 
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
