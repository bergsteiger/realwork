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
  {* ����� ������� pop:Dictionary:WordsIterator
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 aDictionary pop:Dictionary:WordsIterator >>> l_ItfwValueList
[code]  }
  function WordsIterator(const aCtx: TtfwContext;
   aDictionary: TtfwDictionary): ItfwValueList;
   {* ���������� ����� ������� pop:Dictionary:WordsIterator }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopDictionaryWordsIterator
 
 TkwPopDictionaryKeywordByName = class(TtfwClassLike)
  {* ����� ������� pop:Dictionary:KeywordByName
*��� ����������:* TtfwKeyWord
*������:*
[code]
OBJECT VAR l_TtfwKeyWord
 aName aDictionary pop:Dictionary:KeywordByName >>> l_TtfwKeyWord
[code]  }
  function KeywordByName(const aCtx: TtfwContext;
   aDictionary: TtfwDictionary;
   const aName: Il3CString): TtfwKeyWord;
   {* ���������� ����� ������� pop:Dictionary:KeywordByName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopDictionaryKeywordByName
 
 TkwPopDictionaryKeyWordsIterator = class(TtfwClassLike)
  {* ����� ������� pop:Dictionary:KeyWordsIterator
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 aDictionary pop:Dictionary:KeyWordsIterator >>> l_ItfwValueList
[code]  }
  function KeyWordsIterator(const aCtx: TtfwContext;
   aDictionary: TtfwDictionary): ItfwValueList;
   {* ���������� ����� ������� pop:Dictionary:KeyWordsIterator }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopDictionaryKeyWordsIterator
 
 TkwPopDictionaryOwnKeywordByName = class(TtfwClassLike)
  {* ����� ������� pop:Dictionary:OwnKeywordByName
*��� ����������:* TtfwKeyWord
*������:*
[code]
OBJECT VAR l_TtfwKeyWord
 aName aDictionary pop:Dictionary:OwnKeywordByName >>> l_TtfwKeyWord
[code]  }
  function OwnKeywordByName(const aCtx: TtfwContext;
   aDictionary: TtfwDictionary;
   const aName: Il3CString): TtfwKeyWord;
   {* ���������� ����� ������� pop:Dictionary:OwnKeywordByName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopDictionaryOwnKeywordByName
 
end.
