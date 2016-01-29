unit tfwProcedure;

interface

uses
 l3IntfUses
 , tfwNewWord
 , l3Interfaces
 , tfwScriptingInterfaces
 , kwCompiledWordPrim
;

type
 TtfwProcedure = class(TtfwNewWord)
  function AddedParameters: Tl3CStringArray;
  function EndBracket(const aContext: TtfwContext;
   aSilent: Boolean): RtfwWord;
 end;//TtfwProcedure
 
implementation

uses
 l3ImplUses
 , kwStandardProcedureCloseBracket
 , kwCompiledWordWorkerWord
 , SysUtils
 , kwCompiledProcedure
 , kwCompiledFunction
 , kwCompiledProcedureWithStackChecking
 , kwInlinedWord
;

end.
