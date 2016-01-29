unit l3NCString;

interface

uses
 l3IntfUses
 , l3_String
;

type
 Tl3NCString = class(Tl3_String)
  {* Гарантированно некешируемая строка. }
 end;//Tl3NCString
 
implementation

uses
 l3ImplUses
;

end.
