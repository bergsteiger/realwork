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
   {* � ������ ���� � ����� ������� ���� vcm_ztModal, ������ �� ��
vcm_ztManualModal, �.�. ������� ����� ����� ���������� ������ �����
�������� ���� �������� ����. }
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
