unit afwAString;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Interfaces
;

type
 TafwAString = class(Tl3ProtoObject, Il3AString)
  procedure Create(const aString: Il3CString);
  function Make(const aString: Il3CString): Il3AString;
  function S: PAnsiChar;
   {* Собственно строка. }
 end;//TafwAString
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Chars
;

end.
