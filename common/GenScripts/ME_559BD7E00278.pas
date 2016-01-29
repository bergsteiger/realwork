unit ItfwScriptEngineWordsPack;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
 , tfwDictionaryEx
 , l3Interfaces
 , tfwTypeInfo
 , l3Variant
 , Types
 , tfwDictionaryPrim
 , TypInfo
 , tfwClassLike
 , tfwPropertyLike
;

implementation

uses
 l3ImplUses
 , tfwDictionaryExWordsPack
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopScriptEngineAsKeywordFinder = class(TtfwClassLike)
  {* Слово скрипта pop:ScriptEngine:AsKeywordFinder
*Тип результата:* TtfwKeywordFinder
*Пример:*
[code]
OBJECT VAR l_TtfwKeywordFinder
 aScriptEngine pop:ScriptEngine:AsKeywordFinder >>> l_TtfwKeywordFinder
[code]  }
  function AsKeywordFinder(const aCtx: TtfwContext;
   const aScriptEngine: ItfwScriptEngine): TtfwKeywordFinder;
   {* Реализация слова скрипта pop:ScriptEngine:AsKeywordFinder }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopScriptEngineAsKeywordFinder
 
 TkwPopScriptEngineAddInitialization = class(TtfwClassLike)
  {* Слово скрипта pop:ScriptEngine:AddInitialization
*Пример:*
[code]
 aWord aScriptEngine pop:ScriptEngine:AddInitialization
[code]  }
  procedure AddInitialization(const aCtx: TtfwContext;
   const aScriptEngine: ItfwScriptEngine;
   aWord: TtfwWord);
   {* Реализация слова скрипта pop:ScriptEngine:AddInitialization }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopScriptEngineAddInitialization
 
 TkwPopScriptEngineCurrentCompilingDictionary = class(TtfwClassLike)
  {* Слово скрипта pop:ScriptEngine:CurrentCompilingDictionary
*Тип результата:* TtfwDictionaryEx
*Пример:*
[code]
OBJECT VAR l_TtfwDictionaryEx
 aScriptEngine pop:ScriptEngine:CurrentCompilingDictionary >>> l_TtfwDictionaryEx
[code]  }
  function CurrentCompilingDictionary(const aCtx: TtfwContext;
   const aScriptEngine: ItfwScriptEngine): TtfwDictionaryEx;
   {* Реализация слова скрипта pop:ScriptEngine:CurrentCompilingDictionary }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopScriptEngineCurrentCompilingDictionary
 
 TkwPopScriptEngineDisableForHelp = class(TtfwClassLike)
  {* Слово скрипта pop:ScriptEngine:DisableForHelp
*Пример:*
[code]
 aWord aScriptEngine pop:ScriptEngine:DisableForHelp
[code]  }
  procedure DisableForHelp(const aCtx: TtfwContext;
   const aScriptEngine: ItfwScriptEngine;
   aWord: TtfwWord);
   {* Реализация слова скрипта pop:ScriptEngine:DisableForHelp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopScriptEngineDisableForHelp
 
 TkwPopScriptEngineCascadeDict = class(TtfwPropertyLike)
  {* Слово скрипта pop:ScriptEngine:CascadeDict
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aScriptEngine pop:ScriptEngine:CascadeDict >>> l_Boolean
[code]  }
  function CascadeDict(const aCtx: TtfwContext;
   const aScriptEngine: ItfwScriptEngine): Boolean;
   {* Реализация слова скрипта pop:ScriptEngine:CascadeDict }
  procedure DoSetValue(const aScriptEngine: ItfwScriptEngine;
   aValue: Boolean);
   {* Метод установки значения свойства CascadeDict }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopScriptEngineCascadeDict
 
end.
