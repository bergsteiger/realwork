unit tfwKeywordsIterator;

interface

uses
 l3IntfUses
 , tfwMembersIteratorPrim
 , tfwScriptingInterfaces
 , tfwDictionaryPrim
;

type
 TtfwKeywordsIterator = class(TtfwMembersIteratorPrim, ItfwValueList)
  function Make(aDictionary: TtfwDictionaryPrim): ItfwValueList;
  procedure ForEach(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
  procedure ForEachBack(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
  procedure SetItem(anIndex: Integer;
   const aValue: TtfwStackValue);
  function ItemsCountInSlice: Integer;
 end;//TtfwKeywordsIterator
 
implementation

uses
 l3ImplUses
;

end.
