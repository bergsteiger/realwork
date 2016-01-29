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
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TtfwDictionaryExWordsPackResNameGetter
 
 TkwPopDictionaryExFileName = class(TtfwClassLike)
  {* ����� ������� pop:DictionaryEx:FileName
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aDictionaryEx pop:DictionaryEx:FileName >>> l_Il3CString
[code]  }
  function FileName(const aCtx: TtfwContext;
   aDictionaryEx: TtfwDictionaryEx): Il3CString;
   {* ���������� ����� ������� pop:DictionaryEx:FileName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopDictionaryExFileName
 
 TkwPopDictionaryExUsedDictionaries = class(TtfwClassLike)
  {* ����� ������� pop:DictionaryEx:UsedDictionaries
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 aDictionaryEx pop:DictionaryEx:UsedDictionaries >>> l_ItfwValueList
[code]  }
  function UsedDictionaries(const aCtx: TtfwContext;
   aDictionaryEx: TtfwDictionaryEx): ItfwValueList;
   {* ���������� ����� ������� pop:DictionaryEx:UsedDictionaries }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopDictionaryExUsedDictionaries
 
 TkwPopDictionaryExExportedDictionaries = class(TtfwClassLike)
  {* ����� ������� pop:DictionaryEx:ExportedDictionaries
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 aDictionaryEx pop:DictionaryEx:ExportedDictionaries >>> l_ItfwValueList
[code]  }
  function ExportedDictionaries(const aCtx: TtfwContext;
   aDictionaryEx: TtfwDictionaryEx): ItfwValueList;
   {* ���������� ����� ������� pop:DictionaryEx:ExportedDictionaries }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopDictionaryExExportedDictionaries
 
 TkwPopDictionaryExExportDictionary = class(TtfwClassLike)
  {* ����� ������� pop:DictionaryEx:ExportDictionary
*������:*
[code]
 aDictionary aDictionaryEx pop:DictionaryEx:ExportDictionary
[code]  }
  procedure ExportDictionary(const aCtx: TtfwContext;
   aDictionaryEx: TtfwDictionaryEx;
   aDictionary: TtfwDictionaryEx);
   {* ���������� ����� ������� pop:DictionaryEx:ExportDictionary }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopDictionaryExExportDictionary
 
 TkwPopDictionaryExUseDictionary = class(TtfwClassLike)
  {* ����� ������� pop:DictionaryEx:UseDictionary
*������:*
[code]
 aDictionary aDictionaryEx pop:DictionaryEx:UseDictionary
[code]  }
  procedure UseDictionary(const aCtx: TtfwContext;
   aDictionaryEx: TtfwDictionaryEx;
   aDictionary: TtfwDictionaryEx);
   {* ���������� ����� ������� pop:DictionaryEx:UseDictionary }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopDictionaryExUseDictionary
 
 TkwPopDictionaryExFileDateTime = class(TtfwClassLike)
  {* ����� ������� pop:DictionaryEx:FileDateTime
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aDictionaryEx pop:DictionaryEx:FileDateTime >>> l_String
[code]  }
  function FileDateTime(const aCtx: TtfwContext;
   aDictionaryEx: TtfwDictionaryEx): AnsiString;
   {* ���������� ����� ������� pop:DictionaryEx:FileDateTime }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopDictionaryExFileDateTime
 
 TkwPopDictionaryExRemoveFromCache = class(TtfwClassLike)
  {* ����� ������� pop:DictionaryEx:RemoveFromCache
[panel]������� ������� �� ����� ���������������� ��������[panel]
*������:*
[code]
 aDictionaryEx pop:DictionaryEx:RemoveFromCache
[code]  }
  procedure RemoveFromCache(const aCtx: TtfwContext;
   aDictionaryEx: TtfwDictionaryEx);
   {* ���������� ����� ������� pop:DictionaryEx:RemoveFromCache }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopDictionaryExRemoveFromCache
 
end.
