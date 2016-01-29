unit tfwDictionaryListIteratorPrim.imp;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
;

type
 // _ListType_
 
 _tfwDictionaryListIteratorPrim_ = class(ItfwValueList, MtfwIteratableParent)
  function ListToIterate: _ListType_;
  procedure ForEach(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
  procedure ForEachBack(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
  procedure SetItem(anIndex: Integer;
   const aValue: TtfwStackValue);
  function ItemsCountInSlice: Integer;
 end;//_tfwDictionaryListIteratorPrim_
 
implementation

uses
 l3ImplUses
 , tfwDictionary
;

end.
