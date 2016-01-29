unit tfwAnonimousWord;

interface

uses
 l3IntfUses
 , tfwCompilingWord
 , tfwScriptingInterfaces
;

type
 TtfwAnonimousWord = class(TtfwCompilingWord)
  procedure DoCompiledWord(aWord: TtfwWord;
   const aContext: TtfwContext);
  procedure DoRun(const aCtx: TtfwContext);
 end;//TtfwAnonimousWord
 
implementation

uses
 l3ImplUses
;

end.
