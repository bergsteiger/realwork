unit vcmTinyUseCaseController.imp;

interface

uses
 l3IntfUses
;

type
 _vcmTinyUseCaseController_ = class(_vcmFormSetDataSourceWithoutData_)
  {*  онтролер прецедента без вс€ких данных }
  procedure Create;
  function Make: _SetType_;
 end;//_vcmTinyUseCaseController_
 
implementation

uses
 l3ImplUses
 , vcmLocalInterfaces
 , l3Base
 , SysUtils
;

end.
