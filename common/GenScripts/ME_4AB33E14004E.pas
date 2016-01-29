unit vcmModule;

interface

uses
 l3IntfUses
 , Classes
;

type
 RvcmModule = class of TvcmModule;
 
 TvcmModule = class(_l3Unknown_)
 end;//TvcmModule
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , l3MemUtils
 , l3Interlocked
;

end.
