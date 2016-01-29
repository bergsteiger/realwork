unit kwKey;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwKey = class(TtfwRegisterableWord)
  {* Нажатие на кнопку клавиатуры.
Пример:
[code]
: "Нажать" STRING IN aString
 aString key
;
[code] }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwKey
 
implementation

uses
 l3ImplUses
 , Windows
 , Menus
 , Classes
 , Messages
 , l3MessagesService
;

end.
