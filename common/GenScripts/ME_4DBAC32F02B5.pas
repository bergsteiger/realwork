unit tfwDualWord;

interface

uses
 l3IntfUses
 , tfwAnonimousWord
 , tfwScriptingInterfaces
 , kwDualCompiledWordContainer
 , kwCompiledWordPrim
;

type
 TtfwDualWord = class(TtfwAnonimousWord)
  function MedianBracket: RtfwWord;
  function MakeDualCompiled(const aContext: TtfwContext;
   aCompiled: TkwCompiledWordPrim;
   aCompiled2: TkwCompiledWordPrim): TkwDualCompiledWordContainer;
  function MedianBracket2: RtfwWord;
 end;//TtfwDualWord
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
