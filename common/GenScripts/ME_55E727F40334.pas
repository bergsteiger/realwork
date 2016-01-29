unit tfwDictionaryWordsPack;

interface

uses
 l3IntfUses
 , tfwDictionary
 , tfwScriptingInterfaces
 , l3Interfaces
 , tfwClassLike
 , TypInfo
;

implementation

uses
 l3ImplUses
 , tfwMembersIterator
 , tfwScriptEngineExInterfaces
 , tfwKeywordsIterator
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopDictionaryWordsIterator = class(TtfwClassLike)
  {* Слово скрипта pop:Dictionary:WordsIterator
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aDictionary pop:Dictionary:WordsIterator >>> l_ItfwValueList
[code]  }
  function WordsIterator(const aCtx: TtfwContext;
   aDictionary: TtfwDictionary): ItfwValueList;
   {* Реализация слова скрипта pop:Dictionary:WordsIterator }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopDictionaryWordsIterator
 
 TkwPopDictionaryKeywordByName = class(TtfwClassLike)
  {* Слово скрипта pop:Dictionary:KeywordByName
*Тип результата:* TtfwKeyWord
*Пример:*
[code]
OBJECT VAR l_TtfwKeyWord
 aName aDictionary pop:Dictionary:KeywordByName >>> l_TtfwKeyWord
[code]  }
  function KeywordByName(const aCtx: TtfwContext;
   aDictionary: TtfwDictionary;
   const aName: Il3CString): TtfwKeyWord;
   {* Реализация слова скрипта pop:Dictionary:KeywordByName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopDictionaryKeywordByName
 
 TkwPopDictionaryKeyWordsIterator = class(TtfwClassLike)
  {* Слово скрипта pop:Dictionary:KeyWordsIterator
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aDictionary pop:Dictionary:KeyWordsIterator >>> l_ItfwValueList
[code]  }
  function KeyWordsIterator(const aCtx: TtfwContext;
   aDictionary: TtfwDictionary): ItfwValueList;
   {* Реализация слова скрипта pop:Dictionary:KeyWordsIterator }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopDictionaryKeyWordsIterator
 
 TkwPopDictionaryOwnKeywordByName = class(TtfwClassLike)
  {* Слово скрипта pop:Dictionary:OwnKeywordByName
*Тип результата:* TtfwKeyWord
*Пример:*
[code]
OBJECT VAR l_TtfwKeyWord
 aName aDictionary pop:Dictionary:OwnKeywordByName >>> l_TtfwKeyWord
[code]  }
  function OwnKeywordByName(const aCtx: TtfwContext;
   aDictionary: TtfwDictionary;
   const aName: Il3CString): TtfwKeyWord;
   {* Реализация слова скрипта pop:Dictionary:OwnKeywordByName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopDictionaryOwnKeywordByName
 
end.
