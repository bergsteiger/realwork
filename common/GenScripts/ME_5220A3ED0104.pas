unit kwKeyDown;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwKeyDown = class(TtfwRegisterableWord)
  {* 'Alt' KeyDown // зажать клавишу
1000 SLEEP
'Alt' KeyUp // отпустить клавишу }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwKeyDown
 
implementation

uses
 l3ImplUses
 , Windows
 , Menus
 , Classes
 , Messages
 , SysUtils
 , l3MessagesService
;

end.
