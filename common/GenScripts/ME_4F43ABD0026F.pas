unit WordsDefinitionPack;

interface

uses
 l3IntfUses
 , tfwProcedure
 , kwCompiledWordPrim
 , tfwScriptingInterfaces
 , l3Interfaces
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , kwCompiledFunction
 , SysUtils
 , l3Base
;

type
 TkwFUNCTION = class(TtfwProcedure)
 end;//TkwFUNCTION
 
 TkwNewWord = class(TtfwProcedure)
  {* ќпределение новых слов. ѕример: 
[code]
: Hello
 3 FOR
  'Hello' .
 NEXT
;
[code] }
 end;//TkwNewWord
 
 TkwOPERATOR = class(TtfwProcedure)
  {* ќпредел€ет операторы, которые могут принимать слова как слева, так и справа }
 end;//TkwOPERATOR
 
 TkwWordWorker = class(TtfwProcedure)
  {* ќпредел€ет слово, которое может работать со словом записанным за ним непосредственно в коде. Ќапример как @ }
 end;//TkwWordWorker
 
end.
