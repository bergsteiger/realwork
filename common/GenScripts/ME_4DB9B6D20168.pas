unit tfwNewWord;

interface

uses
 l3IntfUses
 , tfwCompilingWord
 , tfwScriptingInterfaces
 , kwCompiledWordPrim
 , l3Interfaces
;

type
 TtfwNewWord = class(TtfwCompilingWord)
  procedure FinishDefinitionOfNewWord(aWordToFinish: TtfwKeyWord;
   aCompiled: TkwCompiledWordPrim;
   const aContext: TtfwContext);
   {* «авершает определение вновь созданного слова }
  function GetNewWordName(const aContext: TtfwContext): Il3CString;
 end;//TtfwNewWord
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3String
 , l3Parser
 , kwForwardDeclaration
;

end.
