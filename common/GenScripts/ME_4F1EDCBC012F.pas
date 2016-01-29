unit vcmFormGUIDFromMainFormList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmInterfaces
 , vcmMainForm
;

type
 TvcmFormGUIDFromMainFormRec = object
 end;//TvcmFormGUIDFromMainFormRec
 
 TvcmFormGUIDFromMainFormList = class(Tl3ProtoDataContainer)
  procedure CreateFormGUID(const aForm: IvcmEntityForm;
   var theGUID: TGUID);
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TvcmFormGUIDFromMainFormList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
