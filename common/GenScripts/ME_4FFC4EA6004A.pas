unit vcmFormSetFormsCollectionItemModelPart;

interface

uses
 l3IntfUses
 , vcmFormSetFormsCollectionItem
 , vcmFormSetFormItemList
 , vcmInterfaces
 , vcmBaseTypes
 , vcmUserControls
;

type
 TvcmFormSetFormsCollectionItemModelPart = class(TvcmFormSetFormsCollectionItem)
  function AddZone(const aName: AnsiString;
   aZoneType: TvcmZoneType;
   const aFormDescriptor: TvcmFormDescriptor): TvcmFormSetFormsCollectionItemModelPart; overload;
  function AddZone(const aName: AnsiString;
   aZoneType: TvcmZoneType;
   const aFormDescriptor: TvcmFormDescriptor;
   aUserType: TvcmUserType;
   aNeedMakeDS: TvcmNeedMakeDS): TvcmFormSetFormsCollectionItemModelPart; overload;
 end;//TvcmFormSetFormsCollectionItemModelPart
 
implementation

uses
 l3ImplUses
 , vcmFormSetFormsCollectionPrim
;

end.
