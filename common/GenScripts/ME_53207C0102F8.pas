unit k2AtomicTag;

interface

uses
 l3IntfUses
 , k2NotStructuredTag
 , l3Interfaces
;

type
 Rk2AtomicTag = class of Tk2AtomicTag;
 
 Tk2AtomicTag = class(Tk2NotStructuredTag)
  {* Базовый атомарный тег }
 end;//Tk2AtomicTag
 
implementation

uses
 l3ImplUses
 , l3String
 , k2Base
;

end.
