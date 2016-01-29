unit tfwStoredValuesStack;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , tfwScriptingInterfaces
 , tfwDictionaryPrim
;

type
 TtfwStoredValuesStack = class(_l3InterfaceRefListPrim_, ItfwStoredValuesStack)
  procedure Create;
  function Make: ItfwStoredValuesStack;
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
  function Count: Integer;
   {* Число элементов. }
  procedure Restore(const aCtx: TtfwContext);
  procedure StoreDictionary(aDictionary: TtfwDictionaryPrim;
   const aCtx: TtfwContext);
 end;//TtfwStoredValuesStack
 
implementation

uses
 l3ImplUses
 , tfwStoredValues
 , tfwArray
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
