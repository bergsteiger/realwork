unit kwCompiledWordWorkerWord;

interface

uses
 l3IntfUses
 , tfwWordWorker
 , tfwScriptingInterfaces
 , kwCompiledWordWorkerWordRunner
 , tfwScriptingTypes
 , kwCompiledWordWorker
 , tfwDictionaryPrim
 , kwCompiledWordPrim
 , kwTemporaryCompiledCode
;

type
 RkwCompiledWordWorkerWord = class of TkwCompiledWordWorkerWord;
 
 TkwImmediateTemporaryCompiledCode = class(TkwTemporaryCompiledCode)
 end;//TkwImmediateTemporaryCompiledCode
 
 TkwCompiledWordWorkerWord = class(TtfwWordWorker)
  procedure Create(aCompiled: TtfwWord);
  function RunnerClass(const aCtx: TtfwContext): RkwCompiledWordWorkerWordRunner;
  function TreatUnknownAsStringInParam(const aContext: TtfwContext;
   aParamNumber: Integer): Boolean;
  function ParamHasModifer(const aContext: TtfwContext;
   aParamNumber: Integer;
   aModifier: TtfwWordModifier): Boolean; overload;
  function ParamHasModifer(const aContext: TtfwContext;
   aParamNumber: Integer;
   aModifier: TtfwLinkType): Boolean; overload;
  function CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker;
 end;//TkwCompiledWordWorkerWord
 
implementation

uses
 l3ImplUses
 , SysUtils
 , tfwWordRefList
 , kwCompiledWordWorkerWordPack
;

end.
