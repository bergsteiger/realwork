unit nevRootFormatInfoListPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevRootFormatInfo
 , nevBase
;

type
 TnevRootFormatInfoListPrim = class(_l3UncomparabeObjectRefList_)
  function CompareViews(const A: InevViewMetrics;
   const B: InevViewMetrics): Integer;
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TnevRootFormatInfoListPrim
 
implementation

uses
 l3ImplUses
 , evdStyles
 , evdTypes
 , m2MemLib
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
