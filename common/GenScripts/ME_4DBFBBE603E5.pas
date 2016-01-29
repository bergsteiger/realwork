unit kwBracketBegin;

interface

uses
 l3IntfUses
 , tfwBeginLikeWord
 , tfwScriptingInterfaces
 , kwCompiledWordPrim
;

type
 TkwBracketBegin = class(TtfwBeginLikeWord)
  {* Поддержка скобок. 
Пример:
[code]
 10 LOOP ( 'Hello' . )
[code] }
  function EndBracket(const aContext: TtfwContext;
   aSilent: Boolean): RtfwWord;
 end;//TkwBracketBegin
 
implementation

uses
 l3ImplUses
 , kwBracketEnd
 , kwTypedBeginLikeCompiledCode
;

end.
