unit m3NewVersionStream;

interface

uses
 l3IntfUses
 , m3DBProxyWriteStream
;

type
 Tm3NewVersionStream = class(Tm3DBProxyWriteStream)
  {* ѕоток, создавший новую версию документа }
 end;//Tm3NewVersionStream
 
implementation

uses
 l3ImplUses
;

end.
