unit vcmFormSetFormsCollectionItemPrim;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , vcmInterfaces
 , l3Interfaces
 , vcmUserControls
;

type
 TvcmNeedMakeFormEvent = function(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean of object;
  {* данные необходимые для создания формы }
 
 TvcmOnFormWeight = function(out aWeight: Integer): Boolean of object;
  {* определить вес для формы }
 
 TvcmFormCountEvent = procedure(const aDataSource: IvcmFormSetDataSource;
  out aCount: Integer) of object;
  {* количество форм которое необходимо создать }
 
 TvcmFormSetFormsCollectionItemPrim = class(Tl3ProtoObject)
 end;//TvcmFormSetFormsCollectionItemPrim
 
implementation

uses
 l3ImplUses
;

end.
