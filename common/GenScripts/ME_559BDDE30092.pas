unit ItfwCompilerWordsPack;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
 , tfwClassLike
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopCompilerCompileInParameterPopCode = class(TtfwClassLike)
  {* Слово скрипта pop:Compiler:CompileInParameterPopCode
*Пример:*
[code]
 aParameterToPop aCompiler pop:Compiler:CompileInParameterPopCode
[code]  }
  procedure CompileInParameterPopCode(const aCtx: TtfwContext;
   aCompiler: TtfwCompiler;
   aParameterToPop: TtfwWord);
   {* Реализация слова скрипта pop:Compiler:CompileInParameterPopCode }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopCompilerCompileInParameterPopCode
 
 TkwPopCompilerGetWordCompilingNow = class(TtfwClassLike)
  {* Слово скрипта pop:Compiler:GetWordCompilingNow
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aCompiler pop:Compiler:GetWordCompilingNow >>> l_TtfwWord
[code]  }
  function GetWordCompilingNow(const aCtx: TtfwContext;
   aCompiler: TtfwCompiler): TtfwWord;
   {* Реализация слова скрипта pop:Compiler:GetWordCompilingNow }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopCompilerGetWordCompilingNow
 
 TkwPopCompilerAddCodePart = class(TtfwClassLike)
  {* Слово скрипта pop:Compiler:AddCodePart
*Пример:*
[code]
 aWord aCompiler pop:Compiler:AddCodePart
[code]  }
  procedure AddCodePart(const aCtx: TtfwContext;
   aCompiler: TtfwCompiler;
   aWord: TtfwWord);
   {* Реализация слова скрипта pop:Compiler:AddCodePart }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopCompilerAddCodePart
 
 TkwPopCompilerKeywordFinder = class(TtfwPropertyLike)
  {* Слово скрипта pop:Compiler:KeywordFinder
*Тип результата:* TtfwKeywordFinder
*Пример:*
[code]
OBJECT VAR l_TtfwKeywordFinder
 aCompiler pop:Compiler:KeywordFinder >>> l_TtfwKeywordFinder
[code]  }
  function KeywordFinder(const aCtx: TtfwContext;
   aCompiler: TtfwCompiler): TtfwKeywordFinder;
   {* Реализация слова скрипта pop:Compiler:KeywordFinder }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopCompilerKeywordFinder
 
 TkwPopCompilerNewWordDefinitor = class(TtfwPropertyLike)
  {* Слово скрипта pop:Compiler:NewWordDefinitor
*Тип результата:* TtfwNewWordDefinitor
*Пример:*
[code]
OBJECT VAR l_TtfwNewWordDefinitor
 aCompiler pop:Compiler:NewWordDefinitor >>> l_TtfwNewWordDefinitor
[code]  }
  function NewWordDefinitor(const aCtx: TtfwContext;
   aCompiler: TtfwCompiler): TtfwNewWordDefinitor;
   {* Реализация слова скрипта pop:Compiler:NewWordDefinitor }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopCompilerNewWordDefinitor
 
end.
