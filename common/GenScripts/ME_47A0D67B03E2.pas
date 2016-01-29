unit l3CastablePersistent;

interface

uses
 l3IntfUses
 , Classes
;

type
 Tl3CastablePersistent = class(TPersistent)
  {* TPersistent с методом QueryInterface. }
 end;//Tl3CastablePersistent
 
implementation

uses
 l3ImplUses
;

end.
