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
  {* ����� ������� pop:KeywordFinder:KeywordByName
*��� ����������:* TtfwKeyWord
*������:*
[code]
OBJECT VAR l_TtfwKeyWord
 aName aKeywordFinder pop:KeywordFinder:KeywordByName >>> l_TtfwKeyWord
[code]  }
  function KeywordByName(const aCtx: TtfwContext;
   aKeywordFinder: TtfwKeywordFinder;
   const aName: Il3CString): TtfwKeyWord;
   {* ���������� ����� ������� pop:KeywordFinder:KeywordByName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopKeywordFinderKeywordByName
 
 TkwPopKeywordFinderParentFinder = class(TtfwPropertyLike)
  {* ����� ������� pop:KeywordFinder:ParentFinder
*��� ����������:* TtfwKeywordFinder
*������:*
[code]
OBJECT VAR l_TtfwKeywordFinder
 aKeywordFinder pop:KeywordFinder:ParentFinder >>> l_TtfwKeywordFinder
[code]  }
  function ParentFinder(const aCtx: TtfwContext;
   aKeywordFinder: TtfwKeywordFinder): TtfwKeywordFinder;
   {* ���������� ����� ������� pop:KeywordFinder:ParentFinder }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopKeywordFinderParentFinder
 
end.
