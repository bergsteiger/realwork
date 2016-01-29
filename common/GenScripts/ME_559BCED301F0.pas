unit ItfwKeywordFinderWordsPack;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
 , l3Interfaces
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
 TkwPopKeywordFinderKeywordByName = class(TtfwClassLike)
  {* Слово скрипта pop:KeywordFinder:KeywordByName
*Тип результата:* TtfwKeyWord
*Пример:*
[code]
OBJECT VAR l_TtfwKeyWord
 aName aKeywordFinder pop:KeywordFinder:KeywordByName >>> l_TtfwKeyWord
[code]  }
  function KeywordByName(const aCtx: TtfwContext;
   aKeywordFinder: TtfwKeywordFinder;
   const aName: Il3CString): TtfwKeyWord;
   {* Реализация слова скрипта pop:KeywordFinder:KeywordByName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopKeywordFinderKeywordByName
 
 TkwPopKeywordFinderParentFinder = class(TtfwPropertyLike)
  {* Слово скрипта pop:KeywordFinder:ParentFinder
*Тип результата:* TtfwKeywordFinder
*Пример:*
[code]
OBJECT VAR l_TtfwKeywordFinder
 aKeywordFinder pop:KeywordFinder:ParentFinder >>> l_TtfwKeywordFinder
[code]  }
  function ParentFinder(const aCtx: TtfwContext;
   aKeywordFinder: TtfwKeywordFinder): TtfwKeywordFinder;
   {* Реализация слова скрипта pop:KeywordFinder:ParentFinder }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopKeywordFinderParentFinder
 
end.
