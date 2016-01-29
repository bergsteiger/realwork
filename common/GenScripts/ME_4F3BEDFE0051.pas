unit kwCompiledFunction;

interface

uses
 l3IntfUses
 , kwCompiledProcedureWithStackChecking
 , kwCompiledVar
 , tfwScriptingInterfaces
 , tfwKeyWordPrim
;

type
 TkwCompiledFunction = class(TkwCompiledProcedureWithStackChecking)
 end;//TkwCompiledFunction
 
implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
 , tfwClassRef
;

end.
