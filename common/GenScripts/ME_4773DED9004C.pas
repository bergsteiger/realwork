unit l3_String;

interface

uses
 l3IntfUses
 , l3CustomString
 , l3Interfaces
;

type
 Tl3_String = class(Tl3CustomString)
  {* Класс реализующий строки с собственным методом хранения данных. }
  procedure NotifyDeletion(aPos: Integer;
   aLen: Integer);
 end;//Tl3_String
 
implementation

uses
 l3ImplUses
;

end.
