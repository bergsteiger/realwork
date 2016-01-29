unit kwEmitString;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwEmitString = class(TtfwRegisterableWord)
  {* Позволяет ввести строку.
Пример:
[code]
: "Ввести строку" STRING IN aString
 aString emitstring
;
[code] }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEmitString
 
implementation

uses
 l3ImplUses
 , l3String
 , Windows
 , Messages
 , l3Chars
 , l3Interfaces
;

end.
