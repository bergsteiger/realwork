unit kwEmitString;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwEmitString = class(TtfwRegisterableWord)
  {* ��������� ������ ������.
������:
[code]
: "������ ������" STRING IN aString
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
