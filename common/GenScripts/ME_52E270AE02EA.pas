unit tfwArrayView;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , tfwScriptingInterfaces
 , l3PureMixIns
;

type
 TtfwArrayView = class(Tl3ProtoObject, ItfwValueList)
  procedure Create(const anOther: ItfwValueList);
  function Make(const anOther: ItfwValueList): ItfwValueList;
  procedure DoForEachBack(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
  procedure DoForEach(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
  function GetItemsCountInSlice: Integer;
  function First: _ItemType_;
   {* Первый элемент. }
  function Last: _ItemType_;
   {* Последний элемент. }
  function Items: _ItemType_;
  function Empty: Boolean;
  function IndexOf(const anItem: _ItemType_): Integer;
  function Add(const anItem: _ItemType_): Integer;
  function Count: Integer;
   {* Число элементов. }
  procedure Clear;
  procedure ForEach(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
  procedure ForEachBack(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
  procedure SetItem(anIndex: Integer;
   const aValue: TtfwStackValue);
  function ItemsCountInSlice: Integer;
 end;//TtfwArrayView
 
implementation

uses
 l3ImplUses
;

end.
