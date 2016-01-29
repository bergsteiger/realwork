unit kwUsesLike;

interface

uses
 l3IntfUses
 , tfwIncludeLike
 , tfwScriptingInterfaces
;

type
 TkwUsesLike = class(TtfwIncludeLike)
  function EndBracket(const aContext: TtfwContext;
   aSilent: Boolean): RtfwWord;
 end;//TkwUsesLike
 
implementation

uses
 l3ImplUses
 , kwStandardProcedureCloseBracket
 , l3String
;

end.
