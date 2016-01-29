unit kwTryFinally;

interface

uses
 l3IntfUses
 , tfwDualWord
 , tfwScriptingInterfaces
 , kwDualCompiledWordContainer
 , kwCompiledWordPrim
;

type
 TkwTryFinally = class(TtfwDualWord)
  {* Полный аналог try finally Delphi }
  function EndBracket(const aContext: TtfwContext;
   aSilent: Boolean): RtfwWord;
  function MedianBracket: RtfwWord;
  function MakeDualCompiled(const aContext: TtfwContext;
   aCompiled: TkwCompiledWordPrim;
   aCompiled2: TkwCompiledWordPrim): TkwDualCompiledWordContainer;
  function MedianBracket2: RtfwWord;
 end;//TkwTryFinally
 
implementation

uses
 l3ImplUses
 , kwCompiledTryFinally
 , kwCompiledTryExcept
 , kwEND
 , kwFINALLY
 , kwEXCEPT
;

end.
