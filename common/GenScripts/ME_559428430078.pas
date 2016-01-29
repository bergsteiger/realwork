unit kwCompiledWordWorkerWordPack;

interface

uses
 l3IntfUses
 , kwCompiledWordWorkerWord
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopCompiledWordWorkerWordCompiled = class(TtfwPropertyLike)
  {* Слово скрипта pop:CompiledWordWorkerWord:Compiled
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aCompiledWordWorkerWord pop:CompiledWordWorkerWord:Compiled >>> l_TtfwWord
[code]  }
  function Compiled(const aCtx: TtfwContext;
   aCompiledWordWorkerWord: TkwCompiledWordWorkerWord): TtfwWord;
   {* Реализация слова скрипта pop:CompiledWordWorkerWord:Compiled }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopCompiledWordWorkerWordCompiled
 
end.
