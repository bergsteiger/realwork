unit kwForwardDeclarationHolder;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
 , l3Interfaces
;

type
 TkwForwardDeclarationHolder = class(TtfwWord)
  procedure Create(aHolded: TtfwWord);
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwForwardDeclarationHolder
 
implementation

uses
 l3ImplUses
;

end.
