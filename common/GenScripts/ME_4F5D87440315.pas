unit l3FourByteCString;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , l3Interfaces
;

type
 Tl3FourByteCString = class(Tl3CProtoObject, Il3CString)
  procedure Create(aChars: Integer);
  function Make(aChars: Integer): Il3CString;
  function AsWStr: Tl3WString;
   {* Возвращает данные строки. }
 end;//Tl3FourByteCString
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Chars
;

end.
