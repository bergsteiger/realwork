unit tfwConstLike;

interface

uses
 l3IntfUses
 , tfwNewWord
 , tfwScriptingInterfaces
 , kwCompiledWordPrim
;

type
 TtfwConstLike = class(TtfwNewWord)
  function EndBracket(const aContext: TtfwContext;
   aSilent: Boolean): RtfwWord;
 end;//TtfwConstLike
 
implementation

uses
 l3ImplUses
 , kwRuntimeWordWithCodeExecution
 , kwConstLikeCompiled
;

end.
