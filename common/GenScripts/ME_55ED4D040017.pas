unit tfwWordsIterator;

interface

uses
 l3IntfUses
 , tfwIteratableParent
 , tfwScriptingInterfaces
 , tfwWordRefList
;

type
 TtfwWordsIterator = class(TtfwIteratableParent, ItfwValueList)
  procedure Create(aWords: TtfwWordRefList);
  function Make(aWords: TtfwWordRefList): ItfwValueList;
  procedure ForEach(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
  procedure ForEachBack(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
  procedure SetItem(anIndex: Integer;
   const aValue: TtfwStackValue);
  function ItemsCountInSlice: Integer;
 end;//TtfwWordsIterator
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
