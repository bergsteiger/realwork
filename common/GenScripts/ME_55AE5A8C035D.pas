unit tfwDictionaryExWordsPack;

interface

uses
 l3IntfUses
 , tfwDictionaryEx
 , l3Interfaces
 , tfwScriptingInterfaces
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , TypInfo
;

implementation

uses
 l3ImplUses
 , tfwDictionaryDataIteratorPrim
 , tfwExportedDictionariesIterator
 , tfwUsedDictionariesIterator
 , l3DateSt
 , tfwMainDictionaryCache
 , tfwDictionaryCache
 , tfwMainDictionary
 , tfwMembersIterator
 , tfwDictionaryWordsPack
 , tfwScriptEngineExInterfaces
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TtfwDictionaryExWordsPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TtfwDictionaryExWordsPackResNameGetter
 
 TkwPopDictionaryExFileName = class(TtfwClassLike)
  {* Слово скрипта pop:DictionaryEx:FileName
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aDictionaryEx pop:DictionaryEx:FileName >>> l_Il3CString
[code]  }
  function FileName(const aCtx: TtfwContext;
   aDictionaryEx: TtfwDictionaryEx): Il3CString;
   {* Реализация слова скрипта pop:DictionaryEx:FileName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopDictionaryExFileName
 
 TkwPopDictionaryExUsedDictionaries = class(TtfwClassLike)
  {* Слово скрипта pop:DictionaryEx:UsedDictionaries
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aDictionaryEx pop:DictionaryEx:UsedDictionaries >>> l_ItfwValueList
[code]  }
  function UsedDictionaries(const aCtx: TtfwContext;
   aDictionaryEx: TtfwDictionaryEx): ItfwValueList;
   {* Реализация слова скрипта pop:DictionaryEx:UsedDictionaries }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopDictionaryExUsedDictionaries
 
 TkwPopDictionaryExExportedDictionaries = class(TtfwClassLike)
  {* Слово скрипта pop:DictionaryEx:ExportedDictionaries
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aDictionaryEx pop:DictionaryEx:ExportedDictionaries >>> l_ItfwValueList
[code]  }
  function ExportedDictionaries(const aCtx: TtfwContext;
   aDictionaryEx: TtfwDictionaryEx): ItfwValueList;
   {* Реализация слова скрипта pop:DictionaryEx:ExportedDictionaries }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopDictionaryExExportedDictionaries
 
 TkwPopDictionaryExExportDictionary = class(TtfwClassLike)
  {* Слово скрипта pop:DictionaryEx:ExportDictionary
*Пример:*
[code]
 aDictionary aDictionaryEx pop:DictionaryEx:ExportDictionary
[code]  }
  procedure ExportDictionary(const aCtx: TtfwContext;
   aDictionaryEx: TtfwDictionaryEx;
   aDictionary: TtfwDictionaryEx);
   {* Реализация слова скрипта pop:DictionaryEx:ExportDictionary }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopDictionaryExExportDictionary
 
 TkwPopDictionaryExUseDictionary = class(TtfwClassLike)
  {* Слово скрипта pop:DictionaryEx:UseDictionary
*Пример:*
[code]
 aDictionary aDictionaryEx pop:DictionaryEx:UseDictionary
[code]  }
  procedure UseDictionary(const aCtx: TtfwContext;
   aDictionaryEx: TtfwDictionaryEx;
   aDictionary: TtfwDictionaryEx);
   {* Реализация слова скрипта pop:DictionaryEx:UseDictionary }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopDictionaryExUseDictionary
 
 TkwPopDictionaryExFileDateTime = class(TtfwClassLike)
  {* Слово скрипта pop:DictionaryEx:FileDateTime
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aDictionaryEx pop:DictionaryEx:FileDateTime >>> l_String
[code]  }
  function FileDateTime(const aCtx: TtfwContext;
   aDictionaryEx: TtfwDictionaryEx): AnsiString;
   {* Реализация слова скрипта pop:DictionaryEx:FileDateTime }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopDictionaryExFileDateTime
 
 TkwPopDictionaryExRemoveFromCache = class(TtfwClassLike)
  {* Слово скрипта pop:DictionaryEx:RemoveFromCache
[panel]Удаляет словарь из кешей скомпилированных словарей[panel]
*Пример:*
[code]
 aDictionaryEx pop:DictionaryEx:RemoveFromCache
[code]  }
  procedure RemoveFromCache(const aCtx: TtfwContext;
   aDictionaryEx: TtfwDictionaryEx);
   {* Реализация слова скрипта pop:DictionaryEx:RemoveFromCache }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopDictionaryExRemoveFromCache
 
end.
