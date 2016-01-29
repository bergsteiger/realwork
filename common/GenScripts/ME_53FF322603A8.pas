unit m3BaseHashInfoStream;

interface

uses
 l3IntfUses
 , ActiveX
;

type
 Tm3HashInfoStreamHeader = record
 end;//Tm3HashInfoStreamHeader
 
 Tm3BaseHashInfoStream = class(_m3CustomHeaderStream_)
  function HeaderID: TCLSID;
  function DefaultHeaderValue: _HeaderType_;
 end;//Tm3BaseHashInfoStream
 
implementation

uses
 l3ImplUses
 , m3IdxCla
 , m2HasLib
 , m2AddDbg
 , m2AddPrc
 , m2COMLib
 , m2MemLib
 , l3Base
 , ComObj
 , m3Const
;

end.
