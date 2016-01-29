unit kwCompiledCheckWithEtalon;

interface

uses
 l3IntfUses
 , kwCompiledWordWorker
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwCompiledCheckWithEtalon = class(TkwCompiledWordWorker)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCompiledCheckWithEtalon
 
implementation

uses
 l3ImplUses
 , SysUtils
 , StrUtils
 , nevTools
;

end.
