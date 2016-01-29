unit vcmUserTypeDescr;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
;

type
 TvcmUserTypeDescr = object
 end;//TvcmUserTypeDescr
 
 TvcmUserTypeDescrList = class(Tl3ProtoDataContainer)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TvcmUserTypeDescrList
 
implementation

uses
 l3ImplUses
 , vcmInterfaces
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
