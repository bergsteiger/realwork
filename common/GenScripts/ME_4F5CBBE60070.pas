unit l3TwoByteCString;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , l3Interfaces
;

type
 Tl3TwoByteCString = class(Tl3CProtoObject, Il3CString)
  procedure Create(aChars: Word);
  function Make(aChars: Word): Il3CString;
  function AsWStr: Tl3WString;
   {* Возвращает данные строки. }
 end;//Tl3TwoByteCString
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Chars
;

end.
