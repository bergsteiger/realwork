unit l3ProtoPersistentWithHandle;

interface

uses
 l3IntfUses
 , l3ProtoPersistent
 , l3Types
;

type
 Tl3ProtoPersistentWithHandle = class(Tl3ProtoPersistent)
  function CompareWith(anOther: Tl3ProtoPersistentWithHandle): Integer;
 end;//Tl3ProtoPersistentWithHandle
 
implementation

uses
 l3ImplUses
;

end.
