unit m3BaseStream;

interface

uses
 l3IntfUses
 , m3PrimStream
 , ActiveX
;

type
 Tm3BaseStream = class(Tm3PrimStream, IStream)
 end;//Tm3BaseStream
 
implementation

uses
 l3ImplUses
 , Windows
 , m2COMLib
 , SysUtils
 , ComObj
 , l3Base
 , Classes
 , m2MemLib
;

end.
