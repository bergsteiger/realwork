unit kwCompiledIF;

interface

uses
 l3IntfUses
 , kwDualCompiledWordContainer
 , tfwScriptingInterfaces
;

type
 TkwCompiledIF = class(TkwDualCompiledWordContainer)
  {* Внутренняя скомпилированная версия IF. }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCompiledIF
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

end.
