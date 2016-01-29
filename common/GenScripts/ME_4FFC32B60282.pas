unit vcmFormSetFormsCollection;

interface

uses
 l3IntfUses
 , vcmFormSetFormsCollectionPrim
 , vcmFormSetFormsCollectionItemPrim
 , vcmInterfaces
;

type
 TvcmFormSetFormsCollection = class(TvcmFormSetFormsCollectionPrim)
  function FindItemByForm(const aForm: IvcmEntityForm): TvcmFormSetFormsCollectionItemPrim;
   {* ищет элемент коллекции соответствующий форме. }
 end;//TvcmFormSetFormsCollection
 
implementation

uses
 l3ImplUses
 , vcmFormSetFormsCollectionItem
;

end.
