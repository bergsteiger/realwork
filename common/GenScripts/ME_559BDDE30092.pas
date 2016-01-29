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
  {* ����� ������� pop:Compiler:CompileInParameterPopCode
*������:*
[code]
 aParameterToPop aCompiler pop:Compiler:CompileInParameterPopCode
[code]  }
  procedure CompileInParameterPopCode(const aCtx: TtfwContext;
   aCompiler: TtfwCompiler;
   aParameterToPop: TtfwWord);
   {* ���������� ����� ������� pop:Compiler:CompileInParameterPopCode }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopCompilerCompileInParameterPopCode
 
 TkwPopCompilerGetWordCompilingNow = class(TtfwClassLike)
  {* ����� ������� pop:Compiler:GetWordCompilingNow
*��� ����������:* TtfwWord
*������:*
[code]
OBJECT VAR l_TtfwWord
 aCompiler pop:Compiler:GetWordCompilingNow >>> l_TtfwWord
[code]  }
  function GetWordCompilingNow(const aCtx: TtfwContext;
   aCompiler: TtfwCompiler): TtfwWord;
   {* ���������� ����� ������� pop:Compiler:GetWordCompilingNow }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopCompilerGetWordCompilingNow
 
 TkwPopCompilerAddCodePart = class(TtfwClassLike)
  {* ����� ������� pop:Compiler:AddCodePart
*������:*
[code]
 aWord aCompiler pop:Compiler:AddCodePart
[code]  }
  procedure AddCodePart(const aCtx: TtfwContext;
   aCompiler: TtfwCompiler;
   aWord: TtfwWord);
   {* ���������� ����� ������� pop:Compiler:AddCodePart }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopCompilerAddCodePart
 
 TkwPopCompilerKeywordFinder = class(TtfwPropertyLike)
  {* ����� ������� pop:Compiler:KeywordFinder
*��� ����������:* TtfwKeywordFinder
*������:*
[code]
OBJECT VAR l_TtfwKeywordFinder
 aCompiler pop:Compiler:KeywordFinder >>> l_TtfwKeywordFinder
[code]  }
  function KeywordFinder(const aCtx: TtfwContext;
   aCompiler: TtfwCompiler): TtfwKeywordFinder;
   {* ���������� ����� ������� pop:Compiler:KeywordFinder }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopCompilerKeywordFinder
 
 TkwPopCompilerNewWordDefinitor = class(TtfwPropertyLike)
  {* ����� ������� pop:Compiler:NewWordDefinitor
*��� ����������:* TtfwNewWordDefinitor
*������:*
[code]
OBJECT VAR l_TtfwNewWordDefinitor
 aCompiler pop:Compiler:NewWordDefinitor >>> l_TtfwNewWordDefinitor
[code]  }
  function NewWordDefinitor(const aCtx: TtfwContext;
   aCompiler: TtfwCompiler): TtfwNewWordDefinitor;
   {* ���������� ����� ������� pop:Compiler:NewWordDefinitor }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopCompilerNewWordDefinitor
 
end.
