unit kwObjectFromStackWord;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwObjectFromStackWord = class(TtfwRegisterableWord)
  procedure DoObject(anObject: TObject;
   const aCtx: TtfwContext);
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwObjectFromStackWord
 
implementation

uses
 l3ImplUses
;

end.
