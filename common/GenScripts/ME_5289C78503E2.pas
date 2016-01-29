unit vcmFormSetFormItemList;

interface

uses
 l3IntfUses
 , vcmBaseTypes
 , vcmUserControls
 , l3ProtoDataContainer
;

type
 TvcmFormSetFormItemDescr = object
 end;//TvcmFormSetFormItemDescr
 
 TvcmFormSetFormItem = object
 end;//TvcmFormSetFormItem
 
 TvcmFormSetFormList = class(Tl3ProtoDataContainer)
  function GetFormIndex(const aFormDescr: TvcmFormSetFormItemDescr): Integer;
  procedure SetIfNeedMakeNo(const aForm: TvcmFormSetFormItemDescr;
   aValue: TvcmNeedMakeDS);
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TvcmFormSetFormList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
