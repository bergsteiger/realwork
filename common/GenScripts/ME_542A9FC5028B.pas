unit m3ArcCla;

interface

uses
 l3IntfUses
 , m3BaseArcStream
;

type
 Tm3ArcInflateStream = class(Tm3BaseArcStream)
 end;//Tm3ArcInflateStream
 
 Tm3ArcDeflateStream = class(Tm3BaseArcStream)
 end;//Tm3ArcDeflateStream
 
 Tm3LZOInflateStream = class(Tm3ArcInflateStream)
 end;//Tm3LZOInflateStream
 
 Tm3LZODeflateStream = class(Tm3ArcDeflateStream)
 end;//Tm3LZODeflateStream
 
implementation

uses
 l3ImplUses
 , m3ArcHandle
 , m3ArcHandleList
;

end.
