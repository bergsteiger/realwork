unit kwComponentFromStackWord;

interface

uses
 l3IntfUses
 , kwObjectFromStackWord
 , Classes
 , tfwScriptingInterfaces
;

type
 TkwComponentFromStackWord = class(TkwObjectFromStackWord)
  procedure DoComponent(aComponent: TComponent;
   const aCtx: TtfwContext);
  procedure DoObject(anObject: TObject;
   const aCtx: TtfwContext);
 end;//TkwComponentFromStackWord
 
implementation

uses
 l3ImplUses
 , Windows
 , Controls
 , Forms
;

end.
