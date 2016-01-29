unit kwSubDescriptorFromStackWord;

interface

uses
 l3IntfUses
 , kwObjectFromStackWord
 , evSubPn
 , tfwScriptingInterfaces
;

type
 TkwSubDescriptorFromStackWord = class(TkwObjectFromStackWord)
  procedure DoWithSubDescriptor(aControl: TevSubDescriptor;
   const aCtx: TtfwContext);
  procedure DoObject(anObject: TObject;
   const aCtx: TtfwContext);
 end;//TkwSubDescriptorFromStackWord
 
implementation

uses
 l3ImplUses
;

end.
