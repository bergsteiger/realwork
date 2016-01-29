unit NewWordDefinitorPack;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
 , l3Interfaces
 , kwCompiledVar
 , tfwClassLike
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
;

type
 TkwGlobalVar = class(TkwCompiledVar)
 end;//TkwGlobalVar
 
implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopNewWordDefinitorCheckWord = class(TtfwClassLike)
  {* Слово скрипта pop:NewWordDefinitor:CheckWord
*Тип результата:* TtfwKeyWord
*Пример:*
[code]
OBJECT VAR l_TtfwKeyWord
 aName aNewWordDefinitor pop:NewWordDefinitor:CheckWord >>> l_TtfwKeyWord
[code]  }
  function CheckWord(const aCtx: TtfwContext;
   aNewWordDefinitor: TtfwNewWordDefinitor;
   const aName: Il3CString): TtfwKeyWord;
   {* Реализация слова скрипта pop:NewWordDefinitor:CheckWord }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopNewWordDefinitorCheckWord
 
 TkwPopNewWordDefinitorCheckVar = class(TtfwClassLike)
  {* Слово скрипта pop:NewWordDefinitor:CheckVar
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aName aLocal aNewWordDefinitor pop:NewWordDefinitor:CheckVar >>> l_TtfwWord
[code]  }
  function CheckVar(const aCtx: TtfwContext;
   aNewWordDefinitor: TtfwNewWordDefinitor;
   aLocal: Boolean;
   const aName: Il3CString): TtfwWord;
   {* Реализация слова скрипта pop:NewWordDefinitor:CheckVar }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopNewWordDefinitorCheckVar
 
 TkwPopNewWordDefinitorDefineInParameter = class(TtfwClassLike)
  {* Слово скрипта pop:NewWordDefinitor:DefineInParameter
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aStereo aParamName aNewWordDefinitor pop:NewWordDefinitor:DefineInParameter >>> l_TtfwWord
[code]  }
  function DefineInParameter(const aCtx: TtfwContext;
   aNewWordDefinitor: TtfwNewWordDefinitor;
   const aParamName: Il3CString;
   aStereo: TtfwWord): TtfwWord;
   {* Реализация слова скрипта pop:NewWordDefinitor:DefineInParameter }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopNewWordDefinitorDefineInParameter
 
 TkwPopNewWordDefinitorKeywordFinder = class(TtfwPropertyLike)
  {* Слово скрипта pop:NewWordDefinitor:KeywordFinder
*Тип результата:* TtfwKeywordFinder
*Пример:*
[code]
OBJECT VAR l_TtfwKeywordFinder
 aNewWordDefinitor pop:NewWordDefinitor:KeywordFinder >>> l_TtfwKeywordFinder
[code]  }
  function KeywordFinder(const aCtx: TtfwContext;
   aNewWordDefinitor: TtfwNewWordDefinitor): TtfwKeywordFinder;
   {* Реализация слова скрипта pop:NewWordDefinitor:KeywordFinder }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopNewWordDefinitorKeywordFinder
 
end.
