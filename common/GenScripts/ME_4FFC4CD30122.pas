unit vcmFormSetFormsCollectionPrim;

interface

uses
 l3IntfUses
 , vcmFormSetFormsCollectionPrimPrim
 , vcmFormSetFormItemList
 , vcmFormSetFormsCollectionItemModelPart
 , vcmInterfaces
 , vcmBaseTypes
 , vcmUserControls
;

type
 TvcmFormSetFormsCollectionPrim = class(TvcmFormSetFormsCollectionPrimPrim)
  function AddZone(const aName: AnsiString;
   aZoneType: TvcmZoneType;
   const aFormDescriptor: TvcmFormDescriptor): TvcmFormSetFormsCollectionItemModelPart; overload;
  function AddZone(const aName: AnsiString;
   aZoneType: TvcmZoneType;
   const aFormDescriptor: TvcmFormDescriptor;
   aUserType: TvcmUserType;
   aNeedMakeDS: TvcmNeedMakeDS): TvcmFormSetFormsCollectionItemModelPart; overload;
 end;//TvcmFormSetFormsCollectionPrim
 
implementation

uses
 l3ImplUses
 , vcmFormSetFormsCollectionItem
 , SysUtils
 , vcmControllers
;

end.
