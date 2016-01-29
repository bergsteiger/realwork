unit k2CustomReader;

interface

uses
 l3IntfUses
 , k2CustomStackGenerator
;

type
 Tk2CustomReader = class(Tk2CustomStackGenerator)
  procedure Read;
 end;//Tk2CustomReader
 
implementation

uses
 l3ImplUses
;

end.
