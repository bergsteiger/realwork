unit daDataProviderFactoryList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , daDataProviderFactory
;

type
 TdaDataProviderFactoryList = class(Tl3ProtoDataContainer)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TdaDataProviderFactoryList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
