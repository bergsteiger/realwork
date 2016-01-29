unit kwTemporaryCompiledCode;

interface

uses
 l3IntfUses
 , kwRuntimeWordWithCode
 , tfwScriptingInterfaces
;

type
 TkwTemporaryCompiledCode = class(TkwRuntimeWordWithCode)
  {* Временный контейне скомпилированного кода, который умрёт после компиляции. На который нельзя держать "слабые" ссылки. Например как Caller }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTemporaryCompiledCode
 
implementation

uses
 l3ImplUses
;

end.
