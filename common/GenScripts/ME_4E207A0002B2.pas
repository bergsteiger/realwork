unit kwIncludedPrim;

interface

uses
 l3IntfUses
 , tfwCompilingWord
 , tfwStreamFactory
 , tfwScriptingInterfaces
 , kwCompiledWordPrim
;

type
 TkwIncludedPrim = class(TtfwCompilingWord)
  procedure DoFiler(aFiler: TtfwStreamFactory;
   const aCtx: TtfwContext);
  procedure FillContext(const anOldContext: TtfwContext;
   var theNewContext: TtfwContext);
  function EndBracket(const aContext: TtfwContext;
   aSilent: Boolean): RtfwWord;
 end;//TkwIncludedPrim
 
implementation

uses
 l3ImplUses
 , kwCompiledIncluded
 , tfwParser
 , tfwParserInterfaces
;

end.
