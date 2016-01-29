unit kwCompiledWordPrimPrim;

interface

uses
 l3IntfUses
 , kwSourcePointWord
 , tfwScriptingInterfaces
 , tfwKeyWordPrim
;

type
 TkwCompiledWordPrimPrim = class(TkwSourcePointWord)
  procedure Create(aWordProducer: TtfwWord;
   const aCtx: TtfwContext;
   aKey: TtfwKeyWordPrim);
 end;//TkwCompiledWordPrimPrim
 
implementation

uses
 l3ImplUses
;

end.
