unit tfwBeginLikeWord;

interface

uses
 l3IntfUses
 , tfwAnonimousWord
 , tfwScriptingInterfaces
 , kwCompiledWordPrim
;

type
 TtfwBeginLikeWord = class(TtfwAnonimousWord)
  {* Поддержка слов-скобок. }
 end;//TtfwBeginLikeWord
 
implementation

uses
 l3ImplUses
 , kwBeginLikeCompiledCode
;

end.
