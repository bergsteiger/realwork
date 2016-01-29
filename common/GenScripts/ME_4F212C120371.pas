unit kwControlFromStackWord.imp;

interface

uses
 l3IntfUses
 , kwComponentFromStackWord
 , Controls
 , tfwScriptingInterfaces
 , Classes
;

type
 _kwControlFromStackWord_ = class(TkwComponentFromStackWord)
  procedure DoControl(aControl: TControl;
   const aCtx: TtfwContext);
  procedure DoComponent(aComponent: TComponent;
   const aCtx: TtfwContext);
 end;//_kwControlFromStackWord_
 
implementation

uses
 l3ImplUses
;

end.
