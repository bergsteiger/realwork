unit kwFORWARD;

interface

uses
 l3IntfUses
 , tfwNewWord
 , tfwScriptingInterfaces
 , kwCompiledWordPrim
;

type
 TkwFORWARD = class(TtfwNewWord)
  {* ѕредварительное определение слова }
  function EndBracket(const aContext: TtfwContext;
   aSilent: Boolean): RtfwWord;
 end;//TkwFORWARD
 
implementation

uses
 l3ImplUses
 , kwForwardDeclaration
 , SysUtils
;

end.
