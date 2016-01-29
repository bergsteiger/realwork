unit m3BaseArcStream;

interface

uses
 l3IntfUses
 , ActiveX
;

type
 Tm3BaseArcStreamHeader = record
 end;//Tm3BaseArcStreamHeader
 
 Tm3BaseArcStream = class(_m3CustomHeaderStream_)
  function HeaderID: TCLSID;
  function DefaultHeaderValue: _HeaderType_;
 end;//Tm3BaseArcStream
 
implementation

uses
 l3ImplUses
 , m2AddDbg
 , m2AddPrc
 , m2COMLib
 , m2MemLib
 , l3Base
 , ComObj
 , m3Const
;

end.
