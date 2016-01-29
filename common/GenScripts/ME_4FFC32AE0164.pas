unit vcmFormSetFormsCollectionItem;

interface

uses
 l3IntfUses
 , vcmFormSetFormsCollectionItemPrim
 , vcmInterfaces
 , vcmFormSetFormsCollectionPrimPrim
;

type
 TvcmFormSetFormsCollectionItem = class(TvcmFormSetFormsCollectionItemPrim)
  function MakeZoneType: TvcmZoneType;
   {* в случае если у формы указана зона vcm_ztModal, меняем ее на
vcm_ztManualModal, т.к. главную форму можно показывать только после
создания всех дочерних форм. }
  function IsSame(const aForm: IvcmEntityForm): Boolean;
  procedure CheckChilds;
 end;//TvcmFormSetFormsCollectionItem
 
implementation

uses
 l3ImplUses
 , SysUtils
 , Classes
 , vcmBase
 , vcmEntityForm
 , vcmFormSetFormsCollection
 , vcmBaseTypes
;

end.
