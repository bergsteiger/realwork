unit l3InterfacedString;

interface

uses
 l3IntfUses
 , l3NCString
 , l3Interfaces
;

type
 Tl3InterfacedString = class(Tl3NCString, Il3CString)
  {* Реализация интерфейса строки }
 end;//Tl3InterfacedString
 
implementation

uses
 l3ImplUses
;

end.
