unit ddAppConfigBase;

interface

uses
 l3IntfUses
 , l3ProtoPersistent
;

type
 TddAppConfigBase = class(Tl3ProtoPersistent)
  procedure Create;
  function Clone: Pointer;
 end;//TddAppConfigBase
 
implementation

uses
 l3ImplUses
;

end.
