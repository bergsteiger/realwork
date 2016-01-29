unit kwPopClassInherits;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwPopClassInherits = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopClassInherits
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
