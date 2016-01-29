unit afwControlPrim;

interface

uses
 l3IntfUses
 , OvcBase
;

type
 TafwControlPrim = class(TOvcBase)
 end;//TafwControlPrim
 
implementation

uses
 l3ImplUses
 , Classes
 , TtfwClassRef_Proxy
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , l3MemUtils
 , l3Interlocked
;

end.
