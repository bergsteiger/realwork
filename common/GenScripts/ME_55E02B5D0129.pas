unit tfwJoinIterator;

interface

uses
 l3IntfUses
 , tfwIteratableParent
 , tfwScriptingInterfaces
;

type
 TtfwJoinIterator = class(TtfwIteratableParent, ItfwValueList)
  procedure Create(const aLeft: ItfwValueList;
   const aRight: ItfwValueList);
  function Make(const aLeft: ItfwValueList;
   const aRight: ItfwValueList): ItfwValueList;
  procedure ForEach(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
  procedure ForEachBack(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
  procedure SetItem(anIndex: Integer;
   const aValue: TtfwStackValue);
  function ItemsCountInSlice: Integer;
 end;//TtfwJoinIterator
 
implementation

uses
 l3ImplUses
;

end.
