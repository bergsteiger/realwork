unit Unknown.imp;

interface

uses
 l3IntfUses
;

type
 _Unknown_ = class(_UnknownImpl_, IUnknown)
 end;//_Unknown_
 
implementation

uses
 l3ImplUses
 , Windows
;

end.
