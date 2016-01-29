unit tfwMembersIterator;

interface

uses
 l3IntfUses
 , tfwMembersIteratorPrim
 , tfwScriptingInterfaces
 , tfwDictionaryPrim
;

type
 TtfwMembersIterator = class(TtfwMembersIteratorPrim, ItfwValueList)
  function Make(aDictionary: TtfwDictionaryPrim): ItfwValueList;
  procedure ForEach(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
  procedure ForEachBack(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
  procedure SetItem(anIndex: Integer;
   const aValue: TtfwStackValue);
  function ItemsCountInSlice: Integer;
 end;//TtfwMembersIterator
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
