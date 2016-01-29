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
  {* ����� ������� pop:ScriptEngine:AsKeywordFinder
*��� ����������:* TtfwKeywordFinder
*������:*
[code]
OBJECT VAR l_TtfwKeywordFinder
 aScriptEngine pop:ScriptEngine:AsKeywordFinder >>> l_TtfwKeywordFinder
[code]  }
  function AsKeywordFinder(const aCtx: TtfwContext;
   const aScriptEngine: ItfwScriptEngine): TtfwKeywordFinder;
   {* ���������� ����� ������� pop:ScriptEngine:AsKeywordFinder }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopScriptEngineAsKeywordFinder
 
 TkwPopScriptEngineAddInitialization = class(TtfwClassLike)
  {* ����� ������� pop:ScriptEngine:AddInitialization
*������:*
[code]
 aWord aScriptEngine pop:ScriptEngine:AddInitialization
[code]  }
  procedure AddInitialization(const aCtx: TtfwContext;
   const aScriptEngine: ItfwScriptEngine;
   aWord: TtfwWord);
   {* ���������� ����� ������� pop:ScriptEngine:AddInitialization }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopScriptEngineAddInitialization
 
 TkwPopScriptEngineCurrentCompilingDictionary = class(TtfwClassLike)
  {* ����� ������� pop:ScriptEngine:CurrentCompilingDictionary
*��� ����������:* TtfwDictionaryEx
*������:*
[code]
OBJECT VAR l_TtfwDictionaryEx
 aScriptEngine pop:ScriptEngine:CurrentCompilingDictionary >>> l_TtfwDictionaryEx
[code]  }
  function CurrentCompilingDictionary(const aCtx: TtfwContext;
   const aScriptEngine: ItfwScriptEngine): TtfwDictionaryEx;
   {* ���������� ����� ������� pop:ScriptEngine:CurrentCompilingDictionary }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopScriptEngineCurrentCompilingDictionary
 
 TkwPopScriptEngineDisableForHelp = class(TtfwClassLike)
  {* ����� ������� pop:ScriptEngine:DisableForHelp
*������:*
[code]
 aWord aScriptEngine pop:ScriptEngine:DisableForHelp
[code]  }
  procedure DisableForHelp(const aCtx: TtfwContext;
   const aScriptEngine: ItfwScriptEngine;
   aWord: TtfwWord);
   {* ���������� ����� ������� pop:ScriptEngine:DisableForHelp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopScriptEngineDisableForHelp
 
 TkwPopScriptEngineCascadeDict = class(TtfwPropertyLike)
  {* ����� ������� pop:ScriptEngine:CascadeDict
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aScriptEngine pop:ScriptEngine:CascadeDict >>> l_Boolean
[code]  }
  function CascadeDict(const aCtx: TtfwContext;
   const aScriptEngine: ItfwScriptEngine): Boolean;
   {* ���������� ����� ������� pop:ScriptEngine:CascadeDict }
  procedure DoSetValue(const aScriptEngine: ItfwScriptEngine;
   aValue: Boolean);
   {* ����� ��������� �������� �������� CascadeDict }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopScriptEngineCascadeDict
 
end.
