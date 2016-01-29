unit kwCloseBracket;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwCloseBracket = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCloseBracket
 
implementation

uses
 l3ImplUses
 , l3String
;

end.
