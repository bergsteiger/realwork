unit l3CEmptyStringPrim;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , l3Interfaces
;

type
 Tl3CEmptyStringPrim = class(Tl3CProtoObject, Il3CString)
  procedure Create;
  function Make: Il3CString;
  function AsWStr: Tl3WString;
   {* Возвращает данные строки. }
 end;//Tl3CEmptyStringPrim
 
implementation

uses
 l3ImplUses
 , l3String
;

end.
