unit tfwWordWorker;

interface

uses
 l3IntfUses
 , tfwAnonimousWord
 , kwCompiledWordWorker
 , tfwScriptingInterfaces
 , kwCompiledWordPrim
;

type
 TtfwWordWorker = class(TtfwAnonimousWord)
  {* Поддержка исполняемых скомпилированных слов. }
  function CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker;
  procedure FillCompiledWorker(aWorker: TtfwWord;
   const aContext: TtfwContext);
  procedure CompileWordWorker(const aContext: TtfwContext;
   aRightParams: TkwCompiledWordPrim);
  function MakeCompiledWordWorker(const aContext: TtfwContext;
   aRightParams: TkwCompiledWordPrim): TtfwWord;
  function EndBracket(const aContext: TtfwContext;
   aSilent: Boolean): RtfwWord;
 end;//TtfwWordWorker
 
implementation

uses
 l3ImplUses
 , kwTemporaryCompiledCode
 , SysUtils
;

end.
