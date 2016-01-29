unit l3LockedChangePrim.imp;

interface

uses
 l3IntfUses
;

type
 _l3LockedChangePrim_ = class(Ml3Changing)
  procedure FireChanging;
  procedure FireChanged;
  function IsChanging: Boolean;
 end;//_l3LockedChangePrim_
 
implementation

uses
 l3ImplUses
;

end.
