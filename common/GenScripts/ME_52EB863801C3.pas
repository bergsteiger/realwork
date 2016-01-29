unit tfwIteratorFromFunctor;

interface

uses
 l3IntfUses
 , tfwIteratableParent
 , tfwScriptingInterfaces
 , tfwArray
;

type
 TtfwArrayCollector = class(TtfwWord)
  procedure Create(anArray: TtfwArray);
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TtfwArrayCollector
 
 TtfwIteratorFromFunctor = class(TtfwIteratableParent, ItfwValueList)
  procedure Create(aFunctor: TtfwWord);
  function Make(aFunctor: TtfwWord): ItfwValueList;
  procedure ForEach(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
  procedure ForEachBack(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
  procedure SetItem(anIndex: Integer;
   const aValue: TtfwStackValue);
  function ItemsCountInSlice: Integer;
 end;//TtfwIteratorFromFunctor
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
