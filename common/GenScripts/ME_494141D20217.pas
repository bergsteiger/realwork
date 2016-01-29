unit vcmFormSetDataSource;

interface

uses
 l3IntfUses
 , vcmInterfaces
;

type
 TvcmFormSetDataSource = class(_vcmTinyUseCaseController_)
  {* Временная реализация абстрактного прецедента для TvcmFormSetFactory.MakeFormSet }
 end;//TvcmFormSetDataSource
 
implementation

uses
 l3ImplUses
 , vcmLocalInterfaces
 , l3Base
 , SysUtils
;

end.
