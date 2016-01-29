unit tfwCodeCompiler.imp;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
 , tfwWordRefList
;

type
 _tfwCodeCompiler_ = class(Ml3Unknown, MtfwWord)
  procedure RunCode(const aCtx: TtfwContext);
 end;//_tfwCodeCompiler_
 
implementation

uses
 l3ImplUses
 , kwForwardDeclarationHolder
 , SysUtils
;

end.
