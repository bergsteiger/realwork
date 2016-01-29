unit l3OneByteCString;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , l3Interfaces
;

type
 Tl3OneByteCString = class(Tl3CProtoObject, Il3CString)
  procedure Create(aChar: AnsiChar);
  function Make(aChar: AnsiChar): Il3CString;
  function AsWStr: Tl3WString;
   {* Возвращает данные строки. }
 end;//Tl3OneByteCString
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Chars
;

end.
