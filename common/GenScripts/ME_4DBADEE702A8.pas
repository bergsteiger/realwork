unit kwCompiledTryExcept;

interface

uses
 l3IntfUses
 , kwDualCompiledWordContainer
 , tfwScriptingInterfaces
;

type
 TkwCompiledTryExcept = class(TkwDualCompiledWordContainer)
  {* Скомпилированная версия try except }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCompiledTryExcept
 
implementation

uses
 l3ImplUses
 , SysUtils
 , StrUtils
;

end.
