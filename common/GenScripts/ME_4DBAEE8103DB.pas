unit kwCASE;

interface

uses
 l3IntfUses
 , tfwBeginLikeWord
 , tfwScriptingInterfaces
 , kwCompiledWordPrim
;

type
 TkwCASE = class(TtfwBeginLikeWord)
  {* Аналог Case из Delphi
[code]
 CASE
  1 ( 1 . )
  2 ( 2 . )
  DEFAULT ( 'else' . )
 ENDCASE
[code] }
  function EndBracket(const aContext: TtfwContext;
   aSilent: Boolean): RtfwWord;
 end;//TkwCASE
 
implementation

uses
 l3ImplUses
 , kwEND
 , kwCompiledCase
;

end.
