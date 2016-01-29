unit m3ArcHandle;

interface

uses
 l3IntfUses
 , m3Persistent
 , ActiveX
;

type
 Tm3ArcHandleData = record
 end;//Tm3ArcHandleData
 
 Tm3ArcHandle = class(Tm3Persistent)
  procedure Load(const aStream: IStream);
  procedure Save(const aStream: IStream);
 end;//Tm3ArcHandle
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
