unit CodeBranchingPack;

interface

uses
 l3IntfUses
 , tfwBeginLikeWord
 , tfwScriptingInterfaces
 , kwCompiledWordPrim
;

type
 TkwRULES = class(TtfwBeginLikeWord)
  {* јналог CASE и трансформаторов в MDP. ≈сли условие выполн€етс€, то выполн€етс€ следующий за ним оператор и осуществл€етс€ выход }
  function EndBracket(const aContext: TtfwContext;
   aSilent: Boolean): RtfwWord;
 end;//TkwRULES
 
implementation

uses
 l3ImplUses
 , kwIfElse
 , kwElse
 , kwCASE
 , kwDEFAULT
 , kwRAISE
 , kwBracketBegin
 , kwBEGIN
 , tfwScriptingTypes
 , kwCompiledRules
 , kwStandardProcedureCloseBracket
;

end.
